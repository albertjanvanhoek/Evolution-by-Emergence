#!/usr/bin/env python3
"""Exact CP two-pin coefficient tests: true separator vs bypass.

Run from this directory:
  python3 cpn_separator_ratio_check.py
  python3 cpn_separator_ratio_check.py --scan --trials 200

All partition coefficients are exact fractions computed by the existing
cpn_fusion_overlap_coeff.py loop enumerator. Each BASE EDGE is truncated
to multiplicity 0 or 1; therefore this does NOT prove anything about
the untruncated exponential Gibbs measure. The fusion parameter t is
omitted from the base diagrams and later enters via e^(t p).
"""
from fractions import Fraction as F
from itertools import combinations
import argparse
import random

from cpn_fusion_overlap_coeff import pinned_coefficients


def get(n, edges, layers, q=3, K=1):
    c,a,terms=pinned_coefficients(q,n,edges,layers,(1,2),K=K,cap=30000)
    ratios={k:a.get(k,F(0))/v for k,v in sorted(c.items()) if v}
    return dict(c),dict(a),ratios,terms


def convolution(a,b):
    out={}
    for j,x in a.items():
        for k,y in b.items():
            out[j+k]=out.get(j+k,F(0))+x*y
    return out


def exact_examples():
    # True middle-layer separator, left and right free hubs.
    left=[(0,4,1),(4,1,1),(4,2,1)]
    right=[(1,5,1),(2,5,1),(5,3,1)]
    cL,aL,rL,_=get(6,left,[{0},{1,2}])
    cR,aR,rR,_=get(6,right,[{1,2},{3}])
    c,a,r,_=get(6,left+right,[{0},{1,2},{3}])
    assert cL==cR=={0:F(7,3),1:F(1,9)}
    assert aL==aR=={0:F(1,15),1:F(1,90)}
    assert c==convolution(cL,cR)
    assert a==convolution(aL,aR)
    assert r=={0:F(1,1225),1:F(1,350),2:F(1,100)}
    print("TRUE SEPARATOR")
    print("  left coefficients:",cL,aL,"conditional ratios:",rL)
    print("  right coefficients:",cR,aR,"conditional ratios:",rR)
    print("  full c_k:",c,"a_k:",a,"r_k:",r)
    print("  exact factorization and ratio ordering PASS")

    # This graph has a forbidden (0,3) bypass of the middle layer {1,2}.
    bypass=[
        (2,4,F(1,10)),(1,4,1),(0,1,F(1,50)),
        (0,3,8),(3,4,F(1,10)),(0,2,2)]
    c,a,r,terms=get(5,bypass,[{0},{1,2},{3}])
    assert terms==377
    assert c=={
        0:F(235837823,27000000),
        1:F(240589,3375000),
        2:F(2843,27000000)}
    assert a=={
        0:F(68611,9000000),
        1:F(34967,27000000),
        2:F(19,13500000)}
    assert r[0] < r[1] and r[2] < r[1]
    c0,c1,c2=[c[j] for j in range(3)]
    a0,a1,a2=[a[j] for j in range(3)]
    D=(a1*c0-a0*c1,
       2*(a2*c0-a0*c2),
       a2*c1-a1*c2)
    assert D[0] > 0 and D[1]>0 and D[2]<0 and D[0] > -D[2]
    print("NON-SEPARATOR COUNTEREXAMPLE (finite Taylor model)")
    print("  c_k:",c,"a_k:",a)
    print("  r_k:",r,"float:",{k:float(v) for k,v in r.items()})
    print("  derivative numerator D0+D1*p+D2*p^2:",D)
    print("  r2<r1, but h'(p)>0 for all 0<=p<=1: PASS")


ALLOWED_SEPARATOR_EDGES=[
  (0,4),(0,1),(0,2),(4,1),(4,2),
  (1,5),(2,5),(5,3),(1,3),(2,3)
]

def scan(trials):
    # Deterministic FALSIFICATION screen with strict left/middle/right separation.
    # This does not prove nondecreasing r_k in the full model.
    rng=random.Random(202611071)
    for q in (2,3,5):
        valid=multik=nonmonotone=skipped=0
        worst=None
        for _ in range(trials):
            k=rng.choice((5,6,7,8))
            edges=rng.sample(ALLOWED_SEPARATOR_EDGES,k)
            weighted=[(u,v,rng.choice((F(1,50),F(1,10),
                     F(1,2),F(1),F(2),F(8)))) for u,v in edges]
            try:
                c,a,ratios,_=pinned_coefficients(
                    q,6,weighted,[{0},{1,2},{3}],(1,2),K=1,cap=9000)
            except RuntimeError:
                skipped+=1
                continue
            rs=[a.get(i,F(0))/c[i] for i in sorted(c) if c[i]]
            if len(rs)<2 or max(rs)==0:
                continue
            valid+=1
            if len(rs)>2:
                multik+=1
            differences=[x-y for x,y in zip(rs[1:],rs[:-1])]
            if worst is None or min(differences)<worst[0]:
                worst=(min(differences),weighted,rs)
            if any(d<0 for d in differences):
                nonmonotone+=1
                print("FOUND exact finite polynomial counterexample:",weighted,rs)
                break
        print(f"q={q}: {valid} nontrivial trials; K>=2 in {multik}; "
              f"skipped complexity {skipped}; counterexamples {nonmonotone}")
        if nonmonotone:
            break


if __name__=="__main__":
    parser=argparse.ArgumentParser()
    parser.add_argument("--scan",action="store_true")
    parser.add_argument("--trials",type=int,default=200)
    args=parser.parse_args()
    exact_examples()
    if args.scan:
        scan(args.trials)
