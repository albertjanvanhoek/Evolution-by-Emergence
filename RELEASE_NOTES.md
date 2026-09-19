# Evolution by Emergence v17 — Recursive Organization Core

`v17` is the fixed peer-review release of the recursive-organization formal core developed through PRs #56–#60.

The purpose of this release is not to claim a new universal law or priority over established mechanisms. It is to provide a **self-standing, machine-auditable, literature-positioned descriptive architecture** that can underpin the larger Evolution by Emergence corpus.

## 1. Canonical review object

Start with:

1. `THEORY_CORE_V17.md` — self-standing theory core;
2. `FORMAL_THEORY_ENDPOINT.md` — formal endpoint and review-readiness criteria;
3. `APPLICATION_MAPPINGS_V17.md` — worked cross-domain mappings and a partial non-mapping;
4. `FORMAL_THEORY_MAP.md` — exact prose-to-Lean traceability;
5. `CLAIMS.md` — claim ledger and non-claims;
6. `verification/audits/2026-09-19-recursive-emergence/` — theorem, adversarial, prior-art, and cold-reader audits;
7. `formalization/cumulative-accessibility/CumulativeAccessibility/EvolutionByEmergenceV17Core.lean` — canonical v17 theorem surface;
8. `PEER_REVIEW_PROMPT.md` — broad-review protocol.

## 2. Core descriptive architecture

The v17 core keeps the following distinctions explicit:

```text
possible
!= generated
!= realized
!= emergent
!= feasible
!= validated / selected
!= retained
!= operationally reusable
!= admitted to future search
!= recursively cumulative.
```

The main recursive motif is:

```text
existing operational organization
    -> generation / construction
    -> candidate configuration
    -> capacity realization
    -> compositional emergence
    -> resource feasibility
    -> external/domain validation or selection
    -> retention
    -> operational reuse
    -> changed downstream generability
    -> finite admission to local search
    -> later recursive successor.
```

Every arrow remains a process that can fail.

## 3. Corrected moving-envelope operational core

The first recursive master specialization used a globally finite `Capacity` type.

The later audit proved that a monotonically accumulating repertoire cannot sustain indefinitely many strict retained expansions inside one fixed finite global capacity universe.

The corrected v17 operational core therefore uses:

```text
possibly non-finite ambient Capacity
+ finite time-local candidate envelopes U_t
+ seed recursive-emergence event
+ monotone active retention
+ locally certified effective successor reproduction
    -> open-ended cumulative operational novelty.
```

With repertoire representation inside the local envelopes:

```text
open-ended cumulative operational novelty
    -> unbounded envelope cardinality over time.
```

This does not require an infinite search set at any single time.

## 4. Primitive promotion and endogenous accessibility

PR #59 strengthens the recursive route by separating:

```text
retained child
-> operational primitive promotion
-> essential contribution to later generability
-> finite admission
-> next-envelope representation
-> independent full filtering
-> actual recursive successor.
```

The essential-parent test holds the next-step generator fixed and asks whether the downstream candidate ceases to be generable when the promoted child is removed.

This establishes **essential contribution under the declared counterfactual**, not sole historical causation.

Primitive promotion alone does not imply another successful innovation.

## 5. Constructive generated-configuration bridge

`ConstructiveRecursiveEmergence.lean` adds an optional stronger interface:

```text
parents construct configuration c for child
AND
that same c realizes the child capacity emergently
AND
the same event passes feasibility, validation, and retention.
```

The stronger constructive event projects to the existing capacity-level recursive event.

This closes the earlier formal seam between:

```text
parents generate capacity phi
```

and

```text
some unrelated configuration realizes phi.
```

Applications that cannot justify configuration-level construction may continue to use the weaker capacity-level interface explicitly.

## 6. Active repertoire versus cumulative history

`ActiveHistory.lean` separates:

```text
Active_t
History_t.
```

`Active_t` contains capacities currently available for reuse.

`History_t` is a declared cumulative trace of capacities the application records as having occurred.

Lean proves a turnover witness in which:

```text
|Active_t| = 1 for every t,
Active is not monotone,
History is open-ended.
```

Thus v17 distinguishes:

- **open-ended cumulative operational novelty** — stronger; requires monotone active retention;
- **open-ended cumulative historical novelty** — weaker; permits operational loss and turnover.

Historical open-endedness is an accounting implication from recurring history-new events; it does not explain why those events continue.

## 7. Deterministic local successor reproduction

The v17 local effective emergence reproduction number is a deterministic count of actual full successors in the next finite local envelope.

Therefore:

```text
R_E^local >= 1
iff
at least one actual local recursive successor exists.
```

It is not automatically:

- an expected branching offspring count;
- a stochastic survival probability;
- a next-generation spectral radius;
- an epidemiological reproduction number.

Mechanism-factor ledgers remain separate and require explicit calibration to actual successors.

## 8. Literature position

The v17 audit explicitly treats the following as antecedents rather than EbE discoveries:

- Darwinian selection and inheritance;
- open-ended-evolution frameworks and finite-system limits;
- adjacent-possible triggering;
- changing phase-space / enablement theories;
- co-option and exaptation;
- modularity and evolvability;
- autocatalytic and generative RAF theory;
- Self-Other Reorganization;
- major evolutionary transitions;
- cumulative culture and cultural loss;
- recombinant technological evolution;
- co-evolving technological/cultural repertoires and search spaces;
- viability and reachability;
- formal component construction and reuse;
- resource-limited maintenance.

The targeted prior-art preflight found **no equal-or-stronger single framework containing the full v17 conjunction**, while identifying generative RAF/SOR, Soros–Stanley open-ended-evolution conditions, and Winters–Charbonneau as the strongest challenges.

That result is **not a priority proof**.

The defensible contribution under review is narrower:

> a machine-auditable cross-domain factorization of established mechanisms, with explicit theorem boundaries and countermodels preventing several common identifications.

## 9. Cold-reader preflight

A clean-room repository-only reconstruction successfully recovered the intended theory without the PR/conversation history.

That preflight led to clarification of:

- the domain of the persistence statement;
- the declared rather than self-validating nature of historical trace;
- the accounting character of the historical open-endedness theorem;
- the distinction between local admitted envelopes and all physically possible candidates.

The reviewer path now resolves without broken internal links.

## 10. What v17 does not claim

The formal core does not establish:

```text
novelty -> improvement
persistence -> function
validation -> truth
retention -> goodness
possibility -> realization
larger possibility space -> progress
self-maintenance -> automatic innovation
historical accumulation -> growing active repertoire
moving envelope -> strong ontology creation
machine proof -> empirical truth.
```

It also does not derive moral or political objectives.

Values and domain evidence specify goals. EbE can then analyze what organization must actually be generated, implemented, maintained, transmitted, and reused for a chosen outcome to become and remain real.

## 11. Machine verification

The canonical v17 Lean surface includes:

- relative compositional emergence;
- filtering and retained integration;
- recursive parent reuse;
- configuration-level constructive projection;
- essential-parent generated-access expansion;
- finite admission and moving local envelopes;
- deterministic local successor counting;
- fixed-finite saturation;
- operational and historical cumulative endpoints;
- non-vacuity witnesses;
- separation countermodels.

The repository's proof workflows build the formal-core targets and reject `sorryAx` on the advertised verification surface.

The release workflow creates `v17` only after the repository's **Build & Deploy Site** workflow succeeds on `main`, so the published tag identifies the tested release commit.

## 12. Broad review target

Reviewers are asked to attack:

1. formal validity;
2. semantic adequacy;
3. stronger prior art;
4. explanatory usefulness;
5. domain mapping;
6. empirical support;
7. normative inference.

A theorem defect, stronger antecedent, failed mapping, empirical counterexample, or successful narrowing is a useful review result.

Use the immutable `v17` tag and record its commit SHA.

## Release lineage

- **v15 — Verification Closure**
- **v16 — Full Theory Peer-Review Release**
- **v17 — Recursive Organization Core**
