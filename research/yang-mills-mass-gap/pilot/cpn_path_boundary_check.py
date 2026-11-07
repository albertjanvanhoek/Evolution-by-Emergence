#!/usr/bin/env python3
"""Exact, dependency-free checks for CPN_BOUNDARY_COMPARISON.md.

Finite CP^(q-1) PROJECTOR action exp(sum b_e tr(P_u P_v)); q>=2.
Graph: A -- x -- B. All values are analytic integrals/absolutely
convergent power series; there is NO Monte Carlo sampling.

Checks:
  - free vs equally pinned oriented-index-loop crossing,
  - exact two-point adjoint correlation and new crossing upper bound,
  - an explicitly negative 3-pinned-projector loop trace.

Usage: python3 cpn_path_boundary_check.py
"""
from __future__ import annotations

import math


def f_and_derivative(q: int, b: float, tol=1e-15, max_terms=500):
    """f_q(b)=E[e^(b S)], S~Beta(1,q-1); series sum b^k/(q)_k."""
    if q < 2 or b < 0:
        raise ValueError("require q>=2 and b>=0")
    term, dterm = 1.0, 0.0
    total, deriv = 1.0, 0.0
    for k in range(1, max_terms + 1):
        term, dterm = term * b / (q + k - 1), (
            dterm * b + term
        ) / (q + k - 1)
        total += term
        deriv += dterm
        if term < tol * total and k > b + 5:
            return total, deriv
    raise ArithmeticError("f_q series did not converge")


def z_orth(q: int, b1: float, b2: float, tol=1e-15, max_terms=500):
    """E[e^(b1 |z1|^2+b2 |z2|^2)] = sum b1^m b2^n/(q)_(m+n)."""
    if q < 2 or min(b1, b2) < 0:
        raise ValueError("require q>=2 and nonnegative couplings")
    total, poch = 0.0, 1.0
    for d in range(max_terms):
        s = sum(b1 ** m * b2 ** (d-m) for m in range(d+1))
        contribution = s / poch
        total += contribution
        if d > b1+b2+5 and abs(contribution) < tol * total:
            return total
        poch *= q+d
    raise ArithmeticError("orthogonal-boundary series did not converge")


def path_values(q: int, b1: float, b2: float):
    f1, fp1 = f_and_derivative(q, b1)
    f2, fp2 = f_and_derivative(q, b2)
    fsame, _ = f_and_derivative(q, b1+b2)
    orth = z_orth(q, b1, b2)
    free = f1*f2
    eps_free = 1-orth/free
    eps_pin = 1-orth/fsame
    lam1 = (q*fp1/f1 - 1)/(q-1)
    lam2 = (q*fp2/f2 - 1)/(q-1)
    corr = (q-1)/q * lam1 * lam2
    bound = (q-1)/(q*q*(q+1)) * eps_pin/(1-eps_pin)
    assert -1e-12 <= eps_free <= eps_pin + 1e-12 <= 1+1e-12
    assert -1e-12 <= corr <= bound + 1e-12
    return {
        "q": q, "b1": b1, "b2": b2, "Zfree": free,
        "Zpin": fsame, "Znocross": orth,
        "free_cross": eps_free, "equal_pinned_cross": eps_pin,
        "free_connected_projector_correlation": corr,
        "two_pin_crossing_upper_bound": bound,
    }


def three_pin_star_negative_trace():
    # Re(Pu Pv Pw)=<u,v><v,w><w,u>; vectors are real
    u = (1.0, 0.0, 0.0)
    v = (1/math.sqrt(2), 1/math.sqrt(2), 0.0)
    w = (1/math.sqrt(5), -2/math.sqrt(5), 0.0)
    dot = lambda a, b: sum(x*y for x,y in zip(a,b))
    trace = dot(u,v)*dot(v,w)*dot(w,u)
    assert abs(trace + .1) < 1e-14
    return trace


if __name__ == "__main__":
    print("Exact comparison on the path A--x--B")
    for q,b in [(2,.25),(3,.25),(3,1.0),(3,2.0),(3,4.0),(4,1.0)]:
        r=path_values(q,b,b)
        print(f"q={q}, b={b:g}: P_free_cross={r['free_cross']:.10f}, "
              f"P_equal_pin_cross={r['equal_pinned_cross']:.10f}, "
              f"C_AB={r['free_connected_projector_correlation']:.10f}, "
              f"bound={r['two_pin_crossing_upper_bound']:.10f}")
    target=path_values(3,1.0,1.0)
    assert abs(target["Znocross"]-2.0)<1e-12
    assert abs(target["free_cross"]-0.030873999580296)<1e-10
    assert abs(target["equal_pinned_cross"]-0.088642316288789)<1e-10
    assert abs(target["free_connected_projector_correlation"]-0.005199903216447)<1e-10
    print("Three distinct pins on star: Tr(Pu Pv Pw) =",three_pin_star_negative_trace())
    print("All checks passed.")
