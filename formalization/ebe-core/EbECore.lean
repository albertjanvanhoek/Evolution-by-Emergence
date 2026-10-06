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
import CumulativeAccessibility.AdaptivePersistence
import MaintenanceDynamics
import CollectiveAlignment
import AnchoredEvolution.CumulativeReproduction
import AnchoredEvolution.Anchor
import AnchoredEvolution.Composition
import AnchoredEvolution.Bridge
import AnchoredEvolution.AnchorSafety
import AnchoredEvolution.GlobalLayer
import AnchoredEvolution.Persistence
import AnchoredEvolution.RoomInOneHead
import PersistenceDrift
import FunctionalCompetition
import FunctionalThresholds
import ReturnPathPrice

/-!
# Evolution by Emergence: the core in one file

This file adds no mathematics. It collects, in one place, the machine-checked
results that carry the core of Evolution by Emergence, in the order of
`CORE.md` at the repository root. Every result lives in its own package and is
proved there; this file imports them, prints each statement (`#check`) and
prints its axioms (`#print axioms`), so CI fails if any of them stops compiling
or depends on `sorry`.

## Where the model comes from

Intelligence is a training loop in a neural network. When a brain learns, it
mainly changes the connections between its neurons rather than the neurons
themselves, so capacity is a configuration of connections. Feedback from outside
adjusts the connections, what works is kept, and what is kept becomes material
for what can be learned next, at a cost and with finite capacity. Artificial
neural networks recreate this loop in their weights. Because learning rewires
rather than grows, adapting is comparatively cheap, and a configuration can pass
from one network to another. The question was whether this loop is special to
neural networks. The answer proposed here is that the same structure describes
any configuration that persists in a world that does not hold still.

## The story, in the order of the sections below

1. Existence is a process paid for from a gradient: the ledger.
2. Things exist through their connections: remove a return path and the node
   declines.
3. Selection comes free: under selection on cost, cost falls and slack rises.
4. A changing world requires reconfiguration: a sealed configuration runs out
   of reserve; one that follows reliable feedback persists.
5. The learning loop becomes the vortex: feedback plus retention makes search
   cheap; kept changes that pay for themselves widen what can be tried next.
6. The commons and capture: transfers decide survival, not size; extraction is
   survivable only within the host's margin; what is selected can fall short of
   what is sufficient.
7. Boundaries: the vortex can stop.
8. One domain worked out: intelligence.

Everything below is a conditional statement under the premises named in each
theorem. Machine checking establishes the implications, not that a given real
system satisfies the premises.
-/

open CumulativeAccessibility

/-! ## 1. Existence is paid for from a gradient

A configuration is viable exactly while its slack, uptake minus upkeep, is
nonnegative. Retained items that pay their own upkeep never meet a ceiling;
otherwise a ceiling exists and cannot be outgrown. A repertoire whose critical
mass is unaffordable goes extinct. A finite budget cannot keep every
candidate, so forgetting is forced. -/

#check @RecursiveAccessibility.internallyViableAt_iff_internalSlack_nonneg
#check @CumulativeReproduction.self_financing_never_binds
#check @CumulativeReproduction.no_runaway_when_upkeep_exceeds_capture
#check @CumulativeReproduction.critical_mass_dichotomy
#check @CumulativeReproduction.unaffordable_critical_mass_extinct
#check @GenerativeLeverage.candidate_set_exceeding_budget_cannot_all_be_retained

/-! ## 2. Existence through connections

Three processes, none of which can maintain itself alone, keep a positive
support floor at every time when they maintain one another around a cycle.
Delete the return edge and the node it fed declines. -/

#check @CollectiveAlignment.cycle3Trajectory_has_positive_support_floor
#check @CollectiveAlignment.deleting_return_edge_makes_source_decline

/-! ## 3. Selection comes free

When fitness falls with cost, selection lowers mean cost; among
implementations that do the same job, competition strictly raises slack, which
can fund more search. Selection selects what persists, not what is good. -/

#check @FunctionalCompetition.mean_cost_nonincreasing
#check @PersistenceDrift.two_type_linear_cost_slack_strict
#check @PersistenceDrift.two_type_cost_selection_search_strict

/-! ## 4. A changing world requires reconfiguration

A configuration whose fit is fixed in advance and rules something out exhausts
its finite reserve in some possible future when misfit costs slack. A
configuration that follows reliable feedback keeps a nonnegative reserve when
fitting pays. Both hold on the vortex ledger. -/

#check @AdaptivePersistence.sealed_configuration_does_not_persist
#check @AdaptivePersistence.listening_configuration_persists
#check @AdaptivePersistence.sealed_configuration_fails_on_vortex_ledger
#check @AdaptivePersistence.listening_persists_on_vortex_ledger

/-! ## 5. The learning loop becomes the vortex

Feedback on each part plus retention of what is found reduces search from
`q ^ k` to `k * q`. Better organization raises the budget for change. A
retained item counts as cumulative only if it opens more than it costs; kept
products become parents for the next round (a second-order click). A turn is a
kept change that both raises slack and widens search; recurring turns give
open-ended accumulation. The speed is a product of opportunity, generation,
affordability, validation, retention and gain: any zero factor stops it, and
more search alone can lower it. -/

#check @CumulativeReproduction.scaffolded_search_cost
#check @CumulativeReproduction.scaffold_strict
#check @RecursiveAccessibility.organization_improvement_increases_endogenousResponseBudget
#check @TransitionAccessibility.kernelDominance_preserves_accessibility
#check @TransitionAccessibility.positivePaidOpening_requires_kernel_advantage
#check @TransitionAccessibility.route_saving_exceeds_marginal_upkeep_opens_paid_window
#check @TransitionAccessibility.no_paidOpening_without_kernel_change
#check @RecursiveAccessibility.retained_intermediate_creates_second_round_access
#check @RecursiveAccessibility.new_parent_set_implies_secondOrderClick
#check @RecursiveAccessibility.dynamicVortexTurn_opens_budget_and_futureSearch
#check @RecursiveAccessibility.recurringOpportunity_and_endogenousVortexResponse_imply_fullDynamicConsequences
#check @RecursiveAccessibility.vortex_full_dynamic_witness
#check @FunctionalOrganization.mechanisticRatchetVelocity_zero_no_retention
#check @FunctionalOrganization.mechanisticRatchetVelocity_mono_retention
#check @FunctionalOrganization.boundedMechanism_implies_blockAverageRateFloor
#check @FunctionalOrganization.shorterResponseLag_strictlyRaises_rateFloor
#check @FunctionalOrganization.more_search_can_reduce_velocity

/-! ## 6. The commons and capture

Inside a network, transfers between parts cancel: they decide which parts can
cover their upkeep, never the size of the whole, and a transfer can break a
part while the whole is unchanged. A non-viable whole stalls. A host survives
one-way extraction exactly while the extraction stays within its margin. A
bad return path can overwhelm selection, and privately selected effort can fall
below what the network needs. A new whole cannot pay for its own parts while it
is being assembled; it needs support from elsewhere. -/

#check @RecursiveAccessibility.internalSlack_eq_sum_partSlack
#check @RecursiveAccessibility.internallyViable_iff_exists_viable_transfer
#check @RecursiveAccessibility.transfer_breaks_part_with_whole_unchanged
#check @RecursiveAccessibility.nonviable_vortex_zero_velocity
#check @FunctionalThresholds.extraction_viable_iff
#check @ReturnPathPrice.mean_fitness_decreases_of_return_below_selection
#check @CollectiveAlignment.selectedAlignment_insufficient_if
#check @EmergentAssemblyBarrier.viable_emergent_intermediate_requires_auxiliary_support

/-! ## 7. Boundaries: the vortex can stop

Without a seed nothing happens; without successors there is one innovation and
then stasis; without retention there is novelty but no accumulation. A fixed
finite space saturates, so open-endedness needs an ever-widening range of
distinctions. -/

#check @RecursiveAccessibility.uniformCritical_and_retention_without_seed_not_enough
#check @RecursiveAccessibility.seed_and_retention_without_criticality_not_enough
#check @RecursiveAccessibility.recurringRecursiveEmergence_without_retention_not_cumulative
#check @RecursiveAccessibility.finite_generative_closure_saturates
#check @RecursiveAccessibility.openEndedNovelty_implies_unboundedEnvelopeCapacity

/-! ## 8. One domain worked out: intelligence

For systems that model the world, the same structure takes a specific form.
Incompatible claims cannot all be true, whether held by different people or by
one person at different times: someone who converts holds incompatible
certainties with the same neurons, so certainty is a configuration of the web,
not a certificate of truth. A record fixed in advance is out of
step in some future unless it rules nothing out, while a record that follows
reliable evidence stays in step. What an agent can know is what reaches it
along its connections, and connected agents share one reality. Compliance
cannot verify a narrative. A network stays correctable only if every live error
remains findable; correctable parts joined by correctable interfaces stay
correctable; removing the last route that can reveal an error seals it; a
shared layer that determines every node passes on its blind spots; correction
routes pay upkeep from the same ledger. -/

#check @Anchored.anchor_not_two
#check @Anchored.RoomInOneHead.room_in_one_head
#check @Anchored.RoomInOneHead.certainty_is_not_a_certificate
#check @Anchored.Persistence.sealed_constraint_fails
#check @Anchored.Persistence.learner_in_step
#check @Anchored.Persistence.shared_reality_when_connected
#check @Anchored.Persistence.self_fulfilment_is_not_verification
#check @Anchored.live_and_aim_force_strong_connectivity
#check @Anchored.built_correctable
#check @Anchored.AnchorSafety.last_route_removal_seals
#check @Anchored.GlobalLayer.hub_determined_network_inherits_blind_spot
#check @Anchored.correctable_population_ceiling

/-! ## Axiom audit -/

#print axioms RecursiveAccessibility.internallyViableAt_iff_internalSlack_nonneg
#print axioms CumulativeReproduction.self_financing_never_binds
#print axioms CumulativeReproduction.no_runaway_when_upkeep_exceeds_capture
#print axioms CumulativeReproduction.critical_mass_dichotomy
#print axioms CumulativeReproduction.unaffordable_critical_mass_extinct
#print axioms GenerativeLeverage.candidate_set_exceeding_budget_cannot_all_be_retained
#print axioms CollectiveAlignment.cycle3Trajectory_has_positive_support_floor
#print axioms CollectiveAlignment.deleting_return_edge_makes_source_decline
#print axioms FunctionalCompetition.mean_cost_nonincreasing
#print axioms PersistenceDrift.two_type_linear_cost_slack_strict
#print axioms PersistenceDrift.two_type_cost_selection_search_strict
#print axioms AdaptivePersistence.sealed_configuration_does_not_persist
#print axioms AdaptivePersistence.listening_configuration_persists
#print axioms AdaptivePersistence.sealed_configuration_fails_on_vortex_ledger
#print axioms AdaptivePersistence.listening_persists_on_vortex_ledger
#print axioms CumulativeReproduction.scaffolded_search_cost
#print axioms CumulativeReproduction.scaffold_strict
#print axioms RecursiveAccessibility.organization_improvement_increases_endogenousResponseBudget
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
#print axioms RecursiveAccessibility.internalSlack_eq_sum_partSlack
#print axioms RecursiveAccessibility.internallyViable_iff_exists_viable_transfer
#print axioms RecursiveAccessibility.transfer_breaks_part_with_whole_unchanged
#print axioms RecursiveAccessibility.nonviable_vortex_zero_velocity
#print axioms FunctionalThresholds.extraction_viable_iff
#print axioms ReturnPathPrice.mean_fitness_decreases_of_return_below_selection
#print axioms CollectiveAlignment.selectedAlignment_insufficient_if
#print axioms EmergentAssemblyBarrier.viable_emergent_intermediate_requires_auxiliary_support
#print axioms RecursiveAccessibility.uniformCritical_and_retention_without_seed_not_enough
#print axioms RecursiveAccessibility.seed_and_retention_without_criticality_not_enough
#print axioms RecursiveAccessibility.recurringRecursiveEmergence_without_retention_not_cumulative
#print axioms RecursiveAccessibility.finite_generative_closure_saturates
#print axioms RecursiveAccessibility.openEndedNovelty_implies_unboundedEnvelopeCapacity
#print axioms Anchored.anchor_not_two
#print axioms Anchored.RoomInOneHead.room_in_one_head
#print axioms Anchored.RoomInOneHead.certainty_is_not_a_certificate
#print axioms Anchored.Persistence.sealed_constraint_fails
#print axioms Anchored.Persistence.learner_in_step
#print axioms Anchored.Persistence.shared_reality_when_connected
#print axioms Anchored.Persistence.self_fulfilment_is_not_verification
#print axioms Anchored.live_and_aim_force_strong_connectivity
#print axioms Anchored.built_correctable
#print axioms Anchored.AnchorSafety.last_route_removal_seals
#print axioms Anchored.GlobalLayer.hub_determined_network_inherits_blind_spot
#print axioms Anchored.correctable_population_ceiling
