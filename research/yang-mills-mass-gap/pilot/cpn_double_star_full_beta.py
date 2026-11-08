#!/usr/bin/env python3
"""CP^(q-1) double-star 2-region fusion, COMPLETE exponential interaction.

Standard library only. Evaluates convergent positive series for the
one-sided pinned overlap p and deterministic Simpson integration in p.
This is a NUMERIC CROSS-CHECK of CPN_DOUBLE_STAR_FUSION_THEOREM.md;
the analytic monotone-likelihood-ratio proof is in that document.

Graph: u,v are two sites on a shared marked separator. The left and
right sides each have a distinct free hub x and one distinct free
marked exterior leaf a. All three edges per side have nonnegative
strength; a variable edge t connects u and v within their layer.
E = (a_left -> {u,v} excursion) AND (a_right -> {u,v} excursion).
"""
from math import sqrt, exp


def f_s(s, b, atol=1e-16):
    """Series f_s(b)=sum_{m>=0} b^m/(s)_m, no factorial in numerator."""
    if s < 2 or b < 0:
        raise ValueError("s>=2, b>=0")
    w = total = 1.0
    for j in range(1, 300):
        w *= b/(s+j-1)
        total += w
        if j > b+10 and w < atol*total:
            return total
    raise ArithmeticError("f_s did not converge")


def side_partition(q, p, b_a=1.0, b_u=1.0, b_v=1.0, atol=1e-16):
    """Return Z_side(p), A_side(p), and h_side(p)=A/Z.

    H_d is the complete homogeneous degree-d polynomial of two
    nonnegative eigenvalues of M=b_u P_u+b_v P_v.
    Recurrence H_(d+1) = s*H_d - delta*H_(d-1),
    s=b_u+b_v, delta=b_u*b_v*(1-p).
    """
    if q < 2 or not 0 <= p <= 1 or min(b_a,b_u,b_v)<0:
        raise ValueError("invalid CP dimension, overlap, or couplings")
    s=b_u+b_v
    delta=b_u*b_v*(1-p)
    hprev,hcurr=1.0,s
    denom=1.0
    G=NC=0.0
    for d in range(300):
        if d==0:
            hd=1.0
        elif d==1:
            hd=s
        else:
            hnext=s*hcurr-delta*hprev
            hprev,hcurr=hcurr,hnext
            hd=hnext
        if d:
            denom *= q+d-1
        wd=max(0.0,hd/denom)  # avoid a possible machine-precision negative
        G += wd
        NC += wd*f_s(q+d,b_a)
        if d>max(20,s+10) and wd<atol*G:
            break
    else:
        raise ArithmeticError("rank-two partition series did not converge")
    Z=f_s(q,b_a)*G
    A=Z-NC
    return Z,A,A/Z


def simpson(f, n=1024):
    if n%2:
        raise ValueError("n must be even")
    h=1.0/n
    acc=f(0)+f(1)
    for i in range(1,n):
        acc+=(4 if i%2 else 2)*f(i*h)
    return acc*h/3


def double_star_probability(q, t, left=(1,1,1), right=(1,1,1),
                            n=1024):
    """Left/right triples are (b_a, b_u, b_v)."""
    def kernel(p, event):
        zl,al,_=side_partition(q,p,*left)
        zr,ar,_=side_partition(q,p,*right)
        rho=q-1
        weight=rho*(1-p)**(q-2)*exp(t*p)
        return weight*(al*ar if event else zl*zr)
    numerator=simpson(lambda p:kernel(p,True),n)
    denominator=simpson(lambda p:kernel(p,False),n)
    return numerator/denominator


def verify():
    q=3
    print("One-sided conditional crossing, q=3, all b=1:")
    last=-1.
    for p in (0,.1,.25,.5,.75,1):
        z,a,h=side_partition(q,p)
        assert h>=last-1e-12
        print(f"  p={p:4g} Z={z:.12f} A={a:.12f} h={h:.12f}")
        last=h
    assert abs(side_partition(q,0)[2]-.05389440441133331)<1e-12
    assert abs(side_partition(q,1)[2]-.06346765067827254)<1e-12
    print("\nTwo-region joint crossing P_t, COMPLETE CP^2 action:")
    prev=-1
    for t in (0,.5,1,2,4,8):
        pt=double_star_probability(q,t,n=1024)
        check=double_star_probability(q,t,n=2048)
        assert abs(pt-check)<1e-10
        assert pt>prev
        print(f"  t={t:4g} P={check:.12f} "
              f"|P1024-P2048|={abs(pt-check):.3g}")
        prev=check
    fused=side_partition(q,1)[2]**2
    print("  t=infinity P_fused=",format(fused,'.12f'))
    assert abs(fused-0.004028142682619229)<1e-12
    assert prev<fused
    for q in (2,3,5,8):
        for bs in ((1,.5,2.),(.1,2,4),(3,3,3)):
            vals=[side_partition(q,i/10,*bs)[2] for i in range(11)]
            assert all(a<=b+1e-12 for a,b in zip(vals, vals[1:]))
    print("All analytic-series and deterministic-integration checks passed.")
    print("Proof of monotonicity is algebraic, NOT based on this grid.")


if __name__=="__main__":
    verify()
