# When Does Change Become Cumulative?

Companion paper to the Organizational Accessibility stack.

## Core result

The master object is the declared operational repertoire

\[
\mathcal R_t(p_\star)
=
\{U:\mathcal H_\tau(U\mid s_t,\mathcal P)\ge p_\star\}.
\]

A preserving step satisfies

\[
\mathcal R_t\subseteq\mathcal R_{t+1},
\]

and a strict order-theoretic click satisfies

\[
\mathcal R_t\subsetneq\mathcal R_{t+1}.
\]

A historically attributed click additionally requires retained earlier structure to make a positive causal contribution to at least one newly accessible target under the parent framework's intervention criterion.

## Shared-budget specialization

For a declared inherited set, scalar realization cost \(c_t(x)\), and budget \(B\), let \(c_t^\star\) be the attained binding cost and define

\[
M_t=\frac{B}{c_t^\star}-1.
\]

For a uniformly dilutive one-way load that multiplies inherited costs by \(1+\kappa\),

\[
\boxed{
\text{retention}\iff \kappa\le M_t.
}
\]

The margin identity is

\[
\boxed{
\frac{1+M_{t+1}}{1+M_t}
=
\frac{c_t^\star}{c_{t+1}^\star}.
}
\]

Under pure dilution,

\[
\boxed{
M_{t+1}
=
\frac{M_t-\kappa}{1+\kappa}.
}
\]

A step that lowers the binding inherited cost winds future capacity; one that raises it spends capacity.

## Positive cumulative-existence result

If a retained first click raises margin from \(M_0\) to \(M_1>M_0\), then every coupling in

\[
(M_0,M_1]
\]

is unaffordable before the first click but affordable afterward.

If maintained production also rises from \(X_0\) to \(X_1\), then for every such positive coupling there is a nonempty interval

\[
\left(
\frac{X_0\kappa}{1+\kappa},
\frac{X_1\kappa}{1+\kappa}
\right]
\]

of module thresholds that are inaccessible before and accessible after.

The paper contains an exact rational two-click witness:

\[
\{A,B\}
\subsetneq
\{A,B,C\}
\subsetneq
\{A,B,C,D\},
\]

while the second click attempted directly from the baseline both loses inherited \(A\) and leaves \(D\) inaccessible.

## Important distinctions

- Cost accessibility is a mechanistic specialization, not a replacement for the stochastic accessibility kernel.
- Pointwise cost domination is sufficient for retention but not necessary.
- Productive strict cost domination is possible.
- Uniform positive dilution cannot satisfy pointwise cost domination.
- Route dominance is retained only as a strong sufficient condition for separable settings.
- Set expansion is not historical causation.
- The load-ladder bound requires a positive minimum load and applies to a fixed declared repertoire.
- The paper does not establish a universal evolutionary arrow.

## Reproducibility

Lean:

    cd formalization/cumulative-accessibility
    lake update
    lake exe cache get
    lake build

Budget-ratchet checks:

    python papers/when-does-change-become-cumulative/verify_budget_ratchet.py

GitHub Actions runs both.

## Files

- manuscript.md — combined paper.
- CLAIMS.md — claim and non-claim ledger.
- REPRODUCIBILITY.md — derivations and verification record.
- LITERATURE_POSITIONING.md — novelty and prior-work caution.
- verify_budget_ratchet.py — exact and numerical checks.
- formalization/cumulative-accessibility/CumulativeAccessibility.lean — machine-checked core.
