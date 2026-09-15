#!/usr/bin/env python3
"""Adversarial check of the packing-depth bound

        D_delta(x_0, ..., x_n)  <=  1 + delta^-1 sqrt( N_* Sigma_* / 2 )

on random master equations with arbitrary time-dependent rates -- no ring, no
shuttle, no structure at all.  Also re-checks the two ingredients separately:

    pointwise   ||p_dot||_1 <= sqrt(2 A sigma)
    integrated  d_TV(p(t), p(t')) <= sqrt( N Sigma / 2 )   on every sub-interval

and the geometric factor  D_delta <= P_delta(X).
"""
from __future__ import annotations
import argparse
import numpy as np
from simulate import dTV, packing_depth


def random_run(n, rng, T=6.0, steps=6000, n_snap=14, rate_scale=3.0):
    """Random support, random time-dependent rates, random snapshot times."""
    supp = rng.random((n, n)) < 0.75
    supp = supp | supp.T                       # W_ij > 0  iff  W_ji > 0
    np.fill_diagonal(supp, False)
    if not supp.any():
        supp[0, 1] = supp[1, 0] = True
    base = rng.lognormal(0.0, 1.0, size=(n, n)) * rate_scale
    freq = rng.uniform(0.5, 4.0, size=(n, n))
    phase = rng.uniform(0, 2 * np.pi, size=(n, n))

    p = rng.dirichlet(np.ones(n))
    dt = T / steps
    N = S = 0.0
    snap_at = np.sort(rng.choice(np.arange(1, steps), size=n_snap, replace=False))
    # Store cumulative budgets at each snapshot so every snapshot-pair
    # sub-interval can be tested against its own N,S increments.
    snaps = [(0, p.copy(), 0.0, 0.0)]
    worst_pointwise = 0.0
    for k in range(steps):
        t = k * dt
        W = np.where(supp, base * (1.2 + np.sin(freq * t + phase)), 0.0)
        F = W * p[None, :]                     # F[i,j] = W[i,j] p_j
        A = F.sum()
        with np.errstate(divide="ignore", invalid="ignore"):
            term = np.where((F > 0) & (F.T > 0), (F - F.T) * np.log(F / F.T), 0.0)
        sigma = 0.5 * term.sum()               # each unordered pair counted twice
        dp = F.sum(axis=1) - F.sum(axis=0)
        if sigma > 0:
            worst_pointwise = max(worst_pointwise,
                                  np.abs(dp).sum() / np.sqrt(2 * A * sigma))
        p = np.clip(p + dp * dt, 1e-14, None)
        p /= p.sum()
        N += A * dt
        S += sigma * dt
        if k + 1 in snap_at:
            snaps.append((k + 1, p.copy(), N, S))
    if snaps[-1][0] != steps:
        snaps.append((steps, p.copy(), N, S))
    return snaps, N, S, worst_pointwise


def check(n_trials=400, seed=1):
    rng = np.random.default_rng(seed)
    worst_point = 0.0
    worst_interval = 0.0
    worst_depth = 0.0
    worst_geom = 0.0
    fails = 0
    for t in range(n_trials):
        n = int(rng.integers(2, 7))
        delta = float(rng.uniform(0.05, 0.6))
        snaps, N, S, wp = random_run(n, rng)
        worst_point = max(worst_point, wp)

        # Integrated bound on every snapshot-pair sub-interval, using
        # cumulative-budget differences for that interval.
        states = [s for _, s, _, _ in snaps]
        for i in range(len(snaps)):
            _, pi, Ni, Si = snaps[i]
            for j in range(i + 1, len(snaps)):
                _, pj, Nj, Sj = snaps[j]
                dN, dS = Nj - Ni, Sj - Si
                if dN > 0 and dS > 0:
                    ratio = dTV(pi, pj) / np.sqrt(dN * dS / 2)
                    worst_interval = max(worst_interval, ratio)
                    if ratio > 1 + 5e-3:
                        fails += 1
                        print("  FAIL interval n=%d ratio=%.6f" % (n, ratio))

        D, _ = packing_depth(states, delta)
        bound = 1.0 + np.sqrt(N * S / 2) / delta
        worst_depth = max(worst_depth, D / bound)
        if D > bound + 1e-9:
            fails += 1
            print("  FAIL n=%d delta=%.3f D=%d bound=%.4f" % (n, delta, D, bound))

        # Geometric factor: exact for |S|=2; lattice-rounding upper
        # bound for all larger finite state spaces.
        if n == 2:
            P = np.floor(1 / delta) + 1
        else:
            from math import comb, floor
            k = floor(n / (2 * delta)) + 1
            P = comb(k + n - 1, n - 1)
        worst_geom = max(worst_geom, D / P)
        if D > P + 1e-9:
            fails += 1
            print("  FAIL geometry n=%d delta=%.3f D=%d P=%d" % (n, delta, D, P))
    return worst_point, worst_interval, worst_depth, worst_geom, fails


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--trials", type=int, default=400,
                    help="number of random master equations; default reproduces the 400-run audit")
    args = ap.parse_args()

    print("=" * 78)
    print("random master equations, arbitrary time-dependent rates")
    print("=" * 78)
    wp, wi, wd, wg, fails = check(n_trials=args.trials)
    print("  trials                                       %d" % args.trials)
    print("  worst  ||p_dot||_1 / sqrt(2 A sigma)         %.6f   (must be <= 1)" % wp)
    print("  worst  d_TV / sqrt(N Sigma / 2)              %.6f   (must be <= 1)" % wi)
    print("  worst  D_delta / [1 + delta^-1 sqrt(N S/2)]  %.6f   (must be <= 1)" % wd)
    print("  worst  D_delta / P_delta upper bound         %.6f   (must be <= 1)" % wg)
    print("  violations                                   %d" % fails)