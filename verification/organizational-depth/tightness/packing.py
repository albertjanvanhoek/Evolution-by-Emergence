#!/usr/bin/env python3
"""Packing-depth checks for finite probability simplices under TV distance."""
import math
import numpy as np

def dtv(p, q):
    return 0.5 * np.abs(np.asarray(p) - np.asarray(q)).sum()

def volumetric_upper_bound(m, delta):
    return (1.0 + 2.0 / delta) ** (m - 1)

def exact_two_state(delta):
    return math.floor(1.0 / delta + 1e-12) + 1

def interior_ring_states(m, delta):
    q = (1.0 - delta) / m
    out=[]
    for i in range(m):
        p=np.full(m,q); p[i]+=delta; out.append(p)
    return out

for delta in [0.9, 0.5, 0.25]:
    print(f"two states, delta={delta}: exact packing={exact_two_state(delta)}")
assert exact_two_state(0.25) == 5

for m in [3,6,12]:
    states=interior_ring_states(m,0.5)
    assert all(dtv(states[i],states[j]) >= 0.5-1e-12
               for i in range(m) for j in range(i+1,m))
    print(f"m={m}: explicit packing lower bound={m}, volumetric upper bound={volumetric_upper_bound(m,0.5):.0f}")
