# (a) Random-coupling check of D0, D1, D0+D1+D2 >= 0 on the seven-edge squarefree model (own enumerator, cached diagrams)
from itertools import permutations, product
from fractions import Fraction as F
import random, math
edges=[(0,2),(1,2),(0,3),(1,3),(2,4),(3,4),(2,3)]
pinned={0,1}; free=[2,3,4]; marked={0,1,4}
recs=[]  # (mask, degrees of free, loops, K, ev)
for ks in product((0,1),repeat=7):
    E=[e for e,k in zip(edges,ks) if k]
    zs={v:[] for v in range(5)}; zbs={v:[] for v in range(5)}; goes={}
    for j,(u,v) in enumerate(E):
        zs[u].append((j,u)); zs[v].append((j,v)); zbs[u].append((j,u,'b')); zbs[v].append((j,v,'b'))
        goes[(j,u,'b')]=(j,v); goes[(j,v,'b')]=(j,u)
    deg=tuple(len(zs[v]) for v in free)
    for ps in product(*[list(permutations(range(len(zs[v])))) for v in free]):
        pair={}
        for v,p in zip(free,ps):
            for a_,b_ in enumerate(p): pair[zs[v][a_]]=zbs[v][b_]
        seen=set(); K=0
        for s in (0,1):
            for zb in zbs[s]:
                c=goes[zb]
                while c[1] not in pinned: seen.add(c); c=goes[pair[c]]
                if s==0 and c[1]==1: K+=1
        loops=0
        for z in pair:
            if z in seen: continue
            loops+=1; c=z
            while c not in seen: seen.add(c); c=goes[pair[c]]
        ev=False
        for zb in zbs[4]:
            c=goes[zb]
            while c[1] not in marked: c=goes[pair[c]]
            if c[1] in pinned: ev=True; break
        recs.append((ks,deg,loops,K,ev))
print("diagrams:",len(recs))
def coeffs(q,b):
    poch=lambda d: math.prod(q+i for i in range(d))
    Z=[0.0]*3; A=[0.0]*3
    for ks,deg,loops,K,ev in recs:
        w=math.prod(bb for bb,k in zip(b,ks) if k)*q**loops/math.prod(poch(d) for d in deg)
        Z[K]+=w; A[K]+=w*ev
    D0=A[1]*Z[0]-Z[1]*A[0]; D1=2*(A[2]*Z[0]-Z[2]*A[0]); D2=A[2]*Z[1]-Z[2]*A[1]
    return D0,D1,D2
random.seed(1); bad=0; minr=1e9
for trial in range(300):
    q=random.choice([2,3,5,8,20])
    b=[math.exp(random.uniform(-4,4)) for _ in range(7)]
    D0,D1,D2=coeffs(q,b)
    for x in (D0,D1,D0+D1+D2):
        if x< -1e-12*max(1,abs(D0)): bad+=1
print("random couplings: violations of D0,D1,D0+D1+D2 >= 0:",bad,"of 900 checks")
# check identity and the published example
D0,D1,D2=coeffs(3,[1/8,8,8,1/8,8,8,1/4]); print("example D:",round(D0,4),round(D1,4),round(D2,5))
