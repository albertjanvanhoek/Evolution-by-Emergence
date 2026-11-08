"""Targeted test (NOTE_O3_INFLUENCE.md, step 1): influence on structured
"bad" boundaries versus random ones, for O(3) beta=1.5 and O(2) beta=1.3.
L = 64, decimation with b = 4 (16 x 16 coarse lattice).

Boundaries (the retained coarse spins, except the target i):
  random     : independent uniform directions (reference, as before)
  ns_checker : +N / -N in a checkerboard (N = z for O(3), y for O(2))
  ns_random  : +N / -N at random
  aligned    : all +N
  planar     : O(3) only, independent directions in the xy-plane

Probes on a coarse spin j at coarse distance d along the axes (4 directions):
  flip : s_j -> -s_j, response of s_i along the original s_j      (d = 1, 2)
  tilt : s_j turned 45 degrees toward a sideways axis e, response
         of s_i along e                                          (d = 1, 2, 4, 6)
         e = x for the N-S and aligned boundaries; e = z for planar (O(3));
         for random, e is a fixed unit vector orthogonalised against s_j.
Both responses, divided by 2, are lower bounds on the total-variation
influence of j on i. Per-neighbour values, grouped errors over boundaries.

The tilt probe targets the spin-flop mechanism (D'Achille, van Enter and Le Ny
2022): with N-S retained spins, the hidden spins can turn sideways, and a
small sideways push at j may then move s_i sideways far away.

Usage: python adversarial.py O3 1.5 | python adversarial.py O2 1.3
"""

import json
import sys
import time

import numpy as np

sys.path.insert(0, ".")
from pilot import init, seed, wolff  # noqa: E402
from stage2 import cond_mean2  # noqa: E402

L, B = 64, 4
NC = L // B
DIST_TILT = (1, 2, 4, 6)
DIST_FLIP = (1, 2)
DIRS = ((1, 0), (-1, 0), (0, 1), (0, -1))


def unit(v):
    return v / np.linalg.norm(v)


def set_boundary(s, kind, n, rng):
    north = np.zeros(n)
    north[2 if n == 3 else 1] = 1.0
    for ci in range(NC):
        for cj in range(NC):
            i, j = ci * B, cj * B
            if kind == "random":
                s[i, j] = unit(rng.normal(size=n))
            elif kind == "ns_checker":
                s[i, j] = north if (ci + cj) % 2 == 0 else -north
            elif kind == "ns_random":
                s[i, j] = north if rng.random() < 0.5 else -north
            elif kind == "aligned":
                s[i, j] = north
            elif kind == "planar":
                v = rng.normal(size=n)
                v[2] = 0.0
                s[i, j] = unit(v)


def side_axis(kind, n, sj):
    if kind == "planar":
        return np.array([0.0, 0.0, 1.0])
    e = np.zeros(n)
    e[0] = 1.0
    if kind == "random":
        e = e - np.dot(e, sj) * sj
        if np.linalg.norm(e) < 1e-6:
            e = np.zeros(n)
            e[1] = 1.0
            e = e - np.dot(e, sj) * sj
        e = unit(e)
    return e


def run(n, beta, kind, n_outer, n_sites, nburn, nmeas, sd):
    seed(sd)
    rng = np.random.default_rng(sd)
    s = init(L, n)
    for _ in range(3000):
        wolff(s, beta)
    coarse = np.zeros((L, L), dtype=np.bool_)
    coarse[::B, ::B] = True
    keys = [f"tilt{d}" for d in DIST_TILT] + [f"flip{d}" for d in DIST_FLIP]
    per_outer = {k: [] for k in keys}
    for _ in range(n_outer):
        for _ in range(100):
            wolff(s, beta)
        base = s.copy()
        set_boundary(base, kind, n, rng)
        acc = {k: [] for k in keys}
        for _ in range(n_sites):
            ci, cj = rng.integers(NC), rng.integers(NC)
            ii, jj = ci * B, cj * B
            frozen = coarse.copy()
            frozen[ii, jj] = False
            m0 = cond_mean2(base.copy(), beta, frozen, ii, jj, nburn, nmeas, 0.5)
            for d in DIST_TILT:
                vals = []
                for di, dj in DIRS:
                    pi, pj = ((ci + d * di) % NC) * B, ((cj + d * dj) % NC) * B
                    sj = base[pi, pj].copy()
                    e = side_axis(kind, n, sj)
                    pert = base.copy()
                    pert[pi, pj] = unit(np.cos(np.pi / 4) * sj + np.sin(np.pi / 4) * e)
                    m1 = cond_mean2(pert, beta, frozen, ii, jj, nburn, nmeas, 0.5)
                    vals.append(0.5 * float(np.dot(m1 - m0, e)))
                acc[f"tilt{d}"].append(np.mean(vals))
            for d in DIST_FLIP:
                vals = []
                for di, dj in DIRS:
                    pi, pj = ((ci + d * di) % NC) * B, ((cj + d * dj) % NC) * B
                    u = base[pi, pj].copy()
                    pert = base.copy()
                    pert[pi, pj] = -u
                    m1 = cond_mean2(pert, beta, frozen, ii, jj, nburn, nmeas, 0.5)
                    vals.append(0.5 * float(np.dot(m0 - m1, u)))
                acc[f"flip{d}"].append(np.mean(vals))
        for k in keys:
            per_outer[k].append(np.mean(acc[k]))
    out = {}
    for k, v in per_outer.items():
        a = np.array(v)
        out[k] = float(a.mean())
        out[k + "_err"] = float(a.std(ddof=1) / np.sqrt(len(a)))
    return out


def main():
    model, beta = sys.argv[1], float(sys.argv[2])
    n = 3 if model == "O3" else 2
    kinds = ["random", "ns_checker", "ns_random", "aligned"] + (["planar"] if n == 3 else [])
    n_outer, n_sites, nburn, nmeas = 6, 2, 400, 500
    rows = []
    for k, kind in enumerate(kinds):
        t0 = time.time()
        sd = 9001 + 10 * k
        o = run(n, beta, kind, n_outer, n_sites, nburn, nmeas, sd)
        dt = time.time() - t0
        print(f"{model} beta={beta} {kind:10s} "
              + " ".join(f"{key}={o[key]:.4f}±{o[key + '_err']:.4f}"
                         for key in [f"tilt{d}" for d in DIST_TILT] + [f"flip{d}" for d in DIST_FLIP])
              + f"  ({dt:.0f}s)", flush=True)
        rows.append({"model": model, "beta": beta, "L": L, "block": B, "boundary": kind,
                     "seed": sd, "n_outer": n_outer, "n_sites": n_sites,
                     "nburn": nburn, "nmeas": nmeas, **o})
        with open(f"adversarial_{model}_b{beta}.json", "w") as f:
            json.dump(rows, f, indent=1)


if __name__ == "__main__":
    main()
