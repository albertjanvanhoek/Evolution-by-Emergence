# Independent check (own code) of the multi-gateway example:
# pinned u=0, v=1 (rank-one, overlap p); free gateways x=2, y=3; free marked leaf a=4.
# Edges u-x,u-y,v-x,v-y,a-x,a-y,x-y, multiplicity <= 1, all couplings 1.
# Weight per configuration: prod_free (q)_d^{-1} * q^{#closed loops avoiding pins} * p^{K}, K = # strands u->v.
# Event E: a strand leaving a, followed through x,y only, ends at u or v.
from itertools import permutations, product
from fractions import Fraction as F
import sys
q=int(sys.argv[1]) if len(sys.argv)>1 else 3
def poch(d):
    r=1
    for i in range(d): r*=q+i
    return r
edges=[(0,2),(1,2),(0,3),(1,3),(2,4),(3,4),(2,3)]
bw=[F(1,8),F(8),F(8),F(1,8),F(8),F(8),F(1,4)]
pinned={0,1}; free=[2,3,4]; marked={0,1,4}
A={}; C={}
for ks in product((0,1),repeat=7):
    E=[e for e,k in zip(edges,ks) if k]
    zs={v:[] for v in range(5)}; zbs={v:[] for v in range(5)}; goes={}
    for j,(u,v) in enumerate(E):
        zs[u].append((j,u)); zs[v].append((j,v)); zbs[u].append((j,u,'b')); zbs[v].append((j,v,'b'))
        goes[(j,u,'b')]=(j,v); goes[(j,v,'b')]=(j,u)
    deg={v:len(zs[v]) for v in range(5)}
    w0=F(1)
    for e,k,b in zip(edges,ks,bw):
        if k: w0*=b
    for v in free: w0/=poch(deg[v])
    for ps in product(*[list(permutations(range(deg[v]))) for v in free]):
        pair={}
        for v,p in zip(free,ps):
            for a_,b_ in enumerate(p): pair[zs[v][a_]]=zbs[v][b_]
        # strands from pinned zbar-slots: follow through free vertices (incl. a) to a pinned vertex
        seen=set(); K=0
        for s in (0,1):
            for zb in zbs[s]:
                c=goes[zb]
                while c[1] not in pinned:
                    seen.add(c); c=goes[pair[c]]
                if s==0 and c[1]==1: K+=1
        loops=0
        for z in pair:
            if z in seen: continue
            loops+=1; c=z
            while c not in seen: seen.add(c); c=goes[pair[c]]
        # event: excursion from a through x,y (cut at u,v,a) reaching u or v
        ev=False
        for zb in zbs[4]:
            c=goes[zb]
            while c[1] not in marked: c=goes[pair[c]]
            if c[1] in pinned: ev=True; break
        wt=w0*q**loops
        C[K]=C.get(K,0)+wt; A[K]=A.get(K,0)+wt*ev
for k in sorted(C): print(f"q={q} K={k}: r_K = {float(A[k]/C[k]):.6f}")
# h(p) and its derivative sign on [0,1]
import numpy as np
def h(p): return sum(A[k]*p**k for k in A)/sum(C[k]*p**k for k in C)
ps=np.linspace(0,1,101); hv=[float(h(F(int(1000*x),1000))) for x in ps]
print("h(0)=%.6f h(1)=%.6f  monotone on grid: %s"%(hv[0],hv[-1], all(hv[i+1]>=hv[i] for i in range(100))))
# Z^2 h' = sum over pairs; report polynomial coefficients
Zc=[C.get(k,0) for k in range(3)]; Ac=[A.get(k,0) for k in range(3)]
D=[F(0)]*5
for i in range(3):
    for j in range(3):
        D[i+j-1 if i+j>=1 else 0]+= (i*Ac[i]*Zc[j]-i*Zc[i]*Ac[j]) if i>=1 else 0
print("Z^2 h' coefficients (p^0,p^1,p^2,...):", [round(float(x),5) for x in D])
