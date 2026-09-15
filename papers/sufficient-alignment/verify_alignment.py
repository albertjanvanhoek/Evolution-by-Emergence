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
