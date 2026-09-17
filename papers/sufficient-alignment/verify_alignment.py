#!/usr/bin/env python3
"""Numerical checks for the sufficient-alignment paper."""

from math import comb


def majority3(p):
    return 3*p*p - 2*p*p*p


def koutofn(n, k, p):
    return sum(comb(n, j) * p**j * (1-p)**(n-j) for j in range(k, n+1))


def protocol_R(m, p):
    return m*p


def repair_value(r, V, W, C):
    return r*V + (1-r)*W - C


def terminate_value(W):
    return W


def dyad_maintenance_ratio(rA, rB, kAB, kBA):
    return (kAB * kBA) / ((1-rA) * (1-rB))


def triad_maintenance_ratio(rA, rB, rC, kAB, kBC, kCA):
    return (kAB * kBC * kCA) / ((1-rA) * (1-rB) * (1-rC))


def matvec(matrix, vector):
    return [sum(a*b for a, b in zip(row, vector)) for row in matrix]


def power_iteration_nonnegative(matrix, steps=500):
    """Approximate the Perron root of a small nonnegative irreducible matrix."""
    n = len(matrix)
    v = [1.0 / n] * n
    lam = 0.0
    for _ in range(steps):
        w = matvec(matrix, v)
        scale = max(abs(x) for x in w)
        if scale == 0.0:
            return 0.0
        v = [x / scale for x in w]
        lam = scale
    return lam


# Exact 2-out-of-3 formula matches binomial tail.
for p in [0.0, 0.1, 0.5, 0.6, 0.9, 1.0]:
    assert abs(majority3(p) - koutofn(3, 2, p)) < 1e-12

# Exact half threshold and redundancy gain examples.
assert abs(majority3(0.5) - 0.5) < 1e-12
assert majority3(0.6) > 0.6
assert majority3(0.9) > 0.9
assert majority3(0.4) < 0.5

# Monotonic grid check.
grid = [i/1000 for i in range(1001)]
vals = [majority3(p) for p in grid]
assert all(a <= b + 1e-15 for a, b in zip(vals, vals[1:]))

# Protocol reproduction threshold.
assert protocol_R(3, 0.2) < 1
assert protocol_R(3, 1/3) == 1
assert protocol_R(3, 0.5) > 1

# Expected carriers in homogeneous mean model.
N0 = 10
assert N0 * protocol_R(3, 0.5)**5 > N0
assert N0 * protocol_R(3, 0.2)**5 < N0

# Repair boundary examples.
r, V, W = 0.8, 10.0, 2.0
threshold = r*(V-W)
assert threshold == 6.4
assert repair_value(r, V, W, 5.0) > terminate_value(W)
assert abs(repair_value(r, V, W, threshold) - terminate_value(W)) < 1e-12
assert repair_value(r, V, W, 7.0) < terminate_value(W)

# Selected versus sufficient alignment toy model.
def selected_alignment(v, cost):
    return v / cost


def alignment_objective(v, cost, e):
    return v*e - 0.5*cost*e*e


v, cost = 0.2, 1.0
eopt = selected_alignment(v, cost)
assert abs(eopt - 0.2) < 1e-12
assert 2*v < cost
assert eopt < 0.5
for e in [0.0, 0.1, 0.2, 0.5, 1.0]:
    assert alignment_objective(v, cost, e) <= alignment_objective(v, cost, eopt) + 1e-12

v2, cost2 = 0.4, 0.7
assert 2*v2 >= cost2
assert selected_alignment(v2, cost2) >= 0.5

# Maintenance-reproduction checks.
rA, rB = 0.7, 0.6
assert dyad_maintenance_ratio(rA, rB, 0.4, 0.35) > 1
assert dyad_maintenance_ratio(rA, rB, 0.4, 0.25) < 1
assert dyad_maintenance_ratio(rA, rB, 0.4, 0.0) == 0

rA, rB, rC = 0.7, 0.6, 0.5
kAB, kBC, kCA = 0.5, 0.5, 0.3
triad_ratio = triad_maintenance_ratio(rA, rB, rC, kAB, kBC, kCA)
assert abs(triad_ratio - 1.25) < 1e-12
assert triad_ratio > 1

# Exact critical closing edge: product gains equal product deficits.
kCA_critical = ((1-rA)*(1-rB)*(1-rC)) / (kAB*kBC)
assert abs(kCA_critical - 0.24) < 1e-12
assert abs(triad_maintenance_ratio(rA, rB, rC, kAB, kBC, kCA_critical) - 1.0) < 1e-12
assert triad_maintenance_ratio(rA, rB, rC, kAB, kBC, 0.20) < 1
assert triad_maintenance_ratio(rA, rB, rC, kAB, kBC, 0.30) > 1
assert triad_maintenance_ratio(rA, rB, rC, kAB, kBC, 0.0) == 0

# Every induced dyad in the one-directional three-cycle is open-loop.
assert dyad_maintenance_ratio(rA, rB, kAB, 0.0) == 0
assert dyad_maintenance_ratio(rB, rC, kBC, 0.0) == 0
assert dyad_maintenance_ratio(rC, rA, kCA, 0.0) == 0

# Independent numerical check of the full triad's dominant eigenvalue.
M = [
    [rA, 0.0, kCA],
    [kAB, rB, 0.0],
    [0.0, kBC, rC],
]
perron = power_iteration_nonnegative(M)
assert perron > 1.0
assert abs(perron - 1.0296) < 5e-4

# Opening the return edge makes the matrix triangular and subcritical.
M_open = [
    [rA, 0.0, 0.0],
    [kAB, rB, 0.0],
    [0.0, kBC, rC],
]
perron_open = power_iteration_nonnegative(M_open)
assert perron_open < 1.0
assert abs(perron_open - rA) < 1e-3

print("majority3(0.6) =", majority3(0.6))
print("majority3(0.9) =", majority3(0.9))
print("R_protocol(m=3,p=0.5) =", protocol_R(3, 0.5))
print("repair threshold =", threshold)
print("selected alignment insufficient example =", eopt)
print("triad maintenance ratio =", triad_ratio)
print("triad Perron root ~=", perron)
print("open-chain Perron root ~=", perron_open)
print("All sufficient-alignment checks passed.")
