# Anchored Correctability — technical map

**Status:** active formal research development, Lean 4 core only (no Mathlib).

**Current verified checkpoint:** **227 audited headline results**; no `sorry` / `sorryAx`. The new common-ground results `informative_content_has_live_rival` and `shareable_iff_rules_out_nothing` are axiom-free; `agreement_witness` uses only `propext`. Verified by GitHub Actions run `36046071150`.

This file is the layer-by-layer technical map. `METAMODEL.md` is the synthesis; the Lean sources and `Audit.lean` are authoritative for proved claims.

---

## 0. Explicit premise discipline

The starting anchor is narrow:

> Pairwise incompatible models cannot all be correct.

The rest of the theory is conditional on named additions rather than being smuggled into that sentence:

- **liveness:** a view remains true in at least one candidate world left open by evidence;
- **correctability aim:** if a live view is the correct one, its correction should remain able to reach the system;
- **execution:** challenge, evidence, response, revision, repair and appeal are transitions;
- **semantics:** claims denote sets of candidate worlds;
- **tracking:** correction responds to the supplied content and changes the public record minimally toward it;
- **faithful interfaces:** exact translation preserves meaning on candidate worlds;
- **change/persistence:** the future world and the communication graph can change;
- **repair:** baseline correction links may fail but can be restored within a stated bound;
- **resources:** maintained correction structure and correction runs consume a finite ledger.

No normative conclusion follows from the anchor alone. The correctability and persistence aims are explicit premises/filters.

---

## 1. Logical and structural anchor

`Anchor.lean` separates factual truth from epistemic guarantee. `Live` means a model is right in some candidate world; `Guaranteed` means it is right in all candidate worlds. A live incompatible rival blocks guarantee (`live_rival_blocks_guarantee`, `open_room_no_guarantee`).

Adding the chosen `CorrectabilityAim` turns the possible-world uncertainty into a structural requirement. `live_and_aim_force_strong_connectivity` derives a strongly connected correction skeleton; `missing_route_leaves_uncorrectable_error` gives the corresponding failure witness.

The older graph result is deliberately abstract: it says correction transport must remain possible, not how an actual challenge changes an actual state.

---

## 2. Layer 1b — executable correction (`Operational.lean`)

`Operational.Process` makes transitions primary. Declared permission is derived from executable steps, and finite correction time/cost are properties of actual runs.

This exposes several separations:

`declared < permitted-and-revisable < responsive`

`paper_constitution` shows declarations can be true while nothing executes. `heard_but_unanswerable` shows an executable challenge can enter a dead end even though revision is independently reachable. `CorrectionWithin` and `Responsive` require the challenge and later revision to lie on the same run.

The process induces a structural correction graph, so the graph becomes an abstraction of executable behavior rather than a primitive assertion.

---

## 3. Layer 1c — meaning and answerability (`Semantics.lean`)

Claims acquire meanings over candidate worlds. Holding a claim and that claim being true are different predicates.

Faithful translation preserves incompatibility. Strengthening another model's partial claim can manufacture disagreement (`overgeneralization_manufactures_conflict`); weakening can hide it (`caricature_dissolves_conflict`). This is why later architectural claims use exact semantic faithfulness rather than mere transmission of some live sharpening.

`Answerable` strengthens responsiveness: after the challenge, a reachable record admits the challenger's still-live view. `revised_but_unanswered` proves that revision alone is insufficient.

The core fixed-error result is `unanswerable_challenge_fixes_error`, strengthened by the non-vacuous `executable_unanswerable_challenge_fixes_error`: a live executable challenge that cannot be answered leaves open a world in which the challenged view is right and the decision remains wrong throughout the post-challenge reachable states.

Procedural self-models remain ordinary claims. `self_model_not_guaranteed` and `sealed_rule_fixes_error` put the correction mechanism under its own correction conditions.

---

## 4. Layer 1d — tracking and evidence (`Tracking.lean`, `DynamicEvidence.lean`)

Answerability can still be vacuous if a system simply opens its record to everything. Tracking therefore adds a minimality/content condition:

`responsive < answerable < tracking`.

`content_insensitive_cannot_track` shows that incompatible rival contents cannot both be tracked by a correction mechanism that behaves identically to both. `always_inclusive_answers_but_does_not_track` separates universal accommodation from content-sensitive learning.

`EvidenceDiscipline` governs candidate-world removal. `scenario_removed_only_by_evidence` proves that a world that disappears along a run entails an evidence-presenting step.

`DynamicEvidence.ResolvedAt` then gives the full resolution dichotomy: a challenge is resolved because its view is admitted while still live, or because evidence removes it. `live_dynamic_resolution_requires_admission` prevents unrelated evidence from substituting for an answer while the challenged view remains live.

`least_cost_exists`, `least_time_exists` and `cost_time_tradeoff` show that cheapest and fastest correction can be different runs.

---

## 5. Layer 1e — one model law across scales (`Network.lean`, `UnifiedTracking.lean`)

A `Network.Model` has private state, a public record and a content-sensitive revision rule. The same type can represent one hypothesis, one person, a group, or a group of groups.

`solo_tracking_iff` makes the individual exactly the one-member group case. `group_tracks` and `sound_tree_tracks` prove recursive closure under explicit door/content conditions.

The group record is a **union** of member records: an epistemic envelope retaining any world still admitted by at least one member. It is not an action-selection rule.

Network failure modes include `blind_cut_blocks` and `pairs_position_blocks`: a connected boundary can still destroy trackability when it sends a group position instead of member content.

`aggregation_under_anchor` is deliberately narrow: literal intersection of incompatible complete views is empty. It is not a theorem against voting, compromise, deliberation or ordinary consensus.

`UnifiedTracking.lean` makes “one law” literal. Both executable-process `Tracking.Tracks` and deterministic `Network.Model.Tracking` are instances of one content-indexed transition relation. `TransitionTracksAt` requires a live incoming content to have at least one admitting correction outcome and every possible outcome to be minimal toward that content.

The same file distinguishes:

- `FaithfulChannel`: exact semantic equivalence on candidate worlds;
- legacy `Network.Honest`: live-preserving sharpening, which can be strictly stronger than what was said.

Architectural claims about carrying another model's meaning use `FaithfulChannel`.

---

## 6. Composition and operational realization

`SemanticComposition.lean` defines heterogeneous exact semantic/process embeddings. Runs, records, step counts and costs lift across the boundary; answerability survives one or multiple nesting levels.

`ModelProcess.lean` is a local witness: one deterministic model revision compiles into challenge + revision, with a two-step/cost-two answer bound for a tracked live view.

`RelayProcess.lean` is an explicit-route witness. A supplied list of `h` exact faithful channels becomes challenge + `h` relay steps + revision, giving an `h+2` bound in the unit-cost baseline.

`Realization.lean` is the generic network interface. Its claim type is addressed content `(j,u)`, so content is carried in the transition itself. `Episode` is one challenge/run/revision hop; `Implements P M E ch α T K` says every graph edge, from every state and for every content, has a bounded episode ending in the receiver model's own revision.

Key bridge theorems are:

- `implemented_hop_within`: implemented edge ⇒ Layer-1b `CorrectionWithin`;
- `implemented_correctable`: strong implemented connectivity + governance ⇒ the process correction graph is correctable;
- `RelayN`: counted graph relay with composed content channel;
- `relay_run`: `m` implemented hops ⇒ one run bounded by `m*T` steps and `m*K` cost;
- `voice_admitted_within_faithful`: exact semantic wrapper for the relay result;
- `canonical_implements`: non-vacuous two-step/cost-two implementation for arbitrary model networks.

The process-family content encoding (`Tracking`/`ModelProcess`) and addressed-content encoding (`Realization`) are both valid but not yet proved equivalent.

---

## 7. Persistence under a changing world (`Persistence.lean`)

This layer adds the long-horizon problem explicitly.

### 7.1 Learning law

`Trajectory`, `InStep`, `OpenAt` and `OpenChange` represent a changing future. `deaf_must_be_vacuous` proves:

> If a record is fixed independently of what actually happens yet must remain in step for every possible future at an open time, it must admit every possible world.

`sealed_constraint_fails` proves that a permanently imposed informative constraint fails in some possible future under open change. `learner_in_step` shows the contrasting positive result: a record following reliable evidence remains in step. `learning_witness` packages all three in a concrete Bool-world witness.

### 7.2 Evidence-defined reality

`reality E src evm prior i` is the prior intersected with all evidence whose source can reach agent `i`.

`same_component_same_reality` uses **mutual reachability**, not informal undirected connectedness: two mutually reachable agents receive the same evidence set and therefore have the same reality. `shared_reality_when_connected` specializes this to a strongly connected network.

Reliable evidence keeps the true world in every member's reality (`reliable_realities_compatible`). Thus disjoint realities require false evidence somewhere (`disjoint_realities_imply_false_evidence`). `hidden_versus_revealed_conflict` is a two-agent witness: connection makes incompatible evidence jointly visible as an empty reality; separation lets each side retain a locally consistent but mutually disjoint reality.

### 7.3 Temporal repair

`TReach` is a route through a time-varying graph. `OnlyBreak` forbids creation/repair of links. `no_repair_split_permanent` proves that a missing route at time `t0` remains unreachable through time when links only break.

`RepairWithin Et E0 R` states that every baseline edge of `E0` is present again within at most `R` steps from any moment. `repair_bounds_delay` proves:

> a baseline route of `m` edges is temporally reachable within `m*(R+1)` steps.

`forgiveness_turns_split_into_delay` combines baseline strong connectivity with bounded repair: every member eventually reaches every other from every start time. This is the theorem-level content of “repair/forgiveness turns fragmentation into delay.”

The stochastic threshold `k*r/(p+r) > 1` is not this theorem. It belongs to F1 plus standard random-graph theory.

### 7.4 Reflexivity

`self_fulfilment_is_not_verification` proves that if an observation follows whenever people comply with a narrative, and a candidate world exists where they comply while the narrative claim is false, then that observation leaves the rival false-narrative world live.

`sealed_narrative_fails` applies the changing-world learning law to a narrative that forbids its own revision.

---

## 8. SCAP as a formal invariant (`SCAP.lean`)

The synthesis is now itself represented in Lean. `SCAP.Invariant` is an explicit conjunction with five fields:

1. **Connected:** baseline correction graph `E0` is strongly connected.
2. **Faithful:** every baseline edge uses exact `FaithfulChannel` transmission.
3. **Evidence-open:** each temporal record follows its supplied evidence; with reliable evidence, `members_in_step` keeps all members in step with the same actual trajectory.
4. **Repairable:** every baseline link returns within bounded delay `R`.
5. **Affordable:** the explicitly counted maintained correction structure satisfies `Ledger.Affordable`.

The stochastic forgiveness threshold is intentionally not a field. It is one model-specific sufficient criterion studied by F1, whereas theorem-level repairability is `RepairWithin`.

`relayN_faithful` proves exact faithfulness composes along a counted route. `faithful_route_exists` derives a counted faithful route between every pair from SCAP connectivity and edge faithfulness. `persistent_faithful_access` adds the temporal `m*(R+1)` repair bound.

`implemented_scap_correctable` bridges the invariant back to Layer 1b through `Realization.Implements`.

### Top-level theorem

`SCAP.scap_persistent_correctability` is the current outer theorem. Given one `SCAP.Invariant`, an implementation contract, and the explicit governance premise, it proves together that:

- the current Layer-1b correction system is structurally correctable;
- any chosen pair has a counted exactly-faithful baseline route;
- bounded repair gives temporal reach along that route within `m*(R+1)` steps from any start time;
- the maintained correction structure is affordable under the stated CRM ledger.

The theorem intentionally keeps temporal waiting/repair and executable process time as separate notions. It does not yet claim that the repaired temporal route is one globally clocked `Operational.Process.Run` with concurrency/attention constraints.

---

## 9. Resource layer and topology

`Bridge.lean`, `Realization.lean` and `NetworkEconomics.lean` make resource assumptions explicit.

A directed ring has one maintained outgoing edge per member and longer paths. One-hop distance between every distinct pair forces the complete directed graph (`latency_one_forces_complete`). In the simple ledger specialization, complete-network link upkeep grows quadratically in member count whereas exogenous plus per-member resource return grows linearly.

The correct interpretation is therefore a **feasible topology/time/cost region**, not “the ledger determines speed” and not a universal claim that a complete network fails even when each individual link fully finances itself.

The four-person witness remains useful: 12 directed links and relay distance 1 for flat all-to-all versus 6 links and maximum relay distance 3 for the paired architecture. Under homogeneous link upkeep, the latter halves standing maintenance but adds process latency.

The full CRM critical-mass/hysteresis dynamics remain canonical in PR #65. This PR currently reuses the ledger and proves affordability consequences; topology loss causing a CRM critical-mass transition remains open.

---

## 10. F1–F5 simulations

The new simulations are under `sim/`. They are graded dynamic counterparts of parts of the set-based theory, not Lean proofs.

- **F1:** repaired-link percolation and the `k*r/(p+r)` threshold.
- **F2:** disagreement feedback, tipping and hysteresis.
- **F3:** changing-world comparison of learner, rigid, drifter, sealed and vacuous models.
- **F4:** selection/erosion of repair narratives under repair cost and robustness to a break-rate shock.
- **F5:** inheritance across time versus learning through links to peers.

Frozen results are in `sim/results/fragmentation.json`; `sim/fragmentation_experiments.py` regenerates the results and F-series figures. A compact committed summary is `sim/figures/F1-F5_summary.svg`. E1–E8 remain in PR #65.

---

## 11. Verification checkpoint

GitHub Actions run `36046071150` built the current Lean package from a clean checkout and the CI gate verified exactly **227** `#print axioms` entries.

For the three Step 6 common-ground results added to this audit:

- `informative_content_has_live_rival` uses no axioms;
- `shareable_iff_rules_out_nothing` uses no axioms;
- `agreement_witness` uses only `propext`;
- **0** audited results use `sorry` / `sorryAx`.

The Lean sources and `Audit.lean` remain authoritative for the full axiom-dependency breakdown.

---

## 12. Current formal limits

The main gaps are now specific rather than architectural:

- relate the process-family and addressed-content operational encodings formally;
- combine repair/waiting and correction execution into one globally clocked process;
- model concurrent relay, attention/capacity and competition for processing;
- generalize uniform `T,K` and homogeneous maintenance to heterogeneous costs;
- move some stochastic failure/repair results from simulation toward theorem-level bounds where justified;
- connect topology degradation/restoration to the CRM critical-mass/hysteresis dynamics, not only the ledger;
- derive some self-model meanings rather than supplying them;
- add collective action on top of the epistemic envelope without confusing action selection with epistemic consensus.
