# When Does Regulation Pay?

Reproducible paper package for:

**When Does Regulation Pay? Functional Control, Regulatory Retention, and the Cost of Staying Within Bounds**

This paper is the direct sequel to papers/persistence-does-not-measure-function/.

## Core result

For the proportional-feedback model

\[
\dot z=\eta-\gamma z-\beta u,\qquad u=kz,
\]

with functional tolerance \(m\), constitutive controller cost \(c_0k\), activity cost \(c_1u\), and deviation penalty \(Lz\), define

\[
A=\beta L-c_1\gamma.
\]

On the positive-regulation branch,

\[
k_{\rm opt}
=
\frac{\sqrt{\eta A/c_0}-\gamma}{\beta},
\qquad
k_{\rm func}
=
\max\left\{0,\frac{\eta/m-\gamma}{\beta}\right\}.
\]

At the selected optimum,

\[
M_{\rm opt}
=
m-\sqrt{\frac{\eta c_0}{A}},
\]

so the selected regulator is functionally sufficient exactly when

\[
\eta\le\frac{Am^2}{c_0}.
\]

> **Selected control need not equal sufficient control.**

## General marginal-alignment theorem

Generalizing the objective to

\[
g(k)=g_0-\Phi(z^*)-C(k)-c_1kz^*,
\]

the overloaded regime \(\eta>m\gamma\), together with convex deviation penalty and increasing-convex constitutive cost, gives

\[
\boxed{
z_{\rm opt}\le m
\iff
\beta m^2\Phi'(m)
\ge
\eta C'(k_{\rm func})+c_1\gamma m^2.
}
\]

With

\[
\Psi'(m)=\Phi'(m)-\frac{c_1\gamma}{\beta},
\]

this is

\[
\boxed{
\beta m^2\Psi'(m)
\ge
\eta C'(k_{\rm func}).
}
\]

The linear boundary above is an exact corollary.

Two further corollaries are developed in the manuscript:

- for \(\Phi_p(z)=Lm(z/m)^p\) and \(C(k)=c_0k\),
  \[
  p_{\min}
  =
  \frac{c_1\gamma+\eta c_0/m^2}{\beta L};
  \]
- for fixed finite \(\Psi'(m)\), the asymptotically relevant controller-cost quantity is \(kC'(k)\); if \(kC'(k)\to\infty\), eventual underprovision follows under unbounded disturbance.

## Pooling

The pooling result assumes shared, sufficiently non-rival constitutive infrastructure. Under that explicit assumption,

\[
c_0\mapsto c_0/n
\]

and the linear alignment boundary becomes

\[
\eta\le\frac{nAm^2}{c_0}.
\]

For a discrete beneficiary count,

\[
n_{\min}
=
\left\lceil\frac{\eta c_0}{Am^2}\right\rceil.
\]

The \(1/n\) result does not apply when controller capacity must be duplicated proportionally for every added beneficiary.

## Contents

- manuscript.md — full manuscript.
- CLAIMS.md — claim, scope, and non-claim ledger.
- REPRODUCIBILITY.md — derivations, parameters, computational checks, and proof scope.
- LITERATURE_POSITIONING.md — novelty and prior-work positioning.
- references.bib — bibliography.
- figures/make_figures.py — standard-library figure generator.
- figures/regulatory_gain_alignment.svg — selected versus sufficient gain.
- figures/functional_margin_pooling.svg — selected functional margin with and without pooling.
- figures/worked_example.csv — plotted values.
- formalization/persistence-drift/RegulatoryReturn.lean — machine-checked algebraic core.

## Formalization

The Lean development checks:

- functional-margin equivalence;
- regulatory-return factorization;
- nonpositive return under a nonpositive activity-return gap;
- an algebraic global-optimum certificate for the linear model;
- the scaled general boundary derivative;
- the marginal-alignment inequality;
- the effective-value reformulation;
- the linear and scaled-power specializations;
- the pooling numerator identity.

It verifies mathematical implications under explicit assumptions. It does not validate biological assumptions, empirical mappings, natural-selection claims, or the separate Poisson rare-shock model.

## Position in the larger project

This paper does not establish a universal forward arrow of organization. It secures a reusable intermediate result:

> optimizing an endogenous objective does not by itself guarantee satisfaction of an independently specified functional boundary; alignment requires sufficient marginal value at that boundary relative to the marginal cost of the control needed to hold it.


## Formal verification map

See [FORMAL_VERIFICATION.md](FORMAL_VERIFICATION.md) for the claim-by-claim mapping from manuscript statements to exact Lean declarations.
