#!/usr/bin/env python3
# Run: python -I cpn_star_edge_derivative.py Q B1,B2,...   (exact tree sampling; Poisson draws; about 1 min per b)
# Star i1,i2 -- x -- o, coupling b; derivative at t=0 of the crossing probability w.r.t. an i1-i2 coupling t.
import numpy as np, math, sys
from scipy.special import gammaln
q=int(sys.argv[1]); bs=[float(x) for x in sys.argv[2].split(",")]
rng=np.random.default_rng(29)
def hfun(a,c): return 1-np.exp(gammaln(q+a)+gammaln(q+c)-gammaln(q)-gammaln(q+a+c))
def sample_w(b,n):
    g=np.linspace(0,1,200001); d=np.exp(b*(g-1))*(1-g)**(q-2); c=np.cumsum(d); c/=c[-1]
    return np.interp(rng.random(n),c,g)
def leaf(w,n):
    u=rng.normal(size=(n,q-1))+1j*rng.normal(size=(n,q-1)); u/=np.linalg.norm(u,axis=1)[:,None]
    z=np.zeros((n,q),complex); z[:,0]=np.sqrt(w)*np.exp(2j*np.pi*rng.random(n)); z[:,1:]=np.sqrt(1-w)[:,None]*u
    return z
for b in bs:
    vals=[]; Ps=[]
    for chunk in range(10):
        n=2_000_000
        w1,w2,w3=sample_w(b,n),sample_w(b,n),sample_w(b,n)
        w12=np.abs(np.sum(np.conj(leaf(w1,n))*leaf(w2,n),axis=1))**2
        a=rng.poisson(b*(w1+w2)); c=rng.poisson(b*w3)
        H=hfun(a,c)
        vals.append(np.mean(H*w12)-np.mean(H)*np.mean(w12)); Ps.append(H.mean())
    v=np.array(vals); print(f"q={q} b={b}: P_0(cross)={np.mean(Ps):.4f}  dP/dt|0 = {v.mean():+.3e} +- {v.std(ddof=1)/math.sqrt(10):.1e}",flush=True)
