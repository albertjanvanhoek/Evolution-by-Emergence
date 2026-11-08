#!/usr/bin/env python3
"""Independent analytic checks for CP overlap-association counterexample and
all-coupling two-site CUT fusion lemma. Python stdlib only; no Monte Carlo.
The finite numerical quadrature checks a theorem; it is not its proof.
"""
from fractions import Fraction
from math import exp, expm1, sqrt


def exact_association(q):
    if q < 2:
        raise ValueError("q>=2 required")
    mu = Fraction(1, q)
    second = Fraction(2, q*(q+1))
    var = second-mu*mu
    exyz = (q*second**2-2*mu*second+mu*mu)/(q-1)
    cov_xy_z = exyz-mu**3
    cov_smooth_z = -cov_xy_z
    assert cov_smooth_z == -Fraction(q-1, q**3*(q+1)**2)
    cov_or_z = -Fraction(q-1,q)**(2*q)/Fraction(q*(q-1))
    return exyz, cov_smooth_z, cov_or_z


def simpson(fun, n=200):
    assert n % 2 == 0
    step=1.0/n
    total=fun(0.0)+fun(1.0)
    for j in range(1,n):
        total += (4 if j%2 else 2)*fun(j*step)
    return total*step/3


def g_cp2(p, b=1.0, c=1.0):
    """Fubini-Study integral of exp(b|<z1,z>|^2+c|<z3,z>|^2)
    at fixed p=|<z1,z3>|^2 for q=3, via rank-two eigenvalues.
    Dirichlet(1,1,1) reduces to a 2D triangle integral.
    """
    disc=sqrt((b-c)**2+4*b*c*p)
    lp=(b+c+disc)/2
    lm=(b+c-disc)/2
    def inner(s):
        a=1-s
        if abs(lm*a)<1e-7:
            return 2*exp(lp*s)*a*(1+lm*a/2+lm*lm*a*a/6)
        return 2*exp(lp*s)*expm1(lm*a)/lm
    return simpson(inner,160)


def triangle_cross(t, b=1.0, c=1.0):
    den=simpson(lambda p: 2*(1-p)*exp(t*p)*g_cp2(p,b,c),200)
    num=simpson(lambda p: 2*(1-p)*exp(t*p),200)
    return 1-num/den


def main():
    print("Exact independent Beta/projector moments:")
    for q in (2,3,4,5):
        exyz,cov,step=exact_association(q)
        print(f"q={q}: E[XYZ]={exyz}, Cov(X+Y-XY,Z)={cov}, "
              f"Cov(OR-threshold,Z)={step}")
    assert exact_association(3)[1] == Fraction(-1,216)
    print("\nCP^2 triangle, b=c=1, full exponential action:")
    last=-1
    for t in (0.0,.5,1.0,2.0,4.0,8.0):
        p=triangle_cross(t)
        assert p>=last
        print(f"t={t:3g}: P(occupied cut)={p:.9f}")
        last=p
    fused=1-2/(exp(2)-3)
    print("t -> infinity (analytic fused value):",round(fused,12))
    assert last<fused
    assert abs(triangle_cross(0)-.515436999790148)<1e-8
    assert abs(triangle_cross(4)-.5264464719909425)<1e-8
    print("All analytic-moment and deterministic-quadrature checks passed.")


if __name__=="__main__":
    main()
