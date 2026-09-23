# Anchored Evolution: from logical anchor to scalable learning process

This research package develops **Anchored Correctability** from one narrow logical anchor into an executable and semantic model of learning that scales from one model to groups and networks, and connects back to the Cumulative Reproduction Model (CRM).

> Pairwise incompatible models cannot all be correct.

Everything beyond that is explicit: liveness is an epistemic state, correctability is a chosen aim, correction is an executable process, claims have meanings over candidate worlds, tracking requires content-sensitive minimal change, evidence can narrow the live-world set, and maintained correction structure consumes resources.

## Current architecture

`anchor → live worlds → executable challenge → semantic answer → content tracking → groups/networks → dynamic evidence → local compilation → executable relay routes → topology economics → CRM resource persistence`

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
| `lean/AnchoredEvolution/NetworkEconomics.lean` | Separates standing link maintenance from per-run correction cost/latency and connects link count to the CRM ledger |
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

## Operational realization, relay cost, and topology

`ModelProcess.lean` compiles a local model revision into challenge + revision, giving a two-step, cost-two answer bound for a tracked live view.

`RelayProcess.lean` extends this to multi-hop communication. For an explicit route of `h` exactly faithful channels, the executable run contains one challenge, `h` relay steps, and one receiver revision. `answerWithin_route` proves a tracked live source view is answered within **`h + 2` steps and `h + 2` cost units** in the unit-cost baseline.

`NetworkEconomics.lean` then separates that per-run quantity from **standing link maintenance**. In the four-person witness:

- flat everyone-to-everyone: **12 directed links**, maximum relay distance **1**, worst-case correction latency **3** process steps;
- two linked pairs: **6 directed links**, maximum relay distance **3**, worst-case correction latency **5** process steps.

Under homogeneous per-link upkeep, the paired architecture therefore uses exactly half the standing maintenance while adding two worst-case correction steps. This makes the earlier qualitative statement precise: hierarchy need not destroy tracking, but it can trade maintained structure for relay distance.

The same file connects maintained link count to the CRM ledger. With net-cost links (`eta < mu`), an affordable architecture cannot exceed `Ledger.cap`; if the cap lies between 6 and 11, the six-link paired architecture can be affordable while the twelve-link flat architecture is not (`paired_fits_when_flat_does_not`). If links are self-financing (`mu <= eta`), the ledger imposes no link-count ceiling.

The route is still supplied explicitly as a list of channels. The graph-indexed `Network.Relay` witness is not yet automatically compiled into that route.

## Reproduce

```bash
cd research/anchored-correctability/lean
lake build
```

GitHub Actions run `35900290050` builds the complete package with Lean 4.33 core only. The audit now contains **148 headline results**:

- **105 depend on no axioms at all**;
- **4 use `Classical.choice`**;
- the remaining **39** use only Lean's standard `propext` / `Quot.sound` dependencies;
- no `sorry` / `sorryAx` is present.

## Current research boundary

The semantic law is unified, evidence-aware, locally executable, executable over explicit faithful multi-hop routes, and now has a first machine-checked maintenance/latency/ledger comparison. The remaining quantitative gaps are narrower:

1. derive the operational channel list automatically from a graph-indexed `Network.Relay` witness;
2. replace unit step/link costs with heterogeneous transmission, deliberation, revision and maintenance costs;
3. add stochastic reliability and failure/repair;
4. connect the resulting topology-dependent quantities to CRM critical-mass/hysteresis dynamics;
5. separately add a collective action rule on top of the epistemic envelope without collapsing epistemic openness into action selection.

The natural comparison object is a frontier `(maintenance cost, correction-run cost, latency, reliability)`, rather than a single correction-cost scalar.
