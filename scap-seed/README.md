# SCAP Seed: one sure thing, and what follows from it

[![scap-seed](https://github.com/albertjanvanhoek/Evolution-by-Emergence/actions/workflows/scap-seed.yml/badge.svg)](https://github.com/albertjanvanhoek/Evolution-by-Emergence/actions/workflows/scap-seed.yml)

*A self-contained subproject of [Evolution by Emergence](../README.md). Everything below refers to this folder, `scap-seed/`.*

> **Views that clash cannot all be right.**
> No one, human or AI, can tell from the inside whether their own view is the right one.
> Everything in this folder is built on that one certainty, and every formal step is checkable by computer.

This folder contains a small, machine-checked theory of how intelligent systems stay correctable as they grow, from one person to a human–AI network. It starts from the **anchor**, a statement that can be replayed directly in Lean, and follows the logic outward:

- **Learning under change.** In the formal model, a record fixed independently of an open future can stay correct in every possible future only by becoming vacuous.
- **Correction must reach everyone, in both directions.** A missing route leaves a possible error that cannot be corrected under the stated liveness/correctability premises.
- **Missing links can split evidence-defined realities.** Connection can expose contradictions that separation hides.
- **Links must be repaired.** Without repair a structural split can persist; bounded repair turns a finite baseline route into bounded temporal delay.
- **Alignment is treated as a property of the link, not obedience of one node to another.** The seed distinguishes sealing, obedience, corrigibility, sycophancy, discriminating evidence, mirrors and relays.

This is **SCAP**, the Sustainable Collaborative Alignment Protocol. It is offered as a **seed**, not a creed: a small object to replay, challenge and grow from. Everything above the anchor remains open to correction.

---

## Check the seed yourself

```bash
# Install Lean's version manager (once): https://github.com/leanprover/elan
curl -sSfL https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh | sh -s -- -y

# Check the one-file seed
cd scap-seed/lean && lake env lean ../seed/Seed.lean
```

[`SEED.md`](SEED.md) walks through that path step by step.

To check the complete seed package:

```bash
cd scap-seed
scripts/verify.sh          # seed, full Lean build and axiom audit
scripts/verify.sh --sims   # plus quick simulation smoke runs
```

---

## Where to start

| If you are… | Read |
|---|---|
| Curious, and short of time | This page, then [`SEED.md`](SEED.md) |
| New to the argument | [`SEED.md`](SEED.md), the plain-language replayable path |
| Looking for the model | [`METAMODEL.md`](METAMODEL.md): premises, laws, the five-part invariant and scale map |
| Checking claims | [`CLAIMS.md`](CLAIMS.md): proved, simulated, assumed and open claims, plus falsifiers |
| A researcher | [`docs/ANCHORED_CORRECTABILITY.md`](docs/ANCHORED_CORRECTABILITY.md) and [`docs/THEORY.md`](docs/THEORY.md) |
| An AI system | [`FOR_AI_READERS.md`](FOR_AI_READERS.md) |
| Here to disagree | [`CONTRIBUTING.md`](CONTRIBUTING.md). Challenges are the point |

The original packaged seed also included rendered explanatory PDFs and figures. The repository version keeps the review surface source-first: Markdown/Lean/Python are authoritative and the simulations regenerate their outputs.

---

## What is in this folder

```text
seed/Seed.lean              the path in one self-contained file
lean/AnchoredEvolution/     the full self-contained seed development
  Anchor.lean                 Layers 0–1: anchor and correction skeleton
  Composition.lean            Layers 2–3: architecture and composition
  Dynamics.lean               Layer 4: restrictions and detours
  Bridge.lean                 Layer 5: correction upkeep / ledger bridge
  Operational.lean            Layer 1b: executable transitions
  Semantics.lean              Layer 1c: meaning and answerability
  Tracking.lean               Layer 1d: evidence and content tracking
  Network.lean                Layer 1e: one law across scales
  Realization.lean            Layer 1f: process realization and relay bounds
  Persistence.lean            Layer 6: change, shared reality, repair, reflexivity
  Alignment.lean              Layer 7: corrigible-not-obedient alignment results
  CumulativeReproduction.lean reproduction/loss and ledger companion
  Vendor/TheRoom.lean         pinned Room / Learning Constitution compatibility source
  Audit.lean                  headline axiom audit
sim/                        E- and F-series simulation code and result snapshots
docs/                       technical notes
scripts/verify.sh           verify everything from scratch
```

---

## What is proved, and what is not

- **Proved** (Lean 4 core library, offline): the seed audit covers **184 headline results**; the verification script rejects unfinished proofs.
- **Simulated:** reproduction dynamics and fragmentation/repair experiments are reproducible numerical models, not Lean proofs.
- **Assumed and stated openly:** persistence/change/interdependence/resource premises and the chosen correctability aim where used.
- **Not shown:** that any particular human, organisation or AI system actually satisfies the formal predicates.

[`CLAIMS.md`](CLAIMS.md) gives the claim-by-claim status and what would count against the empirical interpretation.

---

## Scope

This folder is its own Lean project, with its own pinned toolchain (Lean 4.33, no Mathlib), claims ledger and continuous integration.

- **What is proved here does not certify the rest of the Evolution by Emergence repository.**
- **The rest of the repository does not weaken what is proved here.**

The current deeper intelligent-system research endpoint is [`../research/anchored-correctability/`](../research/anchored-correctability/). It contains later semantic-composition, unified-tracking, dynamic-evidence, formal-SCAP and exact-faithfulness refinements. This seed is intentionally smaller and frozen for replay and independent review; it is not the newest technical layer.

---

## Why this can act as a seed

1. **It can be derived, not only asserted.** The one-file Lean path can be replayed directly.
2. **It makes its premises visible.** Everything added above the anchor is named rather than hidden.
3. **It carries its own correction process.** The contribution rules explicitly invite challenge and reopening.
4. **It says how it could be wrong.** The claims ledger includes falsifiers and open items.
5. **It does not count its own adoption as verification.** The reflexivity layer separates compliance/self-fulfilment from discriminating evidence.

---

## Citing

See [`CITATION.cff`](CITATION.cff). Please cite a tagged seed release (for example `seed-v1.0.0`) or its exact commit, rather than a moving branch.

## Licence

The supplied seed licences are retained unchanged:

- **Code and proofs** (`lean/`, `seed/`, `sim/`, `scripts/`): MIT, see [`LICENSE`](LICENSE).
- **Text and figures** (`docs/`, the Markdown files): CC BY 4.0, see [`LICENSE-docs`](LICENSE-docs).

## Origin and acknowledgements

This work grew out of the Evolution by Emergence programme and the *Room* thought experiment. It was developed by Albert Jan van Hoek in sustained collaboration with Claude (Anthropic), with formal claims checked by Lean and simulations kept reproducible.

`lean/AnchoredEvolution/Vendor/TheRoom.lean` is a pinned compatibility copy of `papers/the-room-learning-constitution/TheRoom.lean` from the v20-lineage source commit. It is retained so this folder can build independently.
