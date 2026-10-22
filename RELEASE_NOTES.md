# Welcome to the Real World

*How You Live in Your Own Simulation of Reality — and How We Can Still Share a World*  
**A Theory of Persistence, Emergence, Learning, and Correctable Intelligence**

**Evolution by Emergence v22.7**

v22.7 keeps everything in v22.6 and adds two pieces of writing, an orientation and a bridge to human rights:
- [`CORE.md`](CORE.md) still follows one model of learning in eight steps, and [`EbECore.lean`](formalization/ebe-core/EbECore.lean) still audits **91** results. No Lean changes.
- An essay, **Building the future**: what changes when answers become cheap.
- A concept note, **The integrity of world models**: neurorights read as part of existing human rights.
- [`DIALOGUE.md`](DIALOGUE.md) now runs to D33.

Nothing is removed. The v22.6 work (identity as a learned path, `LearnedIdentity`, creed line 9) and the v22.5 work (taming capture, relational duties, shared identity as learners, and transparent pricing with its 76-result Lean package) are unchanged. The title's "simulation of reality" means the internal model through which a system experiences and acts in the world; it is not a claim that reality itself is simulated.

## 1. The core

Unchanged.

## 2. Building the future

[`research/building-the-future/BUILDING_THE_FUTURE.md`](research/building-the-future/BUILDING_THE_FUTURE.md) (D32), with a short orientation paragraph in the README. In the author's words: "It is making the future, not predicting the future."

- **The bottleneck moves.** When answers become cheap, the hard part is no longer finding solutions but taking them up: adaptation, building, changing how we live.
- **Yesterday's aims become today's tools.** Surveillance becomes a tool for the health of a nation; solving becomes a tool for building.
- **Prediction becomes a tool too.** The future is unpredictable not only because of chaos, but because we change it. Its path becomes less predictable, its direction more so, if the steering is shared.
- **Responsibility shifts toward uptake,** for people, institutions and AI systems alike. We will not run out of work, because we do not want to.

A stance, not a result: nothing in the Lean work shows that raising the aim is right (D7). The podcast that occasioned the essay is used as the occasion only; its claims are unchecked.

## 3. The integrity of world models

[`research/world-model-integrity/`](research/world-model-integrity/README.md) (D33). It starts from the author's claim: if every brain models reality rather than accessing it directly, that should be the starting point of how we deal with each other, and deliberate deception degrades another's model just as a neural intervention would, by another route.

- **Not every falsehood is a lie.** The note separates honest error, uncertain claims, known falsehoods and deliberate manipulation. The equivalence with neural manipulation is claimed only for the last.
- **One criterion across routes** (proposed): an influence is impermissible when it is exercised knowingly and degrades another learner's capacity to stay in step and correct itself, without free and informed consent.
- **The bridge.** Each of the five neurorights is read against an existing human right (UDHR, ICCPR), the repository and a duty between people. A sixth row is what the neurorights lack: the integrity of shared world models.
- **What rights are for.** In the author's words: "the human rights are there for naming the principles and setting boundaries towards the excess." They are human-made, so they can be built on and corrected.
- **Autonomous interdependence.** Autonomy is produced by connections. The rights protect autonomy; the relational duties protect the interdependence that produces it. Both protect variation, which correction needs (`correcting_levels_form_interval`).
- **Why now.** The UN Human Rights Council asked for guidelines on applying the *existing* framework to neurotechnology (A/HRC/RES/58/6). The note supports that reading, with a reason the debate lacks.

Legal and UN quotations were checked in their primary sources. The note links to the essay of section 2: rights are a case of yesterday's aims becoming today's tools.

## 4. Front door and metadata

- `RELEASE_VERSION`, `CITATION.cff`, `.zenodo.json`, the README citation, the `ebe_core` dependency example and the integration check are synchronized to v22.7. The public title is unchanged.
- The stable Zenodo DOI used across the release lineage is `10.5281/zenodo.15207807`. Zenodo assigns the exact v22.7 version DOI when this GitHub release is archived.

## 5. Status of the claims

- **Proved:** each Lean result is a machine-checked implication under the premises stated in its theorem. This release adds none.
- **Not claimed:**
  - that raising the aim is right, or that cheap answers make implementation easy; the essay is a stance;
  - that every false statement is a rights violation; whether something is a lie, and whether it was meant to steer, is often unknown;
  - that the route of an influence never matters: influence that leaves no route to discovery deserves the strongest protection;
  - that the integrity of world models should be a right; that is proposed, as a value;
  - empirical universality, or that any particular system satisfies the premises.
  - Persistence is not goodness.

## 6. Open work

- **Building the future:** whether the orientation also belongs in `CORE.md` or the creed (the author's call); a Dutch version if wanted.
- **World-model integrity:** whether to send a stakeholder contribution for the Human Rights Council guidelines; measuring the integrity of a shared world model; deception as a deliberately unfaithful channel, in Lean; the literature on mental integrity and cognitive liberty, still to be read.
- **Carried forward:** forgetting provenance and blending lessons (v22.6); whether `TamedCapture` enters the core; graduated sanctions; the transparent-pricing protocol and its open fields; the "Not yet formal" list in `CORE.md`; the open entries in [`DIALOGUE.md`](DIALOGUE.md).

## Since this release

- **World models, and what makes one functional** (D34): a definition note, [`research/world-model/WORLD_MODEL.md`](research/world-model/WORLD_MODEL.md), revised after an independent review that found the first version not ready for the core ([review](research/world-model/sources/REVIEW_1.md), [response](research/world-model/sources/RESPONSE_1.md)). It separates world model, world modelling, functional world model and evidential fit; states the central rule as sharpness subject to calibration (after Gneiting, Balabdaoui and Raftery 2007); separates monotone update from revision; and treats a collective world model as depending on contributors and on the aggregation rule. New core-Lean module [`WorldModel.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/WorldModel.lean), 28 results and a witness, outside the core.

The v22.6 release notes remain available at the `v22.6` tag.
