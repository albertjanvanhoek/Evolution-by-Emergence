#!/usr/bin/env python3
"""Where is the activity-entropy speed limit tight?

Single driven edge at constant asymmetry eps = J/A (J = net flux, A = activity).
  a = A(1+eps)/2,  b = A(1-eps)/2,  a/b = (1+eps)/(1-eps)
  sigma = (a-b) ln(a/b) = 2 eps A artanh(eps)
Over an interval of length tau with A constant:
  d   = |J| tau      = eps A tau
  N   = A tau
  Sig = 2 eps A tau artanh(eps)
"""
import sympy as sp

eps, A, tau, delta, K = sp.symbols('epsilon A tau delta K', positive=True)

J     = eps*A
sigma = J*sp.log((1+eps)/(1-eps))
d     = J*tau
N     = A*tau
Sig   = sigma*tau

print("="*70); print("per-interval: achieved d  vs  bound sqrt(N*Sig/2)"); print("="*70)
bound = sp.sqrt(N*Sig/2)
ratio = sp.simplify(d/bound)
print("  ratio =", sp.simplify(sp.powsimp(ratio, force=True)))
ratio_s = sp.simplify(ratio.rewrite(sp.atanh))
print("  rewritten:", sp.sqrt(eps/sp.atanh(eps)))
print("  limit eps->0 :", sp.limit(ratio, eps, 0))
print("  limit eps->1 :", sp.limit(ratio, eps, 1))
print("  (A and tau cancel entirely -> ratio depends only on eps)")

print()
print("="*70); print("cost per distinguishable transition, at fixed d = delta"); print("="*70)
Atau = sp.solve(sp.Eq(d, delta), A*tau)
Atau = delta/eps
N_n   = sp.simplify(Atau)
Sig_n = sp.simplify((2*eps*sp.atanh(eps))*Atau)
print("  N_n   =", N_n,        "   -> limit eps->0 :", sp.limit(N_n, eps, 0))
print("  Sig_n =", Sig_n, "   -> limit eps->0 :", sp.limit(Sig_n, eps, 0))
print("  product N_n*Sig_n =", sp.simplify(N_n*Sig_n))

print()
print("="*70); print("K transitions: achieved count vs the counting bound"); print("="*70)
Ntot, Stot = K*N_n, K*Sig_n
Kbound = sp.simplify(sp.sqrt(Ntot*Stot/2)/delta)
print("  K_bound =", sp.simplify(sp.powsimp(Kbound, force=True)))
print("  achieved/bound =", sp.simplify(K/Kbound))
print("  limit eps->0 :", sp.limit(K/Kbound, eps, 0))

print()
print("="*70); print("numerical ratio vs eps"); print("="*70)
f = sp.lambdify(eps, sp.sqrt(eps/sp.atanh(eps)), 'mpmath')
import mpmath
for e in [0.9, 0.5, 0.2, 0.1, 0.01, 1e-3, 1e-4]:
    print(f"   eps={e:<8g} ratio={float(f(e)):.6f}   N_n/delta={1/e:>10.1f}   Sig_n/delta={float(2*mpmath.atanh(e)):.3e}")

print()
print("="*70); print("Zhang's tighter form (arXiv:1811.06978)"); print("="*70)
# Zhang replaces the SFS denominator 2<A> by <B>, with
#   B = sum_{i<j} ( sqrt(F_ij) + sqrt(F_ji) )^2   <= 2A   (per edge),
# giving  L <= sqrt(Bcal * Sig)  in place of  L <= sqrt(2 Ncal * Sig),
# i.e.    d <= (1/2) sqrt(Bcal * Sig).
a_, b_ = A*(1+eps)/2, A*(1-eps)/2
B = sp.simplify((sp.sqrt(a_) + sp.sqrt(b_))**2)
print("  B/A            =", sp.simplify(B/A), "  ->", sp.simplify(sp.sqrt(B/A)**2))
print("  B/A at eps->0  =", sp.limit(B/A, eps, 0), "   (so B -> 2A: the two forms coincide)")
print("  B/A at eps->1  =", sp.limit(B/A, eps, 1))
Bcal = B*tau
rZ = sp.simplify(d/(sp.sqrt(Bcal*Sig)/2))
rZ = sp.sqrt(2*eps/(sp.atanh(eps)*(1+sp.sqrt(1-eps**2))))
print("  r_Z(eps)       = sqrt( 2 eps / ( artanh(eps) (1 + sqrt(1-eps^2)) ) )")
print("  limit eps->0   =", sp.limit(rZ, eps, 0))
print("  limit eps->1   =", sp.limit(rZ, eps, 1))
# independent numeric check of r_Z against the definition
import mpmath
print()
print("  eps        r_SFS       r_Zhang     B/(2A)      check |r_Z - d/(sqrt(B tau Sig)/2)|")
for e in [0.9, 0.5, 0.2, 0.05, 0.01, 1e-3]:
    aa, bb = (1+e)/2, (1-e)/2
    BB = (mpmath.sqrt(aa) + mpmath.sqrt(bb))**2
    dd, NN, SS = e, 1.0, 2*e*mpmath.atanh(e)          # A = tau = 1
    r_sfs = dd/mpmath.sqrt(NN*SS/2)
    r_z_def = dd/(mpmath.sqrt(BB*SS)/2)
    r_z_cf = mpmath.sqrt(2*e/(mpmath.atanh(e)*(1+mpmath.sqrt(1-e**2))))
    print(f"  {e:<10g} {float(r_sfs):<11.6f} {float(r_z_cf):<11.6f} "
          f"{float(BB/2):<11.6f} {float(abs(r_z_cf-r_z_def)):.2e}")
print()
print("  Both forms are saturated in the same limit, so the Zhang sharpening")
print("  does not move the saturating construction.")