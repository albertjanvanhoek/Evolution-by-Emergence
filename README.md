# Evolution by Emergence

## A formal architecture of recursive organization

**Evolution by Emergence (EbE)** asks:

> **How can organization that exists now become material that changes which organization can exist next?**

The repository contains a historical book, essays, papers, models, and formalizations. The current v17 integration is making one small formal core stable enough to underpin that larger corpus.

The goal is **not** to claim priority for mechanisms that are already known. The goal is a self-standing, machine-auditable, literature-positioned theory that reviewers can attack precisely.

## Start here

1. **[THEORY_CORE_V17.md](THEORY_CORE_V17.md)** — the self-standing theory.
2. **[FORMAL_THEORY_ENDPOINT.md](FORMAL_THEORY_ENDPOINT.md)** — the completion and peer-review readiness criteria.
3. **[APPLICATION_MAPPINGS_V17.md](APPLICATION_MAPPINGS_V17.md)** — two worked mappings plus a deliberate partial non-mapping.
4. **[FORMAL_THEORY_MAP.md](FORMAL_THEORY_MAP.md)** — claim-to-Lean traceability.
5. **[CLAIMS.md](CLAIMS.md)** — claim ledger and non-claims.
6. **[verification/audits/2026-09-19-recursive-emergence/](verification/audits/2026-09-19-recursive-emergence/)** — theorem, adversarial, and literature audits.
7. **[PRIOR_ART_PREFLIGHT_V17.md](verification/audits/2026-09-19-recursive-emergence/PRIOR_ART_PREFLIGHT_V17.md)** — targeted search for an equal-or-stronger full antecedent.
8. **[COLD_READER_PREFLIGHT_V17.md](verification/audits/2026-09-19-recursive-emergence/COLD_READER_PREFLIGHT_V17.md)** — repository-only semantic/navigation reconstruction.
9. **[EvolutionByEmergenceV17Core.lean](formalization/cumulative-accessibility/CumulativeAccessibility/EvolutionByEmergenceV17Core.lean)** — canonical v17 theorem surface.
10. **[PEER_REVIEW_PROMPT.md](PEER_REVIEW_PROMPT.md)** — reproducible review protocol.

Until v17 is frozen, **v16 remains the latest immutable historical review release**.

## The theory in one paragraph

Persistent organization has to be produced and maintained by processes. Some changes in organization realize capacities that no declared proper part realizes alone. If a new capacity is feasible, passes the relevant domain-specific validation or selection filter, and is retained, it can become operational material for later generation. Retained material can alter what becomes generable next.

But:

```text
possible
!= generated
!= realized
!= emergent
!= feasible
!= validated
!= retained
!= reusable
!= admitted to future search
!= recursively cumulative
```

The formal theory exists largely to keep these distinctions from collapsing.

## Two cumulative endpoints

### Operational accumulation

If previously acquired capacities remain operational, a seed plus sufficient local recursive continuation can produce arbitrarily many strict expansions of the active repertoire.

### Historical accumulation with turnover

Real systems can forget, lose, replace, or deactivate capabilities. The v17 core therefore separates:

```text
Active_t
History_t
```

Parents must be operationally active to be reused. `History_t` is a declared cumulative trace of capacities the application records as having occurred; the formalism does not independently validate the empirical record.

Lean now contains a witness where `|Active_t| = 1` for every time, the active repertoire turns over completely, and cumulative history still expands. So open-ended historical accumulation does not imply an ever-growing current operational repertoire.

## Stronger construction bridge

The generic recursive layer only requires that parents generate a child capacity and that some configuration realizes that capacity emergently.

The v17 integration adds an optional stronger interface:

```text
parents construct configuration c for child
AND
the same c realizes the child capacity emergently
AND
the same event passes feasibility, validation, and retention filters
```

Applications that can justify this stronger bridge can close the configuration-level causal seam; weaker applications can remain explicit about using only capacity-level generation.

## Primitive promotion and future generability

PR #59 adds an essential-parent test: holding the next-step generator fixed, a downstream candidate is no longer generable when the newly retained primitive is removed. This establishes an essential contribution under the declared counterfactual, not sole causation.

A finite admission policy then separates all newly generable possibilities from the finite candidates actually admitted to local search.

## What is machine checked

The formal stack currently checks, among other things:

- relative compositional emergence;
- separation of emergence from historical novelty and prediction;
- feasibility / validation / retention filtering;
- recursive parent reuse;
- configuration-level constructive projection;
- essential-parent generated-access expansion;
- finite local admission and moving envelopes;
- deterministic local successor counting;
- sufficient recursive continuation implications;
- fixed finite retained-repertoire saturation;
- active/history separation under complete active turnover;
- non-vacuity witnesses and multiple countermodels.

The advertised proof surface is imported by `AuditAll.lean` and its selected axiom dependencies are printed by `VerificationSurface.lean`. CI rejects `sorryAx` on that surface.

Machine checking means the conclusions follow from the formal premises. It does **not** mean the premises describe every real system.

## What is not claimed

```text
novelty -> improvement
persistence -> function
validation -> truth
retention -> goodness
possibility -> realization
larger search space -> progress
self-maintenance -> automatic innovation
historical accumulation -> growing active repertoire
machine proof -> empirical truth
```

The theory also does not derive a moral or political objective. Values and domain evidence choose goals; EbE can then ask what organization must actually be generated, implemented, maintained, transmitted, and reused for a chosen outcome to become and remain real.

## Literature position

The mechanisms have strong antecedents in evolutionary theory, open-ended evolution, adjacent-possible models, changing phase spaces, novelty/co-option, evolvability, generative RAFs, major transitions, cumulative culture, technological recombination, viability/reachability, resource-limited maintenance, and systems construction.

EbE therefore does **not** claim to have discovered the verbal idea that earlier organization can become reusable and enable later organization.

The candidate contribution under review is narrower:

> **a machine-checked cross-domain factorization that keeps realization, emergence, feasibility, validation, retention, operational promotion, construction/parent reuse, finite admission, successor reproduction, saturation, and moving accessibility explicit, together with checked countermodels against invalid shortcuts.**

See:

- [LITERATURE_POSITIONING.md](verification/audits/2026-09-19-recursive-emergence/LITERATURE_POSITIONING.md)
- [CLOSEST_ANTECEDENTS.md](verification/audits/2026-09-19-recursive-emergence/CLOSEST_ANTECEDENTS.md)
- [LITERATURE_DIFFERENCE_MATRIX.md](verification/audits/2026-09-19-recursive-emergence/LITERATURE_DIFFERENCE_MATRIX.md)

If an existing theory already provides the same full role more clearly and strongly, that is a useful review result.

## Relation to the v16 Dynamic Vortex

The Dynamic Vortex remains part of the larger stack. Its main role is:

```text
maintenance / uptake / resource slack
    -> feasible response and search
```

The recursive-emergence core asks:

```text
realized retained response
    -> reusable organization
    -> changed generability
    -> future candidates
    -> later retained organization
```

The bridge is not automatic: more resource slack does not by itself prove another validated recursive innovation.

## Worked mappings

[APPLICATION_MAPPINGS_V17.md](APPLICATION_MAPPINGS_V17.md) tests the same definitions against:

1. autocatalytic / reaction-network organization;
2. technological / cultural cumulative innovation, including a climate-transition example with an explicit normative firewall;
3. a fixed-operator genetic algorithm as a partial non-mapping.

## When is it ready for broad review?

The criterion is not certainty.

> **We are ready when we no longer know of an internal contradiction, hidden theorem assumption, obvious stronger antecedent, ambiguous core term, or missing distinction that would predictably waste reviewers' time.**

The full gates are in [FORMAL_THEORY_ENDPOINT.md](FORMAL_THEORY_ENDPOINT.md). The targeted prior-art and cold-reader preflights are now complete; the remaining pre-release gate is final exact-head verification followed by freezing/tagging the review object.

Reviewers should attack:

1. formal validity;
2. semantic adequacy;
3. prior art;
4. explanatory usefulness;
5. application validity;
6. empirical support;
7. normative inference.

A successful falsification or narrowing is a contribution.

## Reproduce the formal surface

```bash
git clone https://github.com/albertjanvanhoek/Evolution-by-Emergence.git
cd Evolution-by-Emergence/formalization/cumulative-accessibility
lake update
lake exe cache get
lake build CumulativeAccessibility.AuditAll CumulativeAccessibility.VerificationSurface
lake env lean CumulativeAccessibility/VerificationSurface.lean
```

For v17, inspect these modules:

```text
EmergentCapacity.lean
VocabularyEmergence.lean
EmergencePersistenceBridge.lean
RecursiveEmergence.lean
ConstructiveRecursiveEmergence.lean
ActiveHistory.lean
LocalEmergenceReproduction.lean
EndogenousEnvelopePromotion.lean
EvolutionByEmergenceV17Core.lean
```

## Historical releases and wider corpus

- **v16** — Full Theory Peer-Review Release; Dynamic Vortex integration.
- **v15** — Verification Closure baseline.

The historical book and essays remain in the repository because the formal core is intended to underpin and discipline that broader work, not erase its development. Use [RESEARCH_GUIDE.md](RESEARCH_GUIDE.md) for the full corpus.

---

*Evolution by Emergence is an active, corrigible research corpus by Albert Jan van Hoek with AI collaboration. Formal verification establishes mathematical implications under explicit assumptions. Scientific interpretation, application, and normative conclusions remain open to evidence and peer review.*