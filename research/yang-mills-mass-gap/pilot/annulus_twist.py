"""Annular twist cost in 2D sigma models (CPN_TWIST.md, numerical companion).

Annulus D_N = {x in Z^2 : N <= ||x||_inf <= 2N}. The outer layer (||x|| = 2N) is pinned to s*,
the inner layer (||x|| = N) to the rotated value s*(t). Only edges with both ends in D_N count.

  o2 :  s in S^1,  E = s.s,          s* = e1, s*(t) = (cos t, sin t)
  o3 :  s in S^2,  E = s.s,          s* = e1, s*(t) = (cos t, sin t, 0)
  cp2:  z in C^3,  E = |conj(z).z'|^2 = tr(P P'),  z* = e1, z*(t) = cos(t/2) e1 + sin(t/2) e2
        (t = pi gives the orthogonal state e2, the antipode in CP^1)

Weight exp(beta * sum E). Measured: g(t) = d/dt log Z(t) = <beta * sum_{inner pinned bonds} dE/dt>.
f(t) = -log(Z(t)/Z(0)) = -int_0^t g (trapezoid), f(pi) by Simpson.
The O(3) proof gives f -> 0 like C/log N; the claim of CPN_TWIST.md is the same for CP^{N-1}.
For O(2) at low temperature a finite cost is expected at fixed radius ratio (spin stiffness).

Usage: python annulus_twist.py o2|o3|cp2 BETA N [NT NTHERM NMEAS [warm]]
  warm: start the free spins on the classical twisted profile (rotation angle falling
        linearly from t at the inner layer to 0 at the outer layer) instead of all at s*.
"""

import json
import math
import sys
import time

import numpy as np
from numba import njit

sys.path.insert(0, ".")
from periodic_b2 import tau_int  # noqa: E402


def geometry(N):
    L = 4 * N + 1
    inside = np.zeros((L, L), dtype=np.bool_)
    kind = np.zeros((L, L), dtype=np.int64)   # 0 free, 1 inner pinned, 2 outer pinned
    for i in range(L):
        for j in range(L):
            d = max(abs(i - 2 * N), abs(j - 2 * N))
            if N <= d <= 2 * N:
                inside[i, j] = True
                kind[i, j] = 1 if d == N else (2 if d == 2 * N else 0)
    return L, inside, kind


# ---------------- O(n) ----------------

@njit(cache=True)
def on_sweep(s, beta, inside, kind, eps):
    L, _, n = s.shape
    h = np.empty(n)
    p = np.empty(n)
    acc = 0
    for i in range(L):
        for j in range(L):
            if not inside[i, j] or kind[i, j] != 0:
                continue
            for k in range(n):
                h[k] = 0.0
            for di, dj in ((1, 0), (-1, 0), (0, 1), (0, -1)):
                a, b = i + di, j + dj
                if 0 <= a < L and 0 <= b < L and inside[a, b]:
                    for k in range(n):
                        h[k] += s[a, b, k]
            nn = 0.0
            for k in range(n):
                p[k] = s[i, j, k] + eps * np.random.normal()
                nn += p[k] * p[k]
            nn = math.sqrt(nn)
            dE = 0.0
            for k in range(n):
                p[k] /= nn
                dE += (p[k] - s[i, j, k]) * h[k]
            if dE >= 0 or np.random.random() < math.exp(beta * dE):
                for k in range(n):
                    s[i, j, k] = p[k]
                acc += 1
            hh = 0.0
            sh = 0.0
            for k in range(n):
                hh += h[k] * h[k]
                sh += s[i, j, k] * h[k]
            if hh > 1e-12:                      # overrelaxation (microcanonical)
                for k in range(n):
                    s[i, j, k] = 2.0 * sh / hh * h[k] - s[i, j, k]
    return acc


@njit(cache=True)
def on_g(s, beta, inside, kind, t):
    L, _, n = s.shape
    g = 0.0
    for i in range(L):
        for j in range(L):
            if not inside[i, j] or kind[i, j] != 1:
                continue
            for di, dj in ((1, 0), (-1, 0), (0, 1), (0, -1)):
                a, b = i + di, j + dj
                if 0 <= a < L and 0 <= b < L and inside[a, b] and kind[a, b] == 0:
                    g += beta * (-math.sin(t) * s[a, b, 0] + math.cos(t) * s[a, b, 1])
    return g


# ---------------- CP^2 ----------------

@njit(cache=True)
def cp_sweep(z, beta, inside, kind, eps, nhit):
    L = z.shape[0]
    acc = 0
    zn = np.empty(3, dtype=np.complex128)
    for i in range(L):
        for j in range(L):
            if not inside[i, j] or kind[i, j] != 0:
                continue
            for _ in range(nhit):
                nn = 0.0
                for k in range(3):
                    zn[k] = z[i, j, k] + eps * (np.random.normal() + 1j * np.random.normal())
                    nn += zn[k].real ** 2 + zn[k].imag ** 2
                nn = math.sqrt(nn)
                for k in range(3):
                    zn[k] /= nn
                dE = 0.0
                for di, dj in ((1, 0), (-1, 0), (0, 1), (0, -1)):
                    a, b = i + di, j + dj
                    if 0 <= a < L and 0 <= b < L and inside[a, b]:
                        o = 0j
                        q = 0j
                        for k in range(3):
                            o += z[i, j, k].conjugate() * z[a, b, k]
                            q += zn[k].conjugate() * z[a, b, k]
                        dE += (q.real ** 2 + q.imag ** 2) - (o.real ** 2 + o.imag ** 2)
                if dE >= 0 or np.random.random() < math.exp(beta * dE):
                    for k in range(3):
                        z[i, j, k] = zn[k]
                    acc += 1
    return acc


@njit(cache=True)
def cp_g(z, beta, inside, kind, t):
    L = z.shape[0]
    c, s_ = math.cos(t / 2), math.sin(t / 2)
    g = 0.0
    for i in range(L):
        for j in range(L):
            if not inside[i, j] or kind[i, j] != 1:
                continue
            for di, dj in ((1, 0), (-1, 0), (0, 1), (0, -1)):
                a, b = i + di, j + dj
                if 0 <= a < L and 0 <= b < L and inside[a, b] and kind[a, b] == 0:
                    A = c * z[a, b, 0] + s_ * z[a, b, 1]
                    dA = 0.5 * (-s_ * z[a, b, 0] + c * z[a, b, 1])
                    g += beta * 2.0 * (A.conjugate() * dA).real
    return g


def main():
    model = sys.argv[1]
    beta = float(sys.argv[2])
    N = int(sys.argv[3])
    nt = int(sys.argv[4]) if len(sys.argv) > 4 else 9
    ntherm = int(sys.argv[5]) if len(sys.argv) > 5 else 1000
    nmeas = int(sys.argv[6]) if len(sys.argv) > 6 else 4000
    warm = len(sys.argv) > 7 and sys.argv[7] == "warm"
    L, inside, kind = geometry(N)
    ts = np.linspace(0, math.pi, nt)
    rng = np.random.default_rng(int(1000 * beta) * 1000 + N)
    out = {"model": model, "beta": beta, "N": N, "ntherm": ntherm, "nmeas": nmeas, "warm": warm, "points": []}
    t0 = time.time()
    for t in ts:
        np.random.seed(int(rng.integers(1 << 30)))
        if model in ("o2", "o3"):
            n = 2 if model == "o2" else 3
            s = np.zeros((L, L, n))
            s[:, :, 0] = 1.0
            for i in range(L):
                for j in range(L):
                    if kind[i, j] == 1:
                        s[i, j, 0], s[i, j, 1] = math.cos(t), math.sin(t)
            sweep = lambda: on_sweep(s, beta, inside, kind, 0.8)  # noqa: E731
            meas = lambda: on_g(s, beta, inside, kind, t)  # noqa: E731
        else:
            z = np.zeros((L, L, 3), dtype=np.complex128)
            z[:, :, 0] = 1.0
            for i in range(L):
                for j in range(L):
                    if kind[i, j] == 1:
                        z[i, j, 0], z[i, j, 1] = math.cos(t / 2), math.sin(t / 2)
                    elif warm and inside[i, j] and kind[i, j] == 0:
                        d = max(abs(i - 2 * N), abs(j - 2 * N))
                        phi = t * (2 * N - d) / N
                        z[i, j, 0], z[i, j, 1] = math.cos(phi / 2), math.sin(phi / 2)
            sweep = lambda: cp_sweep(z, beta, inside, kind, 0.35, 2)  # noqa: E731
            meas = lambda: cp_g(z, beta, inside, kind, t)  # noqa: E731
        for _ in range(ntherm):
            sweep()
        g = np.empty(nmeas)
        for k in range(nmeas):
            sweep()
            g[k] = meas()
        tau = tau_int(g)
        err = float(np.std(g) * math.sqrt(2 * tau / nmeas))
        out["points"].append({"t": float(t), "g": float(g.mean()), "g_err": err, "tau": tau,
                              "halves": [float(g[:nmeas // 2].mean()), float(g[nmeas // 2:].mean())]})
        print(f"{model} beta={beta} N={N} t={t:.3f}: g={g.mean():+.4f} +- {err:.4f} tau={tau:.1f} "
              f"({time.time() - t0:.0f}s)", flush=True)
    gs = np.array([q["g"] for q in out["points"]])
    es = np.array([q["g_err"] for q in out["points"]])
    h = ts[1] - ts[0]
    f, fe = [0.0], [0.0]
    for i in range(1, nt):
        f.append(f[-1] - 0.5 * h * (gs[i - 1] + gs[i]))
        fe.append(math.sqrt(fe[-1] ** 2 + (0.5 * h) ** 2 * (es[i - 1] ** 2 + es[i] ** 2)))
    for q, fv, fev in zip(out["points"], f, fe):
        q["f"], q["f_err"] = fv, fev
    w = np.ones(nt)
    w[1:-1:2] = 4
    w[2:-1:2] = 2
    out["f_pi"] = float(-h / 3 * np.sum(w * gs))
    out["f_pi_err"] = float(h / 3 * math.sqrt(np.sum((w * es) ** 2)))
    print(f"{model} beta={beta} N={N}: f(pi) = {out['f_pi']:.4f} +- {out['f_pi_err']:.4f}; f(t) = "
          + " ".join(f"{v:.3f}" for v in f), flush=True)
    with open(f"annulus_twist_{model}_b{beta}_N{N}{'_warm' if warm else ''}.json", "w") as fh:
        json.dump(out, fh, indent=1)


if __name__ == "__main__":
    main()
