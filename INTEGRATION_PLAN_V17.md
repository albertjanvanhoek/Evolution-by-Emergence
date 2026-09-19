# v17 recursive-emergence integration plan

**Date:** 19 September 2026  
**Status:** integration/review plan, not a merge decision  
**Source stack:** PR #57 -> PR #58 -> PR #59  
**Frozen starting head:** `16812e8f306c783efc96c2e61c289343e3326e6c`

## Purpose

The formal target for this integration is defined in [`FORMAL_THEORY_ENDPOINT.md`](FORMAL_THEORY_ENDPOINT.md).

The endpoint is not a novelty claim. It is a self-standing, machine-auditable,
literature-positioned descriptive core that can serve as the load-bearing
foundation for the essays, applications, and implications elsewhere in the
repository.

The #57-#59 research sequence materially changes the formal core of Evolution by
Emergence (EbE). It should therefore not be integrated by simply merging a stack
of research PRs into `main`.

The integration task has four separate questions:

1. **Correctness:** what is actually machine checked?
2. **Semantics:** what does each formal object mean, and what does it not mean?
3. **Prior art:** which ingredients and mechanisms are already established in
   adjacent literatures?
4. **Contribution:** after those antecedents are acknowledged, what useful
   theorem, architecture, distinction, or reviewable formal object remains?

Only after those questions are answered should the repository choose a
canonical v17 theory surface.

The working rule is:

> **Do not preserve the history of discovery as the architecture of the final
> theory. Preserve the valid results, but refactor the presentation around the
> strongest corrected statement.**

## Current research lineage

### PR #56 — emergent capacity and vocabulary expansion

PR #56 introduced the distinction between:

- compositional emergence;
- operational vocabulary expansion;
- representational vocabulary expansion.

It is superseded by PR #57 and should remain historical rather than be merged
independently.

### PR #57 — persistence bridge and recursive emergence

PR #57 adds the main event-level chain:

```text
compositional emergence
    + resource feasibility
    + external validation
    + next-step retention
    -> retained operational integration
    -> reusable parent material
    -> recursive emergence
```

It then adds deterministic emergence reproduction and a proposed master
certificate.

Important correction discovered later: the deterministic successor count in
PR #57 assumes a globally finite `Capacity` type. Combined with monotone
retention, a seed, and indefinitely uniform critical reproduction, that cannot
be the global state space of an open-ended process.

The implication in PR #57 is logically valid; the globally finite master
certificate is not a suitable canonical open-ended theory.

### PR #58 — finite local envelopes and corrected recursive closure

PR #58 proves both sides of the correction:

```text
fixed globally finite effective capacity space
    + seed
    + monotone retention
    + uniform critical emergence reproduction
    -> contradiction with finite saturation
```

and

```text
possibly infinite Capacity
    + finite time-local envelopes U_t
    + seed
    + locally certified R_E >= 1
    + monotone retention
    -> open-ended cumulative retained novelty
```

with

```text
S_t subseteq U_t
    -> unbounded envelope capacity.
```

It also provides an explicit progressive witness, so the corrected certificate
is non-vacuous.

### PR #59 — endogenous envelope movement through primitive promotion

PR #59 asks the next causal question:

> Why should the next finite envelope contain a candidate that the earlier
> envelope did not?

The final version does **not** equate realization of a child with automatic
envelope expansion. Instead it separates:

1. retention of a child as a new operational primitive;
2. essential use of that primitive in downstream generation;
3. strict expansion of generated access attributable to that primitive while
   holding the next-step generator fixed;
4. finite admission/compression of newly enabled possibilities;
5. representation in the next local envelope;
6. independent emergence/resource/validation/retention filtering;
7. actual local recursive successor.

This is the strongest current causal decomposition.

## Integration gates

PR60 is not ready for merge merely because CI is green. The following gates must
be satisfied in order.

### Gate A — theorem inventory and dependency audit

Produce one inventory dividing every advertised result into:

- definition;
- machine-checked implication;
- concrete witness / non-vacuity result;
- separation countermodel;
- modelling interface;
- empirical calibration seam;
- interpretation.

The inventory must identify assumptions that are stronger than their prose
description, especially:

- monotone retention;
- finite local envelopes;
- repertoire representation `S_t subseteq U_t`;
- external validation;
- promotion admission;
- uniform continuation / critical reproduction;
- ledger calibration to actual successors.

**Stop condition:** any advertised conclusion is stronger than the theorem
surface actually supports.

### Gate B — semantic audit

The final theory must preserve the following distinctions:

- compositional emergence != historical novelty;
- operational promotion != representational/ontological vocabulary creation;
- candidate envelope != full possibility space;
- new generability != realized innovation;
- generation != validation;
- validation != truth;
- retention != improvement;
- open-ended retained novelty != increasing complexity;
- local deterministic `R_E >= 1` != stochastic survival probability;
- unbounded envelope capacity != infinite physical activity in finite time.

A particularly important limitation is that the moving-envelope model can use an
infinite ambient `Capacity` type. It therefore formalizes an unbounded sequence
of **effective distinguishable capacities within one ambient type**. It does not
yet machine-check the stronger claim that evolution creates genuinely new
representational types or an unprestatable ontology.

### Gate C — literature audit

Compare the corrected formal stack with at least these literatures:

1. open-ended evolution (OEE);
2. adjacent possible / innovation-triggering models;
3. changing phase-space / enablement accounts;
4. evolutionary novelty and co-option/exaptation;
5. evolvability, modularity, and reusable building blocks;
6. autocatalytic / RAF systems and hierarchical autocatalysis;
7. major evolutionary transitions;
8. cumulative culture and ratchet effects;
9. technological recombinant/combinatorial evolution;
10. branching / reproduction-number mathematics where relevant.

For each comparison, record:

- what is already known;
- the closest conceptual or formal antecedent;
- what EbE adds, if anything;
- whether the residue is a new theorem, a sharpening, a synthesis, an
  interpretation, or merely new terminology.

**Stop condition:** if a close antecedent already contains the same architecture
at equal or greater precision, narrow the contribution claim before proceeding.

### Gate D — adversarial formal review

Attack, at minimum:

- whether `GeneratedEssentiallyUsingParent` establishes the intended local
  attribution and no more;
- whether simultaneous repertoire changes can still confound the attribution;
- whether the finite admission policy hides the substantive mechanism instead
  of isolating it;
- whether uniform continuation simply repackages open-endedness;
- whether the progressive witness is too construction-specific to establish
  anything beyond consistency;
- whether the local `R_E` object adds explanatory value beyond successor
  existence;
- whether the finite-global no-go is substantive or merely a counting
  corollary;
- whether monotone retention is the right abstraction for domains with loss,
  extinction, forgetting, turnover, and substitution.

The result should be a list of theorem-level issues versus interpretation-level
issues.

### Gate E — canonical Lean refactor

Only after A-D:

1. keep `EmergentCapacity.lean` as the minimal emergence layer;
2. keep `VocabularyEmergence.lean` with explicit operational versus
   representational distinctions;
3. keep `EmergencePersistenceBridge.lean` as the filter/retention bridge;
4. keep `RecursiveEmergence.lean` as parent-reuse recursion;
5. keep the globally finite successor-count result as a finite specialization
   and saturation diagnostic;
6. make the moving-envelope/local reproduction formulation the canonical
   open-ended layer;
7. make primitive-promotion/envelope movement an explicit sufficient mechanism
   for satisfying local continuation;
8. move any shared definitions downward so the import graph follows the
   conceptual dependency graph;
9. replace or rename the globally finite `EvolutionByEmergenceCoreCertificate`
   so it is not presented as the open-ended master theory;
10. expose one corrected canonical master surface with no hidden global
    finiteness assumption.

Target dependency direction:

```text
EmergentCapacity
    -> VocabularyEmergence
    -> EmergencePersistenceBridge
    -> RecursiveEmergence
    -> LocalEmergenceReproduction
    -> EndogenousEnvelopePromotion
    -> corrected EvolutionByEmergenceCore
```

The exact module order can change if needed to avoid circular imports; the
scientific direction should not.

### Gate F — repository narrative rewrite

After the formal surface is stable, update together:

- `README.md`;
- `THEORY.md`;
- `DYNAMIC_OVERVIEW.md`;
- `FORMAL_THEORY_MAP.md`;
- `CLAIMS.md`;
- `RESEARCH_GUIDE.md`;
- `formalization/README.md`;
- `formalization/cumulative-accessibility/README.md`;
- `PEER_REVIEW_PROMPT.md`;
- `RELEASE_NOTES.md`.

The existing Dynamic Vortex should be retained but repositioned.

Its role is principally:

```text
maintenance / uptake / slack
    -> feasible response and search
```

The new recursive-emergence stack supplies:

```text
realized retained response
    -> reusable primitive
    -> changed generability
    -> next candidate horizon
    -> recursive retained novelty.
```

The combined architecture is stronger than either alone, but the coupling
between them remains conditional unless separately derived.

### Gate G — fixed release object

If the preceding gates survive review, create a new immutable release rather
than rewriting v16.

Working release description:

> **v17 — Recursive Emergence Review Release**

The title should remain provisional until the novelty/literature audit is
complete.

## Provisional central theorem architecture

The current corrected mathematical spine is:

```text
one seed recursive-emergence event
    + monotone retention
    + finite local candidate envelopes
    + uniform locally certified effective successor reproduction
    -> open-ended cumulative retained novelty

plus S_t subseteq U_t
    -> unbounded effective envelope capacity.
```

PR #59 gives one stronger sufficient mechanism for the local-continuation
premise:

```text
retained child
    -> operational primitive
    -> essential downstream generative contribution
    -> finite admission
    -> next-envelope representation
    -> full filtered successor
    -> local R_E >= 1.
```

This should be presented as a **conditional causal architecture**, not a theorem
that persistence alone produces indefinite innovation.

## Provisional contribution claim

Until the dedicated literature audit is complete, the strongest safe framing is:

> EbE provides a machine-checked decomposition of one route from retained
> emergent organization to recursively cumulative novelty, while explicitly
> separating candidate generation, operational promotion, causal parent reuse,
> finite search admission, resource feasibility, validation, retention,
> deterministic successor reproduction, finite-space saturation, and
> moving-envelope open-endedness.

This is a **candidate synthesis/architecture claim**, not yet a priority claim.

## Explicit non-claims for v17

The integration must not claim that the current formalization proves:

- a universal law of evolution;
- that all evolution is open-ended;
- that novelty necessarily improves fitness, function, or complexity;
- that every retained primitive expands downstream generability;
- that every generatively consequential primitive is admitted to local search;
- that every admitted candidate survives filtering;
- that self-maintenance automatically makes local reproduction critical;
- that a ledger value above one equals actual reproduction without calibration;
- that deterministic local `R_E >= 1` is a stochastic branching theorem;
- that real systems retain monotonically forever;
- that the effective envelope is the full physical possibility space;
- that an infinite ambient capacity type is physically instantiated at once;
- that the model creates new ontological types;
- that external validation is objective truth;
- or that the individual mechanisms are novel merely because they are combined
  in EbE notation.

## Merge criterion

PR60 should be considered merge-ready only when a reviewer can answer, from the
repository alone:

1. What exactly is proved?
2. Which assumptions make the proof work?
3. Which assumptions are empirical/model choices?
4. Which conclusions are only interpretations?
5. What are the closest antecedents?
6. What is the narrow contribution after those antecedents are acknowledged?
7. What would falsify or substantially weaken that contribution?
8. Which theorem/countermodel files should an independent reviewer run?

A green CI surface is necessary but not sufficient.
