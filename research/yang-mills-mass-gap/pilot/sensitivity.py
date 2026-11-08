"""Experiment 2: how much a coarse spin's conditional distribution depends on
other coarse spins, across block scales, in 2D O(2) and O(3).

Coarse spins: decimation, every b-th site in both directions (b = 1, 2, 4).
For a coarse site i and a boundary eta (all other coarse spins), the
conditional distribution mu_i(.|eta) has the fine spins integrated out. It is
sampled by freezing all other coarse spins and running Metropolis plus
overrelaxation on everything else.

Influence proxy. Flip one other coarse spin j (s_j -> -s_j) to get eta'. For
the fixed unit vector u = s_j (its original direction),

    delta_ij = ( E[s_i.u | eta] - E[s_i.u | eta'] ) / 2   <=   d_TV(mu_i(.|eta), mu_i(.|eta')),

since |s_i.u| <= 1. Averaged over boundaries, delta is an unbiased estimate of
a lower bound on the average total-variation influence. It is not the
supremum that Dobrushin's condition uses, so a value below 1 proves nothing.

Boundaries: 'typical' (from the equilibrium chain) and 'random' (all coarse
spins replaced by independent uniform directions; fine spins then
re-equilibrated).

Benchmark at b = 1: the conditional of one spin given its neighbours is exactly
p(s) ~ exp(beta s.h), with mean A(beta |h|) h/|h|, where A(x) = coth x - 1/x
for O(3) and I1(x)/I0(x) for O(2). The exact delta and the exact TV distance
are computed alongside the estimate.

Usage: python sensitivity.py [--quick]
"""

import json
import sys
import time

import numpy as np
from numba import njit
from scipy.special import i0, i1

sys.path.insert(0, ".")
from pilot import init, seed, sweep, wolff  # noqa: E402

L = 32
CLASSES = {
    "nn": [(1, 0), (-1, 0), (0, 1), (0, -1)],
    "diag": [(1, 1), (1, -1), (-1, 1), (-1, -1)],
    "dist2": [(2, 0), (-2, 0), (0, 2), (0, -2)],
}


@njit(cache=True)
def cond_mean(s, beta, frozen, ii, jj, nburn, nmeas, eps):
    for _ in range(nburn):
        sweep(s, beta, frozen, eps)
    m = np.zeros(s.shape[2])
    for _ in range(nmeas):
        sweep(s, beta, frozen, eps)
        m += s[ii, jj]
    return m / nmeas


@njit(cache=True)
def randomize_coarse(s, b):
    L = s.shape[0]
    n = s.shape[2]
    for i in range(0, L, b):
        for j in range(0, L, b):
            v = np.random.normal(0.0, 1.0, n)
            s[i, j] = v / np.sqrt(np.sum(v * v))


def A(n, x):
    if x < 1e-8:
        return 0.0
    if n == 3:
        return 1.0 / np.tanh(x) - 1.0 / x
    return float(i1(x) / i0(x))


def exact_mean(n, beta, h):
    nh = np.linalg.norm(h)
    return A(n, beta * nh) * h / nh if nh > 1e-12 else np.zeros(n)


def sphere_grid(n, k):
    if n == 2:
        t = 2 * np.pi * (np.arange(k) + 0.5) / k
        return np.column_stack([np.cos(t), np.sin(t)])
    idx = np.arange(k) + 0.5
    phi = np.arccos(1 - 2 * idx / k)
    th = np.pi * (1 + 5 ** 0.5) * idx
    return np.column_stack([np.cos(th) * np.sin(phi), np.sin(th) * np.sin(phi), np.cos(phi)])


def exact_tv(n, beta, h1, h2, grid):
    w1 = np.exp(beta * grid @ h1 - beta * np.linalg.norm(h1))
    w2 = np.exp(beta * grid @ h2 - beta * np.linalg.norm(h2))
    return 0.5 * np.abs(w1 / w1.sum() - w2 / w2.sum()).sum()


def run(n, beta, b, boundary, n_outer, n_sites, nburn, nmeas, rng_seed):
    seed(rng_seed)
    s = init(L, n)
    for _ in range(2000):
        wolff(s, beta)
    eps = 0.8 if beta < 1.0 else 0.5
    coarse = np.zeros((L, L), dtype=np.bool_)
    coarse[::b, ::b] = True
    grid = sphere_grid(n, 4000 if n == 2 else 40000)
    rng = np.random.default_rng(rng_seed)
    est = {c: [] for c in CLASSES}
    exa = {c: [] for c in CLASSES}
    tv = {c: [] for c in CLASSES}
    for _ in range(n_outer):
        for _ in range(50):
            wolff(s, beta)
        base = s.copy()
        if boundary == "random":
            randomize_coarse(base, b)
        nc = L // b
        for _ in range(n_sites):
            ci, cj = rng.integers(nc), rng.integers(nc)
            ii, jj = ci * b, cj * b
            frozen = coarse.copy()
            frozen[ii, jj] = False
            work = base.copy()
            m0 = cond_mean(work, beta, frozen, ii, jj, nburn, nmeas, eps)
            for cname, offs in CLASSES.items():
                vals, evals, tvals = [], [], []
                for di, dj in offs:
                    pi, pj = ((ci + di) % nc) * b, ((cj + dj) % nc) * b
                    u = base[pi, pj].copy()
                    pert = base.copy()
                    pert[pi, pj] = -u
                    m1 = cond_mean(pert, beta, frozen, ii, jj, nburn, nmeas, eps)
                    vals.append(0.5 * np.dot(m0 - m1, u))
                    if b == 1:
                        h = (base[(ii + 1) % L, jj] + base[(ii - 1) % L, jj]
                             + base[ii, (jj + 1) % L] + base[ii, (jj - 1) % L])
                        h2 = h - 2 * u if cname == "nn" else h
                        evals.append(0.5 * np.dot(exact_mean(n, beta, h) - exact_mean(n, beta, h2), u))
                        tvals.append(exact_tv(n, beta, h, h2, grid))
                est[cname].append(np.mean(vals))
                if b == 1:
                    exa[cname].append(np.mean(evals))
                    tv[cname].append(np.mean(tvals))
    out = {}
    for c in CLASSES:
        a = np.array(est[c])
        out[c] = {"delta": float(a.mean()), "err": float(a.std(ddof=1) / np.sqrt(len(a)))}
        if b == 1:
            out[c]["exact_delta"] = float(np.mean(exa[c]))
            out[c]["exact_tv"] = float(np.mean(tv[c]))
    out["sum"] = 4 * sum(out[c]["delta"] for c in CLASSES)
    out["sum_err"] = 4 * float(np.sqrt(sum(out[c]["err"] ** 2 for c in CLASSES)))
    return out


def main():
    quick = "--quick" in sys.argv
    confirm = [a for a in sys.argv if a.startswith("--confirm=")]
    n_outer, n_sites, nburn, nmeas = (4, 2, 100, 300) if quick else (16, 2, 300, 1500)
    configs = [("O(3)", 3, 1.2), ("O(3)", 3, 1.5), ("O(2)", 2, 0.8), ("O(2)", 2, 1.3)]
    boundaries = ("typical", "random")
    tag = "quick" if quick else "full"
    if confirm:
        # targeted confirmation: one model, random boundaries, more statistics
        which = confirm[0].split("=")[1]
        configs = [c for c in configs if f"{c[0]}:{c[2]}" == which]
        boundaries = ("random",)
        n_outer, n_sites, nburn, nmeas = 12, 2, 200, 600
        tag = "confirm_" + which.replace("(", "").replace(")", "").replace(":", "_b")
    res = {"L": L, "n_outer": n_outer, "n_sites": n_sites, "nburn": nburn,
           "nmeas": nmeas, "runs": []}
    for boundary in boundaries:
        for k, (name, n, beta) in enumerate(configs):
            for b in (1, 2, 4):
                t0 = time.time()
                sd = 2000 + 100 * k + 10 * b + (0 if boundary == "typical" else 5) + (7 if confirm else 0)
                out = run(n, beta, b, boundary, n_outer, n_sites, nburn, nmeas, sd)
                dt = time.time() - t0
                line = (f"{name} beta={beta} b={b} {boundary:7s} "
                        + " ".join(f"{c}={out[c]['delta']:.4f}±{out[c]['err']:.4f}" for c in CLASSES)
                        + f"  sum={out['sum']:.3f}±{out['sum_err']:.3f}")
                if b == 1:
                    line += (f"  [exact nn delta={out['nn']['exact_delta']:.4f},"
                             f" exact nn TV={out['nn']['exact_tv']:.4f}]")
                print(line + f"  ({dt:.0f}s)", flush=True)
                res["runs"].append({"model": name, "beta": beta, "block": b,
                                    "boundary": boundary, "seed": sd, **out})
    fn = f"sensitivity_{tag}.json"
    with open(fn, "w") as f:
        json.dump(res, f, indent=1)
    print("wrote", fn)


if __name__ == "__main__":
    main()
