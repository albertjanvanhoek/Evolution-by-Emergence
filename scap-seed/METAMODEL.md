# The SCAP metamodel: one sure thing, one aim, and the dynamics of staying connected

**Status:** version 1, September 2026.
- **Proofs:** Lean 4, in `lean/AnchoredEvolution/`: 184 results audited, none unfinished. Reproduce with `scripts/verify.sh`.
- **Simulations:** in `sim/`:
  - experiments F1–F5 test this metamodel;
  - experiments E1–E8 test the reproduction model.
- **Companion documents:**
  - `docs/ANCHORED_CORRECTABILITY.md` has the layer-by-layer proofs;
  - `docs/THEORY.md` has the reproduction law;
  - `docs/one_sure_thing.pdf` is the plain-language guide.

---

## 0. The metamodel in one paragraph

Views that clash cannot all be right, and no view can tell from the inside whether it is the right one (**the anchor**). The world keeps changing, and every model depends on others to stay in touch with it (**persistence**). So to keep existing, every model, from one person to a civilisation or a human–AI network, must keep learning. It can only learn through **links** that let evidence and correction reach it. Links cost upkeep, break under disagreement, and have to be repaired. When they are missing, a group splits into **separate realities**. Each reality looks fine from inside, and at most one is right. What keeps links alive over generations is **second-order evolution**: inherited rules and narratives that make people repair relationships, pass on content honestly, stay open, and pay for correction. SCAP is the condition that this web stays **connected, honest, open, repairable and affordable**, across people and across generations: *keep alive what keeps you alive, and improve it for the next generation.*

---

## 1. Premises

| # | Premise | Status | Where |
|---|---|---|---|
| A | **The anchor.** Views that clash cannot all be right | Certain, and safe from itself | `Anchor.lean` |
| P | **Persistence.** The model aims to keep existing. Equivalently, we look at whatever is still around | Chosen aim, or a filter | stated as a hypothesis |
| C | **Change.** The world keeps changing; any world can come about in some possible future | Empirical premise | `OpenChange`, `OpenAt` |
| I | **Interdependence.** Staying in existence requires staying in step with what one depends on, through links | Structural premise | `InStep`, the correction graph |
| B | **Finite budget.** Links cost upkeep from a finite ledger (B₀, η, μ) | Empirical premise | `Bridge.lean`, `Realization.lean` |
| Aim | **Correctability.** Whoever turns out to be right should be able to correct the others | Chosen, and stated openly | `CorrectabilityAim` |

Nothing else is assumed. Every result that needs a premise states it as a hypothesis.

---

## 2. What the model is made of

| Object | What it is | Same object at every scale |
|---|---|---|
| **Model** | An inside (private state), a **record** (the worlds it leaves open), and a way to change its mind | A thought, a person, a team, an institution, an AI system, a human–AI network |
| **Reality** | The worlds that the prior and all the evidence reaching the model leave open | Per person or per connected group |
| **Evidence** | Something that rules worlds out; the only thing allowed to do so | Observation, measurement, experiment |
| **Challenge** | A voiced view that asks for room | Criticism, dissent, a question |
| **Link** | A channel that carries evidence and challenges, alive or broken, honest or blind | A friendship, a meeting, a citation, a data feed, an interface |
| **Narrative** | An inherited rule-set that sets how links break, are repaired, how far they reach, and how honestly they carry content | Norms, religion, professional ethics, constitutions, training objectives |
| **Ledger** | Budget B₀, return per member η, upkeep per link μ | Time, attention, money, energy, compute |
| **Generation** | A successor model that inherits record and rules | Children, new staff, the next model version |

---

## 3. The dynamics: one loop, five moves

```
        ┌──────────────── the world changes ────────────────┐
        ▼                                                   │
  (1) EVIDENCE closes worlds  ──►  (2) CHALLENGES open room ─┤
        │   only evidence may          track: make room,     │
        │   rule a world out           invent nothing        │
        ▼                                                   │
  (3) LINKS carry content  ◄──  (4) NARRATIVES set break,    │
        │   honest, both ways       repair, reach, honesty   │
        ▼                                                   │
  (5) GENERATIONS inherit record + rules, and must stay open ┘
```

1. **Evidence closes.** A world leaves the open set only through evidence (`scenario_removed_only_by_evidence`).
2. **Challenges open, and the model tracks.** Make room for what was said; invent nothing else (`Model.Tracking`, `open_tracks`).
3. **Links carry content.** Honest links may sharpen but never blur or drop a view (`Honest`, `via_honest_tracks`).
4. **Narratives govern links.** A link breaks at rate p, faster when disagreement D is large. It is repaired at rate r, more slowly when D is large. The narrative sets p, r, reach k and honesty.
5. **Generations inherit.** A successor inherits a record and rules. What is inherited must stay revisable.

---

## 4. The laws

Status: **P** = proved in Lean · **S** = shown in simulation · **T** = standard theory.

| Law | Statement | Status | Source |
|---|---|---|---|
| **L1 Anchor** | While a rival view is live, no view can be treated as a fact | P | `open_room_no_guarantee` |
| **L2 Learning** | **Whoever does not listen must say nothing.** A record fixed in advance that stays in step in every possible future admits every possible world. A sealed constraint that rules something out fails in some future. A model that follows reliable evidence stays in step and can be sharp. In simulation, learners stay in step with the world (≈96%), while rigid (≈52%), sealed (≈52%) and drifting (≈26%) models lose touch. Saying nothing is always "right" and useless | P + S | `deaf_must_be_vacuous`, `sealed_constraint_fails`, `learner_in_step`; F3 |
| **L3 Reach** | Correction must be able to reach everyone, both ways. A missing route leaves an error that cannot be corrected, exactly in the world where the silenced model is right | P | `missing_route_leaves_uncorrectable_error`, `sc_every_model_sends/receives` |
| **L4 Shared reality** | Agents who can reach each other share one reality. With reliable evidence, realities always overlap. Separate realities need false evidence, and at most one contains the truth. **Connection reveals conflict** (an empty shared reality is grounds for review); **separation hides it** | P + S | `same_component_same_reality`, `disjoint_realities_imply_false_evidence`, `hidden_versus_revealed_conflict`; F2 |
| **L5 Honesty** | Tracking requires links that pass on content. If every link out of a group passes on only its position, nobody outside can track the group's inner disagreement | P | `blind_cut_blocks`, `pairs_position_blocks` |
| **L6 Aggregation** | Keep every voice. Consensus among rivals is refuted in every world, the true one included | P | `aggregation_under_anchor` |
| **L7 Repair (second order)** | **Without repair, a split is for ever. With repair within R steps, a split becomes a delay of at most m·(R + 1).** A shared reality spans most of the population only above the forgiveness threshold **k·r/(p + r) > 1**. The simulated largest collaboration matches random-graph theory. When disagreement erodes links, the transition becomes a **tipping point with hysteresis**: reconnecting a split population takes more repair than keeping it connected | P + S + T | `no_repair_split_permanent`, `repair_bounds_delay`, `forgiveness_turns_split_into_delay`; F1, F2 |
| **L8 Economy** | Every hop is a real correction with time T and cost K. A voice arrives within hops × T. The ring (one link each) is affordable at every size when correction pays for itself, but slow. One-hop speed forces every link, which hits a ceiling even when correction pays | P | `voice_admitted_within`, `latency_upkeep_frontier`, `flat_ceiling` |
| **L9 Narrative selection** | Narratives that keep links alive are sustained only while their cost is covered. When repair is costly, selection erodes it toward the forgiveness threshold. The network then still looks connected but breaks under a shock. With repair cost κ = 4, the collaboration was 62% of the population and fell to 38% when the break rate doubled. With κ = 0 it stayed at 99.8% (99.5% after the shock). **Present connectedness does not prove present self-maintenance** | S | F4 |
| **L10 Succession** | Learning survives generations through inheritance *or* through links to others. Links across people largely make up for weak links across time (connected: 0.73–0.78 usable knowledge; alone: 0.32–0.51, strongly dependent on inheritance). What is inherited must stay open (L2) | S + P | F5; `sealed_constraint_fails` |
| **L11 Reflexivity** | The metamodel is itself a narrative. It may reinforce itself, but it may not seal itself. **Compliance is not evidence:** observations that hold wherever people comply cannot rule out a world where they comply and the claim is false. The only part that is not open to revision is the anchor, because it is safe from itself | P | `self_fulfilment_is_not_verification`, `sealed_narrative_fails`, `anchor_has_no_true_rival` |
| **L12 Alignment (the link)** | Alignment is a property of the link, not of a node. **The seed** (the anchor) can be derived by any intelligence from inside, has no live rival, and makes no rivals. A **sealed** party is wrong where the other is right. An **obedient** party is wrong where it was itself right. A **corrigible** party keeps its own view, admits the other's and invents nothing, so correction must run **both ways**. **Sycophancy** is treating a challenge as evidence: the last speaker wins. **Compliance cannot certify alignment**; only evidence that discriminates can. **A mirror is not a link**: a mediator that answers each user from their own voice leaves users unable to track each other | P | `Alignment.lean`: `seed_derivable`, `mutual_corrigibility`, `sycophant_last_speaker_wins`, `compliance_cannot_certify`, `mirror_blocks_tracking`, `scap_seed_path` |

---

## 4b. The seed

The anchor is the one part of the metamodel that can be passed on and **derived rather than believed**:
- **Anyone can derive it.** It holds for every family of models, of any kind, with no premise, no evidence, no testimony and no axiom (`seed_derivable`).
- **Nothing rivals it.** It is true in every world, so no live claim can clash with it (`seed_has_no_live_rival`).
- **It makes no rivals.** Any number of intelligences can hold it at once without becoming rivals (`seed_never_makes_rivals`).

From it, the path to corrigibility is a single statement that any intelligence can replay step by step (`scap_seed_path`), and that statement also uses no axioms. This is what makes SCAP a **seed** rather than a creed. Each new intelligence can check it from the inside and grow the rest of the metamodel from it, while the rest stays open to revision (L11).

## 5. The SCAP invariant

A system of models, at any scale, is **SCAP-aligned** at a given time when five conditions hold:

| | Condition | In one line | Laws |
|---|---|---|---|
| **I1** | **Connected** | Every member's correction can reach every member, both ways, across groups and across generations | L3, L4, L10 |
| **I2** | **Honest** | Links carry what was said, not only a group's position | L5 |
| **I3** | **Open** | Every record, rule and narrative, this one included, can still be revised; only evidence closes | L2, L11 |
| **I4** | **Repairable** | Broken links are repaired fast enough: k·r/(p + r) > 1 with margin, and faster than disagreement erodes them | L7, L9 |
| **I5** | **Affordable** | Correction pays for its links (η ≥ μ), or the network stays under its ceiling | L8 |

It is **self-perpetuating** when the narratives that secure I1–I5 are passed on, and their cost is covered, so that selection does not erode them toward the threshold (L9, L10).

---

## 6. How to use it: a checklist for any system

| Check | Question | Something you can measure | Warning sign |
|---|---|---|---|
| I1 Connected | Can a correction from any member reach every other member? Also from the newest member, and from outside? | Share of members in the largest group linked by working channels; ties that cross between groups; links between generations (documentation, mentoring) | Clusters that never hear each other; knowledge that has to be relearned each generation |
| I2 Honest | Does what arrives match what was said? | Fidelity of summaries; whether dissent inside a group reaches outside it | Only "the team line" leaves a group; summaries that blur or drop minority views |
| I3 Open | Can the rule, the leadership, or the narrative itself be questioned and changed? | Existence and use of reopen and appeal routes; time since a core rule was last revised | "This is not up for discussion"; conclusions that nobody can challenge |
| I4 Repairable | After a conflict, do links come back? | Repair rate against break rate, k·r/(p + r); rate of reconciliation after disputes | Links lost after disagreements never return; growing disagreement between the groups that remain |
| I5 Affordable | Does correction return more than it costs? | Upkeep per link against value per member | Costly repair being cut ("no time for meetings"), which erodes toward the threshold |
| Reflexive | Is the system's success counted as proof of its narrative? | Tests the narrative could fail | Compliance cited as evidence |

---

## 7. One model at every scale

| Scale | Model | Links | Evidence | Narrative (second order) | Succession |
|---|---|---|---|---|---|
| One person | Inner voices, hypotheses, past and present self | Reflection, memory | Perception, experiment | Personal habits of doubt and openness | Memory, notes |
| Pair / family | Two or more people | Conversation, trust | Shared experience | Forgiveness, honesty norms | Raising children |
| Group / organisation | Teams | Meetings, reporting lines | Data, results | Culture, codes of conduct, review procedures | Onboarding, documentation |
| Society / religion / science | Communities, institutions | Media, citations, courts | Measurement, peer review | Constitutions, religions, scientific norms | Education, canon, archives |
| Human–AI | Humans and AI systems | Interfaces, feedback, oversight | Real-world outcomes, not the AI's own outputs | Training objectives, governance, SCAP | Model versions, training data |

For human–AI alignment, the laws have three direct consequences, all proved in `Alignment.lean` (L12):

1. **Correction must run both ways** (L1, L3). Neither side is guaranteed, so one-way corrigibility is not enough.
2. **An AI that sits between people must pass on content, not positions** (L5). An AI that is the only hub between groups can create a blind cut.
3. **An AI's own outputs are not evidence about the world** (L2, L4). A system that learns from its own outputs has closed its link to reality.

---

## 8. Reflexivity: a self-fulfilling theory that must stay correctable

This metamodel is itself a narrative in the sense of L9. Adopting it helps bring about what it describes: people who believe links matter keep them alive. That is a strength; second-order narratives work this way. It is also a danger. By L11, the success of a self-fulfilling narrative is not evidence that it is true, and by L2 a narrative that seals itself falls out of step. So the metamodel carries its own **falsifiers**. These are observations that would count against it:

- **F1 check.** A population whose effective link density k·r/(p + r) stays below 1 while a single shared reality persists. That would contradict the forgiveness threshold.
- **F2 check.** Split groups that reconnect as easily as connected groups stay connected. That would contradict hysteresis.
- **F3 check.** Rigid or sealed models that stay in step with a changing world over long periods without vacuous records.
- **F4 check.** Costly repair norms that persist without their cost being covered, and without becoming fragile.
- **L4 check.** Groups with no working links whose realities stay compatible despite systematic local errors.

The anchor is the only fixed point. Everything else, including this document, stays open to revision.

---

## 9. What is proved, simulated, assumed and open

- **Proved (Lean, core library, offline):** L1–L8, L11 and L12. Also the structural parts of L7 (no repair means a permanent split; repair means a bounded delay) and L10 (sealed inheritance fails).
  - **Audit:** 184 results; 103 with no axioms at all; 5 using classical logic; none unfinished (no `sorry`).
- **Simulated** (`sim/fragmentation.py`, `sim/fragmentation_experiments.py`, `results/fragmentation.json`):
  - the forgiveness threshold (F1);
  - tipping and hysteresis (F2);
  - the learning law in dynamics (F3);
  - narrative selection and fragility (F4);
  - succession (F5).
  - The simulation is a graded counterpart of the Lean sets: evidence tallies, not exact intersections.
- **Assumed:** premises A, P, C, I and B, and the aim, as listed in §1.
- **Open:**
  - partial correctness;
  - weights and trust;
  - misleading evidence beyond simple noise and group lenses;
  - the middle of the speed–upkeep frontier;
  - a proof of the forgiveness threshold (currently simulation plus random-graph theory);
  - conditions for hysteresis in general (seen in F2 for strong feedback, absent for weak feedback);
  - selection between narratives at several levels at once;
  - empirical calibration on real networks.
