import numpy as np, math, sys
q=5; b=float(sys.argv[1]) if len(sys.argv)>1 else 1.0
edges=[(0,1),(1,2),(3,4),(4,5),(0,3),(1,4),(2,5)]
rng=np.random.default_rng(123)
def samp(n):
    z=rng.normal(size=(n,q))+1j*rng.normal(size=(n,q)); return z/np.linalg.norm(z,axis=1)[:,None]
def ov(u,v): return np.abs(np.sum(np.conj(u)*v,axis=1))**2
pairs=[(("w3",(1,2)),("ind",(2,5))), (("ind",(3,4)),("ind",(4,5))), (("ind",(1,2)),("ind",(2,5))), (("w",(1,2)),("w",(2,5))), (("ind",(0,1)),("ind",(4,5)))]
res={p:[] for p in pairs}
for chunk in range(20):
    z=[samp(1_000_000) for _ in range(6)]
    w={e:ov(z[e[0]],z[e[1]]) for e in edges}
    W=np.exp(b*sum(w.values())); W/=W.sum()
    f={"w":lambda e:w[e],"w3":lambda e:w[e]**3,"ind":lambda e:(w[e]>0.7)*1.0}
    for p in pairs:
        X=f[p[0][0]](p[0][1]); Y=f[p[1][0]](p[1][1])
        res[p].append(np.sum(W*X*Y)-np.sum(W*X)*np.sum(W*Y))
for p,v in res.items():
    v=np.array(v); print(f"q=5 2x3 b={b}: Cov({p[0][0]}{p[0][1]}, {p[1][0]}{p[1][1]}) = {v.mean():+.3e} +- {v.std(ddof=1)/math.sqrt(len(v)):.1e}  (z={v.mean()/(v.std(ddof=1)/math.sqrt(len(v))):+.1f})")
