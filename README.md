# Evolution by Emergence

## v20 peer-review release: cumulative evolution as retained organization changing future accessibility

Evolution by Emergence (EbE) asks one central question:

> **How can organization that exists now become causal material that changes which organization can exist next?**

v20 is the repository's current theory object for independent peer review. It consolidates the retained-organization programme into a machine-auditable substrate-agnostic architecture connecting:

    retained organization
        -> transition machinery
        -> future accessibility
        -> generated organization
        -> budget-constrained retention
        -> retained organization ...

with explicit maintenance cost, emergence constraints, counterfactual ablation, and bounded generative leverage.

The universal interpretation is a **candidate to be challenged**, not an established empirical law.

## Start here

1. **[THEORY_CORE_V20.md](THEORY_CORE_V20.md)** — canonical theory offered for peer review.
2. **[FORMAL_THEORY_MAP.md](FORMAL_THEORY_MAP.md)** — claim-to-Lean traceability for v20.
3. **[PEER_REVIEW_PROMPT.md](PEER_REVIEW_PROMPT.md)** — copy-paste adversarial review protocol for humans or LLMs.
4. **[FORMAL_THEORY_ENDPOINT.md](FORMAL_THEORY_ENDPOINT.md)** — exact scope, freeze, review criteria, and failure conditions.
5. **[formalization/cumulative-accessibility/README.md](formalization/cumulative-accessibility/README.md)** — formal package overview and reproduction instructions.
6. **[formalization/cumulative-accessibility/UNIVERSAL_LAW_CANDIDATE.md](formalization/cumulative-accessibility/UNIVERSAL_LAW_CANDIDATE.md)** — scientific interpretation, universality guardrails, and cross-domain challenge.
7. **[CumulativeAccessibility/VerificationSurface.lean](formalization/cumulative-accessibility/CumulativeAccessibility/VerificationSurface.lean)** — explicit advertised-result axiom audit.

## Research extension under review

[Cumulative Reproduction Model](research/cumulative-reproduction/README.md) adds explicit production, loss and an upkeep/capture ledger, with standalone Lean proofs and reproducible simulations. Its review separates deterministic thresholds, finite-horizon survival and asymptotic growth. It is a research specialization; v20 remains the canonical review object.

## Core in one paragraph

The state is represented as active organization G, retained organization R, context Gamma, and gross budget. Retention consumes maintenance cost, leaving free budget. Retained organization may also alter the effective transition machinery, thereby changing which targets are reachable within a horizon and budget. A retained item counts as cumulatively consequential only under an explicit retained-versus-ablated comparison after maintenance is paid. Strict compositional emergence adds an assembly constraint: a future emergent function cannot, by itself, finance positively costly proper intermediates that do not yet realize that function. Finite resource budgets additionally make unrestricted positive-cost retention impossible, while bounded retained memory plus bounded reuse bounds accessible repertoire. The resulting recursive architecture motivates a testable learning-like dynamic across nested organizational scales.

## The two-sided role of retained history

Retained history simultaneously:

    changes future machinery        R -> K -> A

and

    consumes future capacity        R -> M(R) -> B_free.

This tension is central. Cumulative evolution is not unlimited remembering. Under finite resources, retention becomes a trade-off.

Lean now includes a direct no-go: if every candidate in a retained set costs at least mu > 0 and B < |C| mu, then retaining the whole candidate set cannot satisfy the maintenance budget.

Lean does not determine which candidate is forgotten, compressed, replaced, made cheaper, or retained.

## Necessary and sufficient results are kept distinct

The current transition surface contains:

- a **necessary structural condition**: with non-decreasing upkeep, positive paid opening implies that the ablated kernel cannot reproduce every retained transition at equal or lower cost;
- a **sufficient quantitative condition**: if a retained route's saving exceeds marginal upkeep, there exists a common gross-budget window with retained access and ablated non-access.

These are not stated as converses of each other.

## Emergence remains separate

Strict compositional emergence is not defined as retention or success. If a future emergent function is unavailable in every proper subconfiguration, then that function cannot finance a positively costly proper intermediate by itself. If such an intermediate persists, another support route is required. The transition-mediated specialization and its countermodels make those escape routes explicit.

## Nested learning-like dynamics

The theory can be tested at nested scales: cellular organization, immune memory, neural learning, individual skill and memory, language, cumulative culture, institutions, science, and technology.

This is deliberately called **learning-like** rather than claiming that every substrate literally learns in the psychological sense. The empirical challenge is whether each domain can instantiate retained organization, maintenance, transition machinery, accessibility, and ablation without arbitrary relabeling.

Both retained state and context may change. A person can learn and forget while the surrounding social and technological repertoire changes simultaneously.

## What is machine checked

The v20 review surface includes machine-checked results for:

- matched retain/ablate counterfactuals and paid transfer;
- budget-monotone accessibility;
- weighted transition kernels and route-induced accessibility;
- transition dominance and accessibility preservation;
- necessary kernel advantage for positive paid opening;
- route-saving sufficiency after marginal upkeep;
- bridge from the abstract core to kernel-induced reachability;
- strict compositional emergence assembly barriers;
- auxiliary-support requirement for viable emergent intermediates;
- transition-mediated emergence with adversarial countermodels;
- bounded-memory / bounded-reuse accessibility constraints;
- finite-budget infeasibility of an overfull positive-cost retained candidate set;
- paid reuse and repetition-depth specializations;
- dynamic-vortex and earlier recursive-organization support layers.

The advertised proof surface is imported by AuditAll.lean and explicitly audited by VerificationSurface.lean. CI rejects sorryAx on that reviewed surface.

Machine checking means the conclusions follow from the formal premises. It does **not** mean the premises describe every real system.

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

EbE v20 does not infer:

    persistence -> function
    novelty -> improvement
    validation -> truth
    selection -> progress
    retention -> goodness
    learning-like dynamics -> literal cognition
    moving envelope -> strong unprestatable ontology creation
    machine proof -> empirical truth
    descriptive dynamics -> moral or political obligation

## Reproduce the formal surface

    git clone https://github.com/albertjanvanhoek/Evolution-by-Emergence.git
    cd Evolution-by-Emergence/formalization/cumulative-accessibility
    lake update
    lake exe cache get
    lake build CumulativeAccessibility.AuditAll CumulativeAccessibility.VerificationSurface
    lake env lean CumulativeAccessibility/VerificationSurface.lean

## Earlier releases

- **v19** — Retained Organization and Correctable Learning.
- **v18** — The Learning Constitution: Correctable Interdependence.
- **v17** — Recursive Organization Core.
- **v16** — Full Theory Peer-Review Release / Dynamic Vortex integration.

Those releases remain immutable historical review objects. v20 is the current consolidated theory to review.

Use [RESEARCH_GUIDE.md](RESEARCH_GUIDE.md) for the wider corpus.

---

*Evolution by Emergence is an active, corrigible research corpus by Albert Jan van Hoek with AI collaboration. Formal verification establishes mathematical implications under explicit assumptions. Scientific interpretation, application, and normative conclusions remain open to evidence and peer review.*