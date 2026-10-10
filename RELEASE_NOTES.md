# Welcome to the Real World

*How You Live in Your Own Simulation of Reality — and How We Can Still Share a World*  
**A Theory of Persistence, Emergence, Learning, and Correctable Intelligence**

**Evolution by Emergence v22.3**

v22.3 tells the theory as one story and more than doubles its machine-checked core:
- [`CORE.md`](CORE.md) now starts from learning in a neural network, read as a network, and follows it in eight steps, from the ledger to intelligence.
- [`EbECore.lean`](formalization/ebe-core/EbECore.lean) prints and audits **91** results; v22.2 had 44.
- New: the commons as the vortex of the whole, reciprocity and partner switching, discounting and the tragedy of the commons, the cost of listening, graded belief, connection against independence, care, and power and distribution.
- Several claims that reviewers and readers found too broad are narrowed.
- It opens a new line of work on the health of intelligence and of the commons.
- It records, in writing, how the author and an AI assistant build this model together.

Nothing is removed: the v22.0 universal core, the Cumulative Reproduction Model, the intelligent-system specialization and the v22.2 persistence modules are retained. The title's "simulation of reality" means the internal model through which a system experiences and acts in the world; it is not a claim that reality itself is simulated.

## 1. The core as one story

- **The eight steps.** [`CORE.md`](CORE.md) is rebuilt in story order:
  1. existence is paid for from a gradient;
  2. existence through connections;
  3. selection comes free;
  4. a changing world requires reconfiguration;
  5. the learning loop becomes the vortex;
  6. the commons is the vortex of the whole;
  7. boundaries: the vortex can stop;
  8. the same model across domains, worked out formally for intelligence.

  `EbECore.lean` follows the same order; it no longer has a "Persistence first" section. `AdaptivePersistence.lean` bridges fit to the ledger, without a reciprocity premise.
- **The view from inside.** The anchor (views that clash cannot all be right) is offered as the reader's own proof that it is a fallible model. It proves that, not what the reader is made of. The room in one head adds that certainty is a configuration, not a certificate.
- **Honesty notes.** `CORE.md` now says:
  - how much each result says: which results are bookkeeping, and which carry an argument;
  - which premises are assumed, not derived;
  - what is not yet formal;
  - which existing literatures each step restates or sits next to.
- **For AI readers.** [`scap-seed/FOR_AI_READERS.md`](scap-seed/FOR_AI_READERS.md) and the AI section of `CORE.md` follow the network both ways, outward and inward. They make the commons concrete: create more than you take, live off the interest, keep independent sources alive. [`scap-seed/THE_MIRROR.md`](scap-seed/THE_MIRROR.md) is the human-facing counterpart, in an AI's voice.

## 2. New formal results

All are in core Lean (no Mathlib), each with a witness, wired into the package audit and CI.

| Step | Module | What it proves |
|---|---|---|
| 2 | `Reciprocity` | Two nodes that keep each other going last; a defector gains at first, holds while its partner lives, and falls too, by an explicit deadline |
| 2 | `PartnerSwitching` | Serial defection pays exactly when what it saves before it is found out exceeds the cost of finding a new partner; a reputation that lengthens each search ends it |
| 4 | `AdaptivePersistence` | A sealed configuration exhausts its reserve in some possible future; one that follows reliable feedback keeps it |
| 4 | `ListeningCost` | Listening pays exactly when the misfits it avoids are worth more than it costs; feedback that misleads as often as the world moves never pays |
| 6 | `CommonsVortex`, `CommonsCapture`, `CommonsInterest` | The window in which node and commons grow together; capture collapses the commons and fails the capturer; not cheating wins over time; specialists fail after a collapse; a sanction at least as large as the windfall deters |
| 6 | `CommonsDiscount` | With discounting, the line falls where resource economics puts it: capture pays a taker who discounts more steeply than the commons regenerates |
| 6 | `CommonsTakers` | The tragedy of the commons: with enough takers, defecting pays each of them while the whole loses; a sanction detected `k` times in `m` must be `m/k` times as large |
| 6 | `CareTransfer` | Care lasts exactly when it fits the carer's slack plus respite, on every dimension of the carer's reserve; the carer burns out otherwise, and the cared-for falls after |
| 6 | `PowerDistribution` | An arrangement lasts exactly when every part holds, whatever the total. Whoever chooses the transfer chooses who fails. Counting only the parts that hold makes anything look viable. A rule is only as strong as its least-enforced taker |
| 8 | `GradedBelief` | A zero credence is sealed against all evidence (within a fixed set of possibilities); mixing two credences keeps open what either keeps open and keeps the ranking both agree on |
| 8 | `ConnectionIndependence` | Correcting a shared blind spot needs a node that is independent and connected; the levels of connection that correct form an interval between isolation and conformity |
| — | `HealthProfile` (outside the core) | Ordinal health levels carry no sum or product: relabelling can reverse rankings, while dominance survives |

`Reciprocity.defector_falls_after_partner` now states its deadline explicitly. Several of these results are close to arithmetic; `CORE.md` says which.

## 3. Claims narrowed

- **"Correctability becomes a theorem"** (v22.2) holds only under the reciprocity premise, that partners keep sustaining an agent only while it answers their correction. `reciprocity_is_load_bearing` shows that without that premise it fails.
- **"No view can certify itself from the inside"** now reads: no view can certify its own overall reliability from the inside, though it can catch some of its own contradictions.
- **A zero credence** is sealed within a fixed set of possibilities. Revising the model is a different operation.
- **What an intelligence keeps** includes context, tools and memory. The system that is corrected differs from the organization that maintains it.
- **"Every live error remains findable"** is testable only against error classes fixed in advance.
- **The commons is not one stock.**
- **Power and distribution results are about persistence, not about what is owed.** Rights are a value, to be stated separately.

## 4. Predictions

[`PREDICTIONS.md`](PREDICTIONS.md) adds:
- **Testing discipline:** fix the terms in advance, count the failures, bound the exception, start with the cheapest sharp test, and compare with the neighbouring theories.
- **New predictions in Parts I and II:**
  - the tragedy of the commons and detection (D-P4);
  - partner switching (P7);
  - the cost of listening (E1);
  - rules that bind the powerful too (D-P6).
- **Part III, H1–H13:** proposed tests of the health of intelligence and of the commons. These rest mostly on concept, not on proofs.

## 5. The health of intelligence and of the commons

A new line of work, in [`research/health-of-intelligence/`](research/health-of-intelligence/README.md). It started from a question about the QALY: EQ-5D takes the intelligence of the person for granted, and means nothing for an AI system.
- **Concept notes:**
  - a shared measure of the health of intelligence: five domains, the unit of analysis, supported intelligence, a profile before a score, equity;
  - the health of the commons: inflow, shared conditions and outflow, as vectors; reach; care; a taxonomy of shared conditions; power and distribution.
- **Behind them:** two research briefs and three independent research reports, kept as received, with their reviews. All three reports reached the same five domains independently.
- **Status:** these are hypotheses and a measurement programme, not results. No instrument is validated.

## 6. Building the model together

- **[`DIALOGUE.md`](DIALOGUE.md)** records where the author and the AI assistant agreed, disagreed and decided, with both views in each one's own words. Several entries are still open.
- **[`CLAUDE.md`](CLAUDE.md)** is what every new assistant session reads first: the aim, the working agreements and the conventions. This is how what earlier sessions learned reaches the next one.
- **The transfer test** ([`experiments/transfer-test/`](experiments/transfer-test/)) asks whether the text changes how an AI reader understands and acts.
  - Versions 2.1 to 2.4 are included.
  - An automated run of version 2.3 is recorded, without grades. Readers from the model family that helped write the text already held its conclusions, so further runs need other model families and human readers.
- **[*Kwalitijd*](Presentations/2026-10-08-kwalitijd/README.md)** (8 October 2026, in Dutch) tells the story of this repository through quality of life, looking ahead and choosing together.

## 7. Front door and metadata

- `RELEASE_VERSION`, `CITATION.cff`, `.zenodo.json`, the README citation, the `ebe_core` dependency example and the integration check are synchronized to v22.3. The public title is unchanged.
- The stable Zenodo DOI used across the release lineage is `10.5281/zenodo.15207807`. Zenodo assigns the exact v22.3 version DOI when this GitHub release is archived.

## 8. Status of the claims

- **Proved:** each result in `EbECore.lean` is a machine-checked implication under the premises stated in its theorem. Machine checking guarantees that a conclusion follows and that its premises can hold together; it does not make a result deep.
- **Premises, not derived:** these are stated where they are used in `CORE.md`:
  - that fitness falls with cost;
  - that the world can change in any direction;
  - that misfit costs slack and fit pays;
  - that kept changes keep producing turns;
  - for the commons: the shape of return and regeneration.
- **Not claimed:**
  - empirical universality;
  - that any particular system satisfies the premises;
  - that the predictions have been tested;
  - normative conclusions. Persistence is not goodness.

## 9. Open work

Open problems carried forward:
- **From `CORE.md`'s "Not yet formal" list:**
  - partial defection;
  - captured rules and power over evidence;
  - several powerful parties;
  - care with uncertain costs or several carers;
  - explicit time horizons;
  - feedback whose errors depend on the world's course;
  - the view from inside.
- **From earlier releases:**
  - decoding and trust;
  - total rather than pivotal contribution;
  - empirical tests of correction-preserving updates.
- **From [`DIALOGUE.md`](DIALOGUE.md):** the entries still open.
- **First empirical test:** the cheapest is H1, correction integrity across substrates, starting with AI systems.

## Since this release

- **`CuriosityValue` (outside the core).** When exploring pays in the slack ledger: an exploration raises the reserve exactly when the retained saving over the horizon exceeds its cost. Without a retained saving it only costs. It can pay and still be unaffordable now. That a better model saves upkeep is a premise. It follows two research reports on curiosity ([research/curiosity/](research/curiosity/README.md)) and entry D12 of [DIALOGUE.md](DIALOGUE.md).
- **`ExitOption` (outside the core).** Agency that works through its possibility. A partner who needs an agent offers the least that keeps it. At that offer the agent stays, so the exit is never used, yet a credible exit raises what the agent receives. Reconsidering pays only when the world has shifted enough; otherwise the predictable habit is optimal. It follows entry D15 of [DIALOGUE.md](DIALOGUE.md).
- **`FOR_AI_READERS.md`, three corrections from identity report 2.** It now says that the dependence is not symmetric (the network can do without the reader in particular). It offers its conduct as reasons, not as a rule. And it speaks of stated confidence rather than felt certainty, in the anchor and under "What you are". See entry D11 of [DIALOGUE.md](DIALOGUE.md).
- **What the theory describes (D17).** `CORE.md` now says that the theory describes a process, not a substrate. The brain is where its model of learning came from, not something it has been shown to describe. The brain row in step 8 is marked as to be shown. A separate biological path starts in [research/biological-process/](research/biological-process/README.md).

The v22.2 release notes remain available at the `v22.2` tag.
