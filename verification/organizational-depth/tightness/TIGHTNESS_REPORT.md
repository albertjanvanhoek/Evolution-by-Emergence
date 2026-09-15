# Tightness, recurrence, and retained packing depth

This note supersedes the exploratory tightness report supplied on 15 September 2026. The original report found the key pathology correctly—consecutive fixed-resolution transitions can be accumulated by a two-state shuttle—but overinterpreted one ring simulation.

## 1. The transition bound is asymptotically sharp

For one driven edge with forward and reverse probability fluxes

[
a=rac{A(1+epsilon)}2,qquad b=rac{A(1-epsilon)}2,
]

the net flux is (J=epsilon A) and

[
sigma=(a-b)log(a/b)=2epsilon A,operatorname{artanh}epsilon.
]

Over duration (	au),

[
d_{m TV}=epsilon A	au,qquad
mathcal N=A	au,qquad
Sigma=2epsilon A	au,operatorname{artanh}epsilon,
]

hence

[
oxed{
rac{d_{m TV}}{sqrt{mathcal NSigma/2}}
=
sqrt{rac{epsilon}{operatorname{artanh}epsilon}}
longrightarrow1.
}
]

At fixed (d_{m TV}=delta),

[
mathcal N=delta/epsilon	oinfty,qquad
Sigma=2delta,operatorname{artanh}epsilon	o0.
]

Thus vanishing entropy production per resolved transition is purchased by diverging activity.

## 2. Consecutive transitions are not retained depth

A two-state shuttle can satisfy (d_{m op}(x_n,x_{n+1})gedelta) indefinitely while visiting only two distinguishable states. The former criterion therefore measured resolved path activity rather than retained organizational depth.

## 3. Correction to the exploratory ring conclusion

The original ring moved between simplex vertices, so each move had (d_{m TV}=1) while the counting threshold was (delta=0.5). The observed ratio (0.5) was therefore forced by travelling twice the minimum distance needed to count once.

A corrected interior family is

[
q=rac{1-delta}{m},qquad p^{(j)}=qmathbf1+delta e_j,
]

for which every distinct pair satisfies (d_{m TV}(p^{(i)},p^{(j)})=delta). Driving exactly (delta) mass from one peak to the next gives the same saturation ratio as the shuttle while cycling through (m) mutually separated states.

For (m=6,delta=0.5,epsilon=0.01), 40 moves give approximately

[
mathcal N_*=2000,quad Sigma_*=0.400013,quad K_{m bound}=40.0007,
]

with ratio (0.999983) and packing depth 6.

So saturation of the transition bound is neutral about retained depth.

## 4. Explicit master equation

The corrected simulation reconstructs finite rates at every step:

[
W_{dst,src}=a/p_{src},qquad W_{src,dst}=b/p_{dst}.
]

The shuttle remains away from the boundary, and the interior ring has positive background mass (q), so all rates remain finite. This removes the zero-probability caveat in the exploratory vertex-ring script.

## 5. Retained packing depth

For visited retained states (V(T)), define

[
D_delta(T)=
sup{|Y|:Ysubseteq V(T), d_{m op}(x,y)gedelta
	ext{ for all distinct }x,yin Y}.
]

Revisits are allowed; they simply do not increase depth.

## 6. The thermodynamic bound becomes a genuine depth bound

Choose (D) mutually separated visited representatives and order them chronologically. The (D-1) intervening gaps are disjoint and each has endpoint distance at least (delta). Therefore

[
(D-1)deltalesqrt{Sigma_*mathcal N_*/2},
]

so

[
oxed{
D_delta(T)le
1+rac1deltasqrt{rac{Sigma_*mathcal N_*}{2}}.
}
]

The finite-prefix mathematical core is machine-checked as
`pairwise_depth_resource_bound` in `OperationalBridge.lean`.

## 7. Geometry supplies an independent bound

By definition,

[
D_delta(T)lemathcal P_delta(mathcal X_T).
]

For a fixed finite (m)-state simplex under total variation, the standard finite-dimensional volumetric estimate gives

[
oxed{
mathcal P_delta(Delta_{m-1})
le
left(1+rac{2}{delta}ight)^{m-1}.
}
]

For two states the exact packing number is
(lfloor1/deltafloor+1). The exploratory greedy search missed the fifth point at (delta=0.25); the exact answer is 5.

## 8. Combined boundary

[
oxed{
D_delta(T)le
minleft{
1+rac1deltasqrt{rac{Sigma_*mathcal N_*}{2}},
mathcal P_delta(mathcal X_T)
ight}.
}
]

The first obstruction is dynamical resources; the second is geometric repertoire.

## 9. Escape route

The general requirement for unbounded fixed-resolution depth is not literally growing (|S|), but unbounded operational packing capacity. Growing state count, memory, record space, spatial support, or another operational degree of freedom can provide it—but the process that creates and maintains that capacity must then be physically accounted for.

## 10. Scope

The tightness calculation is for the Shiraishi--Funo--Saito form used in the manuscript. Yunxin Zhang's 2018 Comment (arXiv:1811.06978) presents a tighter alternative inequality; its tightness regime is not claimed here without a separate derivation against Zhang's exact modified-activity definition.

The simplex packing expression is a coarse standard upper bound, not an exact packing formula.
