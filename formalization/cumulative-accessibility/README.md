# Cumulative Accessibility Lean Verification

This project machine-checks the abstract algebra behind the strong monotone accessibility-ratchet criterion used in:

**When Does Change Become Cumulative? A Monotone Accessibility Criterion for Retained Organization**

## Scope

The formalization treats accessibility operationally as a declared predicate over a target family. It proves set-theoretic composition results and two sufficient scalar specializations.

It does not formalize the full stochastic organizational-accessibility kernel, empirical causal identification, physical route dynamics, or the claim that any real evolutionary system satisfies the hypotheses.

## Main definitions

- PreservesOn: every previously accessible declared target remains accessible.
- StrictExpandsOn: preservation plus at least one newly accessible declared target.
- AccessibleByScore: a target exceeds a declared scalar threshold.
- ScoreDominatesOn: target scores do not decrease.
- AccessibleByCost: target cost lies within a declared budget.
- CostDominatesOn: target costs do not increase.

## Checked results

- preservation iff subset inclusion;
- strict expansion iff strict subset inclusion;
- preservation reflexivity and transitivity;
- strict-click persistence through later preserving steps;
- strict expansion after a later click;
- strict-click composition;
- score dominance implies preservation;
- upward score crossing implies strict expansion;
- cost dominance implies preservation;
- downward cost crossing implies strict expansion;
- loss of a previously accessible target rules out preservation.

## Reproduction

    lake update
    lake exe cache get
    lake build

Pinned toolchain:

    Lean 4.33.0

The Mathlib revision is pinned in lakefile.toml.
