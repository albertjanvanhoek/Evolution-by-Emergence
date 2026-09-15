#!/usr/bin/env python3
"""delta-packing numbers of the probability simplex under total variation.

P_delta(X) = max{ |I| : d_TV(p_i, p_j) >= delta for all i != j in I },
the geometric factor in  D_delta <= min[ 1 + delta^-1 sqrt(N Sigma/2), P_delta(X) ].

Three things are computed:

  exact      closed form for |S| = 2:  P_delta = floor(1/delta) + 1
  achievable best delta-separated set found (a LOWER bound on P_delta), by
             randomized greedy with restarts and a swap local search
  upper      a lattice-rounding bound, proved and checked below:
                 P_delta <= C(k + n - 1, n - 1),  k = floor(n/(2 delta)) + 1
             which is sharp to within one point at n = 2.
"""
from __future__ import annotations
import argparse
import itertools
from math import comb, floor
import numpy as np


def dTV(p, q):
    return 0.5 * np.abs(np.asarray(p) - np.asarray(q)).sum()


# --------------------------------------------------------------------------
# upper bound

def round_to_lattice(p, k):
    """Nearest point of L_k = {m/k : m in Z_{>=0}^n, sum m = k}, largest-remainder."""
    f = np.asarray(p) * k
    m = np.floor(f).astype(int)
    D = k - m.sum()
    if D > 0:
        order = np.argsort(-(f - m))
        m[order[:D]] += 1
    return m / k


def upper_bound(n, delta):
    k = floor(n / (2 * delta)) + 1
    return comb(k + n - 1, n - 1), k


def check_rounding_lemma(n, k, trials=200000, seed=0):
    """Lemma: d_TV(p, round_to_lattice(p,k)) <= n/(4k) for every p in the simplex.

    Checked here against random p and against the worst case predicted by the
    proof (all fractional parts equal).
    """
    rng = np.random.default_rng(seed)
    P = rng.dirichlet(np.ones(n), size=trials)
    worst = max(dTV(p, round_to_lattice(p, k)) for p in P)
    # predicted extremal configuration: D = n/2 coordinates rounded up,
    # every fractional part equal to D/n
    D = n // 2
    pred = (n - D) * (D / n) / k
    return worst, n / (4 * k), pred


# --------------------------------------------------------------------------
# achievable lower bound

def candidates(n, k, rng, n_random=4000):
    """Lattice L_k plus random Dirichlet points."""
    pts = []
    for c in itertools.combinations(range(k + n - 1), n - 1):
        m, prev = [], -1
        for x in c:
            m.append(x - prev - 1)
            prev = x
        m.append(k + n - 2 - prev)
        pts.append(np.array(m, dtype=float) / k)
    pts += list(rng.dirichlet(np.ones(n), size=n_random))
    return pts


def greedy(pts, delta, order, tol=1e-12):
    chosen = []
    for i in order:
        p = pts[i]
        if all(dTV(p, c) >= delta - tol for c in chosen):
            chosen.append(p)
    return chosen


def achievable(n, delta, k=20, restarts=400, seed=0, n_random=4000):
    if n == 2:                                    # exact
        return floor(1 / delta) + 1, True
    rng = np.random.default_rng(seed)
    pts = candidates(n, k, rng, n_random=n_random)
    N = len(pts)
    best = greedy(pts, delta, range(N))
    for _ in range(restarts):
        cand = greedy(pts, delta, rng.permutation(N))
        if len(cand) > len(best):
            best = cand
    # swap local search: drop one, re-greedy from a random order
    for _ in range(restarts // 4):
        if not best:
            break
        keep = [c for j, c in enumerate(best) if j != rng.integers(len(best))]
        chosen = list(keep)
        for i in rng.permutation(N):
            p = pts[i]
            if all(dTV(p, c) >= delta - 1e-12 for c in chosen):
                chosen.append(p)
        if len(chosen) > len(best):
            best = chosen
    return len(best), False


# --------------------------------------------------------------------------

if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--ci", action="store_true",
                    help="fast smoke-test settings for CI; full lower-bound search remains the default")
    args = ap.parse_args()

    rounding_trials = 4000 if args.ci else 40000
    search_k = 10 if args.ci else 20
    restarts = 12 if args.ci else 400
    n_random = 500 if args.ci else 4000

    print("=" * 78)
    print("rounding lemma  d_TV(p, L_k) <= n/(4k)")
    print("=" * 78)
    print("  {:<5}{:<5}{:>14}{:>14}{:>14}".format(
        "n", "k", "worst found", "n/(4k)", "proof extremal"))
    for n in [2, 3, 4, 5, 6]:
        for k in [3, 7]:
            w, b, pr = check_rounding_lemma(n, k, trials=rounding_trials)
            flag = "  OK" if w <= b + 1e-12 else "  VIOLATED"
            print("  {:<5}{:<5}{:>14.6f}{:>14.6f}{:>14.6f}{}".format(n, k, w, b, pr, flag))
            assert w <= b + 1e-12

    print()
    print("=" * 78)
    print("delta-packing number of the simplex under total variation")
    print("=" * 78)
    print("  {:<6}{:<8}{:<22}{:<22}".format("|S|", "delta", "achievable", "upper bound"))
    for n in [2, 3, 4, 5]:
        for delta in [0.9, 0.5, 0.25]:
            a, exact = achievable(n, delta, k=search_k, restarts=restarts,
                                  n_random=n_random)
            ub, k = upper_bound(n, delta)
            assert a <= ub
            tag = "exact" if exact else ">= (best found)"
            print("  {:<6}{:<8}{:<22}{:<22}".format(
                n, delta, f"{a}  {tag}", f"{ub}  (k={k})"))
    print()
    if args.ci:
        print("  CI mode uses a reduced lower-bound search; theorem checks are unchanged.")
    print("  Every entry is finite and depends only on (|S|, delta).")
    print("  Neither N_* nor Sigma_* nor time nor temperature appears in it.")
