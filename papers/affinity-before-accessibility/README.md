# Affinity Before Accessibility

Companion note for the Evolution by Emergence / Organizational Accessibility stack.

The note isolates a layer that the production matrix \(B\) takes as given: why components remain associated long enough to become productive couplings.

It separates two independent mechanisms.

## 1. Cost channel

\[
B(a)=aB_0,\qquad \kappa(a)=ca.
\]

The declared margin is

\[
M_c(a)+1
=
K\frac{2-1/(a\lambda_0)}{1+ca}.
\]

For \(c>0\),

\[
a^\star=
\frac{1+\sqrt{1+2\lambda_0/c}}{2\lambda_0}.
\]

The maximum is global. If \(K>1/2\),

\[
c_{\rm crit}
=
\frac{\lambda_0(2K-1)^2}{4K}
\]

is the linear-upkeep ceiling for nonnegative peak margin.

This mechanism requires the stated unbounded upkeep law. A saturating overhead can remove the high-affinity downturn.

## 2. Turnover/Sabatier channel

\[
\kappa\equiv0,
\qquad
\lambda(a)
=
\lambda_0\frac{4a}{(1+a)^2}.
\]

Because

\[
\frac{4a}{(1+a)^2}\le1
\]

with equality only at \(a=1\), productive mass and declared margin peak at intermediate affinity even with zero maintained-association overhead.

This is the mechanism that is directly analogous to the Sabatier principle: too weak to hold, too strong to release.

## Formalization

See:

    formalization/affinity-layer/AffinityLayer.lean

The Lean file machine-checks the global cost-optimum certificate, the explicit optimizer, the peak-height formula, the turnover maximum, and exact rational turnover witnesses.

## Reproducibility

See:

    papers/affinity-before-accessibility/verify_affinity.py

and the GitHub Actions affinity-layer workflow.
