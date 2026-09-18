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

## 6. Quantitative maintenance support and the opportunity bridge

The maintenance-reproduction and cumulative-accessibility projects are linked as Lean packages, but the bridge now preserves more of the maintenance result.

`MaintenanceDynamics.lean` defines a quantitative support relation

```text
Supported(b, x)
    := b is strictly positive
       AND
       x is componentwise at or above b.
```

For the canonical three-cycle vector `b`, Lean proves under nonnegative update coefficients, positivity of the canonical witness, and the **non-strict** product threshold that

```text
forall n, Supported(b, trajectory(n)).
```

The scalar

```text
epsilon = min(b_A, b_B, b_C)
```

is therefore strictly positive and lower-bounds every trajectory component. The vector bound is retained as the primary result. The canonical vector is a mathematically explicit reference level inside this construction; interpreting it as an operational physical threshold still requires application-specific units, normalization, and a model of what those quantities enable.

`MaintenanceOpportunityBridge.lean` keeps support separate from opportunity. Persistent support implies recurring opportunity only when a connection is explicitly declared:

```text
SupportImpliesOpportunity Support Opportunity.
```

Thus maintenance does not constrain an arbitrary external opportunity predicate.

## 7. Response timing and resource feasibility

Let `F(m)` denote a complete successful event at time `m`: a candidate is inside the envelope, fresh, generable from retained material, externally accepted, and retained at the next step.

The original bridge distinguished:

```text
Q := from every horizon, an opportunity occurs later
V := every opportunity time has F
W := from every horizon, a later time has both opportunity and F
G := from every horizon, a later time has F
```

`ResponseDynamics.lean` now separates opportunity time from response time. It introduces:

```text
D_Δ := from every horizon, there is a later opportunity q
       and a validated success r with q ≤ r ≤ q + Δ

B_Δ := every opportunity q receives a resource-feasible
       validated response r with q ≤ r ≤ q + Δ
```

Resource feasibility is quantitative:

```text
Cost(t,z) ≤ Budget(t).
```

The cost is time- and candidate-specific; the budget is time-specific. A resource-validated success still has to satisfy the ordinary envelope, novelty, generation, external-validation, and next-step-retention conditions.

Lean checks:

```text
W <-> D_0
Q and B_Δ -> D_Δ
D_Δ -> G
R and G -> N
P and R and N -> C
```

Thus same-time coincidence is not required once delayed response is represented explicitly. The concrete lag-1 witness places opportunities at even times and successful uptake at odd times. Every opportunity is answered exactly one step later, so `D_1` and `G` hold while `W` is false.

The resource term is also kept independent. Lean checks examples with:

```text
validated success AND not resource-feasible validated success
resource feasibility AND not validated success
```

so neither ordinary success nor a budget inequality silently determines the other.

The earlier same-time theorems remain valid:

```text
Q and V -> W
W -> Q
W -> G
```

but `W` is now understood as the zero-delay member of the larger bounded-response family.

## 8. Internally generated response budget

`EndogenousBudgetBridge.lean` removes the independent response-budget input from the resource side of the response interface.

The physical specialization keeps the external gradient separate from the organization:

```text
G_t                     external gradient / supplied disequilibrium
s_t                     organizational state
U(s_t,G_t)              captured throughput
M(s_t)                  recurring maintenance demand
L_t = U(s_t,G_t)-M(s_t) internal slack
B_t^resp = beta_t L_t   reinvested response budget
```

The system therefore does **not** create its own gradient. What it can change is how much of that gradient it captures and how much throughput maintenance consumes. At fixed `G_t`, an organizational change that raises uptake and/or lowers maintenance weakly raises slack; with `beta_t >= 0`, it weakly raises response budget.

The concrete witness fixes the gradient at `10`, holds maintenance at `6`, and changes uptake from `10` to `11`. This changes internally available slack from `4` to `5`. A response costing `9/2` is therefore inaccessible before the organizational change and accessible afterward. That internally financed response is then used in the existing one-step delayed even/odd architecture, yielding recurrent validated uptake and—under retention—open-ended cumulative novelty.

A second, deliberately separate specialization uses the existing cumulative-accessibility margin

```text
M = B/c* - 1
```

as a response budget in its own dimensionless units. The exact first cumulative click changes

```text
2/3 -> 97/99,
```

so the already-proved `9/10` second-click load lies outside the old budget and inside the new one. This closes the formal seam to the existing budget-ratchet result without claiming that normalized accessibility margin is literally free energy.

The remaining open loop is now narrower: retained novelty does not yet cause the organizational state transition `s_t -> s_{t+1}`. The present witness supplies that state trajectory. Closing that final feedback would require a model in which retained organization changes uptake and/or maintenance, thereby changing future internally generated slack.

## 9. Verification status and current stopping point

`FormalCoreWitness.lean` remains the joint-satisfiability witness, and `MaintenanceGatedWitness.lean` remains the opportunity-gated dependency/ablation witness. `BoundedResponseWitness.lean` adds the lag-1 response witness and the resource-independence regressions. `EndogenousBudgetWitness.lean` adds the fixed-gradient internally funded response witness and the exact cumulative-margin crossing witness.

Verification is split into two explicit surfaces:

```text
AuditAll.lean
    -> imports every module advertised by the package README

VerificationSurface.lean
    -> prints axiom dependencies for the explicit advertised theorem list
```

The new response modules are included in both surfaces. CI compiles them and rejects `sorryAx` in the selected declaration audits.

Resource availability is now endogenous to the declared uptake-minus-maintenance ledger. What remains incomplete is the feedback from successful retained novelty into the organizational state that determines later uptake and maintenance. Response cost, generation, validation, and retention also remain explicit inputs/conditions rather than stochastic consequences of that state.
