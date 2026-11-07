#!/usr/bin/env python3
"""Exact enumeration of the FINITE Taylor truncation of CP projector loops.

Every edge has multiplicity 0 <= k <= K, so these are NOT exact
finite-beta probabilities of the full exponential action. No sampling.
Inner/middle/outer events are defined by a strand excursion between
successive marked layers, without passing through another marked vertex.
"""
from functools import lru_cache
from itertools import permutations, product
from math import factorial


@lru_cache(None)
def all_perms(d):
    return tuple(permutations(range(d)))


@lru_cache(None)
def poch(q, d):
    result = 1
    for k in range(d):
        result *= q+k
    return result


def enumerated_measure(n, edges, groups, q=3, K=2, pin=None):
    """edges are (vertex,vertex,coupling); groups are disjoint sets.
    pin: sites fixed separately to the SAME rank-one projector.
    If omitted, pin all sites in the marked groups.
    """
    groups = [set(g) for g in groups]
    marked = set().union(*groups)
    if pin is None:
        pin = marked
    pin = set(pin)
    assert q >= 2 and K >= 0 and pin <= marked
    assert sum(map(len, groups)) == len(marked)
    assert all(0 <= u < n and 0 <= v < n and u != v and b >= 0
               for u,v,b in edges)
    group_of = {v:i for i,g in enumerate(groups) for v in g}
    test_pairs = [(j,j+1) for j in range(len(groups)-1)]
    Z_free = Z_pin = cross_free = cross_pin = 0.0
    Z_free_nc = Z_pin_nc = 0.0
    diagram_count = 0

    for multiplicities in product(range(K+1), repeat=len(edges)):
        factor = 1.0
        slots = [[] for _ in range(n)]
        twin = []
        for (u,v,b), k in zip(edges,multiplicities):
            factor *= b**k/factorial(k)
            for _ in range(k):
                h=len(twin)
                twin.extend((h+1,h))
                slots[u].append(h)
                slots[v].append(h+1)
        if factor == 0:
            continue
        degree = [len(h) for h in slots]
        where = [0]*len(twin)
        for v,hs in enumerate(slots):
            for h in hs:
                where[h]=v
        local_free = factor
        local_pin = factor
        for v,d in enumerate(degree):
            local_free /= poch(q,d)
            if v not in pin:
                local_pin /= poch(q,d)

        for site_perms in product(*(all_perms(d) for d in degree)):
            diagram_count += 1
            successor = [0]*len(twin)
            for v,hs in enumerate(slots):
                for j,pj in enumerate(site_perms[v]):
                    successor[hs[j]] = twin[hs[pj]]

            # Count the loops in the free (all-unpinned) diagram.
            seen = [False]*len(twin)
            total_loops = 0
            for h in range(len(twin)):
                if seen[h]: continue
                total_loops += 1
                cur = h
                while not seen[cur]:
                    seen[cur] = True
                    cur = successor[cur]

            # Cut *all marked layers*, even those not pinned.
            # Each excursion uses only permutations at unmarked sites.
            crossing_pairs = set()
            for v in marked:
                for h in slots[v]:
                    cur = twin[h]
                    while where[cur] not in marked:
                        cur = successor[cur]
                    w = where[cur]
                    if group_of[v] != group_of[w]:
                        crossing_pairs.add(tuple(sorted((group_of[v],group_of[w]))))
            event = all(pair in crossing_pairs for pair in test_pairs)

            weight_free = local_free * q**total_loops
            Z_free += weight_free
            if event: cross_free += weight_free
            else: Z_free_nc += weight_free

            # Pinned site = identity pairing on each edge occurrence.
            # Loops visiting pinned sites have color weight 1, not q.
            if any(site_perms[v] != tuple(range(degree[v])) for v in pin):
                continue
            seen = [False]*len(twin)
            loops_avoiding_pins = 0
            for h in range(len(twin)):
                if seen[h]: continue
                cur = h
                touches_pin = False
                while not seen[cur]:
                    seen[cur] = True
                    touches_pin |= where[cur] in pin
                    cur = successor[cur]
                if not touches_pin:
                    loops_avoiding_pins += 1
            weight_pin = local_pin*q**loops_avoiding_pins
            Z_pin += weight_pin
            if event: cross_pin += weight_pin
            else: Z_pin_nc += weight_pin

    return {
        "Zfree": Z_free, "Zpin": Z_pin, "ZNCfree": Z_free_nc,
        "ZNCpin": Z_pin_nc, "Pfree": cross_free/Z_free,
        "Ppin": cross_pin/Z_pin, "diagrams": diagram_count
    }


def main():
    samples = [
      ("star I2 O1",4,[(0,2,1.),(1,2,1.),(2,3,1.)],[{0,1},{3}]),
      ("bipartite 4-cycle I2 O2",4,
       [(0,2,1.),(0,3,1.),(1,2,1.),(1,3,1.)],[{0,1},{2,3}]),
      ("4-cycle with inner layer edge",4,
       [(0,1,1.),(0,2,1.),(2,3,1.),(3,1,1.)],[{0,1},{3}]),
      ("2 rings, 5-path",5,
       [(0,1,1.),(1,2,1.),(2,3,1.),(3,4,1.)],[{0},{2},{4}]),
      ("2 rings, middle layer size 2",4,
       [(0,1,1.),(0,2,1.),(2,3,1.),(3,1,1.)],[{0},{1,2},{3}]),
    ]
    for name,n,edges,groups in samples:
        for K in (1,2):
            r = enumerated_measure(n,edges,groups,q=3,K=K)
            assert r["Pfree"] <= r["Ppin"]+1e-10
            print(f"{name}; K={K}; "
                  f"Pfree={r['Pfree']:.9f}; Ppin={r['Ppin']:.9f}; "
                  f"NCfree={r['ZNCfree']:.9f}; NCpin={r['ZNCpin']:.9f}; "
                  f"diagrams={r['diagrams']}")
    # Exact formal Taylor coefficient on star (2 inner endpoints):
    q=3
    assert abs((2/(q*(q+1))-1/q**2)-1/18)<1e-12
    # A 3-port exterior wiring 3-cycle changes P(interior id) by q²:
    assert abs(q**3/poch(q,3)-.45)<1e-12
    assert abs(q/poch(q,3)-.05)<1e-12
    print("Finite-truncation checks passed.")


if __name__=="__main__":
    main()
