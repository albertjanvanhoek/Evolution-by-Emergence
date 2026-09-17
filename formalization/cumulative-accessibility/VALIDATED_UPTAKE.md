# External validation: separating novelty from accepted improvement

This note adds the next layer above open-ended generative uptake without identifying persistence, novelty, or internal generability with adaptation, truth, or usefulness.

## 1. Architecture

The cumulative-accessibility stack now separates four time-dependent objects:

```text
M_t  retained repertoire
H_t  current finite-parent generative rule
U_t  current distinguishability envelope
E_t  declared external test / acceptance criterion
```

The first three objects describe what is retained, what can be generated from it, and what can currently be represented as a distinct candidate. The fourth is deliberately external to that internal generative loop.

`E_t(z)` means only that candidate `z` passes the declared criterion at time `t`. The formalization does not assume that `E_t` is complete, infallible, uniquely correct, or equivalent to objective truth, biological fitness, or utility.

## 2. Validated generative capacity uptake

`ValidatedUptake.lean` defines a sufficient mechanism in which, from every time onward, there is eventually a time `m` and candidate `z` satisfying

```text
z ∈ U_m
z ∉ M_m
GeneratedFromAvailable M_m H_m z
E_m(z)
z ∈ M_{m+1}.
```

This extends the previous internal chain

```text
U_t -> H_t -> M_{t+1}
```

to an externally screened chain

```text
U_t -> H_t -> candidate -> E_t -> M_{t+1}.
```

The arrow notation is schematic: the Lean theorem does not assert a physical causal model for `E_t`; it requires the external predicate as an explicit premise.

## 3. Machine-checked implications

Lean proves

```text
validated generative capacity uptake
    -> generative capacity uptake
```

and separately

```text
validated generative capacity uptake
    -> eventual validated novel uptake.
```

Therefore, with monotone retention,

```text
validated generative capacity uptake
    -> open-ended cumulative retained novelty.
```

With the additional representation condition `M_t ⊆ U_t`, it also implies

```text
unbounded distinguishability capacity.
```

The progressive natural-number architecture is also checked as a positive witness under an accept-all criterion. This shows the validated-uptake predicate is non-vacuous; it is not an argument that indiscriminate acceptance is a meaningful scientific criterion.

## 4. The separation result

The important conceptual result is the converse failure.

Using the same progressive open-ended architecture together with an external criterion that rejects every candidate, Lean proves

```text
open-ended cumulative novelty
AND
not eventual validated novel uptake.
```

Hence

```text
new != externally validated.
```

Open-ended production alone is not evidence of open-ended adaptation, truth tracking, usefulness, or correction.

## 5. Relation to corrigibility

This is only the first formal foothold for corrigibility. `E_t` currently says whether a candidate passes a declared external test. It does not yet model how tests themselves are revised, how contradictory evidence is resolved, or how an organization changes its generator after failed predictions.

A stronger corrective architecture would therefore distinguish at least:

```text
M_t  retained organization / memory
H_t  generative mechanism
U_t  represented possibility envelope
E_t  external test process
C_t  correction/update mechanism acting on M_t and/or H_t after test outcomes
```

The scientifically important next question is then not merely whether novelty is screened, but whether external error can causally alter the future generative process while preserving enough organization for learning to accumulate.

## 6. Conditional bridge to maintenance reproduction

The repository's maintenance-reproduction formalization and this cumulative-accessibility stack now coexist on the same PR branch. They answer different questions:

```text
maintenance reproduction:
    under what recurrent structure can a correction/maintenance organization persist?

validated cumulative accessibility:
    given continued opportunities, what conditions produce repeatedly generated,
    externally screened, retained novelty?
```

`MaintenanceOpportunityBridge.lean` now formalizes the interface between those questions without claiming that one already proves the other.

It defines

```text
RecurringOpportunity O:
    from every time onward, some later time has an opportunity;

OpportunityConditionedValidatedRealization O U H E M:
    whenever an opportunity occurs, at least one genuinely new candidate is
    distinguishable, generated, externally accepted, and retained.
```

Lean then proves

```text
recurring opportunity
+ opportunity-conditioned validated realization
    -> validated generative capacity uptake.
```

Therefore, with monotone retention,

```text
recurring opportunity
+ validated realization
+ retention
    -> open-ended cumulative retained novelty.
```

And with `M_t ⊆ U_t`, the same premises imply unbounded distinguishability capacity.

A separation witness proves that recurring opportunity alone is not enough: even an opportunity at every time is compatible with a repertoire that never changes.

This is the honest current bridge. The maintenance-reproduction algebra has not yet been shown to imply `RecurringOpportunity` for a concrete time-indexed correction process. Establishing that dynamical mapping is the remaining cross-project task rather than an assumption hidden inside the theorem.