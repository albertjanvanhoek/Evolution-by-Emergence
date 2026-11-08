# Independent enumerator (own code) for the other assistant's two-hub check:
# I={0,1}, O={2}, hubs 3,4; edges (0,3),(1,3),(3,4),(4,2) weight 1 (k<=1), t-edge (0,1) (k_t<=1). q=3.
# Unit of multiplicity on edge (u,v) = factor (zbar_u.z_v)(zbar_v.z_u): one z-slot and one zbar-slot at u and at v.
# Vertex weight 1/(q)_d * sum over bijections pi: z-slots -> zbar-slots; index loops get weight q.
from fractions import Fraction as F
from itertools import permutations, product
from math import factorial
q=3
def poch(d):
    r=1
    for k in range(d): r*=q+k
    return r
base=[(0,3),(1,3),(3,4),(4,2)]; tedge=(0,1)
marked={0:'I',1:'I',2:'O'}
def run(kt):
    Z=F(0); A=F(0)
    for ks in product((0,1),repeat=4):
        edges=[e for e,k in zip(base,ks) for _ in range(k)]+[tedge]*kt
        # slots: for unit j on edge (u,v): at u: zbar-slot leads to v's z-slot (factor zbar_u.z_v); at v: zbar-slot leads to u's z-slot
        zslots={v:[] for v in range(5)}; zbslots={v:[] for v in range(5)}; goes={}  # zbar-slot -> (vertex, z-slot id)
        for j,(u,v) in enumerate(edges):
            zslots[u].append(('z',j,u)); zslots[v].append(('z',j,v))
            zbslots[u].append(('zb',j,u)); zbslots[v].append(('zb',j,v))
            goes[('zb',j,u)]=('z',j,v); goes[('zb',j,v)]=('z',j,u)
        deg={v:len(zslots[v]) for v in range(5)}
        w=F(1)
        for v in range(5): w/=poch(deg[v])
        for perms in product(*[list(permutations(range(deg[v]))) for v in range(5)]):
            pair={}  # z-slot -> zbar-slot at same vertex
            for v,p in zip(range(5),perms):
                for a,bb in enumerate(p): pair[zslots[v][a]]=zbslots[v][bb]
            # count loops
            seen=set(); loops=0
            for s in pair:
                if s in seen: continue
                loops+=1; cur=s
                while cur not in seen:
                    seen.add(cur); cur=goes[pair[cur]]
            # excursions from marked zbar-slots through unmarked vertices
            cross=False
            for m in marked:
                for zb in zbslots[m]:
                    cur=goes[zb]
                    while cur[2] not in marked: cur=goes[pair[cur]]
                    if marked[cur[2]]!=marked[m]: cross=True
            wt=w*q**loops
            Z+=wt; A+=wt*cross
    return Z,A
Z0,A0=run(0); Z1,A1=run(1)
print("Z0,A0,Z1,A1 =",Z0,A0,Z1,A1)
print("P0 =",A0/Z0,"  P'_0 =",(A1*Z0-A0*Z1)/Z0**2)
