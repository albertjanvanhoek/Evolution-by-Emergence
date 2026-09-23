# Claims ledger

Every claim this subproject (`scap-seed/`) makes is listed here with:
- its **status**;
- **where it is checked**;
- **what would count against it**.

A claim is only as strong as its status, so please read each one at that level.

**Status:**
- **Proved:** machine-checked in Lean 4. Run `scripts/verify.sh`.
- **Simulated:** shown in reproducible simulation with fixed seeds, in `sim/`.
- **Theory:** a standard result from the literature, used as is.
- **Assumed:** a premise, stated openly.
- **Open:** not yet shown.

This ledger covers this folder only. Claims made elsewhere in the Evolution by Emergence repository are not certified by these proofs.

A proved theorem can still be *about the wrong thing*. The column "what would count against it" addresses that: it names observations under which the formal result would stop describing the real system.

## Premises

| ID | Premise | Status | Why it is used |
|---|---|---|---|
| A | Views that clash cannot all be right (the anchor) | Proved, no axioms (`seed_derivable`, `anchor_holds`) | The one certainty |
| P | Persistence: a model aims to keep existing (or: we look at what is still around) | Assumed (an aim, or a filter) | Drives the learning law |
| C | Change: the world keeps changing | Assumed (empirical) | Makes rigidity fail |
| I | Interdependence: staying in existence requires staying in step through links | Assumed (structural) | Makes links necessary |
| B | Links cost upkeep from a finite budget | Assumed (empirical) | Makes correction an economic question |
| Aim | Whoever is right should be able to correct the others | Assumed (a choice) | Turns the anchor into requirements on the web of links |

## Laws

| ID | Claim | Status | Checked in | What would count against it |
|---|---|---|---|---|
| L1 | While a rival view is live, no view can be treated as a fact | Proved | `open_room_no_guarantee` | A view guaranteed while a live rival exists (the anchor itself rules this out) |
| L2 | Whoever does not listen must say nothing; sealed constraints fail under change; learners stay in step | Proved + simulated | `deaf_must_be_vacuous`, `sealed_constraint_fails`, `learner_in_step`; F3 | A rigid or sealed model that stays in step with a changing world over long periods, without leaving every world open |
| L3 | Correction must reach everyone, both ways; a missing route locks in an error where the silenced one is right | Proved | `missing_route_leaves_uncorrectable_error` | Only a model outside the premises: one where views cannot clash, or the silenced view is not live |
| L4 | One reality per connected group. With reliable evidence, realities overlap. Separate realities need false evidence. Connection reveals conflict; separation hides it | Proved + simulated | `same_component_same_reality`, `disjoint_realities_imply_false_evidence`, `hidden_versus_revealed_conflict`; F2 | Groups with no working links whose realities stay compatible despite systematic local errors |
| L5 | Tracking needs links that pass on content. A blind cut blocks it | Proved | `blind_cut_blocks`, `pairs_position_blocks` | Rival views tracked across a boundary through which only a group's position passes |
| L6 | Keep every voice; consensus among rivals is refuted in every world | Proved | `aggregation_under_anchor` | (Follows from the anchor) |
| L7 | Without repair a split is permanent; with repair within R steps, the delay is at most m·(R+1) | Proved | `no_repair_split_permanent`, `repair_bounds_delay` | (Structural) |
| L7b | A shared reality spans most of a population only above k·r/(p + r) = 1 (the forgiveness threshold) | Simulated + theory (random graphs) | F1 | A single shared reality that persists while the effective link density stays below 1 |
| L7c | When disagreement erodes links, fragmentation shows tipping and hysteresis | Simulated (strong feedback only) | F2 | Split groups reconnecting as easily as connected groups stay connected |
| L8 | Hops take time and cost. A ring is cheap and slow; one-hop speed forces every link, which hits a ceiling even when correction pays for itself | Proved | `voice_admitted_within`, `latency_upkeep_frontier`, `flat_ceiling` | (Structural, given the ledger premise B) |
| L9 | Costly repair narratives erode toward the threshold and become fragile | Simulated | F4 | Costly repair norms persisting without their cost being covered, and without becoming fragile |
| L10 | Learning survives generations through inheritance or links to others; inheritance must stay open | Simulated + proved | F5; `sealed_constraint_fails` | Isolated lineages keeping knowledge in a changing world while inheritance is sealed |
| L11 | Compliance is not evidence; a self-sealing narrative fails under change | Proved | `self_fulfilment_is_not_verification`, `sealed_narrative_fails` | (Follows from the definitions) |
| L12 | Alignment is a property of the link: corrigible, not obedient; correction both ways; sycophancy is treating a challenge as evidence; compliance cannot certify alignment; a mirror is not a link | Proved | `Alignment.lean`, `seed/Seed.lean` | Real systems certified aligned by evidence that does not discriminate, and turning out aligned. That would not refute the theorem, but it would show the definitions miss something |
| R1–R8 | The reproduction law: threshold, critical mass, speed classes, budget ceiling, hysteresis, nested layers, scaffolds | Proved (discrete core) + simulated | `CumulativeReproduction.lean`; E1–E8; `docs/THEORY.md` | See `docs/THEORY.md` §8 |

## Open

- The forgiveness threshold, proved (currently simulation plus random-graph theory).
- General conditions for hysteresis.
- Partial correctness: views that are partly right.
- Weights and trust between sources.
- Misleading evidence beyond noise and group lenses.
- The middle of the speed–upkeep frontier (hierarchies, degree-limited networks).
- Selection between narratives at several levels.
- Proofs that link the content-indexed and content-in-label formulations.
- Empirical calibration on real networks, and tests on real AI systems:
  - blind-cut tests of summaries;
  - tracking tests (does a model make room for a challenge without dropping its own view?);
  - whether an evaluation discriminates.

**If you can close an open item, or refute a claim, please open a challenge** ([`CONTRIBUTING.md`](CONTRIBUTING.md)).
