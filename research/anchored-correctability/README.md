# Anchored Evolution: from logical anchor to scalable learning process

This research package develops **Anchored Correctability** from one narrow logical anchor into an executable and semantic model of learning that scales from one model to groups and networks, and connects back to the Cumulative Reproduction Model (CRM).

> Pairwise incompatible models cannot all be correct.

Everything beyond that is explicit: liveness is an epistemic state, correctability is a chosen aim, correction is an executable process, claims have meanings over candidate worlds, tracking requires content-sensitive minimal change, evidence can narrow the live-world set, and maintained correction structure consumes resources.

## Current architecture

`anchor → live worlds → executable challenge → semantic answer → content tracking → groups/networks → dynamic evidence → local compilation → executable relay routes → CRM resource persistence`

The correction hierarchy is:

`declared < permitted-and-revisable < responsive < answerable < tracking`

Dynamic evidence adds the complementary legitimate outcome: a challenge need not be accommodated if evidence actually removes that view from the live set.

## Lean files

| Path | Role |
|---|---|
| `lean/AnchoredEvolution/Anchor.lean` | Logical anchor, live/guaranteed possible-world semantics, structural correction skeleton |
| `lean/AnchoredEvolution/Operational.lean` | Executable transitions, responsiveness, finite correction time/cost, induced correction graph |
| `lean/AnchoredEvolution/Semantics.lean` | Claim meanings, perspective translation, answerability, fixed-error theorem, self-model |
| `lean/AnchoredEvolution/Tracking.lean` | Answer graph, evidence discipline, content tracking, cost/time trade-off |
| `lean/AnchoredEvolution/Network.lean` | One model type for individual/group/group-of-groups; doors, relays, blind cuts, provenance, four-person benchmark |
| `lean/AnchoredEvolution/SemanticComposition.lean` | Heterogeneous faithful process embeddings preserving answerability, time and cost across boundaries |
| `lean/AnchoredEvolution/UnifiedTracking.lean` | One relation-level tracking law; operational and deterministic network tracking are instances; exact faithfulness separated from live-preserving sharpening |
| `lean/AnchoredEvolution/DynamicEvidence.lean` | Evidence-aware resolution: admit a still-live view or acquire evidence that removes it |
| `lean/AnchoredEvolution/ModelProcess.lean` | Two-step compiler from a scale-free model revision into an executable process |
| `lean/AnchoredEvolution/RelayProcess.lean` | Executable multi-hop faithful relay routes; route length becomes correction time and run cost |
| `lean/AnchoredEvolution/Composition.lean` | Structural composition, ring witness, non-absorption, recursive scale invariance |
| `lean/AnchoredEvolution/Dynamics.lean` | Structural correctability through restrictions/restorations over time |
| `lean/AnchoredEvolution/Bridge.lean` | Resource/upkeep bridge from correction structure to CRM ledger |
| `lean/AnchoredEvolution/Witness.lean` | Non-vacuity witnesses |
| `lean/AnchoredEvolution/CumulativeReproduction.lean` | Vendored reviewed discrete CRM core for standalone build |
| `lean/AnchoredEvolution/Vendor/TheRoom.lean` | Verbatim compatibility copy of `TheRoom.lean` from commit `a870788` |
| `lean/AnchoredEvolution/Audit.lean` | Explicit axiom audit |

The reviewed CRM theory, stochastic experiments and figures remain canonical in PR #65.

## One tracking law across scales

`UnifiedTracking.lean` gives both process-based `Tracking.Tracks` and deterministic `Network.Model.Tracking` one common **content-indexed transition law**:

1. if incoming content is live, at least one correction outcome admits it;
2. every correction outcome changes the public record minimally toward that content.

A person is the one-member group (`solo_tracking_iff`); tracking groups close under grouping when every live content has a door (`group_tracks`); the same constructor recurses to arbitrary depth (`sound_tree_tracks`).

The legacy `Network.Honest` condition is retained for compatibility but is mathematically only **live-preserving sharpening**. Exact semantic transport is `FaithfulChannel`, which preserves compatibility and incompatibility both ways. Translation alone therefore cannot create or erase disagreement under the exact condition.

## Evidence-aware resolution

`DynamicEvidence.ResolvedAt` resolves a challenge when either the later record admits the view or the view is no longer live. `resolution_is_admission_or_evidence` proves that, under `EvidenceDiscipline`, a live initial view is resolved either by semantic admission or along a route containing an actual evidence-presenting step. If the view remains live, `live_dynamic_resolution_requires_admission` forces admission.

## Operational realization and relay cost

`ModelProcess.lean` compiles a local model revision into challenge + revision, giving a two-step, cost-two answer bound for a tracked live view.

`RelayProcess.lean` extends this to multi-hop communication. For an explicit route of `h` exactly faithful channels, the executable run contains:

- one challenge step;
- `h` relay steps;
- one receiver revision step.

`answerWithin_route` therefore proves a tracked live source view is answered within **`h + 2` steps and `h + 2` cost units** in the unit-cost baseline. `faithfulRoute_iff` proves the relayed content has exactly the same truth value as the source content on candidate worlds. This is the first theorem in the project where network distance, semantic answerability, and operational resource cost occur in the same object.

The route is currently supplied explicitly as a list of channels. The existing graph-indexed `Network.Relay` proof is not yet automatically compiled into that route, so the result should not be read as an automatic quantitative theorem for every structural graph path yet.

## Reproduce

```bash
cd research/anchored-correctability/lean
lake build
```

GitHub Actions run `35871863420` builds the complete package with Lean 4.33 core only. The audit now contains **139 headline results**:

- **102 depend on no axioms at all**;
- **4 use `Classical.choice`**;
- the remaining **33** use only Lean's standard `propext` / `Quot.sound` dependencies;
- no `sorry` / `sorryAx` is present.

## Current research boundary

The semantic law is unified, evidence-aware, locally executable, and executable over an explicit faithful multi-hop route. The remaining quantitative gaps are now narrower:

1. derive the operational channel list automatically from a graph-indexed `Network.Relay` witness;
2. replace the unit-cost baseline with heterogeneous relay/revision costs;
3. distinguish **per-run correction cost** from **standing link-maintenance cost**;
4. add stochastic reliability;
5. use those quantities to connect topology to the CRM budget and, later, to hysteresis/critical-mass dynamics.

The natural comparison object is therefore a frontier such as `(maintenance cost, correction-run cost, latency, reliability)`, rather than a single correction-cost scalar. The group union record remains an epistemic envelope, not a collective action rule.
