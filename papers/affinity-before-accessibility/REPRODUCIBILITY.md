# Reproducibility

## Cost channel

\[
F_c(a)
=
\frac{2-1/(a\lambda_0)}{1+ca}.
\]

Stationarity:

\[
1+2ca-2c\lambda_0a^2=0.
\]

Positive optimizer:

\[
a^\star
=
\frac{1+\sqrt{1+2\lambda_0/c}}{2\lambda_0}.
\]

Global certificate:

\[
F_c(a^\star)-F_c(a)
=
\frac{(a-a^\star)^2}
{a(a^\star)^2\lambda_0(1+ca)}.
\]

Peak:

\[
F_c(a^\star)
=
2\frac{s-1}{s+1},
\qquad
s=\sqrt{1+2\lambda_0/c}.
\]

With margin \(M+1=KF_c\), the peak is nonnegative iff

\[
c\le
\frac{\lambda_0(2K-1)^2}{4K}
\]

for \(K>1/2\).

## Saturating-overhead counterexample

For

\[
\kappa(a)=\frac{ca}{1+a},
\]

the score derivative has positive denominator and numerator

\[
1+2(c+1)a+
(c+1-2c\lambda_0)a^2.
\]

Thus

\[
c(2\lambda_0-1)\le1
\]

is sufficient for strict monotonic increase over \(a>0\). This demonstrates that the cost volcano depends on its overhead law.

## Turnover channel

\[
h(a)=\frac{4a}{(1+a)^2}.
\]

Because

\[
(1+a)^2-4a=(a-1)^2\ge0,
\]

\[
0<h(a)\le1
\]

for \(a>0\), with equality only at \(a=1\).

With

\[
\lambda(a)=\lambda_0h(a),
\qquad
\kappa=0,
\]

productive mass

\[
X(a)=2-\frac1{\lambda(a)}
\]

is maximized at \(a=1\).

## Local reproduction

Lean:

    cd formalization/affinity-layer
    lake update
    lake exe cache get
    lake build

Numerical and closed-form checks:

    python papers/affinity-before-accessibility/verify_affinity.py

## Formalization scope

Lean checks the reduced algebra. It does not derive the affinity laws from chemistry, mechanics, or the full production-network ODEs.
