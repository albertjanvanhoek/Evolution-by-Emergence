# Cumulative Accessibility Lean Verification

Machine verification for:

**When Does Change Become Cumulative? Retained accessibility, slack, and the budgeted ratchet of reusable organization**

## Scope

The formalization now has five connected layers.

### General operational layer

Accessibility is represented as a declared predicate over a target family. This checks the order-theoretic logic without replacing the stochastic accessibility kernel.

### Shared-budget cost specialization

A scalar real-valued cost representation is used to prove the exact uniform-dilution budget boundary, margin dynamics, and a rational two-click witness.

### Recursive-accessibility layer

`CumulativeAccessibility/RecursiveAccessibility.lean` formalizes:

- finite-horizon search opportunity under reproduction;
- separation of persistence from variation;
- retained viable stepping stones;
- state-dependent search operators;
- second-order accessibility clicks;
- historical composition of preserved ancestral search with later generator expansion;
- independence of reachable depth and search-operator expansion.

### Evolvability and generative-structure layer

Five modules sharpen what it means for future accessibility itself to change:

- `EvolvabilityStructure.lean` — evolvability preorder, functional projection, and binary recombination;
- `GenerativeArity.lean` — finite-parent hypergenerators, with unary descent as the cardinality-one special case;
- `ModuleGeneratedEvolvability.lean` — derivation of effective search-operator expansion from retained internal modules;
- `GenerativeClosure.lean` — retained recursive production, where generated intermediates become reusable parent material;
- `GeneratorRuleEvolution.lean` — rule-driven search expansion at fixed repertoire, kept distinct from repertoire-driven expansion.

### Finite-saturation layer

`CumulativeAccessibility/FiniteGenerativeSaturation.lean` proves a finite-capacity boundary for cumulative retained novelty.

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

The module also implements the retained finite-parent generative closure directly on a finite type and proves that this concrete closure satisfies the saturation theorem.

`FINITE_SATURATION_BRIDGE.md` records the relation to the repository's fixed-resolution organizational-depth work. The bridge is deliberately conditional: a finite declared candidate universe is not silently identified with an operational packing number without an explicit representation/resolution map.

The formalization does **not** claim that scalar cost is generally equivalent to finite-horizon hitting probability. It does not identify persistence with fitness or function, prove indefinite survival, claim that larger candidate sets are better, claim that all evolution is multi-parent, or claim that physical reality has a finite state space. Lean verifies consequences of the declared transition, viability, retention, projection, generative-rule, and finite-universe assumptions.

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

## Checked results

### Order-theoretic core

- preservation iff subset inclusion;
- strict expansion iff strict subset inclusion;
- preservation reflexivity and transitivity;
- strict-click composition;
- loss of an old declared target rules out preservation.

### Score, cost, and budget ratchet

- score dominance preserves accessibility and threshold crossing can create strict expansion;
- cost dominance preserves budget feasibility and downward cost crossing can create strict expansion;
- exact declared-set retention under uniform dilution iff `kappa <= Margin`;
- winding/spending margin identities and exact update;
- a margin increase opens a nonempty future coupling interval;
- a production increase opens a nonempty target-threshold interval;
- exact rational two-click strict-expansion witness and direct-baseline failure of the second click;
- route-level dominance preserves old route-feasible targets and a newly feasible route gives strict expansion.

### Recursive accessibility

- finite-horizon expected search opportunity is monotone in a nonnegative reproduction factor for fixed nonnegative variation rate;
- exact linear search opportunity at replacement `R = 1`;
- persistence without variation gives zero search opportunity;
- one- and two-step retained viable reachability;
- a retained intermediate can expose an indirect target unavailable as a direct baseline step;
- second-order clicks strictly expand declared candidate sets;
- retained history plus preservation plus a later second-order click strictly expands the descendant generator relative to the ancestor;
- an explicit descendant candidate is produced that the ancestor's generator lacked;
- deeper reachability can occur without search-operator expansion, and search-operator expansion can occur without realization of the newly proposed candidate.

### Evolvability order and functional projection

- generator inclusion is reflexive and transitive on raw organizational states;
- mutual weak evolvability is exactly equality of the declared candidate sets;
- the state-level relation is a **preorder**, not generally a partial order, because distinct states can expose the same generator;
- a strict raw candidate-set expansion can fail to expand a coarse declared functional feature repertoire;
- the same candidate expansion can become a genuine feature-repertoire expansion under a feature map that distinguishes the new candidate.

Thus candidate count and task-relevant/functional novelty are formally separated.

### Recombination and generative arity

- expanding retained module availability preserves existing recombination routes;
- retaining a second distinct module can open a genuinely joint candidate;
- a concrete `(a,b) -> c` candidate exists although neither `a` nor `b` has a unary edge to `c` in the witness;
- ordinary unary generation lifts exactly into a finite-parent hypergenerator with singleton parent sets;
- explicit binary recombination lifts exactly into the same finite-parent representation;
- the concrete joint generator is not `UnaryOnly`.

This establishes a precise representation-level claim: tree-like single-parent descent is the arity-one special case of a more general finite-parent dependency structure. A multi-parent dependency can of course be encoded in a unary graph by augmenting the state representation; the formalization does not claim otherwise.

### Module-generated evolvability

For

`SearchFromModules Modules Generate state candidate`,

the effective search operator is derived rather than assumed.

Lean checks that:

- retention of all old internal modules preserves all old generated candidates;
- if the descendant contains a realizable parent set generating a declared candidate absent from the ancestor, the effective search operator strictly expands;
- with a viable realized state transition, the same premises derive a second-order accessibility click;
- a concrete retained-diversity witness derives the `(a,b) -> c` search expansion.

### Retained generative closure

Define one round as

`A' = A union Generated(A)`.

The formalization checks:

- one retained generative round never removes an old item;
- the closure step is monotone in the available repertoire;
- iterated retained closure is monotone in round number;
- a novel generated candidate gives strict expansion;
- in the concrete chain `{a} -> b` and `{b} -> c`, candidate `c` is unavailable after one round but available after two because generated `b` is retained as reusable substrate.

This is the minimal recursive-production witness in the stack.

### Generator-rule evolution

Repertoire-driven and rule-driven evolvability are explicitly separated.

With the retained repertoire fixed, Lean checks that:

- pointwise extension of a finite-parent generative rule preserves all previously generated candidates;
- a new rule event can strictly expand the candidate repertoire;
- a state-dependent rule change can therefore derive a second-order click without changing the retained module set;
- a concrete fixed-repertoire witness preserves `a -> b` while adding `a -> c`.

Accordingly, expansion of the effective search operator may arise from at least two distinct mechanisms:

1. more/different retained parent material under a fixed rule;
2. a changed generative rule under a fixed repertoire.

### Finite generative saturation

Lean checks that:

- each strict inclusion of finite retained repertoires increases cardinality;
- an uninterrupted strict chain of length `k` requires at least `k` additional states;
- the total number of strict expansions up to any horizon, including expansions separated by idle steps, is bounded by `|U| - |S 0|`;
- this finite novelty-count bound does not require a fixed update rule;
- under a fixed deterministic retained update, equality of two consecutive states is permanent;
- therefore a fixed deterministic retained process inside `U` reaches a fixed repertoire within the finite remaining capacity;
- the finite retained hypergraph closure is a direct specialization and cannot strictly expand forever.

This separates two claims that should not be conflated: rule evolution can expand the effective search operator, but rule evolution alone cannot defeat a fixed finite distinguishability capacity when cumulative retention is monotone.

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
