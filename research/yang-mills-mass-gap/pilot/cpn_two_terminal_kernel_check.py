#!/usr/bin/env python3
"""Exact-rational CP two-terminal loop-gluing audit and full-beta serial test.

No Monte Carlo, no third-party dependencies. Each H diagram check fixes
edge multiplicities (one copy per selected edge) and sums ALL local
index-permutation diagrams. It verifies both unrestricted and NO-CROSS
coefficients of each two-pin overlap power p^K. Fixed-count audits are
not themselves an all-beta proof; see the accompanying analytic note.
"""
from collections import defaultdict
from fractions import Fraction as Q
from functools import lru_cache
from itertools import permutations, product
from math import comb, factorial, prod
from random import Random


@lru_cache(None)
def pm(d):
    return tuple(permutations(range(d)))


def rising(q, k):
    return prod(range(q, q+k))


def polynomial_counts(q, n_vertices, edges, pins=(0, 1), outer=5):
    """Full / no-cross coefficient dictionaries for a FIXED edge diagram.

    Edges: (u,v,multiplicity), and first two sites are separately pinned.
    Non-pinned sites are free, INCLUDING the marked outer endpoint.
    """
    slots = [[] for _ in range(n_vertices)]
    twin, where = [], []
    edge_factor = 1
    for u,v,m in edges:
        edge_factor *= factorial(m)
        for _ in range(m):
            h = len(twin)
            twin.extend((h+1,h))
            where.extend((u,v))
            slots[u].append(h)
            slots[v].append(h+1)
    degree = [len(s) for s in slots]
    moment_factor = prod(rising(q,degree[v])
                         for v in range(n_vertices) if v not in pins)
    opts = [(tuple(range(degree[v])),) if v in pins else pm(degree[v])
            for v in range(n_vertices)]
    C,NC = defaultdict(int),defaultdict(int)
    for pairings in product(*opts):
        nxt = [0]*len(twin)
        for v,ss in enumerate(slots):
            for j,h in enumerate(ss):
                nxt[h] = twin[ss[pairings[v][j]]]
        seen = set()
        k_alt = free_loops = 0
        for h in range(len(twin)):
            if h in seen:
                continue
            cur = h
            word = []
            while cur not in seen:
                seen.add(cur)
                if where[cur] in pins:
                    word.append(where[cur])
                cur = nxt[cur]
            if word:
                k_alt += sum(word[j] != word[j-1]
                             for j in range(len(word))) // 2
            else:
                free_loops += 1
        event = False
        for v in pins:
            for h in slots[v]:
                cur = twin[h]
                while where[cur] not in (*pins,outer):
                    cur = nxt[cur]
                if where[cur] == outer:
                    event = True
                    break
            if event:
                break
        weight = q**free_loops
        C[k_alt] += weight
        if not event:
            NC[k_alt] += weight
    denominator = edge_factor*moment_factor
    return ({k:Q(x,denominator) for k,x in C.items()},
            {k:Q(x,denominator) for k,x in NC.items()})


def two_terminal_kernel(q, H, terminals=(2,5), size=6):
    """Expansion c_n of fixed H diagram with x and a pinned."""
    slots = [[] for _ in range(size)]
    twin,where = [],[]
    factor = 1
    for u,v,m in H:
        factor *= factorial(m)
        for _ in range(m):
            h = len(twin)
            twin.extend((h+1,h))
            where.extend((u,v))
            slots[u].append(h)
            slots[v].append(h+1)
    degree = [len(s) for s in slots]
    factor *= prod(rising(q,degree[v])
                   for v in range(size) if v not in terminals)
    opts = [(tuple(range(degree[v])),) if v in terminals else pm(degree[v])
            for v in range(size)]
    counts = defaultdict(int)
    for pairings in product(*opts):
        nxt = [0]*len(twin)
        for v,ss in enumerate(slots):
            for j,h in enumerate(ss):
                nxt[h] = twin[ss[pairings[v][j]]]
        seen = set()
        alternations = free_loops = 0
        for h in range(len(twin)):
            if h in seen:
                continue
            cur = h
            word = []
            while cur not in seen:
                seen.add(cur)
                if where[cur] in terminals:
                    word.append(where[cur])
                cur = nxt[cur]
            if word:
                alternations += sum(word[j]!=word[j-1]
                                    for j in range(len(word)))//2
            else:
                free_loops += 1
        counts[alternations] += q**free_loops
    return {k:Q(v,factor) for k,v in counts.items()}


def check_one_H(q,H,root_counts=(1,1)):
    r,s = root_counts
    d = r+s
    original,no_cross = polynomial_counts(
        q,6,[(0,2,r),(1,2,s)]+H)
    kernel = two_terminal_kernel(q,H)
    mass = sum(c*Q(factorial(n),rising(q,n))
               for n,c in kernel.items())
    nc_mass = sum(
        c*Q(factorial(n),rising(q,n))*
        Q(rising(q,d)*rising(q,n),rising(q,d+n))
        for n,c in kernel.items())
    # Root-sector polynomial S_{r,s}(p) has these positive integer counts.
    source = {k: factorial(r)*factorial(s)*comb(r,k)*comb(s,k)
              for k in range(min(r,s)+1)}
    predicted = {k:Q(v,factorial(r)*factorial(s)*rising(q,d))*mass
                 for k,v in source.items()}
    predicted_nc = {k:Q(v,factorial(r)*factorial(s)*rising(q,d))*nc_mass
                    for k,v in source.items()}
    assert original == predicted, ("Z failure",q,H,original,predicted)
    assert no_cross == predicted_nc, ("NC failure",q,H,no_cross,predicted_nc)


def serial_kernel_mass(q,J,b,cutoff=26):
    """Full positive-series effective edge occupation ν(n) for serial H."""
    coeff = [0.]*(cutoff+1)
    for k in range(cutoff+1):
        for m in range(cutoff+1):
            factor = J**k*b**m / rising(q,k+m)
            for n in range(min(k,m)+1):
                coeff[n] += factor*comb(k,n)*comb(m,n)
    weights = [c*factorial(n)/rising(q,n) for n,c in enumerate(coeff)]
    normalizer = sum(weights)
    return [v/normalizer for v in weights],normalizer


def source_distribution(q,p,bu,bv,cutoff=55):
    s = bu+bv
    delta = bu*bv*(1-p)
    previous,current = 1.,s
    norm = 1.
    weights = []
    for d in range(cutoff):
        if d == 0:
            h = 1.
        elif d == 1:
            h = s
        else:
            previous,current = current,s*current-delta*previous
            h = current
        if d:
            norm *= q+d-1
        weights.append(h/norm)
    Z = sum(weights)
    return [w/Z for w in weights],Z


def crossing(q,p,bu,bv,nu):
    mu,G = source_distribution(q,p,bu,bv)
    NC = 0.
    for d,md in enumerate(mu):
        for n,vn in enumerate(nu):
            F = 1.
            for j in range(n):
                F *= (q+j)/(q+d+j)
            NC += md*vn*F
    return 1-NC,G


def main():
    rng = Random(11)
    candidates = [(2,3),(2,4),(2,5),(3,4),(3,5),(4,5)]
    # Enumerate all local pairings, cycles and each p^K power exactly.
    fixed_cases = 0
    for q in (2,3,5):
        for _ in range(10):
            chosen = rng.sample(candidates,rng.choice((3,4,5,6)))
            H = [(u,v,1) for u,v in chosen]
            check_one_H(q,H)
            fixed_cases += 1
    print(f"PASS: {fixed_cases} exact-rational full/NC diagram gluing audits")

    nu,z = serial_kernel_mass(3,1.,1.)
    vals = []
    for p in (0,.25,.5,.75,1):
        h,G = crossing(3,p,1.,1.,nu)
        vals.append(h)
        print(f"CP² J=b=bu=bv=1: p={p:.2f}, h={h:.12f}")
    targets = (.004826190176,.005056163727,.005281249142,
               .005501599512,.005717361678)
    assert all(abs(a-b)<2e-10 for a,b in zip(vals,targets))
    assert all(x<y for x,y in zip(vals,vals[1:]))
    print("PASS: complete-exponential serial kernel and overlap checks")
    print("CAUTION: a finite graph with two marked terminals is not a 2D annulus.")


if __name__=="__main__":
    main()
