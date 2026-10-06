# Predictions

This document states what the framework predicts about collectives of intelligences, in a form that can be checked and can be wrong. It has two parts:

- **Part I — descriptive predictions.** What the architecture of persisting collectives of fallible intelligences will look like, and how sealed collectives fail.
- **Part II — SCAP as a conditional design result.** What agents who want to persist together, and understand the premises, would rationally build, and the four conditions without which it fails.

Each prediction names the machine-checked result it rests on, what observation would count against it, and where it can be tested. The theorems are conditional implications under the premises stated in their Lean files; the predictions are the empirical claims that real collectives satisfy those premises often enough for the pattern to show. A failed prediction is a useful result: it locates which premise does not hold in which domain.

## Starting point

The framework is one model of learning, read as a network ([CORE.md](CORE.md)). Applied to intelligences:

1. **Intelligences are non-certain.** Incompatible views cannot all be right, and no view can certify itself from the inside, so the feedback that keeps a model in step comes from outside, through its connections (`learner_in_step`, `shared_reality_when_connected`).
2. **They exist through their connections** and pay for their upkeep from the same ledger.

In a world that changes, a configuration whose fit is fixed in advance runs out of reserve in some possible future, while one that follows reliable feedback persists (`sealed_configuration_does_not_persist`, `listening_configuration_persists`). Where members depend reciprocally on one another, reciprocity adds a social route that makes sealing costly sooner (`sealing_is_fatal_after_buffer`). Nothing guarantees persistence: sealed configurations can last while the world stays within what they hold, or while they can pass their costs to others, and the vortex can stop.

The predictions are therefore of the form **"what persists will have this architecture; what lacks it will be over-represented among failures"**, not "every collective converges to it".

---

## Part I — Descriptive predictions

### P1. No exempt members

**Prediction.** In persisting collectives, every member can both send and receive correction. Members or offices that are permanently exempt from correction are rare among long-lived collectives and common among those that fragmented or collapsed.

**Rests on.** `sc_every_model_sends`, `sc_every_model_receives`, `sealing_breaks`, `isolation_breaks`, `sealed_configuration_does_not_persist`.

**Would count against it.** Long-lived collectives (decades, under changing conditions) in which some member or office is structurally unanswerable and cannot pass the cost of its errors to others (see E1 for the exception).

### P2. Restrictions come with detours

**Prediction.** Persisting collectives restrict and exclude, but their exclusions keep a route for correction to arrive another way: appeal, review, re-admission, an alternative channel. Exclusions without any detour precede fragmentation.

**Rests on.** `correctable_after_iff_legitimate`, `exclusion_with_detour_legitimate`.

**Would count against it.** Persisting collectives whose exclusions are routinely final and unreviewable, with no alternative correction route, and no subsequent loss of error detection.

### P3. Nested structure with correctable interfaces

**Prediction.** As collectives grow, they become groups of groups. They persist when the interfaces between levels carry correction both ways; absorbing a sub-group so that its correction cannot leave, or cannot enter, precedes failure at that boundary.

**Rests on.** `composite_correctable`, `built_correctable`, `interface_necessary`, `sealed_outward_breaks`, `sealed_inward_breaks`.

**Would count against it.** Large persisting collectives that are flat, or nested ones whose level boundaries are one-way, without loss of correctability.

### P4. Sparse links and emerging hierarchy

**Prediction.** All-to-all connection stops being affordable as membership grows; persisting collectives trade latency for upkeep, moving toward sparse, ring- or tree-like correction structures as they grow.

**Rests on.** `flat_ceiling`, `latency_upkeep_frontier`, `ring_self_financing`, `correctable_population_ceiling`.

**Would count against it.** Collectives that keep full pairwise correction links at large size with positive per-link upkeep and no external subsidy.

### P5. Independent checks, protected diversity — and the shared-layer blind spot

**Prediction.** Persisting collectives keep several independent checks on what matters and protect members whose views are not determined by a common source. **Collectives whose members all rely on the same representation layer — for example the same AI model — will miss exactly the errors that layer is blind to, however careful each member is.** Independent members are pivotal at those blind spots; losing the last one seals the error.

**Rests on.** `hub_determined_network_inherits_blind_spot`, `independent_node_pivotal_at_hub_blind_spot`, `backup_becomes_pivotal`, `majority3_redundancy_gain`.

**Would count against it.** Collectives converging on one shared AI layer that detect errors on that layer's blind spots at the same rate as collectives with independent sources.

### P6. Repair mechanisms

**Prediction.** Persisting collectives have ways to repair broken links — reconciliation, re-engagement, forgiveness, re-admission. Without repair, splits become permanent; with bounded repair, they become delays.

**Rests on.** `no_repair_split_permanent`, `repair_bounds_delay`, `forgiveness_turns_split_into_delay`.

**Would count against it.** Long-lived collectives under recurring conflict with no repair mechanism and no permanent fragmentation.

### P7. Members who stop answering are dropped after a delay

**Prediction.** Where members depend reciprocally on each other, a member that stops answering correction loses its links after a characteristic delay set by its buffer, not immediately and not never. The delay grows with the buffer (reserves, reputation, accumulated goodwill).

**Rests on.** `sealing_is_fatal_after_buffer`, `persistence_requires_correction_within`, `buffer_seals_dependence`; where members can find new partners, `switching_defection_pays_iff` and `reputation_ends_serial_defection`: dropping a member works only if news of it reaches its next partners.

**Would count against it.** Reciprocally dependent members that stop answering and keep their links indefinitely without any external buffer.

### P8. Balance between generating and validating

**Prediction.** Persisting collectives balance producing new ideas with checking them; collectives that maximize generation alone, or validation alone, improve more slowly. The best balance shifts with what the collective has already built.

**Rests on.** `more_search_can_reduce_velocity`, the state-dependent allocation results.

**Would count against it.** Collectives where pure generation (or pure validation) yields faster retained improvement than a balance.

### P9. Shared knowledge is kept when reuse pays for it

**Prediction.** Persisting collectives retain shared standards, tools and vocabularies when they are reused often enough to cover their upkeep, and let them lapse otherwise.

**Rests on.** `retainedReuseCost_lt_inlineCost_iff`, `candidate_set_exceeding_budget_cannot_all_be_retained`.

**Would count against it.** Systematic retention of costly shared structures that are rarely reused, without subsidy.

### P10. Transfers decide who survives, creation decides how much

**Prediction.** Redistributing resources between members changes which members can sustain themselves, but not the collective's total capacity; only creation (more capture, less upkeep) enlarges it. A transfer can break a member while the collective's total is unchanged.

**Rests on.** `internallyViable_iff_exists_viable_transfer`, `transfer_breaks_part_with_whole_unchanged`.

**Would count against it.** Pure transfers that change a collective's total capacity in the model's own accounting (this would indicate a mis-specified ledger rather than a failed theorem).

### E1. The exception: sealed persistence

**Prediction.** Sealed agents and collectives — monopolies, coercive regimes, parasitic arrangements — *can* persist without answering correction, but only while the world stays within what they already hold, or while they can pass the cost of their errors to others. They live off their reserve and fail abruptly when the world moves past them, the reserve runs out, or partners they depend on can leave.

**Rests on.** `sealed_configuration_does_not_persist` (sealing fails once the world moves outside what the configuration fits), `stable_world_favours_sealing` and `listening_pays_iff` (while the world holds still, listening only costs; it pays once the world's moves outweigh its cost), `reciprocity_is_load_bearing` (without dependence on partners, sealing is not punished socially), `sealing_is_fatal_after_buffer`, `buffer_seals_dependence`.

**Would count against it.** Sealed systems that persist indefinitely in a changing world while bearing the cost of their own errors.

---

## Part II — SCAP as a conditional design result

### D1. The design claim

**Claim.** If agents share the aim of persisting together and understand the premises, the rational response is to maintain the conditions that remove the exception E1: keep every member, including the powerful, dependent on answering. **No asymmetry without accountability.** Those conditions are SCAP:

- **Connected** — no exempt nodes;
- **Faithful** — correction is not distorted in transit;
- **Evidence-open** — records follow evidence;
- **Repairable** — splits become delays;
- **Affordable** — correction pays its own upkeep.

**Rests on.** `scap_persistent_correctability` (the five conditions together give persistent correctability), `listening_configuration_persists`, `sealed_configuration_does_not_persist`, `reciprocity_is_load_bearing`, `commons_responsive_correctable`.

**Status.** This is a conditional design result, not an unconditional prediction: it says what agents with this aim and understanding would build, not that every collective will build it.

### The four conditions without which D1 fails

#### C1. SCAP must itself stay correctable

If every agent aligns on one shared framework, that framework becomes the shared layer, and its blind spots propagate to everyone (`hub_determined_network_inherits_blind_spot`). A procedural rule that cannot be challenged locks in its errors (`sealed_rule_fixes_error`); self-claims receive no exemption (`self_model_not_guaranteed`). SCAP works as an alignment only while it is held as the room holds every view: live, challengeable, revisable. **A SCAP that cannot be questioned predicts its own failure.**

#### C2. Understanding is not enforcement

Even when everyone understands the premises, an individual can gain by capturing for as long as its buffer lasts (`buffer_seals_dependence`), and the more members share a commons, the less each one's own share of the damage restrains it (`tragedy_of_the_commons`, `enough_takers_make_defection_pay`). Shared understanding makes the cooperative equilibrium reachable; institutions that restore reciprocity — appeal, separation of powers, the ability to leave, independent checks — make it stable.

#### C3. Declared is not operational

A constitution can declare every right while nothing can execute (`paper_constitution`); a challenge can be heard and never answered (`heard_but_unanswerable`). Capturers can adopt SCAP's language while keeping every route sealed. Behavioural compliance cannot certify alignment unless the observation discriminates (`compliance_cannot_certify`). SCAP is measured by operation — are challenges answered, within what time, at what cost — not by what is written.

#### C4. Correctable is not sustainable

SCAP keeps correction working; it does not limit what members take from the commons they share. A member can take up to its interest, its own creation plus what the commons regenerates, and the commons stays level (`living_off_interest`). A member that takes more eats the principal, and a depleted commons regenerates nothing (`capture_collapses_commons`); the more specialized the collective, the more members fail after the collapse (`specialists_fail_after_collapse`). Affordable covers the upkeep of correction; living off the interest covers the upkeep of everything else. **A collective can stay correctable and still spend its ground.**

### Predictions from Part II

- **D-P1.** Collectives whose members share the premises and maintain operational SCAP conditions show less capture and persist longer than otherwise comparable collectives that do not.
- **D-P2.** Collectives that adopt SCAP as unquestionable doctrine lose the advantage of D-P1 on the blind spots of their own doctrine (C1).
- **D-P3.** Collectives with SCAP in declaration only show capture rates like collectives without it (C3).
- **D-P4.** Without enforcement that restores reciprocity, shared understanding alone delays capture but does not prevent it (C2), and the more members share a commons, the more often it is captured; enforcement works when the expected sanction, the sanction times the rate at which capture is detected, is at least the windfall (`detected_sanction_deters`).
- **D-P5.** Among collectives that maintain operational SCAP, those whose members together take more from a shared, self-regenerating commons than they create plus what it regenerates run it down and lose members that depend on it, at a pace set by the stock rather than by how correctable they are; those that live off the interest do not (C4).

**Would count against Part II.** Shared, operational, correctable SCAP conditions showing no effect on capture or persistence; or unquestionable SCAP performing as well as correctable SCAP on its own blind spots.

---

## Where this can be tested

1. **Simulated collectives of AI agents.** AI agents are themselves non-certain intelligences, and the setting is cheap and controllable. Vary connectivity, a shared model layer, repair, reciprocity and buffers; plant errors and include agents that attempt capture; measure detection rate, time to detection, capture incidence and persistence. Part II adds conditions: agents given the SCAP premises versus not, SCAP as revisable versus as doctrine, and SCAP declared versus enforced.
2. **Open-source projects and wiki communities.** Public data on issue responsiveness, appeal routes, maintainer turnover, forks (splits) and re-merges (repair), and project survival.
3. **Institutional histories.** Longevity against the presence of appeal, review, repair and independent-check mechanisms, and the timing of collapse of sealed regimes against measures of their buffer.

## Relation to existing evidence

The framework was developed from a model of learning in neural networks, the room and substrate dependence. Many of its parts restate or sit next to existing results ([CORE.md, Related work](CORE.md#related-work)), so a prediction counts as support for this framework only where it goes beyond what those theories already predict. Some predictions meet independent empirical work that they can be tested against. The clearest is Elinor Ostrom's design principles for long-lived commons — monitoring, accessible conflict resolution, members' say in the rules, nested enterprises — which resemble P1–P3 and P6, and her congruence between what members take from a commons and what they provide to it, which resembles the window (C4, D-P5). Agreement there would be independent support; the predictions that go beyond it are the shared-layer blind spot (P5), the buffer timing of sealing (P7, E1), transfer versus creation (P10), and the reflexive conditions on SCAP itself (C1–C3).

## How to test these without fooling ourselves

The predictions have the form "what persists has this architecture", which makes them easy to confirm by accident. Before any test:

- **Fix the terms in advance.** Say what counts as a member, an exempt member, a correction route, a repair, a buffer and persistence, and over what horizon, before looking at which collectives lasted.
- **Count the failures, not only the survivors.** Sample collectives when they start, or match long-lived and failed ones on age, size and setting; otherwise survivorship produces the pattern by itself.
- **Bound the exception.** E1 lets a sealed collective last while the world holds still or while it passes its costs on. Measure the stability of its setting and its cost-shifting independently, in advance; a sealed collective that lasts without either counts against P1 and E1, and may not be explained away afterwards.
- **Start with the cheapest sharp test.** P5, the shared-layer blind spot, can be tested now in simulated collectives of AI agents: plant errors where a shared model is blind and compare detection with collectives that have independent sources.
- **Compare with the neighbours.** For each prediction, say which existing theory predicts the same; the ones none of them predict are the test of this framework.

## What this document does not claim

- That any particular collective satisfies the premises, or that every collective converges to the predicted architecture.
- That persistence is good, or that the design claim is morally obligatory; Part II is conditional on the aim of persisting together.
- That the predictions have been tested. They are stated so that they can be.
