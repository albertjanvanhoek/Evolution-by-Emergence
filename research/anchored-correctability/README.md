# Anchored Evolution: from logical anchor to scalable learning process

This research package develops **Anchored Correctability** from one narrow logical anchor into an executable and semantic model of learning that scales from one model to groups and networks, and connects back to the Cumulative Reproduction Model (CRM).

> Pairwise incompatible models cannot all be correct.

Everything beyond that is explicit: liveness is an epistemic state, correctability is a chosen aim, correction is an executable process, claims have meanings over candidate worlds, tracking requires content-sensitive minimal change, evidence can narrow the live-world set, and maintained correction structure consumes resources.

## Current architecture

`anchor → live worlds → executable challenge → semantic answer → content tracking → groups/networks → unified transition law → dynamic evidence → operational realization → topology economics → CRM resource persistence`

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
| `lean/AnchoredEvolution/ModelProcess.lean` | Two-step local compiler from a model revision into an executable process |
| `lean/AnchoredEvolution/RelayProcess.lean` | Explicit exactly-faithful channel-list realization with `h + 2` step/cost bound |
| `lean/AnchoredEvolution/Realization.lean` | Generic graph-indexed realization: content lives in the challenge step, graph hops become Layer-1b corrections, relay length gives time/cost bounds, and ring/flat topology is tied to the ledger |
| `lean/AnchoredEvolution/NetworkEconomics.lean` | Four-person maintenance/latency benchmark and link-count CRM ledger results |
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

## Operational realization

Three related constructions now meet at the operational boundary.

`ModelProcess.lean` is the local witness: for a fixed incoming content, a tracking model compiles to challenge + revision and answers within two steps and cost two.

`RelayProcess.lean` is the explicit exactly-faithful route witness: for a supplied list of `h` faithful channels, one challenge, `h` relay steps and one receiver revision answer the source view within **`h + 2` steps and `h + 2` cost units**.

`Realization.lean` is the generic network interface. Its process claim is an addressed pair `(j, u)`, so the challenged content is carried in the transition itself rather than being an index on a family of processes. `Episode` is one challenge/run/revision hop. `Implements P M E ch α T K` says that every network edge, from every process state and for every incoming content, has such an episode bounded by `T` steps and `K` cost, ending in the receiving model's own revision.

The main consequences are:

- `implemented_hop_within`: each implemented network edge is an actual Layer-1b `CorrectionWithin`;
- `implemented_correctable`: if the implemented graph is strongly connected and the addressed records are governed, the actual process correction system is structurally correctable;
- `relay_run`: an `m`-hop implemented relay executes as one process run in at most `m·T` steps and `m·K` cost;
- `voice_admitted_within`: the original live-preserving-sharpening interface theorem;
- `voice_admitted_within_faithful`: the stronger architectural wrapper requiring exact `FaithfulChannel` transmission;
- `canonical_implements`: every network of models has a non-vacuous two-step, cost-two implementation per hop.

Exact-faithfulness wrappers are also provided for the solo, flat and ring instances. The original `Honest` theorems are retained because they are mathematically stronger in applicability, but exact faithfulness is the condition used when the claim is that another model's meaning is preserved.

## Topology, latency and upkeep

`Realization.lean` adds general counted-route theorems. In a directed ring of `n + 1` members, the route from member 0 to member `n` has exactly `n` hops (`ring_latency_lower`, `ring_latency_attained`), while one-hop distance between every distinct pair forces the complete directed graph (`latency_one_forces_complete`). For an implemented ring, every live voice reaches every other member within `n·T` process steps and `n·K` cost.

Its ledger specialization uses `d` maintained links per member. A ring has `d = 1`; the complete directed network has `d = N - 1`. The Lean result `flat_ceiling` is stated under positive per-link upkeep and per-member return: with `N` members, complete-network upkeep scales as `(N - 1)·μ·N`, while available budget is `B0 + η·N`. `latency_upkeep_frontier` combines the exact ring hop bound, one-hop complete-network requirement, and these affordability conditions.

`NetworkEconomics.lean` keeps the complementary concrete four-person benchmark:

- flat everyone-to-everyone: **12 directed links**, maximum relay distance **1**, worst-case correction latency **3** process steps;
- two linked pairs: **6 directed links**, maximum relay distance **3**, worst-case correction latency **5** process steps.

Under homogeneous per-link upkeep, the paired architecture therefore uses exactly half the standing maintenance while adding two worst-case correction steps. With net-cost links (`eta < mu`), its link-count bridge also gives a concrete CRM-cap witness: a six-link paired architecture can fit in a regime where a twelve-link flat architecture cannot.

## Reproduce

```bash
cd research/anchored-correctability/lean
lake build
```

GitHub Actions run `35909573951` builds the complete package with Lean 4.33 core only and verifies **175 headline audit results**:

- **105 depend on no axioms at all**;
- **4 use `Classical.choice`**;
- the remaining **66** use only Lean's standard `propext` / `Quot.sound` dependencies;
- no `sorry` / `sorryAx` is present.

The 27 audited `Realization` results—including the four exact-faithfulness wrappers—introduce no additional classical logic.

## Current research boundary

The generic graph-to-process bridge is now present, so the main remaining gaps are no longer simply “make a graph executable.” The next targets are:

1. prove the relationship between the two operational encodings: `Tracking`/`ModelProcess` content indexed at the process level versus `Realization` content carried directly in each challenge step, and relate `RelayProcess`'s explicit faithful channel list to `Realization.RelayN`;
2. replace homogeneous hop/link bounds with heterogeneous transmission, deliberation, revision and maintenance costs;
3. add concurrency, capacity/attention constraints, stochastic reliability, failure and repair;
4. connect topology degradation/restoration to CRM critical-mass and hysteresis dynamics rather than only to the shared ledger;
5. separately add a collective action rule on top of the epistemic envelope without collapsing epistemic openness into action selection.

The natural comparison object remains a frontier `(maintenance cost, correction-run cost, latency, reliability)`, rather than a single correction-cost scalar.
