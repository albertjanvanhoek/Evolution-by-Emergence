# Stronger test of conjecture B: Cov(F(w), G(w)) for increasing F, G of the overlaps, CP^{q-1} Gibbs measure.
import numpy as np, math, itertools
rng=np.random.default_rng(9); N=2_000_000
def samp(n,q):
    z=rng.normal(size=(n,q))+1j*rng.normal(size=(n,q)); return z/np.linalg.norm(z,axis=1)[:,None]
def ov(u,v): return np.abs(np.sum(np.conj(u)*v,axis=1))**2
graphs={"square":(4,[(0,1),(1,2),(2,3),(0,3)]),"K4":(4,list(itertools.combinations(range(4),2))),
        "2x3 grid":(6,[(0,1),(1,2),(3,4),(4,5),(0,3),(1,4),(2,5)])}
worst=(1,None)
for q in (2,3,5):
  for gname,(nv,edges) in graphs.items():
    z=[samp(N,q) for _ in range(nv)]
    w={e:ov(z[e[0]],z[e[1]]) for e in itertools.combinations(range(nv),2)}
    for b in (1.0,3.0):
        W=np.exp(b*sum(w[e] for e in edges)); 
        ee=edges
        tests=[]
        # increasing functions of edge overlaps
        F=[("w_e",lambda e: w[e]),("1{w_e>0.7}",lambda e:(w[e]>0.7)*1.0),("w_e^3",lambda e:w[e]**3)]
        for (fa,fA),(fb,fB) in itertools.product(F,F):
            for e,f in itertools.combinations(ee,2):
                X=fA(e); Y=fB(f)
                cs=[]
                for i in range(8):
                    Wi=W[i::8]; Wi=Wi/Wi.sum()
                    cs.append(np.sum(Wi*X[i::8]*Y[i::8])-np.sum(Wi*X[i::8])*np.sum(Wi*Y[i::8]))
                m=np.mean(cs); s=np.std(cs)/math.sqrt(8)
                tests.append((m/ (s+1e-12), m, fa,fb,e,f))
        # also min over two edges vs third
        z_=min(tests)
        print(f"q={q} {gname} b={b}: {len(tests)} covariances, most negative z-score {z_[0]:+.2f} (cov {z_[1]:+.2e}, {z_[2]}@{z_[4]} vs {z_[3]}@{z_[5]})",flush=True)
