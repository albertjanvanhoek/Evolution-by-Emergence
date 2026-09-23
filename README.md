# Evolution by Emergence

## v20 peer-review release: cumulative evolution as retained organization changing future accessibility

Evolution by Emergence (EbE) asks one central question:

> **How can organization that exists now become causal material that changes which organization can exist next?**

v20 remains the immutable peer-review release object. Development on `main` now also contains reviewed post-v20 extensions; a v21 synthesis will distinguish the universal theory from its intelligent-system specialization.

The universal interpretation is a **candidate to be challenged**, not an established empirical law.

## Start here

1. **[THEORY_CORE_V20.md](THEORY_CORE_V20.md)** — immutable v20 universal theory offered for peer review.
2. **[FORMAL_THEORY_MAP.md](FORMAL_THEORY_MAP.md)** — claim-to-Lean traceability for the universal formal programme.
3. **[PEER_REVIEW_PROMPT.md](PEER_REVIEW_PROMPT.md)** — copy-paste adversarial review protocol for humans or LLMs.
4. **[FORMAL_THEORY_ENDPOINT.md](FORMAL_THEORY_ENDPOINT.md)** — exact scope, review criteria, and failure conditions.
5. **[formalization/cumulative-accessibility/README.md](formalization/cumulative-accessibility/README.md)** — v20 retained-organization/accessibility formal core.

## Post-v20 universal development

[Cumulative Reproduction Model](research/cumulative-reproduction/README.md) adds explicit production, loss, critical mass and an upkeep/capture ledger, with standalone Lean proofs and reproducible E1–E8 experiments. Its review keeps deterministic growth, finite-target hitting, finite-horizon survival and asymptotic persistence distinct. It extends rather than replaces the identity-sensitive v20 accessibility architecture.

## Intelligent-system specialization

[Anchored Correctability / Persistence / SCAP](research/anchored-correctability/README.md) is the current deep intelligent-system research endpoint. It adds epistemic objects not assumed by the universal model—candidate worlds, semantic claims, evidence, challenge, answerability and tracking—and develops exact interfaces, operational realization, bounded repair, a formal SCAP invariant, and an alignment specialization.

### Start small: SCAP Seed

[SCAP Seed](scap-seed/README.md) is a smaller, self-contained derivation and review object for the intelligent-system track. It has its own pinned Lean project, claims ledger, simulations, contribution rules and licences. The seed is intentionally frozen and portable; it does not supersede the newer research package above.

## Core in one paragraph

The v20 state is represented as active organization G, retained organization R, context Gamma, and gross budget. Retention consumes maintenance cost, leaving free budget. Retained organization may also alter the effective transition machinery, thereby changing which targets are reachable within a horizon and budget. A retained item counts as cumulatively consequential only under an explicit retained-versus-ablated comparison after maintenance is paid. Strict compositional emergence adds an assembly constraint: a future emergent function cannot, by itself, finance positively costly proper intermediates that do not yet realize that function. Finite resource budgets additionally make unrestricted positive-cost retention impossible, while bounded retained memory plus bounded reuse bounds accessible repertoire.

The reviewed Cumulative Reproduction Model adds a complementary count-level dynamic: retained organization can be produced and lost while paying upkeep and capturing resources. The v21 synthesis will keep these two roles separate—**which retained organization changes later accessibility**, and **how a retained repertoire grows, collapses or is budget-limited**.

## The two-sided role of retained history

Retained history simultaneously:

    changes future machinery        R -> K -> A

and

    consumes future capacity        R -> M(R) -> B_free.

This tension is central. Cumulative evolution is not unlimited remembering. Under finite resources, retention becomes a trade-off.

## Necessary and sufficient results are kept distinct

The v20 transition surface contains:

- a **necessary structural condition**: with non-decreasing upkeep, positive paid opening implies that the ablated kernel cannot reproduce every retained transition at equal or lower cost;
- a **sufficient quantitative condition**: if a retained route's saving exceeds marginal upkeep, there exists a common gross-budget window with retained access and ablated non-access.

These are not stated as converses of each other.

## Emergence remains separate

Strict compositional emergence is not defined as retention or success. If a future emergent function is unavailable in every proper subconfiguration, then that function cannot finance a positively costly proper intermediate by itself. If such an intermediate persists, another support route is required. The transition-mediated specialization and its countermodels make those escape routes explicit.

## What is machine checked

The repository now contains several independently checked surfaces rather than one proof certifying everything:

- the v20 cumulative-accessibility formal core;
- the reviewed Cumulative Reproduction Model;
- the Anchored Correctability / Persistence / SCAP intelligent-system specialization;
- the self-contained SCAP Seed.

A green build means the stated theorem follows from its formal premises. It does **not** mean the premises describe every real system, nor that one package certifies the others.

## What reviewers should attack

Reviewers are asked to localize criticism:

1. **formal validity** — does a conclusion fail under its exact premises?
2. **semantic adequacy** — does the formal predicate fail to mean what the prose claims?
3. **prior art** — does an existing theory already provide an equal or stronger architecture?
4. **explanatory value** — is the factorization unnecessary or uninformative?
5. **cross-domain mapping** — does a real cumulative-evolution system resist non-arbitrary instantiation?
6. **universality** — can a bona fide cumulative evolutionary process be shown to lack retained-history effects on later accessibility under any defensible mapping?

A successful falsification, narrowing, or prior-art correction is a useful outcome.

## Non-claims

The universal EbE programme does not infer:

    persistence -> function
    novelty -> improvement
    validation -> truth
    selection -> progress
    retention -> goodness
    learning-like dynamics -> literal cognition
    machine proof -> empirical truth
    descriptive dynamics -> moral or political obligation

The intelligent-system specialization adds semantic and epistemic premises explicitly; those premises are not silently promoted to universal axioms.

## Reproduce the v20 formal surface

    git clone https://github.com/albertjanvanhoek/Evolution-by-Emergence.git
    cd Evolution-by-Emergence/formalization/cumulative-accessibility
    lake update
    lake exe cache get
    lake build CumulativeAccessibility.AuditAll CumulativeAccessibility.VerificationSurface
    lake env lean CumulativeAccessibility/VerificationSurface.lean

## Earlier releases

- **v20** — Cumulative Evolution: Retained Organization and Future Accessibility.
- **v19** — Retained Organization and Correctable Learning.
- **v18** — The Learning Constitution: Correctable Interdependence.
- **v17** — Recursive Organization Core.
- **v16** — Full Theory Peer-Review Release / Dynamic Vortex integration.

Those releases remain immutable historical review objects. Use [RESEARCH_GUIDE.md](RESEARCH_GUIDE.md) for the wider corpus.

---

*Evolution by Emergence is an active, corrigible research corpus by Albert Jan van Hoek with AI collaboration. Formal verification establishes mathematical implications under explicit assumptions. Scientific interpretation, application, and normative conclusions remain open to evidence and peer review.*
