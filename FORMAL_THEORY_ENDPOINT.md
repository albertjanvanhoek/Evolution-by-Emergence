# Formal Theory Endpoint — v21 Peer-Review Freeze

**Status:** v21 release/review specification  
**Purpose:** define the exact repository-level theory object offered for independent review while keeping universal and intelligent-system scopes separate.

## 1. Canonical v21 object

The v21 review object is:

1. `THEORY_CORE_V21.md`;
2. `FORMAL_THEORY_MAP.md`;
3. `RELEASE_NOTES.md`;
4. `formalization/cumulative-accessibility/`;
5. `research/cumulative-reproduction/`;
6. `UNIVERSAL_TO_INTELLIGENCE.md`;
7. `research/anchored-correctability/`;
8. `scap-seed/`;
9. `.github/workflows/v21-integration-check.yml`.

The packages have separate verification boundaries. The repository-level review object is their documented composition, not a claim that one package proves the others.

## 2. Universal thesis under review

> **Retained organization can alter later transition machinery and future accessibility while paying maintenance costs, and retained organization can itself participate in production/loss dynamics under finite resources. Their coupled but distinct treatment provides a substrate-agnostic candidate architecture for cumulative evolution.**

The structural/accessibility part is inherited from v20. The reviewed Cumulative Reproduction Model adds a distinct count-level dynamical specialization.

Machine checking establishes conditional theorem components. It does not establish empirical universality.

## 3. Universal causal grammar

```text
S_t = (G_t, R_t, Gamma_t, B_t^gross)
B_t^free = B_t^gross - M(R_t)

R_t -> transition machinery -> future accessibility
R_t -> maintenance burden -> free budget
R_t / generated organization -> production / loss / admission -> R_(t+1)
```

The identity-sensitive structural question and count-level repertoire question are not collapsed.

## 4. Formally closed universal surface

The v21 universal surface includes the v20 machine-checked results for:

- matched retain/ablate counterfactuals;
- paid maintenance and free-budget accounting;
- finite-horizon accessibility from weighted transition kernels;
- kernel-dominance preservation;
- necessary retained-kernel advantage for paid opening;
- sufficient route-saving-over-upkeep condition;
- strict compositional emergence financing barriers;
- auxiliary-support requirements and countermodels;
- bounded single-unit reuse;
- finite-resource retention no-go results;
- paid reuse / repetition specializations.

The reviewed CRM additionally provides a standalone Lean surface for conditional discrete recurrence and ledger results, plus independently scoped ODE/CTMC analysis and simulations.

## 5. Intelligent-system specialization

`research/anchored-correctability/` is not part of the universal axiom set. It introduces:

- candidate worlds and semantic claims;
- evidence and liveness;
- challenge, answerability and tracking;
- exact semantic communication interfaces;
- correction-network composition;
- operational realization with time/cost;
- changing worlds, link failure and bounded repair;
- SCAP persistence conditions;
- an alignment specialization.

Its top-level theorem object is the explicit SCAP conjunction:

```text
Connected ∧ Faithful ∧ Evidence-open ∧ Repairable ∧ Affordable.
```

Under the declared realization/governance premises, `SCAP.scap_persistent_correctability` composes structural correctability, an exactly faithful route, bounded temporal restoration and affordability.

This remains a specialization, not a theorem that all EbE systems have beliefs or semantic claims.

## 6. SCAP Seed

`scap-seed/` is a smaller self-contained review/replay object. It has its own Lean toolchain, claims ledger, contribution rules, simulations and licences.

The seed is deliberately independent:

- seed proofs do not certify the larger repository;
- larger-repository results do not weaken seed-local proofs;
- the seed may remain frozen while the deep specialization evolves.

## 7. What remains open

v21 does not close:

- empirical universality;
- a universal scalar measure of organization or function;
- a universal optimizer for retention;
- a theorem that every nonlinear production law has one critical mass;
- physical realizability of mathematical blow-up;
- complete identification between the universal and intelligent-system architectures;
- globally-clocked concurrent realization of all repair/communication dynamics;
- theorem-level stochastic repair thresholds for the fragmentation simulations;
- empirical cross-domain measurement mappings;
- normative conclusions.

## 8. Specialization boundary

`UNIVERSAL_TO_INTELLIGENCE.md` records the proposed mapping from retained organization and transition accessibility to records, revision rules, challenge/evidence processes and maintained correction networks.

This is a declared research seam. A reviewer should challenge whether the specialization instantiates the universal interfaces non-arbitrarily and whether any additional semantic premises are justified.

## 9. Peer-review gates

The v21 object is ready for release/review only when:

- `RELEASE_VERSION`, `RELEASE_TITLE` and `RELEASE_NOTES.md` all identify v21;
- `THEORY_CORE_V21.md`, this endpoint and `FORMAL_THEORY_MAP.md` point to the same architecture;
- the universal structural surface passes its Lean audit without `sorryAx`;
- the reviewed CRM Lean/regression/smoke checks pass;
- Anchored Correctability builds and its advertised 224 theorem audit is present without `sorryAx`;
- SCAP Seed passes its own proof/audit and quick simulation checks;
- `.github/workflows/v21-integration-check.yml` is green on the exact candidate commit;
- necessity and sufficiency remain labelled in the correct direction;
- deterministic, stochastic and simulation claims remain separated;
- the intelligent-system specialization is not presented as a universal EbE axiom.

## 10. Freeze rule

Once v21 is tagged, the v21 tag is immutable. Later semantic changes belong in a later release.

The historical `v20` tag remains the immutable reference for the prior retained-organization/accessibility-only review object.

## 11. How to falsify or narrow v21

A strong challenge can show:

1. a formal theorem defect;
2. a mismatch between prose and formal semantics;
3. a hidden assumption doing the explanatory work;
4. structural and count-level models have been conflated;
5. a stronger or equal prior theory already exists;
6. a genuine cumulative system cannot instantiate the universal interfaces non-arbitrarily;
7. an intelligent-system mapping adds unjustified semantics or fails to instantiate the universal architecture;
8. simulation conclusions do not survive the stated parameter/model changes;
9. the architecture adds no explanatory or predictive leverage.

## 12. Verification command surfaces

### Universal structural core

```bash
cd formalization/cumulative-accessibility
lake update
lake exe cache get
lake build CumulativeAccessibility.AuditAll CumulativeAccessibility.VerificationSurface
lake env lean CumulativeAccessibility/VerificationSurface.lean
```

### Cumulative Reproduction Model

Use `research/cumulative-reproduction/README.md` and its path-scoped workflow.

### Anchored Correctability / SCAP

Use `research/anchored-correctability/README.md` and its 224-result audit workflow.

### SCAP Seed

Use `scap-seed/README.md` and `scripts/verify.sh`.

The v21 integration workflow runs all four surfaces on the same commit.

## 13. What counts as success

The goal is not endorsement. Success means criticism becomes localizable to theorem, definition, modelling premise, model boundary, specialization seam, prior art, empirical mapping or interpretation.

A successful falsification or narrowing is a contribution.