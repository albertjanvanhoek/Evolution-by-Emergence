# Anchored Correctability

**Status:** active formal research development, Lean 4 core only (no Mathlib), under `lean/AnchoredEvolution/`.

**Current verified checkpoint:** 128 audited headline results; 96 axiom-free, 4 using `Classical.choice`, 28 using only standard `propext` / `Quot.sound`; no `sorry` / `sorryAx`.

---

## 0. What the project now is

Anchored Correctability starts from one narrow logical anchor:

> **Pairwise incompatible models cannot all be correct.**

The rest is not smuggled into that statement. The development names each additional ingredient:

- **liveness:** a view remains true in at least one candidate world left open by current evidence;
- **correctability aim:** whichever live world is actual, the system should retain a route by which its error can be corrected;
- **execution:** challenge, evidence, revision and repair are state transitions, not declarations;
- **semantics:** claims have meanings over candidate worlds;
- **tracking:** correction must respond to the content that was actually supplied and change the model only as far as that content warrants;
- **evidence:** candidate worlds may be removed only through evidence under the stated evidence discipline;
- **resources:** correction structure itself has upkeep and therefore inherits the CRM ledger constraint.

The project is therefore a description of what a **fallible learning system that remains correctable** must preserve, conditional on the explicitly stated aim.

---

## 1. Premise ledger

| Status | Ingredient | Formal object |
|---|---|---|
| Logical anchor | pairwise incompatible models are not jointly correct | `PairwiseIncompatible`, `AnchorInEveryWorld` |
| Epistemic state | each non-refuted view is true in at least one still-open world | `Live`, `LiveClaim` |
| Chosen aim | correction from a correct live model remains able to reach the system | `CorrectabilityAim` |
| Operational | actions are executable state transitions with costs | `Operational.Process`, `Process.Run` |
| Semantic | claims denote sets of candidate worlds | `meaning`, `Compatible`, `Incompatible` |
| Tracking | live content is admitted and revision is minimal toward that content | `Tracking.Tracks`, `Network.Model.Tracking`, `UnifiedTracking.TransitionTracking` |
| Evidence | only evidence narrows candidate worlds | `EvidenceDiscipline` |
| Economic | maintained correction structure consumes a ledger | `Bridge.lean`, CRM core |

No normative conclusion follows from the anchor alone. Results that need the correctability aim state it as a hypothesis.

---

## 2. The correction hierarchy

The formalization has progressively separated notions that ordinary prose often collapses:

`declared < permitted-and-revisable < responsive < answerable < tracking`

### Declared

The interface says challenge or revision is available. `paper_constitution` proves this can hold even where nothing can execute.

### Permitted and revisable

A challenge really executes and some revision is reachable somewhere. `heard_but_unanswerable` proves that these can still be causally disconnected: challenges can be filed into a dead end while the authority revises independently.

### Responsive

A run that **starts with the participant's challenge** reaches a revision. Correction time and correction cost are properties of the run. `sealed_iff_no_finite_cost` turns sealing into a result: no finite responsive correction exists.

### Answerable

A challenge reaches a record that no longer excludes the challenger's live view. `revised_but_unanswered` proves responsiveness is weaker: merely rewording a policy can count as revision while still excluding the challenger.

### Tracking

Answerability is still not enough. A system can answer every challenge by opening the record to everything. Tracking adds **content dependence and minimal change**. `always_inclusive_answers_but_does_not_track` separates these notions; `content_insensitive_cannot_track` proves that a content-blind correction mechanism cannot track incompatible rival views.

---

## 3. Layer map

### Layer 0 — logical anchor (`Anchor.lean`)

Core consequences include `anchor_not_two`, `anchor_at_most_one`, `anchor_others_wrong`, and the possible-world distinction between `Live` and `Guaranteed`.

The important epistemic result is `open_room_no_guarantee`: when incompatible rivals are live, no one represented model is guaranteed across all candidate worlds.

### Layer 1 — structural correction skeleton (`Anchor.lean`)

`live_and_aim_force_strong_connectivity` derives strong connectivity from liveness plus the chosen correctability aim. `missing_route_leaves_uncorrectable_error` gives the failure witness: a missing route leaves open a world where the silenced live model is right, others are wrong, and its correction cannot reach the target.

### Layer 1b — executable correction (`Operational.lean`)

The executable step relation becomes primary. Permission, revision availability, responsiveness, time and cost are derived from actual steps. The process also induces a structural correction graph, connecting the operational and graph views.

### Layer 1c — meaning and answerability (`Semantics.lean`)

Claims receive meanings over candidate worlds. Holding a claim and that claim being true are separate facts.

The elephant result is formalized here. `overgeneralization_manufactures_conflict` shows that two compatible partial descriptions can be made incompatible by strengthening the translation; `caricature_dissolves_conflict` shows weakening can hide real conflict. A faithful translation preserves incompatibility exactly.

`unanswerable_challenge_fixes_error` and its non-vacuous strengthening `executable_unanswerable_challenge_fixes_error` connect failure to answer a live challenge with a candidate world in which the decision remains wrong.

Claims about the correction procedure itself are ordinary claims under the same semantics (`self_model_not_guaranteed`, `sealed_rule_fixes_error`). Thus recursive correctability is not exempt from the model's own anchor.

### Layer 1d — tracking, evidence and cost/time (`Tracking.lean`)

This layer builds an **answer graph**, introduces `EvidenceDiscipline`, and adds content tracking. `scenario_removed_only_by_evidence` proves that a candidate world that disappears along a run implies an evidence-presenting step occurred. `content_insensitive_cannot_track` proves that a process behaving identically under rival challenge contents cannot track both once the old record excludes one of them. `cost_time_tradeoff` shows that fastest and cheapest correction can be different runs.

### Layer 1e — scale-free models and networks (`Network.lean`)

A `Model` has a private state, a public record and a revision rule. The same type can represent one person, a hypothesis inside a person, a group, or a group of groups.

`solo_tracking_iff` proves that the individual is exactly the one-member group case. `group_tracks` proves closure under grouping when members track and every live content has a door. `sound_tree_tracks` recursively extends this to arbitrary depth.

The public group record is a **union of member records**. This is best interpreted as an **epistemic envelope**: which worlds remain admitted by at least one member. It is not a collective action rule.

The relay results show that content transport matters in addition to graph connectivity. Blind interfaces can destroy tracking even when the structural graph is connected (`blind_cut_blocks`, `pairs_position_blocks`). The four-person benchmark establishes preservation of tracking under suitable interfaces; it does **not** establish that hierarchy has zero physical or organizational cost.

`aggregation_under_anchor` is narrow: literal intersection of mutually incompatible complete member views is empty on the candidate set. It is not a theorem against ordinary deliberative consensus, compromise or action selection.

### Layer 3b — semantic process composition (`SemanticComposition.lean`)

`HFaithful` requires exact preservation of claim meaning. An `Embedding` also preserves records, executable steps and step cost. Entire runs lift and answerability survives a boundary with the same time and cost bounds. `answerable_through_two_levels` reuses the same law at the next nesting level.

### Unification bridge — literally one tracking law (`UnifiedTracking.lean`)

The nondeterministic process-based and deterministic model-level tracking formalisms are instances of one common relation-level object: a **content-indexed transition relation**.

`TransitionTracksAt` requires:

1. if incoming content is live, at least one transition outcome admits it;
2. every transition outcome is minimal toward that content.

`operational_tracks_iff_transition_tracksAt_of_live` identifies process-level tracking with this law for live views. `model_tracking_iff_transition_tracking` proves that `Network.Model.Tracking` is its deterministic specialization.

The same file repairs interface terminology. The legacy `Network.Honest` condition permits **live-preserving sharpening**; it is weaker than exact semantic faithfulness. `FaithfulChannel` specializes `HFaithful` to network content and preserves compatibility and incompatibility in both directions. Translation alone therefore cannot manufacture or erase a conflict under the stronger condition.

### Dynamic evidence-aware resolution (`DynamicEvidence.lean`)

`ResolvedAt` allows two legitimate outcomes: the later decision admits the challenged view, or the view is no longer live under later evidence.

`resolution_is_admission_or_evidence` proves the key dichotomy. If the view was live initially, the later state is reachable, and evidence discipline holds, then resolution means either semantic admission or that an actual evidence-presenting step occurred on the route. `live_dynamic_resolution_requires_admission` prevents unrelated evidence from substituting for an answer when the view remains live.

The learning rule is therefore:

> **If a challenged possibility remains live, admit it; otherwise its removal must be accounted for by evidence.**

### Local operational compiler (`ModelProcess.lean`)

The scale-free model law is now concretely realizable as an executable process. For a fixed incoming content, `compile` creates a two-step process:

1. `idle → heard` by challenge, cost 1;
2. `heard → done` by the model's own revision rule, cost 1.

`compiled_tracks_of_live` proves that a tracking model compiles to a process that tracks the live incoming view. `compiled_answerWithin_two` gives an explicit operational upper bound: answer within two steps and total cost two. `compiled_answerable_of_live` gives finite answerability immediately.

This closes the **local** abstract-revision gap. Relay hops between distinct models are not yet compiled into the same run.

### Structural composition and dynamics (`Composition.lean`, `Dynamics.lean`)

The graph layer remains useful as a deliberately lossy abstraction. Correctable systems compose structurally; a ring is a minimal strongly connected witness; sealed inward/outward boundaries break structural correctability; restrictions preserve it exactly when old routes remain realizable directly or through detours.

### Resource bridge (`Bridge.lean`)

The correction network is retained organization. Maintaining it consumes resources. The bridge proves a lower bound on upkeep and a population ceiling under net-cost correction, while self-financing correction removes that ledger ceiling.

This is a structural/economic bridge, not yet a full theorem connecting relay latency to CRM hysteresis.

---

## 4. What the model now says about scale

The same correction law is usable without changing logical form for one hypothesis inside a learner, one person as a one-member group, several people forming a group, groups forming higher-level groups, and networks connected by content-transforming interfaces.

The conditions added by composition are interface conditions rather than a new epistemic law: a live view needs a door into the containing model, and translation across a boundary must preserve enough of its content for tracking to remain meaningful.

Exact semantic faithfulness is stronger than live-preserving sharpening. The distinction matters because strengthening a representation can itself manufacture conflict.

---

## 5. Inside and outside

From the **inside**, a learner holds views whose meanings correspond to candidate worlds and can be challenged by content it did not already accommodate.

From the **outside**, the learner is a transition system: challenge and evidence steps occur, states change, records change, and those changes consume time and resources.

The relation-level tracking law is the bridge. `ModelProcess.lean` now also shows that the scale-free deterministic revision rule can be realized by an explicit step-and-cost process at the local model boundary.

Because procedural self-models are themselves claims, the bridge is not outside its own theory: claims such as "our challenges are answerable" remain challengeable under the same anchor.

---

## 6. Audit checkpoint

GitHub Actions builds the complete package with Lean 4.33 core only and rejects `sorryAx`.

Current audit: **128 headline results**.

- **96** depend on no axioms;
- **4** use `Classical.choice`;
- **28** use only `propext` / `Quot.sound` among their non-classical dependencies;
- **0** use `sorry` / `sorryAx`.

The six local-compiler results add four axiom-free theorems and two results using only standard `propext` / `Quot.sound` dependencies.

---

## 7. Limits and research boundary

Several boundaries remain explicit.

1. **Relay execution is not yet compiled.** A local `Network.Model` now has an operational realization, but a multi-hop `Network.Relay` is still a semantic route rather than a sequence of executable relay steps in the same `Process.Run`.
2. **Relay time is not yet counted.** The local model has a verified two-step correction bound; network hop-count latency remains to be derived.
3. **Link maintenance is not yet in the process ledger.** The CRM bridge prices maintained correction structure abstractly; it does not derive upkeep from a concrete network topology with relays.
4. **Reliability is not modelled.** Routes either exist or do not; stochastic transmission/revision failure remains future work.
5. **The group record is not a group action.** Union retains epistemic possibilities but does not choose a single intervention, policy or action.
6. **Correctness remains binary over candidate worlds.** Probabilistic support, graded fit and source credibility are not represented.
7. **Self-model meaning remains supplied.** A procedural claim's meaning is not yet derived by running world-dependent versions of the process.

---

## 8. Next formal target

The next layer should compile a **relay route plus receiving model** into one operational run with explicit relay steps and local revision. The target theorem is that exact faithful channels preserve the semantic content needed for tracking while route length contributes directly to correction time and route-specific cost.

After that, the natural comparison object is a feasible frontier involving at least:

`(link-maintenance cost, correction-run cost, latency, reliability)`.

That will allow ring, flat and hierarchical examples to be compared without collapsing "fewer maintained links" into the stronger and unjustified claim "hierarchy costs nothing", and it will supply the missing quantitative input for a deeper CRM budget/hysteresis bridge.

---

## 9. Reproduce

```bash
cd research/anchored-correctability/lean
lake build
```

The build prints the complete axiom audit from `AnchoredEvolution/Audit.lean`.
