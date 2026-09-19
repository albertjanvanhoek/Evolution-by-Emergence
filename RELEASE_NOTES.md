# Evolution by Emergence v17 — Recursive Organization Core

`v17` is the fixed peer-review release of the recursive-organization formal core developed through PRs #56–#60.

The v17 work does not seek a priority claim. Its target is a self-standing, machine-auditable, literature-positioned descriptive core that can underpin the repository's papers and essays while keeping empirical mappings and normative premises outside the proof kernel.

## v17 formal endpoint

The canonical candidate core is now documented in:

- `THEORY_CORE_V17.md` — self-standing formal theory;
- `FORMAL_THEORY_ENDPOINT.md` — readiness criteria for broad review;
- `APPLICATION_MAPPINGS_V17.md` — cross-domain mappings and a partial non-mapping;
- `EvolutionByEmergenceV17Core.lean` — canonical Lean theorem surface;
- `verification/audits/2026-09-19-recursive-emergence/` — theorem, adversarial, and literature audits.

## Formal changes since v16

### Recursive emergence and moving local envelopes

The #57-#59 research sequence introduced and then corrected a recursive-emergence master architecture:

```text
retained emergent child
    -> reusable parent material
    -> later generated candidate
    -> resource / validation / retention filters
    -> next retained child
```

The first deterministic reproduction specialization used a globally finite `Capacity` type. The later audit proved that an indefinitely monotonically accumulating process cannot satisfy the resulting master premises inside a fixed finite global capacity universe.

The corrected v17 operational core therefore uses:

```text
possibly non-finite ambient Capacity
+ finite time-local candidate envelopes U_t
+ seed
+ monotone active retention
+ locally certified effective successor reproduction
    -> open-ended cumulative operational novelty
    -> with representation, unbounded envelope capacity.
```

### Endogenous envelope promotion

A retained child can be promoted to operational primitive status. PR #59 strengthens later attribution by requiring the child to be essential for a downstream generated candidate under a fixed next-step generator. Newly enabled possibilities are then separated from a finite admission policy and from independent next-event filtering.

This does not claim that promotion automatically produces another successful innovation.

### Constructive generated-configuration bridge

`ConstructiveRecursiveEmergence.lean` adds an optional stronger event semantics in which the finite parent set constructs the **same configuration** that witnesses the child capacity's compositional emergence and filtered retention.

The stronger event projects to the existing capacity-level recursive event, so previous results remain available to applications that can justify the stronger construction relation.

### Active repertoire versus cumulative history

`ActiveHistory.lean` separates current operational availability from cumulative historical trace.

Lean proves a concrete turnover architecture in which:

```text
|Active_t| = 1 for every t,
Active is not monotone,
History is open-ended.
```

Thus v17 distinguishes:

- open-ended cumulative **operational** novelty, which uses monotone active retention;
- open-ended cumulative **historical** novelty, which permits active loss and turnover.

## Literature positioning

The v17 audit explicitly treats the following as antecedents rather than discoveries:

- open-ended-evolution frameworks and finite-system limits;
- adjacent-possible triggering;
- changing phase-space / enablement theories;
- co-option, exaptation, modularity, and evolvability;
- autocatalytic and generative RAF hierarchies;
- major evolutionary transitions;
- cumulative-cultural ratchets;
- technological recombination and building blocks;
- co-evolving cultural/technological repertoires and search spaces;
- constrained reachability and resource-limited maintenance;
- formal component construction and reuse.

The candidate contribution under review is therefore the exact cross-domain factorization, theorem/countermodel surface, and machine-auditable separation of interfaces—not the broad idea that earlier organization can enable later organization.

## Review readiness

The v17 object is not ready to tag merely because CI is green. Broad review requires:

1. final exact-head proof/no-`sorryAx` verification;
2. semantic consistency across repository entry points;
3. explicit literature ancestry and unresolved prior-art questions;
4. application mappings that use stable definitions;
5. a fixed reviewer path and review protocol;
6. a frozen commit/release so all reviewers inspect the same object.

The prior-art and cold-reader preflights are complete, and the release is published only from the exact `main` commit that passes the repository's deployment workflow. `v17` is therefore the recommended immutable object for review of the recursive-organization core.

---

**Historical v16 note.** The text below is preserved as the release description
for v16. References below to the "current" or "canonical" theory are relative to
that frozen v16 release. For the present candidate v17 authority hierarchy, use
README.md, THEORY_CORE_V17.md, and EvolutionByEmergenceV17Core.lean.

# Evolution by Emergence v16 — Full Theory Peer-Review Release

`v16` is the first fixed release in which the current **Evolution by Emergence**
theory is presented as one accessible, formally traceable, adversarially
reviewable research object.

The release does not claim that every component mechanism is new or universal.
Its central scientific claim is architectural:

> **Existing organization uses environmental throughput to maintain and modify
> itself; retained modifications change resources, reusable structure, or
> generative possibilities, thereby changing which organizations can exist
> next.**

The repository now exposes that claim through one theory document, one dynamic
overview, one claim-to-Lean map, explicit non-claims, and a repository-wide
verification workflow.

## 1. The full theory is now one review surface

The canonical entry point is:

- `THEORY.md` — accessible full theory;
- `DYNAMIC_OVERVIEW.md` — the resource-fed recursive accessibility vortex;
- `FORMAL_THEORY_MAP.md` — exact theory-claim → Lean-declaration map;
- `formalization/README.md` — proof packages and local reproduction commands;
- `CLAIMS.md` — current core claim ledger and explicit non-claims;
- `PEER_REVIEW_PROMPT.md` — adversarial review protocol.

The historical 2025 book remains part of the repository as the intellectual
history of the project. It is no longer presented as the most precise statement
of the current scientific theory.

## 2. The integrated dynamic thesis

The central causal architecture is:

```text
encounter / association
    → productive coupling
    → recurrent maintenance
    → resource solvency and internal slack
    → response / search
    → validation and retention
    → reusable historical organization
    → changed generator / second-order accessibility
    → changed organization
    → changed future uptake, maintenance, and search
    ↺
```

The integrated formal core preserves the distinctions:

- maintenance ≠ innovation;
- opportunity ≠ successful response;
- resource feasibility ≠ validation;
- novelty ≠ improvement;
- retention ≠ function;
- capacity ≠ realized novelty;
- selection ≠ global progress;
- external validation predicate ≠ objective truth.

## 3. New end-to-end dynamic composition

The release includes `DynamicVortex.lean` and
`DynamicVortexWitness.lean`.

A `DynamicVortexTurn` is one declared organizational transition that:

1. strictly increases internal slack at the same external gradient; and
2. is a genuine second-order accessibility click.

Lean proves that such a turn opens both:

- a nonempty interval of newly affordable response costs; and
- at least one future-search candidate unavailable to the old organization.

The recurrent composition theorem combines internally funded validated response
with recurring second-order organizational updates. Under explicit opportunity,
retention, and representation assumptions it yields:

[
oxed{
	ext{open-ended cumulative retained novelty}
land
	ext{unbounded effective distinguishability capacity}
land
	ext{recurring second-order organizational updates}.
}
]

The concrete witness jointly inhabits these conditions.

The retained-response → physical-organizational-update connection remains an
explicit modelling interface. The release does not assume that every novelty
event improves physical organization.

## 4. Endogenous resource budget

The external environmental gradient remains a boundary condition, while usable
response budget is generated internally:

[
L_t=mathcal U(s_t,G_t)-mathcal M(s_t),
]

[
B_t^{mathrm{resp}}=eta_tL_t.
]

The fixed-gradient witness keeps the external gradient at 10, maintenance at 6,
and raises organization-dependent uptake from 10 to 11:

[
L:4ightarrow5.
]

A response of cost (9/2) crosses from infeasible to feasible.

This closes the earlier budget seam without claiming that organization creates
the external thermodynamic gradient.

## 5. Retained history and evolving accessibility

The release retains and integrates the existing formal results that:

- retained generated intermediates can become later parent material;
- retained module changes can expand effective search;
- generator-rule changes can expand effective search;
- a viable transition can be a `SecondOrderClick`;
- retained history can expose a future candidate unavailable to an ancestor.

Thus the formalization distinguishes movement through a fixed search space from
change in the search-generating structure itself.

## 6. Selection, persistence, and function

The full theory now explicitly incorporates the persistence-drift and
collective-alignment results instead of leaving them as adjacent packages.

Under explicit toy-model assumptions:

- cheaper functionally equivalent implementations can increase slack;
- released slack can increase search;
- state-dependent return-path effects can overwhelm the ordinary positive
  selection component;
- persistence and declared function can diverge;
- privately selected control can fall below a sufficient functional threshold;
- recurrent corrective protocols require their own maintenance and
  reproduction.

These are conditional results, not a theorem that evolution always progresses
or that collaboration is inherently beneficial.

## 7. Physical boundaries

The full theory also integrates the finite-capacity and organizational-depth
results.

Lean checks that:

- a fixed finite distinguishability universe cannot support indefinitely many
  strict retained expansions;
- open-ended cumulative retained novelty requires unbounded effective
  distinguishability capacity in the declared representation model;
- under explicit finite-action/speed-limit assumptions, bounded finite-time
  resources bound fixed-resolution organizational depth;
- in the finite-state Markov/channel specialization, total-variation data
  processing transfers the physical bound to operational distinguishability.

Therefore:

[
oxed{
	ext{recursive accessibility}

eq
	ext{finite-time physical explosion}.
}
]

## 8. Full-theory verification

This release adds:

```text
.github/workflows/full-theory-proof-check.yml
```

The workflow builds and source-audits the five major supporting proof families:

1. affinity layer;
2. collective alignment and recurrent maintenance;
3. persistence, selection, and slack;
4. cumulative accessibility and the dynamic vortex;
5. organizational depth and the physical/operational bridge.

The selected theory-surface source runs fail if their printed axiom
dependencies contain `sorryAx`.

Before release preparation, the exact integrated PR head passed all five jobs.
The release workflow itself only creates the tag after the repository's
`Build & Deploy Site` workflow succeeds on `main`, so the published tag
identifies the tested release commit.

## 9. Exact theory-to-proof traceability

`FORMAL_THEORY_MAP.md` labels claims as:

- **MC — machine checked**;
- **CW — concrete witness**;
- **EXT — external mathematics**;
- **MODEL — modelling interface**;
- **INT — interpretation/research programme**.

Every Lean declaration named in the map was resolved against its cited source
file during release preparation. A documentation mismatch in the
maintenance-debt section was found and corrected before release.

## 10. Current core claim ledger

`CLAIMS.md` now separates twelve current core claims from older application
and governance hypotheses.

The core ledger explicitly refuses to infer:

- function from persistence;
- truth from external validation;
- improvement from novelty;
- progress from selection;
- empirical causality from a satisfiability witness;
- physical free energy from dimensionless accessibility margin;
- moral obligation from persistence;
- universality from cross-domain analogy;
- novelty from new notation.

## 11. Novelty status

The release adopts the conclusion of the repository's adversarial literature
audit.

Among the twelve claims examined in that audit:

- 7 were best classified as rediscoveries or elementary corollaries;
- 5 as sharpenings of known results;
- 0 as high-confidence new general theorems on the evidence then available.

Accordingly, the recommended framing is:

[
oxed{
	ext{primarily a synthesis / architecture}
+
	ext{some exact model-specific results}.
}
]

The main peer-review target is therefore the integrated architecture, its
interfaces, its exact separations, its empirical usefulness, and whether a
stronger antecedent already exists.

## 12. What remains open

Important open interfaces include:

- support → opportunity;
- retained response → specific physical organizational update;
- physical update → measured uptake/maintenance/search change;
- endogenous response cost;
- depletion and renewal of external gradients;
- turnover, forgetting, redundancy, and recoverable memory;
- stochastic generation and validation;
- mechanistic evolution of generator rules;
- cross-scale composition;
- empirical operationalization of distinguishability;
- operational definitions of capture and commons;
- architectural prior art.

These are part of the research programme rather than hidden assumptions.

## 13. How to peer review v16

Review the immutable `v16` tag and record the tag's commit SHA.

Recommended route:

1. `THEORY.md`
2. `DYNAMIC_OVERVIEW.md`
3. `FORMAL_THEORY_MAP.md`
4. `CLAIMS.md`
5. `formalization/README.md`
6. `PEER_REVIEW_PROMPT.md`
7. exact Lean sources cited for any claim under review
8. `verification/audits/`

A successful counterexample, stronger theorem, failed empirical interface, or
stronger prior-art identification is a useful review result.

## Release lineage

- **v12 — Sufficient Alignment and Collective Intelligence**
- **v13 — Open for peer-review**
- **v14 — Formal Core Closure**
- **v15 — Verification Closure**
- **v16 — Full Theory Peer-Review Release**

Earlier tags remain immutable historical objects. `v16` is the recommended
fixed object for review of the current full Evolution by Emergence theory.

## Licensing and source

The repository remains open access under its existing licensing terms. The
release tag contains the theory documents, Lean sources, paper packages,
audits, review protocol, release metadata, and reproducibility instructions
needed to inspect the theory as one fixed research object.


## Final preflight status

Before release:

- the targeted prior-art preflight found no equal-or-stronger full duplicate, while identifying generative RAF/SOR, open-ended-evolution opportunity creation, and co-evolving technological/search-space models as the strongest antecedents;
- the cold-reader semantic/navigation preflight reconstructed the theory from the repository alone and prompted clarification of persistence, historical-trace, recurrence, and local-envelope semantics;
- the canonical v17 Lean code checkpoint passed the full proof workflow and no-`sorryAx` audit;
- the release workflow is configured to tag only the exact `main` commit whose **Build & Deploy Site** workflow succeeds.

For broad review, use the immutable `v17` tag and record its commit SHA.

## Release lineage

- **v15 — Verification Closure**
- **v16 — Full Theory Peer-Review Release**
- **v17 — Recursive Organization Core**
