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


## From a window certificate to an actual average-rate floor

The window theorem by itself guarantees at least one gain event in every block.
That does not yet rule out offsetting losses between those events.

The formal layer therefore adds the explicit condition

```text
∀ t, 0 ≤ TrajectoryFunctionalVelocity ... t target
```

for the chosen target.

Under that condition, Lean defines the actual total functional gain in each
non-overlapping block and proves

```math
\mathrm{BlockGain}_k \ge g_{\min}.
```

Dividing by the positive block width `W` gives the machine-checked average
rate bound

```math
\frac{g_{\min}}{W}
\le
\mathrm{BlockAverageRate}_k.
```

For the maintained three-cycle specialization, `W=\Delta+1` once
support→opportunity is declared and the response lag is bounded by `\Delta`.

This makes the role of monotonic retention/per-target non-worsening explicit:
without it, positive certified events do not by themselves imply a positive
average functional velocity.


## Guaranteed-rate acceleration

The derived block-average result makes it possible to distinguish an increase
in a **guaranteed rate floor** from an increase in the realized rate itself.

Define the mechanism certificate

```math
v_{\min}(K,\Delta,g_{\min})
=
\frac{g_{\min}}{K+\Delta+1}.
```

Lean now checks three strict comparative-statics results:

```math
g_{\min}\uparrow
\quad\Rightarrow\quad
v_{\min}\uparrow,
```

```math
\Delta\downarrow
\quad\Rightarrow\quad
v_{\min}\uparrow,
```

and

```math
K\downarrow
\quad\Rightarrow\quad
v_{\min}\uparrow,
```

under the stated positivity conditions.

It also proves that strong `TrajectoryRatchetStepOn` at every step supplies
the target-wise nonnegative-gain premise for every retained target in the
declared family.

Thus the first formal mechanism-level acceleration statement is now:

```text
faster opportunity access
or faster validated response
or larger guaranteed gain per retained update
        ↓
strictly higher guaranteed functional-rate floor.
```

This is intentionally weaker than asserting that the observed trajectory's
realized average rate must strictly increase. A stronger empirical or dynamical
model would be needed to identify the lower bound with realized velocity.


## Coupled search-validation trade-off

`SearchValidationTradeoff.lean` provides a deliberately minimal exact model
showing why ceteris-paribus monotonicity of ledger coordinates does not imply
monotonicity of the coupled system.

With a unit processing budget, let `x` be candidate-generation/search
allocation and `1-x` validation allocation. Holding the other ledger factors
at one gives

```math
v(x)=x(1-x).
```

Lean checks:

```math
0\le v(x)\le\frac14
```

on `0\le x\le1`, with the global upper bound attained iff

```math
x=\frac12.
```

It also checks strict increase on the left half, strict decrease on the right
half, and the explicit counterexample

```math
v(1)<v(1/2).
```

The numerical optimum `1/2` is specific to the symmetric unit-budget toy
model. The reusable claim is only that shared constraints can couple
rate-producing stages and create an interior optimum.


## State-dependent allocation and moving bottlenecks

Two additional verified modules make the resource-allocation toy explicitly
state-dependent:

- `StateDependentAllocation.lean`
- `BottleneckAllocation.lean`

The one-baseline model introduces retained validation infrastructure `b` and
proves that the global optimum of the normalized reduced velocity moves from
`1/2` to

```math
x^*(b)=\frac{1+b}{2}
```

for `0\le b\le1`. A checked witness gives `b=1/2\Rightarrow x^*=3/4`.

The two-baseline model then lets both search and validation have inherited
capacity:

```math
Q(s,v,x)=(s+x)(v+1-x).
```

Lean proves the global algebraic bound

```math
Q(s,v,x)
\le
\frac{(1+s+v)^2}{4},
```

attained at

```math
x^*(s,v)=\frac{1+v-s}{2}.
```

At this point the two final stage capacities are exactly equal. Lean also
checks the feasibility conditions and both boundary regimes:

- if validation plus the new unit is still no larger than inherited search
  capacity, allocating all new resource to validation is optimal;
- symmetrically, if search plus the new unit is still no larger than inherited
  validation capacity, allocating all new resource to search is optimal.

The formal result is an optimization witness, not a claim that real biological,
neural, ecological, or organizational systems literally optimize this product.
Its role is to machine-check the narrower statement that inherited organization
can change the velocity-maximizing next allocation.
