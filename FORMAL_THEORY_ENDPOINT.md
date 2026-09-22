# Formal Theory Endpoint — v20 Peer-Review Freeze

**Status:** v20 review specification  
**Purpose:** define the exact theory object being frozen for broad independent review.

## 1. Review object

The canonical v20 object is:

1. THEORY_CORE_V20.md
2. FORMAL_THEORY_MAP.md
3. PEER_REVIEW_PROMPT.md
4. formalization/cumulative-accessibility/UNIVERSAL_LAW_CANDIDATE.md
5. formalization/cumulative-accessibility/README.md
6. the canonical Lean modules named in THEORY_CORE_V20.md
7. CumulativeAccessibility/AuditAll.lean
8. CumulativeAccessibility/VerificationSurface.lean

Reviewers should resolve release/tag v20 to an exact commit SHA and review that immutable object.

## 2. Descriptive thesis under review

> **Retained organization can become causal structure for future change by altering transition machinery and therefore later accessibility, while finite maintenance resources constrain what can remain retained. Recursive repetition of this history-retention-accessibility process provides a substrate-agnostic architecture for cumulative evolution.**

This is the scientific thesis to challenge. Machine checking supports conditional theorem components; it does not establish empirical universality.

## 3. Minimal causal grammar

    S_t = (G_t, R_t, Gamma_t, B_t^gross)
    B_t^free = B_t^gross - M(R_t)

    R_t -> K_t -> A_t -> generated organization -> retained organization R_(t+1)

with the simultaneous maintenance path

    R_t -> M(R_t) -> B_t^free -> feasible change.

Strict emergence and bounded generative leverage are separate constraints on this recursive architecture.

## 4. What is formally closed for v20

The v20 review surface includes checked results for:

- matched retain/ablate counterfactuals;
- paid maintenance and free-budget accounting;
- budget-monotone accessibility;
- route-induced finite-horizon accessibility from weighted transition kernels;
- transition-dominance preservation;
- necessary kernel advantage for paid opening under non-decreasing upkeep;
- sufficient route-saving-over-upkeep condition;
- abstract-core to kernel-reachability bridge;
- strict-emergence target-financing barrier;
- positive auxiliary-support requirement;
- transition-mediated emergence specialization and countermodels;
- bounded single-unit reuse;
- resource-normalized generative leverage;
- finite-budget no-go for retaining an overfull positive-cost candidate set;
- paid reuse / repetition specializations;
- supporting dynamic-vortex resource-response composition.

## 5. What remains deliberately open

v20 does not close:

- empirical universality;
- a universal scalar measure of organization or function;
- strong creation of previously unstatable ontologies;
- a universal optimizer deciding which retained item survives;
- stochastic generalization of every deterministic specialization;
- empirical measurement mappings across all domains;
- normative conclusions.

These are review or research questions, not hidden theorem claims.

## 6. Cross-domain challenge

The same logical architecture should be tested without changing its definitions in substantially different substrates, including at least:

- cellular / biochemical organization;
- organismal or immune memory;
- neural learning;
- cumulative culture / language;
- technological evolution.

A failed mapping is informative. A domain should not be forced into the theory by arbitrary relabeling.

## 7. Learning-like interpretation

The theory uses **learning-like** as an interpretation of the repeated history -> retention -> changed-accessibility dynamic across nested layers.

It does not assert that cells, societies, or technologies literally learn in the psychological sense. It does not infer intelligence or consciousness from satisfying the formal interfaces.

## 8. Peer-review gates

The v20 object is suitable for broad review when:

- the exact release commit passes the advertised Lean workflows;
- AuditAll imports the advertised modules;
- VerificationSurface prints the selected theorem dependencies;
- no audited theorem depends on sorryAx;
- the README, theory core, map, prompt, and release notes all point to the same v20 object;
- necessity and sufficiency are labelled in the correct direction;
- the finite-budget result is described as a trade-off/no-go rather than an optimizer;
- the learning-like interpretation is labelled as an empirical cross-scale hypothesis;
- older v17-v19 material is clearly historical/supporting rather than the current canonical theory.

## 9. Freeze rule

After v20 is tagged, core claims and theorem semantics are frozen for the review window.

Subsequent changes that alter the review object should receive a new release rather than silently moving v20.

Typos, links, and non-semantic presentation repairs may be made only in later versions; the immutable v20 tag remains the reviewed reference.

## 10. How to falsify or narrow the theory

A strong challenge can show any of the following:

1. a formal theorem defect;
2. a mismatch between prose and formal semantics;
3. a hidden assumption doing the explanatory work;
4. an equal or stronger antecedent in existing literature;
5. a genuine cumulative-evolution system that cannot instantiate the interfaces non-arbitrarily;
6. a counterexample to the proposed cross-scale universality;
7. evidence that the factorization provides no explanatory or predictive leverage.

## 11. What counts as success

The goal of the review is not endorsement.

Success means criticism becomes localizable: theorem, definition, modelling premise, prior art, mapping, empirical claim, or interpretation.

A successful falsification or narrowing is a contribution.

## 12. Exact verification commands

    cd formalization/cumulative-accessibility
    lake update
    lake exe cache get
    lake build CumulativeAccessibility.AuditAll CumulativeAccessibility.VerificationSurface
    lake env lean CumulativeAccessibility/VerificationSurface.lean

The v20 release notes record the exact release object and its lineage.