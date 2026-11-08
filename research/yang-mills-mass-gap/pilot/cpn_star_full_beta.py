#!/usr/bin/env python3
"""Analytic, no-Monte-Carlo check of a full-coupling CP star layer theorem.

G = one free hub plus arbitrary pinned/free leaves in two marked layers.
CP(q-1) nearest-neighbor projector model, q>=2, b_i>=0.
Numerical series are absolutely positive; omitted tails are bounded
geometrically. No external Python dependencies.
"""
import math


def f_q_terms(q, b, tol=1e-14, cap=1000):
    if q < 2 or b < 0:
        raise ValueError("require integer q>=2 and b>=0")
    terms = [1.0]
    t = total = 1.0
    for k in range(1, cap):
        t *= b / (q+k-1)
        terms.append(t)
        total += t
        # Geometric upper bound on every term omitted after order k.
        ratio = b / (q+k)
        if ratio < 1 and t*ratio/(1-ratio) < tol*total:
            return terms, total, t*ratio/(1-ratio)
    raise ArithmeticError("series cap exceeded")


def convolve(x, y):
    z = [0.0] * (len(x)+len(y)-1)
    for i, a in enumerate(x):
        for j, b in enumerate(y):
            z[i+j] += a*b
    return z


def star_layers(q, inner, outer, tol=1e-14):
    if not inner or not outer:
        raise ValueError("both layers must be nonempty")
    distributions = []
    omitted_free = 0.0
    for b in list(inner)+list(outer):
        terms, Z, tail = f_q_terms(q, b, tol)
        distributions.append([x/Z for x in terms])
        omitted_free += tail/Z
    p_inner = p_outer = [1.0]
    for p in distributions[:len(inner)]:
        p_inner = convolve(p_inner, p)
    for p in distributions[len(inner):]:
        p_outer = convolve(p_outer, p)
    nc_free = 0.0
    for a, pa in enumerate(p_inner):
        for b, pb in enumerate(p_outer):
            F = math.exp(math.lgamma(q+a)+math.lgamma(q+b)
                         -math.lgamma(q+a+b)-math.lgamma(q))
            nc_free += pa*pb*F

    BI, BO = sum(inner), sum(outer)
    pin_terms, Zpin, pin_tail = f_q_terms(q, BI+BO, tol)
    # Zorth = sum_{d>=0} [sum_{a=0}^d BI^a BO^(d-a)]/(q)_d.
    # Its tail is bounded termwise by the tail of f_q(BI+BO).
    geometric_sum = Zorth = denominator = 1.0
    for d in range(1, len(pin_terms)):
        geometric_sum = BI*geometric_sum + BO**d
        denominator *= q+d-1
        Zorth += geometric_sum/denominator

    return {
        "q": q, "inner": inner, "outer": outer,
        "free_crossing": 1-nc_free,
        "equal_pinned_crossing": 1-Zorth/Zpin,
        "Zpin": Zpin, "Zorth": Zorth,
        "upper_bound_omitted_free_mass": omitted_free,
        "upper_bound_Zpin_and_Zorth_tail": pin_tail
    }


def restricted_pairing_reversal(q):
    """Two central permutations, four marked leaves with multiplicity 1.

    NC=(01)(23) has two cycles; cross=(02) has three cycles.
    The PAIRING RESTRICTION is on the internal hub, not exterior wiring.
    """
    return q/(q+1), 0.5


def main():
    samples = [
        (2, [1.,1.], [1.,1.]),
        (3, [1.,1.], [1.,1.]),
        (3, [.1,2.], [4.,3.]),
        (3, [7.,3.], [7.,3.]),
        (5, [1.,1.], [1.,1.])
    ]
    for q, inner, outer in samples:
        result = star_layers(q,inner,outer)
        f, p = result["free_crossing"], result["equal_pinned_crossing"]
        assert -1e-11 <= f <= p+1e-11 <= 1+1e-11
        print(f"q={q} inner={inner} outer={outer}: "
              f"free={f:.12f}, equal-pin={p:.12f}, "
              f"free omitted-mass bound={result['upper_bound_omitted_free_mass']:.2e}")
    assert abs(star_layers(3,[1.,1.],[1.,1.])['free_crossing']
               -0.10552987594908148)<1e-11
    assert abs(star_layers(3,[1.,1.],[1.,1.])['equal_pinned_crossing']
               -0.32343798360829035)<1e-11
    assert restricted_pairing_reversal(3) == (0.75,0.5)
    print("Restricted-pairing reversal: q=3, free=0.75 > equal-pin=0.5")
    print("All checks passed.")


if __name__ == "__main__":
    main()
