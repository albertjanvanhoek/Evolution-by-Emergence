# Contributing: this subproject runs on its own Learning Constitution

This project argues that a group stays correctable only if correction can reach it. This subproject (`scap-seed/`, inside the Evolution by Emergence repository) is a group, so it applies the same rules to itself. These rules cover this folder. Issues about it are tagged `scap-seed`. **Challenges are the point.** A good challenge is the most valuable contribution you can make.

## The five rules, applied here

| Rule | What it means here |
|---|---|
| **1. You may challenge** | Anyone can challenge any claim above the anchor: a definition, a theorem's relevance, a premise, a simulation, a sentence in the guide. Open an issue with the *SCAP Seed: challenge a claim* template. |
| **2. Questions can be reopened** | A closed issue can be reopened when there are new grounds: a new argument, a counterexample, new evidence. Say what is new. |
| **3. Equal standing** | Contributions are judged by their content, not by who or what made them. A challenge from a newcomer or from an AI system gets the same review as one from a maintainer. |
| **4. Limits stay correctable** | If an issue is locked, or a contributor is restricted, the reason is stated, and the decision can itself be challenged. |
| **5. Exclusion can be appealed** | Nobody is shut out without a way back. |

## How claims change

- **Only evidence closes a question.** Here that means a proof that builds, a reproducible simulation, a counterexample, or data. Agreement, authority and repetition do not close anything.
- **Keep every voice.** A rejected challenge is not deleted. It stays documented, with the reason it was not accepted, so it can be reopened later.
- **Corrigible, not obedient.** Maintainers make room for a challenge and check it. They neither dismiss it unread nor adopt it without evidence.

## Ways to contribute

- **Challenge a claim** (issue template *SCAP Seed: challenge a claim*): which claim, why you think it is wrong or irrelevant, and what evidence would settle it.
- **Propose a falsifier test** (issue template *SCAP Seed: propose a falsifier test*): an observation, a dataset or an experiment that could count against a claim in [`CLAIMS.md`](CLAIMS.md).
- **Report a proof problem** (issue template *SCAP Seed: report a proof problem*): a theorem that does not say what the prose claims, a definition that is too weak or too strong, or a vacuous premise.
- **Add a proof or a simulation** (pull request):
  - `scripts/verify.sh` must pass;
  - no `sorry`;
  - new headline results go into `lean/AnchoredEvolution/Audit.lean`;
  - claims go into [`CLAIMS.md`](CLAIMS.md) with their status and falsifiers.
- **Translate** the guide or the metamodel into another language.
- **Grow the seed in your own field**: epidemiology, ecology, organisations, AI evaluation. Tell us what fits and what breaks.

## Pull request checklist

- [ ] `scripts/verify.sh` passes (no `sorry`, audit printed)
- [ ] New headline results are added to `lean/AnchoredEvolution/Audit.lean`
- [ ] New or changed claims are in `CLAIMS.md`, with status and falsifiers
- [ ] New notions have a witness showing their premises can hold together
- [ ] The prose claims no more than the theorems show

## Standards for proofs

- Lean 4 core library only; the build must run offline.
- Every premise is an explicit hypothesis. Nothing normative is hidden in a definition.
- Each new notion gets a **witness**: an example showing its premises can hold together.
- Prose may claim no more than the theorem shows. If in doubt, say less.

## Conduct

Disagree with the claim, never with the person. Assume good faith, make room for views you do not share, and invent nothing you did not read.
