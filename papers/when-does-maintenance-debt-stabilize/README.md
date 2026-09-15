# When Does Maintenance Debt Stabilize?

## Exact thresholds in a slow-fast feedback system

This package contains the standalone manuscript developing the maintenance-dynamics result in the Evolution by Emergence research corpus.

### Start here

1. manuscript.md — full paper.
2. CLAIMS.md — claim ledger and explicit non-claims.
3. LITERATURE_POSITIONING.md — established antecedents versus the narrower contribution.
4. REPRODUCIBILITY.md — theorem map, verification boundary, and numerical reproduction.
5. references.bib — references.
6. verify_maintenance_dynamics.py — small standard-library numerical check.

### Core result

The base system is
\[
\dot x=x(1-x)[\alpha(1-h)-c],\qquad
\dot K=ax-\delta K,\qquad
\dot h=\varepsilon(K-h).
\]

Define maintenance debt
\[
D=\delta K-ax=-\dot K.
\]

With debt-sensitive behavior
\[
\dot x=x(1-x)[\alpha(1-h)-c+\gamma D],
\]
the interior equilibrium is Hurwitz when
\[
(\delta+\varepsilon+ab\gamma)(\delta+ab\gamma)>a\alpha b,
\]
where \(b=x^*(1-x^*)\).

The exact boundary is
\[
\gamma_{\rm crit}
=
\frac{
\frac12(\sqrt{\varepsilon^2+4a\alpha b}-\varepsilon)-\delta
}{ab}.
\]

The model-specific chain from nonlinear vector field to characteristic-root location is machine checked in Lean 4.

### Conservative interpretation

The paper does not claim that feedback-induced oscillations are new. Its contribution is the distinction between visible state and current replacement balance, the exact debt-response threshold, the zero-mean cycle accounting result, and the end-to-end formal verification.


## Formal verification map

See [FORMAL_VERIFICATION.md](FORMAL_VERIFICATION.md) for the claim-by-claim mapping from manuscript statements to exact Lean declarations.
