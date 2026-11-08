"""Independent Monte Carlo check of the CP^2 path identities in CPN_BOUNDARY_COMPARISON.md.

Integrates the spin model directly (uniform z on the unit sphere of C^3), without the loop
expansion, and compares with the exact values claimed there (q = 3, b1 = b2 = 1).
Run: python -I cpn_path_independent_mc.py   (about 10 s, 4e6 samples)
"""
import numpy as np, math
rng=np.random.default_rng(7); q=3; b1=b2=1.0; n=4_000_000
def samp(n):
    z=rng.normal(size=(n,q))+1j*rng.normal(size=(n,q)); return z/np.linalg.norm(z,axis=1)[:,None]
def ov(a,b): return np.abs(np.sum(np.conj(a)*b,axis=1))**2
u=np.array([1,0,0],complex); v=np.array([0,1,0],complex)
z=samp(n)
s_u=np.abs(z[:,0])**2; s_v=np.abs(z[:,1])**2
Zpin=np.mean(np.exp((b1+b2)*s_u)); Zorth=np.mean(np.exp(b1*s_u+b2*s_v))
print("Z_pin  MC %.5f  exact (e^2-3)/2 = %.5f"%(Zpin,(math.e**2-3)/2))
print("Z_orth MC %.5f  claimed 2 (b=1)"%Zorth)
print("1-Z_orth/Z_pin MC %.5f  claimed 0.08864"%(1-Zorth/Zpin))
# free path A-x-B: all three free; by invariance fix x=e1; C_AB = E[tr(PA PB)]-1/q
zA=samp(n); zB=samp(n)
w=np.exp(b1*np.abs(zA[:,0])**2+b2*np.abs(zB[:,0])**2)
C=np.sum(w*ov(zA,zB))/np.sum(w)-1/q
# error by batches
bs=[ (np.sum(w[i::10]*ov(zA[i::10],zB[i::10]))/np.sum(w[i::10])-1/q) for i in range(10)]
print("C_AB MC %.5f +- %.5f  claimed 0.0052000"%(C,np.std(bs)/math.sqrt(10)))
# Z_free = f_q(b)^2 with f_q(b)=sum b^k/(q)_k ; check f_q(1) = E[e^{b S}], S~Beta(1,q-1)
f=sum(1/math.prod(range(q,q+k)) for k in range(40))
print("f_q(1) series %.5f  MC E[e^S] %.5f"%(f,np.mean(np.exp(s_u))))
# three-pin trace example
uu=np.array([1,0,0]);vv=np.array([1,1,0])/math.sqrt(2);ww=np.array([1,-2,0])/math.sqrt(5)
P=lambda x:np.outer(x,x); print("tr(PuPvPw) =",np.trace(P(uu)@P(vv)@P(ww)))
