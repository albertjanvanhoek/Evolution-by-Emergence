"""Stage 1 validation of experiment 2 (review on PR #144).

Same influence proxy as sensitivity.py, random boundaries, L = 32, with:
  * uncertainty grouped by outer configuration: for each outer boundary, the
    summed influence over all neighbours (and sites) is one observation, so
    correlations between sites and between neighbour classes are included;
  * two independent seeds;
  * burn-in after each perturbation of 200 versus 800 sweeps;
  * neighbour offsets de-duplicated modulo the coarse lattice side.

Usage: python validate.py MODEL BETA   (MODEL is O2 or O3)
"""

import json
import sys
import time

import numpy as np

sys.path.insert(0, ".")
from pilot import init, seed, wolff  # noqa: E402
from sensitivity import CLASSES, cond_mean, randomize_coarse  # noqa: E402

L = 32


def neighbours(nc):
    seen, out = set(), []
    for offs in CLASSES.values():
        for di, dj in offs:
            key = (di % nc, dj % nc)
            if key != (0, 0) and key not in seen:
                seen.add(key)
                out.append((di, dj))
    return out


def run(n, beta, b, n_outer, n_sites, nburn, nmeas, sd):
    seed(sd)
    rng = np.random.default_rng(sd)
    s = init(L, n)
    for _ in range(2000):
        wolff(s, beta)
    eps = 0.5
    nc = L // b
    nbrs = neighbours(nc)
    coarse = np.zeros((L, L), dtype=np.bool_)
    coarse[::b, ::b] = True
    per_outer = []
    for _ in range(n_outer):
        for _ in range(50):
            wolff(s, beta)
        base = s.copy()
        randomize_coarse(base, b)
        site_sums = []
        for _ in range(n_sites):
            ci, cj = rng.integers(nc), rng.integers(nc)
            ii, jj = ci * b, cj * b
            frozen = coarse.copy()
            frozen[ii, jj] = False
            m0 = cond_mean(base.copy(), beta, frozen, ii, jj, nburn, nmeas, eps)
            tot = 0.0
            for di, dj in nbrs:
                pi, pj = ((ci + di) % nc) * b, ((cj + dj) % nc) * b
                u = base[pi, pj].copy()
                pert = base.copy()
                pert[pi, pj] = -u
                m1 = cond_mean(pert, beta, frozen, ii, jj, nburn, nmeas, eps)
                tot += 0.5 * np.dot(m0 - m1, u)
            site_sums.append(tot)
        per_outer.append(np.mean(site_sums))
    a = np.array(per_outer)
    return float(a.mean()), float(a.std(ddof=1) / np.sqrt(len(a))), len(nbrs)


def main():
    model, beta = sys.argv[1], float(sys.argv[2])
    n = 3 if model == "O3" else 2
    n_outer, n_sites, nmeas = 12, 2, 600
    rows = []
    for b in (2, 4):
        for label, nburn, sd in (("seed A, burn 200", 200, 3001),
                                 ("seed B, burn 200", 200, 4001),
                                 ("seed A, burn 800", 800, 3001)):
            t0 = time.time()
            mean, err, nn = run(n, beta, b, n_outer, n_sites, nburn, nmeas, sd + 10 * b)
            dt = time.time() - t0
            print(f"{model} beta={beta} b={b} {label}: sum={mean:.3f} ± {err:.3f}"
                  f"  ({nn} neighbours, {dt:.0f}s)", flush=True)
            rows.append({"model": model, "beta": beta, "block": b, "setting": label,
                         "nburn": nburn, "seed": sd + 10 * b, "sum": mean,
                         "err_grouped": err, "neighbours": nn, "n_outer": n_outer,
                         "n_sites": n_sites, "nmeas": nmeas})
    with open(f"validate_{model}_b{beta}.json", "w") as f:
        json.dump(rows, f, indent=1)


if __name__ == "__main__":
    main()
