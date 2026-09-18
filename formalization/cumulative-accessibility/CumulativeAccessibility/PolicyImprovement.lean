import CumulativeAccessibility.FunctionalRatePolicy

namespace CumulativeAccessibility
namespace FunctionalOrganization

/-!
# Policy improvement as a learning-to-learn witness

A state-dependent policy is not automatically a self-improving policy. The rule
itself can remain fixed while selecting different actions in different states.

This file makes the next meta-level explicit by comparing two policy rules:

* a fixed half-half allocation policy;
* the state-sensitive bottleneck policy.

On a declared two-state test family, the adaptive policy weakly dominates the
fixed rule and is strictly faster in the validation-rich state.

This is a checked policy-improvement witness. It does not contain an endogenous
mechanism by which the old policy generates the new one, so it is not by itself
a recursive-self-improvement theorem.
-/

/-- Fixed half-half allocation rule. -/
noncomputable def FixedHalfRatePolicy :
    RatePolicy TwoStageOrganization ℝ :=
  fun _ => 1 / 2

/-- The two organizational states used as a minimal held-out policy test set. -/
def PolicyWitnessStateFamily : Set TwoStageOrganization :=
  { state |
      state = symmetricOrganization ∨
      state = validationRichOrganization }

/-- The adaptive bottleneck rule weakly dominates the fixed half-half rule on
both declared witness states in the one-target functional lift. -/
theorem bottleneckPolicy_dominates_fixedHalf_on_witnessStates :
    FunctionalPolicyDominatesOn
      PolicyWitnessStateFamily
      UnitTargetFamily
      (LiftScalarRateLandscape TwoStageRateLandscape)
      FixedHalfRatePolicy
      BottleneckRatePolicy := by
  intro state hState target hTarget
  rcases hState with hSym | hVal
  · subst state
    have hPolicy := bottleneckRatePolicy_on_witness_states.1
    simp [ActionRateDominatesOn, LiftScalarRateLandscape,
      FixedHalfRatePolicy, hPolicy]
  · subst state
    have hPolicy := bottleneckRatePolicy_on_witness_states.2
    have hPreference :=
      allocation_preference_reverses_across_states.2
    simpa [ActionRateDominatesOn, LiftScalarRateLandscape,
      FixedHalfRatePolicy, hPolicy] using le_of_lt hPreference

/-- The dominance is strict on the validation-rich witness state. -/
theorem bottleneckPolicy_strictlyImproves_fixedHalf_on_witnessStates :
    StrictFunctionalPolicyImprovementOn
      PolicyWitnessStateFamily
      UnitTargetFamily
      (LiftScalarRateLandscape TwoStageRateLandscape)
      FixedHalfRatePolicy
      BottleneckRatePolicy := by
  constructor
  · exact bottleneckPolicy_dominates_fixedHalf_on_witnessStates
  · refine ⟨validationRichOrganization, ?_, (), ?_, ?_⟩
    · exact Or.inr rfl
    · trivial
    · have hPolicy := bottleneckRatePolicy_on_witness_states.2
      have hPreference :=
        allocation_preference_reverses_across_states.2
      simpa [LiftScalarRateLandscape,
        FixedHalfRatePolicy, hPolicy] using hPreference

/-- The fixed half-half rule is optimal in the symmetric witness state. -/
theorem fixedHalfPolicy_optimal_at_symmetric_state :
    PolicyOptimalAt
      TwoStageRateLandscape UnitAllocationFeasible
      FixedHalfRatePolicy symmetricOrganization := by
  have hAdaptive :=
    bottleneckRatePolicy_optimalAt symmetricOrganization
  have hSame := bottleneckRatePolicy_on_witness_states.1
  simpa [FixedHalfRatePolicy, hSame] using hAdaptive

/-- The same fixed rule is not optimal after validation capacity has
accumulated. -/
theorem fixedHalfPolicy_not_optimal_at_validationRich_state :
    ¬ PolicyOptimalAt
      TwoStageRateLandscape UnitAllocationFeasible
      FixedHalfRatePolicy validationRichOrganization := by
  intro hOptimal
  have hCandidateFeasible :
      UnitAllocationFeasible (3 / 4 : ℝ) := by
    norm_num [UnitAllocationFeasible]
  have hBound :=
    hOptimal.2 (3 / 4 : ℝ) hCandidateFeasible
  have hPreference :=
    allocation_preference_reverses_across_states.2
  unfold TwoStageRateLandscape at hBound
  unfold FixedHalfRatePolicy at hBound
  exact (not_lt_of_ge hBound) hPreference

/-- Minimal policy-learning conclusion: a rule that is optimal at one
organizational state can become suboptimal after retained organization changes,
while a state-sensitive rule remains optimal at both witness states. -/
theorem learned_state_sensitivity_can_improve_policy :
    PolicyOptimalAt
        TwoStageRateLandscape UnitAllocationFeasible
        FixedHalfRatePolicy symmetricOrganization
    ∧
    ¬ PolicyOptimalAt
        TwoStageRateLandscape UnitAllocationFeasible
        FixedHalfRatePolicy validationRichOrganization
    ∧
    PolicyOptimalAt
        TwoStageRateLandscape UnitAllocationFeasible
        BottleneckRatePolicy symmetricOrganization
    ∧
    PolicyOptimalAt
        TwoStageRateLandscape UnitAllocationFeasible
        BottleneckRatePolicy validationRichOrganization := by
  exact ⟨
    fixedHalfPolicy_optimal_at_symmetric_state,
    fixedHalfPolicy_not_optimal_at_validationRich_state,
    bottleneckRatePolicy_optimalAt symmetricOrganization,
    bottleneckRatePolicy_optimalAt validationRichOrganization
  ⟩

#print axioms bottleneckPolicy_dominates_fixedHalf_on_witnessStates
#print axioms bottleneckPolicy_strictlyImproves_fixedHalf_on_witnessStates
#print axioms fixedHalfPolicy_optimal_at_symmetric_state
#print axioms fixedHalfPolicy_not_optimal_at_validationRich_state
#print axioms learned_state_sensitivity_can_improve_policy

end FunctionalOrganization
end CumulativeAccessibility
