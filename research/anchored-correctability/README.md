# Anchored Evolution: from logical anchor to persistent correctability

This research package develops **Anchored Correctability** from one narrow logical anchor into an executable, semantic and scale-free learning model, then asks the longer-horizon question: **what lets correctability persist while the world and the network change?**

> Pairwise incompatible models cannot all be correct.

Everything beyond that is explicit. Liveness is an epistemic state; correctability is a chosen aim; correction is executable; claims have meanings over candidate worlds; tracking requires content-sensitive minimal change; exact interfaces preserve meaning; evidence can narrow the live-world set; links can fail and be repaired; and maintained correction structure consumes resources.

## Current architecture

`anchor → live worlds → executable challenge → semantic answer → content tracking → groups/networks → one transition law → dynamic evidence → operational realization → persistence/repair → SCAP invariant`

Resource economics is a cross-cutting constraint on that persistent structure and reuses the CRM ledger from PR #65.

The correction hierarchy remains:

`declared < permitted-and-revisable < responsive < answerable < tracking`

## Formal stack

| File | Role |
|---|---|
| `Anchor.lean` | Logical anchor, possible-world liveness/guarantee, structural correction skeleton |
| `Operational.lean` | Executable transitions, responsiveness, finite correction time/cost, induced correction graph |
| `Semantics.lean` | Claim meanings, perspective distortion, answerability, fixed-error and procedural self-model results |
| `Tracking.lean` | Answer graph, evidence discipline, content-sensitive minimal correction, fastest/cheapest trade-off |
| `Network.lean` | Same `Model` type for individual/group/group-of-groups; doors, relays, blind cuts, provenance |
| `SemanticComposition.lean` | Exact heterogeneous process embeddings preserving answerability, time and cost |
| `UnifiedTracking.lean` | One content-indexed transition law; process and deterministic-model tracking are instances; exact `FaithfulChannel` separated from legacy live-preserving sharpening |
| `DynamicEvidence.lean` | A challenge resolves by admitting a still-live view or by evidence that removes it |
| `ModelProcess.lean` | Two-step local executable witness |
| `RelayProcess.lean` | Explicit exactly-faithful route witness with `h + 2` unit-step/cost bound |
| `Realization.lean` | Generic graph-to-process contract; addressed content in challenge transitions; counted relays and `m*T`, `m*K` bounds |
| `Persistence.lean` | Changing-world learning law, evidence-defined shared reality, temporal link repair, reflexivity |
| `SCAP.lean` | Formal top-level Connected/Faithful/Open/Repairable/Affordable invariant and persistent-correctability theorem |
| `NetworkEconomics.lean` | Concrete topology maintenance/latency examples and CRM link-budget results |
| `Composition.lean`, `Dynamics.lean` | Structural composition and route-preserving change |
| `Bridge.lean` | Resource/upkeep bridge to the CRM ledger |
| `CumulativeReproduction.lean` | Vendored reviewed discrete CRM core for standalone build; full CRM package remains canonical in PR #65 |
| `Audit.lean` | Explicit axiom audit |

For a law-by-law synthesis, see [`METAMODEL.md`](METAMODEL.md). For the detailed theorem notes, see [`ANCHORED_CORRECTABILITY.md`](ANCHORED_CORRECTABILITY.md).

## Persistence: what is new

`Persistence.lean` adds time explicitly.

`deaf_must_be_vacuous` proves that a record fixed independently of what happens, yet required to remain in step at an open future time, must admit every still-possible world. `sealed_constraint_fails` proves the complementary statement: an invariant informative constraint fails in some possible future under open change. `learner_in_step` shows that following reliable evidence keeps a learner in step.

A member's `reality` is its prior intersected with all evidence whose source can reach it. Mutual reachability gives equal realities (`same_component_same_reality`), and strong connectivity gives one shared evidence-defined reality. Reliable evidence keeps the true world in every reality; disjoint realities therefore imply false evidence somewhere. `hidden_versus_revealed_conflict` gives a two-agent witness in which connection exposes inconsistent evidence while separation hides it.

Temporal reachability is `TReach`. If links only disappear, a split is permanent (`no_repair_split_permanent`). If every baseline link is restored within `R` steps, a baseline route of `m` links is temporally reachable within **`m*(R+1)`** steps (`repair_bounds_delay`). Strong baseline connectivity plus that bounded repair condition gives `forgiveness_turns_split_into_delay`.

`self_fulfilment_is_not_verification` formalizes the reflexive point: an observation generated whenever a narrative is complied with cannot by itself eliminate a candidate world in which the compliance occurs but the narrative's claim is false.

## SCAP is now a Lean object

`SCAP.Invariant` deliberately packages five **explicit premises** rather than claiming they all follow from the anchor:

- **Connected:** the baseline correction web is strongly connected;
- **Faithful:** every baseline edge is an exact `FaithfulChannel` on the candidate worlds;
- **Evidence-open:** public records follow supplied evidence, so reliable evidence keeps them in step;
- **Repairable:** every baseline edge returns within a bounded delay `R`;
- **Affordable:** the explicitly counted maintained correction structure fits the CRM ledger.

The stochastic condition `k*r/(p+r) > 1` is **not** the definition of SCAP repairability and is not a Lean theorem. It is a model-specific percolation threshold tested in F1 and compared with random-graph theory.

The top-level theorem `SCAP.scap_persistent_correctability` combines the current layers. Given `SCAP.Invariant`, a `Realization.Implements` contract and the existing governance premise, it establishes current Layer-1b structural correctability, an exactly faithful counted route between any pair, temporal access along that baseline route within `m*(R+1)` under bounded repair, and affordability of the maintained structure.

It intentionally keeps temporal waiting/repair distinct from a single globally-clocked `Operational.Process.Run`; concurrency and attention/capacity are still open.

## Operational realization and resources

`Realization.Implements P M E ch α T K` requires every network edge, every process state and every incoming content to have a bounded challenge/run/revision episode ending in the receiving model's own revision. Thus an `m`-hop implemented relay executes within `m*T` steps and `m*K` run cost.

This is separate from **standing maintenance**. `NetworkEconomics.lean` and the ledger specialization in `Realization.lean` constrain which topologies can be maintained. One-hop distance between every distinct pair forces a complete directed graph; a ring uses one maintained outgoing link per member but has longer routes. The current theory therefore yields a feasible region in maintenance, correction-run cost and latency, not one universal optimum.

## F1–F5 simulations

The new scoped simulations are under `sim/` and test the dynamic metamodel; they are not proofs.

- **F1:** repaired-link percolation and usable knowledge across the `k*r/(p+r)` transition.
- **F2:** disagreement-dependent break/repair and hysteresis.
- **F3:** learners versus rigid, drifting, sealed and vacuous models in a changing world.
- **F4:** selection and fragility of repair narratives under repair cost.
- **F5:** substitution between inheritance across time and links across peers.

The frozen result snapshot is `sim/results/fragmentation.json`; `sim/fragmentation_experiments.py` regenerates the F-series results and figures. E1–E8 CRM experiments remain canonical in PR #65 and are not duplicated here.

![F1–F5 summary](sim/figures/F1-F5_summary.svg)

## Verification

```bash
cd research/anchored-correctability/lean
lake build
```

GitHub Actions run `35915854514` builds the complete package from a clean checkout with Lean 4.33 core only and verifies exactly **200 audited headline results**:

- **122** depend on no axioms;
- **4** use `Classical.choice`;
- **74** use only Lean's standard `propext` / `Quot.sound` dependencies;
- **0** use `sorry` / `sorryAx`.

The new persistence layer contributes 17 audited results and `SCAP.lean` adds 8; neither adds classical logic.

## Current research boundary

The central persistence theorem now exists. The next technical gaps are to relate the process-family and addressed-content operational encodings; put repair/waiting and relay execution into one globally clocked process with concurrency/capacity constraints; generalize homogeneous time/cost/upkeep; formalize stochastic failure/repair where possible; and connect topology degradation/restoration to the CRM critical-mass/hysteresis dynamics rather than only to the ledger. Collective action remains separate from the epistemic envelope.
