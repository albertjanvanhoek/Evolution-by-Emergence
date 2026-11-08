# Direct term: does one more strand inside a layer ever lower P(E | n)?
# P(E|n) = sum_{perms} w 1_E / sum w, w = prod_v (q)_{d_v}^{-1} q^{#loops} (couplings drop out at fixed n).
from itertools import permutations, product
from fractions import Fraction as F
from functools import lru_cache
import sys
q=int(sys.argv[1]) if len(sys.argv)>1 else 3
@lru_cache(None)
def perms(d): return list(permutations(range(d)))
def PE(nv, edges, marked):
    zs={v:[] for v in range(nv)}; zbs={v:[] for v in range(nv)}; goes={}
    for j,(u,v) in enumerate(edges):
        zs[u].append((j,u)); zs[v].append((j,v)); zbs[u].append((j,u,'b')); zbs[v].append((j,v,'b'))
        goes[(j,u,'b')]=(j,v); goes[(j,v,'b')]=(j,u)
    deg={v:len(zs[v]) for v in range(nv)}
    Z=0; A=0
    for ps in product(*[perms(deg[v]) for v in range(nv)]):
        pair={}
        for v,p in zip(range(nv),ps):
            for a,b in enumerate(p): pair[zs[v][a]]=zbs[v][b]
        seen=set(); loops=0
        for s in pair:
            if s in seen: continue
            loops+=1; c=s
            while c not in seen: seen.add(c); c=goes[pair[c]]
        cross=False
        for m in marked:
            for zb in zbs[m]:
                c=goes[zb]
                while c[1] not in marked: c=goes[pair[c]]
                if marked[c[1]]!=marked[m]: cross=True; break
            if cross: break
        w=q**loops; Z+=w; A+=w*cross
    return F(A,Z) if Z else None   # vertex factors are common to all perms at fixed n
graphs={
 "two-hub chain I={0,1},O={2}, hubs 3,4": (5,[(0,3),(1,3),(3,4),(4,2)],{0:'I',1:'I',2:'O'},(0,1)),
 "two hubs both to I1,I2,O": (5,[(0,3),(1,3),(2,3),(0,4),(1,4),(2,4)],{0:'I',1:'I',2:'O'},(0,1)),
 "hub with I1,I2 + I2-hub2-O": (5,[(0,3),(1,3),(3,2),(1,4),(4,2)],{0:'I',1:'I',2:'O'},(0,1)),
}
worst=None
for name,(nv,base,marked,te) in graphs.items():
    cnt=0; bad=0; mind=None
    for ks in product((0,1),repeat=len(base)):
        bedges=[e for e,k in zip(base,ks) for _ in range(k)]
        prev=None
        for kt in range(0,4):
            p=PE(nv,bedges+[te]*kt,marked)
            if p is None: continue
            if prev is not None:
                d=p-prev; cnt+=1
                if mind is None or d<mind[0]: mind=(d,ks,kt)
                if d<0: bad+=1
            prev=p
    print(f"{name}: {cnt} comparisons, {bad} decreases; smallest change {float(mind[0]):+.5f} at base={mind[1]}, k_t {mind[2]-1}->{mind[2]}",flush=True)
