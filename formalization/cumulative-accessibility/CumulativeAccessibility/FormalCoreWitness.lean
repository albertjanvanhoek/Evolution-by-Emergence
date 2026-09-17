import CumulativeAccessibility.MaintenanceOpportunityBridge
import CumulativeAccessibility.MaintenanceGatedWitness

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Concrete witness for the closed formal core

The cross-stack theorems are conditional, so this file checks that their
premises can be inhabited simultaneously.  The witness deliberately uses the
already simple progressive accessibility architecture and a permissive external
criterion; its purpose is logical non-vacuity, not biological realism.

For maintenance we choose

    rA = rB = rC = 1/2
    kAB = kBC = kCA = 1.

All self-retentions are nonnegative, all maintenance deficits are positive,
and the closed-loop product is strictly supercritical:

    (1/2)^3 = 1/8 < 1.

The progressive architecture realizes a new accepted candidate at every time,
so it satisfies the opportunity-conditioned response for *any* opportunity
stream, including the concrete maintenance stream.
-/

/-- The progressive architecture realizes an accepted new retained candidate
at every time. Therefore it satisfies the validated-response premise for any
chosen opportunity predicate; the opportunity hypothesis is not even needed by
this deliberately strong witness. -/
theorem progressiveArchitecture_realizesValidatedAtEveryOpportunity
    (Opportunity : ℕ → Prop) :
    OpportunityConditionedValidatedRealization
      Opportunity
      progressiveEnvelope progressiveGenerator acceptAllCriterion
      progressiveRepertoire := by
  intro m hOpportunity
  refine ⟨m + 1, ?_, ?_, ?_, ?_, ?_⟩
  · simp [progressiveEnvelope]
  · simp [progressiveRepertoire]
  · refine ⟨{m}, ?_, ?_⟩
    · intro x hx
      have hxm : x = m := by simpa using hx
      subst x
      simp [progressiveRepertoire]
    · simp [progressiveGenerator]
  · simp [acceptAllCriterion]
  · simp [progressiveRepertoire]

/-- Fully concrete non-vacuity witness for the cross-stack theorem.

A positive strict three-cycle maintenance process supplies recurrent
availability; the progressive architecture converts every such opportunity
into externally accepted retained novelty; monotone retention then yields
open-ended cumulative novelty. -/
theorem concreteMaintenanceToValidatedNoveltyWitness :
    OpenEndedCumulativeNovelty progressiveRepertoire := by
  apply strictCycle3Maintenance_and_validatedResponse_imply_openEndedNovelty
    (rA := (1 / 2 : ℝ)) (rB := (1 / 2 : ℝ)) (rC := (1 / 2 : ℝ))
    (kAB := 1) (kBC := 1) (kCA := 1)
    progressiveEnvelope progressiveGenerator acceptAllCriterion
    progressiveRepertoire
  · norm_num
  · norm_num
  · norm_num
  · norm_num [CollectiveAlignment.maintenanceDeficit]
  · norm_num [CollectiveAlignment.maintenanceDeficit]
  · norm_num [CollectiveAlignment.maintenanceDeficit]
  · norm_num
  · norm_num
  · norm_num
  · norm_num [CollectiveAlignment.maintenanceDeficit]
  · exact progressiveRepertoire_retained
  · exact progressiveArchitecture_realizesValidatedAtEveryOpportunity
      (cycle3MaintenanceOpportunity
        (1 / 2 : ℝ) (1 / 2 : ℝ) (1 / 2 : ℝ) 1 1 1)

/-- The same concrete architecture also realizes the necessary unbounded
moving-envelope consequence. -/
theorem concreteMaintenanceToValidatedNoveltyWitness_unbounded :
    UnboundedEnvelopeCapacity progressiveEnvelope := by
  apply openEndedNovelty_implies_unboundedEnvelopeCapacity
    progressiveEnvelope progressiveRepertoire
    progressiveRepertoire_represented progressiveRepertoire_retained
  exact concreteMaintenanceToValidatedNoveltyWitness

#print axioms progressiveArchitecture_realizesValidatedAtEveryOpportunity
#print axioms concreteMaintenanceToValidatedNoveltyWitness
#print axioms concreteMaintenanceToValidatedNoveltyWitness_unbounded

end RecursiveAccessibility
end CumulativeAccessibility
