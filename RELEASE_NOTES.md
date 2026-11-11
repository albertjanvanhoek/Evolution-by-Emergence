# Welcome to the Real World

*How You Live in Your Own Simulation of Reality — and How We Can Still Share a World*  
**A Theory of Persistence, Emergence, Learning, and Correctable Intelligence**

**Evolution by Emergence v23.1**

v23.1 keeps everything in v23.0 and adds three pieces of research, none of them in the core:
- [`CORE.md`](CORE.md) still opens with what a functional world model is, and [`EbECore.lean`](formalization/ebe-core/EbECore.lean) still audits **96** results.
- **Cooperative error identification** and **acting under time** (D35), with formal models and seeded simulations.
- **Models for acting in a changing world** (D36), with a formal model and simulations.
- **A working space on the Yang–Mills mass gap** (D37, D38), now handed over to others, with a separate 14-result Lean package. It contains no mass-gap result and claims none.
- [`DIALOGUE.md`](DIALOGUE.md) now runs to D38.

Nothing is removed. The v23.0 world-model work, and everything it retained from earlier releases, is unchanged. The title's "simulation of reality" means the internal model through which a system experiences and acts in the world; it is not a claim that reality itself is simulated.

## 1. The core

Unchanged.

## 2. Cooperative error identification and acting under time (D35)

Conjectures under investigation, in [`research/cooperative-correction/`](research/cooperative-correction/README.md), revised after an independent review that found the first version credited a gain to the bridge that came from provenance. A formal model, [`CooperativeCorrection.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/CooperativeCorrection.lean) (14 results and 2 witnesses, outside the core), separates logical implications from behavioural assumptions; seeded simulations with matched comparators show that a shared reference adds nothing when agents measure the same quantity, a great deal when they measure different ones, and harm when the reference is not commutable: the bridge is itself a model that must be tested.

**Acting under time** (conjecture 5, at the author's request): an intelligence cannot defer acting until its model is certain, and not acting is also an action, so the regress of checking ends locally at the next decision ([ACTING_UNDER_TIME.md](research/cooperative-correction/ACTING_UNDER_TIME.md)). [`ActingUnderTime.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/ActingUnderTime.lean) (11 results and a witness, outside the core) proves the decision boundary between investigating and acting, the irreversibility effect and that prevention hides the counterfactual; seeded simulations (E8, E9) show that pooled evidence with provenance makes waiting worth it where one agent should act at once, that reversibility makes earlier action right, and that reading suppressed signals as an all-clear multiplies the loss tenfold.

## 3. Models for acting in a changing world (D36)

[research/world-model/MODELS_FOR_ACTING.md](research/world-model/MODELS_FOR_ACTING.md), a proposed functional decomposition of what an intelligence keeps besides its world model (representations, objectives, policies, records) and how it uses them to persist, organized around the loop of acting under time; claims labelled one by one, failure cases where the boundaries collapse, sources checked. Formalized in [`ModelsForActing.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/ModelsForActing.lean) (23 results and 4 witnesses, outside the core), and tested in seeded simulations ([sim_models.py](research/world-model/simulation/sim_models.py), [sim_learning.py](research/world-model/simulation/sim_learning.py)): stopping to learn when certain enough fails where uncertainty cannot be resolved, and a rule set by the value of several more readings does best at every cost; copies counted as evidence make a holder confidently wrong ten times as often; an aimless world model pays when purposes change faster than distinctions can be learned, relative to their upkeep, and otherwise a representation scoped to the purpose is cheaper; peers sharing one's blind spots add nothing, however many. Formally: a representation suffices exactly when the worlds it conflates share an optimal action; an aimless world model that tracks outcomes serves every objective; exact knowledge does not choose without an objective; and a self-assessment can be certified exactly when some channel, from whatever source, separates the states it must tell apart.

## 4. The Yang–Mills mass gap: a working space, handed over (D37, D38)

[`research/yang-mills-mass-gap/`](research/yang-mills-mass-gap/README.md), built on 7–8 November 2026 by the author with two AI assistants from different model families, each checking the other. Active work has stopped. [`HANDOFF.md`](research/yang-mills-mass-gap/HANDOFF.md) is written for whoever takes it further, with open issues [#145](https://github.com/albertjanvanhoek/Evolution-by-Emergence/issues/145)–[#147](https://github.com/albertjanvanhoek/Evolution-by-Emergence/issues/147). In the author's words: "I think we tried enough - please prepare the PR for a merge and a release - such that others can do the rest."

- **Routes closed, with reasons.** The residual term of a renormalisation bridge is short-range even in gapless O(2), so it is not where the difficulty is. A continuous gauge-invariant twist in 4D SU(2) costs area, so the mechanism of the new 2D O(3) proofs does not carry over directly; twists in gauge theory come from 1-form symmetries, which are abelian. The thin centre sector is frozen once monopoles are forbidden, which reproduces Kovács and Tomboulis (1997).
- **A rung below Yang–Mills: 2D CP^{N−1}.** The twist estimate of the O(3) proof seems to carry over. What is missing is one pinning lemma, which a fusion argument reduces to a monotonicity of a loop-crossing probability. That monotonicity is proved, at all couplings, for growing graph classes: stars, a double star, any network behind one gateway, weak extra gateways, and separate routes from each pinned site to one outer site. Also proved: the O(3) twist estimate on bounded-range graphs, and an identity that makes the crossing probability computable on any graph.
- **The open problem, stated exactly:** gateways that touch both pinned sites and the outer site, outer layers with many sites, and bounds uniform over the annulus. An exact screen and a full-model test found no counterexample.
- **The formal layer:** [`research/yang-mills-mass-gap/lean/`](research/yang-mills-mass-gap/lean/), a separate Mathlib project with its own CI and 14 audited results: a counterexample to a covariance-transfer assumption, a corrected transfer with the residual term kept, a physical-scale condition, and the law of total covariance on finite spaces. These are bookkeeping; the physics sits in their hypotheses.

**Not claimed:** a mass gap, exponential decay for CP^{N−1}, or any result about four-dimensional Yang–Mills. Every proof was written by one model family and, where stated, checked by the other; **no human expert has reviewed any of it.** The two 2D O(N) proofs it builds on are preprints, not yet peer reviewed.

## 5. Front door and metadata

- [`README.md`](README.md) lists the new folder under research.
- `RELEASE_VERSION`, `CITATION.cff`, `.zenodo.json` (adds the keywords "Yang–Mills", "lattice gauge theory" and "sigma model"), the README citation, the `ebe_core` dependency example and the integration check are synchronized to v23.1. The public title is unchanged.
- The stable Zenodo DOI used across the release lineage is `10.5281/zenodo.15207807`. Zenodo assigns the exact v23.1 version DOI when this GitHub release is archived.

## 6. Status of the claims

- **Proved:** each Lean result is a machine-checked implication under the premises stated in its theorem. Machine checking guarantees that a conclusion follows; it does not make a result deep.
- **Conjectures and working notes** are labelled as such in each folder. The simulations of D35 and D36 are seeded and reproducible; they show what a model does, not what any real system does.
- **Persistence is not goodness.** Values are stated separately (D7).

## 7. Open work

- **Yang–Mills:** problems P1–P6 in [`HANDOFF.md`](research/yang-mills-mass-gap/HANDOFF.md), above all a human review of the proofs.
- **Cooperative correction and models for acting:** the open items in [`research/cooperative-correction/`](research/cooperative-correction/README.md) and [`research/world-model/`](research/world-model/README.md).
- **Carried forward:** the open work of v23.0, including a practice and checklists for world models, and the "Not yet formal" list in [`CORE.md`](CORE.md).

## Since this release

- **`LearningVerbs.lean`** (outside the core): the verbs of learning, D40. Seven verbs are together enough for learning in one turn of a loop and each is needed; seven verbs between two learners remove a blind spot. 55 theorems, core Lean. See [research/discovarianism/LEARNING_DECOMPOSITION.md](research/discovarianism/LEARNING_DECOMPOSITION.md).
- **`LongCollaboration.lean`** (outside the core): which verbs a long collaboration needs, D41. In a closed pair it lasts exactly when both learners do all seven verbs; a learner who takes and does not pass on is corrected only while the other's reserve lasts. 31 theorems, core Lean.
- **`LearningRatchet.lean`** (outside the core; first named `LearningVortex`): the learning loop on the vortex ledger, as a ratchet, D42 and D43. The loop pays for its own next turn; the speed has a sign (a retained false record); the speed has two terms (own operations, and a link to a different view). 32 theorems, core Lean, including being told against being taught (D44). A first formal statement of "efficiency buys duration".
- **Concept note:** [research/relational-duties/FALLIBLE_NOT_INCOMPETENT.md](research/relational-duties/FALLIBLE_NOT_INCOMPETENT.md), a person as the holder of a correctable model, and the safeguard that fallible is not incompetent (D39). A proposal, to be kept apart from established law.

The v23.0 release notes remain available at the `v23.0` tag.
