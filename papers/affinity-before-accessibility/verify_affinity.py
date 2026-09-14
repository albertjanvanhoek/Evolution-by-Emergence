"""
Reproducibility checks for Affinity Before Accessibility.

Standard library only. The script verifies:
1. the closed-form linear-upkeep optimum and critical cost;
2. that a saturating overhead can remove the cost volcano;
3. the no-upkeep Sabatier-shaped turnover optimum;
4. exact rational turnover witnesses.
"""
from fractions import Fraction as F
from math import sqrt

# Original numerical affinity setup from the parallel agent.
f = 0.406930
lam0 = sqrt(1.0 + f)
pA = lam0 / (1.0 + lam0)
pB = (1.0 - f) / (1.0 + lam0)
K = min(pA / 0.30, pB / 0.15)


def productive_mass_linear(a):
    return 2.0 - 1.0 / (a * lam0)


def cost_score(a, c):
    return productive_mass_linear(a) / (1.0 + c * a)


def cost_margin(a, c):
    return K * cost_score(a, c) - 1.0


def a_star(c):
    return (1.0 + sqrt(1.0 + 2.0 * lam0 / c)) / (2.0 * lam0)


def c_crit():
    return lam0 * (2.0 * K - 1.0) ** 2 / (4.0 * K)


def stationary_residual(a, c):
    return 1.0 + 2.0 * c * a - 2.0 * c * lam0 * a * a


def peak_formula(c):
    s = sqrt(1.0 + 2.0 * lam0 / c)
    return 2.0 * K * (s - 1.0) / (s + 1.0) - 1.0


print("LINEAR-UPKEEP CHANNEL")
print(f"lam0={lam0:.9f}  K={K:.9f}  ccrit={c_crit():.9f}")
assert abs(c_crit() - 1.12304468645) < 2e-9

for c in [0.05, 0.10, 0.20, 0.50, 1.00, 2.00]:
    a = a_star(c)
    assert abs(stationary_residual(a, c)) < 1e-11
    assert abs(cost_margin(a, c) - peak_formula(c)) < 1e-11
    # Global square certificate at representative points.
    for b in [0.5 / lam0 + 1e-4, 0.8, 1.0, 2.0, 5.0, 20.0]:
        lhs = cost_score(a, c) - cost_score(b, c)
        rhs = (b - a) ** 2 / (b * a * a * lam0 * (1.0 + c * b))
        assert abs(lhs - rhs) < 2e-10
        assert lhs >= -2e-12
    print(f"c={c:4.2f}  a*={a:.6f}  Mmax={cost_margin(a,c):+.6f}")

# Critical point check.
cc = c_crit()
assert abs(peak_formula(cc)) < 2e-10
assert peak_formula(0.99 * cc) > 0.0
assert peak_formula(1.01 * cc) < 0.0

print("\nSATURATING-OVERHEAD COUNTEREXAMPLE")
c = 0.20
assert c * (2.0 * lam0 - 1.0) < 1.0

def sat_score(a):
    kappa = c * a / (1.0 + a)
    return productive_mass_linear(a) / (1.0 + kappa)

# The analytic derivative numerator is strictly positive under the condition.
def sat_deriv_numer(a):
    return 1.0 + 2.0 * (c + 1.0) * a + (c + 1.0 - 2.0 * c * lam0) * a * a

for a in [0.5/lam0 + 1e-4, 0.5, 0.8, 1.0, 2.0, 5.0, 20.0, 100.0]:
    assert sat_deriv_numer(a) > 0.0

grid = [0.5/lam0 + 1e-4 + i * 0.01 for i in range(20000)]
vals = [sat_score(a) for a in grid]
assert all(y > x for x, y in zip(vals, vals[1:]))
plateau_margin = K * (2.0 / (1.0 + c)) - 1.0
print(f"condition c(2lam0-1)={c*(2*lam0-1):.6f}<1")
print(f"monotone on checked grid; asymptotic margin plateau={plateau_margin:+.6f}")

print("\nTURNOVER / SABATIER CHANNEL")
def h(a):
    return 4.0 * a / (1.0 + a) ** 2

def turn_lam(a):
    return lam0 * h(a)

def turn_margin(a):
    L = turn_lam(a)
    if L <= 0.5:
        return -1.0
    return K * (2.0 - 1.0 / L) - 1.0

assert abs(h(1.0) - 1.0) < 1e-15
for a in [0.1, 0.2, 0.5, 0.8, 1.2, 2.0, 5.0, 10.0]:
    assert h(a) < 1.0
assert abs(turn_margin(1.0) - 1.09239446775) < 2e-9
print(f"peak at a=1: M={turn_margin(1.0):+.9f}")

# Exact rational witness used in Lean.
lam = F(6, 5)
Kq = F(56, 33)
def hq(a):
    return F(4) * a / (1 + a) ** 2
def turn_mass_q(a):
    return F(2) - F(1) / (lam * hq(a))
def margin_q(a):
    return Kq * turn_mass_q(a) - 1

assert margin_q(F(1)) == F(97,99)
assert margin_q(F(1,2)) == F(53,66)
assert margin_q(F(2)) == F(53,66)
assert lam * hq(F(1,10)) == F(48,121)
assert lam * hq(F(10)) == F(48,121)
assert F(48,121) < F(1,2)
print("exact rational witness:", margin_q(F(1)), margin_q(F(1,2)), margin_q(F(2)))
print("extreme lambda:", lam*hq(F(1,10)), "<", F(1,2))

print("\nALL AFFINITY CHECKS PASS")
