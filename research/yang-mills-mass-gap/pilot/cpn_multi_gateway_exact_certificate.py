#!/usr/bin/env python3
"""Exact coefficient certificate for a TWO-GATEWAY CP loop polynomial.

Graph: separately pinned 0=u, 1=v; free 2=x, 3=y, outer marked
free 4=a. Seven edges: u-x,v-x,u-y,v-y,x-a,y-a,x-y.
The event is a direct root-group -> a excursion after cutting
the marked sites 0,1,4. All free local index pairings are summed.

IMPORTANT SCOPE: each base edge permits ONLY 0 or 1 strand.
The positive finite Taylor polynomial measure is NOT the complete
exponential CP model. For q=2,3,5,8 the script gives an exact
rational, coefficient-by-coefficient sign certificate for
d/dp[A(p)/Z(p)] >= 0 for EVERY set of nonnegative edge strengths.
It also gives a counterexample to monotonicity of a_k/c_k.
No random numbers, floats, Monte Carlo, or external packages.
"""
from collections import defaultdict
from fractions import Fraction as F
from functools import lru_cache
from itertools import permutations, product
from math import prod

EDGES=((0,2),(1,2),(0,3),(1,3),(2,4),(3,4),(2,3))
PINS=(0,1)
MARKED=(0,1,4)
FREE=(2,3,4)
N=5
POWER=3**len(EDGES)

@lru_cache(None)
def perms(d):
    return tuple(permutations(range(d)))

def rising(q,d):
    return prod(range(q,q+d))

def diagrams():
    """Precompute (edge mask, K, free-loop count, event, free degrees).
    Only q-independent combinatorics appears here.
    """
    for mask in range(1<<len(EDGES)):
        slots=[[] for _ in range(N)]
        where=[];twin=[]
        for i,(u,v) in enumerate(EDGES):
            if (mask>>i)&1:
                h=len(twin)
                twin.extend((h+1,h))
                where.extend((u,v))
                slots[u].append(h)
                slots[v].append(h+1)
        degree=tuple(len(slots[v]) for v in FREE)
        options=[perms(len(slots[v])) if v in FREE
                 else (tuple(range(len(slots[v]))),)
                 for v in range(N)]
        for pi in product(*options):
            nxt=[0]*len(twin)
            for v,hs in enumerate(slots):
                for j,h in enumerate(hs):
                    nxt[h]=twin[hs[pi[v][j]]]
            seen=set()
            K=free_loops=0
            for h in range(len(nxt)):
                if h in seen:
                    continue
                cur=h
                word=[]
                while cur not in seen:
                    seen.add(cur)
                    if where[cur] in PINS:
                        word.append(where[cur])
                    cur=nxt[cur]
                if word:
                    K+=sum(word[j]!=word[j-1]
                           for j in range(len(word)))//2
                else:
                    free_loops+=1
            event=False
            for v in PINS:
                for h in slots[v]:
                    cur=twin[h]
                    while where[cur] not in MARKED:
                        cur=nxt[cur]
                    if where[cur]==4:
                        event=True
                        break
                if event:break
            yield mask,K,free_loops,event,degree

def coefficient_arrays(q,records):
    C=[[F(0) for _ in range(3)] for _ in range(128)]
    A=[[F(0) for _ in range(3)] for _ in range(128)]
    for mask,k,free,hit,degrees in records:
        assert 0<=k<=2
        denominator=prod(rising(q,d) for d in degrees)
        weight=F(q**free,denominator)
        C[mask][k]+=weight
        if hit:A[mask][k]+=weight
    return C,A

def monomial_key(i,j):
    return sum((((i>>b)&1)+((j>>b)&1))*3**b
               for b in range(len(EDGES)))

def coefficient_certificate(C,A):
    # Every index is a monomial in the seven edge couplings with
    # exponent 0,1, or 2, encoded in base 3.
    D0=defaultdict(F)
    D1=defaultdict(F)
    D2=defaultdict(F)
    for i in range(len(C)):
        for j in range(len(C)):
            key=monomial_key(i,j)
            D0[key]+=A[i][1]*C[j][0]-A[i][0]*C[j][1]
            D1[key]+=2*(A[i][2]*C[j][0]-A[i][0]*C[j][2])
            D2[key]+=A[i][2]*C[j][1]-A[i][1]*C[j][2]
    # Since
    # D(p) = (1-p^2)*D0 + (p-p^2)*D1 + p^2*(D0+D1+D2),
    # all factors are >=0 on 0<=p<=1 if these three
    # coefficient polynomials are nonnegative.
    Dsum={k:D0[k]+D1[k]+D2[k] for k in D0.keys()}
    for name,poly in (("D0",D0),("D1",D1),("Dsum",Dsum)):
        negatives=[(k,v) for k,v in poly.items() if v<0]
        assert not negatives,(name,negatives[:3])
    return {
        "nonzero_D0":sum(x>0 for x in D0.values()),
        "nonzero_D1":sum(x>0 for x in D1.values()),
        "nonzero_Dsum":sum(x>0 for x in Dsum.values()),
        "negative_D2":sum(x<0 for x in D2.values()),
    }

def evaluate(C,A,weights):
    assert all(isinstance(x,F) for x in weights)
    Z=[F(0)]*3;B=[F(0)]*3
    for mask in range(128):
        mon=prod(weights[i] for i in range(7) if (mask>>i)&1)
        for k in range(3):
            Z[k]+=C[mask][k]*mon
            B[k]+=A[mask][k]*mon
    ratios=[B[k]/Z[k] for k in range(3)]
    D0=B[1]*Z[0]-B[0]*Z[1]
    D1=2*(B[2]*Z[0]-B[0]*Z[2])
    D2=B[2]*Z[1]-B[1]*Z[2]
    return Z,B,ratios,(D0,D1,D2)

def main():
    records=list(diagrams())
    print("Fixed-multiplicity loop diagrams:",len(records))
    assert len(records)==4222
    for q in (2,3,5,8):
        C,A=coefficient_arrays(q,records)
        result=coefficient_certificate(C,A)
        print("q=",q,"certificate:",result)

    C,A=coefficient_arrays(3,records)
    weights=(F(1,8),F(8),F(8),F(1,8),
             F(8),F(8),F(1,4))
    Z,B,ratios,D=evaluate(C,A,weights)
    assert Z==[
        F(5206485343,24883200),
        F(346063027,24883200),
        F(40207,388800)]
    assert B==[
        F(2070859,38880),
        F(11589679,1555200),
        F(319,6075)]
    assert ratios==[
        F(1325349760,5206485343),
        F(185434864,346063027),
        F(20416,40207)]
    assert ratios[2]<ratios[1]
    assert D[0]>0 and D[1]>0 and D[2]<0 and sum(D)>0
    print("Exact CP² witness edge strengths:",weights)
    print("Z coefficients:",Z)
    print("A coefficients:",B)
    print("r_K:",ratios,"decimal:",[round(float(x),9) for x in ratios])
    print("h' numerator D0,D1,D2:",D)
    print("CERTIFIED: r2<r1 but h'(p)>0 for all 0<=p<=1.")
    print("WARNING: only the squarefree finite Taylor polynomial model.")

if __name__=="__main__":
    main()
