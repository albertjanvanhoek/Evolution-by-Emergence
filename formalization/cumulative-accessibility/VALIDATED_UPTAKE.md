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

A stronger corrective architecture could distinguish, for example:

```text
M_t  retained organization / memory
H_t  generative mechanism
U_t  represented possibility envelope
E_t  external test process
C_t  correction/update mechanism acting on M_t and/or H_t after test outcomes
```

That would be a generalization of the present formal core, not a missing premise of the theorem proved here.

## 6. Closed bridge to maintenance reproduction

The maintenance-reproduction and cumulative-accessibility projects are now linked as Lean packages.

`MaintenanceDynamics.lean` turns the finite three-cycle maintenance witness into a deterministic time-indexed trajectory. For nonnegative self-retention and couplings, the coordinatewise cone above the canonical witness is forward invariant once the closed-loop replacement threshold is met. Under positive deficits/couplings and the strict product threshold, the canonical trajectory is strictly positive at every time.

Lean therefore proves

```text
strict positive three-cycle maintenance conditions
    -> positive maintenance availability at every time
    -> arbitrarily late maintenance availability.
```

`MaintenanceOpportunityBridge.lean` imports that result and discharges the formerly abstract recurrence premise:

```text
strict three-cycle maintenance
    -> RecurringOpportunity(cycle3MaintenanceOpportunity).
```

Together with the still-explicit response condition,

```text
OpportunityConditionedValidatedRealization,
```

Lean proves the cross-stack theorem

```text
strict closed maintenance loop
+ opportunity-conditioned validated realization
+ monotone retention
    -> open-ended cumulative retained novelty.
```

With `M_t ⊆ U_t`, the same premises imply

```text
unbounded distinguishability capacity.
```

The response condition remains essential. Maintenance keeps an organization available for future interaction; it does not logically force the organization to generate novelty, pass an external test, or retain the result. A separation witness already proves that opportunities alone are insufficient.

## 7. Formal-core closure and non-vacuity

`FormalCoreWitness.lean` checks that the complete premise set is jointly inhabited rather than merely syntactically composable.

It chooses

```text
rA = rB = rC = 1/2
kAB = kBC = kCA = 1,
```

so that

```text
(1-rA)(1-rB)(1-rC) = 1/8 < 1 = kAB kBC kCA.
```

The progressive accessibility architecture generates and retains a new candidate at every time and the declared accept-all criterion validates those candidates. Lean machine-checks the complete route

```text
concrete maintenance dynamics
    -> recurrent maintenance availability
    -> validated response
    -> open-ended cumulative retained novelty
    -> unbounded moving-envelope capacity.
```

This is a natural **formal-core closure point**. The stated theorem chain is complete under explicit assumptions, the major converse failures are represented by counterexamples, and the assumptions are jointly non-vacuous.

Further work can still generalize the maintenance network, model changing external tests, replace monotone retention with turnover/memory, or test whether real systems satisfy the assumptions. Those are new mathematical or empirical questions; they are not required to make the present implication formally complete.
