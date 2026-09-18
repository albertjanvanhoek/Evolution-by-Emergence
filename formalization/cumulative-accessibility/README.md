# Cumulative Accessibility Lean Verification

Machine-checked formalization for the cumulative-accessibility and formal-core results in **Evolution by Emergence**.

The package separates four questions that are easy to collapse informally:

1. **Can an organization persist?**
2. **Can retained organization change what becomes accessible next?**
3. **Can new organization continue to be realized and retained?**
4. **What capacity conditions are necessary for that process to remain open-ended?**

The current formal-core route keeps maintenance support, opportunity, response delay, resource feasibility, retention, and representation separate:

```text
nonnegative three-cycle dynamics + positive canonical support vector
+ non-strict closed-loop replacement threshold
                ↓
persistent positive quantitative support bound
                +
declared support → opportunity connection
                ↓
recurring opportunity Q

Q + per-opportunity resource-feasible validated response within lag Δ
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

The earlier same-time coupling predicate `W` is now proved to be exactly the `Δ = 0` special case. Positive bounded delay is therefore a genuine generalization: the checked even/odd witness has recurrent lag-1 response and validated uptake while same-time `W` is false.

The quantitative response layer still does **not** derive resource budgets, response costs, generation, validation, or retention from maintenance dynamics. It makes those mechanisms explicit so later work can model their dynamics rather than hiding them inside `W`.

This is a conditional mathematical implication chain. It is **not** a claim that persistence automatically creates learning, that novelty is improvement, or that the abstract assumptions automatically hold in real systems.

## Main modules

### Accessibility and retained search

- `CumulativeAccessibility.lean` — basic accessibility, preservation, strict expansion, costs, margins, and route-level results.
- `RecursiveAccessibility.lean` — finite search opportunity, retained stepping stones, second-order clicks, and separation of reachable depth from search-operator expansion.
- `EvolvabilityStructure.lean` — candidate-set ordering, functional projection, and recombination.
- `GenerativeArity.lean` — finite-parent generators and unary versus multi-parent generation.
- `ModuleGeneratedEvolvability.lean` — search expansion from retained parent material.
- `GeneratorRuleEvolution.lean` — search expansion from changes in the generative rule.
- `GenerativeClosure.lean` — generated intermediates can be retained and reused as future parent material.

A minimal checked example is:

```text
a → b → c
```

where `c` is unavailable after one retained generative round but becomes available after two once `b` has been generated and retained.

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

CI also retains the two end-to-end witness targets:

```text
CumulativeAccessibility.AuditAll
CumulativeAccessibility.VerificationSurface
CumulativeAccessibility.FormalCoreWitness
CumulativeAccessibility.MaintenanceGatedWitness
CumulativeAccessibility.BoundedResponseWitness
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
  CumulativeAccessibility.MaintenanceGatedWitness
```

To inspect the printed axioms directly:

```bash
lake env lean CumulativeAccessibility/VerificationSurface.lean
lake env lean CumulativeAccessibility/FormalCoreWitness.lean
lake env lean CumulativeAccessibility/MaintenanceGatedWitness.lean
lake env lean CumulativeAccessibility/BoundedResponseWitness.lean
```

A formal-core verification should fail review if either output contains `sorryAx`.

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

The present maintenance-to-novelty architecture is still feed-forward: novelty does not consume maintenance resources, modify the support bound, or feed back into the maintenance dynamics. The new response layer exposes time-dependent response costs, budgets, and bounded delay, but those functions are still declared inputs rather than endogenous resource dynamics. Generation, validation, and retention success are likewise not yet derived from a stochastic or adaptive mechanism.

Those are separate modelling, empirical, and interpretive questions.
