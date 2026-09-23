import AnchoredEvolution.Bridge
import AnchoredEvolution.Witness
import AnchoredEvolution.Operational
import AnchoredEvolution.Semantics
import AnchoredEvolution.Tracking
import AnchoredEvolution.Network
import AnchoredEvolution.SemanticComposition
import AnchoredEvolution.UnifiedTracking
import AnchoredEvolution.DynamicEvidence
import AnchoredEvolution.ModelProcess
import AnchoredEvolution.RelayProcess
import AnchoredEvolution.Realization
import AnchoredEvolution.NetworkEconomics
import AnchoredEvolution.Persistence
import AnchoredEvolution.SCAP

/-!
# Axiom audit of the anchored development

Each headline theorem prints its axiom dependencies.

* `propext` and `Quot.sound` are standard foundations of Lean.
* `Classical.choice` marks a proof that uses excluded middle.
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
-- Layer 1d: answer graph, evidence, content tracking, best-case cost
#print axioms Tracking.answer_edge_is_responsive_edge
#print axioms Tracking.answer_correctable_implies_correctable
#print axioms Tracking.unanswered_voice_breaks
#print axioms Tracking.candidates_shrink
#print axioms Tracking.scenario_removed_only_by_evidence
#print axioms Tracking.evidence_settles_room
#print axioms Tracking.minimal_toward_rival_blocks
#print axioms Tracking.content_insensitive_cannot_track
#print axioms Tracking.tracks_implies_answerable
#print axioms Tracking.always_inclusive_answers_but_does_not_track
#print axioms Tracking.tracking_witness
#print axioms Tracking.tc_rivals
#print axioms Tracking.least_cost_exists
#print axioms Tracking.least_time_exists
#print axioms Tracking.cost_time_tradeoff
-- Layer 1e: one correction law for one, two, three, four … models
#print axioms Network.open_tracks
#print axioms Network.same_revision_blocks
#print axioms Network.insensitive_model_cannot_track
#print axioms Network.honest_comp
#print axioms Network.via_honest_tracks
#print axioms Network.confusing_channel_blocks
#print axioms Network.provenance
#print axioms Network.relay_honest
#print axioms Network.honest_network_tracks
#print axioms Network.blind_cut
#print axioms Network.blind_cut_blocks
#print axioms Network.ring_tracks
#print axioms Network.group_tracks
#print axioms Network.closed_door_breaks
#print axioms Network.solo_tracking_iff
#print axioms Network.aggregation_under_anchor
#print axioms Network.sound_tree_tracks
#print axioms Network.tree_provenance
#print axioms Network.twoPairsTree_sound
#print axioms Network.four_person_benchmark
#print axioms Network.pairs_position_blocks
-- Layer 3b: semantic composition across process boundaries
#print axioms SemanticComposition.hfaithful_compatible_iff
#print axioms SemanticComposition.hfaithful_incompatible_iff
#print axioms SemanticComposition.Embedding.liftRun
#print axioms SemanticComposition.Embedding.admits_preserved
#print axioms SemanticComposition.Embedding.answerWithin_preserved
#print axioms SemanticComposition.Embedding.answerable_preserved
#print axioms SemanticComposition.answerable_through_two_levels
-- Unification bridge: one relation-level tracking law + exact interfaces
#print axioms UnifiedTracking.operational_tracks_iff_transition_tracksAt_of_live
#print axioms UnifiedTracking.model_tracking_iff_transition_tracking
#print axioms UnifiedTracking.faithful_channel_is_live_sharpening
#print axioms UnifiedTracking.faithful_channel_compatible_iff
#print axioms UnifiedTracking.faithful_channel_incompatible_iff
#print axioms UnifiedTracking.via_faithful_tracks
-- Dynamic evidence-aware resolution
#print axioms DynamicEvidence.resolved_of_live_iff_admits
#print axioms DynamicEvidence.not_live_is_resolved
#print axioms DynamicEvidence.answerWithin_implies_dynamic_static
#print axioms DynamicEvidence.evidential_refutation_answers
#print axioms DynamicEvidence.resolution_is_admission_or_evidence
#print axioms DynamicEvidence.live_dynamic_resolution_requires_admission
-- Concrete local compiler from a scale-free model to an executable process
#print axioms ModelProcess.challenge_step
#print axioms ModelProcess.revision_step
#print axioms ModelProcess.after_challenge_cases
#print axioms ModelProcess.compiled_tracks_of_live
#print axioms ModelProcess.compiled_answerWithin_two
#print axioms ModelProcess.compiled_answerable_of_live
-- Executable multi-hop relay process and quantitative bound
#print axioms RelayProcess.faithfulRoute_live
#print axioms RelayProcess.faithfulRoute_refines
#print axioms RelayProcess.faithfulRoute_iff
#print axioms RelayProcess.challenge_step
#print axioms RelayProcess.relay_step
#print axioms RelayProcess.revision_step
#print axioms RelayProcess.relay_run
#print axioms RelayProcess.relay_revision_run
#print axioms RelayProcess.answerWithin_route
#print axioms RelayProcess.answerable_route
#print axioms RelayProcess.zero_hop_two_step
-- Layer 1f: graph-indexed realization on Layer-1b processes
#print axioms Realization.ReachIn.trans
#print axioms Realization.one_hop_is_edge
#print axioms Realization.latency_one_forces_complete
#print axioms Realization.ring_forced
#print axioms Realization.ring_latency_lower
#print axioms Realization.ring_latency_attained
#print axioms Realization.ring_within
#print axioms Realization.run_append
#print axioms Realization.episode_run
#print axioms Realization.episode_correction
#print axioms Realization.implemented_hop_within
#print axioms Realization.implemented_correctable
#print axioms Realization.relay_run
#print axioms Realization.voice_admitted_within
#print axioms Realization.voice_admitted_within_faithful
#print axioms Realization.solo_voice_within
#print axioms Realization.flat_voice_within
#print axioms Realization.ring_voice_within
#print axioms Realization.solo_voice_within_faithful
#print axioms Realization.flat_voice_within_faithful
#print axioms Realization.ring_voice_within_faithful
#print axioms Realization.ring_self_financing
#print axioms Realization.flat_ceiling
#print axioms Realization.latency_upkeep_frontier
#print axioms Realization.canonical_implements
#print axioms Realization.canonical_correctable
#print axioms Realization.canonical_ring_voice
-- Network economics: topology trade-off + CRM link budget
#print axioms NetworkEconomics.paired_four_half_links
#print axioms NetworkEconomics.paired_four_half_maintenance
#print axioms NetworkEconomics.paired_four_latency_tradeoff
#print axioms NetworkEconomics.faithful_route_profile_answers
#print axioms NetworkEconomics.link_affordable_iff_ledger
#print axioms NetworkEconomics.affordable_links_bounded_by_cap
#print axioms NetworkEconomics.self_financing_links_unbounded
#print axioms NetworkEconomics.links_above_cap_unaffordable
#print axioms NetworkEconomics.paired_fits_when_flat_does_not
-- Layer 6: persistence, shared reality, repair, reflexivity
#print axioms Persistence.deaf_must_be_vacuous
#print axioms Persistence.sealed_constraint_fails
#print axioms Persistence.rigid_informative_fails
#print axioms Persistence.learner_in_step
#print axioms Persistence.learning_witness
#print axioms Persistence.same_component_same_reality
#print axioms Persistence.shared_reality_when_connected
#print axioms Persistence.reliable_realities_compatible
#print axioms Persistence.disjoint_realities_imply_false_evidence
#print axioms Persistence.disjoint_realities_not_both_true
#print axioms Persistence.empty_reality_signals_false_evidence
#print axioms Persistence.hidden_versus_revealed_conflict
#print axioms Persistence.no_repair_split_permanent
#print axioms Persistence.repair_bounds_delay
#print axioms Persistence.forgiveness_turns_split_into_delay
#print axioms Persistence.self_fulfilment_is_not_verification
#print axioms Persistence.sealed_narrative_fails
-- SCAP top-level invariant and persistence theorem
#print axioms SCAP.faithful_id
#print axioms SCAP.faithful_comp
#print axioms SCAP.relayN_faithful
#print axioms SCAP.faithful_route_exists
#print axioms SCAP.members_in_step
#print axioms SCAP.persistent_faithful_access
#print axioms SCAP.implemented_scap_correctable
#print axioms SCAP.scap_persistent_correctability
