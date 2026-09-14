"""
Reproducibility checks for When Does Change Become Cumulative?

Uses only the Python standard library. Exact claims are checked with Fraction.
The floating-point productive-extension witness is also reproduced from the
closed-form equilibrium formulas.
"""
from fractions import Fraction as F
from math import sqrt, log

B = F(1, 1)

def margin(binding):
    return B / binding - 1

# Exact two-click witness.
c0 = {"A": F(3,5), "B": F(3,10), "C": F(2), "D": F(2)}
c1 = {"A": F(33,70), "B": F(99,196), "C": F(3,7), "D": F(2)}
c2 = {"A": F(627,700), "B": F(1881,1960), "C": F(57,70), "D": F(19,21)}
direct = {"A": F(57,50), "B": F(57,100), "C": F(2), "D": F(19,18)}

acc0 = {k for k,v in c0.items() if v <= B}
acc1 = {k for k,v in c1.items() if v <= B}
acc2 = {k for k,v in c2.items() if v <= B}
acc_direct = {k for k,v in direct.items() if v <= B}

assert acc0 == {"A","B"}
assert acc1 == {"A","B","C"}
assert acc2 == {"A","B","C","D"}
assert acc0 < acc1 < acc2
assert "A" not in acc_direct
assert "D" not in acc_direct

M0 = margin(F(3,5))
M1 = margin(F(99,196))
kappa = F(9,10)
assert M0 == F(2,3)
assert M1 == F(97,99)
assert M0 < kappa <= M1

X0 = F(1)
X1 = F(7,6)
thetaD = F(1,2)
lo = X0*kappa/(1+kappa)
hi = X1*kappa/(1+kappa)
assert lo < thetaD <= hi
assert lo == F(9,19)
assert hi == F(21,38)

# Exact productive pointwise-domination witness used in the manuscript/Lean:
# f=1/100, v=125, lambda=3/2.
old = {"A": F(3,5), "B": F(3,10)}
new = {"A": F(753,2000), "B": F(2259,8000)}
assert all(new[k] < old[k] for k in old)
assert margin(new["A"]) == F(1247,753)

# Reproduce the corrected floating-point witness v=100, f=.01.
def non_substituting_extension(f, v):
    lam = sqrt(1 + v*f)
    X = 2 - 1/lam
    den = lam + 1 + f
    xA = X*lam/den
    xB = X/den
    xC = X*f/den
    return lam, X, xA, xB, xC

lam, X, xA, xB, xC = non_substituting_extension(0.01, 100.0)
cA, cB = 0.30/xA, 0.15/xB
assert cA < 0.60 and cB < 0.30
assert abs(cA - 0.39775) < 1e-4
assert abs(cB - 0.28125) < 1e-4

# Repeated-load topology checks.
# Sequential renormalization: multipliers compose.
kmin = 0.10
seq_bound = log(1 + float(M1)) / log(1 + kmin)
prod = 1.0
n_seq = 0
binding = float(F(99,196))
while binding * prod * (1+kmin) <= 1.0 + 1e-15:
    prod *= (1+kmin)
    n_seq += 1
assert n_seq == int(seq_bound)

# Simultaneous shared pool: intrinsic kappas add.
pool_bound = float(M1) / kmin
n_pool = 0
S = 0.0
while S + kmin <= float(M1) + 1e-15:
    S += kmin
    n_pool += 1
assert n_pool == int(pool_bound)

# Exact shared-pool realized-ratio identity at an arbitrary rational state.
Mbase = F(1,1)
S0 = F(1,3)
knew = F(1,4)
M_before = (Mbase - S0) / (1 + S0)
M_after = (Mbase - S0 - knew) / (1 + S0 + knew)
r_realized = (1 + S0 + knew) / (1 + S0)
k_eff = r_realized - 1
assert k_eff == knew / (1 + S0)
assert 1 + M_after == (1 + M_before) / r_realized
assert k_eff <= M_before
assert S0 + knew <= Mbase

print("Exact accessible sets:", acc0, "->", acc1, "->", acc2)
print("M0 =", M0, "M1 =", M1, "kappa =", kappa)
print("theta_D window =", lo, "<", thetaD, "<=", hi)
print("productive domination exact costs:", new)
print("v=100,f=.01 costs:", f"{cA:.5f}", f"{cB:.5f}")
print("sequential fixed-load bound:", seq_bound, "accepted loads:", n_seq)
print("shared-pool fixed-load bound:", pool_bound, "accepted loads:", n_pool)
print("shared-pool realized kappa_eff:", k_eff, "M before:", M_before, "M after:", M_after)
print("ALL CHECKS PASS")
