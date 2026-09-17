# Cumulative Accessibility Lean Verification

Machine-checked formalization for the cumulative-accessibility and formal-core results in **Evolution by Emergence**.

The package separates four questions that are easy to collapse informally:

1. **Can an organization persist?**
2. **Can retained organization change what becomes accessible next?**
3. **Can new organization continue to be realized and retained?**
4. **What capacity conditions are necessary for that process to remain open-ended?**

The current formal-core route is:

```text
strict recurrent maintenance conditions
                ↓
recurring maintenance opportunity
                +
opportunity-conditioned validated realization
                +
retention
                ↓
validated generative uptake
                ↓
open-ended cumulative retained novelty
                +
representation inside a moving envelope
                ↓
unbounded effective distinguishability capacity
```

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

The external predicate is intentionally uninterpreted. It is **not** defined to mean objective truth, fitness, utility, morality, or correctness.

With retention, repeated validated generative uptake implies open-ended cumulative retained novelty. With representation inside the moving envelope, it also implies unbounded envelope capacity.

### Maintenance bridge

`MaintenanceOpportunityBridge.lean` separates:

```text
RecurringOpportunity
```

from

```text
OpportunityConditionedValidatedRealization.
```

The concrete strict three-cycle maintenance dynamics discharge the recurring-opportunity premise under their stated assumptions. Combined with validated response and retention, Lean derives open-ended cumulative retained novelty.

A control theorem shows that recurring opportunity alone is insufficient.

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

The CI workflow no longer treats plain `lake build` as sufficient evidence for the formal core.

It explicitly builds:

```text
CumulativeAccessibility.FormalCoreWitness
CumulativeAccessibility.MaintenanceGatedWitness
```

These targets recursively force the finite-saturation, open-ended-capacity, uptake, validation, maintenance-dynamics, and bridge dependencies through Lean.

Both witness files also contain `#print axioms` statements for their central theorems. CI re-runs those source files and fails if the output contains:

```text
sorryAx
```

The checked theorems use standard Lean/Mathlib axioms such as `propext`, `Classical.choice`, and `Quot.sound`; the release criterion is that no formal-core result depends on an unproven `sorry` placeholder.

## Reproduce locally

From the repository root:

```bash
cd formalization/cumulative-accessibility
lake update
lake exe cache get
lake build
lake build \
  CumulativeAccessibility.FormalCoreWitness \
  CumulativeAccessibility.MaintenanceGatedWitness
```

To inspect the printed axioms directly:

```bash
lake env lean CumulativeAccessibility/FormalCoreWitness.lean
lake env lean CumulativeAccessibility/MaintenanceGatedWitness.lean
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

Those are separate modelling, empirical, and interpretive questions.
