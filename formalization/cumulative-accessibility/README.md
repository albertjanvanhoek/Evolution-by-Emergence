# Cumulative Accessibility Lean Verification

Machine verification for:

**When Does Change Become Cumulative? Retained accessibility, slack, and the budgeted ratchet of reusable organization**

## Scope

The formalization has two layers.

### General operational layer

Accessibility is represented as a declared predicate over a target family. This checks the order-theoretic logic without replacing the stochastic accessibility kernel.

### Shared-budget cost specialization

A scalar real-valued cost representation is used to prove the exact uniform-dilution budget boundary, margin dynamics, and a rational two-click witness.

The formalization does not claim that scalar cost is generally equivalent to finite-horizon hitting probability.

## Main definitions

- PreservesOn
- StrictExpandsOn
- AccessibleByScore
- ScoreDominatesOn
- AccessibleByCost
- CostDominatesOn
- RetainsCostOn
- Margin
- RouteDominatesOn

## Checked results

### Order-theoretic core

- preservation iff subset inclusion;
- strict expansion iff strict subset inclusion;
- preservation reflexivity and transitivity;
- strict-click composition;
- loss of an old declared target rules out preservation.

### Score and cost sufficient conditions

- score dominance preserves accessibility;
- an upward score crossing creates strict expansion;
- cost dominance preserves budget feasibility;
- a downward cost crossing creates strict expansion;
- strict pointwise cost domination exists in general;
- positive uniform dilution cannot pointwise dominate a positive inherited cost.

### Shared-budget ratchet

- exact declared-set retention iff \(\kappa\le M\);
- margin nonnegativity;
- winding/spending margin ratio;
- general multiplicative margin update;
- winding iff the positive binding-cost multiplier is below one;
- lower log-slack contracts the admissible candidate set;
- at zero log-slack strictly spending candidates are rejected and winding candidates remain admissible;
- pure-dilution margin recursion;
- a margin increase opens a nonempty future coupling interval;
- a production increase opens a nonempty target-threshold interval.

### Positive existence

- exact rational two-click strict expansion;
- exact direct second-click failure at baseline;
- exact first-click winding;
- exact inclusion of \(\kappa=9/10\) in the opened coupling interval;
- exact inclusion of \(\theta_D=1/2\) in the opened threshold interval;
- exact productive strict cost-domination witness.

### Route-level sufficient condition

- route dominance is reflexive and transitive;
- route dominance preserves route-feasible old targets;
- a newly feasible route under route dominance gives strict expansion.

This route result is intentionally treated as a strong sufficient condition for separable settings, not as the generic shared-budget mechanism.

## Reproduction

    lake update
    lake exe cache get
    lake build

Pinned toolchain:

    Lean 4.33.0

Mathlib is pinned in lakefile.toml.
