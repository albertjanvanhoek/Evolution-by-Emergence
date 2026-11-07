"""Stage 3 (review on PR #144): the same influence measurement at block sizes
2, 4 and 8 on L = 64, for O(3) beta=1.5 and O(2) beta=1.3, random boundaries.

Neighbours:
  b = 2, 4 : the 28-neighbour stencil of stage 2 (rings 1, 2 and axis 3), plus
             at b = 2 a sample of distant neighbours (coarse distance 4 to 6),
             reported per neighbour and not added to the sum.
  b = 8    : all 63 other coarse spins of the 8 x 8 coarse lattice, so the sum
             is complete. Rings by Chebyshev distance (minimum image).

Per boundary and site:
  signed : sum over j of delta_ij (as before; opposite responses can cancel);
  abs    : sum over j of |delta_ij| (no cancellation, but biased upward by noise);
  noise  : sum over j of |(m0 - m0') . u_j| / 2, where m0' comes from a second,
           independent base chain. This estimates what `abs` would read if every
           true delta_ij were 0.
Uncertainty is grouped by outer boundary.

Usage: python stage3.py O3 1.5 | python stage3.py O2 1.3
"""

import json
import sys
import time

import numpy as np

sys.path.insert(0, ".")
from pilot import init, seed, wolff  # noqa: E402
from sensitivity import randomize_coarse  # noqa: E402
from stage2 import cond_mean2  # noqa: E402

L = 64
FAR = [(4, 0), (0, 4), (-4, 0), (0, -4), (4, 4), (-4, -4), (6, 0), (0, 6)]


def mi(d, nc):
    d %= nc
    return d - nc if d > nc // 2 else d


def stencil(b):
    nc = L // b
    if b == 8:
        offs = [(di, dj) for di in range(nc) for dj in range(nc) if (di, dj) != (0, 0)]
        offs = [(mi(di, nc), mi(dj, nc)) for di, dj in offs]
    else:
        offs = [(di, dj) for di in range(-2, 3) for dj in range(-2, 3) if (di, dj) != (0, 0)]
        offs += [(3, 0), (-3, 0), (0, 3), (0, -3)]
    return offs


def ring(di, dj):
    m = max(abs(di), abs(dj))
    if m == 1:
        return "ring1"
    if m == 2:
        return "ring2"
    if m == 3:
        return "ring3"
    return "ring4"


def run(n, beta, b, n_outer, n_sites, nburn, nmeas, sd):
    seed(sd)
    rng = np.random.default_rng(sd)
    s = init(L, n)
    for _ in range(3000):
        wolff(s, beta)
    eps = 0.5
    nc = L // b
    offs = stencil(b)
    far = FAR if b == 2 else []
    coarse = np.zeros((L, L), dtype=np.bool_)
    coarse[::b, ::b] = True
    keys = ["signed", "abs", "noise", "ring1", "ring2", "ring3", "ring4", "far_per_nbr"]
    per_outer = {k: [] for k in keys}
    for _ in range(n_outer):
        for _ in range(100):
            wolff(s, beta)
        base = s.copy()
        randomize_coarse(base, b)
        acc = {k: [] for k in keys}
        for _ in range(n_sites):
            ci, cj = rng.integers(nc), rng.integers(nc)
            ii, jj = ci * b, cj * b
            frozen = coarse.copy()
            frozen[ii, jj] = False
            m0 = cond_mean2(base.copy(), beta, frozen, ii, jj, nburn, nmeas, eps)
            m0b = cond_mean2(base.copy(), beta, frozen, ii, jj, nburn, nmeas, eps)
            r = {k: 0.0 for k in keys}
            for di, dj in offs + far:
                pi, pj = ((ci + di) % nc) * b, ((cj + dj) % nc) * b
                u = base[pi, pj].copy()
                pert = base.copy()
                pert[pi, pj] = -u
                m1 = cond_mean2(pert, beta, frozen, ii, jj, nburn, nmeas, eps)
                d = 0.5 * float(np.dot(m0 - m1, u))
                if (di, dj) in far:
                    r["far_per_nbr"] += d / len(far)
                    continue
                r["signed"] += d
                r["abs"] += abs(d)
                r["noise"] += abs(0.5 * float(np.dot(m0 - m0b, u)))
                r[ring(di, dj)] += d
            for k in keys:
                acc[k].append(r[k])
        for k in keys:
            per_outer[k].append(np.mean(acc[k]))
    out = {"neighbours": len(offs)}
    for k, v in per_outer.items():
        a = np.array(v)
        out[k] = float(a.mean())
        out[k + "_err"] = float(a.std(ddof=1) / np.sqrt(len(a)))
    return out


def main():
    model, beta = sys.argv[1], float(sys.argv[2])
    n = 3 if model == "O3" else 2
    n_outer, n_sites, nburn, nmeas = 8, 2, 150, 500
    plan = [(2, "seed A", 7001), (2, "seed B", 8001), (4, "seed A", 7001),
            (8, "seed A", 7001), (8, "seed B", 8001)]
    rows = []
    for b, label, sd in plan:
        t0 = time.time()
        o = run(n, beta, b, n_outer, n_sites, nburn, nmeas, sd + b)
        dt = time.time() - t0
        line = (f"{model} beta={beta} b={b} {label} ({o['neighbours']} nbrs): "
                f"signed={o['signed']:.3f}±{o['signed_err']:.3f} "
                f"abs={o['abs']:.3f}±{o['abs_err']:.3f} noise={o['noise']:.3f} | "
                f"r1={o['ring1']:.3f}±{o['ring1_err']:.3f} r2={o['ring2']:.3f}±{o['ring2_err']:.3f} "
                f"r3={o['ring3']:.3f}±{o['ring3_err']:.3f} r4={o['ring4']:.3f}±{o['ring4_err']:.3f}")
        if b == 2:
            line += f" | far/nbr={o['far_per_nbr']:.4f}±{o['far_per_nbr_err']:.4f}"
        print(line + f"  ({dt:.0f}s)", flush=True)
        rows.append({"model": model, "beta": beta, "L": L, "block": b, "setting": label,
                     "seed": sd + b, "nburn": nburn, "nmeas": nmeas, "n_outer": n_outer,
                     "n_sites": n_sites, **o})
        with open(f"stage3_{model}_b{beta}.json", "w") as f:
            json.dump(rows, f, indent=1)


if __name__ == "__main__":
    main()
