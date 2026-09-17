# Bridge: finite generative saturation and the fixed-resolution no-go boundary

This note records the precise relationship between the recursive-accessibility
formalization and the repository's fixed-resolution organizational-depth work.
It is a conceptual bridge, not a claim that the two theorem stacks are
identical.

## 1. The finite generative saturation result

`CumulativeAccessibility/FiniteGenerativeSaturation.lean` proves a purely
combinatorial statement.

Let `S n` be the retained repertoire after step `n`, and let `U` be a fixed
finite declared universe. If

1. `S n ⊆ U` for every `n`, and
2. retention is monotone, `S n ⊆ S (n+1)`,

then, for every finite horizon `N`,

```text
number of strict expansion steps before N
    ≤ |U| - |S 0|.
```

The theorem allows arbitrary idle periods and does **not** require the
generative rule to remain fixed. A changing rule can change *which* remaining
states are reached, but cannot create more than the finite remaining capacity
of `U` while all novelty is retained inside `U`.

A stronger fixed-rule specialization is also proved. If the update is a fixed
deterministic inflationary map `F : Finset α → Finset α` closed inside `U`,
then some `n ≤ |U| - |S 0|` satisfies

```text
S (n+k) = S n     for every k ≥ 0.
```

Thus a fixed deterministic retained closure reaches an actual fixed point.
The direct finite implementation of retained hypergraph generation is proved
to satisfy this specialization.

## 2. The fixed-resolution paper's geometric factor

The tightness analysis for **Organizational Depth at Finite Time: A
Fixed-Resolution No-Go Boundary** distinguishes consecutive transition counts
from retained depth and introduces packing depth. Its two-factor bound includes
the geometric obstruction

```text
D_δ ≤ P_δ(X),
```

where `P_δ(X)` is the `δ`-packing number of the operational state space. The
point of that factor is that revisiting or shuttling between a small number of
states does not create additional retained depth.

This geometric obstruction is independent of the paper's thermodynamic factor.

## 3. What is shared

Both results express the same elementary finite-capacity logic at different
levels of representation:

- the fixed-resolution result limits how many mutually distinguishable retained
  states can coexist at resolution `δ`;
- the generative-saturation result limits how many strict retained repertoire
  additions can occur inside a declared finite candidate universe.

The bridge becomes direct only after declaring how a generative state is mapped
to an operationally distinguishable state or resolution class. The Lean
saturation theorem itself does **not** formalize that physical/operational map.

In particular, a continuous state space may contain infinitely many distinct
mathematical states even when its fixed-`δ` packing number is finite. Therefore
`|U|` should not silently be identified with `P_δ(X)` without an explicit
representation or coding assumption.

## 4. Consequence for open-ended evolution

The strengthened saturation result corrects an easy overstatement:

> changing the generative rule is not, by itself, enough to evade finite
> cumulative novelty capacity.

If the effective distinguishable universe remains fixed and finite, and old
novelty remains retained, then the total number of strict additions is finite
regardless of how the rule changes through time.

Therefore indefinitely many strict **cumulative** novelty events require at
least one finite-capacity premise to fail. Examples include:

- the effective distinguishable state space/repertoire is not finite or keeps
  expanding;
- the operational representation or resolution changes so that new
  distinctions become available;
- external structure enlarges the effective universe of possible retained
  organization;
- retention is abandoned, allowing turnover/revisitation rather than
  cumulative depth.

The last case can support indefinite *change* without indefinite cumulative
retained novelty, exactly the distinction highlighted by the shuttle example
in the fixed-resolution tightness analysis.

## 5. Relation to second-order evolution

The recursive-accessibility stack now separates two second-order mechanisms:

1. **repertoire-driven expansion** — retained modules change while the
   generative rule is fixed;
2. **rule-driven expansion** — the generative rule changes while the retained
   repertoire is fixed.

Both can expand the *effective one-step search operator*. The finite-saturation
boundary adds a higher-level constraint: neither mechanism alone guarantees
open-ended cumulative novelty inside a fixed finite distinguishable universe.

So a sharper stack is:

```text
maintenance
→ retention
→ reusable intermediates / coexistence
→ expanded effective search
→ possible rule evolution
→ further cumulative novelty
subject to finite distinguishability capacity.
```

Open-ended cumulative evolution additionally requires that the effective space
of retained distinguishable possibilities itself remain open.
