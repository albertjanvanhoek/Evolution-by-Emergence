import CumulativeAccessibility.EndogenousBudgetBridge
import CumulativeAccessibility.GenerativeLeverage
import CumulativeAccessibility.TransitionAccessibility
import CumulativeAccessibility.GenerativeClosure
import CumulativeAccessibility.ModuleGeneratedEvolvability
import CumulativeAccessibility.DynamicVortex
import CumulativeAccessibility.DynamicVortexWitness
import CumulativeAccessibility.RatchetVelocityLedger
import CumulativeAccessibility.BoundedUpdateRate
import CumulativeAccessibility.SearchValidationTradeoff
import CumulativeAccessibility.FiniteGenerativeSaturation
import CumulativeAccessibility.OpenEndedCapacity
import CumulativeAccessibility.EmergentAssemblyBarrier
import CumulativeAccessibility.EvolutionByEmergenceCore
import CumulativeAccessibility.NetworkVortexLedger
import CumulativeAccessibility.PersistenceRequiresVortex
import AnchoredEvolution.CumulativeReproduction
import AnchoredEvolution.Anchor
import AnchoredEvolution.Composition
import AnchoredEvolution.Bridge
import AnchoredEvolution.AnchorSafety
import AnchoredEvolution.GlobalLayer
import AnchoredEvolution.PersistenceFirst
import PersistenceDrift

/-!
# Evolution by Emergence: the core in one file

This file adds no mathematics. It collects, in one place, the machine-checked
results that carry the core dynamic of Evolution by Emergence, in the order of
`CORE.md` at the repository root. Every result lives in its own package and is
proved there; this file imports them, prints each statement (`#check`) and
prints its axioms (`#print axioms`), so CI fails if any of them stops compiling
or depends on `sorry`.

## Where it starts: persistence

One premise, two consequences, five laws. The theory is about persistence.
Intelligences are fundamentally non-certain (the room), and an intelligence
exists only while the substrate and network that sustain it are maintained
(substrate dependence). Two consequences are proved below:

* **Persistence requires correctability**, given reciprocity: partners keep
  sustaining an agent only while it answers their correction. Without
  reciprocity it does not follow (`reciprocity_is_load_bearing`).
* **Persistence requires the vortex**, in an open-ended world: readiness for
  what can happen forces an ever-growing repertoire, and with positive upkeep
  capture must keep growing. Persistence requires the vortex; it does not
  produce it.

## The core in one sentence

To persist, organization must keep paying for itself and keep its errors
findable. Organization that pays for itself can spend its surplus trying new
combinations of what it already keeps. The combinations that pass the filters
are kept, and keeping them changes what can be tried next. When a kept change
also makes the organization cheaper to run or better at capturing resources,
the surplus grows. That loop is the vortex.

```
        external gradient
               | capture
               v
   +---- ORGANIZATION ----+   slack = capture - upkeep   (viable iff >= 0)
   |   (what is retained) |
   |                      |-- beta * slack --> budget for trying
   |                      |                        |
   |      retained <-- filters <-- combine what is kept
   +----------------------+
   a turn: one kept change that raises slack AND widens what can be tried
```

Everything below is a conditional statement under the premises named in each
theorem. Machine checking establishes the implications, not that a given real
system satisfies the premises.
-/

open CumulativeAccessibility

/-! ## Persistence first: the two consequences

Substrate dependence with a finite buffer plus reciprocal support: persisting
requires answering correction within the buffer; sealing is fatal once the
buffer runs out; across a strongly connected support network the correction
edges in operation are strongly connected, so the correctability aim of
`Anchor.lean` is derived rather than chosen. The countermodel shows reciprocity
is load-bearing.

An open-ended world plus readiness forces an unbounded repertoire; with
positive upkeep per retained kind and viability at every time, capture must
exceed every bound. -/

#check @Anchored.PersistenceFirst.persistence_requires_correction_within
#check @Anchored.PersistenceFirst.sealing_is_fatal_after_buffer
#check @Anchored.PersistenceFirst.interdependence_and_persistence_force_correctability
#check @Anchored.PersistenceFirst.persistence_replaces_the_aim
#check @Anchored.PersistenceFirst.reciprocity_is_load_bearing
#check @RecursiveAccessibility.open_world_forces_unbounded_repertoire
#check @RecursiveAccessibility.persistence_in_open_world_requires_unbounded_capture

/-! ## Law 1. The ledger: staying alive

Slack is capture minus upkeep; the organization is viable exactly when slack
is nonnegative. Better organization (more capture, cheaper upkeep) raises the
budget for change. Items that pay their own upkeep never hit a ceiling;
otherwise a ceiling exists and cannot be outgrown. A finite budget cannot
keep every candidate, so forgetting is forced. -/

#check @RecursiveAccessibility.internallyViableAt_iff_internalSlack_nonneg
#check @RecursiveAccessibility.organization_improvement_increases_endogenousResponseBudget
#check @CumulativeReproduction.self_financing_never_binds
#check @CumulativeReproduction.no_runaway_when_upkeep_exceeds_capture
#check @CumulativeReproduction.critical_mass_dichotomy
#check @GenerativeLeverage.candidate_set_exceeding_budget_cannot_all_be_retained

/-! ## Law 2. The ratchet: accumulation

What is kept changes which routes exist. A kept item counts as cumulative only
if it opens more than it costs to keep: a mere change of state is not enough,
and paying more upkeep cannot create the advantage. Kept products become
parents for the next round, so the set of things that can be tried widens
(a second-order click). -/

#check @TransitionAccessibility.kernelDominance_preserves_accessibility
#check @TransitionAccessibility.positivePaidOpening_requires_kernel_advantage
#check @TransitionAccessibility.route_saving_exceeds_marginal_upkeep_opens_paid_window
#check @TransitionAccessibility.no_paidOpening_without_kernel_change
#check @RecursiveAccessibility.retained_intermediate_creates_second_round_access
#check @RecursiveAccessibility.new_parent_set_implies_secondOrderClick

/-! ## Law 3. The vortex: feedback

A turn is one kept change that both raises slack and widens search. Recurring
turns give open-ended accumulation. The concrete witness shows that all
premises can hold at once. (The composition theorem packages proved parts; it
does not derive the recurring-turn premise itself.) -/

#check @RecursiveAccessibility.dynamicVortexTurn_opens_budget_and_futureSearch
#check @RecursiveAccessibility.recurringOpportunity_and_endogenousVortexResponse_imply_fullDynamicConsequences
#check @RecursiveAccessibility.vortex_full_dynamic_witness

/-! ## Law 4. The speed

speed = opportunity x generate x affordable x validated x retained x gain.
Any zero factor stops the vortex. Shorter waits, shorter response lags and
larger gains raise the guaranteed rate floor. More search alone can lower the
speed: search and validation must stay balanced.

Competition among implementations that do the same job lowers their cost and
strictly raises slack, which can fund more search: in this theory Darwinian
competition is the vortex's efficiency engine. -/

#check @FunctionalOrganization.mechanisticRatchetVelocity_zero_no_retention
#check @FunctionalOrganization.mechanisticRatchetVelocity_mono_retention
#check @FunctionalOrganization.boundedMechanism_implies_blockAverageRateFloor
#check @FunctionalOrganization.shorterResponseLag_strictlyRaises_rateFloor
#check @FunctionalOrganization.more_search_can_reduce_velocity
#check @PersistenceDrift.two_type_linear_cost_slack_strict
#check @PersistenceDrift.two_type_cost_selection_search_strict

/-! ## Law 5. The network

Inside a network of parts, transfers between parts cancel: they decide which
parts can cover their upkeep, never the size of the vortex. Only creation
(more capture, less upkeep) enlarges it, and a non-viable whole stalls.

For systems that model the world: incompatible claims cannot all be true. A
network that stays correctable must keep a route by which every live error
can be found; correctable parts joined by correctable interfaces stay
correctable at every scale; removing the last route that can reveal an error
seals it; a shared layer that determines every node passes on its blind spots;
correction routes are retained organization and pay upkeep from the same
ledger. -/

#check @RecursiveAccessibility.internalSlack_eq_sum_partSlack
#check @RecursiveAccessibility.internallyViable_iff_exists_viable_transfer
#check @RecursiveAccessibility.nonviable_vortex_zero_velocity
#check @Anchored.anchor_not_two
#check @Anchored.live_and_aim_force_strong_connectivity
#check @Anchored.built_correctable
#check @Anchored.AnchorSafety.last_route_removal_seals
#check @Anchored.GlobalLayer.hub_determined_network_inherits_blind_spot
#check @Anchored.correctable_population_ceiling

/-! ## Boundaries: what cannot be dropped

Each premise of the open-ended loop is shown to be necessary by a
countermodel: without a seed nothing happens, without successors there is one
innovation and then stasis, without retention there is endless novelty but no
accumulation. A fixed finite space saturates, so open-endedness needs an
ever-widening range of distinctions. A new whole cannot pay for its own parts,
so intermediates need support from elsewhere. -/

#check @RecursiveAccessibility.uniformCritical_and_retention_without_seed_not_enough
#check @RecursiveAccessibility.seed_and_retention_without_criticality_not_enough
#check @RecursiveAccessibility.recurringRecursiveEmergence_without_retention_not_cumulative
#check @RecursiveAccessibility.finite_generative_closure_saturates
#check @RecursiveAccessibility.openEndedNovelty_implies_unboundedEnvelopeCapacity
#check @EmergentAssemblyBarrier.viable_emergent_intermediate_requires_auxiliary_support

/-! ## Axiom audit -/

#print axioms Anchored.PersistenceFirst.persistence_requires_correction_within
#print axioms Anchored.PersistenceFirst.sealing_is_fatal_after_buffer
#print axioms Anchored.PersistenceFirst.interdependence_and_persistence_force_correctability
#print axioms Anchored.PersistenceFirst.persistence_replaces_the_aim
#print axioms Anchored.PersistenceFirst.reciprocity_is_load_bearing
#print axioms RecursiveAccessibility.open_world_forces_unbounded_repertoire
#print axioms RecursiveAccessibility.persistence_in_open_world_requires_unbounded_capture
#print axioms RecursiveAccessibility.internallyViableAt_iff_internalSlack_nonneg
#print axioms RecursiveAccessibility.organization_improvement_increases_endogenousResponseBudget
#print axioms CumulativeReproduction.self_financing_never_binds
#print axioms CumulativeReproduction.no_runaway_when_upkeep_exceeds_capture
#print axioms CumulativeReproduction.critical_mass_dichotomy
#print axioms GenerativeLeverage.candidate_set_exceeding_budget_cannot_all_be_retained
#print axioms TransitionAccessibility.kernelDominance_preserves_accessibility
#print axioms TransitionAccessibility.positivePaidOpening_requires_kernel_advantage
#print axioms TransitionAccessibility.route_saving_exceeds_marginal_upkeep_opens_paid_window
#print axioms TransitionAccessibility.no_paidOpening_without_kernel_change
#print axioms RecursiveAccessibility.retained_intermediate_creates_second_round_access
#print axioms RecursiveAccessibility.new_parent_set_implies_secondOrderClick
#print axioms RecursiveAccessibility.dynamicVortexTurn_opens_budget_and_futureSearch
#print axioms RecursiveAccessibility.recurringOpportunity_and_endogenousVortexResponse_imply_fullDynamicConsequences
#print axioms RecursiveAccessibility.vortex_full_dynamic_witness
#print axioms FunctionalOrganization.mechanisticRatchetVelocity_zero_no_retention
#print axioms FunctionalOrganization.mechanisticRatchetVelocity_mono_retention
#print axioms FunctionalOrganization.boundedMechanism_implies_blockAverageRateFloor
#print axioms FunctionalOrganization.shorterResponseLag_strictlyRaises_rateFloor
#print axioms FunctionalOrganization.more_search_can_reduce_velocity
#print axioms PersistenceDrift.two_type_linear_cost_slack_strict
#print axioms PersistenceDrift.two_type_cost_selection_search_strict
#print axioms RecursiveAccessibility.internalSlack_eq_sum_partSlack
#print axioms RecursiveAccessibility.internallyViable_iff_exists_viable_transfer
#print axioms RecursiveAccessibility.nonviable_vortex_zero_velocity
#print axioms Anchored.anchor_not_two
#print axioms Anchored.live_and_aim_force_strong_connectivity
#print axioms Anchored.built_correctable
#print axioms Anchored.AnchorSafety.last_route_removal_seals
#print axioms Anchored.GlobalLayer.hub_determined_network_inherits_blind_spot
#print axioms Anchored.correctable_population_ceiling
#print axioms RecursiveAccessibility.uniformCritical_and_retention_without_seed_not_enough
#print axioms RecursiveAccessibility.seed_and_retention_without_criticality_not_enough
#print axioms RecursiveAccessibility.recurringRecursiveEmergence_without_retention_not_cumulative
#print axioms RecursiveAccessibility.finite_generative_closure_saturates
#print axioms RecursiveAccessibility.openEndedNovelty_implies_unboundedEnvelopeCapacity
#print axioms EmergentAssemblyBarrier.viable_emergent_intermediate_requires_auxiliary_support
