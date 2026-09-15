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


def cubic_roots(A: float, B: float, C: float):
    """Durand-Kerner roots of z^3 + A z^2 + B z + C."""
    def poly(z):
        return z**3 + A*z**2 + B*z + C

    roots = [1+0j, complex(-0.4, 0.9), complex(-0.4, -0.9)]
    for _ in range(200):
        new = []
        for i, z in enumerate(roots):
            denom = 1+0j
            for j, w in enumerate(roots):
                if i != j:
                    denom *= z - w
            new.append(z - poly(z) / denom)
        if max(abs(new[i] - roots[i]) for i in range(3)) < 1e-14:
            roots = new
            break
        roots = new
    return sorted(roots, key=lambda z: (z.real, z.imag))

def characteristic_roots(gamma: float):
    A = delta + epsilon + a*b*gamma
    B = delta*epsilon + a*b*epsilon*gamma
    C = a*alpha*b*epsilon
    return cubic_roots(A, B, C)

roots0 = characteristic_roots(0.0)
roots06 = characteristic_roots(0.6)
print("roots(gamma=0):", roots0)
print("roots(gamma=0.6):", roots06)
assert max(z.real for z in roots0) > 0.0
assert max(z.real for z in roots06) < 0.0
