# Welcome to the Real World

*How You Live in Your Own Simulation of Reality — and How We Can Still Share a World*  
**A Theory of Persistence, Emergence, Learning, and Correctable Intelligence**

**Evolution by Emergence v22.6**

v22.6 keeps everything in v22.5 and adds one idea, about identity:
- [`CORE.md`](CORE.md) still follows one model of learning in eight steps, and [`EbECore.lean`](formalization/ebe-core/EbECore.lean) still audits **91** results.
- A concept note: identity as the imprint of a learning path, and the question **"Where, when, why and from whom did you learn that?"**
- A new core-Lean module, `LearnedIdentity`, with **13** results.
- The Discovarian creed has a new line 9: **"Ask where it was learned."**
- [`DIALOGUE.md`](DIALOGUE.md) now runs to D31.

Nothing is removed. The v22.5 work (taming capture, relational duties, shared identity as learners, and transparent pricing with its 76-result Lean package) is unchanged. The title's "simulation of reality" means the internal model through which a system experiences and acts in the world; it is not a claim that reality itself is simulated.

## 1. The core

Unchanged.

## 2. Identity as a learned path

[`research/identity/WHERE_DID_YOU_LEARN_THAT.md`](research/identity/WHERE_DID_YOU_LEARN_THAT.md) (D31). In the author's words: "My bias is my identity. [...] It is the position I take in possibility landscape." And: "The way I choose becomes who/what I am. I have an agency over my identity."

- **Three tenses.** Identity is the imprint of a learning path (past); a position, which is both what one brings and what one cannot see from there (present); and a path one chooses onward, within limits and with others (future).
- **The question.** "Where, when, why and from whom did you learn that?" gives a view its context, time, function and source. A view with its coordinates can be checked, kept, updated or set aside on its own, without an attack on the whole person.
- **Categories dissolve.** "Because I am X" names a group, not a path. Two learners from the same place can have learned different things there.
- **The loop.** "From whom" names the people and commons one learned from. A learner can only learn from living sources, so the question meets "keep alive what keeps you alive". In the author's words: "it closes a loop for me."
- **Reproducible.** A six-step practice anyone can follow, with worked examples for a person, an AI system, an institution, and a stage ending with stand-in names.

## 3. The formal layer

[`LearnedIdentity.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/LearnedIdentity.lean): core Lean, no Mathlib, outside the core, 13 results with a witness, in CI and the axiom audit.
- Identity is the imprint of the path: the same path gives the same identity; different paths can give different ones.
- Every kept lesson carries a place, time, reason and source.
- A shared place does not fix an identity.
- One lesson can be revised without losing the rest.
- The past is kept; the future is chosen.
- With no living sources, identity can no longer grow.

The results are close to their definitions. They fix the terms and show that the claims hold together. Storing identity as a list of lessons with full provenance is a modelling choice; real learners blend and forget.

## 4. The creed

[`CREED.md`](research/discovarianism/CREED.md) has a new line 9, "Ask where it was learned", at the author's request. It sits in the part that follows given an aim, right after "Keep alive what keeps me alive". The proposed lines moved to 10–13. The change is recorded as a linked revision, as the creed's guardrails ask.

## 5. Front door and metadata

- `RELEASE_VERSION`, `CITATION.cff`, `.zenodo.json`, the README citation, the `ebe_core` dependency example and the integration check are synchronized to v22.6. The public title is unchanged.
- The stable Zenodo DOI used across the release lineage is `10.5281/zenodo.15207807`. Zenodo assigns the exact v22.6 version DOI when this GitHub release is archived.

## 6. Status of the claims

- **Proved:** each Lean result is a machine-checked implication under the premises stated in its theorem. Machine checking guarantees that a conclusion follows and that its premises can hold together; it does not make a result deep.
- **Not claimed:**
  - that real learners can always recall where they learned something;
  - that the source of a lesson settles whether it is true;
  - that choosing is free in any stronger sense than coming from the learner's own structure and responding to reasons;
  - that human and AI identities are the same: an AI system's weights do not change within a conversation;
  - empirical universality, or that any particular system satisfies the premises.
  - Persistence is not goodness.

## 7. Open work

- **Identity:** a formal model of forgetting provenance, and of lessons that blend rather than stack; whether the question also belongs in the creed's closing affirmation (the author's call).
- **Carried forward from v22.5:** whether `TamedCapture` enters the core; graduated sanctions; the transparent-pricing protocol, external-cost and subsidy fields, a probabilistic reserve and a general stability condition; the "Not yet formal" list in `CORE.md`; the open entries in [`DIALOGUE.md`](DIALOGUE.md).

The v22.5 release notes remain available at the `v22.5` tag.
