# The core of Evolution by Emergence

**One premise, two consequences, five laws.** Everything else in this repository refines, specializes or records the history of what is on this page. The formal backbone is collected in one Lean file, [`formalization/ebe-core/EbECore.lean`](formalization/ebe-core/EbECore.lean), which states every result below and is checked by CI.

## Where it starts: persistence

The theory is about **persistence**: what it takes for organization, and in particular for intelligence, to keep existing. It starts from two insights:

1. **The room.** Intelligences are fundamentally non-certain. Incompatible views cannot all be right, and no view can certify itself from the inside.
2. **Substrate dependence.** An intelligence exists only while the substrate and the network that sustain it are maintained.

Two consequences follow, and both are machine-checked:

- **Persistence requires correctability.** If an agent depends on partners who keep sustaining it only while it answers their correction (*reciprocity*), then persisting requires answering correction within its buffer, sealing itself off is fatal once the buffer runs out, and across an interdependent network the correction routes must reach everyone. Staying correctable is not a chosen aim; it is what persistence requires. Without reciprocity it does not follow: a sealed agent can persist where no one it depends on can withdraw.
- **Persistence requires the vortex.** In an open-ended world, where the kinds of situation that can arise keep growing, being ready for what can happen forces an ever-growing repertoire. With upkeep on everything retained, capture must keep growing too: the loop below has to keep turning. Persistence requires the vortex; it does not produce it. The vortex can still stop, and what persists is what kept it turning.

## The core in one sentence

> **To persist, organization must keep paying for itself and keep its errors findable. Organization that pays for itself can spend its surplus trying new combinations of what it already keeps. The combinations that pass the filters are kept, and keeping them changes what can be tried next. When a kept change also makes the organization cheaper to run or better at capturing resources, the surplus grows. That loop is the vortex.**

```
        external gradient
               │ capture
               ▼
   ┌──── ORGANIZATION ────┐   slack = capture − upkeep   (viable iff ≥ 0)
   │   (what is retained) │
   │                      │── β·slack ──► budget for trying
   │                      │                    │
   │      retained ◄── filters ◄── combine what is kept
   │   (becomes parent      (affordable, validated, kept)
   │    material; changes
   │    what can be tried)
   └──────────────────────┘
   A turn of the vortex: one kept change that both raises slack AND widens what can be tried
```

## The five laws

**1. The ledger: staying alive.** Slack is capture minus upkeep; the organization is viable exactly while slack is at least zero. Better organization, capturing more or maintaining more cheaply, raises the budget for change. Items that pay their own upkeep never meet a ceiling; otherwise there is a ceiling that no growth law can outrun. A finite budget cannot keep every candidate, so forgetting is forced.

**2. The ratchet: accumulation.** What is kept changes which routes exist. A kept item counts as cumulative only if it opens more than it costs to keep: a mere change of state is not enough, and paying more upkeep cannot create the advantage. Kept products become parents for the next round, so what can be tried widens: a *second-order click*.

**3. The vortex: feedback.** A turn is one kept change that both raises slack and widens search. Recurring turns give open-ended accumulation, and a concrete witness shows that all the premises can hold at once.

**4. The speed.** `speed = opportunity × generate × affordable × validated × retained × gain`. Any zero factor stops the vortex. Shorter waits, shorter response lags and larger gains raise the guaranteed rate floor. More search alone can lower the speed: search and validation must stay balanced. Competition among implementations that do the same job lowers their cost and strictly raises slack, which can fund more search: **Darwinian competition is the vortex's efficiency engine.**

**5. The network.** Inside a network of parts, transfers between parts cancel: they decide which parts can cover their upkeep, never the size of the vortex. Only creation enlarges it, and a non-viable whole stalls. For systems that model the world: incompatible claims cannot all be true; a network stays correctable only if a route remains by which every live error can be found; correctable parts joined by correctable interfaces stay correctable at every scale; removing the last route that can reveal an error seals it; a shared layer that determines every node passes on its blind spots; correction routes are retained organization and pay upkeep from the same ledger.

## The boundaries: what cannot be dropped

Persistence forces correction only through **reciprocity**: an agent that depends on no one who can withdraw can persist while sealed, but only while its buffer lasts. Each premise of the open-ended loop is shown necessary by a countermodel. Without a **seed** nothing happens. Without **successors** there is one innovation, then stasis. Without **retention** there is endless novelty but no accumulation. A **fixed finite space saturates**, so open-endedness needs an ever-widening range of distinctions. A **new whole cannot pay for its own parts**, so intermediate steps need support from elsewhere.

## What the derivation assumes

The two consequences above rest on premises about the world, stated explicitly in the Lean files: substrate dependence with a finite buffer, reciprocal support, an open-ended world, readiness for what can happen (no instant acquisition of a missing distinction), and positive upkeep on what is retained. Whether a given domain satisfies them is an empirical question; where one fails, the corresponding consequence does not follow.

## Where each law is proved

| Law | Result (Lean name) | Source |
|---|---|---|
| P | `persistence_requires_correction_within`, `sealing_is_fatal_after_buffer`, `interdependence_and_persistence_force_correctability`, `persistence_replaces_the_aim`, `reciprocity_is_load_bearing` | [PersistenceFirst](research/anchored-correctability/lean/AnchoredEvolution/PersistenceFirst.lean) |
| P | `open_world_forces_unbounded_repertoire`, `persistence_in_open_world_requires_unbounded_capture` | [PersistenceRequiresVortex](formalization/cumulative-accessibility/CumulativeAccessibility/PersistenceRequiresVortex.lean) |
| 1 | `internallyViableAt_iff_internalSlack_nonneg`, `organization_improvement_increases_endogenousResponseBudget` | [EndogenousBudgetBridge](formalization/cumulative-accessibility/CumulativeAccessibility/EndogenousBudgetBridge.lean) |
| 1 | `self_financing_never_binds`, `no_runaway_when_upkeep_exceeds_capture`, `critical_mass_dichotomy` | [CumulativeReproduction](research/anchored-correctability/lean/AnchoredEvolution/CumulativeReproduction.lean) |
| 1 | `candidate_set_exceeding_budget_cannot_all_be_retained` | [GenerativeLeverage](formalization/cumulative-accessibility/CumulativeAccessibility/GenerativeLeverage.lean) |
| 2 | `kernelDominance_preserves_accessibility`, `positivePaidOpening_requires_kernel_advantage`, `route_saving_exceeds_marginal_upkeep_opens_paid_window`, `no_paidOpening_without_kernel_change` | [TransitionAccessibility](formalization/cumulative-accessibility/CumulativeAccessibility/TransitionAccessibility.lean) |
| 2 | `retained_intermediate_creates_second_round_access` | [GenerativeClosure](formalization/cumulative-accessibility/CumulativeAccessibility/GenerativeClosure.lean) |
| 2 | `new_parent_set_implies_secondOrderClick` | [ModuleGeneratedEvolvability](formalization/cumulative-accessibility/CumulativeAccessibility/ModuleGeneratedEvolvability.lean) |
| 3 | `dynamicVortexTurn_opens_budget_and_futureSearch`, `recurringOpportunity_and_endogenousVortexResponse_imply_fullDynamicConsequences` | [DynamicVortex](formalization/cumulative-accessibility/CumulativeAccessibility/DynamicVortex.lean) |
| 3 | `vortex_full_dynamic_witness` | [DynamicVortexWitness](formalization/cumulative-accessibility/CumulativeAccessibility/DynamicVortexWitness.lean) |
| 4 | `mechanisticRatchetVelocity_zero_no_retention`, `mechanisticRatchetVelocity_mono_retention` | [RatchetVelocityLedger](formalization/cumulative-accessibility/CumulativeAccessibility/RatchetVelocityLedger.lean) |
| 4 | `boundedMechanism_implies_blockAverageRateFloor`, `shorterResponseLag_strictlyRaises_rateFloor` | [BoundedUpdateRate](formalization/cumulative-accessibility/CumulativeAccessibility/BoundedUpdateRate.lean) |
| 4 | `more_search_can_reduce_velocity` | [SearchValidationTradeoff](formalization/cumulative-accessibility/CumulativeAccessibility/SearchValidationTradeoff.lean) |
| 4 | `two_type_linear_cost_slack_strict`, `two_type_cost_selection_search_strict` | [PersistenceDrift](formalization/persistence-drift/PersistenceDrift.lean) |
| 5 | `internalSlack_eq_sum_partSlack`, `internallyViable_iff_exists_viable_transfer`, `nonviable_vortex_zero_velocity` | [NetworkVortexLedger](formalization/cumulative-accessibility/CumulativeAccessibility/NetworkVortexLedger.lean) |
| 5 | `anchor_not_two`, `live_and_aim_force_strong_connectivity` | [Anchor](research/anchored-correctability/lean/AnchoredEvolution/Anchor.lean) |
| 5 | `built_correctable` | [Composition](research/anchored-correctability/lean/AnchoredEvolution/Composition.lean) |
| 5 | `last_route_removal_seals` | [AnchorSafety](research/anchored-correctability/lean/AnchoredEvolution/AnchorSafety.lean) |
| 5 | `hub_determined_network_inherits_blind_spot` | [GlobalLayer](research/anchored-correctability/lean/AnchoredEvolution/GlobalLayer.lean) |
| 5 | `correctable_population_ceiling` | [Bridge](research/anchored-correctability/lean/AnchoredEvolution/Bridge.lean) |
| B | `uniformCritical_and_retention_without_seed_not_enough`, `seed_and_retention_without_criticality_not_enough`, `recurringRecursiveEmergence_without_retention_not_cumulative` | [EvolutionByEmergenceCore](formalization/cumulative-accessibility/CumulativeAccessibility/EvolutionByEmergenceCore.lean) |
| B | `finite_generative_closure_saturates` | [FiniteGenerativeSaturation](formalization/cumulative-accessibility/CumulativeAccessibility/FiniteGenerativeSaturation.lean) |
| B | `openEndedNovelty_implies_unboundedEnvelopeCapacity` | [OpenEndedCapacity](formalization/cumulative-accessibility/CumulativeAccessibility/OpenEndedCapacity.lean) |
| B | `viable_emergent_intermediate_requires_auxiliary_support` | [EmergentAssemblyBarrier](formalization/cumulative-accessibility/CumulativeAccessibility/EmergentAssemblyBarrier.lean) |

## What this page does and does not claim

- **Proved:** each row is a machine-checked implication under the premises stated in its Lean theorem. `EbECore.lean` prints every statement and its axioms; CI rejects `sorry`.
- **Derived from persistence:** that correctability and a turning vortex are *required* for persistence, under the premises listed above.
- **Not derived:** that real systems keep producing turns. The vortex composition theorem joins proved parts, and the countermodels show the vortex can stop. That premise, like every application mapping (what counts as capture, upkeep, a filter or a transfer in a given domain), is an assumption to be tested.
- **Not claimed:** empirical universality, that any particular system satisfies the premises, or normative conclusions.

## What the framework predicts

The falsifiable predictions about collectives of fallible intelligences — and SCAP as a conditional design result — are in [PREDICTIONS.md](PREDICTIONS.md).

## How this relates to the rest of the repository

The current full theory ([THEORY_CORE_V21.md](THEORY_CORE_V21.md), [FORMAL_THEORY_MAP.md](FORMAL_THEORY_MAP.md)) and the intelligent-system specialization ([research/anchored-correctability/](research/anchored-correctability/)) remain the detailed review objects. Earlier cores, essays, chapters and papers are lineage, kept as written. If a reader understands this page and can check `EbECore.lean`, they hold the core.
