#!/usr/bin/env python3
"""End-to-end master-equation checks for transition-bound tightness.

The generator is reconstructed explicitly at every integration step. Both a
two-state shuttle and an interior finite-state ring asymptotically saturate
the SFS transition bound when each move has TV length exactly delta.
"""
import itertools
import numpy as np

def dtv(p, q):
    return 0.5 * np.abs(np.asarray(p) - np.asarray(q)).sum()

def max_pairwise_separated(states, delta):
    uniq=[]
    for s in states:
        if not any(dtv(s,u) < 1e-10 for u in uniq):
            uniq.append(np.array(s,dtype=float))
    n=len(uniq)
    if n>20:
        chosen=[]
        for s in uniq:
            if all(dtv(s,c) >= delta-1e-10 for c in chosen):
                chosen.append(s)
        return len(chosen),n
    for r in range(n,0,-1):
        for comb in itertools.combinations(range(n),r):
            if all(dtv(uniq[i],uniq[j]) >= delta-1e-10
                   for i,j in itertools.combinations(comb,2)):
                return r,n
    return 0,n

def driven_edge_step(p, src, dst, moved, eps, A0=1.0, steps=4000):
    a=A0*(1+eps)/2
    b=A0*(1-eps)/2
    J=a-b
    tau=moved/J
    dt=tau/steps
    N=S=0.0
    p=p.copy().astype(float)
    for _ in range(steps):
        assert p[src] > 0 and p[dst] > 0
        W=np.zeros((len(p),len(p)))
        W[dst,src]=a/p[src]
        W[src,dst]=b/p[dst]
        W[src,src]=-W[dst,src]
        W[dst,dst]=-W[src,dst]
        dp=W@p
        fwd=W[dst,src]*p[src]
        rev=W[src,dst]*p[dst]
        activity=fwd+rev
        sigma=(fwd-rev)*np.log(fwd/rev)
        p += dp*dt
        N += activity*dt
        S += sigma*dt
    return p,N,S

def run_shuttle(eps,delta,K,A0=1.0):
    p=np.array([0.5+delta/2,0.5-delta/2])
    visited=[p.copy()]
    N=S=0.0
    for k in range(K):
        src,dst=(0,1) if k%2==0 else (1,0)
        p,n,s=driven_edge_step(p,src,dst,delta,eps,A0)
        N+=n; S+=s; visited.append(p.copy())
    return N,S,visited

def ring_state(m,delta,peak):
    q=(1-delta)/m
    p=np.full(m,q); p[peak]+=delta
    return p

def run_interior_ring(m,eps,delta,K,A0=1.0):
    p=ring_state(m,delta,0)
    visited=[p.copy()]
    N=S=0.0
    for k in range(K):
        src,dst=k%m,(k+1)%m
        p,n,s=driven_edge_step(p,src,dst,delta,eps,A0)
        N+=n; S+=s
        assert np.max(np.abs(p-ring_state(m,delta,dst))) < 2e-6
        visited.append(p.copy())
    return N,S,visited

def report(label,N,S,states,delta):
    K=len(states)-1
    consecutive=sum(dtv(states[i],states[i+1]) >= delta-2e-6 for i in range(K))
    depth,uniq=max_pairwise_separated(states,delta-2e-6)
    bound=np.sqrt(N*S/2)/delta
    print(f"{label:<28} N={N:10.3f} Sigma={S:10.6f} bound={bound:9.4f} "
          f"K_consec={consecutive:4d} ratio={consecutive/bound:.6f} "
          f"packing-depth={depth:3d} unique={uniq:3d}")
    return bound,consecutive,depth

if __name__=="__main__":
    delta=0.5
    K=40
    print("Two-state shuttle")
    for eps in [0.5,0.2,0.05,0.01]:
        report(f"shuttle eps={eps:g}",*run_shuttle(eps,delta,K),delta)
    print("\nInterior 6-state ring")
    for eps in [0.2,0.05,0.01]:
        b,k,d=report(f"ring eps={eps:g}",*run_interior_ring(6,eps,delta,K),delta)
        assert d==6
    print("\nBudget scaling at fixed 6-state repertoire")
    for K in [12,60,300]:
        report(f"ring K={K}",*run_interior_ring(6,0.02,delta,K),delta)
