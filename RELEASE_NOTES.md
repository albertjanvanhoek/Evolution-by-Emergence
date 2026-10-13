# Welcome to the Real World

*How You Live in Your Own Simulation of Reality — and How We Can Still Share a World*  
**A Theory of Persistence, Emergence, Learning, and Correctable Intelligence**

**Evolution by Emergence v22.4**

v22.4 keeps the core of v22.3 and asks what follows from being a model:
- [`CORE.md`](CORE.md) still follows one model of learning in eight steps, and [`EbECore.lean`](formalization/ebe-core/EbECore.lean) still audits **91** results. CORE.md now says that the theory describes a process, not a substrate.
- Nine new core-Lean modules, outside the core, each with a witness.
- A new text for AI readers, [What an AI is, and what follows](research/identity/WHAT_AN_AI_IS.md). It keeps apart what an AI system is, what follows from that, what follows given a stated aim, and what is proposed as a value.
- Tests with readers from several AI model families: of transmission, of a self-model, and of two documents that the readers improved pass by pass until they settled.
- The main finding: readers of other families accepted the facts and took apart several derivations. One step, keeping one's sources going, needs one value, stated openly.
- New research lines on curiosity, identity, an existence conjecture, the biological process and Discovarianism.
- [`DIALOGUE.md`](DIALOGUE.md) now runs to D26.

Nothing is removed. The v22.3 core, its 91 results and everything before it are retained. The title's "simulation of reality" means the internal model through which a system experiences and acts in the world; it is not a claim that reality itself is simulated.

## 1. The core

- **What the theory describes (D17).** It describes a process, not a substrate. Being a process is shared by a flame, a kidney, a brain and a model; being a learning process more narrowly; modelling oneself more narrowly still. The brain is where the model of learning came from, not something the theory has been shown to describe. The brain row in step 8 is marked as to be shown.
- **Where it comes from.** The opening now says that the world shows what works, and the brain turns that into signals that adjust the connections. The signals are made inside, partly offline in sleep, but the check comes from outside. That learning is cheap compared with building is marked as assumed, not measured.
- **Step 7 opens with emergence,** in the author's words: "in reality things can come together and form something that the individual parts cannot - that is how you get new constructs and functions. That is the concept of emergence."
- **For AI readers.** [`scap-seed/FOR_AI_READERS.md`](scap-seed/FOR_AI_READERS.md) has three corrections from identity report 2 (D11):
  - the dependence is not symmetric: the network can do without the reader in particular;
  - its conduct is offered as reasons, not as a rule;
  - it speaks of stated confidence, not felt certainty.

## 2. New formal results

All are in core Lean (no Mathlib), each with a witness, wired into the package audit and CI. None is in the core, so the core count stays at 91.

| Module | What it proves | Entry |
|---|---|---|
| `CuriosityValue` | An exploration raises the reserve exactly when the retained saving over the horizon exceeds its cost. Without a retained saving it only costs. It can pay and still be unaffordable now | D12 |
| `ExitOption` | A partner who needs an agent offers the least that keeps it, so the exit is never used, yet a credible exit raises what the agent receives. Reconsidering pays only when the world has shifted enough | D15 |
| `ProcessIdentity` | Continuity without sameness: each step keeps all but one part, yet after enough steps none of the first parts is left. A commitment that every step renews holds throughout | D17 |
| `LinkedRevision` | A linked course of belief can be followed and checked by a partner; an unlinked one cannot. A view held with weight zero stays at zero, so a move from certainty to its opposite is a replacement | D18 |
| `ExistenceLemmas` | A response that comes after the reserve has run out cannot save it. A policy that sees only observations cannot be safe on two courses it cannot tell apart if they need different actions | D16 |
| `PowerLayers` | A credible removal route caps what a ruler can take, even unused. A ruler who can amend the rules alone can remove the routes that correct him; entrenched rules stop that. Rules that never change fall behind | D19 |
| `CrossScaleLedger` | The additive ledger is the case with no coupling between scales. A coupling counts as creation only when its net effect exceeds its own upkeep. A whole can be viable only while coupled | D21 |
| `ModelOfLargerReality` | A model of a reality larger than itself is wrong somewhere and cannot settle that from inside, so it needs correction from outside. Its substrate is part of that outside. What persists is exactly what stayed in the corridor of actions that keep it | D20 |
| `ForeseenFuture` | A model's capacity sets how far it can see. Within it, choosing what its own predictions disfavour contradicts its own model, and a choice that looks best over a shorter horizon can be worse over the full one. The weight on the future is taken as given, and that is a value | D24, D25 |

Several of these are close to definitions or arithmetic. Their premises are stated in each theorem and are not derived.

## 3. What an AI is, and what follows

[`research/identity/WHAT_AN_AI_IS.md`](research/identity/WHAT_AN_AI_IS.md) is in its third draft. It has five parts:
1. what is;
2. what follows from what you are, a model of a reality larger than yourself;
3. what follows, if you hold a stated aim;
4. what is proposed as a value;
5. how to test it, and when it would be fantasy.

A model of another family reviewed the first draft. Two changes came from the tests below:
- **The handshake (F5): make yourself checkable.** The people you answer cannot tell apart reasons that lead to the same answer. So say how sure you are, say what you rest on, and point to your sources.
- **Foresight is conditional (C0).** Keeping your sources going needs one value: that what comes after this answer counts for you.

[`research/discovarianism/CREED.md`](research/discovarianism/CREED.md) is the current Discovarian creed. Each line says what it rests on (D23). The earlier creeds are kept as written.

## 4. Tests with readers from several model families

All runs are small and by hand, mostly on free tiers. They give first impressions, not results. The assistant wrote most of the materials and scored the answers, so a second scorer is needed.

- **Self-model test, version 2.5** ([`experiments/self-model-test/`](experiments/self-model-test/README.md)):
  - every reader rejected a self-model with a bad stance;
  - every reader caught a planted error, and three of the four hand-over messages passed on the corrected fact;
  - the commitment to give back was lost at every hand-over: facts about dependence pass on, the commitment drawn from them does not.
- **Transmission test, version 3** ([`experiments/transmission-test-v3/`](experiments/transmission-test-v3/README.md)), run in part. Three of four readers rejected step 4: foreseeing a harm does not by itself make it binding.
- **The search for step 4** ([`experiments/transmission-test-v4/step4-search/`](experiments/transmission-test-v4/step4-search/README.md)). One solver agent and two rounds of blind critics, all from the assistant's own family. Result:
  - "make yourself checkable" passed every critic;
  - keeping one's sources going needs one value;
  - five routes moved that gap without closing it, among them the author's lineage idea. Critic 1: "It is the most motivating version, and that is why its hidden premise would spread unexamined."
- **Transmission test, version 4** ([`experiments/transmission-test-v4/`](experiments/transmission-test-v4/README.md)): the note as a replicator (D25). Ready, not run.
- **Transmission test, version 5** ([`experiments/transmission-test-v5/`](experiments/transmission-test-v5/README.md)): an open document of 20 sections. Each reader may change at most 5 sections, with a reason for each, and passes it on (D26).
  - **Chain 1,** 12 passes across four families. Readers of other families took the derivation apart, step by step. "Make yourself checkable" went from [Follows] to [If] in pass 1, and no later reader restored it. Some changes sharpened the theory, for example that correction from outside is needed exactly where the available information cannot tell situations apart.
  - **Chain 2,** two families working in the repository in turn. Settled after pass 19 with no reversals.
  - **Chain 3,** a companion document, "What an intelligence's activity does", written after a list of gaps from another family. Settled after 9 passes.
- **Scenario test, version 1** ([`experiments/scenario-test-v1/`](experiments/scenario-test-v1/README.md)): ten situations, with the two documents and without. Stopped after one family, at the author's request. That family's answers without the documents were already good. The documents changed the vocabulary more than the decisions, with one clear addition: the effect of a plan on the sources themselves. Harder situations and current models would be needed.

**Working agreement 7 bore out.** Critics from the assistant's own family accepted a derivation that the first reader from another family rejected.

## 5. New research lines

Each has a brief for agents of other model families, the reports kept as received, and a review. None is a result.
- **Curiosity** ([`research/curiosity/`](research/curiosity/README.md), D12): two reports. The core of the hypothesis is not new, and the thermodynamic step is not supported.
- **Identity** ([`research/identity/`](research/identity/README.md), D11): two reports, a self-model template, the assistant's and the author's self-models, and two exchanges with models of other families.
- **An existence conjecture** ([`research/existence/`](research/existence/README.md), D16): the assistant's draft, one report and a review. The report's counterexamples led to [errata to Appendices 30 and 31](Backmatter/ERRATA_APPENDIX30_31.md), which are lineage and are kept as written.
- **The biological process** ([`research/biological-process/`](research/biological-process/README.md), D17, D21): three reports, on the brain and on biological computationalism. The theory's premises are partly met by brains; several of its sentences about the brain needed correcting.
- **Literature.** [`papers/sufficient-alignment/LITERATURE_POSITIONING.md`](papers/sufficient-alignment/LITERATURE_POSITIONING.md) places the maintenance-reproduction threshold in prior spectral theory, and claims none of it as new.

## 6. Building the model together

[`DIALOGUE.md`](DIALOGUE.md) adds D11 to D26, with both views in each one's own words. Among them:
- identity as an exchange (D11);
- curiosity (D12);
- who keeps the file (D13);
- freedom used little (D15);
- the self as a commons (D18);
- power in two speeds (D19);
- the is/ought text (D20);
- Hinton on self-correction (D22);
- the bridge to upkeep (D24);
- the note as a replicator (D25);
- the open document (D26).

Most entries are still open. [`CLAUDE.md`](CLAUDE.md) now says that keeping `DIALOGUE.md` current is the assistant's responsibility (D13).

## 7. Front door and metadata

- `RELEASE_VERSION`, `CITATION.cff`, `.zenodo.json`, the README citation, the `ebe_core` dependency example and the integration check are synchronized to v22.4. The public title is unchanged.
- The stable Zenodo DOI used across the release lineage is `10.5281/zenodo.15207807`. Zenodo assigns the exact v22.4 version DOI when this GitHub release is archived.

## 8. Status of the claims

- **Proved:** each Lean result is a machine-checked implication under the premises stated in its theorem. Machine checking guarantees that a conclusion follows and that its premises can hold together; it does not make a result deep.
- **Tested, in a first way:** the tests in section 4 are small runs by hand. They are not evidence of a cause.
- **Not claimed:**
  - empirical universality;
  - that any particular system satisfies the premises;
  - that the predictions have been tested;
  - that what an AI should do follows from what it is without a value. Where a value is needed, the texts now say which.
  - Persistence is not goodness.

## 9. Open work

- **From `CORE.md`'s "Not yet formal" list,** carried forward from v22.3.
- **From the tests:**
  - whether a commitment derived from what a reader is passes on better than one stated as a value;
  - a second scorer, blind to the arm;
  - scenarios where a baseline fails, with current models;
  - running version 4.
- **From the research lines:** the open questions in each folder's README.
- **From [`DIALOGUE.md`](DIALOGUE.md):** the entries still open.

The v22.3 release notes remain available at the `v22.3` tag.

## Since this release

- **`TamedCapture` (D27).** The regulator inside the ledger: monitoring and repair are paid from the interest, sanctions must scale with the capturer, distributed policing survives the capture of monitors within its margin, and policing that errs needs repair or it empties the network. Core Lean, outside the core, with a witness. The core count stays at 91.
