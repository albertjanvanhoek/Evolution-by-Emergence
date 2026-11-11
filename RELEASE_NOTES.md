# Welcome to the Real World

*How You Live in Your Own Simulation of Reality — and How We Can Still Share a World*  
**A Theory of Persistence, Emergence, Learning, and Correctable Intelligence**

**Evolution by Emergence v23.2**

v23.2 keeps everything in v23.1 and adds work done on 10 and 11 November 2026, none of it in the core:
- [`CORE.md`](CORE.md) still opens with what a functional world model is, and [`EbECore.lean`](formalization/ebe-core/EbECore.lean) still audits **96** results.
- **A working note on what one turn of learning consists of**, with three core-Lean modules (D40 to D47), and an **independent literature audit** of it with the repository's response.
- **Two new sections in the creed**, in draft (D40, D43, D45, D46).
- **A legal concept note**, a proposal and not law (D39).
- [`DIALOGUE.md`](DIALOGUE.md) now runs to D49.

Nothing is removed. **This release should not be read as new theory.** The audit judged the formal work to be mainly a small reconstruction of known ideas, and the repository accepts that judgment. **No human expert has reviewed any of the additions.**

## 1. The core

Unchanged in its results and its table. Three pointers were added to [`CORE.md`](CORE.md): to the working note of section 2, and at two items of the "not yet formal" list, where the note has a first form outside the core. One of them records that "outside" has two senses the page does not yet separate: the world answering a test, and another learner correcting what one's own tests cannot tell apart.

## 2. Learning as a loop, in small models (D40 to D47)

[`research/discovarianism/LEARNING_DECOMPOSITION.md`](research/discovarianism/LEARNING_DECOMPOSITION.md), a working note in fifteen sections, with a Z3 model beside it and three modules in [`formalization/cumulative-accessibility/`](formalization/cumulative-accessibility/README.md): `LearningVerbs.lean` (58 theorems), `LongCollaboration.lean` (31) and `LearningRatchet.lean` (34). Core Lean, no Mathlib, in CI.

The model is learning as ruling out possible worlds, in a world that stands still. Within it:
- **One turn.** Trying, testing, recording, updating and retaining, with the truth left open and the turn paid for, are together enough for a learning turn (`seven_verbs_learn`). They are not each individually necessary: five are, in the sense of exact negation; for update and retain the blocking results use one plain way of failing, and a counterexample to more is itself a theorem (`update_not_necessary_in_general`).
- **What cannot be certified from inside.** Two situations can agree in everything the learner has and differ in which world is actual (`tested_and_untested_look_alike`). So "test" and "leave open" are conditions and not things a learner can know it is doing.
- **The blind spot.** An error that none of a learner's operations tells from the truth survives its own honest turns; another learner with a different operation can remove it (`blind_spot_survives`, `seven_verbs_correct`).
- **Corrections can be false.** Accepting a false signal rules out the truth, and for a blind spot the receiver's own observations give the same verdict on a true and a false correction (`accepting_false_signal_loses_truth`, `own_evidence_cannot_evaluate_blind_correction`).
- **Being told and being taught.** Receiving a result is different from acquiring an operation; honest own testing with a correctly understood operation does not rule out the truth (`own_test_keeps_truth`); a method can itself be wrong, and checking it is the same loop applied to accounts of the method.
- **On the ledger of step 1.** A learning turn raises later slack; a retained false record changes it by what it removed minus what the lost truth costs, and blocks later learning until it is taken back; progress has one term from one's own operations and one that arrives only through a link to a different view (`LearningRatchet.lean`). The space is fixed, so this is a ratchet toward fit and not a vortex.
- **A lasting exchange of correction** (`LongCollaboration.lean`) is largely the repository's earlier `Reciprocity` result, and sits on a knife-edge where a correction pays exactly one turn's cost.

## 3. How it was checked, and what the checks found (D43, D45, D46, D47)

- **Two outside reviews** by an assistant from another model family, and **the writing assistant's own adversarial review**. Each found places where the prose said more than the theorems. The corrections are recorded entry by entry.
- **An independent literature audit:** [`verification/audits/2026-11-11-learning-verbs/`](verification/audits/2026-11-11-learning-verbs/AUDIT.md), with the [brief](verification/audits/2026-11-11-learning-verbs/BRIEF.md) it was written on and the [response](verification/audits/2026-11-11-learning-verbs/RESPONSE.md). Sixteen claims: four restatements, seven special cases, one not found, four defective, **no sharpening**. Closest antecedents include candidate elimination (Mitchell 1977), observational equivalence and identification (Rothenberg 1971), knowledge as indistinguishable alternatives (Halpern and Moses 1990), belief revision and update (Alchourrón, Gärdenfors and Makinson 1985; Katsuno and Mendelzon 1992), and relational autonomy (Nedelsky 1989).
- **Two counterexamples** from the audit were accepted and corrected in the Lean files: general necessity of all seven verbs, and a false turn that left no trace when its cost was zero.
- **Left open by the audit and the response:** the literature the audit could not reach; and that an equality in a model says nothing about intention, so the step from a failed verb to a vice needs premises the models do not have.

## 4. The creed (D40, D43, D45, D46, D48)

[`research/discovarianism/CREED.md`](research/discovarianism/CREED.md) has two new sections by linked revision: what a learner does, what has to hold and is not in its hands alone, and a sin for each thing done, with a paragraph on what is not a sin. A tenth verb, *develop and acquire methods*, is provisional. Lines 1 to 13 and the opening line are unchanged. **The new sections are the assistant's wording in the author's voice and are marked in the creed as a draft awaiting his corrections.** Two remarks on the author's own lines are recorded in D43 and not acted on.

## 5. A legal concept note (D39)

[`research/relational-duties/FALLIBLE_NOT_INCOMPETENT.md`](research/relational-duties/FALLIBLE_NOT_INCOMPETENT.md): a person as the holder of a correctable model, a proposed protected interest in one's routes of correction, and the safeguard that fallible is not incompetent. **It is a proposal and is to be kept apart from established law. No lawyer has read it.** Its quotations were confirmed in their primary sources by the audit; its wider historical and legal statements are marked with what their sources support. The audit places it beside existing work on relational autonomy and epistemic injustice.

## 6. Front door and metadata

- [`README.md`](README.md) lists the working note, the creed and the legal note, and links the audit from "Start here".
- [`CLAUDE.md`](CLAUDE.md) gains a reading item and one working rule from this episode: write a result's limits in the same sentence as the result, search for overlap before adding a module, give every blocking result a witness, and ask for a literature audit before calling anything new.
- [`verification/README.md`](verification/README.md) lists the new audit.
- `RELEASE_VERSION`, `CITATION.cff`, `.zenodo.json` (adds the keywords "learning" and "legal capacity"), the README citation, the `ebe_core` dependency example and the integration check are synchronized to v23.2. The public title is unchanged.
- **A defect in the previous state of this file is repaired:** after the merges of 11 November `RELEASE_NOTES.md` on `main` contained unresolved merge-conflict markers. No other file did.
- The stable Zenodo DOI used across the release lineage is `10.5281/zenodo.15207807`. Zenodo assigns the exact v23.2 version DOI when this GitHub release is archived.

## 7. Status of the claims

- **Proved:** each Lean result is a machine-checked implication under the premises stated in its theorem. Machine checking guarantees that a conclusion follows; it does not make a result deep, and most of the results of section 2 are close to their definitions.
- **Not new:** see section 3.
- **Drafts and proposals** are labelled as such where they stand: the creed's new sections, the legal note, and the two definitions of intelligence in D45.
- **Persistence is not goodness.** Values are stated separately (D7).

## 8. Open work

- **A human reader** for all of sections 2 to 5: a lawyer, a philosopher, a clinician.
- **The author's reading** of the creed's new sections and of the audit response.
- **A world that moves.** The learning model's world stands still, and the theory's does not; forgetting and letting go have no model here.
- **Corrections that can be wrong, cost something, and are checked against independent sources** (D43).
- **Widening,** which would turn the ratchet of section 2 into a vortex.
- **Carried forward:** the open work of v23.1, including the Yang–Mills handoff problems, and the "Not yet formal" list in [`CORE.md`](CORE.md).

## Since this release

Nothing yet.
