# Evolution by Emergence v20 — Cumulative Evolution: Retained Organization and Future Accessibility

v20 is the first release that freezes the consolidated retained-organization theory as the repository's primary object for independent peer review.

The centre is:

> **Retained organization can become causal structure for future change by altering transition machinery and later accessibility, while finite maintenance resources constrain what can remain retained.**

The proposed cross-domain interpretation is a candidate theory of cumulative evolution. Its universality is explicitly open to falsification.

## 1. Canonical review object

Start with:

1. `THEORY_CORE_V20.md` — canonical theory.
2. `FORMAL_THEORY_MAP.md` — claim-to-Lean traceability.
3. `PEER_REVIEW_PROMPT.md` — reproducible adversarial review protocol.
4. `FORMAL_THEORY_ENDPOINT.md` — review freeze, scope, and failure conditions.
5. `formalization/cumulative-accessibility/README.md` — formal package overview.
6. `formalization/cumulative-accessibility/UNIVERSAL_LAW_CANDIDATE.md` — universality guardrails and nested learning-like interpretation.
7. `formalization/cumulative-accessibility/CumulativeAccessibility/VerificationSurface.lean` — explicit axiom audit.

Reviewers should resolve tag `v20` to its exact commit SHA and review that immutable object.

## 2. State and paid retention

The core state is:

    S_t = (G_t, R_t, Gamma_t, B_t^gross)
    B_t^free = B_t^gross - M(R_t).

Retained history therefore has two simultaneous effects:

    R_t -> transition machinery -> future accessibility

and

    R_t -> maintenance burden -> reduced free budget.

v20 promotes this resource-constrained recursive loop to the centre of the theory.

## 3. Transition machinery now induces the canonical accessibility surface

`TransitionAccessibility.lean` defines weighted transition kernels, actual finite routes, route cost, and finite-horizon accessibility under a free budget.

Lean checks that kernel dominance preserves accessibility at equal horizon and budget.

The release then distinguishes two theorem directions:

### Necessary structural condition

With non-decreasing upkeep, positive paid opening implies that the ablated kernel cannot reproduce every retained transition at equal or lower cost.

### Sufficient quantitative condition

If a retained route's cost saving exceeds the marginal retention burden relative to a lower bound on ablated routes, there exists a common gross-budget window in which the target is accessible with retained organization and inaccessible without it.

These statements are deliberately **not** presented as converses.

## 4. Bridge back to the retained-organization core

The generic core retains an abstract graded accessibility interface. The v20 publication-facing surface instantiates that interface from transition-kernel reachability.

Lean proves that positive core transfer under this implementation is exactly retained reachability plus ablated non-reachability under each arm's own post-maintenance budget.

This closes the main K -> A -> paid-transfer semantic seam identified during adversarial review.

## 5. Emergent assembly barrier

`EmergentAssemblyBarrier.lean` and `TransitionMediatedEmergence.lean` give strict compositional emergence a load-bearing role.

If a future function is strictly emergent and target-specific benefit is unavailable before realization, then a positively costly proper intermediate cannot finance itself from that future function alone.

If the intermediate remains viable, some positive auxiliary support is required.

The transition-mediated specialization derives the same conclusion when realizing the emergent function is what adds a transition.

Permanent countermodels show escape routes:

- dropping emergence can allow a proper part to transfer;
- favorable upkeep accounting can create apparent opening without kernel improvement;
- a proper part can persist as a stepping stone through another transition.

## 6. Finite resources force retention trade-offs

`GenerativeLeverage.lean` now includes the direct no-go:

    if every candidate costs at least mu > 0
    and B < |C| mu,
    then retaining all of C is budget-infeasible.

This is intentionally not an optimizer or a fitness rule. The theorem does not decide which candidate is forgotten, replaced, compressed, made cheaper, reused more effectively, or retained.

## 7. Bounded generative leverage

Under an injective bounded single-unit reuse encoding:

    |A| <= |R| d.

With minimum retained-unit maintenance mu and total maintenance budget B:

    |A| mu <= B d.

Uniformly bounded retained cardinality plus uniformly bounded per-unit reuse therefore rules out unbounded accessible cardinality under the declared encoding.

Failure of the encoding may itself be scientifically informative, for example by revealing compositional or synergistic support.

## 8. Nested learning-like dynamics

v20 makes the scale-free interpretation explicit:

    history / interaction
      -> retained organization
      -> changed transition machinery
      -> changed future accessibility
      -> new organization
      -> budget-constrained retention.

This is described as **learning-like dynamics**, not as a claim that every substrate literally learns psychologically.

The architecture can now be challenged across nested layers including cellular organization, immune memory, neural learning, individual memory and skill, cumulative culture, institutions, science, and technology.

The nesting also allows context to change: a learning individual changes while the surrounding technological and social repertoire changes too.

Lean does not establish that all these domains share one empirical mechanism. That is a principal scientific test of v20.

## 9. Peer-review protocol

`PEER_REVIEW_PROMPT.md` has been rewritten around the v20 release.

Reviewers are asked to attack:

1. formal validity;
2. semantic adequacy;
3. hidden modelling assumptions;
4. equal-or-stronger prior art;
5. explanatory value;
6. cross-domain mappings;
7. the proposed universality itself.

A successful falsification, narrowing, or prior-art correction is an intended useful outcome.

## 10. Verification surface

The canonical v20 Lean review files are:

    RetainedOrganizationCore.lean
    TransitionAccessibility.lean
    EmergentAssemblyBarrier.lean
    TransitionMediatedEmergence.lean
    GenerativeLeverage.lean
    PaidReuseHierarchy.lean
    RepetitionDepth.lean
    DynamicVortex.lean
    AuditAll.lean
    VerificationSurface.lean

The explicit audit surface includes the finite-budget retention theorem.

Reproduce with:

    cd formalization/cumulative-accessibility
    lake update
    lake exe cache get
    lake build CumulativeAccessibility.AuditAll CumulativeAccessibility.VerificationSurface
    lake env lean CumulativeAccessibility/VerificationSurface.lean

The release criterion is that the advertised surface compiles and the selected axiom audit contains no `sorryAx`.

## 11. Scope boundaries

v20 does not prove:

- empirical universality;
- that all state dependence is cumulative evolution;
- that retention is always beneficial;
- that novelty is improvement;
- that persistence is function;
- that validation is truth;
- that selection is progress;
- that learning-like dynamics imply literal cognition;
- a universal rule choosing which retained item survives;
- strong creation of previously unstatable ontologies in the current fixed ambient Lean types;
- a moral, legal, or political obligation from the descriptive mathematics.

## 12. Relationship to earlier releases

- **v19 — Retained Organization and Correctable Learning:** developed the paid-retention synthesis and intelligent-agent specialization.
- **v18 — The Learning Constitution:** separate machine-checked correctable-interdependence companion.
- **v17 — Recursive Organization Core:** corrected recursive-emergence and moving-envelope surface.
- **v16 — Full Theory Peer-Review Release:** Dynamic Vortex resource-response integration.

v20 consolidates these developments around the retained-organization -> transition-machinery -> accessibility spine and makes that consolidated object the theory to be peer reviewed.

## 13. Review thesis

A defensible current formulation is:

> **Evolution by Emergence v20 provides machine-checked substrate-agnostic constraints linking retained organization, transition-induced future accessibility, maintenance cost, strict compositional emergence, finite-budget retention trade-offs, and bounded generative leverage. It proposes that their recursive composition captures a learning-like architecture of cumulative evolution across nested organizational scales.**

The first sentence is the formal contribution. The second is the scientific hypothesis to challenge.