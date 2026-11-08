#!/usr/bin/env python3
"""Exact-rational two-pin coefficient expansion for CP single-edge fusion.

All BASE edges truncated to 0 <= n_e <= K, K=1 for the examples/search.
The fusion coupling t is NOT included in this enumeration: its effect is
recovered exactly from Beta moments m_j=j!/(q)_j. The finite base-edge
truncation is NOT an all-beta CP Gibbs calculation.

The event is a DIRECT EXCURSION between successive marked layers:
cut at every marked site and stop at the next marked site, ignoring
permutations at those sites. Pins u,v belong to the SAME marked layer.
"""
from fractions import Fraction
from functools import lru_cache
from itertools import permutations, product, combinations
from math import factorial, prod
from random import Random


@lru_cache(None)
def perms(d):
    return tuple(permutations(range(d)))


@lru_cache(None)
def poch(q, d):
    return prod(range(q, q+d))


def pinned_coefficients(q, n, edges, layers, pins, K=1, cap=30000):
    marked = set().union(*layers)
    layerid = {v:j for j, layer in enumerate(layers) for v in layer}
    assert len(pins) == 2 and pins[0] in marked and pins[1] in marked
    assert layerid[pins[0]] == layerid[pins[1]]
    C, A, count = {}, {}, 0

    for multiplicities in product(range(K+1), repeat=len(edges)):
        slots = [[] for _ in range(n)]
        twin = []
        factor = Fraction(1)
        for (u,v,b),k in zip(edges,multiplicities):
            factor *= Fraction(str(b))**k/factorial(k)
            for _ in range(k):
                h = len(twin)
                twin.extend((h+1,h))
                slots[u].append(h)
                slots[v].append(h+1)
        if not factor:
            continue
        deg = [len(s) for s in slots]
        nperm = prod(factorial(deg[v]) for v in range(n) if v not in pins)
        if nperm > cap:
            raise RuntimeError("too many local permutations", nperm)
        for v,d in enumerate(deg):
            if v not in pins:
                factor /= poch(q,d)

        where = [0]*len(twin)
        for v,hs in enumerate(slots):
            for h in hs:
                where[h] = v

        options = [perms(deg[v]) if v not in pins
                   else [tuple(range(deg[v]))] for v in range(n)]
        for choices in product(*options):
            count += 1
            successor = [0]*len(twin)
            for v,hs in enumerate(slots):
                for j,h in enumerate(hs):
                    successor[h] = twin[hs[choices[v][j]]]

            visited, loops_without_pins, switches = set(), 0, 0
            for h in range(len(twin)):
                if h in visited:
                    continue
                cur = h
                pin_visits = []
                while cur not in visited:
                    visited.add(cur)
                    if where[cur] in pins:
                        pin_visits.append(where[cur])
                    cur = successor[cur]
                if not pin_visits:
                    loops_without_pins += 1
                else:
                    switches += sum(pin_visits[j] != pin_visits[j-1]
                                    for j in range(len(pin_visits)))//2

            pair_groups = set()
            for v in marked:
                for h in slots[v]:
                    cur = twin[h]
                    while where[cur] not in marked:
                        cur = successor[cur]
                    i,j = layerid[v],layerid[where[cur]]
                    if i != j:
                        pair_groups.add(tuple(sorted((i,j))))
            event = all((j,j+1) in pair_groups for j in range(len(layers)-1))

            weight = factor*q**loops_without_pins
            C[switches] = C.get(switches,Fraction(0))+weight
            if event:
                A[switches] = A.get(switches,Fraction(0))+weight
    return C,A,count


def beta_moment(q,k):
    return Fraction(factorial(k),poch(q,k))


def scalar_derivative_at_zero(q,C,A):
    Z0 = sum(c*beta_moment(q,k) for k,c in C.items())
    A0 = sum(c*beta_moment(q,k) for k,c in A.items())
    Z1 = sum(c*beta_moment(q,k+1) for k,c in C.items())
    A1 = sum(c*beta_moment(q,k+1) for k,c in A.items())
    return (Z0,A0,Z1,A1), (A1*Z0-A0*Z1)/Z0**2


def show_case(label,n,edges,layers,pins,K=1):
    C,A,count = pinned_coefficients(3,n,edges,layers,pins,K=K)
    ratios = {k:A.get(k,Fraction(0))/c for k,c in sorted(C.items()) if c}
    print(label, "K=",K, "diagrams=",count)
    print("  c_k:",C)
    print("  a_k:",A)
    print("  P(E|K=k) ratios:",ratios)
    return C,A,ratios


def seeded_scan(layers,pins,seed,trials=250):
    r = Random(seed)
    n = 6
    possible = [e for e in combinations(range(n),2) if e != tuple(sorted(pins))]
    seen, worst, examples = 0, Fraction(1), None
    for i in range(trials):
        chosen = r.sample(possible,r.choice((4,5,6,7)))
        edges = [(u,v,r.choice((0.5,1.0,2.0))) for u,v in chosen]
        try:
            C,A,_ = pinned_coefficients(3,n,edges,layers,pins,K=1,cap=500)
        except RuntimeError:
            continue
        ratios=[A.get(k,Fraction(0))/c for k,c in sorted(C.items()) if c]
        if not ratios or max(ratios)==0 or min(ratios)==1:
            continue
        seen+=1
        for j in range(1,len(ratios)):
            diff=ratios[j]-ratios[j-1]
            if diff < worst:
                worst,examples=diff,(edges,ratios)
            if diff < 0:
                raise AssertionError(("counterexample at finite Taylor cutoff",
                                      layers,edges,ratios))
    return seen,worst,examples


def main():
    twohub_edges=[(0,3,1),(1,3,1),(3,4,1),(4,2,1)]
    C,A,ratios=show_case("two-hub tree",5,twohub_edges,
                          [{0,1},{2}],(0,1))
    assert C=={0:Fraction(28,9),1:Fraction(4,27)}
    assert A=={0:Fraction(1,180),1:Fraction(1,1080)}
    assert ratios=={0:Fraction(1,560),1:Fraction(1,160)}
    data,derivative=scalar_derivative_at_zero(3,C,A)
    assert data==(Fraction(256,81),Fraction(19,3240),
                  Fraction(86,81),Fraction(13,6480))
    assert derivative==Fraction(3,262144)
    print("  reproduced previous independent two-hub derivative:",derivative)

    cycle_edges=[(0,4,1),(1,5,1),(4,5,1),(4,2,1),(5,3,1)]
    _,_,ratios=show_case("two-hub cyclic case",6,cycle_edges,
                           [{0,1},{2,3}],(0,1))
    assert ratios=={0:Fraction(553,17050),1:Fraction(19,100)}
    for layers,pins in [
        ([{0,1},{2,3}],(0,1)),
        ([{0},{1,2},{3}],(1,2))
    ]:
        seen,worst,_=seeded_scan(layers,pins,2607)
        print("search",layers,"usable=",seen,
              "smallest adjacent ratio difference=",worst)
    print("Checks passed. NO all-coupling monotonicity theorem.")


if __name__=="__main__":
    main()
