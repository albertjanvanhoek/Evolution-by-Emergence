#!/usr/bin/env python3
"""Check the single-use / repeated-use chain dichotomy.

For nonnegative reference and upkeep costs, a module used once cannot
pay for itself purely as an additive representational scaffold.
Repeated use can cross a calculable threshold.
"""

import math


def saving(n: int, c: float, r: float, h: float) -> float:
    return (n - 1) * c - n * r - h


def min_repetitions(c: float, r: float, h: float) -> int:
    if not c > r >= 0 or h < 0:
        raise ValueError("require c > r >= 0 and h >= 0")
    return math.floor((c + h) / (c - r)) + 1


def main():
    grid_c = [1.0, 2.0, 5.0, 10.0]
    grid_h = [0.0, 0.2, 1.0, 3.0]

    for c in grid_c:
        for r_frac in [0.0, 0.1, 0.3, 0.6, 0.9]:
            r = r_frac * c
            for h in grid_h:
                # Single-use no-go.
                assert saving(1, c, r, h) <= 0

                # Exact integer threshold.
                nstar = min_repetitions(c, r, h)
                assert saving(nstar, c, r, h) > 0
                if nstar > 1:
                    assert saving(nstar - 1, c, r, h) <= 0

    print("PASS: n=1 never gives a pure additive scaffold; repetition threshold exact")


if __name__ == "__main__":
    main()
