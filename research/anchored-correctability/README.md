# Anchored Correctability

This research checkpoint formalizes the line that grows from **The Room** and the **Learning Constitution**.

The construction begins with one logical anchor: pairwise incompatible models cannot all be correct. It then names, rather than hides, the two premises needed to move from that fact to a system architecture:

1. **Liveness:** each model not yet refuted by evidence is correct in at least one candidate world still open.
2. **Correctability aim:** whichever candidate world is actual, correction from its correct model must be able to reach every model in the shared system.

The Lean development derives the resulting correction architecture, shows that it composes recursively across scales, characterizes which restrictions preserve correctability through time, and connects the upkeep of correction routes to the Cumulative Reproduction budget law.

## Why this is a separate checkpoint

The Cumulative Reproduction Model is tracked and reviewed in PR #65 (`research/cumulative-reproduction/`). This directory records the **new anchored development** without duplicating that model's theory, simulations, or figures. A local copy of its Lean discrete core is retained only so that this package builds independently; `Bridge.lean` is the formal interface between the two lines of work.

The older `TheRoom.lean` used a factual reading of truth guarantee. This checkpoint replaces that step with a possible-world reading: a model is guaranteed only if it is correct in every world left open by the evidence. The change matters because the premises can then hold even when one participant is in fact right, rather than making the central Room case vacuous.

## Structure

- `ANCHORED_CORRECTABILITY.md` — premise ledger, layer map, theorem meanings, limits and next questions.
- `lean/AnchoredEvolution/Anchor.lean` — logical anchor, liveness/guarantee semantics, and the forced correction skeleton.
- `lean/AnchoredEvolution/Composition.lean` — minimal architecture, composition, nesting, interdependence and non-absorption.
- `lean/AnchoredEvolution/Dynamics.lean` — correctability through time; restrictions are admissible exactly when old correction routes remain realizable directly or by detour.
- `lean/AnchoredEvolution/Bridge.lean` — budget cost of maintaining mutually correctable networks.
- `lean/AnchoredEvolution/Witness.lean` — non-vacuity witnesses at one and several levels.
- `lean/AnchoredEvolution/Audit.lean` — axiom audit of the headline results.
- `lean/AnchoredEvolution/CumulativeReproduction.lean` — local discrete core used by the bridge; the reviewed research package in PR #65 remains canonical for the CRM itself.

## Reproduce

```bash
cd lean
lake build
```

The package uses Lean 4.33 core only, no Mathlib, and contains no `sorry`. The audit currently covers 36 headline results: 25 use no axioms, one explicitly uses classical logic, and the remainder use Lean's standard `propext` / `Quot.sound` dependencies.

## Research frontier

This PR is intentionally a working branch. The current formalization establishes **existence of correction routes**, not their speed, reliability, evidential quality or weight. The immediate open fronts are the cost–latency/reliability frontier, graded correctness and apparent incompatibility, evidence dynamics that update liveness, weighted credibility without structurally zeroing standing, and a machine-checked bridge from correctability loss to the CRM critical-mass/hysteresis dynamics.
