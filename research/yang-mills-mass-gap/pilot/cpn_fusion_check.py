#!/usr/bin/env python3
"""Run: python -I cpn_fusion_check.py   (needs cpn_layer_exact_enumeration.py; about 2 min)
Free vs fused vs pinned crossing probability for two layers (finite Taylor truncation).
Fused = every layer's spins forced equal, common direction uniform. By SU(q) invariance
Z_fused = E_{p~Beta(1,q-1)} Z_pin(p) = sum_k c_k k!/(q)_k, with c_k the equal-pinned weight
with K = k strands from layer I to layer O; Z_fused,NC = c_0 (two-vertex lemma on the
contracted graph). So P_fused = 1 - c_0 / sum_k c_k k!/(q)_k."""
import sys; sys.path.insert(0,'.')
from itertools import product, permutations
from math import factorial
from cpn_layer_exact_enumeration import enumerated_measure, poch, all_perms

def pinned_K_weights(n, edges, I, O, q=3, K=2):
    pin = set(I)|set(O); c = {}
    for mult in product(range(K+1), repeat=len(edges)):
        f = 1.0; slots=[[] for _ in range(n)]; twin=[]
        for (u,v,b),k in zip(edges,mult):
            f *= b**k/factorial(k)
            for _ in range(k):
                h=len(twin); twin.extend((h+1,h)); slots[u].append(h); slots[v].append(h+1)
        deg=[len(s) for s in slots]; where=[0]*len(twin)
        for v,hs in enumerate(slots):
            for h in hs: where[h]=v
        for v,d in enumerate(deg):
            if v not in pin: f /= poch(q,d)
        free_vs=[v for v in range(n) if v not in pin]
        for perms in product(*(all_perms(deg[v]) for v in free_vs)):
            succ=[None]*len(twin)
            for v,pv in zip(free_vs,perms):
                hs=slots[v]
                for j,pj in enumerate(pv): succ[hs[j]]=twin[hs[pj]]
            # strands leaving pinned vertices
            kk=0; seen=[False]*len(twin)
            for v in pin:
                for h in slots[v]:
                    cur=twin[h]
                    while where[cur] not in pin:
                        seen[cur]=True; cur=succ[cur]
                    if v in I and where[cur] in O: kk+=1
            # closed loops avoiding pins
            loops=0
            for h in range(len(twin)):
                if seen[h] or where[h] in pin: continue
                # h at a free vertex not on any pinned excursion -> part of a closed loop
                cur=h; ok=True; path=[]
                while not seen[cur]:
                    seen[cur]=True; path.append(cur); cur=succ[cur]
                loops+=1
            w=f*q**loops
            c[kk]=c.get(kk,0.0)+w
    return c

samples = [
  ("star I2 O1",4,[(0,2,1.),(1,2,1.),(2,3,1.)],{0,1},{3}),
  ("bipartite 4-cycle I2 O2",4,[(0,2,1.),(0,3,1.),(1,2,1.),(1,3,1.)],{0,1},{2,3}),
  ("4-cycle, edge inside layer I",4,[(0,1,1.),(0,2,1.),(2,3,1.),(3,1,1.)],{0,1},{3}),
  ("I2 O2 via two free middles",6,[(0,2,1.),(1,3,1.),(2,3,1.),(2,4,1.),(3,5,1.)],{0,1},{4,5}),
  ("I2 O1, strong I-edge b=3",4,[(0,1,3.),(0,2,1.),(1,2,1.),(2,3,1.)],{0,1},{3}),
]
q=3
for name,n,edges,I,O in samples:
    for K in (1,2):
        a=enumerated_measure(n,edges,[I,O],q=q,K=K)
        c=pinned_K_weights(n,edges,I,O,q=q,K=K)
        Zf=sum(ck*factorial(k)/poch(q,k) for k,ck in c.items())
        Pfused=1-c.get(0,0.0)/Zf
        Ppin_chk=1-c.get(0,0.0)/sum(c.values())
        ok=a['Pfree']<=Pfused+1e-12<=a['Ppin']+2e-12
        print(f"{name:30s} K={K}: Pfree={a['Pfree']:.5f}  Pfused={Pfused:.5f}  Ppin={a['Ppin']:.5f} (recomputed {Ppin_chk:.5f})  {'OK' if ok else 'VIOLATED'}",flush=True)
