# Formal verification

## Source

`formalization/cumulative-accessibility/CumulativeAccessibility/FunctionalRatchetVelocity.lean`

Mechanism-ledger specialization:

`formalization/cumulative-accessibility/CumulativeAccessibility/RatchetVelocityLedger.lean`

## Type separation

The formal layer uses two types:

```text
σ = organizational state
φ = functional target
```

and defines:

```text
FunctionalCost σ φ := σ → φ → ℝ
```

This is a deliberate strengthening of the earlier quantitative-accessibility
layer, where organization states and future targets share one type.

## Core definitions

- `FunctionalCost`
- `FunctionAccessibleWithin`
- `FunctionalBudgetAccess`
- `FunctionalRepertoireWithin`
- `FunctionalGeometryChangesOn`
- `HasCheaperFunctionOn`
- `NoMoreFunctionallyViscousOn`
- `StrictlyLessFunctionallyViscousOn`
- `FunctionalStepVelocity`
- `FunctionalStepRate`
- `PositiveFunctionalRateOn`
- `FunctionalRateDominatesOn`
- `StrictlyFasterFunctionalRateOn`
- `NonnegativeFunctionalVelocityOn`
- `PositiveFunctionalVelocityOn`
- `NoLessFunctionalVelocityOn`
- `StrictlyFasterFunctionalVelocityOn`
- `AcceleratingFunctionalRatchetOn`
- `TrajectoryFunctionalVelocity`
- `TrajectoryRatchetStepOn`

## Machine-checked consequences intended for the public surface

1. Non-worsening functional viscosity is equivalent to nonnegative
   target-wise ratchet velocity.
2. Strict functional viscosity improvement is equivalent to positive
   target-wise ratchet velocity.
3. Non-worsening functional costs preserve every function already affordable
   at a fixed budget.
4. Strict functional improvement opens an exact budget window for at least one
   function.
5. Strict functional improvement strictly expands the declared functional
   repertoire at some budget.
6. Positive functional velocity therefore induces strict repertoire expansion
   at some budget.
7. Positive unit-step velocity remains positive after normalization by any
   positive duration/resource interval.
8. Strict matched rate improvement contains an explicit functional target whose
   normalized acquisition rate is higher in the comparison episode.
9. A strong accelerating ratchet contains an explicit target whose functional
   cost falls faster in the second matched interval.
10. A concrete two-state/two-function witness shows repertoire expansion without
   changing the type or number of components.

## Important boundary

The formalism does **not** prove that:

- more functions are always better;
- a larger repertoire is always fitter;
- all functional targets are commensurable;
- function can be read directly from static structure;
- ecological, neural, social, and technological functions share the same
  empirical units;
- positive velocity is globally monotonic across all possible targets;
- an accelerating ratchet implies finite-time explosion.

The comparison of velocities has a literal speed interpretation only when the
compared steps represent matched time or resource intervals.

## Scalarization

The core intentionally avoids a universal scalar "amount of organization".

An application may introduce a measure or weighting over functional targets,
but any resulting scalar inherits the assumptions of that target family and
aggregation rule. The vector-valued cost and velocity profiles remain the
primitive objects.


## Mechanism-ledger layer

`RatchetVelocityLedger.lean` deliberately does not redefine the measured
functional rate. It introduces an explicit modelling seam:

```text
VelocityLedgerMatches measuredRate ledgerFactors
```

with

```math
v_{ledger}
=
\lambda p_G p_R p_V p_T \bar g.
```

Lean checks nonnegativity, zero-bottleneck cases, and ceteris-paribus
monotonicity in opportunity rate, generation, resource feasibility, validation,
retention, and mean retained functional gain.

These are conditional algebraic consequences of the ledger. The formal theory
does not prove that a biological, ecological, neural, social, or technological
system is correctly represented by this factorization.


## First derived mechanism-to-speed bridge

`BoundedUpdateRate.lean` closes the first nontrivial route from existing EbE
maintenance/response machinery into the new speed layer.

The qualitative predicate `RecurringOpportunity` is intentionally too weak to
imply a positive frequency floor: opportunity gaps may grow without bound.

The new premise

```text
OpportunityGapBound K Opportunity
```

requires an opportunity within at most `K` indexed steps from every starting
point. Combined with the existing bounded response premise

```text
OpportunityConditionedResourceResponseWithin Δ ...
```

Lean proves

```text
ResourceValidatedSuccessEveryWindow (K + Δ + 1)
```

so every sliding window of that width contains a complete resource-feasible
validated retained update.

For the canonical maintained three-cycle, the support theorem is stronger:
quantitative support is present at **every** indexed time. Therefore an explicit
support→opportunity connection yields `K = 0`, and Lean proves:

```text
maintained three-cycle
+ support → opportunity
+ bounded response lag Δ
→ validated update in every window of width Δ+1
```

A final application seam

```text
ValidatedSuccessImpliesMinimumFunctionalGain ... g_min
```

connects each validated update to a chosen functional target. The end-to-end
theorem then yields:

```text
maintained three-cycle
+ support → opportunity
+ bounded response lag Δ
+ minimum functional gain g_min per validated update
→ at least g_min functional gain in every Δ+1 window
```

This is a deterministic local rate certificate. The formal core does not yet
identify it with a universal long-run stochastic average.
