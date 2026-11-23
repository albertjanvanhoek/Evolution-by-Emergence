# Welcome to the Real World

*How You Live in Your Own Simulation of Reality — and How We Can Still Share a World*  
**A Theory of Persistence, Emergence, Learning, and Correctable Intelligence**

**Evolution by Emergence v23.3**

v23.3 keeps everything in v23.2 and adds work done between 8 and 23 November 2026, none of it in the core:
- [`CORE.md`](CORE.md) and [`EbECore.lean`](formalization/ebe-core/EbECore.lean) are unchanged; the core still audits **96** results.
- **A probabilistic ledger for learning** (D50): a working note with a script, revised after an outside review. It claims no new mathematical result.
- **The Ten Verbs Hypothesis** (D51): its versions as lineage, a feasibility study of whether a task can tell the verbs apart, four outside reviews, and a brief for an independent experiment.
- **A working note, "Perplexity as the Workbench's Clock"** (D52): OpenAI's published pretraining curve read through two January 2026 preprints.
- **A proof attempt on the Yang–Mills side** that D(p) never decreases. It is not a proof.
- [`DIALOGUE.md`](DIALOGUE.md) now runs to D54.

Nothing is removed. **This release should not be read as new theory.** Each addition is labelled where it stands as a working note, a feasibility study or an attempt. **No human expert has reviewed any of the additions.**

## 1. The core

Unchanged in its results and its table. No Lean module was added in this release.

## 2. A probabilistic ledger for learning (D50)

[`research/probabilistic-ledger/`](research/probabilistic-ledger/README.md), a working note with a deterministic script, outside the core. It compares two ways to charge for misfit: counting wrong worlds, as in `LearningRatchet.lean`, and the log-loss of the actual world.

- **What it shows, each in its model:** log-loss does not move when a wrong world is split with its mass kept, if the level of scoring is declared; with noise, a false record becomes a debt that honest observations repay; the two terms of progress become a chain rule with redundancy and synergy; with a right instrument the expected gain of an honest turn is never negative.
- **What it does not claim:** every identity used is standard; the note is not a validated resource ledger; nothing physical is claimed.
- **Outside review:** [`verification/audits/2026-11-17-probabilistic-ledger/`](verification/audits/2026-11-17-probabilistic-ledger/REVIEW.md). It reproduced every number and found the prose stronger than the code in twelve places. All were accepted and corrected, with a [response](verification/audits/2026-11-17-probabilistic-ledger/RESPONSE.md). Its verdict on novelty: nothing mathematical is added.

## 3. The Ten Verbs Hypothesis (D51)

[`research/ten-verbs-hypothesis/`](research/ten-verbs-hypothesis/README.md): versions 0.1 to 0.5 kept verbatim as lineage, and a feasibility study in one model of the ten verbs as parameters (seeded parameter and model recovery, and a knockout matrix that checks only the model's architecture).

- **In this model:** with rich belief reports most verbs are recovered well; with only choices recorded the belief verbs blur, so the hypothesis's main test could fail for reasons of measurement alone.
- **Four outside reviews,** kept verbatim. They supported merging it as "a documented feasibility experiment, not as validation of the Ten Verbs Hypothesis." One earlier conclusion was withdrawn after the first.
- **Closed as a feasibility study** by the author's decision. An unfinished four-model comparison is kept in `wip/`, marked not run and imported by nothing.
- **Next:** an independent experiment, with a brief for a modeller in [`research/incompatible-accounts/`](research/incompatible-accounts/BRIEF.md) that does not mention the verbs, and a separate analysis plan for after the design is frozen.

## 4. Perplexity as the Workbench's Clock (D52)

[`papers/perplexity-workbench-clock/`](papers/perplexity-workbench-clock/README.md), a working note. It reads OpenAI's published base-model perplexity curve (22 November 2026) through two of the author's January 2026 preprints on functional information.

- **What it argues:** held-out loss is a scale for functional information in order, though not in magnitude; thresholds set where capabilities appear and velocity sets when; dependence between capabilities gives a partial order, not a fixed sequence; capability is a stack that a base-model index sees only the bottom of.
- **What it tests:** five predictions, each with what would count against it. One of them, even spacing of the bands, already fails a first check against the published numbers. A study design on open model checkpoints is given and has not been run.
- **How well it is checked:** the paper's README lists how each source was seen. Most were seen only as abstracts or excerpts. No literature audit has been done.

## 5. The Yang–Mills working space

[`research/yang-mills-mass-gap/CPN_D_MONOTONICITY.md`](research/yang-mills-mass-gap/CPN_D_MONOTONICITY.md), with a pilot script: an attempt to prove that D(p) never decreases. **No proof.** It gives an exact reformulation as a correlation inequality, two lemmas with proofs, a proof that the purely geometric route fails, and an exact reduction of the weak-coupling case. One lemma needed a repair while drafting and needs a second reader. The working space still contains **no mass-gap result**.

## 6. Front door and metadata

- [`README.md`](README.md) lists the probabilistic ledger and the perplexity note, and its line on the Ten Verbs Hypothesis now matches D51.
- [`verification/README.md`](verification/README.md) lists the outside review of the probabilistic ledger.
- `RELEASE_VERSION`, `CITATION.cff`, `.zenodo.json`, the README citation, the `ebe_core` dependency example and the integration check are synchronized to v23.3. The public title is unchanged.
- The stable Zenodo DOI used across the release lineage is `10.5281/zenodo.15207807`. Zenodo assigns the exact v23.3 version DOI when this GitHub release is archived.

## 7. Status of the claims

- **Proved:** nothing new in this release. The Lean results of earlier releases are unchanged.
- **Numerical results** (sections 2 and 3) hold for the models written, and those models were written by the assistant.
- **Not new:** the probabilistic ledger adds nothing mathematical, by its review; the perplexity note rests on known results, named in it.
- **Working notes, feasibility studies and attempts** are labelled as such where they stand.
- **Persistence is not goodness.** Values are stated separately (D7).

## 8. Open work

- **A human reader** for all of sections 2 to 5.
- **The author's reading** of the probabilistic ledger note and its response (D50), of the feasibility study's results (D51), and of the whole perplexity note (D52).
- **The independent experiment** on incompatible accounts, built by someone other than the assistant.
- **A pilot run** of the open-checkpoint study in the perplexity note.
- **A second reader** for the repaired lemma in the D(p) attempt.
- **Carried forward:** the open work of v23.2, including the creed's draft sections, a lawyer's reading of the legal note, and the "Not yet formal" list in [`CORE.md`](CORE.md).

## Since this release

Nothing yet.
