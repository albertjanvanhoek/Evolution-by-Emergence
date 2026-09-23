# Anchored Correctability

**Status:** active formal research development, Lean 4 core only (no Mathlib), under `lean/AnchoredEvolution/`.

**Current verified checkpoint:** 139 audited headline results; 102 axiom-free, 4 using `Classical.choice`, 33 using only standard `propext` / `Quot.sound`; no `sorry` / `sorryAx`.

---

## 0. Construction in one sentence

Anchored Correctability starts from one narrow logical anchor — **pairwise incompatible models cannot all be correct** — and asks what a fallible learning system must preserve, conditional on the explicit aim that it remain able to correct itself whichever evidentially live world is actual.

The project keeps every additional ingredient named rather than hiding it in the anchor:

- **liveness:** a view remains true in at least one candidate world left open by current evidence;
- **correctability aim:** if a live view is the correct one, its correction must remain able to reach the system;
- **execution:** challenge, evidence, relay, revision and repair are state transitions;
- **semantics:** claims denote sets of candidate worlds;
- **tracking:** correction responds to the content actually supplied and changes the public record only as far as that content warrants;
- **evidence:** candidate worlds may be removed only by evidence under the stated evidence discipline;
- **resources:** correction structure and correction runs consume resources and therefore eventually meet the CRM ledger.

No normative conclusion follows from the anchor alone. The correctability aim is a chosen premise and appears explicitly in the theorems that use it.

---

## 1. Premise ledger

| Status | Ingredient | Formal object |
|---|---|---|
| Logical anchor | incompatible models are not jointly correct | `PairwiseIncompatible`, `AnchorInEveryWorld` |
| Epistemic state | each non-refuted view is true in at least one still-open world | `Live`, `LiveClaim` |
| Chosen aim | correction from a correct live model remains able to reach the system | `CorrectabilityAim` |
| Operational | actions are executable transitions with step cost | `Operational.Process`, `Process.Run` |
| Semantic | claims denote sets of candidate worlds | `Compatible`, `Incompatible` |
| Tracking | live content is admitted and revision is minimal toward that content | `Tracking.Tracks`, `Network.Model.Tracking`, `UnifiedTracking.TransitionTracking` |
| Evidence | only evidence narrows candidate worlds | `EvidenceDiscipline` |
| Economic | maintained correction structure consumes a ledger | `Bridge.lean`, CRM core |

---

## 2. The correction hierarchy

The formalization separates concepts that ordinary prose often collapses:

`declared < permitted-and-revisable < responsive < answerable < tracking`

**Declared.** An interface says challenge or revision is available. `paper_constitution` proves that the full paper constitution can hold at a state from which no step executes.

**Permitted and revisable.** The challenge actually executes and some revision is reachable. `heard_but_unanswerable` proves these capabilities can still be causally disconnected: challenges are filed into a dead end while independent revision remains possible.

**Responsive.** A run beginning with the participant's challenge reaches revision. Correction time and correction cost are properties of actual runs. `sealed_iff_no_finite_cost` turns infinite correction cost from a declaration into a theorem about the absence of finite responsive runs.

**Answerable.** The challenge reaches a record that admits the challenger's live view. `revised_but_unanswered` proves that responsiveness is weaker: revision can merely reword the decision and continue excluding the challenger.

**Tracking.** Answerability is still too weak, because a system could answer by opening its model to everything. Tracking adds content dependence and minimal change. `always_inclusive_answers_but_does_not_track` separates the notions, while `content_insensitive_cannot_track` proves that a content-blind mechanism cannot track incompatible rival views.

Dynamic evidence adds one legitimate alternative to admission: if evidence genuinely removes the challenged view from the live set, the challenge can be resolved by refutation rather than accommodation.

---

## 3. Formal layers

### Layer 0 — anchor (`Anchor.lean`)

The anchor yields `anchor_not_two`, `anchor_at_most_one`, `anchor_others_wrong` and related results. Possible-world semantics separates `Live` from `Guaranteed`, repairing the older factual reading of certainty in `TheRoom.lean`.

`open_room_no_guarantee` says that when incompatible rivals remain live, no represented model is guaranteed across all candidate worlds. This is an epistemic statement, not a claim that nobody happens to be right in the actual world.

### Layer 1 — structural correctability (`Anchor.lean`)

`live_and_aim_force_strong_connectivity` derives a strongly connected correction skeleton from liveness plus the chosen aim. `missing_route_leaves_uncorrectable_error` gives the failure witness: if a correction route is missing, there is an evidentially open world where the omitted live model is right, others are wrong, and its correction cannot reach the target.

### Layer 1b — executable correction (`Operational.lean`)

The executable step relation becomes primary. Permission, revision availability, responsiveness, correction time and cost are derived from actual state transitions. The process also induces the older structural correction graph, making that graph an abstraction of behavior rather than a primitive declaration.

### Layer 1c — meaning and answerability (`Semantics.lean`)

Claims receive meanings over candidate worlds. Holding a claim and the claim being true are separate predicates.

The perspective problem is machine checked. `overgeneralization_manufactures_conflict` shows that strengthening another person's partial description can manufacture incompatibility; `caricature_dissolves_conflict` shows weakening can hide incompatibility. Faithful translation preserves incompatibility exactly.

`unanswerable_challenge_fixes_error` and the non-vacuous `executable_unanswerable_challenge_fixes_error` connect an unanswerable live challenge to a candidate world in which the decision remains wrong after the challenge. `self_model_not_guaranteed` and `sealed_rule_fixes_error` put claims about the correction mechanism itself under the same anchor.

### Layer 1d — tracking, evidence, time and cost (`Tracking.lean`)

The answer graph is stronger than the responsive graph. Under record discipline, answer-graph correctability implies responsive-graph correctability.

`EvidenceDiscipline` lets candidate sets change with state. `scenario_removed_only_by_evidence` proves that a world that disappears from the candidate set along a run implies an actual evidence-presenting step occurred.

Content tracking then requires both successful admission and minimal change toward the content. `content_insensitive_cannot_track` is the central causal result: if two incompatible challenges generate the same process behavior, both cannot be tracked once the old record excludes one of them.

`least_cost_exists`, `least_time_exists` and `cost_time_tradeoff` show that fastest and cheapest correction need not be the same run. The eventual network object therefore should not collapse correction into one scalar.

### Layer 1e — scale-free models and networks (`Network.lean`)

A `Model` has private state, a public record and a revision rule. The same type can represent one hypothesis inside a learner, one person, a group, or a group of groups.

`solo_tracking_iff` proves that one person is exactly the one-member group case. `group_tracks` proves closure under grouping when every member tracks and every live content has a door. `sound_tree_tracks` repeats the same construction at arbitrary depth.

The group record is the **union** of member records. It is best interpreted as an **epistemic envelope**: a world remains admitted if at least one member still admits it. It is not yet a collective action or policy-selection rule.

Relay theorems establish that structural reachability is insufficient if interfaces destroy content. `blind_cut_blocks` and `pairs_position_blocks` show that forwarding a group's position instead of members' rival content can make tracking impossible across the boundary even when the surrounding network remains connected.

`aggregation_under_anchor` is deliberately narrow: literal intersection of mutually incompatible complete views is empty on the candidate set. It is not a theorem against ordinary deliberative consensus, compromise or action selection.

### Semantic composition (`SemanticComposition.lean`)

`HFaithful` is exact heterogeneous semantic translation. An `Embedding` additionally preserves records, executable steps and costs. `liftRun`, `answerWithin_preserved`, `answerable_preserved` and `answerable_through_two_levels` show that semantic answerability survives faithful process boundaries without inventing a new rule at the next scale.

### One law, literally (`UnifiedTracking.lean`)

There were previously two tracking descriptions: process-based nondeterministic tracking and deterministic model revision. They are now instances of one content-indexed transition relation.

`TransitionTracksAt` requires:

1. if incoming content is live, at least one transition outcome admits it;
2. every transition outcome changes the public record minimally toward that content.

`operational_tracks_iff_transition_tracksAt_of_live` identifies process tracking with this relation-level law for live views. `model_tracking_iff_transition_tracking` proves that `Network.Model.Tracking` is its deterministic specialization.

The same file distinguishes **exact faithfulness** from the older `Network.Honest` predicate. The latter is better understood as live-preserving sharpening: it may narrow what was said. `FaithfulChannel` preserves compatibility and incompatibility in both directions, so exact translation itself cannot manufacture or erase conflict.

### Dynamic evidence (`DynamicEvidence.lean`)

`ResolvedAt` says a challenged view is resolved when either the current record admits it or the view is no longer live under the current evidence state.

`resolution_is_admission_or_evidence` proves the central dichotomy. If a view was initially live and later becomes resolved along a run obeying `EvidenceDiscipline`, then either the later record admits it or the route contains an actual evidence-presenting step. `live_dynamic_resolution_requires_admission` prevents unrelated evidence from substituting for an answer when the view remains live.

The resulting learning rule is:

> **If a challenged possibility remains live, admit it; otherwise its removal must be accounted for by evidence.**

### Local operational realization (`ModelProcess.lean`)

A deterministic scale-free model is now executable. For a fixed incoming content, `compile` creates:

1. challenge: `idle → heard`, cost 1;
2. local model revision: `heard → done`, cost 1.

`compiled_tracks_of_live` proves that a tracking model compiles to a process that tracks the live view. `compiled_answerWithin_two` gives the explicit local bound of two steps and total cost two.

### Executable relay routes (`RelayProcess.lean`)

This closes the next operational gap. A route is an explicit list of content channels. The process executes:

1. one challenge;
2. one relay step per channel;
3. one receiver revision.

Each step has unit cost in this baseline model. `FaithfulRoute` requires exact semantic faithfulness at every hop. `faithfulRoute_iff` proves that end-to-end relayed content has the same truth value as the original source content on candidate worlds.

The main quantitative theorem is `answerWithin_route`:

> If the receiver tracks and the source view is live, then an exactly faithful route of `h` channels answers the original view within **`h + 2` steps and `h + 2` cost units**.

Thus network distance, semantic answerability and resource cost now occur in the same machine-checked run. `zero_hop_two_step` recovers the local compiler as the zero-hop special case.

The current route is supplied explicitly as a channel list. The graph-indexed `Network.Relay` proof is not yet automatically compiled into that operational list, so this is not yet an automatic quantitative theorem for every structural path.

### Structural composition and dynamics (`Composition.lean`, `Dynamics.lean`)

The older graph layer remains a deliberately lossy abstraction. Strong structural correctability composes recursively; a ring is a minimal strongly connected witness; sealed inward/outward boundaries break correctability; restrictions preserve it exactly when old routes remain realizable directly or through detours.

### Resource bridge (`Bridge.lean`)

Correction structure is retained organization. Maintaining it consumes resources. The bridge proves a lower upkeep bound, a correctable-population ceiling when correction has positive net cost, and removal of that ceiling when correction is self-financing.

This is not yet a complete theorem connecting operational relay latency and standing topology maintenance to CRM hysteresis. The ingredients are now closer but remain separate.

---

## 4. What scale means here

The same tracking law is now literally shared by individual and collective models. Scaling adds interface and routing conditions, not a new epistemic principle.

A live view needs a door into the containing model. Its content must survive interfaces with enough fidelity for the receiver to track it. Exact semantic faithfulness is stronger than mere live-preserving sharpening because strengthening can itself manufacture conflict.

The four-person examples therefore support the statement that **hierarchy need not destroy tracking when interfaces preserve content**. They do not support the stronger claim that hierarchy has zero cost. The executable relay layer now makes the missing cost visible as route length under the unit-cost baseline.

---

## 5. Inside and outside

From the **inside**, a learner holds views whose meanings correspond to candidate worlds and receives challenges carrying content.

From the **outside**, the learner is a transition system: challenge, relay, evidence and revision steps occur; records change; time passes; resources are consumed.

The relation-level tracking law connects these views. `ModelProcess.lean` and `RelayProcess.lean` additionally show that the scale-free semantic law can be realized by explicit step-and-cost processes, including multi-hop communication.

Because procedural self-models are themselves claims, the architecture does not place its own correction mechanism outside the theory.

---

## 6. Audit checkpoint

GitHub Actions run `35871863420` built the complete package successfully with Lean 4.33 core only and the CI gate verified exactly **139** audit entries.

- **102** results depend on no axioms;
- **4** use `Classical.choice`;
- **33** use only `propext` / `Quot.sound` among their non-classical dependencies;
- **0** use `sorry` / `sorryAx`.

For the new relay layer, six audited results are axiom-free and five use only standard `propext` / `Quot.sound`; none introduce classical logic.

---

## 7. Current limits

1. **Graph route → operational route is not automatic yet.** `Network.Relay` and `RelayProcess` use compatible ideas but the latter currently receives an explicit channel list.
2. **Relay costs are unit costs.** Heterogeneous transmission, deliberation and revision costs are not yet represented.
3. **Standing maintenance cost remains separate from run cost.** `Bridge.lean` prices maintained correction structure abstractly; `RelayProcess.lean` prices one correction run. They have not yet been combined in one topology object.
4. **Reliability is binary.** Routes either work or do not; stochastic loss/failure is not modelled.
5. **Group epistemic envelope is not group action.** Retaining possibilities does not choose a single intervention or policy.
6. **Correctness is binary over candidate worlds.** Probabilities, graded support and source credibility remain future work.
7. **Self-model meanings are supplied.** They are not yet derived by running world-dependent versions of the process.

---

## 8. Next formal target

The next quantitative layer should turn a structural network into the operational object automatically and separate two resource questions:

- **standing maintenance:** what it costs to keep links/interfaces available;
- **correction run:** what one actual challenge/relay/revision trajectory costs and how long it takes.

After adding heterogeneous edge costs, the natural comparison object becomes a feasible frontier:

`(maintenance cost, correction-run cost, latency, reliability)`.

That will permit ring, flat and hierarchical networks to be compared without equating fewer links with universally lower cost, and supplies the quantities needed for a deeper CRM budget/hysteresis bridge.

---

## 9. Reproduce

```bash
cd research/anchored-correctability/lean
lake build
```

The build prints the complete axiom audit from `AnchoredEvolution/Audit.lean`.
