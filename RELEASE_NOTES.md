# Welcome to the Real World

*How You Live in Your Own Simulation of Reality — and How We Can Still Share a World*  
**A Theory of Persistence, Emergence, Learning, and Correctable Intelligence**

**Evolution by Emergence v23.0**

v23.0 is a major release because the core now opens with the question its title has asked since v22: how you live in your own simulation of reality, and how we can still share a world.
- [`CORE.md`](CORE.md) opens with **what a functional world model is**, before its eight steps.
- [`EbECore.lean`](formalization/ebe-core/EbECore.lean) now audits **96** results: five from the new module `WorldModel` join the 91 of v22.
- A definition note, [`research/world-model/WORLD_MODEL.md`](research/world-model/WORLD_MODEL.md), shaped by **three independent reviews**, kept as received with a response to each.
- Since v22.7: the integrity of world models (D33) and the building-the-future essay (D32) are unchanged; [`DIALOGUE.md`](DIALOGUE.md) now runs to D34.

Nothing is removed. The eight steps and their 91 results are unchanged, and so is the earlier work: identity as a learned path, taming capture, relational duties, shared identity as learners, and transparent pricing with its 76-result Lean package. The title's "simulation of reality" means the internal model through which a system experiences and acts in the world; it is not a claim that reality itself is simulated.

## 1. What the theory is about: world models

[`research/world-model/WORLD_MODEL.md`](research/world-model/WORLD_MODEL.md) (D34). In the author's words: "a worldmodel doesn't happen automatically - you have to work on it and create it."

- **Two terms.** A *world model* is any representation that lets a holder infer what it does not observe, what may happen and what would happen if it acted; a wrong one is still a world model. A *functional* world model is the concept the note is about. *World modelling* is the practice, and *evidential fit* a narrow formal ideal.
- **The definition.** A functional world model is held, for a stated scope and use, with the aim of fitting how things are, regardless of what its holder wants; it is tested against evidence whose outcomes are not fixed by the claims tested; it aims to be as sharp as the evidence supports, subject to calibration where calibration can be assessed (after Gneiting, Balabdaoui and Raftery 2007); and it is correctable, in its beliefs, its background assumptions and its range of possibilities, by the holder or by the system that maintains it.
- **Its value.** Many mistakes can be found in the model, at low cost, before they are made in the world.
- **Correction.** Narrowing, revision and representational extension are distinguished. Recomputing from a false piece of evidence repeats the error; retracting it and recomputing corrects it. Keeping the grounds a conclusion rests on is what correction needs; provenance makes it targeted and cheaper.
- **The collective world model.** Its quality depends on two things: what contributors pass on, with their uncertainty and sources, and how the contributions are combined. Under veto pooling one excluding contribution makes the collective deny the actual world; under a weighted average it does not. A collective produces a record, a consensus and a decision, and aggregating is not integrating.
- **A responsibility.** In the author's words: "The definition creates a responsibility." Once it is clear what keeps a world model functional, neglecting one's own, or passing on more certainty than one has, becomes a choice. Taking the responsibility on is a value, not a deduction.
- **Eleven constituents,** each with one principal label (*Stipulated*, *Follows*, *If* or *Proposed*) and its other claims labelled separately.

## 2. How it was checked

- **Review 1,** a strong reader from another model family, found the first version **not ready**: it conflated a representation, a practice and an ideal; built non-recovery into one update rule; rested the collective claim on intersection; and confused set-level sharpness with calibration. The note was rewritten.
- **Review 2,** a lighter reader from a third family, found the second version **ready with changes**. Its verdict lines contradicted each other and two of its points described text that was not there; the response says so, and adopts the rest.
- **Review 3,** a strong reader in a fresh conversation, found the next version **ready with changes**, with five changes it called publication-relevant. All are made.
- Reviews 2 and 3 wrote their own definitions before seeing the material; those answers were recorded first and are kept.
- Everything is in [`research/world-model/sources/`](research/world-model/sources/). No human reader has reviewed it yet.

## 3. The formal layer

[`WorldModel.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/WorldModel.lean): core Lean, no Mathlib, 30 results and a witness. Five are in the core:
- `fit_iff_matches_evidence`: evidential fit is equality of support and live set, a set-level analogue of being as sharp as the evidence allows, not a calibration result;
- `inconsistency_flags_background_or_evidence`: an empty live set means a background assumption or a piece of evidence is false of the actual world;
- `retracting_false_evidence_recovers`: retracting a false piece of evidence recovers what recomputation cannot;
- `hard_pool_one_excluding_contribution_denies_actual`: under veto pooling, one excluding contribution makes the collective deny the actual world;
- `linear_pool_keeps_what_one_source_keeps`: under a weighted sum, what one positively weighted source keeps stays possible.

The results are close to their definitions, and the note says which restate one. They make the terms and their limits checkable. They are not findings about cognition, institutions or persistence. Not modelled: probability over the support, calibration, actions and their consequences, costs, causal structure, and adding new possibilities.

## 4. Front door and metadata

- [`README.md`](README.md) and `CORE.md` lead with the world model.
- `RELEASE_VERSION`, `CITATION.cff`, `.zenodo.json` (adds the keyword "world model"), the README citation, the `ebe_core` dependency example, the integration check and the core count check are synchronized to v23.0 and 96 results. The public title is unchanged.
- The stable Zenodo DOI used across the release lineage is `10.5281/zenodo.15207807`. Zenodo assigns the exact v23.0 version DOI when this GitHub release is archived.

## 5. Status of the claims

- **Proved:** each Lean result is a machine-checked implication under the premises stated in its theorem. Machine checking guarantees that a conclusion follows and that its premises can hold together; it does not make a result deep.
- **Not claimed:**
  - that a functional world model reaches the truth: it can pass every available test and be systematically wrong;
  - that the formal layer covers the concept: it covers evidential fit at the level of possibilities, and the role of update and pooling rules in it;
  - that cells, immune systems or every AI system have functional world models;
  - that one pooling rule is right for every collective;
  - that anyone should maintain a functional world model: that is an aim, stated, not derived;
  - empirical universality, or that any particular system satisfies the premises.
  - Persistence is not goodness.

## 6. Open work

- **World models:** a practice and two checklists, for holders and for contributors; a test in the spirit of H1 in [`PREDICTIONS.md`](PREDICTIONS.md); representational extension, causal structure and the integration side of collective models, all outside the formal layer; the author's hypothesis linking sharpness and compression; a human reader.
- **Carried forward:** the open items of v22.5 to v22.7, including forgetting provenance, graduated sanctions, the transparent-pricing protocol and the stakeholder question on neurorights; the "Not yet formal" list in `CORE.md`; the open entries in [`DIALOGUE.md`](DIALOGUE.md).

## Since this release

- **Cooperative error identification** (D35): conjectures under investigation, in [`research/cooperative-correction/`](research/cooperative-correction/README.md), revised after an independent review that found the first version credited a gain to the bridge that came from provenance. A formal model, [`CooperativeCorrection.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/CooperativeCorrection.lean) (14 results and 2 witnesses, outside the core), separates logical implications from behavioural assumptions; seeded simulations with matched comparators show that a shared reference adds nothing when agents measure the same quantity, a great deal when they measure different ones, and harm when the reference is not commutable: the bridge is itself a model that must be tested.
  - **Acting under time** (conjecture 5, at the author's request): an intelligence cannot defer acting until its model is certain, and not acting is also an action, so the regress of checking ends locally at the next decision ([ACTING_UNDER_TIME.md](research/cooperative-correction/ACTING_UNDER_TIME.md)). [`ActingUnderTime.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/ActingUnderTime.lean) (11 results and a witness, outside the core) proves the decision boundary between investigating and acting, the irreversibility effect and that prevention hides the counterfactual; seeded simulations (E8, E9) show that pooled evidence with provenance makes waiting worth it where one agent should act at once, that reversibility makes earlier action right, and that reading suppressed signals as an all-clear multiplies the loss tenfold.
- **Models for acting in a changing world** (D36): [research/world-model/MODELS_FOR_ACTING.md](research/world-model/MODELS_FOR_ACTING.md), a proposed functional decomposition of what an intelligence keeps besides its world model (representations, objectives, policies, records) and how it uses them to persist, organized around the loop of acting under time; claims labelled one by one, failure cases where the boundaries collapse, sources checked. Formalized in [`ModelsForActing.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/ModelsForActing.lean) (16 results and 3 witnesses, outside the core), and tested in seeded simulations ([sim_models.py](research/world-model/simulation/sim_models.py)): an aimless world model pays when purposes change faster than distinctions can be learned, relative to their upkeep, and otherwise a representation scoped to the purpose is cheaper; peers sharing one's blind spots add nothing, however many. Formally: a representation suffices exactly when the worlds it conflates share an optimal action; an aimless world model that tracks outcomes serves every objective; exact knowledge does not choose without an objective; and a self-assessment can be certified exactly when some channel, from whatever source, separates the states it must tell apart.

The v22.7 release notes remain available at the `v22.7` tag.
