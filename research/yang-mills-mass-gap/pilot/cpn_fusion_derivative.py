#!/usr/bin/env python3
"""Controlled finite-Taylor CP projector loop fusion checks.

Evaluate P_t(E) and dP_t(E)/dt at t=0 after introducing one
intra-layer edge, using every oriented index-loop pairing exactly.
Base edges are independently truncated at k<=K; the added edge
is kept at k=0,1,2 depending on max_t_count. NOT exact probabilities
for the untruncated exponential CP Gibbs ensemble.
No third-party packages.
"""
from fractions import Fraction
from functools import lru_cache
from itertools import permutations, product, combinations
from math import factorial, prod
import random

@lru_cache(None)
def perms(d):
    return tuple(permutations(range(d)))

@lru_cache(None)
def poch(q, d):
    return prod(range(q, q+d))

def coefficients(q, n, edges, layers, t_edge, K=1, max_t_count=1, exact=False):
    """Coefficients of t^j in Z(t) and its excursion-event numerator.

    edges: triples (u,v,b), nonnegative coupling b.
    Event E: each pair of consecutive marked layers is connected
    by a strand excursion with no other marked site internally.
    """
    assert q >= 2 and K >= 0
    marked = set().union(*(set(layer) for layer in layers))
    layerid = {v:j for j,layer in enumerate(layers) for v in layer}
    assert set(t_edge).issubset(marked)
    assert layerid[t_edge[0]] == layerid[t_edge[1]]
    assert sum(map(len, layers)) == len(marked)
    result = []
    for kt in range(max_t_count+1):
        Z = Fraction(0) if exact else 0.0
        A = Fraction(0) if exact else 0.0
        for k_other in product(range(K+1), repeat=len(edges)):
            ks = k_other+(kt,)
            all_edges = list(edges)+[(t_edge[0],t_edge[1],1)]
            slots = [[] for _ in range(n)]
            twin = []
            factor = Fraction(1) if exact else 1.0
            for (u,v,b),k in zip(all_edges, ks):
                if exact:
                    factor *= Fraction(str(b))**k/factorial(k)
                else:
                    factor *= b**k/factorial(k)
                for _ in range(k):
                    h = len(twin)
                    twin.extend((h+1,h))
                    slots[u].append(h)
                    slots[v].append(h+1)
            if not factor:
                continue
            deg = [len(s) for s in slots]
            base = factor/prod(poch(q,d) for d in deg)
            where = [0]*len(twin)
            for v,hs in enumerate(slots):
                for h in hs:
                    where[h] = v
            for pp in product(*(perms(d) for d in deg)):
                succ = [None]*len(twin)
                for v,hs in enumerate(slots):
                    for j,pj in enumerate(pp[v]):
                        succ[hs[j]] = twin[hs[pj]]
                seen = set()
                nloops = 0
                for h in range(len(twin)):
                    if h in seen:
                        continue
                    nloops += 1
                    cur = h
                    while cur not in seen:
                        seen.add(cur)
                        cur = succ[cur]
                connected = set()
                for v in marked:
                    for h in slots[v]:
                        cur = twin[h]
                        while where[cur] not in marked:
                            cur = succ[cur]
                        i,j = layerid[v], layerid[where[cur]]
                        if i != j:
                            connected.add(tuple(sorted((i,j))))
                event = all((j,j+1) in connected for j in range(len(layers)-1))
                weight = base*q**nloops
                Z += weight
                if event:
                    A += weight
        result.append((Z,A))
    return result

def p_and_derivative(coeffs, t=0):
    Z = sum(z*t**j for j,(z,a) in enumerate(coeffs))
    A = sum(a*t**j for j,(z,a) in enumerate(coeffs))
    Zp = sum(j*z*t**(j-1) for j,(z,a) in enumerate(coeffs) if j)
    Ap = sum(j*a*t**(j-1) for j,(z,a) in enumerate(coeffs) if j)
    return A/Z, (Ap*Z-A*Zp)/Z**2

TWO_HUB = (
    5, [(0,3,1),(1,3,1),(3,4,1),(4,2,1)],
    [{0,1},{2}], (0,1)
)
THREE_LAYER = (
    5, [(0,4,1),(1,4,1),(2,4,1),(3,4,1)],
    [{0},{1,2},{3}], (1,2)
)

def random_scan(layers, t_edge, seed, trials, q_choices=(2,3,5,8)):
    rng = random.Random(seed)
    marked = set().union(*layers)
    negatives = []
    nontrivial = 0
    for trial in range(trials):
        n = rng.choice([5,6])
        possible = [
            e for e in combinations(range(n),2)
            if e != t_edge and not(e[0] in marked and e[1] in marked)
        ]
        size = rng.randrange(4,min(7,len(possible))+1)
        chosen = rng.sample(possible,size)
        edges = [
            (u,v,round(10**rng.uniform(-1.2,.7),3))
            for u,v in chosen
        ]
        q = rng.choice(q_choices)
        p,dp = p_and_derivative(
            coefficients(q,n,edges,layers,t_edge,K=1))
        if p > 1e-10:
            nontrivial += 1
        if dp < -1e-9:
            negatives.append((trial,q,edges,dp))
    return nontrivial,negatives

def main():
    print("Exact rational finite-Taylor test (base K=1, added Kt=1):")
    for q in (2,3,5):
        coeff = coefficients(q,*TWO_HUB,K=1,exact=True)
        p,dp = p_and_derivative(coeff)
        print("q=",q,"coeff=",coeff,"P0=",p,"Pprime0=",dp)
        assert dp > 0
    q3 = coefficients(3,*TWO_HUB,K=1,exact=True)
    assert p_and_derivative(q3)[1] == Fraction(3,262144)

    print("Two free hubs, base K=2, added Kt=1 (float):")
    for q in (3,):
        coeff = coefficients(q,*TWO_HUB,K=2,exact=False)
        p,dp = p_and_derivative(coeff)
        print("q=",q,"P0=",format(p,'.12f'),
              "Pprime0=",format(dp,'.12f'))
        assert dp > 0

    print("Three marked layers, base K=1, added Kt=2:")
    coeff = coefficients(3,*THREE_LAYER,K=1,max_t_count=2)
    for t in (0,.2,.5,1):
        p,dp = p_and_derivative(coeff,t)
        print("t=",t,"P(E_both)=",format(p,'.10f'),
              "Pprime=",format(dp,'.10f'))
        assert dp > 0

    for layers,edge,seed,trials in [
        ([{0,1},{2,3}],(0,1),73,250),
        ([{0},{1,2},{3}],(1,2),117,300)
    ]:
        nontrivial,negatives = random_scan(layers,edge,seed,trials)
        print("Random trials:",trials,"nontrivial:",nontrivial,
              "negative slopes below -1e-9:",len(negatives))
        assert not negatives
    print("Checks passed: finite Taylor tests, NOT a mass gap or monotonicity theorem.")

if __name__=="__main__":
    main()
