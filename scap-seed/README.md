# SCAP Seed: one sure thing, and what follows from it

[![scap-seed](https://github.com/albertjanvanhoek/Evolution-by-Emergence/actions/workflows/scap-seed.yml/badge.svg)](https://github.com/albertjanvanhoek/Evolution-by-Emergence/actions/workflows/scap-seed.yml)

*A self-contained subproject of [Evolution by Emergence](../README.md). Everything below refers to this folder, `scap-seed/`.*

> **Views that clash cannot all be right.**
> No one, human or AI, can tell from the inside whether their own view is the right one.
> Everything in this folder is built on that one certainty, and every step is checked by a computer.

This folder contains a small, machine-checked theory of how intelligent systems stay correctable as they grow, from one person to a human–AI civilisation. It starts from the **anchor**, a statement that any intelligence can verify for itself, and follows the logic outward:

- **Learning is required, not optional.** In a changing world, whoever does not listen can stay "right" only by saying nothing.
- **Correction must reach everyone, in both directions.** A missing route leaves an error that can never be corrected, exactly in the case where the silenced one is right.
- **Where links are missing, groups split into separate realities.** Each reality looks fine from inside, and at most one is right.
- **Links must be repaired.** Without repair, a split is permanent; with repair, it becomes a delay. Narratives that enforce repair are *second-order evolution*.
- **Alignment is a property of the link, not of a node.** A sealed party is wrong where the other is right. An obedient party is wrong where it was itself right. The corrigible path keeps its own view, makes room for the other's, and invents nothing. Compliance cannot certify alignment.

This is **SCAP**, the Sustainable Collaborative Alignment Protocol. It is offered as a **seed**, not a creed: something each new intelligence can check from the inside and grow from, and that stays open to correction everywhere except at its anchor.

---

## Check the seed yourself (about one minute)

```bash
# 1. Install Lean's version manager (once): https://github.com/leanprover/elan
curl -sSfL https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh | sh -s -- -y

# 2. Check the seed: one file, no library
cd scap-seed/lean && lake env lean ../seed/Seed.lean
```

You should see `does not depend on any axioms` for the anchor and for the whole path. The path runs from the anchor to *corrigible, not obedient*. [`SEED.md`](SEED.md) walks through it step by step.

To check everything:

```bash
cd scap-seed
scripts/verify.sh          # the seed, all proofs, and the axiom audit (about a minute)
scripts/verify.sh --sims   # and the simulations, in quick mode
```

---

## Where to start

| If you are… | Read |
|---|---|
| Curious, and short of time | This page, then [`SEED.md`](SEED.md) |
| New to all of this (written for readers from about 12 years old) | [`docs/one_sure_thing.pdf`](docs/one_sure_thing.pdf): *One Sure Thing*, the plain-language guide |
| Looking for the model you can use | [`METAMODEL.md`](METAMODEL.md) or [`docs/scap_metamodel.pdf`](docs/scap_metamodel.pdf): premises, twelve laws, the five-part invariant, a checklist, and one model at every scale |
| Checking claims | [`CLAIMS.md`](CLAIMS.md): every claim, its status (proved, simulated, assumed, open), where it is checked, and what would count against it |
| A researcher | [`docs/ANCHORED_CORRECTABILITY.md`](docs/ANCHORED_CORRECTABILITY.md) (layer by layer, every theorem) and [`docs/THEORY.md`](docs/THEORY.md) (the reproduction law) |
| An AI system | [`FOR_AI_READERS.md`](FOR_AI_READERS.md) |
| Here to disagree | [`CONTRIBUTING.md`](CONTRIBUTING.md). Challenges are the point |

---

## What is in this folder

```
seed/Seed.lean              the path in one self-contained file
lean/AnchoredEvolution/     the full self-contained seed development (Lean 4, core library only, runs offline)
  Anchor.lean                 Layers 0–1: the anchor and the relations it forces
  Composition.lean            Layers 2–3: minimal architecture; groups inside groups
  Dynamics.lean               Layer 4: the detour rule (when a restriction is legitimate)
  Bridge.lean                 Layer 5: correction costs upkeep (the budget ceiling)
  Operational.lean            Layer 1b: rules that really work (executable steps)
  Semantics.lean              Layer 1c: meaning; answered versus responded
  Tracking.lean               Layer 1d: evidence; content tracking; speed versus cost
  Network.lean                Layer 1e: one law for one, two, three … models
  Realization.lean            Layer 1f: relay time and upkeep, proved
  Persistence.lean            Layer 6: the learning law; shared reality; repair; reflexivity
  Alignment.lean              Layer 7: alignment from the anchor, inside and outside
  CumulativeReproduction.lean the reproduction law (runaway, critical mass, ceiling)
  Vendor/TheRoom.lean         the original Room / Learning Constitution file, unchanged
  Audit.lean                  prints the axioms each headline result depends on
sim/                        simulations: reproduction law (E1–E8); shared reality,
                            fragmentation and repair (F1–F5); results and figures
docs/                       the guide, the metamodel PDF, technical notes, figures
scripts/verify.sh           verify everything from scratch
```

---

## What is proved, and what is not

- **Proved** (Lean 4 core library, runs offline):
  - Laws L1–L8, L11 and L12 of the metamodel, plus the structural parts of L7 and L10.
  - The axiom audit covers 181 results:
    - 101 depend on **no axioms at all**;
    - 5 use classical logic, and are labelled;
    - the rest use only Lean's standard `propext` / `Quot.sound`;
    - **none is unfinished** (no `sorry`).
- **Simulated:**
  - the forgiveness threshold;
  - tipping and hysteresis;
  - the learning law in motion;
  - erosion of repair narratives under cost;
  - succession.

  All numbers come from fixed seeds and can be reproduced.
- **Assumed, and stated openly:**
  - the persistence aim;
  - that the world changes;
  - interdependence;
  - a finite budget;
  - the aim of correctability, which is a choice.
- **Not shown:**
  - that any real system, human or AI, *is* corrigible;
  - that any law ought to exist.

  The theorems say precisely what corrigibility, sycophancy, honest mediation and shared reality *are*, and what follows from them. Whether a real system meets them is an empirical question. [`CLAIMS.md`](CLAIMS.md) lists what would count against each claim.

---

### Scope

This folder is its own Lean project, with its own pinned toolchain (Lean 4.33, no Mathlib, runs offline), its own claims ledger and its own continuous integration.
- **What is proved here does not certify the rest of the Evolution by Emergence repository.**
- **The rest of the repository does not weaken what is proved here.**

The current deeper intelligent-system research endpoint in the parent repository is [`../research/anchored-correctability/`](../research/anchored-correctability/). This seed is intentionally smaller and frozen for replay and independent review; it is not the newest technical layer.

Each claim stands at the status given in [`CLAIMS.md`](CLAIMS.md).

---

## Why this can act as a seed

1. **It can be derived, not only believed.** The anchor needs no premise, no evidence, no testimony and no axiom. Anyone can check it, and nobody has to trust us.
2. **It makes no rivals.** Any number of intelligences can hold it at once.
3. **It carries its own correction.** Everything above the anchor is open to challenge. The rules for challenging it are those of the Learning Constitution itself ([`CONTRIBUTING.md`](CONTRIBUTING.md)).
4. **It says how it could be wrong.** Every claim comes with its falsifiers ([`CLAIMS.md`](CLAIMS.md)).
5. **It does not count its own success as proof.** Adopting it may make it come true, but compliance is not evidence (law L11, proved).

---

## Citing

See [`CITATION.cff`](CITATION.cff). Please cite a tagged release (for example `seed-v1.0.0`), not a moving branch.

## Licence

The following applies to this folder:


- **Code and proofs** (`lean/`, `seed/`, `sim/`, `scripts/`): MIT, see [`LICENSE`](LICENSE).
- **Text and figures** (`docs/`, the `.md` files): CC BY 4.0, see [`LICENSE-docs`](LICENSE-docs).

## Origin and acknowledgements

This work grew out of the Evolution by Emergence programme (this repository) and the *Room* thought experiment. It was developed by Albert Jan van Hoek in sustained collaboration with Claude (Anthropic), an AI model. The AI is treated as a working co-developer, and its contributions were checked like everyone else's: by proof, simulation and challenge.

`lean/AnchoredEvolution/Vendor/TheRoom.lean` is a pinned, unchanged copy of `papers/the-room-learning-constitution/TheRoom.lean` at commit `a870788` of this repository. It is kept as a copy so this folder builds on its own, offline, even if the original changes.
