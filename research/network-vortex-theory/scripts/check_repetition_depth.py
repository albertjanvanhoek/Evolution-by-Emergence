#!/usr/bin/env python3
"""Finite checks for the repetition-depth sufficient condition.

This is an adversarial algebra/check script, not a proof assistant result.
It checks:
1. the exact repetition threshold;
2. the monotone worst-case argument used in the theorem notes;
3. all parent-retention patterns in an explicit laminar chain satisfy the
   declared lower bound on exposed occurrences;
4. the separable worst-case lower-bound objective has the full dictionary
   as its unique optimum when every level clears the strict threshold.
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


def exposed_occurrences(ns, retained, i):
    """Occurrences of level i before it is retained in a laminar chain.

    ns[i] is the minimum number of level-i occurrences inside its immediate
    retained parent; the final ns entry is the external repetition count for
    the top level. Moving upward, multiplication stops at the nearest already
    retained ancestor because only one stored definition of that ancestor
    needs to be represented.
    """
    n = ns[i]
    for j in range(i + 1, len(ns)):
        if retained[j]:
            break
        n *= ns[j]
    return n


def objective(bits, ns, cs, rs, hs):
    """Separable worst-case lower-bound objective.

    This is deliberately not the full recursive construction model. It uses
    the minimum occurrence and inline-cost bounds from the theorem, so if the
    full retained set is uniquely optimal here, the theorem's marginal
    inequality is being checked in its hardest declared case.
    """
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
    best_value = min(value for value, _ in scores)
    best = [bits for value, bits in scores if abs(value - best_value) < 1e-10]
    return best == [tuple([True] * k)]


def main():
    rng = random.Random(20260922)

    # Exact threshold identity.
    for _ in range(10_000):
        c = rng.uniform(0.1, 20.0)
        r = rng.uniform(0.0, c - 1e-8)
        h = rng.uniform(0.0, 20.0)
        n = rng.randint(1, 50)
        assert (gain(n, c, r, h) > 0) == (n > (c + h) / (c - r))

    # Worst-case monotonicity used by RD1:
    # if the minimum n and minimum c clear the threshold, every admissible
    # larger exposed count and larger inline cost must also clear it.
    for _ in range(10_000):
        cmin = rng.uniform(0.5, 20.0)
        r = rng.uniform(0.0, 0.95 * cmin)
        h = rng.uniform(0.0, 10.0)
        nmin = threshold(cmin, r, h)
        gmin = gain(nmin, cmin, r, h)
        assert gmin > 0

        n = nmin + rng.randint(0, 25)
        c = cmin + rng.uniform(0.0, 20.0)
        assert gain(n, c, r, h) >= gmin - 1e-10

    # Explicit laminar parent-retention patterns never expose fewer than the
    # immediate repetition count n_i.
    for k in range(1, 8):
        ns = [rng.randint(2, 5) for _ in range(k)]
        for retained in product([False, True], repeat=k):
            for i in range(k):
                if retained[i]:
                    continue
                assert exposed_occurrences(ns, retained, i) >= ns[i]

    # Arbitrary finite depths under the theorem's worst-case lower bounds.
    for k in range(1, 9):
        for _ in range(250):
            cs, rs, hs, ns = [], [], [], []
            for _level in range(k):
                c = rng.uniform(1.0, 12.0)
                r = rng.uniform(0.0, 0.8 * c)
                h = rng.uniform(0.0, 5.0)
                n = threshold(c, r, h) + rng.randint(0, 5)
                assert gain(n, c, r, h) > 0
                cs.append(c)
                rs.append(r)
                hs.append(h)
                ns.append(n)
            assert exhaustive_unique_full_optimum(ns, cs, rs, hs)

    print("PASS: repetition-depth threshold, monotonicity, laminar exposure, and finite optima")


if __name__ == "__main__":
    main()
