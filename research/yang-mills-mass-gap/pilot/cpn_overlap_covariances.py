# Sign of overlap covariances Cov(w_e, w_f) under the CP^{q-1} Gibbs measure exp(b sum_e w_e), w_e = |z_u^* z_v|^2.
import numpy as np, math, itertools
rng=np.random.default_rng(5); N=2_000_000
def samp(n,q):
    z=rng.normal(size=(n,q))+1j*rng.normal(size=(n,q)); return z/np.linalg.norm(z,axis=1)[:,None]
def ov(u,v): return np.abs(np.sum(np.conj(u)*v,axis=1))**2
for q in (2,3,5):
  for name,nv,edges in [("square",4,[(0,1),(1,2),(2,3),(0,3)]),("K4",4,[(0,1),(0,2),(0,3),(1,2),(1,3),(2,3)])]:
    z=[samp(N,q) for _ in range(nv)]
    w={e:ov(z[e[0]],z[e[1]]) for e in itertools.combinations(range(nv),2)}
    for b in (1.0,3.0):
        W=np.exp(b*sum(w[e] for e in edges)); W/=W.sum()
        out=[]
        for e,f in [((0,1),(1,2)),((0,1),(2,3)),((0,2),(1,3)),((0,1),(0,1))]:
            c=np.sum(W*w[e]*w[f])-np.sum(W*w[e])*np.sum(W*w[f])
            # error via batches
            cs=[]
            for i in range(10):
                Wi=W[i::10]/W[i::10].sum(); cs.append(np.sum(Wi*w[e][i::10]*w[f][i::10])-np.sum(Wi*w[e][i::10])*np.sum(Wi*w[f][i::10]))
            out.append(f"Cov(w{e[0]}{e[1]},w{f[0]}{f[1]})={c:+.5f}±{np.std(cs)/math.sqrt(10):.5f}")
        print(f"q={q} {name} b={b}: "+"  ".join(out),flush=True)
