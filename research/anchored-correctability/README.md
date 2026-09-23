# Anchored Evolution: from logical anchor to scalable learning process

This research package develops **Anchored Correctability** from one narrow logical anchor into an executable and semantic model of learning that scales from one model to groups and networks, and connects back to the Cumulative Reproduction Model (CRM).

The anchor is:

> Pairwise incompatible models cannot all be correct.

Everything beyond that is kept explicit: liveness is an epistemic state, correctability is a chosen aim, correction is an executable process, claims have meanings over candidate worlds, and resource limits enter only at the ledger layer.

## Current architecture

The development now has one connected chain:

`anchor → live worlds → executable challenge → semantic answer → content tracking → groups/networks → dynamic evidence → time/cost → resource persistence`

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

## Reproduce

```bash
cd research/anchored-correctability/lean
lake build
```

The current GitHub Actions checkpoint builds with Lean 4.33 core only. The audit contains **122 headline results**:

- **92 depend on no axioms at all**;
- **4 use `Classical.choice`**;
- the remaining **26** use only Lean's standard `propext` / `Quot.sound` dependencies;
- no `sorry` / `sorryAx` is present.

## Current research boundary

The semantic law is now unified and evidence-aware, but three important layers remain distinct.

First, the scale-free `Network.Model` still uses an abstract revision function; it has not yet been compiled into the full `Operational.Process` with explicit relay steps and costs. Second, relay hop count, latency, reliability and link-maintenance cost are not yet part of the network theorems. Third, the union record is an epistemic envelope, not a rule for selecting one collective action.

The next technical target is therefore to construct an **operational network process** from models plus interfaces, prove that it realizes the unified tracking law, and then derive correction latency and maintenance cost from actual relay paths. That is the point at which the network topology can be connected rigorously to the CRM budget/hysteresis layer.
