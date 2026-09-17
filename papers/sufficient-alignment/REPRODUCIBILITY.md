# Reproducibility

## Lean

The machine-checked algebraic core is in:

    formalization/collective-alignment/CollectiveAlignment.lean
    formalization/collective-alignment/MaintenanceReproduction.lean

Run:

    cd formalization/collective-alignment
    lake update
    lake exe cache get
    lake build

The formalization checks:

- deterministic signal-garbling policy lifting;
- 2-out-of-3 reliability monotonicity;
- the exact half-threshold;
- redundancy gain above \(p=1/2\);
- the quadratic selected-alignment global optimum and exact \(2v\ge c\) sufficiency boundary;
- protocol reproduction monotonicity and exact scalar threshold;
- expected carrier growth/decline around \(R=1\);
- weak and strict repair boundaries;
- exact dyadic maintenance-product fixed-point boundary;
- explicit dyadic above/below-threshold witnesses;
- exact directed-three-cycle maintenance-product fixed-point boundary;
- explicit triad above/below-threshold witnesses;
- positivity of the canonical triad witness under positive deficits and forward gains;
- deletion of the return edge making the affected coordinate autonomous;
- factorization of the one-way dyad characteristic expression with no closed-loop cross term.

The formalization deliberately does not re-prove the general stochastic Blackwell theorem, general \(k\)-out-of-\(n\) reliability theory, the Galton-Watson extinction theorem, repeated-game forgiveness results, or the full arbitrary-network Perron-Frobenius / M-matrix threshold for

\[
G=(I-R)^{-1}K.
\]

That general spectral result is treated as prior external mathematics; the new Lean module machine-checks the explicit small-network algebraic witnesses used to motivate it.

## Numerical verification

Run:

    python papers/sufficient-alignment/verify_alignment.py

The existing script evaluates the 2-out-of-3 reliability curve, verifies the threshold numerically, checks protocol reproduction examples, and checks the repair boundary. The maintenance-reproduction module is currently algebraic and does not depend on a new numerical script.

## Epistemic boundary

Lean verifies mathematical consequences of the stated toy-model assumptions. It does not establish that honesty, forgiveness, reciprocity, love, fear, or SCAP are universal moral requirements, nor that a given real network is correctly represented by these models. It also does not establish that mere persistence of a network is beneficial; maintenance reproduction must remain distinguished from externally validated adaptive performance.

## Verified proof state

### Original collective-alignment stack

The original theorem stack was verified at commit:

`7e8ff46ad629eee19e712365baa80c29ae8deea6`

GitHub Actions workflow run:

`34943940789`

Lean job:

`104298814659`

That run passed `lake build`. The `#print axioms` audit reported only the standard Lean/Mathlib dependencies

`propext`, `Classical.choice`, and `Quot.sound`

for the reported declarations, with no `sorryAx`.

### Maintenance-reproduction extension

The maintenance-reproduction Lean module was verified at commit:

`42b1ec5928d3a1b2f4a509f6e64c9722a311d1b3`

GitHub Actions workflow run:

`35182451221`

Lean job:

`105077348176`

That run passed `lake build`, including both `CollectiveAlignment` and `MaintenanceReproduction`. The maintenance-reproduction declarations report only the standard Lean/Mathlib dependencies in their `#print axioms` output and no `sorryAx`.

## Repository integration

The paper is routed from the top-level README and the global `CLAIMS.md`. The CI workflow is configured to run on pull requests and on `main` whenever the sufficient-alignment paper or collective-alignment formalization changes.
