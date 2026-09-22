#!/usr/bin/env python3
"""Finite checks for the repetition-depth sufficient condition.

This is an adversarial algebra/check script, not a proof assistant result.
It verifies the threshold identity and exhaustive subset optima for the
declared additive toy objective used in theorem-notes/README.md.
"""

from itertools import product
import math
import random


def gain(n: int, c: float, r: float, h: float) -> float:
    """Saving from retaining one repeated module."""
    return (n - 1) * c - n * r - h


def threshold(c: float, r: float, h: float) -> int:
    if not c > r >= 0 or h < 0:
        raise ValueError("require c > r >= 0 and h >= 0")
    return math.floor((c + h) / (c - r)) + 1


def objective(bits, ns, cs, rs, hs):
    """Separable additive specialization: baseline minus retained savings."""
    baseline = sum(n * c for n, c in zip(ns, cs))
    saving = sum(
        gain(n, c, r, h)
        for keep, n, c, r, h in zip(bits, ns, cs, rs, hs)
        if keep
    )
    return baseline - saving


def exhaustive_unique_full_optimum(ns, cs, rs, hs):
    k = len(ns)
    scores = []
    for bits in product([False, True], repeat=k):
        scores.append((objective(bits, ns, cs, rs, hs), bits))
    scores.sort()
    best_value = scores[0][0]
    best = [bits for value, bits in scores if abs(value - best_value) < 1e-10]
    return best == [tuple([True] * k)]


def main():
    # Identity of the threshold formula.
    rng = random.Random(20260922)
    for _ in range(10_000):
        c = rng.uniform(0.1, 20.0)
        r = rng.uniform(0.0, c - 1e-8)
        h = rng.uniform(0.0, 20.0)
        n = rng.randint(1, 50)
        lhs = gain(n, c, r, h) > 0
        rhs = n > (c + h) / (c - r)
        assert lhs == rhs

    # Arbitrary finite depths: when each level clears its strict threshold,
    # exhaustive enumeration must select the full retained chain uniquely.
    for k in range(1, 9):
        for _ in range(250):
            cs, rs, hs, ns = [], [], [], []
            for _level in range(k):
                c = rng.uniform(1.0, 12.0)
                r = rng.uniform(0.0, 0.8 * c)
                h = rng.uniform(0.0, 5.0)
                nstar = threshold(c, r, h)
                n = nstar + rng.randint(0, 5)
                assert gain(n, c, r, h) > 0
                cs.append(c); rs.append(r); hs.append(h); ns.append(n)
            assert exhaustive_unique_full_optimum(ns, cs, rs, hs)

    print("PASS: repetition threshold and finite-depth exhaustive checks")


if __name__ == "__main__":
    main()
