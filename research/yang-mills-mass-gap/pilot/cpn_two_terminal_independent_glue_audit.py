#!/usr/bin/env python3
"""Independent CP two-terminal *event-resolved* gluing audit.

Test both unrestricted and NO-CROSS coefficients in p, for a network
with interior repeated-edge multiplicities and a genuine cycle.

Terminals: x=2,a=4; inner pinned source u=0,v=1.
The outer marked a=4 is free in the full graph.
Uses only stdlib Fractions / permutations, no existing pilot imports.

WARNING: This is a finite fixed-multiplicity falsification screen, not
a proof that the event-resolved reduction holds for ALL finite H.
"""
from collections import defaultdict
from fractions import Fraction
from functools import lru_cache
from itertools import permutations, product
from math import factorial, comb, prod


@lru_cache(None)
def permutations_of(n):
    return tuple(permutations(range(n)))


def rising(q, n):
    return prod(range(q, q+n))


def explicit_diagrams(q, edges, pinned, n_vertices, outer=None):
    """Return total and NC coefficient polynomials of overlap of pins."""
    slots=[[] for _ in range(n_vertices)]
    twins=[]; vertex=[]
    edge_factor=1
    for u,v,k in edges:
        edge_factor*=factorial(k)
        for _ in range(k):
            h=len(twins)
            twins.extend((h+1,h))
            vertex.extend((u,v))
            slots[u].append(h)
            slots[v].append(h+1)
    degrees=[len(x) for x in slots]
    denominator=edge_factor*prod(rising(q,degrees[i])
                                 for i in range(n_vertices) if i not in pinned)
    options=[(tuple(range(degrees[i])),) if i in pinned
             else permutations_of(degrees[i]) for i in range(n_vertices)]
    total=defaultdict(int); nc=defaultdict(int)
    diagrams=0
    for choices in product(*options):
        diagrams+=1
        succ=[0]*len(twins)
        for v,halfedges in enumerate(slots):
            for k,h in enumerate(halfedges):
                succ[h]=twins[halfedges[choices[v][k]]]
        seen=set(); free_loops=K=0
        for h in range(len(twins)):
            if h in seen: continue
            word=[];cur=h
            while cur not in seen:
                seen.add(cur)
                if vertex[cur] in pinned:
                    word.append(vertex[cur])
                cur=succ[cur]
            if word:
                K+=sum(word[j]!=word[j-1] for j in range(len(word)))//2
            else:
                free_loops+=1
        no_cross=True
        if outer is not None:
            marked=set(pinned)|{outer}
            for u in pinned:
                for h in slots[u]:
                    cur=twins[h]
                    while vertex[cur] not in marked:
                        cur=succ[cur]
                    if vertex[cur]==outer:
                        no_cross=False
                        break
                if not no_cross: break
        w=q**free_loops
        total[K]+=w
        if no_cross: nc[K]+=w
    return ({k:Fraction(v,denominator) for k,v in total.items()},
            {k:Fraction(v,denominator) for k,v in nc.items()},
            diagrams)


def two_terminal_prediction(q,H,r,s):
    kernel,_,nk=explicit_diagrams(q,H,(2,4),5)
    d=r+s
    total_mass=sum(c*Fraction(factorial(n),rising(q,n))
                   for n,c in kernel.items())
    nc_mass=sum(c*Fraction(factorial(n),rising(q+d,n))
                for n,c in kernel.items())
    # Two pinned rank-one projector source moment. Alternation polynomial
    # S_rs(p)=r!s! sum_k binom(r,k)binom(s,k) p^k.
    source={k:Fraction(comb(r,k)*comb(s,k),rising(q,d))
            for k in range(min(r,s)+1)}
    return ({k:v*total_mass for k,v in source.items()},
            {k:v*nc_mass for k,v in source.items()},kernel,nk)


CASES=(
    ("serial double-double", ((2,3,2),(3,4,2)), 1,1),
    ("serial unequal", ((2,3,2),(3,4,1)),2,1),
    ("triangle", ((2,3,1),(3,4,1),(2,4,1)),2,2),
    ("triangle repeat left", ((2,3,2),(3,4,1),(2,4,1)),1,1),
    ("triangle repeat outer", ((2,3,1),(3,4,2),(2,4,1)),1,1),
    ("triangle repeat direct", ((2,3,1),(3,4,1),(2,4,2)),1,1)
)


def main():
    cases=0
    for q in (2,3,5):
        for name,H,r,s in CASES:
            full,nc,ct=explicit_diagrams(
                q,((0,2,r),(1,2,s))+H,(0,1),5,outer=4)
            pred_full,pred_nc,kernel,nk=two_terminal_prediction(q,H,r,s)
            assert full==pred_full,(q,name,"full",full,pred_full)
            assert nc==pred_nc,(q,name,"no crossing",nc,pred_nc)
            assert all(v>=0 for v in kernel.values())
            cases+=1
            print(f"q={q} {name}: PASS full & NC; "
                  f"H perms={nk}; full perms={ct}")
    # Fully inspectable cyclic case with a repeated left H edge.
    H=((2,3,2),(3,4,1),(2,4,1))
    full,nc,_=explicit_diagrams(3,((0,2,1),(1,2,1))+H,(0,1),5,outer=4)
    pred_full,pred_nc,kernel,_=two_terminal_prediction(3,H,1,1)
    assert kernel=={1:Fraction(1,60),2:Fraction(1,30)}
    assert full=={0:Fraction(1,1080),1:Fraction(1,1080)}
    assert nc=={0:Fraction(1,2160),1:Fraction(1,2160)}
    assert full==pred_full and nc==pred_nc
    print("Exact cyclic repeated-edge example:",kernel,full,nc)
    print(f"PASS: {cases} independent fixed-multiplicity tests.")
    print("NOT A PROOF for arbitrary H; not an untruncated CP test.")


if __name__=="__main__":
    main()
