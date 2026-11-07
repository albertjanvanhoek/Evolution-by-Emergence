"""Annular twist cost of O(3) on NON-PLANAR graphs (WORLDSHEET.md, section 7).

Same set-up and measurement as annulus_twist.py (o3): annulus N <= ||x||_inf <= 2N in Z^2,
inner layer pinned to s*(t) = (cos t, sin t, 0), outer layer to s* = e1; weight
exp(beta * sum_e s_x . s_y). g(t) = d/dt log Z(t), f(t) = -log Z(t)/Z(0) by trapezoid.

Extra edges ("handles") join free vertices only:
  planar : none (reproduces annulus_twist.py o3)
  short  : K = rho * (#free) random pairs at sup-distance 2..ELL (local wormholes:
           the graph is no longer planar, but every edge is short)
  long   : K = rho * (#free) random pairs anywhere in the annulus (negative control)

Question: does f(pi/2) still fall with N when the graph is non-planar but local?

Usage (from pilot/): python twist_graph.py MODE BETA N [RHO ELL NT NTHERM NMEAS SEED]
Runs in twist_graph_out/: planar at beta 2.0, 2.3, 2.6; short (rho 0.1, 0.3) and long (rho 0.01, 0.1)
at beta 2.0; all with ell 4, 9 angles, 2000 + 8000 sweeps, seed 1, N = 4, 8, 16, 32 (about 3 minutes at N = 32).
"""
import json
import math
import sys
import time

import numpy as np
from numba import njit

sys.path.insert(0, ".")
from periodic_b2 import tau_int  # noqa: E402


def build(N, mode, rho, ell, seed):
    L = 4 * N + 1
    idx = -np.ones((L, L), dtype=np.int64)
    kind, coords = [], []
    for i in range(L):
        for j in range(L):
            d = max(abs(i - 2 * N), abs(j - 2 * N))
            if N <= d <= 2 * N:
                idx[i, j] = len(kind)
                kind.append(1 if d == N else (2 if d == 2 * N else 0))
                coords.append((i, j))
    kind = np.array(kind, dtype=np.int64)
    coords = np.array(coords)
    edges = set()
    for v, (i, j) in enumerate(coords):
        for di, dj in ((1, 0), (0, 1)):
            a, b = i + di, j + dj
            if 0 <= a < L and 0 <= b < L and idx[a, b] >= 0:
                edges.add((v, int(idx[a, b])))
    free = np.where(kind == 0)[0]
    rng = np.random.default_rng(seed)
    K = int(round(rho * free.size)) if mode != "planar" else 0
    added = 0
    tries = 0
    while added < K and tries < 100 * K + 100:
        tries += 1
        u = int(rng.choice(free))
        if mode == "short":
            i, j = coords[u]
            di, dj = rng.integers(-ell, ell + 1, size=2)
            if max(abs(di), abs(dj)) < 2:
                continue
            a, b = i + di, j + dj
            if not (0 <= a < L and 0 <= b < L) or idx[a, b] < 0 or kind[idx[a, b]] != 0:
                continue
            w = int(idx[a, b])
        else:
            w = int(rng.choice(free))
            if w == u:
                continue
        e = (min(u, w), max(u, w))
        if e in edges:
            continue
        edges.add(e)
        added += 1
    E = np.array(sorted(edges), dtype=np.int64)
    nv = kind.size
    deg = np.zeros(nv, dtype=np.int64)
    for a, b in E:
        deg[a] += 1
        deg[b] += 1
    ptr = np.zeros(nv + 1, dtype=np.int64)
    ptr[1:] = np.cumsum(deg)
    nbr = np.empty(ptr[-1], dtype=np.int64)
    fill = ptr[:-1].copy()
    for a, b in E:
        nbr[fill[a]] = b
        fill[a] += 1
        nbr[fill[b]] = a
        fill[b] += 1
    return kind, ptr, nbr, added


@njit(cache=True)
def sweep(s, beta, kind, ptr, nbr, eps):
    nv, n = s.shape
    h = np.empty(n)
    p = np.empty(n)
    for v in range(nv):
        if kind[v] != 0:
            continue
        for k in range(n):
            h[k] = 0.0
        for q in range(ptr[v], ptr[v + 1]):
            w = nbr[q]
            for k in range(n):
                h[k] += s[w, k]
        nn = 0.0
        for k in range(n):
            p[k] = s[v, k] + eps * np.random.normal()
            nn += p[k] * p[k]
        nn = math.sqrt(nn)
        dE = 0.0
        for k in range(n):
            p[k] /= nn
            dE += (p[k] - s[v, k]) * h[k]
        if dE >= 0 or np.random.random() < math.exp(beta * dE):
            for k in range(n):
                s[v, k] = p[k]
        hh = 0.0
        sh = 0.0
        for k in range(n):
            hh += h[k] * h[k]
            sh += s[v, k] * h[k]
        if hh > 1e-12:
            for k in range(n):
                s[v, k] = 2.0 * sh / hh * h[k] - s[v, k]


@njit(cache=True)
def gmeas(s, beta, kind, ptr, nbr, t):
    g = 0.0
    for v in range(kind.size):
        if kind[v] != 1:
            continue
        for q in range(ptr[v], ptr[v + 1]):
            w = nbr[q]
            if kind[w] == 0:
                g += beta * (-math.sin(t) * s[w, 0] + math.cos(t) * s[w, 1])
    return g


def main():
    mode, beta, N = sys.argv[1], float(sys.argv[2]), int(sys.argv[3])
    a = sys.argv[4:]
    rho = float(a[0]) if len(a) > 0 else 0.1
    ell = int(a[1]) if len(a) > 1 else 4
    nt = int(a[2]) if len(a) > 2 else 9
    ntherm = int(a[3]) if len(a) > 3 else 1000
    nmeas = int(a[4]) if len(a) > 4 else 4000
    seed = int(a[5]) if len(a) > 5 else 1
    kind, ptr, nbr, added = build(N, mode, rho, ell, seed)
    ts = np.linspace(0, math.pi, nt)
    rng = np.random.default_rng(seed * 7919 + N)
    out = {"mode": mode, "beta": beta, "N": N, "rho": rho, "ell": ell, "added_edges": added,
           "n_vertices": int(kind.size), "ntherm": ntherm, "nmeas": nmeas, "seed": seed, "points": []}
    t0 = time.time()
    for t in ts:
        np.random.seed(int(rng.integers(1 << 30)))
        s = np.zeros((kind.size, 3))
        s[:, 0] = 1.0
        s[kind == 1, 0], s[kind == 1, 1] = math.cos(t), math.sin(t)
        for _ in range(ntherm):
            sweep(s, beta, kind, ptr, nbr, 0.8)
        g = np.empty(nmeas)
        for k in range(nmeas):
            sweep(s, beta, kind, ptr, nbr, 0.8)
            g[k] = gmeas(s, beta, kind, ptr, nbr, t)
        tau = tau_int(g)
        err = float(np.std(g) * math.sqrt(2 * tau / nmeas))
        out["points"].append({"t": float(t), "g": float(g.mean()), "g_err": err, "tau": tau})
    gs = np.array([q["g"] for q in out["points"]])
    es = np.array([q["g_err"] for q in out["points"]])
    hstep = ts[1] - ts[0]
    f, fe = [0.0], [0.0]
    for i in range(1, nt):
        f.append(f[-1] - 0.5 * hstep * (gs[i - 1] + gs[i]))
        fe.append(math.sqrt(fe[-1] ** 2 + (0.5 * hstep) ** 2 * (es[i - 1] ** 2 + es[i] ** 2)))
    for q, fv, fev in zip(out["points"], f, fe):
        q["f"], q["f_err"] = fv, fev
    out["seconds"] = time.time() - t0
    mid = (nt - 1) // 2
    print(f"{mode} beta={beta} N={N} added={added}: f(pi/2) = {f[mid]:.3f} +- {fe[mid]:.3f} "
          f"({out['seconds']:.0f}s)", flush=True)
    with open(f"twist_graph_{mode}_b{beta}_N{N}_r{rho}_l{ell}_s{seed}.json", "w") as fh:
        json.dump(out, fh, indent=1)


if __name__ == "__main__":
    main()
