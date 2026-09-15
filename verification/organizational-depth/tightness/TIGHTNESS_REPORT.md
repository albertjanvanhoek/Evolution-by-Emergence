# Tightness, recurrence, and retained packing depth

This note supersedes the exploratory tightness report supplied on 15 September 2026. The original report found the key pathology correctly—consecutive fixed-resolution transitions can be accumulated by a two-state shuttle—but overinterpreted one ring simulation. The original report is preserved in \`archive/\`.

## 1. The transition bound is asymptotically sharp

For one driven edge with forward and reverse probability fluxes

\[
a=\frac{A(1+\epsilon)}2,\qquad
b=\frac{A(1-\epsilon)}2,
\]

the net flux is \(J=\epsilon A\) and

\[
\sigma=(a-b)\log(a/b)
=
2\epsilon A\,\operatorname{artanh}\epsilon.
\]

Over duration \(\tau\),

\[
d_{\rm TV}=\epsilon A\tau,\qquad
\mathcal N=A\tau,\qquad
\Sigma=2\epsilon A\tau\,\operatorname{artanh}\epsilon,
\]

hence

\[
\boxed{
\frac{d_{\rm TV}}{\sqrt{\mathcal N\Sigma/2}}
=
\sqrt{\frac{\epsilon}{\operatorname{artanh}\epsilon}}
\longrightarrow1
\qquad(\epsilon\to0).
}
\]

At fixed \(d_{\rm TV}=\delta\),

\[
\mathcal N=\frac{\delta}{\epsilon}\to\infty,\qquad
\Sigma=2\delta\,\operatorname{artanh}\epsilon\to0.
\]

Thus vanishing entropy production per resolved transition is purchased by diverging activity. The bound is asymptotically sharp; at every finite \(\epsilon>0\), the ratio remains below one.

## 2. Consecutive transitions are not retained depth

A two-state shuttle can satisfy

\[
d_{\rm op}(x_n,x_{n+1})\ge\delta
\]

indefinitely while visiting only two distinguishable states. The former criterion therefore measured resolved path activity rather than retained organizational depth.

## 3. Correction to the exploratory ring conclusion

The original ring moved between simplex vertices, so each move had \(d_{\rm TV}=1\) while the counting threshold was \(\delta=0.5\). The observed ratio \(0.5\) was therefore forced by travelling twice the minimum distance needed to count once.

For \(0<\delta<1\), a corrected interior family is

\[
q=\frac{1-\delta}{m},\qquad
p^{(j)}=q\mathbf1+\delta e_j,
\]

for which every distinct pair satisfies

\[
d_{\rm TV}(p^{(i)},p^{(j)})=\delta.
\]

Driving exactly \(\delta\) probability mass from one peak to the next gives the same saturation ratio as the shuttle while cycling through \(m\) mutually separated states.

For \(m=6,\delta=0.5,\epsilon=0.01\), 40 moves give approximately

\[
\mathcal N_*=2000,\qquad
\Sigma_*=0.400013,\qquad
K_{\rm bound}=40.0007,
\]

with ratio \(0.999983\) and packing depth 6.

So saturation of the transition bound is neutral about retained depth.

## 4. Explicit master equation

The corrected simulation reconstructs finite rates at every step:

\[
W_{\rm dst,src}=\frac{a}{p_{\rm src}},\qquad
W_{\rm src,dst}=\frac{b}{p_{\rm dst}}.
\]

The shuttle remains away from the boundary, and the interior ring has positive background mass \(q\), so all rates remain finite. This removes the zero-probability caveat in the exploratory vertex-ring script.

## 5. Retained packing depth

For visited retained states \(V(T)\), define

\[
D_\delta(T)=
\sup\left\{
|Y|:
Y\subseteq V(T),\;
Y\text{ finite},\;
d_{\rm op}(x,y)\ge\delta
\text{ for all distinct }x,y\in Y
\right\}.
\]

Revisits are allowed; they simply do not increase depth.

## 6. The thermodynamic bound becomes a genuine depth bound

Choose \(D\) mutually separated visited representatives and order them chronologically. The \(D-1\) intervening gaps are disjoint and each has endpoint distance at least \(\delta\). Therefore

\[
(D-1)\delta
\le
\sqrt{\frac{\Sigma_*\mathcal N_*}{2}},
\]

so

\[
\boxed{
D_\delta(T)
\le
1+
\frac1\delta
\sqrt{\frac{\Sigma_*\mathcal N_*}{2}}.
}
\]

The finite-prefix mathematical core is machine-checked as
\`pairwise_depth_resource_bound\` in \`OperationalBridge.lean\`.

## 7. Geometry supplies an independent bound

By definition,

\[
D_\delta(T)\le\mathcal P_\delta(\mathcal X_T).
\]

For a fixed finite \(m\)-state simplex under total variation, the standard finite-dimensional volumetric estimate gives

\[
\boxed{
\mathcal P_\delta(\Delta_{m-1})
\le
\left(1+\frac{2}{\delta}\right)^{m-1}.
}
\]

For two states the exact packing number is

\[
\left\lfloor\frac1\delta\right\rfloor+1.
\]

The exploratory greedy search missed the fifth point at \(\delta=0.25\); the exact answer is 5.

## 8. Combined boundary

\[
\boxed{
D_\delta(T)
\le
\min\left\{
1+
\frac1\delta
\sqrt{\frac{\Sigma_*\mathcal N_*}{2}},
\;
\mathcal P_\delta(\mathcal X_T)
\right\}.
}
\]

The first obstruction is dynamical resources; the second is geometric repertoire.

## 9. Escape route

The general requirement for unbounded fixed-resolution depth is not literally growing \(|S|\), but **unbounded operational packing capacity**. Growing state count, memory, record space, spatial support, or another operational degree of freedom can provide it—but the process that creates and maintains that capacity must then be physically accounted for.

## 10. Scope

The tightness calculation is for the Shiraishi--Funo--Saito form used in the manuscript. Yunxin Zhang's 2018 Comment (arXiv:1811.06978) presents a tighter alternative inequality; its tightness regime is not claimed here without a separate derivation against Zhang's exact modified-activity definition.

The simplex packing expression is a coarse standard upper bound, not an exact packing formula.
