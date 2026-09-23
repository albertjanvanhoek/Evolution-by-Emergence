# CLAIMS — v21

Compact claim ledger for the current Evolution by Emergence review object.

This file distinguishes machine-checked conditional claims, reviewed analytical/numerical claims, specialization claims, and scientific interpretation. It does not replace the exact Lean sources.

## Universal structural claims

| ID | Claim | Source | Evidence type | Falsification / review path |
|---|---|---|---|---|
| V21-U-001 | Retained organization can alter finite-horizon accessibility by changing weighted transition machinery after maintenance burden is paid. | `RetainedOrganizationCore.lean`; `TransitionAccessibility.lean` | machine-checked conditional architecture | find a theorem defect, semantic mismatch, or non-arbitrary application where the mapping fails |
| V21-U-002 | Under non-decreasing upkeep, positive paid opening requires a retained structural advantage; the ablated kernel cannot dominate the retained kernel. | `TransitionAccessibility.lean` | machine-checked necessary condition | construct a counterexample under exact premises |
| V21-U-003 | A retained route saving exceeding marginal upkeep relative to an ablated lower bound is sufficient for a paid-opening budget window. | `TransitionAccessibility.lean` | machine-checked sufficient condition | construct a counterexample under exact premises |
| V21-U-004 | Under strict compositional emergence and target benefit only after realization, the future target function alone cannot finance a positively costly proper intermediate; viable intermediates require auxiliary support. | `EmergentAssemblyBarrier.lean`; `TransitionMediatedEmergence.lean` | machine checked + countermodels | challenge emergence, benefit timing, upkeep, or construct a formal counterexample |
| V21-U-005 | Under bounded single-unit reuse, accessible repertoire is bounded by retained units times support slots, with a corresponding resource-normalized bound. | `GenerativeLeverage.lean` | machine checked | break the bound under exact encoding or show the encoding is inappropriate |
| V21-U-006 | A positive-cost candidate set cannot all be retained when minimum aggregate upkeep exceeds available budget. | `GenerativeLeverage.lean` | machine-checked no-go | construct a counterexample under exact cost/budget premises |

## Cumulative Reproduction Model claims

| ID | Claim | Source | Evidence type | Falsification / review path |
|---|---|---|---|---|
| V21-D-001 | In the discrete natural-number recurrence, growth/shrinkage/fixed-point statements follow gain versus loss under the declared semantics. | `research/cumulative-reproduction/lean/CumulativeReproduction.lean` | machine checked | produce a Lean counterexample under exact premises |
| V21-D-002 | Uniform supercritical/subcritical regions imply the declared growth/extinction consequences, and linear/quadratic excess premises imply corresponding lower growth bounds. | same | machine checked | challenge exact recurrence premises or proof |
| V21-D-003 | In the linear resource ledger with `mu > eta`, affordability imposes a finite repertoire ceiling. | same; CRM `THEORY.md` | machine checked / analytical interpretation | challenge the ledger mapping or construct counterexample under exact premises |
| V21-D-004 | Finite-target hitting, finite-horizon survival, eventual survival and deterministic growth are distinct; finite-cap no-immigration stochastic systems eventually go extinct despite possible deterministic supercriticality. | CRM `REVIEW.md`; `VALIDATION.md`; simulations | reviewed analytical/numerical result | challenge derivation, implementation or model assumptions |
| V21-D-005 | Critical-mass and `R_c` interpretations depend on the declared production law and parentage assumptions; they are not universal summaries of arbitrary nonlinear dynamics. | CRM `THEORY.md`; `REVIEW.md` | reviewed scope claim | identify an inconsistency or stronger general theorem |

## Intelligent-system specialization claims

| ID | Claim | Source | Evidence type | Falsification / review path |
|---|---|---|---|---|
| V21-S-001 | The same content-indexed tracking law can represent local process tracking and deterministic model revision. | `UnifiedTracking.lean` | machine checked | produce formal counterexample under exact definitions |
| V21-S-002 | Exact semantic relay is stronger than legacy live-preserving sharpening and preserves another model's meaning where claimed. | `UnifiedTracking.lean`; `Realization.lean` | machine checked | challenge exact channel definitions or bridge theorem |
| V21-S-003 | Group/network constructions preserve tracking under explicit doors/interface assumptions, including recursive group-of-groups structure. | `Network.lean`; `SemanticComposition.lean` | machine checked | break a theorem under exact premises or challenge empirical meaning of interfaces |
| V21-S-004 | Abstract correction-network edges can be implemented by bounded challenge/revision episodes, turning graph routes into actual runs with time/cost bounds. | `Realization.lean` | machine checked | challenge `Implements` premise or route/run bridge |
| V21-S-005 | Under open change, fixed informative records cannot remain correct for every possible future; bounded repair converts baseline route loss into bounded temporal delay. | `Persistence.lean` | machine checked | construct counterexample under exact `OpenChange` / `RepairWithin` premises |
| V21-S-006 | SCAP packages Connected, Faithful, Evidence-open, Repairable and Affordable conditions, and under the declared realization/governance premises yields persistent structural correctability with bounded restoration and affordability. | `SCAP.lean` | machine checked | challenge theorem premises, composition, or semantic interpretation |
| V21-S-007 | Corrigibility is formally distinct from obedience/sycophancy; behavioural compliance cannot by itself certify alignment; exact relay preserves distinct content whereas mirroring is blind to another agent's view. | `Alignment.lean` | machine checked specialization | challenge definitions, theorem scope or empirical mapping |

## Specialization claim

| ID | Claim | Source | Evidence type | Falsification / review path |
|---|---|---|---|---|
| V21-X-001 | Anchored Correctability is a plausible specialization of universal EbE because retained records/rules/correction structure can alter later revision accessibility while requiring maintenance. | `UNIVERSAL_TO_INTELLIGENCE.md`; `THEORY_CORE_V21.md` | modeling/synthesis claim | show mapping is arbitrary, fails an interface, or adds assumptions carrying the result independently |

A complete formal embedding theorem between the two architectures has **not** yet been established.

## Scientific interpretation

| ID | Claim | Source | Evidence type | Falsification / review path |
|---|---|---|---|---|
| V21-I-001 | The combined structural and dynamical architecture is a useful candidate framework for resource-constrained cumulative evolution across nested organizational scales. | `THEORY_CORE_V21.md` | scientific hypothesis / synthesis | identify a bona fide cumulative-evolution domain that cannot instantiate the interfaces non-arbitrarily, show explanatory redundancy, or identify stronger prior art |

## Non-claims

v21 does not infer:

- function from persistence;
- improvement from novelty;
- truth from validation;
- progress from selection;
- universal critical mass from arbitrary nonlinear production;
- permanent stochastic persistence from deterministic supercriticality;
- literal cognition from the universal structural model;
- semantic beliefs or challenges as universal EbE primitives;
- normative, legal or political obligations from the descriptive mathematics;
- empirical truth from machine verification.

## Review rule

For any claim, trace:

```text
claim -> definition -> theorem/analysis/simulation -> assumptions -> converse status -> empirical mapping
```

A successful falsification, narrowing, or prior-art correction is a useful result.
