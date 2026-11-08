import numpy as np, time
from su2 import *
rng=np.random.default_rng(1)
# 1. qmul vs matrices
s=[np.array([[0,1],[1,0]],complex),np.array([[0,-1j],[1j,0]]),np.array([[1,0],[0,-1]],complex)]
def mat(a): return a[0]*np.eye(2)+1j*sum(a[k+1]*s[k] for k in range(3))
a=random_su2((),rng); b=random_su2((),rng)
print("qmul err", np.abs(mat(qmul(a,b))-mat(a)@mat(b)).max(), "dag err", np.abs(mat(qdag(a))-mat(a).conj().T).max())
# 2. gauge invariance + staple consistency
L=4
U=random_su2((4,L,L,L,L),rng)
p0=mean_plaquette(U); W0=loop_RR(U,0,1,2)[...,0].mean()
random_gauge(U,rng); print("gauge inv plaq", p0-mean_plaquette(U), "2x2", W0-loop_RR(U,0,1,2)[...,0].mean())
# staple: sum over plaquettes containing U_mu(x) of Tr = Tr(U A)
mu=2
A=staple(U,mu); loc=(2*qmul(U[mu],A)[...,0]).sum()
tot=0
for nu in range(4):
    if nu==mu: continue
    a_,b_=(mu,nu) if mu<nu else (nu,mu)
    tot+=2*2*plaquette_field(U,a_,b_)[...,0].sum()
print("staple check", loc, tot)
# 3. plaquette values
for beta,L,nth,nm in [(0.5,4,50,50),(2.3,6,200,100),(2.5,6,200,100)]:
    U=cold(L); t=time.time()
    for i in range(nth): sweep(U,beta,rng)
    ps=[]
    for i in range(nm): sweep(U,beta,rng); ps.append(mean_plaquette(U))
    ps=np.array(ps); print(f"beta={beta} L={L} <P>={ps.mean():.4f} +- {ps.std()/np.sqrt(len(ps)/5):.4f}  t/sweep={(time.time()-t)/(nth+nm):.3f}s")
