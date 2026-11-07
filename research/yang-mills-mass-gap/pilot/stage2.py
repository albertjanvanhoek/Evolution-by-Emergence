"""Stage 2 (review on PR #144): L = 64, block size 4, O(3) beta=1.5 and
O(2) beta=1.3, random boundaries, influence proxy over 28 coarse neighbours
(Chebyshev distance 1 and 2, plus the four at axis distance 3).

Settings per model:
  seed A          : conditional chains start from the current configuration
  seed B          : independent seed, same method
  seed A, fresh   : every conditional chain (base and perturbed) starts from
                    independently drawn random fine spins, with a longer
                    burn-in. This tests for a bias shared by chains that
                    start from the same configuration.

Uncertainty is grouped by outer boundary. The kernel avoids temporary arrays
for speed. `bench` mode re-checks it against the exact single-site conditional
at block size 1.

Usage: python stage2.py bench | python stage2.py O3 1.5 | python stage2.py O2 1.3
"""

import json
import math
import sys
import time

import numpy as np
from numba import njit

sys.path.insert(0, ".")
from pilot import init, seed, wolff  # noqa: E402
from sensitivity import exact_mean, randomize_coarse  # noqa: E402


@njit(cache=True)
def sweep2(s, beta, frozen, eps):
    L = s.shape[0]
    n = s.shape[2]
    h = np.empty(n)
    p = np.empty(n)
    for i in range(L):
        ip = (i + 1) % L
        im = (i - 1) % L
        for j in range(L):
            if frozen[i, j]:
                continue
            jp = (j + 1) % L
            jm = (j - 1) % L
            hh = 0.0
            for k in range(n):
                h[k] = s[ip, j, k] + s[im, j, k] + s[i, jp, k] + s[i, jm, k]
                hh += h[k] * h[k]
            nn = 0.0
            for k in range(n):
                p[k] = s[i, j, k] + eps * np.random.normal()
                nn += p[k] * p[k]
            nn = math.sqrt(nn)
            dE = 0.0
            for k in range(n):
                p[k] /= nn
                dE += (p[k] - s[i, j, k]) * h[k]
            dE *= beta
            if dE >= 0.0 or np.random.random() < math.exp(dE):
                for k in range(n):
                    s[i, j, k] = p[k]
            if hh > 1e-12:
                sh = 0.0
                for k in range(n):
                    sh += s[i, j, k] * h[k]
                c = 2.0 * sh / hh
                for k in range(n):
                    s[i, j, k] = c * h[k] - s[i, j, k]


@njit(cache=True)
def cond_mean2(s, beta, frozen, ii, jj, nburn, nmeas, eps):
    n = s.shape[2]
    for _ in range(nburn):
        sweep2(s, beta, frozen, eps)
    m = np.zeros(n)
    for _ in range(nmeas):
        sweep2(s, beta, frozen, eps)
        for k in range(n):
            m[k] += s[ii, jj, k]
    return m / nmeas


@njit(cache=True)
def fresh_unfrozen(s, frozen):
    L = s.shape[0]
    n = s.shape[2]
    for i in range(L):
        for j in range(L):
            if not frozen[i, j]:
                nn = 0.0
                for k in range(n):
                    s[i, j, k] = np.random.normal()
                    nn += s[i, j, k] ** 2
                nn = math.sqrt(nn)
                for k in range(n):
                    s[i, j, k] /= nn


def neighbour_set():
    out = [(di, dj) for di in range(-2, 3) for dj in range(-2, 3) if (di, dj) != (0, 0)]
    out += [(3, 0), (-3, 0), (0, 3), (0, -3)]
    return out


def ring(di, dj):
    m = max(abs(di), abs(dj))
    return "ring1" if m == 1 else ("ring2" if m == 2 else "axis3")


def run(L, n, beta, b, n_outer, n_sites, nburn, nmeas, sd, fresh):
    seed(sd)
    rng = np.random.default_rng(sd)
    s = init(L, n)
    for _ in range(3000):
        wolff(s, beta)
    eps = 0.5
    nc = L // b
    nbrs = neighbour_set()
    coarse = np.zeros((L, L), dtype=np.bool_)
    coarse[::b, ::b] = True
    per_outer = {"total": [], "ring1": [], "ring2": [], "axis3": []}
    for _ in range(n_outer):
        for _ in range(100):
            wolff(s, beta)
        base = s.copy()
        randomize_coarse(base, b)
        acc = {"total": [], "ring1": [], "ring2": [], "axis3": []}
        for _ in range(n_sites):
            ci, cj = rng.integers(nc), rng.integers(nc)
            ii, jj = ci * b, cj * b
            frozen = coarse.copy()
            frozen[ii, jj] = False
            w = base.copy()
            if fresh:
                fresh_unfrozen(w, frozen)
            m0 = cond_mean2(w, beta, frozen, ii, jj, nburn, nmeas, eps)
            parts = {"ring1": 0.0, "ring2": 0.0, "axis3": 0.0}
            for di, dj in nbrs:
                pi, pj = ((ci + di) % nc) * b, ((cj + dj) % nc) * b
                u = base[pi, pj].copy()
                pert = base.copy()
                pert[pi, pj] = -u
                if fresh:
                    fresh_unfrozen(pert, frozen)
                m1 = cond_mean2(pert, beta, frozen, ii, jj, nburn, nmeas, eps)
                parts[ring(di, dj)] += 0.5 * float(np.dot(m0 - m1, u))
            for k in parts:
                acc[k].append(parts[k])
            acc["total"].append(sum(parts.values()))
        for k in acc:
            per_outer[k].append(np.mean(acc[k]))
    out = {}
    for k, v in per_outer.items():
        a = np.array(v)
        out[k] = float(a.mean())
        out[k + "_err"] = float(a.std(ddof=1) / np.sqrt(len(a)))
    return out


def bench():
    """Block size 1 on L = 32: compare cond_mean2 against the exact conditional."""
    rows = []
    for n, beta in ((3, 1.5), (2, 1.3)):
        seed(77)
        s = init(32, n)
        for _ in range(2000):
            wolff(s, beta)
        errs = []
        for _ in range(40):
            for _ in range(20):
                wolff(s, beta)
            i, j = np.random.randint(32), np.random.randint(32)
            frozen = np.ones((32, 32), dtype=np.bool_)
            frozen[i, j] = False
            m = cond_mean2(s.copy(), beta, frozen, i, j, 50, 4000, 0.5)
            h = s[(i + 1) % 32, j] + s[(i - 1) % 32, j] + s[i, (j + 1) % 32] + s[i, (j - 1) % 32]
            errs.append(np.linalg.norm(m - exact_mean(n, beta, h)))
        line = f"bench O({n}) beta={beta}: mean |estimated - exact| conditional mean = {np.mean(errs):.4f} (max {np.max(errs):.4f})"
        print(line, flush=True)
        rows.append(line)
    return rows


def main():
    if sys.argv[1] == "bench":
        bench()
        return
    model, beta = sys.argv[1], float(sys.argv[2])
    n = 3 if model == "O3" else 2
    L, b, n_outer, n_sites, nmeas = 64, 4, 8, 2, 600
    rows = []
    for label, nburn, sd, fresh in (("seed A", 200, 5001, False),
                                    ("seed B", 200, 6001, False),
                                    ("seed A, fresh chains", 800, 5001, True)):
        t0 = time.time()
        out = run(L, n, beta, b, n_outer, n_sites, nburn, nmeas, sd, fresh)
        dt = time.time() - t0
        print(f"{model} beta={beta} L={L} b={b} {label}: total={out['total']:.3f}±{out['total_err']:.3f}"
              f"  ring1={out['ring1']:.3f}±{out['ring1_err']:.3f}"
              f"  ring2={out['ring2']:.3f}±{out['ring2_err']:.3f}"
              f"  axis3={out['axis3']:.3f}±{out['axis3_err']:.3f}  ({dt:.0f}s)", flush=True)
        rows.append({"model": model, "beta": beta, "L": L, "block": b, "setting": label,
                     "seed": sd, "fresh": fresh, "nburn": nburn, "nmeas": nmeas,
                     "n_outer": n_outer, "n_sites": n_sites, **out})
        with open(f"stage2_{model}_b{beta}.json", "w") as f:
            json.dump(rows, f, indent=1)


if __name__ == "__main__":
    main()
