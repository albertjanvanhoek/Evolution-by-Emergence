# Open-ended cumulative novelty: capacity, access, and retention

This note records the current necessity/sufficiency scaffold in the cumulative-accessibility formalization.

It is intentionally narrower than a full theory of open-ended evolution. The Lean results concern **cumulative retained novelty**: arbitrarily many strict expansions of a retained finite repertoire. They do not by themselves require that the new states are adaptive, useful, externally correct, or increasingly complex.

## 1. Architecture

The evolving architecture is separated into three objects:

```text
M_t  retained repertoire
H_t  current finite-parent generative rule
U_t  current finite distinguishability envelope
```

with retention and representation conditions

```text
M_t ⊆ M_{t+1}
M_t ⊆ U_t.
```

This keeps three questions separate:

1. what can currently be distinguished (`U_t`);
2. what can currently be generated from retained organization (`H_t`);
3. what has actually been generated and retained (`M_t`).

## 2. Necessary capacity condition

`OpenEndedCapacity.lean` defines open-ended cumulative novelty by

```text
for every K, some finite horizon contains at least K strict retained expansions.
```

For every horizon `N`, Lean proves

```text
|M_0| + strictExpansionCount(M,N) ≤ |U_N|.
```

Therefore

```text
open-ended cumulative novelty
    -> unbounded envelope capacity.
```

This theorem does not mention `H_t`. Arbitrarily changing the generative rule cannot rescue open-ended cumulative novelty if the effective distinguishability envelopes remain uniformly bounded.

The converse is false. A concrete witness has `|U_t| -> infinity` while `M_t = {0}` forever.

## 3. A transparent sufficient uptake condition

`CapacityUptake.lean` introduces a mechanistic sufficient condition.

From every time onward, there must eventually be a time `m` and candidate `z` such that

```text
z ∈ U_m                         -- currently distinguishable
z ∉ M_m                         -- genuinely new to the retained repertoire
GeneratedFromAvailable M_m H_m z -- generatively accessible from current material
z ∈ M_{m+1}.                    -- actually retained
```

This is the explicit causal chain

```text
U_t -> H_t -> M_{t+1}.
```

Together with monotone retention, Lean proves

```text
generative capacity uptake
    -> open-ended cumulative novelty
    -> unbounded distinguishability capacity.
```

A progressive witness on the natural numbers is machine checked: at time `n`, the retained repertoire is `{0,...,n}`, the envelope additionally exposes `n+1`, and the current unary generator maps retained parent `n` to `n+1`.

## 4. Separating opportunity from realization

The packaged uptake condition is sufficient but strong. `CapacitySlack.lean` therefore separates it into two premises.

### Recurring capacity slack

From every time onward, there is a later moment with

```text
M_m ⊂ U_m.
```

So unused distinguishability capacity keeps reappearing.

### Immediate generative realization

Whenever

```text
M_m ⊂ U_m,
```

the current generator can produce at least one candidate in `U_m \ M_m`, and that candidate is retained in `M_{m+1}`.

Lean proves

```text
recurring capacity slack
+ local generative realization
+ retention
    -> open-ended cumulative novelty.
```

With the representation condition `M_t ⊆ U_t`, the same premises also imply unbounded envelope capacity.

This gives the current theorem sandwich:

```text
recurring slack + realization + retention
    -> open-ended cumulative novelty
    -> unbounded distinguishability capacity.
```

The left implication is a sufficient mechanism. The right implication is necessary. The formalization does **not** claim that the left-hand premises are minimal or that the two arrows combine into an iff characterization.

## 5. Relation to open-ended-evolution terminology

The broader open-ended-evolution literature distinguishes ongoing novelty within an existing space from stronger forms that expand or transform the relevant state space. The present formalization should be read as an elementary capacity/uptake scaffold beneath such distinctions, not as a replacement for them.

In particular, the current Lean predicate counts retained novelty events. A full evolutionary claim would need additional conditions for viability, adaptation, evaluation, or external correction. Those belong to a further layer rather than being silently built into `U_t`, `H_t`, or `M_t`.

## 6. What this adds to the Evolution-by-Emergence stack

The current chain is now:

```text
maintenance
-> retention
-> reusable intermediates and coexistence
-> finite-parent generation / recombination
-> expanded effective search
-> possible generator-rule evolution
-> repeated uptake of newly distinguishable possibilities
-> cumulative novelty
```

subject to the necessary higher-level condition that effective distinguishability capacity cannot remain uniformly bounded if cumulative novelty is genuinely open-ended.

The remaining scientific step is to add **external validation/corrigibility** to the novelty process, so that open-ended production is not confused with open-ended production of arbitrary internally generated states.
