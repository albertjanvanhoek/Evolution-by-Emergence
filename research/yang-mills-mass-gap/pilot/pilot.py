"""Pilot: coarse versus residual correlations in 2D O(2) and O(3) spin models.

For a coarse variable B (spins on a frozen subset of sites), the spin-spin
correlation splits exactly as

    C(r) = <s_x . s_y> = <E[s_x|B] . E[s_y|B]> + <E[s_x . s_y|B] - E[s_x|B] . E[s_y|B]>
           (total)       (coarse part)              (residual part)

(the mean spin is 0 by symmetry). The outer chain samples B with the Wolff
cluster algorithm. For each outer sample, an inner chain samples the other
spins with B frozen (Metropolis plus overrelaxation). Conditional means are
estimated from two halves of the inner chain, and the coarse part uses the
product of the two halves, which removes the finite-sample bias.

Coarse variables:
  grid   : every b-th row and column. Cells are then conditionally
           independent (nearest-neighbour Markov property), so the residual
           part between different cells is exactly 0. This validates the
           estimator.
  points : every b-th site in both directions (decimation). The residual part
           is genuinely nonzero.

Usage: python pilot.py [--quick]
"""

import json
import sys
import time

import numpy as np
from numba import njit

L = 32
B = 4
OFFSET = B // 2
RS = np.array([1, B, 2 * B, 3 * B, 4 * B])


@njit(cache=True)
def rand_unit(n):
    v = np.random.normal(0.0, 1.0, n)
    return v / np.sqrt(np.sum(v * v))


@njit(cache=True)
def init(L, n):
    s = np.empty((L, L, n))
    for i in range(L):
        for j in range(L):
            s[i, j] = rand_unit(n)
    return s


@njit(cache=True)
def wolff(s, beta):
    L = s.shape[0]
    n = s.shape[2]
    r = rand_unit(n)
    inc = np.zeros((L, L), dtype=np.bool_)
    stack_i = np.empty(L * L, dtype=np.int64)
    stack_j = np.empty(L * L, dtype=np.int64)
    i0 = np.random.randint(L)
    j0 = np.random.randint(L)
    top = 0
    stack_i[0] = i0
    stack_j[0] = j0
    inc[i0, j0] = True
    top = 1
    while top > 0:
        top -= 1
        i = stack_i[top]
        j = stack_j[top]
        px = np.sum(s[i, j] * r)
        s[i, j] -= 2.0 * px * r
        for d in range(4):
            if d == 0:
                ni, nj = (i + 1) % L, j
            elif d == 1:
                ni, nj = (i - 1) % L, j
            elif d == 2:
                ni, nj = i, (j + 1) % L
            else:
                ni, nj = i, (j - 1) % L
            if not inc[ni, nj]:
                py = np.sum(s[ni, nj] * r)
                if px * py > 0.0:
                    if np.random.random() < 1.0 - np.exp(-2.0 * beta * px * py):
                        inc[ni, nj] = True
                        stack_i[top] = ni
                        stack_j[top] = nj
                        top += 1


@njit(cache=True)
def local_field(s, i, j):
    L = s.shape[0]
    return s[(i + 1) % L, j] + s[(i - 1) % L, j] + s[i, (j + 1) % L] + s[i, (j - 1) % L]


@njit(cache=True)
def sweep(s, beta, frozen, eps):
    L = s.shape[0]
    n = s.shape[2]
    acc = 0
    for i in range(L):
        for j in range(L):
            if frozen[i, j]:
                continue
            h = local_field(s, i, j)
            # Metropolis
            prop = s[i, j] + eps * np.random.normal(0.0, 1.0, n)
            prop /= np.sqrt(np.sum(prop * prop))
            dE = beta * np.sum((prop - s[i, j]) * h)
            if dE >= 0.0 or np.random.random() < np.exp(dE):
                s[i, j] = prop
                acc += 1
            # overrelaxation (energy preserving reflection about h)
            hh = np.sum(h * h)
            if hh > 1e-12:
                s[i, j] = 2.0 * np.sum(s[i, j] * h) / hh * h - s[i, j]
    return acc


@njit(cache=True)
def inner_chain(s, beta, frozen, eps, nsweep, rs, off, b):
    """Run the conditional chain; return per-observation-site estimates."""
    L = s.shape[0]
    n = s.shape[2]
    half = nsweep // 2
    m1 = np.zeros((L, L, n))
    m2 = np.zeros((L, L, n))
    nr = rs.shape[0]
    pair = np.zeros((nr, L, L))
    for t in range(nsweep):
        sweep(s, beta, frozen, eps)
        if t < half:
            m1 += s
        else:
            m2 += s
        for k in range(nr):
            r = rs[k]
            for i in range(off, L, b):
                for j in range(off, L, b):
                    pair[k, i, j] += np.sum(s[i, j] * s[(i + r) % L, j])
    m1 /= half
    m2 /= (nsweep - half)
    pair /= nsweep
    out = np.zeros((nr, 2))  # (coarse, residual), averaged over observation sites
    cnt = 0
    for i in range(off, L, b):
        for j in range(off, L, b):
            cnt += 1
            for k in range(nr):
                r = rs[k]
                y = (i + r) % L
                coarse = 0.5 * (np.sum(m1[i, j] * m2[y, j]) + np.sum(m2[i, j] * m1[y, j]))
                out[k, 0] += coarse
                out[k, 1] += pair[k, i, j] - coarse
    return out / cnt


@njit(cache=True)
def direct_corr(s, rs, off, b):
    L = s.shape[0]
    nr = rs.shape[0]
    out = np.zeros(nr)
    cnt = 0
    for i in range(off, L, b):
        for j in range(off, L, b):
            cnt += 1
            for k in range(nr):
                out[k] += np.sum(s[i, j] * s[(i + rs[k]) % L, j])
    return out / cnt


@njit(cache=True)
def seed(x):
    np.random.seed(x)


def frozen_mask(kind):
    idx = np.arange(L)
    on = (idx % B == 0)
    if kind == "grid":
        return on[:, None] | on[None, :]
    return on[:, None] & on[None, :]


def run(n, beta, kind, n_outer, n_inner, rng_seed):
    seed(rng_seed)
    s = init(L, n)
    for _ in range(2000):
        wolff(s, beta)
    frozen = frozen_mask(kind)
    eps = 0.8 if beta < 1.0 else 0.5
    rows = []
    for _ in range(n_outer):
        for _ in range(50):
            wolff(s, beta)
        direct = direct_corr(s, RS, OFFSET, B)
        work = s.copy()
        est = inner_chain(work, beta, frozen, eps, n_inner, RS, OFFSET, B)
        rows.append(np.column_stack([direct, est]))
    a = np.array(rows)  # (outer, r, [direct, coarse, residual])
    mean = a.mean(axis=0)
    err = a.std(axis=0, ddof=1) / np.sqrt(n_outer)
    return mean, err


def main():
    quick = "--quick" in sys.argv
    n_outer, n_inner = (8, 200) if quick else (32, 1000)
    configs = [
        ("O(3)", 3, 1.2), ("O(3)", 3, 1.5),
        ("O(2)", 2, 0.8), ("O(2)", 2, 1.3),
    ]
    results = {"L": L, "block": B, "offset": OFFSET, "r": RS.tolist(),
               "n_outer": n_outer, "n_inner": n_inner, "runs": []}
    for kind in ("grid", "points"):
        for k, (name, n, beta) in enumerate(configs):
            t0 = time.time()
            rng_seed = 1000 + 10 * k + (0 if kind == "grid" else 5)
            mean, err = run(n, beta, kind, n_outer, n_inner, rng_seed)
            dt = time.time() - t0
            print(f"\n{name} beta={beta} coarse={kind}  seed={rng_seed}  ({dt:.0f}s)")
            print("   r   direct C(r)        coarse            residual")
            for i, r in enumerate(RS):
                print(f"{r:4d}  {mean[i,0]: .4f}±{err[i,0]:.4f}  "
                      f"{mean[i,1]: .4f}±{err[i,1]:.4f}  {mean[i,2]: .4f}±{err[i,2]:.4f}")
            results["runs"].append({
                "model": name, "beta": beta, "coarse": kind, "seed": rng_seed,
                "seconds": round(dt, 1),
                "direct": mean[:, 0].tolist(), "direct_err": err[:, 0].tolist(),
                "coarse_part": mean[:, 1].tolist(), "coarse_err": err[:, 1].tolist(),
                "residual": mean[:, 2].tolist(), "residual_err": err[:, 2].tolist(),
            })
    out = "results_quick.json" if quick else "results.json"
    with open(out, "w") as f:
        json.dump(results, f, indent=1)
    print(f"\nwrote {out}")


if __name__ == "__main__":
    main()
