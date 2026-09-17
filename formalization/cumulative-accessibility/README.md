# Cumulative Accessibility Lean Verification

Machine verification for:

**When Does Change Become Cumulative? Retained accessibility, slack, and the budgeted ratchet of reusable organization**

## Scope

The formalization now has nine connected layers.

### 1. General operational layer

Accessibility is represented as a declared predicate over a target family. This checks the order-theoretic logic without replacing the stochastic accessibility kernel.

### 2. Shared-budget cost specialization

A scalar real-valued cost representation proves the exact uniform-dilution budget boundary, margin dynamics, route-level sufficient conditions, and a rational two-click witness.

### 3. Recursive-accessibility layer

`CumulativeAccessibility/RecursiveAccessibility.lean` formalizes:

- finite-horizon search opportunity under reproduction;
- separation of persistence from variation;
- retained viable stepping stones;
- state-dependent search operators;
- second-order accessibility clicks;
- historical composition of preserved ancestral search with later generator expansion;
- independence of reachable depth and search-operator expansion.

### 4. Evolvability and generative-structure layer

Five modules sharpen what it means for future accessibility itself to change:

- `EvolvabilityStructure.lean` — evolvability preorder, functional projection, and binary recombination;
- `GenerativeArity.lean` — finite-parent hypergenerators, with unary descent as the cardinality-one special case;
- `ModuleGeneratedEvolvability.lean` — derivation of effective search-operator expansion from retained internal modules;
- `GenerativeClosure.lean` — retained recursive production, where generated intermediates become reusable parent material;
- `GeneratorRuleEvolution.lean` — rule-driven search expansion at fixed repertoire, kept distinct from repertoire-driven expansion.

### 5. Finite-saturation layer

`FiniteGenerativeSaturation.lean` proves a finite-capacity boundary for cumulative retained novelty.

For a monotone retained sequence `S n` inside a fixed finite declared universe `U`, Lean checks that for every horizon `N`,

```text
strictExpansionCount S N <= |U| - |S 0|.
```

This count bound allows idle periods and does **not** assume a fixed generative rule. Changing the rule may change which remaining states are reached, but cannot create more strict retained additions than the finite remaining capacity of `U`.

With a fixed deterministic inflationary update rule closed inside `U`, Lean proves the stronger result that some

```text
n <= |U| - |S 0|
```

is a true fixed point: `S (n+k) = S n` for every later `k`.

The module also implements retained finite-parent generative closure directly on a finite type and proves that this concrete closure satisfies the saturation theorem.

### 6. Moving distinguishability-capacity layer

`OpenEndedCapacity.lean` lifts the architecture to the time-varying triplet

```text
(M_t, H_t, U_t)
```

where `M_t` is retained organization, `H_t` is the current finite-parent generative rule, and `U_t` is the current finite distinguishability envelope.

For every horizon `N`, Lean proves

```text
|M_0| + strictExpansionCount(M,N) <= |U_N|.
```

Therefore open-ended cumulative retained novelty forces unbounded envelope capacity. The theorem does not mention `H_t`: arbitrarily changing the generative rule cannot evade a uniformly bounded effective distinguishability capacity.

The converse is false. A machine-checked witness has `|U_t| -> infinity` while `M_t = {0}` forever.

### 7. Capacity-uptake layer

Two modules provide a sufficient mechanism rather than only a no-go boundary:

- `CapacityUptake.lean` — explicit `U_t -> H_t -> M_{t+1}` coupling;
- `CapacitySlack.lean` — decomposition into recurring unused capacity and local generative realization.

`GenerativeCapacityUptake` requires that from every time onward there is eventually a candidate that

```text
is in U_m,
is not yet in M_m,
is generated from retained M_m by H_m,
and is retained in M_{m+1}.
```

With monotone retention, Lean proves that this condition implies open-ended cumulative novelty.

The stronger packaged condition is then decomposed into:

```text
RecurringCapacitySlack:
    from every time onward, some later M_m is a strict subset of U_m;

ImmediateGenerativeRealization:
    whenever M_m is a strict subset of U_m, H_m generates at least one
    candidate in U_m \ M_m and that candidate is retained in M_{m+1}.
```

Lean proves

```text
recurring capacity slack
+ local generative realization
+ retention
    -> open-ended cumulative novelty
    -> unbounded distinguishability capacity.
```

The first implication is sufficient, not claimed minimal. The second is necessary.

### 8. External-validation layer

`ValidatedUptake.lean` extends the architecture to

```text
(M_t, H_t, U_t, E_t)
```

where `E_t` is a declared external test or acceptance predicate. The formalization does **not** identify this predicate with objective truth, fitness, or utility.

`ValidatedGenerativeCapacityUptake` requires arbitrarily late candidates that are simultaneously distinguishable, genuinely new, generable from current retained material, accepted by `E_t`, and retained.

Lean proves

```text
validated generative capacity uptake
    -> generative capacity uptake
    -> open-ended cumulative novelty.
```

With `M_t ⊆ U_t`, the same condition also implies unbounded envelope capacity. A positive progressive witness shows the validated condition is non-vacuous under an accept-all criterion, while a reject-all witness proves that open-ended cumulative novelty alone does not imply externally validated novelty.

### 9. Maintenance-opportunity bridge

`MaintenanceOpportunityBridge.lean` formalizes the interface needed to connect recurrent maintenance to cumulative validated novelty without silently equating persistence with learning.

It separates

```text
RecurringOpportunity:
    opportunities recur arbitrarily far into the future;

OpportunityConditionedValidatedRealization:
    whenever an opportunity occurs, at least one genuinely new candidate is
    distinguishable, generated, externally accepted, and retained.
```

Lean proves

```text
recurring opportunity
+ opportunity-conditioned validated realization
    -> validated generative capacity uptake.
```

Therefore, with retention,

```text
recurring opportunity
+ validated realization
+ retention
    -> open-ended cumulative novelty.
```

With representation inside the moving envelope, the same premises imply unbounded distinguishability capacity. A separation witness proves that recurring opportunity alone is insufficient: opportunities may occur forever while the retained repertoire stays static.

`MaintenanceOpportunityBridge.lean` now imports the concrete maintenance dynamics. For the strict three-cycle under the stated positivity/non-negativity and closed-loop assumptions, the machine-checked trajectory supplies recurring maintenance opportunity arbitrarily far into the future. This closes the previously conditional maintenance-to-opportunity arrow for that concrete model. It does **not** establish the corresponding result for arbitrary maintenance networks.

`FINITE_SATURATION_BRIDGE.md` records the relation to the repository's fixed-resolution organizational-depth work. `OPEN_ENDED_UPTAKE.md` summarizes the necessity/sufficiency scaffold. `VALIDATED_UPTAKE.md` documents the external-validation and maintenance-opportunity layers.

The formalization does **not** identify persistence with fitness or function, prove indefinite biological survival, claim that larger candidate sets are better, claim that all evolution is multi-parent, or claim that physical reality has a finite state space. The current open-endedness results concern cumulative retained novelty. External validation is represented as an explicit declared criterion, and the maintenance bridge remains conditional on stated model assumptions rather than asserting that persistence automatically produces learning.

## Main definitions

- `PreservesOn`
- `StrictExpandsOn`
- `AccessibleByScore`
- `AccessibleByCost`
- `RetainsCostOn`
- `Margin`
- `RouteDominatesOn`
- `finiteSearchOpportunity`
- `ViableReach`
- `SearchOperator`
- `SecondOrderClick`
- `EvolvabilityLe`
- `EvolvabilityLt`
- `FeatureReachable`
- `RecombAccessible`
- `HyperGenerator`
- `GeneratedFromAvailable`
- `UnaryOnly`
- `SearchFromModules`
- `GenerativeClosureStep`
- `GenerativeClosureN`
- `GeneratorRuleLe`
- `GeneratorRuleLt`
- `SearchFromRules`
- `strictExpansionCount`
- `finiteGenerativeStep`
- `FiniteGenerativeClosureN`
- `OpenEndedCumulativeNovelty`
- `UnboundedEnvelopeCapacity`
- `EvolvingGenerativeArchitecture`
- `EventualNovelUptake`
- `GenerativeCapacityUptake`
- `RecurringCapacitySlack`
- `ImmediateGenerativeRealization`
- `ExternalCriterion`
- `EventualValidatedNovelUptake`
- `ValidatedGenerativeCapacityUptake`
- `RecurringOpportunity`
- `OpportunityConditionedValidatedRealization`

## Checked results

### Order-theoretic and budget core

- preservation iff subset inclusion;
- strict expansion iff strict subset inclusion;
- preservation reflexivity and transitivity;
- strict-click composition;
- score and cost dominance preserve declared accessibility;
- exact declared-set retention under uniform dilution iff `kappa <= Margin`;
- winding/spending margin identities and exact update;
- a margin increase opens a nonempty future coupling interval;
- a production increase opens a nonempty target-threshold interval;
- exact rational two-click strict-expansion witness and direct-baseline failure of the second click;
- route dominance preserves old route-feasible targets and a newly feasible route gives strict expansion.

### Recursive accessibility and evolvability

- finite-horizon expected search opportunity is monotone in a nonnegative reproduction factor for fixed nonnegative variation rate;
- persistence without variation gives zero search opportunity;
- retained intermediates can expose indirect targets unavailable as direct baseline steps;
- second-order clicks strictly expand declared candidate sets;
- retained history plus preservation plus a later second-order click can strictly expand the descendant generator relative to the ancestor;
- deeper reachability and search-operator expansion are logically distinct;
- evolvability inclusion is a preorder on raw organizational states;
- strict raw candidate expansion need not create a new declared functional feature.

### Recombination, arity, and recursive production

- expanding retained module availability preserves existing recombination routes;
- a concrete `(a,b) -> c` candidate exists although neither `a` nor `b` has a unary edge to `c`;
- unary generation is the cardinality-one special case of finite-parent generation;
- the concrete joint generator is not `UnaryOnly`;
- retained modules can derive strict expansion of the effective search operator;
- in the chain `{a} -> b`, `{b} -> c`, candidate `c` is unavailable after one retained generative round but available after two;
- rule-driven and repertoire-driven evolvability are formally separated.

### Finite and moving capacity

- each strict inclusion of finite retained repertoires increases cardinality;
- total strict expansions inside a fixed finite universe are bounded by remaining finite capacity;
- the count bound allows idle periods and changing update rules;
- fixed deterministic retained closure reaches a fixed repertoire;
- finite retained hypergraph closure cannot strictly expand forever;
- in a moving envelope, `|M_0| + strictExpansionCount(M,N) <= |U_N|`;
- open-ended cumulative novelty implies unbounded envelope capacity;
- a uniform finite envelope-capacity bound rules out open-ended cumulative novelty;
- unbounded envelope capacity is not sufficient by itself.

### Capacity uptake

- the strict-expansion counter is monotone in horizon;
- generative capacity uptake implies eventual realized novelty uptake;
- repeated realized uptake plus retention implies open-ended cumulative novelty;
- generative capacity uptake therefore implies open-ended cumulative novelty;
- with representation `M_t ⊆ U_t`, generative uptake also implies unbounded envelope capacity;
- recurring capacity slack plus immediate generative realization implies the packaged uptake condition;
- therefore recurring slack + local realization + retention is sufficient for open-ended cumulative novelty;
- a concrete progressive architecture on the natural numbers satisfies the decomposed conditions and is machine-checked as open-ended.

### External validation

- validated generative capacity uptake implies ordinary generative capacity uptake;
- validated generative capacity uptake implies arbitrarily late externally accepted novel-retention events;
- with retention, validated uptake implies open-ended cumulative novelty;
- with representation, validated uptake implies unbounded envelope capacity;
- the progressive architecture satisfies validated uptake under an accept-all criterion;
- open-ended cumulative novelty does not imply external validation, witnessed by a reject-all criterion.

### Maintenance-opportunity bridge

- recurring opportunity plus opportunity-conditioned validated realization implies validated generative capacity uptake;
- with retention, the same premises imply open-ended cumulative novelty;
- with representation, they imply unbounded envelope capacity;
- the strict three-cycle maintenance dynamics discharge recurring opportunity under the stated assumptions;
- recurring opportunity alone is not sufficient for open-ended novelty.

## Reproduction

```text
lake update
lake exe cache get
lake build
```

Pinned toolchain:

```text
Lean 4.33.0
```

Mathlib is pinned in `lakefile.toml`.