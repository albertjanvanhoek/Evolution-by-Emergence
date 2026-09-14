# Reproducibility and provenance

## Frozen worked model

Unless stated otherwise:

    J = 2
    d = 1
    ell = 1
    v = 2
    reference f0 = 0.5

For the integrated A-B-C architecture:

\[
\lambda(f)=\sqrt{1+f},\qquad
X^*(f)=2-1/\lambda(f),
\]

\[
p_A=\lambda/(1+\lambda),\qquad
p_B=(1-f)/(1+\lambda),\qquad
p_C=f/(1+\lambda).
\]

At \(f_0=0.5\):

    lambda0 = 1.224744871...
    X0*     = 1.183503419...
    x_A0    = 0.651530772...
    x_B0    = 0.265986324...
    x_C0    = 0.265986324...

The declared capacities are:

\[
\Phi_1(x)=x_B,\qquad \theta_1=0.15,
\]

\[
\Phi_2(x)=x_A+x_C,\qquad \theta_2=0.50,
\]

\[
\Phi_3(x)=\min(x_A,x_B),\qquad \theta_3=0.15.
\]

\(\Phi_1=x_B\) represents a one-unit-per-abundance service supplied uniquely by type B. Its functional content comes from the **prespecified service interpretation and threshold**, not from mathematical complexity of the map.

At the reference state:

\[
M^0=\min_k\left(\Phi_k/\theta_k-1\right)=0.773242158\ldots
\]

## Exact hollowing threshold

For \(\theta_B=0.15\), the crossing \(x_B^*(f^*)=0.15\) is equivalent to

\[
40\lambda^3-17\lambda^2-77\lambda+40=0.
\]

The physical root gives:

    lambda* = 1.3114193...
    f*      = 0.7198206...
    X*      = 1.2374674...

The monotonicity statement is intended on the physical branch

\[
1\le\lambda<\sqrt2,
\]

equivalently \(0\le f<1\) for \(v=2\).

## Uniform one-way extraction

If host abundances are uniformly diluted by

\[
c=\frac{1}{1+\kappa},\qquad \kappa\ge0,
\]

and a capacity score is homogeneous of degree one,

\[
\Phi(cx)=c\Phi(x),
\]

then

\[
M(\kappa)=\frac{M^0-\kappa}{1+\kappa}.
\]

Therefore

\[
M(\kappa)\ge0\iff\kappa\le M^0,
\qquad
\kappa_{\rm crit}=M^0.
\]

This includes linear capacities and Leontief/minimum capacities under uniform scaling.

For the worked case:

    M0 = kappa_crit = 0.773242158...
    kappa = 0.360 consumes 46.6% of the extraction tolerance.

## Lean verification

Project files:

    formalization/persistence-drift/lean-toolchain
    formalization/persistence-drift/lakefile.toml

Paper-specific proof source:

    formalization/persistence-drift/FunctionalThresholds.lean

Relevant theorem names:

    homogeneous_margin_under_uniform_dilution
    extraction_margin_eq
    extraction_viable_iff
    extraction_margin_zero_at_budget
    single_channel_extraction_threshold
    hollowing_threshold_iff_cubic
    f_from_lambda
    hollowB_strictly_decreases_on_physical_branch

The paper-specific proof state was verified by GitHub Actions at:

    eadc51028da96fd7e92fe38af66b61743bae10a0

To verify locally:

    cd formalization/persistence-drift
    lake update
    lake exe cache get
    lake build

CI workflow:

    .github/workflows/persistence-drift-lean-check.yml

The #print axioms audit in FunctionalThresholds.lean is intended to make accidental dependence on sorry visible.

## Figures

The committed figure generator uses only the Python standard library.

Regenerate from the repository root with:

    python papers/persistence-does-not-measure-function/figures/make_figures.py

It writes:

    integrated_hollowing_margin.svg
    downstream_extraction_margin.svg
    threshold_sensitivity.csv

Rendered SVGs are committed so readers do not need Python to inspect the figures.

## Epistemic scope

Machine verification establishes algebraic implications of formalized assumptions. It does not establish that:

- the toy production model is an adequate empirical model of a particular organism, institution, or technology;
- the declared capacities or thresholds are biologically privileged;
- persistence implies functional progress;
- the classical Perron-Frobenius or resource-competition results discussed in the manuscript are novel.
- the current constant-\(B\) model contains an endogenous regulator; the regulatory-return equations in the Discussion are hypotheses for a future state-dependent extension.

This is intentionally a counterexample/methods contribution: one internally consistent model is sufficient to show that productive persistence, structural support, and functional capacity are not universally interchangeable measurements.
