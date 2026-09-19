# Recursive emergence theorem and assumption inventory

**Date:** 19 September 2026  
**Status:** Gate A audit for PR #60  
**Scope:** research stack #57-#59 as inherited by the v17 integration branch

This inventory is intentionally stricter than the prose theory. Its purpose is
to identify exactly which statements are definitions, checked implications,
witnesses, modelling interfaces, or empirical seams.

## Status labels

- **DEF** — definition only.
- **MC** — machine-checked implication from explicit premises.
- **CW** — concrete machine-checked witness / non-vacuity construction.
- **SEP** — machine-checked separation or countermodel.
- **MODEL** — modelling interface whose applicability is not derived by Lean.
- **EMP** — empirical/calibration question outside the current proof.
- **INT** — interpretation layered on top of the formal result.

## 1. Emergence layer

| Object/result | Status | Formal content | What it does not establish |
|---|---|---|---|
| `CapacityRelation` | DEF | A relation between configuration, context, and capacity. | A unique or objective ontology of capacities. |
| `EmergentUnder Proper Realizes config ctx phi` | DEF | Whole realizes `phi`; every declared proper subconfiguration fails to realize `phi`. | Historical novelty, usefulness, surprise, persistence, validation, strong metaphysical emergence. |
| minimal-realizer incomparability | MC | Two minimal realizers are incomparable under the declared proper-part relation. | That real systems have a unique decomposition or minimal realization. |
| decomposition-refinement result | MC | Emergence under a finer declared decomposition implies the corresponding coarser condition under stated refinement premises. | Decomposition independence. |
| historical/model novelty separation witnesses | SEP/CW | Compositional emergence can occur without historical novelty or model surprise. | A universal definition of novelty. |

**Audit note.** The emergence predicate is deliberately relative to `Proper`,
`Realizes`, and context. Reviewers should not read it as a proof of ontological
emergence.

## 2. Vocabulary layer

| Object/result | Status | Formal content | What it does not establish |
|---|---|---|---|
| `OperationallyNovel Active phi` | DEF | `phi` is not currently active. | That `phi` is historically new or outside the representational language. |
| `IntegrateOperationalCapacity` | DEF | Adds a realized primitive to an active repertoire. | Persistence or downstream generativity. |
| operational integration strictly expands active repertoire | MC | Adding an operationally novel primitive yields strict active-set expansion. | Any useful downstream effect. |
| representational vocabulary extension | DEF/MC | Old capacity type is explicitly embedded in a larger/new representation and strict extension is witnessed. | That evolution necessarily creates new mathematical types. |
| vocabulary integration needs downstream witness | SEP/MC | Primitive expansion alone does not entail new downstream realization; an explicit downstream witness suffices for strict generated-access expansion. | Automatic evolvability from vocabulary expansion. |

**Audit note.** The recursive open-ended theorem currently depends on
operational capacities within an ambient `Capacity` type. Strong
representational/type creation remains separate.

## 3. Emergence-to-retention bridge

| Object/result | Status | Formal content | What it does not establish |
|---|---|---|---|
| `RetainedIntegrationAt S m phi` | DEF | `phi` is absent at `m` and present at `m+1`. | Why it was retained. |
| `ResourceValidatedRetentionAt` | DEF | Retention plus resource feasibility and declared external validation. | Objective truth, fitness, or universal value. |
| `ResourceValidatedEmergentIntegrationAt` / event surface | DEF | Compositional emergence plus the declared resource/validation/retention filters. | That emergence causes the filters to pass. |
| emergent integration -> operational ratchet | MC | A full filtered retained event gives the advertised operational expansion. | Further innovation without an additional generative witness. |
| emergence alone does not force retention | SEP | A model can satisfy emergence without the retained-integration conclusion. | — |

**Audit note.** Resource feasibility, validation, and retention are independent
premises/interfaces. This layer is a conjunction architecture, not a causal law
that derives them from emergence.

## 4. Recursive parent-reuse layer

| Object/result | Status | Formal content | What it does not establish |
|---|---|---|---|
| `GeneratedUsingParent Available Generate parent child` | DEF | There exists a finite parent set containing the designated parent; all parents are available; the generator maps that set to the child. | That the parent is necessary rather than merely present. |
| `RecursiveEmergenceStepAt` | DEF | Retained parent + generation using that parent + full filtered emergent child event. | That such a successor must exist. |
| recursive step -> child new and retained | MC | The child satisfies next-step retained novelty under the event definition. | Long-run continuation. |
| recursive step + monotone retention -> strict repertoire expansion | MC | One event produces a strict retained-set expansion. | Infinite accumulation. |
| finite timed recursive chain | DEF/MC | Finite chains compose and previous products are legitimate later parent material under the stated conditions. | Infinite recursion by itself. |
| progressive `a -> b -> c` / natural-number witnesses | CW | The recursive predicate is jointly satisfiable and can be iterated in the constructed architecture. | Empirical realism or spontaneous mechanism. |

## 5. Recurrent recursion and open-ended retained novelty

| Object/result | Status | Formal content | What it does not establish |
|---|---|---|---|
| `RecurringRecursiveEmergence` | DEF | For arbitrarily late times, a full recursive-emergence step exists. | Why those events recur. |
| recurring recursive emergence + monotone retention -> `OpenEndedCumulativeNovelty` | MC | Arbitrarily many strict retained repertoire expansions occur. | Increasing complexity, fitness, function, or OEE under every published definition. |
| compatibility route through validated generative uptake | MC | Stronger recursive events instantiate the older uptake interface under envelope premises. | That the uptake interface is the unique interpretation. |

**Audit note.** This theorem is structurally close to its conclusion because
recurrence of full novelty events is assumed. Its value is compositional
correctness, not a causal derivation of recurrence.

## 6. Self-maintenance leverage

| Object/result | Status | Formal content | What it does not establish |
|---|---|---|---|
| strict slack increase + reinvestment -> response-budget gain | MC | Under the declared slack/budget equations, more slack increases the declared budget. | Generation, validation, or retention. |
| strict slack gain -> newly tolerable burden interval | MC | A strict gain opens a nonempty burden interval in the same ledger. | Greater actual persistence in an empirical system. |
| non-worsening target costs + slack nondecrease -> preserve slack-funded targets | MC | Previously feasible declared targets stay feasible. | Actual search or innovation. |
| crossing witness -> strict slack-funded access expansion | MC | One target crossing gives strict feasible-set expansion. | A recursive-emergence successor. |
| `RecursiveEmergenceSuccessorWithin` + seed -> recurrent recursion | MC | If every realized event is guaranteed a child-reusing successor within the declared lag, recurrence follows. | That leverage causes the successor guarantee. |

**Audit note.** The leverage-to-reproduction mapping is intentionally open.

## 7. Finite deterministic emergence reproduction

| Object/result | Status | Formal content | What it does not establish |
|---|---|---|---|
| immediate successor finset | DEF | Enumerates full recursive-emergence successors in a globally finite declared `Capacity`. | A suitable global state space for open-ended accumulation. |
| `EffectiveEmergenceSuccessorCount` / number | DEF | Cardinality of the actual immediate successor set (and real cast). | An expectation, stochastic branching ratio, or empirical rate. |
| `R_E >= 1` iff immediate successor exists | MC | Exact deterministic counting equivalence. | Positive survival probability. |
| `R_E > 1` -> at least two branches | MC | More than one counted successor yields two distinct successors. | Branch independence or long-run diversification. |
| mechanism ledger `window * opportunityRate * pGenerate * pResource * pValidate * pRetain` | DEF/MODEL | A factor ledger for a declared application. | Equality to actual successor count. |
| `ReproductionLedgerCertifiedLowerBound` | MODEL | Explicit certification seam: ledger is a lower bound on actual deterministic successor number. | Automatic empirical calibration. |
| ledger >= 1 + certified lower bound -> actual successor | MC | Once calibration is assumed, the deterministic threshold follows. | That the calibration is true. |

## 8. Finite-global no-go

| Object/result | Status | Formal content | What it does not establish |
|---|---|---|---|
| finite generative saturation results | MC | A monotonically retained repertoire inside a fixed finite universe has a finite number of strict expansions and eventually cannot keep strictly expanding. | A physical finite-state theorem without a representation premise. |
| `finiteCapacity_uniformCriticalEmergenceReproduction_impossible` | MC | Fixed globally finite `Capacity` + seed + monotone retention + indefinitely uniform deterministic critical reproduction contradict finite saturation. | A deep impossibility of OEE in all finite physical systems. |
| old finite `EvolutionByEmergenceCoreCertificate` impossible | MC | The PR57 global finite master certificate is uninhabitable under its combined indefinite premises. | That its individual implications were false. |

**Audit note.** The underlying counting idea is elementary. The substantive
repository value is that it detects and repairs a bad global finiteness choice
in the proposed master surface.

## 9. Moving local envelopes

| Object/result | Status | Formal content | What it does not establish |
|---|---|---|---|
| `LocalRecursiveEmergenceSuccessors U ...` | DEF | Counts full successors only in finite `U_(m+1)`; ambient `Capacity` need not be finite. | Why `U` changes. |
| local successor count / local `R_E` | DEF | Finite local count and real cast. | Stochastic expectation or universal reproduction metric. |
| local `R_E >= 1` iff a local full successor exists | MC | Exact local counting equivalence. | Empirical criticality. |
| `UniformLocalCriticalEmergenceReproduction` | DEF | Every realized event has at least one full local successor. | A mechanism producing that condition. |
| seed + uniform local criticality + retention -> OECN | MC | Corrected recursive closure without global `Fintype Capacity`. | That real systems meet uniform criticality. |
| plus `S_t subseteq U_t` -> `UnboundedEnvelopeCapacity U` | MC | A represented monotonically accumulated repertoire forces local envelope cardinalities to be unbounded over time. | An ever-growing physical phase-space dimension or ontology. |
| uniformly bounded envelope rules out indefinite uniform local criticality | MC | Under seed/retention/representation premises, a uniform cardinality ceiling is incompatible with the corrected indefinite process. | That every notion of OEE needs this exact representation. |
| locally certified master certificate | DEF/MC | Preserves ledger calibration seam while avoiding global capacity finiteness. | Empirical calibration. |
| progressive local certificate | CW | Corrected master certificate is inhabited. | Naturalness or empirical likelihood. |

## 10. Endogenous envelope promotion

| Object/result | Status | Formal content | What it does not establish |
|---|---|---|---|
| recursive event -> operational promotion | MC | Child moves from inactive/novel at time `m` to retained reusable material at `m+1`; with retention, previous active material remains. | Downstream generative effect. |
| `GeneratedEssentiallyUsingParent` | DEF | Candidate is generated using parent and is not generable from the same available repertoire with that parent removed. | Global causal necessity across all histories or generators. |
| `GenerativelyConsequentialPromotionAt` | DEF | Promoted child is essential under the full next-step repertoire; candidate was not generable pre-promotion; same `H_(m+1)` is used in both comparisons. | Absence of every possible simultaneous confounder in a real system. |
| consequential promotion -> strict generated-access expansion | MC | Removing the promoted child strictly reduces the declared generated-access relation under fixed next-step generator. | That a downstream candidate is searched, realized, or retained. |
| `PromotionAdmissionPolicy` | DEF/MODEL | For each time and promoted child, selects a finite set of candidates admitted to local search. | A derived theory of attention, compression, resource allocation, or sampling. |
| `PromotionResponsiveEnvelope` | MODEL | Admitted consequential candidates are represented in `U_(m+1)`. | Existence of consequential candidates or correctness of admission. |
| `PromotionDrivenFilteredSuccessorAt` | DEF | Consequential generation + old-envelope exclusion + full next-step filtered emergent event. | That promotion itself makes filtering succeed. |
| promotion-driven filtered successor -> local successor | MC | The stronger causal package instantiates PR58's full local successor predicate. | Automatic continuation. |
| `UniformPromotionDrivenContinuation` | DEF/MODEL | Every realized recursive event has some promotion-driven filtered successor. | A derivation of indefinite continuation from lower-level physics. |
| uniform promotion continuation + responsive envelope -> uniform local criticality | MC | Stronger mechanism-level condition implies the PR58 local threshold. | That the stronger condition is empirically common. |
| seed + retention + responsive envelope + uniform promotion continuation -> OECN / unbounded envelope | MC | Full PR59 sufficient route to corrected open-ended retained novelty. | Universal OEE. |
| one-shot promotion without downstream consequential candidate | SEP | Operational promotion alone does not imply new generated access. | — |
| progressive promotion witnesses | CW | Full PR59 route is jointly satisfiable. | Empirical realism. |

## 11. The strongest current conditional architecture

The strongest current deductive route can be written as:

```text
seed recursive-emergence event
+ monotone retention
+ finite local candidate envelopes
+ uniform promotion-responsive, promotion-driven filtered continuation
    -> uniform local effective successor reproduction
    -> open-ended cumulative retained novelty

and with S_t subseteq U_t
    -> unbounded envelope capacity.
```

The lower-level expansion step within one event is:

```text
retained child
    -> operational primitive
    + essential use in later generation under fixed next-step generator
    + no pre-promotion generability
    -> strict generated-access expansion

then
finite admission
    + next-envelope representation
    + independent emergence/resource/validation/retention success
    -> actual local recursive successor.
```

## 12. Load-bearing assumptions

The following premises are scientifically load-bearing and should be displayed,
not buried:

1. **Declared decomposition and realization semantics.**
   Emergence is relative to these choices.
2. **Monotone retention.**
   The retained repertoire never loses an element in the open-ended accumulation
   theorem.
3. **Full-event recurrence/continuation.**
   Uniform local criticality or promotion-driven continuation is a strong
   assumption about every realized event.
4. **External criterion.**
   Validation is uninterpreted and application specific.
5. **Response resource model.**
   Cost and budget are declared interfaces.
6. **Finite local admission.**
   The theory does not derive which consequential possibilities receive
   attention/search resources.
7. **Envelope responsiveness.**
   Admitted consequential candidates are assumed to enter the next local
   horizon.
8. **Repertoire representation.**
   The unbounded-envelope conclusion requires `S_t subseteq U_t`.
9. **Ledger calibration.**
   Mechanism-factor products do not become actual successor counts without a
   certified mapping.
10. **One ambient capacity type in the corrected recursive theorem.**
    Strong ontology/type creation is not part of the current closure.

## 13. Circularity stress test

The strongest potential criticism is that
`UniformPromotionDrivenContinuation` assumes a fully filtered successor after
every realized event and therefore contains most of the long-run continuation
content.

That criticism is partly correct and should be conceded precisely:

- PR59 does **not** derive indefinite continuation from primitive promotion
  alone.
- It decomposes a sufficient continuation condition into more interpretable
  event-level parts and proves that the stronger condition implies the PR58
  local reproduction threshold.
- The scientific burden moves to explaining/calibrating the frequency of
  consequential promotions, admission, and filter success.

The nontrivial formal contributions around that assumption are:

- promotion is separated from downstream expansion;
- essential-parent contribution is separated from mere parent membership;
- generator change is held fixed in the attribution test;
- generated possibility is separated from finite local admission;
- admission is separated from realized filtered success;
- local continuation is separated from global finite-space saturation;
- the corrected certificate is explicitly inhabited.

Reviewers should judge whether this decomposition yields enough explanatory or
measurement value to justify the architecture.

## 14. Gate A outcome

**Gate A is provisionally passed for internal integration work, not for release.**

No contradiction was found between the advertised current conclusion and the
formal theorem structure. However, the inventory identifies three points that
must remain prominent in v17:

1. the open-ended endpoint is **retained set expansion**, not universal
   complexity growth;
2. uniform continuation is an explicit strong premise, not derived from
   self-maintenance or promotion alone;
3. the ambient-type/moving-envelope construction is weaker than strong
   representational vocabulary creation.

Gate B (semantic audit) and Gate C (literature/priority audit) remain open.
