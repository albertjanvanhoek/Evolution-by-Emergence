# When Does Regulation Pay?

Reproducible paper package for:

**When Does Regulation Pay? Functional Control, Regulatory Retention, and the Cost of Staying Within Bounds**

This paper is the direct sequel to papers/persistence-does-not-measure-function/.

## Core question

The previous paper introduced an externally evaluated functional margin. This paper asks what happens when the organization itself senses deviation and acts on it.

The central distinction is:

- **control efficacy:** is regulatory gain large enough to keep the functional state inside the declared viable region?
- **regulatory retention:** does paying for that gain improve the selected growth/maintenance objective?

These thresholds are not identical.

## Main exact result

For the scalar negative-feedback model

\[
\dot z=\eta-\gamma z-\beta u,\qquad u=kz,
\]

with functional tolerance \(m\), constitutive controller cost \(c_0k\), activity cost \(c_1u\), and damage penalty \(Lz\), define

\[
A=\beta L-c_1\gamma.
\]

When \(A>0\) and regulation is selected, the growth-optimal gain is

\[
k_{\rm opt}
=
\frac{\sqrt{\eta A/c_0}-\gamma}{\beta},
\]

whereas the minimum function-preserving gain is

\[
k_{\rm func}
=
\max\left\{0,\frac{\eta/m-\gamma}{\beta}\right\}.
\]

At the selected optimum,

\[
M_{\rm opt}
=
m-\sqrt{\frac{\eta c_0}{A}}.
\]

Therefore the growth-optimal regulator is functionally sufficient exactly when

\[
\eta\le\frac{A m^2}{c_0}.
\]

Selection can therefore retain a regulator while selecting **too little regulation** to satisfy an independently declared functional threshold.

## Contents

- manuscript.md — full working manuscript.
- CLAIMS.md — claim and non-claim ledger.
- REPRODUCIBILITY.md — equations, parameters, computational checks, and proof status.
- references.bib — literature used in the draft.
- figures/make_figures.py — standard-library Python figure generator.
- figures/regulatory_gain_alignment.svg — selected versus function-preserving gain.
- figures/functional_margin_pooling.svg — functional margin at the selected optimum, with and without pooling.
- figures/worked_example.csv — plotted parameter values.

## Relationship to existing literature

The paper does **not** claim that cost–effectiveness tradeoffs in regulation are new. Those are established in control theory, evolutionary systems biology, sensory adaptation, and fluctuating-environment theory.

The narrower contribution is the explicit separation between a **selected control optimum** and an **externally declared functional boundary**, using the functional-margin language developed in the companion paper.

## Formalization

The first Lean formalization is kept with the existing persistence formalization:

formalization/persistence-drift/RegulatoryReturn.lean

It verifies the elementary control-margin and return-factorization statements without claiming to formalize the biological assumptions themselves.
