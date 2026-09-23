import AnchoredEvolution.Bridge
import AnchoredEvolution.Witness
import AnchoredEvolution.Operational
import AnchoredEvolution.Semantics

/-!
# Axiom audit of the anchored development

Each headline theorem prints its axiom dependencies.

* `propext` and `Quot.sound` are standard foundations of Lean.
* `Classical.choice` marks a proof that uses excluded middle.  The anchor
  layer is constructive except for the two results labelled classical.
* `sorryAx` must never appear.
-/

open Anchored

-- Layer 0: the anchor
#print axioms anchor_not_two
#print axioms anchor_at_most_one
#print axioms anchor_others_wrong
#print axioms anchor_all_but_one_wrong
#print axioms anchor_lifts
#print axioms anchor_true
#print axioms anchor_has_no_true_rival
-- certainty is not a truth certificate (scenario version)
#print axioms live_rival_blocks_guarantee
#print axioms open_room_no_guarantee
#print axioms guarantee_would_refute_rivals
#print axioms factual_symmetry_fails_when_someone_is_right
-- Layer 1: the skeleton forced by the anchor
#print axioms live_and_aim_force_strong_connectivity
#print axioms missing_route_leaves_uncorrectable_error
-- Layer 2: minimal architecture
#print axioms sc_every_model_sends
#print axioms sc_every_model_receives
#print axioms ring_strongly_connected
#print axioms ring_out_unique
#print axioms ring_in_unique
-- Layer 3: composition and scale invariance
#print axioms Composite.composite_correctable
#print axioms Composite.interface_necessary
#print axioms Composite.sealed_outward_breaks
#print axioms Composite.sealed_inward_breaks
#print axioms built_correctable
#print axioms correction_through_others
-- Layer 4: dynamics
#print axioms correctable_after_iff_legitimate
#print axioms trajectory_correctable
#print axioms sealing_breaks
#print axioms isolation_breaks
#print axioms exclusion_with_detour_legitimate
-- Layer 5: ledger bridge
#print axioms correction_upkeep_lower_bound
#print axioms correctable_population_ceiling
#print axioms ring_affordable_iff
#print axioms self_financing_correction_unbounded
-- non-vacuity witnesses
#print axioms room_no_guarantee
#print axioms room_correctable
#print axioms level3_correctable
-- Operational layer: permissions, availability and cost derived from steps
#print axioms Operational.paper_constitution
#print axioms Operational.Process.derived_permission_executable
#print axioms Operational.Process.derived_challenge_executes
#print axioms Operational.Process.derived_appeal_executes
#print axioms Operational.heard_but_unanswerable
#print axioms Operational.Process.responsive_implies_restriction_clause
#print axioms Operational.Process.responsive_blocks_sealing
#print axioms Operational.Process.sealed_iff_no_finite_cost
#print axioms Operational.Process.sealed_unaffordable_at_every_budget
#print axioms Operational.Process.responsive_invariant
#print axioms Operational.Process.commons_responsive_correctable
#print axioms Operational.Process.operational_voice_sealed_breaks
#print axioms Operational.answeringDesk_responsive
#print axioms Operational.declared_available_but_sealed
-- Layer 1c: meaning, perspective, answering, self-model
#print axioms Semantic.views_anchor
#print axioms Semantic.represented_views_no_guarantee
#print axioms Semantic.room_applies_to_represented_claims
#print axioms Semantic.faithful_preserves_incompatibility
#print axioms Semantic.strengthening_preserves_incompatibility
#print axioms Semantic.weakening_reflects_incompatibility
#print axioms Semantic.overgeneralization_manufactures_conflict
#print axioms Semantic.caricature_dissolves_conflict
#print axioms Semantic.answer_requires_revision
#print axioms Semantic.first_revision
#print axioms Semantic.answerable_implies_responsive
#print axioms Semantic.unanswerable_challenge_fixes_error
#print axioms Semantic.executable_unanswerable_challenge_fixes_error
#print axioms Semantic.revised_but_unanswered
#print axioms Semantic.answeringDesk_answers
#print axioms Semantic.self_model_not_guaranteed
#print axioms Semantic.sealed_rule_fixes_error
