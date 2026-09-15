#!/usr/bin/env python3
"""Tightness of the Shiraishi--Funo--Saito activity--entropy bound."""
import math

def sfs_ratio(eps: float) -> float:
    return math.sqrt(eps / math.atanh(eps))

def per_transition_cost(delta: float, eps: float):
    return delta / eps, 2.0 * delta * math.atanh(eps)

print("SFS near-equilibrium saturation")
print("eps        ratio          N/delta       Sigma/delta")
for eps in [0.9, 0.5, 0.2, 0.1, 0.05, 0.01, 1e-3, 1e-4]:
    n, s = per_transition_cost(1.0, eps)
    print(f"{eps:<10g} {sfs_ratio(eps):.9f}   {n:>10.1f}   {s:>12.6g}")

assert sfs_ratio(0.01) > 0.9999
assert sfs_ratio(0.2) < 1.0
print("\nAs eps -> 0: ratio -> 1, N/delta -> infinity, Sigma/delta -> 0.")
