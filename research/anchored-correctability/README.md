# Anchored Evolution: correctability and cumulative reproduction

The package has two connected parts.

1. **[`ANCHORED_CORRECTABILITY.md`](ANCHORED_CORRECTABILITY.md): the model built up from its one certainty.**
   - It starts from the anchor: incompatible models cannot all be correct.
   - It adds only named premises (liveness and the aim).
   - It derives the relational skeleton, executable responsiveness, semantic answerability, preservation of answerability across faithful process boundaries, structural composition, correctability through time, and the economic ceiling on mutual correctability.
2. **[`THEORY.md`](THEORY.md): the Cumulative Reproduction Model.**
   - It gives the law of whether and how fast retained organization runs away, levels off, or collapses.
   - Its terms are R_c, the critical mass, the budget ceiling and the speed class.

The two meet in `lean/AnchoredEvolution/Bridge.lean`. The correction network is itself retained organization, so it obeys the same budget law.

## Contents

| Path | What |
|---|---|
| `ANCHORED_CORRECTABILITY.md` | Layer-by-layer construction from the anchor, premise ledger, theorem map, limits |
| `THEORY.md` | Cumulative Reproduction Model: laws, evidence, predictions, limits |
| `lean/AnchoredEvolution/Anchor.lean` | Layer 0 (the anchor) and Layer 1 (the relational skeleton it forces) |
| `lean/AnchoredEvolution/Operational.lean` | Layer 1b: permissions, availability and correction cost derived from executable steps; responsiveness; joins the Room's constitution, `ConstitutionAccessibility` and the correction graph into one transition system |
| `lean/AnchoredEvolution/Semantics.lean` | Layer 1c: claims get meanings over candidate worlds; the anchor applies to represented claims; perspective translations (the elephant, formally); answering vs responding; unanswerable challenges fix errors; the metamodel under its own anchor |
| `lean/AnchoredEvolution/SemanticComposition.lean` | Layer 3b: heterogeneous member→group translations and faithful process embeddings; semantic compatibility, runs, admission, answerability, time and cost are preserved across a boundary, and the same theorem reuses across two levels |
| `lean/AnchoredEvolution/Vendor/TheRoom.lean` | Verbatim copy of the repository's `TheRoom.lean` (commit `a870788`), reused unchanged |
| `lean/AnchoredEvolution/Composition.lean` | Layer 2 (every model sends and receives; ring) and Layer 3 (structural composition at any depth, interdependence, non-absorption) |
| `lean/AnchoredEvolution/Dynamics.lean` | Layer 4 (a restriction is legitimate iff correction can route around it; invariance through time) |
| `lean/AnchoredEvolution/Bridge.lean` | Layer 5 (upkeep of correctability; correctable-population ceiling) |
| `lean/AnchoredEvolution/Witness.lean` | Non-vacuity: a room of three; a three-level, twelve-model system |
| `lean/AnchoredEvolution/CumulativeReproduction.lean` | Discrete-time core of the reproduction model |
| `lean/AnchoredEvolution/Audit.lean` | Axiom audit of 74 headline results |
| `sim/` | Exact stochastic simulation for the reproduction model (E1–E8), results and figures |

## Reproduce

```bash
cd lean && lake build            # Lean 4.33 core only, offline; prints the axiom audit
cd sim  && python experiments.py # about 2.5 min; --quick for a smoke test
```

**Audit summary (verified in CI):**
- 56 of the 74 audited results depend on no axioms at all;
- two use classical logic: `anchor_all_but_one_wrong`, and `room_applies_to_represented_claims` (inherited from `TheRoom.lean`'s proof);
- the remaining 16 use only `propext` / `Quot.sound`;
- there is no `sorry`.

## Current research boundary

The generic semantic boundary law is now machine checked: a faithful translation plus step/record/cost preservation carries answerability from a member process into a containing process, and the same law composes through two levels. What is not yet built is the **concrete group-process constructor** that takes component processes plus explicit interface steps and proves that it supplies such an embedding. That is the next target. Dynamic evidence comes after that: a challenge should ultimately be answerable either by revising the record to admit a still-live view or by new evidence that genuinely removes that view from the live set.
