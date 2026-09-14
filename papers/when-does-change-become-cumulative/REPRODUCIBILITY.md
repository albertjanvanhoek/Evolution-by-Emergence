# Reproducibility

## 1. Operational repertoire

Fix target family \(\mathscr U\), protocol \(\mathcal P\), horizon \(\tau\), establishment criterion, and threshold \(p_\star\).

\[
\mathcal R_t
=
\{U\in\mathscr U:
\mathcal H_\tau(U\mid s_t,\mathcal P)\ge p_\star\}.
\]

Preservation:

\[
\mathcal R_t\subseteq\mathcal R_{t+1}.
\]

Strict click:

\[
\mathcal R_t\subsetneq\mathcal R_{t+1}.
\]

Historical attribution is separate and uses the intervention criterion of the parent Organizational Accessibility framework.

## 2. Cost specialization

For effective cost \(c_t(x)\) and common budget \(B\),

\[
\mathcal F_t(B)=\{x:c_t(x)\le B\}.
\]

Pointwise cost domination is

\[
c_{t+1}(x)\le c_t(x)
\quad\forall x,
\]

and is sufficient but not necessary for budget retention.

## 3. Uniform-dilution theorem

Fix a declared inherited set and let \(c_t^\star\) be its attained binding cost among currently budget-feasible declared capabilities.

Define

\[
M_t=\frac{B}{c_t^\star}-1.
\]

If a one-way non-returning load multiplies inherited costs by \(1+\kappa\), then

\[
\boxed{
\text{retention}\iff \kappa\le M_t.
}
\]

The Lean theorem is retainsCostOn_scaled_iff_margin.

## 4. Margin dynamics

For positive budget and binding costs,

\[
\boxed{
\frac{1+M_{t+1}}{1+M_t}
=
\frac{c_t^\star}{c_{t+1}^\star}.
}
\]

For uniform dilution,

\[
\boxed{
M_{t+1}
=
\frac{M_t-\kappa}{1+\kappa}.
}
\]

The second identity does not by itself imply finite-step exhaustion if accepted \(\kappa\) can become arbitrarily small.

## 5. General two-click region

If

\[
M_1>M_0\ge0,
\]

then the interval

\[
(M_0,M_1]
\]

is nonempty. Every coupling in it is too expensive before the first click but affordable afterward.

If also

\[
X_1>X_0
\]

and \(\kappa>0\), then

\[
\left(
\frac{X_0\kappa}{1+\kappa},
\frac{X_1\kappa}{1+\kappa}
\right]
\]

is a nonempty interval of module thresholds inaccessible before and accessible after.

Both existence statements are machine checked.

## 6. Exact rational witness

Budget:

\[
B=1.
\]

Thresholds:

\[
\theta_A=3/10,\quad
\theta_B=3/20,\quad
\theta_C=1/10,\quad
\theta_D=1/2.
\]

Baseline:

\[
c_0(A)=3/5,\qquad
c_0(B)=3/10,
\]

with \(C,D\) inaccessible.

Productive click:

\[
f=11/25,\qquad
v=2,\qquad
\lambda=6/5,\qquad
X_1=7/6.
\]

Costs:

\[
c_1(A)=33/70,\quad
c_1(B)=99/196,\quad
c_1(C)=3/7.
\]

Thus

\[
M_0=2/3,\qquad
M_1=97/99.
\]

Second click:

\[
\kappa_D=9/10,\qquad
\theta_D=1/2.
\]

Costs:

\[
c_2(A)=627/700,
\]

\[
c_2(B)=1881/1960,
\]

\[
c_2(C)=57/70,
\]

\[
c_2(D)=19/21.
\]

Therefore

\[
\{A,B\}\subsetneq\{A,B,C\}\subsetneq\{A,B,C,D\}.
\]

Direct second-click counterfactual:

\[
c_{\rm direct}(A)=57/50>1,
\]

\[
c_{\rm direct}(D)=19/18>1.
\]

The Lean specialization uses finite real costs above budget for capabilities that are structurally absent at baseline; this is an accessibility-equivalent sentinel for the thresholded theorem, not a claim that the physical cost is finite.

## 7. Productive domination witness

The standard-library Python verifier reproduces the corrected numerical witness

\[
v=100,\quad f=0.01,
\]

for which

\[
c(A):0.60000\to0.39775,
\]

\[
c(B):0.30000\to0.28125.
\]

The Lean source additionally checks exact rational strict domination using

\[
f=1/100,\quad v=44,\quad \lambda=6/5,
\]

with

\[
c(A)=663/1400<3/5,
\]

\[
c(B)=1989/7000<3/10.
\]

The Lean theorem checks the exact cost inequalities; the closed-form production-network mapping is documented in the manuscript and remains inherited model algebra rather than a formalized matrix-eigenvalue theorem.

## 8. Load ladder

For a fixed declared repertoire under repeated non-returning loads,

\[
\prod_{i=1}^{n}(1+\kappa_i)\le1+M_0.
\]

If

\[
\kappa_i\ge\kappa_{\min}>0,
\]

then

\[
n\le
\frac{\log(1+M_0)}
{\log(1+\kappa_{\min})}.
\]

This is a maximum load-ladder bound, not a universal count of future capability acquisitions. If newly acquired capabilities join the declaration, they can become binding earlier.

## 9. Local reproduction

Lean:

    cd formalization/cumulative-accessibility
    lake update
    lake exe cache get
    lake build

Budget-ratchet checks:

    python papers/when-does-change-become-cumulative/verify_budget_ratchet.py

The Python script uses only the standard library and exact Fraction arithmetic for the two-click witness.

## 10. Formalization scope

CumulativeAccessibility.lean machine-checks:

- preservation/subset equivalence;
- strict expansion/proper-subset equivalence;
- preservation and strict-click composition;
- score dominance and threshold crossing;
- cost dominance and budget crossing;
- existence of strict pointwise cost domination;
- impossibility of cost domination under positive uniform dilution;
- margin nonnegativity;
- margin ratio;
- pure-dilution margin recursion;
- exact declared-set retention boundary;
- opened coupling window after margin increase;
- opened threshold window after production increase;
- exact two-click rational witness;
- direct second-click failure;
- exact winding and window inequalities;
- exact productive strict-domination cost witness;
- route-dominance reflexivity/transitivity and its sufficient implications.

It does not formalize:

- the full stochastic accessibility kernel;
- empirical causal identification;
- the production-network ODE/eigenvector derivation;
- the external declaration of target families;
- a directional theorem for the state-dependent candidate generator \(Q_s\).

## 11. Verification record

Verified combined proof/document state:

    333b98b7b8073582291dbba124c5f8f3fec0e55f

GitHub Actions run:

    34848881508

Result:

    Cumulative Accessibility Check: PASS
    lean: PASS
    budget-ratchet: PASS

The Lean log reports no sorryAx dependency for the new shared-budget, margin-window, exact two-click, direct-counterfactual, or productive-domination theorems.

This verification-record commit changes documentation only; it does not alter the verified Lean source or Python verifier.
