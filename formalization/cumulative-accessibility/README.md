# Cumulative Accessibility Lean Verification

Machine verification for:

**When Does Change Become Cumulative? Retained accessibility, slack, and the budgeted ratchet of reusable organization**

## Scope

The formalization has three layers.

### General operational layer

Accessibility is represented as a declared predicate over a target family. This checks the order-theoretic logic without replacing the stochastic accessibility kernel.

### Shared-budget cost specialization

A scalar real-valued cost representation is used to prove the exact uniform-dilution budget boundary, margin dynamics, and a rational two-click witness.

### Recursive-accessibility extension

`CumulativeAccessibility/RecursiveAccessibility.lean` formalizes a narrow next layer:

- finite-horizon search opportunity grows monotonically with a nonnegative reproduction factor when variation production is held fixed;
- zero variation production gives zero search opportunity regardless of persistence;
- retained viable intermediates can make an indirect target reachable even when it is not directly reachable from baseline;
- a viable transition can strictly expand the state's future search operator;
- if retained history preserves the ancestor's candidate repertoire, a later second-order click composes into strict search-operator expansion relative to the ancestor and exposes an explicit descendant candidate that the ancestor could not generate.

The final item is the **historical search-generator composition result**. It formalizes the distinction between reaching farther under a fixed generator and reaching a retained descendant whose generator itself has expanded. The preservation premise is essential: without it, a candidate absent from an intermediate state could simply be something the ancestor had already possessed and then lost.

The formalization does not claim that scalar cost is generally equivalent to finite-horizon hitting probability. The recursive-accessibility layer does not identify persistence with fitness or function, does not prove indefinite survival, and does not claim that more search is always better.

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
- finiteSearchOpportunity
- ViableReach
- reachableWithin
- SearchOperator
- SecondOrderClick

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

### Recursive accessibility

- finite-horizon expected search opportunity is monotone in a nonnegative reproduction factor for fixed nonnegative variation rate;
- exact linear search opportunity at replacement \(R=1\);
- persistence without variation does not generate search opportunities;
- one- and two-step retained viable reachability;
- a retained intermediate can expose an indirect target unavailable as a direct baseline step;
- second-order clicks strictly expand declared candidate sets;
- retained history plus preserved ancestral search and a later second-order click strictly expands the descendant search operator relative to the ancestor;
- the composed theorem produces an explicit candidate accessible to the descendant but absent from the ancestor's generator;
- equivalently, the descendant's declared candidate set is a strict superset of the ancestor's.

The last three statements jointly formalize a precise sense in which evolution can create new ways of evolving: the reachable descendant can possess a one-step candidate generator that strictly contains the ancestor's declared generator.

## Reproduction

    lake update
    lake exe cache get
    lake build

Pinned toolchain:

    Lean 4.33.0

Mathlib is pinned in lakefile.toml.
