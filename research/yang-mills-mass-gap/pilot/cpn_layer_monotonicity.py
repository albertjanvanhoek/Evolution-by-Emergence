#!/usr/bin/env python3
# Run: python -I cpn_layer_monotonicity.py   (about 1 min; 4e6 samples)
"""Star I={i1,i2}, O={o}, centre x, b on i1-x, i2-x, x-o, extra coupling t on i1-i2.
Reduction: given multiplicities, P(no crossing) = (q)_a (q)_c / (q)_{a+c}, a = n(i1x)+n(i2x), c = n(xo),
independent of the i1-i2 multiplicity m (sum over x's permutations, as in the two-vertex lemma).
Given the spins, n_e ~ Poisson(b_e |z_u^* z_v|^2) independently, so
P_t(cross) = E_t[ sum_{a,c} Pois(a; b(w1+w2)) Pois(c; b w3) (1 - (q)_a (q)_c/(q)_{a+c}) ]
with E_t the CP^{q-1} spin Gibbs measure. Estimated by reweighting one sample of uniform spins."""
import numpy as np, math
q=3; b=1.0; rng=np.random.default_rng(11); N=4_000_000
def samp(n):
    z=rng.normal(size=(n,q))+1j*rng.normal(size=(n,q)); return z/np.linalg.norm(z,axis=1)[:,None]
def ov(u,v): return np.abs(np.sum(np.conj(u)*v,axis=1))**2
def poch(d):
    r=1.0
    for k in range(d): r*=q+k
    return r
M=40
h=np.array([[1-poch(a)*poch(c)/poch(a+c) for c in range(M)] for a in range(M)])
def pois(lam):  # matrix n x M
    k=np.arange(M); return np.exp(-lam[:,None]+k[None,:]*np.log(np.maximum(lam[:,None],1e-300))-np.array([math.lgamma(x+1) for x in k])[None,:])
zi1,zi2,zx,zo=samp(N),samp(N),samp(N),samp(N)
w1,w2,w3,w12=ov(zi1,zx),ov(zi2,zx),ov(zo,zx),ov(zi1,zi2)
Pa=pois(b*(w1+w2)); Pc=pois(b*w3)
Eh=np.einsum('na,ac,nc->n',Pa,h,Pc)
base=b*(w1+w2+w3)
res=[]
for t in (0,0.5,1,2,4,8):
    W=np.exp(base+t*w12-(b*3+t))
    P=np.sum(W*Eh)/np.sum(W)
    bs=[np.sum(W[i::20]*Eh[i::20])/np.sum(W[i::20]) for i in range(20)]
    res.append((t,P,np.std(bs)/math.sqrt(20)))
# exact anchors
f=lambda x: sum(x**n/poch(n) for n in range(80))
Zorth=lambda b1,b2: sum(b1**m*b2**n/poch(m+n) for m in range(60) for n in range(60))
star0 = 1 - sum((1/(poch(a1)*poch(a2)*poch(c)))*poch(a1+a2)*poch(c)/poch(a1+a2+c) for a1 in range(40) for a2 in range(40) for c in range(40))/f(1)**3
fused = 1 - Zorth(2*b,b)/(f(2*b)*f(b))
print("exact t=0 (star):", round(star0,6), "  exact t=inf (fused):", round(fused,6))
for t,P,e in res: print(f"t={t}: P_cross={P:.6f} +- {e:.6f}")
# common-sample differences
W0=np.exp(base-3*b)
for t1,t2 in ((0,0.5),(0.5,1),(1,2),(2,4),(4,8)):
    d=[]
    for i in range(20):
        sl=slice(i,None,20)
        Wa=W0[sl]*np.exp(t1*w12[sl]); Wb=W0[sl]*np.exp(t2*w12[sl])
        d.append(np.sum(Wb*Eh[sl])/np.sum(Wb)-np.sum(Wa*Eh[sl])/np.sum(Wa))
    print(f"P(t={t2})-P(t={t1}) = {np.mean(d):+.6f} +- {np.std(d)/math.sqrt(20):.6f}")
