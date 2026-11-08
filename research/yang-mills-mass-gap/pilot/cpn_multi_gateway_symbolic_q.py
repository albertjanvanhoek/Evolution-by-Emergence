#!/usr/bin/env python3
"""Symbolic-in-q CP two-gateway overlap-order certificate.

Upgrades cpn_multi_gateway_exact_certificate.py from finitely many q
values to ALL real q>=2 (hence all physical integer q>=2), within
the EXACT SAME squarefree finite strand polynomial: n_e in {0,1}.
Uses the q-INDEPENDENT 4,222 diagrams of that script but recomputes
all weights as integer polynomials in q and checks the nonnegative
(q-2)-monomial coefficients of D0, D1, D0+D1+D2.

No floating point, numerical interpolation, random search or external
dependencies. Not a proof for unbounded edge multiplicities or the
full exponential CP Gibbs ensemble.
"""
from collections import defaultdict
from math import comb, prod
from fractions import Fraction
from cpn_multi_gateway_exact_certificate import diagrams, coefficient_arrays

def add(dest,src,sign=1):
    if len(dest)<len(src):
        dest.extend([0]*(len(src)-len(dest)))
    for i,x in enumerate(src):
        dest[i]+=sign*x

def mul(a,b):
    if not any(a) or not any(b):
        return [0]
    r=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        if x:
            for j,y in enumerate(b):
                if y:
                    r[i+j]+=x*y
    return r

def polyproduct(*args):
    out=[1]
    for p in args:
        out=mul(out,p)
    return out

def poch_tail(d,max_degree):
    return polyproduct(*[[j,1] for j in range(d,max_degree)])

def evaluate(poly,q):
    return sum(c*q**j for j,c in enumerate(poly))

def shift_q_minus_2(poly):
    # coefficients of P(2+t), for all t>=0
    ans=[0]*len(poly)
    for j,c in enumerate(poly):
        if c:
            for k in range(j+1):
                ans[k]+=c*comb(j,k)*2**(j-k)
    return ans

def exponent_key(i,j):
    return tuple(((i>>e)&1)+((j>>e)&1) for e in range(7))

def polynomial_weights(records):
    # Common denominator L(q)=(q)_4^2(q)_2 for the free vertices x,y,a.
    # Each weight * L(q) is a polynomial in q with INTEGER coefficients.
    C=[[[0] for _ in range(3)] for _ in range(128)]
    A=[[[0] for _ in range(3)] for _ in range(128)]
    tail4=[poch_tail(d,4) for d in range(5)]
    tail2=[poch_tail(d,2) for d in range(3)]
    for mask,k,loops,event,deg in records:
        dx,dy,da=deg
        poly=polyproduct([0]*loops+[1],tail4[dx],tail4[dy],tail2[da])
        add(C[mask][k],poly)
        if event:
            add(A[mask][k],poly)
    return C,A

def q_polynomial_certificate(C,A):
    D=[defaultdict(lambda:[0]) for _ in range(3)]
    for i in range(128):
        for j in range(128):
            key=exponent_key(i,j)
            # D0=a1 c0-a0 c1
            add(D[0][key],mul(A[i][1],C[j][0]))
            add(D[0][key],mul(A[i][0],C[j][1]),-1)
            # D1=2(a2 c0-a0 c2)
            add(D[1][key],mul(A[i][2],C[j][0]),2)
            add(D[1][key],mul(A[i][0],C[j][2]),-2)
            # D2=a2 c1-a1 c2
            add(D[2][key],mul(A[i][2],C[j][1]))
            add(D[2][key],mul(A[i][1],C[j][2]),-1)
    result=[]
    for name,polys in (
        ("D0",D[0]),("D1",D[1]),("D2",D[2]),
        ("Dsum",{k:add_many(D[0][k],D[1][k],D[2][k])
                 for k in D[0]})):
        shifted={key:shift_q_minus_2(p) for key,p in polys.items()}
        positive=sum(x>0 for p in shifted.values() for x in p)
        negative=sum(x<0 for p in shifted.values() for x in p)
        degree=max((j for p in shifted.values() for j,x in enumerate(p) if x),default=0)
        print(f"{name}: positive joint coefficients={positive}, "
              f"negative={negative}, max (q-2) degree={degree}")
        result.append((name,positive,negative,degree))
    assert result==[
        ("D0",15746,0,16),
        ("D1",3752,0,14),
        ("D2",1210,432,12),
        ("Dsum",15598,0,16)]
    # D(p)=(1-p²)D0+p(1-p)D1+p²(D0+D1+D2).
    # Every coefficient of D0,D1,Dsum in (q-2) and b_e is >=0,
    # so D(p)>=0 for any q>=2, p in [0,1], strengths b_e>=0.
    return result

def add_many(*ps):
    out=[0]
    for p in ps:
        add(out,p)
    return out

def independent_numeric_consistency(records,C,A):
    for q in (2,3,5,8,50):
        regularC,regularA=coefficient_arrays(q,records)
        L=prod(q+j for j in range(4))**2*prod(q+j for j in range(2))
        for mask in range(128):
            for k in range(3):
                assert Fraction(evaluate(C[mask][k],q),L)==regularC[mask][k]
                assert Fraction(evaluate(A[mask][k],q),L)==regularA[mask][k]
    print("Exact q-polynomial vs rational-loop cross-check passed at q=2,3,5,8,50.")

def main():
    records=list(diagrams())
    assert len(records)==4222
    C,A=polynomial_weights(records)
    independent_numeric_consistency(records,C,A)
    q_polynomial_certificate(C,A)
    print("CERTIFIED all real q>=2 for the squarefree seven-edge loop model.")
    print("NOT certified: full exponential CP or arbitrary annuli.")

if __name__=="__main__":
    main()
