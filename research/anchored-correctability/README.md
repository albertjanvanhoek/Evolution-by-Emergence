# Anchored Evolution: from logical anchor to scalable learning process

This research package develops **Anchored Correctability** from one narrow logical anchor into an executable and semantic model of learning that scales from one model to groups and networks, and connects back to the Cumulative Reproduction Model (CRM).

The anchor is:

> Pairwise incompatible models cannot all be correct.

Everything beyond that is kept explicit: liveness is an epistemic state, correctability is a chosen aim, correction is an executable process, claims have meanings over candidate worlds, and resource limits enter only at the ledger layer.

## Current architecture

The development now has one connected chain:

`anchor → live worlds → executable challenge → semantic answer → content tracking → groups/networks → dynamic evidence → local operational compilation → network time/cost → resource persistence`

The important correction hierarchy is:

`declared < permitted-and-revisable < responsive < answerable < tracking`

- **Declared**: an interface says challenge/revision are available.
- **Permitted and revisable**: the challenge really executes and some revision is reachable.
- **Responsive**: a run beginning with the challenge reaches revision.
- **Answerable**: that run reaches a record that admits the challenger's still-live view.
- **Tracking**: the response depends on what was said and changes the record only as far as the incoming content warrants.

Dynamic evidence adds the complementary legitimate outcome: a challenge need not be accommodated if new evidence actually removes the challenged view from the live set.

## Lean files

| Path | Role |
|---|---|
| `lean/AnchoredEvolution/Anchor.lean` | Logical anchor, live/guaranteed possible-world semantics, structural correction skeleton |
| `lean/AnchoredEvolution/Operational.lean` | Executable transitions, responsiveness, finite correction time/cost, induced correction graph |
| `lean/AnchoredEvolution/Semantics.lean` | Claim meanings, perspective translation, answerability, fixed-error theorem, self-model |
| `lean/AnchoredEvolution/Tracking.lean` | Answer graph, evidence discipline, content tracking, cost/time trade-off |
| `lean/AnchoredEvolution/Network.lean` | One model type for individual/group/group-of-groups; doors, relays, blind cuts, provenance, four-person benchmark |
| `lean/AnchoredEvolution/SemanticComposition.lean` | Heterogeneous faithful process embeddings preserving answerability, time and cost across boundaries |
| `lean/AnchoredEvolution/UnifiedTracking.lean` | One relation-level tracking law; proves operational tracking and deterministic network tracking are instances; separates exact faithfulness from live-preserving sharpening |
| `lean/AnchoredEvolution/DynamicEvidence.lean` | Evidence-aware resolution: admit a still-live view or acquire evidence that removes it |
| `lean/AnchoredEvolution/ModelProcess.lean` | Concrete two-step compiler from a scale-free model revision into an executable process with explicit time/cost |
| `lean/AnchoredEvolution/Composition.lean` | Structural composition, ring witness, non-absorption, recursive scale invariance |
| `lean/AnchoredEvolution/Dynamics.lean` | Structural correctability through restrictions/restorations over time |
| `lean/AnchoredEvolution/Bridge.lean` | Resource/upkeep bridge from correction structure to CRM ledger |
| `lean/AnchoredEvolution/Witness.lean` | Non-vacuity witnesses |
| `lean/AnchoredEvolution/CumulativeReproduction.lean` | Vendored reviewed discrete CRM core for standalone build |
| `lean/AnchoredEvolution/Vendor/TheRoom.lean` | Verbatim compatibility copy of `TheRoom.lean` from commit `a870788` |
| `lean/AnchoredEvolution/Audit.lean` | Explicit axiom audit |

The reviewed CRM theory, stochastic experiments and figures remain canonical in PR #65; this package only vendors the discrete Lean core needed for the bridge and standalone build.

## What is now formally unified

`UnifiedTracking.lean` removes an important duplication. The process-based `Tracking.Tracks` and the scale-free `Network.Model.Tracking` are both instances of one **content-indexed transition law**:

1. if incoming content is still live, at least one correction outcome admits it;
2. every correction outcome changes the public record minimally toward that content.

For executable processes, the possible outcomes are the states reachable after the challenge. For a `Network.Model`, there is one deterministic outcome, `revise s v`. Thus “one person”, “group”, and “group of groups” no longer rely on a second tracking principle.

The interface terminology is also sharpened. `Network.Honest` is retained for compatibility, but mathematically it is a **live-preserving sharpening** condition: it may narrow the content while keeping it live. Exact semantic transmission is now `UnifiedTracking.FaithfulChannel`, inherited from `SemanticComposition.HFaithful`. Exact faithfulness preserves compatibility and incompatibility both ways, so translation alone cannot manufacture or erase a conflict.

## Scaling result

A person is the one-member group (`solo_tracking_iff`). A group of tracking members tracks when every live content has a door (`group_tracks`). The same constructor recurses to arbitrary depth (`sound_tree_tracks`). Strongly connected relay networks preserve tracking when their interfaces satisfy the stated channel condition; blind cuts destroy the ability to track rival content across the boundary.

The group record is best read as an **epistemic envelope**: it is the union of worlds admitted by its members. It is not yet a collective action rule. Likewise, `aggregation_under_anchor` concerns literal intersection of mutually incompatible complete views; it is not a claim that ordinary deliberative consensus is generally false.

## Evidence-aware resolution

The fixed-candidate semantics has now been extended. `DynamicEvidence.ResolvedAt` treats a challenge as resolved when either:

- the later record admits the view; or
- the view is no longer live under the later evidence state.

`resolution_is_admission_or_evidence` proves that, when the view was live initially and candidate worlds obey `EvidenceDiscipline`, a reachable resolution is either semantic admission or includes an actual evidence-presenting step. `live_dynamic_resolution_requires_admission` prevents the mere occurrence of unrelated evidence from substituting for answering a view that remains live.

## Executable realization of a model

`ModelProcess.lean` now closes the first operational gap. A scale-free `Network.Model` can be compiled into an actual `Operational.Process` for a fixed incoming content:

1. the challenge executes (`idle → heard`), cost 1;
2. the model applies its own `revise` rule (`heard → done`), cost 1.

If the abstract model tracks a live view, the compiled process tracks that view (`compiled_tracks_of_live`) and answers it within two steps at total cost two (`compiled_answerWithin_two`). This is a local-model compiler; it does not yet count the relay hops needed to get content from one model to another.

## Reproduce

```bash
cd research/anchored-correctability/lean
lake build
```

The current GitHub Actions checkpoint builds with Lean 4.33 core only. The audit contains **128 headline results**:

- **96 depend on no axioms at all**;
- **4 use `Classical.choice`**;
- the remaining **28** use only Lean's standard `propext` / `Quot.sound` dependencies;
- no `sorry` / `sorryAx` is present.

## Current research boundary

The semantic law is unified, evidence-aware, and locally executable. The remaining gap is now genuinely **network operationalization**: relay hops are still semantic `Relay` objects rather than steps in the executable process. Consequently hop-count latency, relay cost, reliability, and concrete link-maintenance cost are not yet derived from the same run.

The next technical target is therefore to compile a **relay route plus a receiving model** into an operational run, prove that exact faithful channels preserve the incoming content along that run, and derive correction time/cost from route length. That is the point at which ring, flat and hierarchical topologies can be compared quantitatively and then connected rigorously to the CRM budget/hysteresis layer.
