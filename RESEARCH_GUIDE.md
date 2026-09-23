# Evolution by Emergence — Research Guide

> A routing document for the current theory, formalizations, specializations and historical corpus.

This repository is an active research corpus by **Albert Jan van Hoek, with AI collaboration**. It contains a universal candidate architecture for cumulative evolution, several formal and numerical specializations, and a separate intelligent-system programme about corrigibility and persistent learning networks.

This guide tells you **what to read for which question**. It is not evidence that the claims are true.

## Current review object — v21

The current release route is:

1. `THEORY_CORE_V21.md` — universal synthesis.
2. `FORMAL_THEORY_MAP.md` — theorem/model map.
3. `FORMAL_THEORY_ENDPOINT.md` — exact review object and release gates.
4. `CLAIMS_V21.md` — compact v21 claim ledger.
5. `formalization/cumulative-accessibility/` — universal structural core inherited from v20.
6. `research/cumulative-reproduction/` — reviewed count-level production/loss/resource dynamics.
7. `UNIVERSAL_TO_INTELLIGENCE.md` — explicit specialization seam.
8. `research/anchored-correctability/` — current deep intelligent-system endpoint.
9. `scap-seed/` — smaller self-contained seed.

The v21 universal centre is:

```text
retained organization
    -> transition machinery
    -> future accessibility
    -> generated organization
    -> production / loss / admission
    -> resource-constrained retention
    -> retained organization ...
```

Two questions are deliberately kept separate:

- **structural:** which retained organization changes later possibilities?
- **dynamical:** under a declared production/loss/resource law, how does the retained repertoire change over time?

The first is handled by the identity-sensitive cumulative-accessibility formalization. The second is handled by the reviewed Cumulative Reproduction Model.

## Intelligent systems are a specialization

The current intelligent-system research package is:

```text
research/anchored-correctability/
```

It adds semantic primitives absent from the universal core:

- candidate worlds;
- claims and meanings;
- evidence and liveness;
- challenge, answerability and tracking;
- exact semantic interfaces;
- correction networks;
- temporal failure/repair;
- SCAP persistence conditions;
- alignment/corrigibility distinctions.

Do not silently import these primitives into universal EbE. Use `UNIVERSAL_TO_INTELLIGENCE.md` to inspect the proposed mapping and its open seam.

### Small entry point

`scap-seed/` is the portable replay/review object for this track. It is intentionally smaller than the deep package and has its own toolchain, claims ledger, contribution rules, simulations and licences.

## Verification boundaries

A green repository does not mean one proof certifies everything.

The main verification surfaces are:

| Surface | Role | Verification |
|---|---|---|
| `formalization/cumulative-accessibility/` | universal retained-organization/accessibility core | Lean/Mathlib audit |
| `research/cumulative-reproduction/` | count-level CRM + E1–E8 | standalone Lean + regressions/simulations |
| `research/anchored-correctability/` | intelligent-system specialization | Lean 4.33, 224 audited headline results |
| `scap-seed/` | portable seed | independent Lean audit + quick simulations |

`.github/workflows/v21-integration-check.yml` runs all four on the same candidate commit.

Passing means each surface passed its own declared check. It does not establish empirical universality, novelty, or equivalence between surfaces.

## Operating protocol

For human or LLM review:

1. **Choose the route before loading context.** Do not treat the whole repository as one undifferentiated theory.
2. **Prefer source over derivative output.** Lean/Markdown/TeX source is authoritative over rendered PDFs where they differ.
3. **Keep theorem direction explicit.** Necessary, sufficient and equivalence statements are not interchangeable.
4. **Separate model classes.** Discrete recurrence, ODE, CTMC and simulation are different evidence objects.
5. **Separate universal from semantic specialization.** Candidate worlds and challenges are not generic EbE primitives.
6. **Treat machine checking correctly.** Lean establishes implications under formal premises; it does not validate empirical premises.
7. **Look for counterexamples, hidden assumptions and prior art.** Narrowing the theory is a useful result.
8. **Do not infer normative obligations from descriptive mathematics.**

## Route A — universal structural core

Read:

- `THEORY_CORE_V21.md`, sections 2–5;
- `formalization/cumulative-accessibility/README.md`;
- `CumulativeAccessibility/RetainedOrganizationCore.lean`;
- `CumulativeAccessibility/TransitionAccessibility.lean`;
- `CumulativeAccessibility/EmergentAssemblyBarrier.lean`;
- `CumulativeAccessibility/TransitionMediatedEmergence.lean`;
- `CumulativeAccessibility/GenerativeLeverage.lean`;
- `CumulativeAccessibility/VerificationSurface.lean`.

Questions to test:

- does the retain/ablate contrast identify a genuine retained cause?
- does the transition/accessibility object match the application?
- are maintenance and route costs commensurable?
- are emergence premises doing hidden work?
- does the bounded-reuse encoding fit the target system?

## Route B — cumulative reproduction dynamics

Read:

- `research/cumulative-reproduction/THEORY.md`;
- `REVIEW.md`;
- `VALIDATION.md`;
- `lean/CumulativeReproduction.lean`;
- `sim/`.

Keep distinct:

- deterministic growth;
- finite-target hitting;
- finite-horizon stochastic survival;
- eventual survival/extinction;
- repertoire affordability;
- critical-mass results conditional on a specific production law.

## Route C — intelligent-system specialization

Read:

- `UNIVERSAL_TO_INTELLIGENCE.md`;
- `research/anchored-correctability/README.md`;
- `ANCHORED_CORRECTABILITY.md`;
- `METAMODEL.md`;
- `lean/AnchoredEvolution/UnifiedTracking.lean`;
- `Realization.lean`;
- `Persistence.lean`;
- `SCAP.lean`;
- `Alignment.lean`;
- `Audit.lean`.

The central progression is:

```text
anchor -> semantic possibility -> executable correction -> tracking
       -> groups/networks -> realization -> changing world + repair
       -> SCAP persistence -> alignment specialization
```

The formal SCAP object is:

```text
Connected ∧ Faithful ∧ Evidence-open ∧ Repairable ∧ Affordable.
```

Do not turn this conjunction into a claim that all five conditions follow from the anchor.

## Route D — SCAP Seed

Start with:

- `scap-seed/README.md`;
- `SEED.md`;
- `CLAIMS.md` inside that folder;
- `FOR_AI_READERS.md`;
- `lean/`;
- `scripts/verify.sh`.

Use the seed when the goal is replayability, challenge, teaching, AI inspection, or a minimal independent object.

Use `research/anchored-correctability/` when the goal is the most complete current technical model.

## Historical releases

- **v20** — retained organization and future accessibility; immutable structural review object.
- **v19** — retained organization and correctable learning.
- **v18** — Learning Constitution / Correctable Interdependence.
- **v17** — Recursive Organization Core.
- **v16** — Dynamic Vortex / full-theory integration.

Historical tags remain the correct source when reviewing an older release. Do not silently project v21 results backwards into v20 or earlier objects.

Useful historical packages remain under:

- `papers/the-room-learning-constitution/`;
- `formalization/collective-alignment/`;
- `formalization/persistence-drift/`;
- `verification/organizational-depth/`;
- `Individual_essays/`.

## Literature position

The repository's default scientific framing is conservative: it is primarily a synthesis/research architecture with exact model-specific results and substantial antecedents across evolutionary theory, network science, cumulative culture, control, resource-constrained dynamics and related fields.

Novelty should be argued against literature, not inferred from terminology or machine verification.

## How to evaluate any claim

Prefer a trace of the form:

```text
claim
 -> exact source
 -> definition(s)
 -> theorem / derivation / simulation
 -> assumptions
 -> converse status
 -> counterexample / ablation
 -> prior art
 -> empirical mapping
 -> interpretation
```

A strong criticism identifies the first link that fails.

A strong positive result reports which links survived an attempted falsification.

## Final epistemic rule

Do not reward the theory for being ambitious and do not reject it for being broad.

Review the smallest testable statement available.

**A successful falsification is a contribution. Prior art is a result. A machine-checked implication is still only an implication under its premises.**
