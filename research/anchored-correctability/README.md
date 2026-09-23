# Anchored Evolution: from logical anchor to persistent correctable intelligence

This research package develops **Anchored Correctability** as the current intelligent-system specialization of Evolution by Emergence. It is not the universal EbE core: it adds explicit epistemic objects such as claims, candidate worlds, evidence, challenge, answerability and correction.

> Pairwise incompatible models cannot all be correct.

Everything beyond that is explicit: liveness is an epistemic state, correctability is a chosen aim, correction is an executable process, claims have meanings over candidate worlds, tracking requires content-sensitive minimal change, evidence can narrow the live-world set, exact interfaces preserve meaning, maintained correction structure consumes resources, and persistence under change requires bounded repair.

## Scope relative to Evolution by Emergence

The universal EbE theory asks how retained organization changes future transition machinery and accessibility under finite resources. This package specializes that architecture to **intelligences / learning systems** by adding semantics and evidence. The intended correspondence is structural, but this package does not prove that every universal EbE system instantiates these epistemic semantics.

## Current architecture

`anchor → live worlds → executable challenge → semantic answer → content tracking → groups/networks → unified transition law → dynamic evidence → operational realization → persistence/repair → SCAP`

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
| `lean/AnchoredEvolution/Persistence.lean` | Changing-world learning law, evidence-defined shared reality, temporal repair, reflexivity |
| `lean/AnchoredEvolution/SCAP.lean` | Formal top-level invariant: Connected, Faithful, Evidence-open, Repairable, Affordable |
| `lean/AnchoredEvolution/NetworkEconomics.lean` | Four-person maintenance/latency benchmark and link-count CRM ledger results |
| `lean/AnchoredEvolution/Composition.lean` | Structural composition, ring witness, non-absorption, recursive scale invariance |
| `lean/AnchoredEvolution/Dynamics.lean` | Structural correctability through restrictions/restorations over time |
| `lean/AnchoredEvolution/Bridge.lean` | Resource/upkeep bridge from correction structure to CRM ledger |
| `lean/AnchoredEvolution/Witness.lean` | Non-vacuity witnesses |
| `lean/AnchoredEvolution/CumulativeReproduction.lean` | Vendored reviewed discrete CRM core for standalone build; canonical source is `research/cumulative-reproduction/lean/CumulativeReproduction.lean` in the parent repository |
| `lean/AnchoredEvolution/Vendor/TheRoom.lean` | Verbatim compatibility copy of `TheRoom.lean` from commit `a870788` |
| `lean/AnchoredEvolution/Audit.lean` | Explicit axiom audit |

The reviewed CRM theory, stochastic experiments and figures remain canonical in `research/cumulative-reproduction/` (PR #65 lineage).

## One tracking law across scales

`UnifiedTracking.lean` gives both process-based `Tracking.Tracks` and deterministic `Network.Model.Tracking` one common **content-indexed transition law**:

1. if incoming content is live, at least one correction outcome admits it;
2. every correction outcome changes the public record minimally toward that content.

A person is the one-member group (`solo_tracking_iff`); tracking groups close under grouping when every live content has a door (`group_tracks`); the same constructor recurses to arbitrary depth (`sound_tree_tracks`).

The legacy `Network.Honest` condition is retained for compatibility but is mathematically only **live-preserving sharpening**. Exact semantic transport is `FaithfulChannel`, which preserves compatibility and incompatibility both ways.

## Persistence and SCAP

`Persistence.lean` adds open change, evidence-defined reality and time-varying communication. It proves that a fixed informative record cannot remain correct under every open future, that reliable evidence keeps a learner in step, that mutually reachable agents share the same evidence-defined reality, that hidden cuts can conceal incompatible evidence, and that bounded repair turns structural separation into bounded delay.

`SCAP.lean` packages the theorem-level persistence conditions as one explicit conjunction:

`Connected ∧ Faithful ∧ Evidence-open ∧ Repairable ∧ Affordable`.

`scap_persistent_correctability` combines current Layer-1b correctability, exactly faithful baseline relay, bounded temporal restoration `m*(R+1)`, and affordability of the maintained correction structure. It deliberately does not collapse temporal waiting into a single globally-clocked concurrent `Operational.Process.Run`.

## Reproduce

```bash
cd research/anchored-correctability/lean
lake build
```

The branch CI builds the complete package with Lean 4.33 core only and rejects `sorryAx` on the audited surface.

## Current research boundary

The main remaining gaps are:

1. prove the relationship between the two operational content encodings (`Tracking`/`ModelProcess` versus addressed content in `Realization`);
2. put repair/waiting and executable relay into one globally-clocked concurrent process;
3. add capacity/attention constraints and heterogeneous costs;
4. derive stronger stochastic failure/repair results where justified;
5. connect topology degradation/restoration to CRM critical-mass/hysteresis, rather than only to the shared affordability ledger;
6. keep collective action separate from the epistemic envelope.
