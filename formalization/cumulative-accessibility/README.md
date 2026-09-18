# Cumulative Accessibility Lean Verification

Machine-checked formalization for the cumulative-accessibility and formal-core results in **Evolution by Emergence**.

The package separates five questions that are easy to collapse informally:

1. **Can an organization persist?**
2. **Can it generate an internally usable response budget from an external gradient?**
3. **Can new organization continue to be realized, validated, and retained?**
4. **Can retained organizational change alter what becomes accessible next?**
5. **What capacity conditions are necessary for that recursive process to remain open-ended?**

For the full synthesis and proof-status map, start with [`../../DYNAMIC_OVERVIEW.md`](../../DYNAMIC_OVERVIEW.md).

The current formal-core route keeps maintenance support, opportunity, internally generated resource slack, response delay, retention, and representation separate:

```text
external gradient G_t
        +
organization-dependent uptake U(s_t,G_t)
        -
maintenance demand M(s_t)
                ↓
internal slack L_t
                ↓  reinvestment beta_t
endogenous response budget B_t^resp

nonnegative three-cycle dynamics + positive canonical support vector
+ non-strict closed-loop replacement threshold
                ↓
persistent quantitative support
                +
declared support → opportunity connection
                ↓
recurring opportunity Q

Q + internally financed validated response within lag Δ
                ↓
recurrent validated response within lag Δ
                ↓
validated generative uptake G

retention R + G
                ↓
open-ended cumulative retained novelty N

representation P + retention R + N
                ↓
unbounded effective distinguishability capacity C
```

The external gradient remains a boundary condition; the **usable response budget is endogenous to organization**. At fixed gradient, increasing uptake and/or reducing maintenance demand cannot reduce internal slack, and a nonnegative reinvestment coupling therefore cannot reduce response budget.

The earlier same-time predicate `W` remains exactly the `Δ = 0` special case. The exact shared-budget cumulative-accessibility margin `M=B/c*-1` is also connected to the response interface as a separate mechanism-level specialization; it is not identified with physical free-energy slack.

This is a conditional mathematical implication chain. It is **not** a claim that persistence automatically creates learning, that novelty is improvement, or that the abstract assumptions automatically hold in real systems.

## Main modules

### Accessibility and retained search

- `CumulativeAccessibility.lean` — basic accessibility, preservation, strict expansion, costs, margins, and route-level results.
- `RecursiveAccessibility.lean` — finite search opportunity, retained stepping stones, second-order clicks, and separation of reachable depth from search-operator expansion.
- `QuantitativeAccessibility.lean` — directed accessibility-cost geometry, plasticity/viscosity order, and recovery of a binary second-order click from strict quantitative improvement at a suitable budget.
- `FunctionalRatchetVelocity.lean` — separates organizational states from functional targets, defines functional repertoire, target-wise functional gain and duration/resource-normalized ratchet rates, and connects strict functional cost improvement to thresholded repertoire expansion.
- `RatchetVelocityLedger.lean` — optional mechanism ledger separating opportunity rate, generation, resource feasibility, validation, retention, and mean retained gain; its match to an empirical rate remains an explicit modelling assumption.
- `BoundedUpdateRate.lean` — first derived speed bridge: bounded opportunity gaps plus bounded validated-response lag imply bounded successful-update gaps; maintained three-cycle support yields the zero-opportunity-gap specialization and, with a minimum-gain seam, a functional-gain guarantee in every finite response window.
- `IntelligentLearningMaintenance.lean` — separate inside specialization mapping intelligent learning-maintenance process states into the outside geometry, including a matched held-out rate-grounded definition of recursive self-improvement.
- `EvolvabilityStructure.lean` — candidate-set ordering, functional projection, and recombination.
- `GenerativeArity.lean` — finite-parent generators and unary versus multi-parent generation.
- `ModuleGeneratedEvolvability.lean` — search expansion from retained parent material.
- `GeneratorRuleEvolution.lean` — search expansion from changes in the generative rule.
- `GenerativeClosure.lean` — generated intermediates can be retained and reused as future parent material.

A minimal checked example is:

```text
a → b → c
```

where c is unavailable after one retained generative round but becomes available after two once b has been generated and retained.

### Quantitative accessibility and viscosity

QuantitativeAccessibility.lean lifts binary accessibility to a declared
directed cost geometry:

    AccessibilityCost x z = cost of future transition x -> z
    AccessibleWithin Cost B x z := Cost x z <= B

A new condition is **no more viscous** than an old one on a target set when all
declared future costs weakly decrease. It is **strictly less viscous** when at
least one declared target becomes strictly cheaper.

Lean checks:

    strict quantitative cost improvement
            ↓
    some target becomes affordable at a budget where it was previously unaffordable
            ↓
    strict expansion of the budget-thresholded search family

For a single state-dependent cost geometry this yields:

    QuantitativeSecondOrderClick
            ↓
    exists B, SecondOrderClick at budget B

Thus the weighted geometry strictly generalizes the existing binary
second-order-accessibility interface.

FunctionalRatchetVelocity.lean then separates the organizational-state type
from the functional-target type:

    FunctionalCost sigma phi := sigma -> phi -> Real

This allows a network state to be distinguished from what the network can do.
The primitive outside object is a target-indexed functional cost profile rather
than a universal scalar complexity measure. Lean checks:

    strict retained functional cost improvement
            ↓
    positive target-wise functional gain
            ↓
    strict functional-repertoire expansion at some budget

For positive declared duration/resource interval Δ, the gain is normalized into
a functional rate. Matched episodes can therefore be compared even when their
durations differ.

RatchetVelocityLedger.lean adds the conditional specialization

    v_ledger = opportunityRate
               * pGenerate
               * pResource
               * pValidate
               * pRetain
               * meanGain

with an explicit `VelocityLedgerMatches` predicate separating the measured rate
from the ledger. Lean checks zero-bottleneck and ceteris-paribus monotonicity
results; it does not infer that this product is the correct empirical model in
every domain.

IntelligentLearningMaintenance.lean is deliberately separate. It introduces an
internal process state P, a map from process state to accessibility geometry,
labelled learning verbs, endogenous self-improvement, and recursive
self-improvement. The labels do not carry universal monotonic effects: an
application must justify how its process state changes the external cost
geometry.

The stronger rate-grounded recursive interface starts old and self-modified
learning episodes from the same organization, preserves declared prior
functions, and requires the new process's normalized held-out functional-rate
profile to weakly dominate the old one with at least one strict improvement.

### Finite saturation

`FiniteGenerativeSaturation.lean` proves that a monotonically retained repertoire inside a fixed finite declared distinguishability set cannot strictly expand forever.

For every horizon `N`,

```text
|S_0| + strictExpansionCount(S,N) ≤ |S_N|
```

and therefore, if `S_n ⊆ U` for fixed finite `U`,

```text
strictExpansionCount(S,N) ≤ |U| - |S_0|.
```

Idle periods and changing update rules do not evade this counting bound while the effective distinguishable set remains fixed and finite.

For a fixed deterministic inflationary update closed inside `U`, the retained trajectory reaches a genuine fixed point.

### Open-ended capacity

`OpenEndedCapacity.lean` replaces the fixed finite set by a moving finite envelope `U_t` and defines:

- `OpenEndedCumulativeNovelty`;
- `UnboundedEnvelopeCapacity`.

For retained organization `M_t` represented inside `U_t`, Lean proves:

```text
|M_0| + strictExpansionCount(M,N) ≤ |U_N|.
```

Hence:

```text
open-ended cumulative retained novelty
                ↓
unbounded effective distinguishability capacity
```

The converse is false. The package includes a checked counterexample with an indefinitely growing envelope and a static retained repertoire.

So:

```text
capacity for novelty ≠ realized novelty
```

### Uptake and validation

- `CapacityUptake.lean` — explicit coupling from available capacity and the current generator to retained novelty.
- `CapacitySlack.lean` — a sufficient decomposition using recurring unused capacity plus local generative realization.
- `ValidatedUptake.lean` — adds a declared external acceptance predicate `E_t`.
- `ResponseDynamics.lean` — adds explicit response cost/budget, bounded response delay, and the theorem that recurrent opportunity plus bounded resource-feasible response implies validated uptake.
- `BoundedResponseWitness.lean` — lag-1 even/odd witness and resource-independence counterexamples.
- `EndogenousBudgetBridge.lean` — maps organization-dependent gradient uptake minus maintenance into internally generated response budget; separately maps cumulative-accessibility margin into the same interface within its own units.
- `EndogenousBudgetWitness.lean` — fixed-gradient uptake-improvement witness and exact `2/3 → 97/99` margin-funded response witness.
- `DynamicVortex.lean` — explicit composition interface joining internally funded validated response to second-order organizational/search updates.
- `DynamicVortexWitness.lean` — concrete full-dynamic construction with open-ended retained novelty, unbounded envelope capacity, and recurring second-order updates.

The external predicate is intentionally uninterpreted. It is **not** defined to mean objective truth, fitness, utility, morality, or correctness.

With retention, repeated validated generative uptake implies open-ended cumulative retained novelty. With representation inside the moving envelope, it also implies unbounded envelope capacity.

### Maintenance bridge

`MaintenanceDynamics.lean` now preserves the quantitative information that the earlier Boolean interface discarded. It defines a state `x` as supported by a lower-bound vector `b` only when `b` is itself strictly positive and `x ≥ b` componentwise.

For the canonical three-cycle witness, Lean proves under nonnegative coefficients, positivity of the canonical witness, and the **non-strict** product threshold:

```text
∀ n, Supported(canonicalVector, trajectory n).
```

The scalar

```text
ε = min(canonicalVector.a, canonicalVector.b, canonicalVector.c)
```

is therefore positive and lower-bounds every trajectory component at every time. The vector remains the primary object; the scalar floor is only a summary. This is a mathematical reference level inside the construction, not by itself an empirically calibrated operational threshold.

`MaintenanceOpportunityBridge.lean` then requires an explicit declared connection

```text
SupportImpliesOpportunity Support Opportunity
```

before persistent support can imply recurring opportunity. Persistent support cannot establish recurrence of an arbitrary external opportunity predicate.

The response layer now distinguishes:

```text
Q      = recurring opportunity
W      = recurring same-time opportunity + successful validated uptake
D_Δ    = recurring opportunity answered by validated success within lag Δ
B_Δ    = every opportunity receives a resource-feasible validated response within lag Δ
G      = recurring successful validated uptake
```

Response resource feasibility is quantitative:

```text
ResourceFeasibleAt(Cost, Budget, t, z)
    := Cost(t,z) ≤ Budget(t)
```

and a resource-validated success additionally requires the same envelope, novelty, generation, external-validation, and next-step-retention conditions used by ordinary validated uptake.

Lean checks:

```text
W ↔ D_0
Q ∧ B_Δ → D_Δ
D_Δ → G
R ∧ G → N
P ∧ R ∧ N → C
```

The existing same-time results remain available, including `Q ∧ V → W`, `W → Q`, and `W → G`.

The new regression witnesses establish:

```text
D_1 ∧ ¬W
validated success ∧ ¬resource-feasible validated success
resource feasibility ∧ ¬validated success
```

The first uses opportunities at even times and successful uptake at odd times, so every opportunity is answered exactly one step later. The other two show that the resource inequality is an independent constraint: abstract validated success does not determine an arbitrary cost/budget model, and sufficient budget alone does not create generation or success.

### Endogenous budget bridge

`EndogenousBudgetBridge.lean` closes the resource seam left by the bounded-response layer.

For organizational state `s_t`, external gradient `G_t`, uptake function `U`, maintenance demand `M`, and reinvestment fraction `beta_t`, it defines

```text
InternalSlackAt(t) = U(s_t,G_t) - M(s_t)

EndogenousResponseBudget(t)
    = beta_t * InternalSlackAt(t).
```

Lean checks that viability is equivalent to nonnegative internal slack, and that at fixed external gradient

```text
higher uptake + no larger maintenance
        → no lower internal slack
        → no lower response budget        (beta >= 0).
```

A strict response-budget increase opens a nonempty interval of response costs that were unaffordable before and affordable afterward.

The concrete fixed-gradient witness keeps `G=10` and maintenance `=6`, changes organizational uptake from `10` to `11`, and therefore raises slack/budget from `4` to `5`. A response cost `9/2` crosses that window and finances the existing lag-1 even/odd response architecture. With recurrent opportunity this yields `G`; with retention it yields `N`.

The same interface is also instantiated by the existing cumulative-accessibility margin without equating it to physical energy:

```text
M_0 = 2/3
M_1 = 97/99
response/load cost = 9/10
```

so the exact first retained click makes the same `9/10` second-click load infeasible before and feasible afterward.


### Two complementary witnesses

`FormalCoreWitness.lean` is the original **logical non-vacuity witness**. It shows that the premise set of the cross-stack theorem can be inhabited simultaneously. Its progressive architecture is deliberately stronger than necessary and realizes novelty at every time step; therefore it does not make maintenance opportunity load-bearing in that particular construction.

`MaintenanceGatedWitness.lean` is a stronger **within-model dependency / ablation witness**. It defines one architecture family parameterized by an opportunity stream:

```text
opportunity present
    → generator enabled
    → repertoire expands

opportunity absent
    → generator disabled
    → repertoire unchanged
```

For the concrete recurrent maintenance opportunity stream, the gated architecture has open-ended cumulative retained novelty. Replacing the opportunity stream by `False` leaves the same architecture family static and not open-ended.

This demonstrates a genuine dependency inside the formal model. It does **not** establish empirical causality in biological, social, cognitive, or technological systems.

## Verification contract

Compilation coverage and proof-dependency auditing are now separate explicit checks.

`CumulativeAccessibility.AuditAll` imports every module advertised in this README. CI builds that aggregate target so an auxiliary advertised module cannot remain outside the verification surface merely because the central witness import graph does not reach it.

`CumulativeAccessibility.VerificationSurface` contains an explicit reviewed list of advertised declarations and prints their axiom dependencies. CI fails if any printed dependency contains:

```text
sorryAx
```

CI explicitly builds the aggregate, axiom-audit, and witness targets:

```text
CumulativeAccessibility.AuditAll
CumulativeAccessibility.VerificationSurface
CumulativeAccessibility.FormalCoreWitness
CumulativeAccessibility.MaintenanceGatedWitness
CumulativeAccessibility.BoundedResponseWitness
CumulativeAccessibility.EndogenousBudgetWitness
CumulativeAccessibility.DynamicVortexWitness
```

Changes under `formalization/collective-alignment/**` now trigger the downstream cumulative-accessibility workflow because that package is a local dependency.

The checked theorems may use standard Lean/Mathlib axioms such as `propext`, `Classical.choice`, and `Quot.sound`; the verification criterion is that no selected advertised result depends on an unproved `sorry` placeholder. Adding a result to the advertised verification surface therefore requires both importing its module through `AuditAll` and adding its declaration to the explicit axiom-audit list.

## Reproduce locally

From the repository root:

```bash
cd formalization/cumulative-accessibility
lake update
lake exe cache get
lake build
lake build \
  CumulativeAccessibility.AuditAll \
  CumulativeAccessibility.VerificationSurface \
  CumulativeAccessibility.FormalCoreWitness \
  CumulativeAccessibility.MaintenanceGatedWitness \
  CumulativeAccessibility.BoundedResponseWitness \
  CumulativeAccessibility.EndogenousBudgetWitness \
  CumulativeAccessibility.DynamicVortexWitness \
  CumulativeAccessibility.QuantitativeAccessibility \
  CumulativeAccessibility.IntelligentLearningMaintenance
```

To inspect the printed axioms directly:

```bash
lake env lean CumulativeAccessibility/VerificationSurface.lean
lake env lean CumulativeAccessibility/FormalCoreWitness.lean
lake env lean CumulativeAccessibility/MaintenanceGatedWitness.lean
lake env lean CumulativeAccessibility/BoundedResponseWitness.lean
lake env lean CumulativeAccessibility/EndogenousBudgetWitness.lean
lake env lean CumulativeAccessibility/DynamicVortex.lean
lake env lean CumulativeAccessibility/DynamicVortexWitness.lean
lake env lean CumulativeAccessibility/QuantitativeAccessibility.lean
lake env lean CumulativeAccessibility/IntelligentLearningMaintenance.lean
```

A formal-core verification should fail review if any audited output contains `sorryAx`.

Pinned toolchain:

```text
Lean 4.33.0
```

Mathlib is pinned in `lakefile.toml`.

## Scope boundaries

Machine checking establishes that the stated conclusions follow from the stated formal assumptions. It does not establish that:

- persistence is fitness or function;
- maintenance is learning;
- novelty is improvement;
- every recurrent maintenance network learns;
- unbounded capacity guarantees realized novelty;
- the external acceptance predicate is objectively correct;
- the strict three-cycle result already generalizes to arbitrary networks;
- physical reality has a fixed finite state space;
- or empirical systems satisfy the model assumptions.

The response budget is endogenous to a declared organization/gradient ledger, and the package contains recursive structural results in which retained products become later parent material and organizational changes expand future search. `DynamicVortex.lean` now packages those routes into a typed composition theorem, while `DynamicVortexWitness.lean` supplies a concrete non-vacuity witness.

The key remaining modelling seam is narrower: an application must justify why a particular retained validated response produces a particular physical organizational state update, and whether that update changes measured uptake, maintenance, or future search. The generic theorem keeps that integration premise explicit. External-gradient dynamics, stochastic generation/validation, turnover/memory, and empirical identification remain separate modelling questions.

Those are separate modelling, empirical, and interpretive questions.
