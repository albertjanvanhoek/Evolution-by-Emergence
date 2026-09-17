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

print("majority3(0.6) =", majority3(0.6))
print("majority3(0.9) =", majority3(0.9))
print("R_protocol(m=3,p=0.5) =", protocol_R(3, 0.5))
print("repair threshold =", threshold)
print("All sufficient-alignment checks passed.")


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

print("selected alignment insufficient example =", eopt)


# Recurrent-maintenance extension.
def deficit(r):
    return 1.0 - r

def cycle3_witness(rB, rC, kAB, kBC):
    """Canonical witness used by the Lean theorem."""
    xA = deficit(rB) * deficit(rC)
    xB = kAB * deficit(rC)
    xC = kAB * kBC
    return xA, xB, xC

def cycle3_step(rA, rB, rC, kAB, kBC, kCA, x):
    xA, xB, xC = x
    return (
        rA*xA + kCA*xC,
        rB*xB + kAB*xA,
        rC*xC + kBC*xB,
    )

# Example from the derivation: all nodes are individually subcritical,
# every two-node subgraph lacks a closed return cycle, but the full directed
# three-cycle lies above its canonical product threshold.
rA, rB, rC = 0.7, 0.6, 0.5
kAB, kBC, kCA = 0.5, 0.5, 0.3
loop_gain = kAB*kBC*kCA
deficit_product = deficit(rA)*deficit(rB)*deficit(rC)
assert abs(loop_gain - 0.075) < 1e-12
assert abs(deficit_product - 0.06) < 1e-12
assert loop_gain > deficit_product

x = cycle3_witness(rB, rC, kAB, kBC)
x_next = cycle3_step(rA, rB, rC, kAB, kBC, kCA, x)
assert all(v > 0 for v in x)
assert x_next[0] > x[0]
assert abs(x_next[1] - x[1]) < 1e-12
assert abs(x_next[2] - x[2]) < 1e-12

# Exact critical return-edge value for the same other parameters.
kCA_critical = deficit_product / (kAB*kBC)
assert abs(kCA_critical - 0.24) < 1e-12
x_critical_next = cycle3_step(rA, rB, rC, kAB, kBC, kCA_critical, x)
assert all(abs(a-b) < 1e-12 for a, b in zip(x_critical_next, x))

# Delete the return edge C -> A: positive subcritical A declines immediately.
x_deleted_next = cycle3_step(rA, rB, rC, kAB, kBC, 0.0, x)
assert x_deleted_next[0] < x[0]

print("three-cycle loop gain =", loop_gain)
print("three-cycle deficit product =", deficit_product)
print("critical k_CA =", kCA_critical)
print("recurrent-maintenance witness =", x)
print("recurrent-maintenance next state =", x_next)
