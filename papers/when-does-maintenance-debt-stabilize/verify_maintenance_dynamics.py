#!/usr/bin/env python3
"""Reproduce the maintenance-debt threshold using only the Python standard library."""

from math import sqrt

alpha = 1.0
c = 0.2
a = 1.0
delta = 0.2
epsilon = 0.2

h_star = 1.0 - c / alpha
K_star = h_star
x_star = (delta / a) * h_star
b = x_star * (1.0 - x_star)

y_crit = (sqrt(epsilon**2 + 4.0 * a * alpha * b) - epsilon) / 2.0
gamma_crit = (y_crit - delta) / (a * b)

def hurwitz_lhs(gamma: float) -> float:
    y = delta + a * b * gamma
    return y * (y + epsilon)

rhs = a * alpha * b

print(f"h* = K* = {h_star:.12f}")
print(f"x* = {x_star:.12f}")
print(f"b = {b:.12f}")
print(f"y_crit = {y_crit:.12f}")
print(f"gamma_crit = {gamma_crit:.12f}")
print(f"base lhs = {hurwitz_lhs(0.0):.12f}")
print(f"rhs = {rhs:.12f}")
print(f"lhs(gamma_crit) = {hurwitz_lhs(gamma_crit):.12f}")
print(f"lhs(0.6) = {hurwitz_lhs(0.6):.12f}")

assert abs(h_star - 0.8) < 1e-12
assert abs(x_star - 0.16) < 1e-12
assert abs(b - 0.1344) < 1e-12
assert abs(y_crit - 0.28) < 1e-12
assert abs(gamma_crit - (25.0 / 42.0)) < 1e-12
assert hurwitz_lhs(0.0) < rhs
assert abs(hurwitz_lhs(gamma_crit) - rhs) < 1e-12
assert hurwitz_lhs(0.6) > rhs

print("All checks passed.")
