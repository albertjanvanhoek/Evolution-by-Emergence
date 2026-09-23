# Formal Theory Map — v21 Review Surface

**Purpose:** trace the v21 universal synthesis and its intelligent-system specialization to their exact verification surfaces, while keeping model boundaries explicit.

## Canonical v21 objects

### Universal theory

- `THEORY_CORE_V21.md` — current universal synthesis.
- `formalization/cumulative-accessibility/` — identity-sensitive retained-organization/accessibility core inherited from v20.
- `research/cumulative-reproduction/` — reviewed count-level production/loss/resource dynamics.

### Intelligent-system specialization

- `UNIVERSAL_TO_INTELLIGENCE.md` — declared specialization seam.
- `research/anchored-correctability/` — deep semantic/operational specialization.
- `scap-seed/` — smaller self-contained seed.

The specialization adds candidate worlds, semantic claims, evidence, challenge, answerability and tracking. Those are not universal EbE axioms.

## V21 theorem and model spine

| ID | Claim / object | Source | Status | Important boundary |
|---|---|---|---|---|
| V21-U1 | Retain/ablate arms are matched on active organization, context and gross budget. | `RetainedOrganizationCore.lean` | machine checked | does not identify the empirically correct retained item |
| V21-U2 | Paid retention changes free budget through maintenance burden. | `RetainedOrganizationCore.lean` | machine checked | retention need not be beneficial |
| V21-U3 | Weighted transition-kernel dominance preserves finite-horizon accessibility at equal budget. | `TransitionAccessibility.lean` | machine checked | empirical dominance is application-specific |
| V21-U4 | Positive paid opening requires retained structural advantage under non-decreasing upkeep. | `TransitionAccessibility.lean` | machine-checked necessary condition | not sufficient |
| V21-U5 | A retained route saving exceeding marginal upkeep relative to an ablated lower bound is sufficient for a paid-opening window. | `TransitionAccessibility.lean` | machine-checked sufficient condition | not necessary |
| V21-U6 | Strict compositional emergence blocks financing of a positively costly proper intermediate by the future target function alone; viable intermediates need auxiliary support. | `EmergentAssemblyBarrier.lean`; `TransitionMediatedEmergence.lean` | machine checked | other support routes may sustain the intermediate |
| V21-U7 | Bounded single-unit reuse yields `|A| <= |R| d` and its maintenance-normalized bound. | `GenerativeLeverage.lean` | machine checked | compositional support can escape the encoding |
| V21-U8 | Positive-cost candidates cannot all be retained when their minimum total upkeep exceeds the available budget. | `GenerativeLeverage.lean` | machine checked | no optimizer is supplied |
| V21-D1 | For the discrete CRM recurrence, growth/shrinkage/fixed-point conditions follow gain versus loss under the stated natural-number semantics. | `research/cumulative-reproduction/lean/CumulativeReproduction.lean` | machine checked | does not prove the ODE or CTMC |
| V21-D2 | Uniformly supercritical/subcritical regions imply the corresponding discrete growth/extinction results under their stated premises. | same | machine checked | threshold existence is model-dependent |
| V21-D3 | Linear and quadratic excess conditions imply corresponding lower growth bounds. | same | machine checked | not a universal classification of growth |
| V21-D4 | Under the linear ledger with `mu > eta`, affordability implies a finite repertoire ceiling. | same + `THEORY.md` | machine checked / analytic specialization | if `eta >= mu`, absence of this ceiling does not imply growth or physical feasibility |
| V21-D5 | Finite-target hitting, finite-horizon survival, eventual survival and deterministic growth are distinct quantities. | `REVIEW.md`; `VALIDATION.md`; E1/E2/E5/E7 | reviewed analytic/numerical distinction | simulations are not Lean proofs |
| V21-S1 | Exact semantic relay is distinguished from weaker live-preserving sharpening. | `UnifiedTracking.lean`; `Realization.lean` | machine checked | semantics are specialization-specific |
| V21-S2 | One content-indexed tracking law covers local process tracking and deterministic model revision. | `UnifiedTracking.lean` | machine checked | does not establish empirical universality |
| V21-S3 | Groups/networks can preserve tracking under the declared doors/interface conditions. | `Network.lean`; `SemanticComposition.lean` | machine checked | collective action is separate from epistemic openness |
| V21-S4 | Abstract network links can be realized as bounded Layer-1b challenge/revision episodes with time and cost. | `Realization.lean` | machine checked | implementation is an explicit premise/interface |
| V21-S5 | Under open change, a fixed informative record cannot remain correct in every possible future; bounded repair turns baseline route loss into bounded temporal delay. | `Persistence.lean` | machine checked | stochastic repair threshold is separate simulation/theory |
| V21-S6 | SCAP packages Connected, Faithful, Evidence-open, Repairable and Affordable conditions. | `SCAP.lean` | machine checked object | not all five follow from the anchor |
| V21-S7 | Under SCAP plus realization/governance premises, persistent structural correctability, an exactly faithful route, bounded temporal restoration and affordability hold together. | `SCAP.scap_persistent_correctability` | machine checked | not yet one globally-clocked concurrent process |
| V21-S8 | Corrigibility is distinct from obedience/sycophancy; behavioural compliance alone cannot certify alignment; exact relay preserves another view's meaning. | `Alignment.lean` | machine checked specialization | not a universal psychological model |

## Universal definitions retained from v20

### State and budget

```text
State = (active G, retained R, context Gamma, grossBudget)
freeBudget = grossBudget - Maintenance(retained)
```

### Paid transfer

Matched retained and ablated arms share active organization, context and gross budget. Positive paid transfer requires a retained causal effect after each arm pays its own maintenance burden.

### Weighted transition machinery

A `WeightedKernel` supplies allowed one-step transitions and nonnegative transition costs. `ReachableWithin` requires an actual finite route within both horizon and free budget.

### Strict compositional emergence

A declared whole realizes a capacity while every declared proper subconfiguration does not.

### Bounded reuse

A declared encoding injectively assigns accessible targets to retained units and bounded support slots.

## CRM specialization

The reviewed Cumulative Reproduction Model introduces a repertoire count `N`, gain/loss rules and model-specific resource accounting. It is intentionally not substituted for the identity-sensitive accessibility model.

Use:

```text
research/cumulative-reproduction/THEORY.md
research/cumulative-reproduction/REVIEW.md
research/cumulative-reproduction/VALIDATION.md
research/cumulative-reproduction/lean/CumulativeReproduction.lean
```

The ODE, CTMC and E1–E8 experiments are separate analytical/numerical objects whose scope is documented in that package.

## Intelligent-system specialization seam

The mapping from universal EbE to Anchored Correctability is declared in `UNIVERSAL_TO_INTELLIGENCE.md`.

Typical correspondences are:

```text
retained organization    -> retained records, revision rules, correction structure
transition machinery     -> challenge/evidence/revision transitions
future accessibility     -> reachable model revisions / correction routes
maintenance burden       -> cost of keeping correction processes and links available
context change            -> changing evidence/world conditions
restoration               -> repair of correction routes
```

This mapping is a proposed specialization. A theorem proving complete equivalence between the two architectures has not been established.

## Verification contract

The v21 release candidate must pass four independent surfaces on one commit:

1. `formalization/cumulative-accessibility/` — structural universal surface;
2. `research/cumulative-reproduction/` — CRM Lean core + regressions/smoke simulations;
3. `research/anchored-correctability/` — 224-result audited intelligent-system package;
4. `scap-seed/` — self-contained seed verification and quick simulations.

`.github/workflows/v21-integration-check.yml` runs that matrix.

A green matrix means each package passes its own verification boundary. It does not mean one package proves another or that the scientific interpretations are empirically true.

## Historical relation

The detailed v20 theorem map remains frozen at tag `v20`. v21 preserves those theorem directions and adds the reviewed CRM and explicitly separated intelligent-system specialization.

## Review outcome classes

Classify findings as one of:

- formal defect;
- semantic mismatch;
- hidden modelling premise;
- model-boundary conflation;
- prior-art correction;
- counterexample / universality failure;
- specialization failure;
- empirical uncertainty;
- explanatory redundancy;
- interpretation or normative overreach.

A successful falsification or narrowing is a useful result.