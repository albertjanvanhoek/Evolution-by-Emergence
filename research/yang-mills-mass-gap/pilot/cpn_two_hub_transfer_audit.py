#!/usr/bin/env python3
"""Independent exact-rational CP index-loop audit and full-series weak-bridge slope.

q>=2, projector interaction exp(sum b_e tr(P_u P_v)).
  1. Star D6 term-by-term in the pin-overlap polynomial p;
  2. A single x-y bridge: exact conditional excursion probability;
  3. Complete-series small-J coefficient (NO base-edge truncation).
Uses Python stdlib only; no Monte Carlo. The finite-count audits do
not replace the general combinatorial proof in CPN_TWO_HUB_TRANSFER.md.
"""
from collections import defaultdict
from fractions import Fraction as Q
from functools import lru_cache
from itertools import permutations, product
from math import factorial, prod


@lru_cache(None)
def permutations_d(d):
    return tuple(permutations(range(d)))


def rising(q, k):
    return prod(range(q, q+k))


def enumerate_polynomial(q, n_sites, edges, outer, free_sites):
    """Pinned vertices 0,1; event = a direct excursion from outer to either pin.

    All multiplicities are FIXED and the coefficients of p^K are exact Fractions.
    Edge tuples are (u,v,multiplicity), not coupling strengths.
    """
    pinned = (0, 1)
    marked = {0,1,outer}
    ports = [[] for _ in range(n_sites)]
    twins, sites = [], []
    factor=Q(1)
    for u,v,count in edges:
        factor /= factorial(count)
        for _ in range(count):
            h=len(twins)
            twins.extend((h+1,h))
            sites.extend((u,v))
            ports[u].append(h)
            ports[v].append(h+1)
    deg=[len(a) for a in ports]
    for v in free_sites:
        factor /= rising(q,deg[v])
    options=[permutations_d(deg[v]) if v in free_sites
             else (tuple(range(deg[v])),) for v in range(n_sites)]
    total, crossing=defaultdict(Q),defaultdict(Q)
    for pp in product(*options):
        follow=[0]*len(twins)
        for v, hs in enumerate(ports):
            for j,h in enumerate(hs):
                follow[h]=twins[hs[pp[v][j]]]
        seen=set()
        free_loops=alternations=0
        for h in range(len(twins)):
            if h in seen:
                continue
            cur=h
            word=[]
            while cur not in seen:
                seen.add(cur)
                if sites[cur] in pinned:
                    word.append(sites[cur])
                cur=follow[cur]
            if word:
                alternations += sum(word[j]!=word[j-1]
                                    for j in range(len(word)))//2
            else:
                free_loops+=1
        event=False
        for v in pinned:
            for h in ports[v]:
                cur=twins[h]
                while sites[cur] not in marked:
                    cur=follow[cur]
                if sites[cur]==outer:
                    event=True
                    break
            if event:
                break
        w=factor*q**free_loops
        total[alternations]+=w
        if event:
            crossing[alternations]+=w
    return dict(total),dict(crossing)


def audit_star_d6(q, ru, rv, ma):
    d=ru+rv
    whole, crossing=enumerate_polynomial(
        q,4,[(0,2,ru),(1,2,rv),(3,2,ma)],3,{2,3})
    root,unused=enumerate_polynomial(
        q,4,[(0,2,ru),(1,2,rv),(3,2,0)],3,{2,3})
    assert whole=={k:w/rising(q,ma) for k,w in root.items()}
    no_cross={k:w-crossing.get(k,Q(0)) for k,w in whole.items()}
    assert no_cross=={
        k:w*Q(rising(q,d),rising(q,d+ma))
        for k,w in root.items()}
    return no_cross


def audit_single_bridge(q,ru,rv,m):
    d=ru+rv
    whole,crossing=enumerate_polynomial(
        q,5,[(0,2,ru),(1,2,rv),(2,3,1),(3,4,m)],4,{2,3,4})
    desired=Q(d,q+d)*Q(m,q+m)
    assert all(crossing.get(k,Q(0))==desired*w
               for k,w in whole.items())
    return desired


def f_and_derivative(q,b):
    term=total=1.0
    derivative=0.0
    for m in range(1,500):
        term *= b/(q+m-1)
        total += term
        derivative += m*term/b if b else (1/q if m==1 else 0)
        if m>max(20,b+12) and term<1e-17*total:
            break
    return total,derivative


def root_factor(q,p,bu,bv):
    s=bu+bv
    delta=bu*bv*(1-p)
    prev,cur=1.0,s
    rising_d=Z=1.0
    total=0.0
    for d in range(1,500):
        if d==1:
            hd=s
        else:
            prev,cur=cur,s*cur-delta*prev
            hd=cur
        rising_d*=q+d-1
        w=hd/rising_d
        Z+=w
        total+=w*d/(q+d)
        if d>max(25,s+12) and w<1e-17*Z:
            break
    return total/Z


def exact_full_series_slope(q,p,bu,bv,b):
    f,fp=f_and_derivative(q,b)
    adjoint=(q*fp/f-1)/(q-1)
    return adjoint*root_factor(q,p,bu,bv)/q


def main():
    audited=0
    for q in (2,3,5):
        for ru,rv,ma in ((1,1,1),(2,1,1),(1,2,2),
                         (2,2,2),(0,2,2),(2,0,3),(0,0,2)):
            audit_star_d6(q,ru,rv,ma)
            audited+=1
        for ru,rv,m in ((1,1,1),(2,1,2),(1,2,2),
                        (2,0,3),(0,1,2)):
            result=audit_single_bridge(q,ru,rv,m)
            print('q',q,'root',ru,rv,'outer',m,
                  'P(connect | one bridge)',result)
            audited+=1
    assert audited==36
    print('PASS:',audited,'exact-rational fixed-multiplicity audits')
    target=(.004558485237910052,.004776293996745877,
            .004989484196212951,.005198200355603170,
            .005402581093969625)
    slopes=[exact_full_series_slope(3,p,1,1,1)
            for p in (0,.25,.5,.75,1)]
    for p,s in zip((0,.25,.5,.75,1),slopes):
        print(f'q=3, p={p}: dP/dJ at J=0 = {s:.12f}')
    assert all(abs(x-y)<1e-12 for x,y in zip(slopes,target))
    assert all(x<y for x,y in zip(slopes,slopes[1:]))
    print('PASS: complete-exponential weak-bridge slope checks')


if __name__=='__main__':
    main()
