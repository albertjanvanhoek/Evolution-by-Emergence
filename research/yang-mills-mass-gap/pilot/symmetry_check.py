"""Symmetry null control and mixing check for the adversarial test
(review on PR #144).

With every retained spin along +N or -N, the conditional law of the hidden
spins is invariant under reflection of the sideways axis e. So the exact
sideways mean of any hidden spin is 0. A chain stuck in one sideways sector
would violate this, and could also fake a long-range response to a tilt.

For each model and a few fixed North-South random boundaries (L = 64, b = 4):
  base  : no tilt. Hidden spins start East (+e), West (-e) or random.
          Short run (400 burn-in, 500 measured, as in adversarial.py) and long
          run (4000 burn-in, 4000 measured). Reported: the target's sideways
          mean, and the sideways magnetisation of all hidden spins.
  tilt  : coarse spin at distance 4 tilted 45 degrees toward +e. Starts East
          and West, short and long. If the response depends on the start, the
          chain is not mixing and the earlier tilt numbers are unreliable.

Usage: python symmetry_check.py O2 1.3 | python symmetry_check.py O3 1.5
"""

import json
import math
import sys
import time

import numpy as np
from numba import njit

sys.path.insert(0, ".")
from pilot import init, seed, wolff  # noqa: E402
from stage2 import fresh_unfrozen, sweep2  # noqa: E402

L, B = 64, 4
NC = L // B


@njit(cache=True)
def run_chain(s, beta, frozen, ii, jj, e, nburn, nmeas):
    L = s.shape[0]
    n = s.shape[2]
    for _ in range(nburn):
        sweep2(s, beta, frozen, 0.5)
    tgt = 0.0
    mag = 0.0
    nfree = 0
    for i in range(L):
        for j in range(L):
            if not frozen[i, j]:
                nfree += 1
    for _ in range(nmeas):
        sweep2(s, beta, frozen, 0.5)
        v = 0.0
        for k in range(n):
            v += s[ii, jj, k] * e[k]
        tgt += v
        m = 0.0
        for i in range(L):
            for j in range(L):
                if not frozen[i, j]:
                    for k in range(n):
                        m += s[i, j, k] * e[k]
        mag += m / nfree
    return tgt / nmeas, mag / nmeas


@njit(cache=True)
def polarise(s, frozen, e):
    L = s.shape[0]
    n = s.shape[2]
    for i in range(L):
        for j in range(L):
            if not frozen[i, j]:
                nn = 0.0
                for k in range(n):
                    s[i, j, k] = e[k] + 0.3 * np.random.normal()
                    nn += s[i, j, k] ** 2
                nn = math.sqrt(nn)
                for k in range(n):
                    s[i, j, k] /= nn


def main():
    model, beta = sys.argv[1], float(sys.argv[2])
    n = 3 if model == "O3" else 2
    north = np.zeros(n)
    north[2 if n == 3 else 1] = 1.0
    e = np.zeros(n)
    e[0] = 1.0
    seed(12345)
    rng = np.random.default_rng(12345)
    s = init(L, n)
    for _ in range(3000):
        wolff(s, beta)
    coarse = np.zeros((L, L), dtype=np.bool_)
    coarse[::B, ::B] = True
    runs = {"short": (400, 500), "long": (4000, 4000)}
    rows = []
    t0 = time.time()
    for nb in range(4):
        for _ in range(100):
            wolff(s, beta)
        base = s.copy()
        for ci in range(NC):
            for cj in range(NC):
                base[ci * B, cj * B] = north if rng.random() < 0.5 else -north
        ci, cj = rng.integers(NC), rng.integers(NC)
        ii, jj = ci * B, cj * B
        frozen = coarse.copy()
        frozen[ii, jj] = False
        pi, pj = ((ci + 4) % NC) * B, cj * B
        tilted = base.copy()
        sj = base[pi, pj].copy()
        tilted[pi, pj] = (sj + e) / np.linalg.norm(sj + e)
        for label, (nburn, nmeas) in runs.items():
            for start in ("east", "west", "random"):
                w = base.copy()
                if start == "east":
                    polarise(w, frozen, e)
                elif start == "west":
                    polarise(w, frozen, -e)
                else:
                    fresh_unfrozen(w, frozen)
                tgt, mag = run_chain(w, beta, frozen, ii, jj, e, nburn, nmeas)
                rows.append({"boundary": nb, "probe": "base", "run": label, "start": start,
                             "target_sideways": tgt, "hidden_sideways_mag": mag})
            for start in ("east", "west"):
                w = tilted.copy()
                polarise(w, frozen, e if start == "east" else -e)
                tgt, mag = run_chain(w, beta, frozen, ii, jj, e, nburn, nmeas)
                rows.append({"boundary": nb, "probe": "tilt_d4", "run": label, "start": start,
                             "target_sideways": tgt, "hidden_sideways_mag": mag})
    print(f"{model} beta={beta}  ({time.time() - t0:.0f}s)")
    print(" bnd probe    run    start   target_sideways  hidden_sideways_mag")
    for r in rows:
        print(f"  {r['boundary']}  {r['probe']:7s} {r['run']:6s} {r['start']:7s} "
              f"{r['target_sideways']: .4f}          {r['hidden_sideways_mag']: .4f}")
    with open(f"symmetry_{model}_b{beta}.json", "w") as f:
        json.dump({"model": model, "beta": beta, "L": L, "block": B, "runs": runs,
                   "rows": rows}, f, indent=1)


if __name__ == "__main__":
    main()
