# Anchored Correctability: the model built up from its one certainty

**Status:** formal development, Lean 4 core library only (no Mathlib), in `lean/AnchoredEvolution/`.
**Build:** `cd lean && lake build`, run offline.
**Audit:** 36 headline results are audited in `Audit.lean`:
- 25 depend on **no axioms at all**, so they are fully constructive;
- one uses classical logic, and it is labelled;
- the rest use only Lean's standard `propext` / `Quot.sound`, which come from arithmetic automation;
- no `sorry` anywhere.

---

## 0. The construction in one paragraph

We start from the one certainty: pairwise incompatible models cannot all be correct. We add only two further premises, both named:

- **Liveness (the epistemic state).** Evidence has not refuted any model, so each is correct in some scenario still open.
- **The aim (a choice).** The system should stay correctable in whichever scenario is actual.

From these we derive, step by step:
- no model can be treated as fact;
- every missing correction route leaves open a scenario in which the system is wrong and cannot be corrected;
- the correction graph must be strongly connected: every model can reach every other along some chain of routes;
- every model must be able both to send and to receive correction, and one route in and one route out suffice;
- correctable parts joined by a correctable interface form a correctable whole of the same type, so the law holds at every nesting level;
- absorption across a level boundary, in either direction, breaks correctability;
- a restriction keeps the system correctable *if and only if* correction can route around it;
- the correction network is itself retained organization, so the budget law of the Cumulative Reproduction Model limits how large a mutually correctable community can be, unless correction pays for itself.

---

## 1. Premise ledger: what is certain, what is chosen, what is assumed

| Status | Premise | Lean |
|---|---|---|
| **Certain** (the anchor) | Pairwise incompatible models are not jointly correct, in every candidate world | `PairwiseIncompatible`, `AnchorInEveryWorld` |
| Epistemic state | **Liveness:** each model is correct in at least one world that evidence leaves open | `Live` |
| **Chosen aim** | In every candidate world, the correct model's correction can reach every model | `CorrectabilityAim` |
| Structural | Correction travels along edges. A composite consists of components plus interface edges | `Reach`, `System`, `Composite` |
| Economic (Layer 5 only) | Each maintained route costs upkeep μ; the budget is the ledger (B₀, η, μ) | `Bridge.lean` |

Nothing else is assumed. In particular, no normative conclusion is hidden inside a definition. The aim is a choice, and every theorem that needs it states it as a hypothesis.

---

## 2. The layers

### Layer 0 — the anchor (`Anchor.lean`)

| Theorem | Meaning | Axioms |
|---|---|---|
| `anchor_not_two` | Two correct models cannot be distinct | none |
| `anchor_at_most_one` | At most one model is correct (given decidable identity) | none |
| `anchor_others_wrong` | If one model is correct, every other is wrong | none |
| `anchor_all_but_one_wrong` | There is an index such that every other model is wrong; nobody needs to know which | classical |
| `anchor_lifts` | If group consensuses entail distinct members' claims, the groups are pairwise incompatible too: the anchor holds one level up | none |
| `anchor_true`, `anchor_has_no_true_rival` | **Reflexive stability.** The anchor is true, so any model incompatible with it is false. Applying the Room to the anchor cannot unseat it, and everyone can hold it at once | none |

The anchor is also scale-free by construction. The index type can be persons, one person at different times, or groups.

### Layer 1 — the relational skeleton forced by the anchor (`Anchor.lean`)

| Theorem | Meaning | Axioms |
|---|---|---|
| `live_rival_blocks_guarantee` | If a rival model is live, my model is not guaranteed: it is wrong in the world where the rival is right | none |
| `open_room_no_guarantee` | If every model is live and has a rival, **no model can be treated as fact** | none |
| `guarantee_would_refute_rivals` | A guarantee is the only certainty-based ground for silencing a rival: given one, every rival is wrong everywhere | none |
| `live_and_aim_force_strong_connectivity` | Liveness plus the aim imply every model's correction can reach every model | none |
| **`missing_route_leaves_uncorrectable_error`** | If the route from a live model b to d is missing, some evidentially open world has been dropped. In that world b is right, **every other model (including d) is wrong**, and b's correction cannot reach d | none |

The last theorem is the formal centre. A missing route is not a neutral design choice. It removes a scenario that evidence left open. By the anchor, that scenario is exactly the one in which everyone except the silenced model is wrong. The system has made itself uncorrectable in precisely the case where it is in error.

### Layer 2 — minimal architecture (`Composition.lean`)

| Theorem | Meaning | Axioms |
|---|---|---|
| `sc_every_model_sends` | In a correctable system, every model's correction can leave it. This is *standing*: the parable's "protect the observer", since no model's voice is made epistemically nonexistent | none |
| `sc_every_model_receives` | Every model can be reached by correction. This is *correctability*: the parable's "protect the relationship", since no model is beyond correction and self-exemption is ruled out | none |
| `ring_strongly_connected`, `ring_out_unique`, `ring_in_unique` | One outgoing and one incoming route per model suffice, so the cost of correctability is linear in the number of models | std |

### Layer 3 — composition and scale invariance (`Composition.lean`)

| Theorem | Meaning | Axioms |
|---|---|---|
| `composite_correctable` | Correctable components joined by a correctable interface give a correctable composite | none |
| `toSystem` (definition) | A composite is again a `System`, the same type as its parts. This is what makes the law recursive | — |
| **`built_correctable`** | Any system built by repeated composition is correctable, **at any nesting depth** | none |
| `interface_necessary` | If the composite is correctable and every component is non-empty, the interface between components must be correctable too | none |
| **`correction_through_others`** | A component can be internally uncorrectable while the whole is correctable, because its correction arrives through others. Interdependence appears as a theorem | propext |
| `sealed_outward_breaks` | **Downward absorption:** a member whose correction cannot leave it ("the official description") breaks correctability of the whole | none |
| `sealed_inward_breaks` | **Upward absorption:** a member no one can correct (self-exemption at scale) breaks it too | none |

The two absorption theorems are the parable's two protections — *protect the observer* and *protect the relationship* — applied at every level boundary. They are generic in the index type, so they hold for persons in a group, groups in an institution, and so on up.

### Layer 4 — correctability through time (`Dynamics.lean`)

| Theorem | Meaning | Axioms |
|---|---|---|
| **`correctable_after_iff_legitimate`** | If the system is correctable now, it stays correctable after a change **iff every old route remains realizable, directly or by detour** | none |
| `trajectory_correctable` | Starting correctable and changing only by legitimate restrictions and restorations, the system is correctable forever | none |
| `exclusion_with_detour_legitimate` | Removing a direct route is legitimate when a detour survives. Exclusion is allowed; exclusion from all correction is not | none |
| `sealing_breaks`, `isolation_breaks` | Leaving a model with no outgoing route, or no incoming route, breaks correctability. These are the formal "unappealable exclusion" | none |

This turns the Learning Constitution's recursive clause ("restrictions must remain correctable") into an exact criterion: **a restriction is legitimate exactly when correction can route around it.**

### Layer 5 — the correction network as retained organization (`Bridge.lean`)

| Theorem | Meaning | Axioms |
|---|---|---|
| `correction_upkeep_lower_bound` | Keeping n models mutually correctable costs at least n·μ | std |
| `correctable_population_ceiling` | With net-cost correction (η < μ), at most B₀/(μ − η) models can remain mutually correctable | std |
| `ring_affordable_iff` | The bound is attained: a ring of models is affordable exactly when the ledger admits that many items | none |
| `self_financing_correction_unbounded` | If correction returns at least its upkeep (η ≥ μ), there is no ceiling | std |

This links the anchored development to the Cumulative Reproduction Model. Correctability is itself subject to the budget-balance law. A community can stay mutually correctable at any size only if correction produces at least what it costs to maintain.

### Non-vacuity witnesses (`Witness.lean`)

- **Room of three.** In world w, model w is right. The anchor holds in every world, every model is live, and correction runs around a ring. All Layer-1 premises hold at once, no model is guaranteed (`room_no_guarantee`), and the skeleton theorem gives correctability (`room_correctable`).
- **Three levels.** Rooms, pairs of rooms, and pairs of pairs: twelve models on three levels. `level3_correctable` follows from the same `built_correctable` theorem that makes a single room correctable.

---

## 3. A finding about `TheRoom.lean`

`TheRoom.lean` defines `TruthGuaranteed a` *factually*: every proposition agent a is certain of happens to be true. Its symmetry premise `NoPrivilegedTruthAccess` states that agents of the same standing are equally truth-guaranteed.

Under the factual reading, that premise is **false in exactly the case the Room is about**: one agent happens to be right and the other does not (`factual_symmetry_fails_when_someone_is_right`). So `same_standing_blocks_either_infallibility` can only be applied in worlds where both agents are already wrong. Its conclusion is then true but trivially so.

The scenario version used here repairs this. A guarantee means **correct in every world evidence leaves open**. With that definition:
- the premises can all hold in a world where one model really is right (the room witness);
- the conclusion "no model can be treated as fact" is informative.

I recommend porting `Live`, `Guaranteed` and `open_room_no_guarantee` back into `TheRoom.lean`.

---

## 4. How this answers the scaling requirement

The requirement was that the metamodel work for one model, and unchanged when two, three or four models meet.

1. **The anchor is scale-free.** It is generic in what counts as a model, and it lifts to group consensuses (`anchor_lifts`).
2. **The derived property is one predicate at every level.** `Correctable` means strongly connected correction.
3. **The property is closed under composition.** A composite is a system of the same type (`toSystem`), and `built_correctable` holds at any depth.
4. **The condition at each boundary is exactly the parable's symmetry.** Neither the whole may absorb the part, nor the part the whole (`sealed_outward_breaks`, `sealed_inward_breaks`).
5. **Scaling costs are linear.** One route in and one out per model suffice (the ring). The only ceiling is economic, and it disappears when correction pays for itself (Layer 5).

---

## 5. Limits: what this does not yet capture

- **Speed and reliability.** Correctability here means a route *exists*. It says nothing about how fast correction arrives or how well it survives the journey. The ring is the cheapest correctable architecture but also the slowest: a correction may need n hops. Hierarchies with appeal and feedback routes trade a little cost for much shorter paths. That cost–latency frontier is the natural next theorem.
- **Graded correctness.** `holds a w` is binary. The elephant parable shows that models can be *partly* right, and that incompatibility itself can be only apparent. Here incompatibility is a premise within each world. Where models are compatible, the anchor does not apply and the no-guarantee argument weakens. This is stated, not hidden.
- **Evidence.** Liveness is an input. The development does not model how evidence refutes a model; it only shows that certainty cannot.
- **Credibility and weights.** Routes are unweighted. Different weight for different sources is compatible with everything here, as long as no source's weight becomes zero by construction, but it is not modelled.
- **No machine-checked link to the CRM dynamics.** Layer 5 shares the ledger with the reproduction model. The claim that excluding members can push a community below its critical mass (the CRM hysteresis law) is an interpretation, not a proved theorem here.

---

## 6. Reproduce

```bash
cd lean
lake build            # Lean 4.33 core only; prints the axiom audit from Audit.lean
```

Files:
- `Anchor.lean`: Layers 0–1
- `Composition.lean`: Layers 2–3
- `Dynamics.lean`: Layer 4
- `Bridge.lean`: Layer 5
- `Witness.lean`: non-vacuity witnesses
- `CumulativeReproduction.lean`: the reproduction model's discrete core
- `Audit.lean`: the axiom audit
