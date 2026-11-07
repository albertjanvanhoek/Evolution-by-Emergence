import numpy as np, math
rng=np.random.default_rng(41); q=3; bu,bv,ba=1.0,1.0,1.0
def poch(s,d):
    r=1.0
    for k in range(d): r*=s+k
    return r
def eig(p): s=bu+bv; D=bu*bv*(1-p); disc=math.sqrt(max(s*s-4*D,0)); return (s+disc)/2,(s-disc)/2
def H(d,p):
    lp,lm=eig(p); return sum(lp**j*lm**(d-j) for j in range(d+1))
def w(d,p): return H(d,p)/poch(q,d)
f=lambda s,b: sum(b**m/poch(s,m) for m in range(80))
# (i) moment identity: G(p) = E exp(bu tr(PuPx)+bv tr(PvPx)) vs sum_d w_d(p)
p=0.3
u=np.zeros(q,complex); u[0]=1; v=np.zeros(q,complex); v[0]=math.sqrt(p); v[1]=math.sqrt(1-p)
z=rng.normal(size=(4_000_000,q))+1j*rng.normal(size=(4_000_000,q)); z/=np.linalg.norm(z,axis=1)[:,None]
G_mc=np.mean(np.exp(bu*np.abs(z@np.conj(u))**2+bv*np.abs(z@np.conj(v))**2))
print("G(0.3): MC %.5f  series %.5f"%(G_mc, sum(w(d,p) for d in range(80))))
# (ii) MLR: H_d(p1)/H_d(p0) increasing in d for p1>p0
ok=True
for p0,p1 in [(0,0.3),(0.3,0.7),(0.7,0.99),(0,1)]:
    r=[H(d,p1)/H(d,p0) for d in range(40)]
    ok &= all(r[i+1]>=r[i]-1e-12 for i in range(39))
print("MLR in d holds on tested pairs:",ok)
# (iii) h_side(p) increasing in p
def h(p): 
    num=sum(w(d,p)*f(q+d,ba) for d in range(80)); den=f(q,ba)*sum(w(d,p) for d in range(80)); return 1-num/den
hs=[h(p) for p in np.linspace(0,1,11)]
print("h_side(p) for p=0..1:", " ".join("%.5f"%x for x in hs), " increasing:", all(hs[i+1]>=hs[i] for i in range(10)))
# p=1 consistency with path formula: 1 - Zorth(s,ba)/(f(s)f(ba))
s=bu+bv; Zo=sum(s**m*ba**n/poch(q,m+n) for m in range(60) for n in range(60))
print("h_side(1) %.6f vs path formula %.6f"%(h(1.0), 1-Zo/(f(q,s)*f(q,ba))))
