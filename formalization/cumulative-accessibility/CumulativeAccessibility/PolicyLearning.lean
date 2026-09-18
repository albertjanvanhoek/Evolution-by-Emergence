import CumulativeAccessibility.PolicyImprovement

namespace CumulativeAccessibility
namespace FunctionalOrganization

/-!
# Policy learning across retained and held-out organizational states

A state-dependent policy can outperform a fixed action without learning its own
rule. PolicyImprovement.lean therefore stops short of recursive self-improvement.

This file adds the next interface.

A policy-learning improvement must:

1. weakly preserve functional rate on a declared retained-state family;
2. strictly improve functional rate on a declared held-out state family.

An endogenous policy-learning improvement additionally requires the old policy
to generate and apply the intervention that produces the new policy.

The concrete two-state witness uses:

* symmetricOrganization as the retained/training state;
* validationRichOrganization as the changed held-out state.

The fixed half-half rule and bottleneck-aware rule choose the same action in the
symmetric state, while the bottleneck-aware rule is strictly faster in the
validation-rich state.

This is a minimal generalization witness. It does not prove that a real learner
can infer the bottleneck policy from data.
-/

/-- Policy improvement that preserves declared previously handled states and
strictly improves on a declared held-out state family. -/
def HeldOutPolicyLearningImprovementOn
    (retainedStates heldOutStates : Set State)
    (targets : Set Target)
    (Landscape : FunctionalRateLandscape State Action Target)
    (oldPolicy newPolicy : RatePolicy State Action) : Prop :=
  FunctionalPolicyDominatesOn
      retainedStates targets Landscape oldPolicy newPolicy ∧
    StrictFunctionalPolicyImprovementOn
      heldOutStates targets Landscape oldPolicy newPolicy

/-- Endogenous policy learning: the old policy generates and applies an
intervention that produces a held-out policy-learning improvement. -/
def EndogenousPolicyLearningImprovementOn
    (retainedStates heldOutStates : Set State)
    (targets : Set Target)
    (Landscape : FunctionalRateLandscape State Action Target)
    (Generate : RatePolicy State Action → I → Prop)
    (Apply :
      RatePolicy State Action → I → RatePolicy State Action → Prop)
    (oldPolicy newPolicy : RatePolicy State Action) : Prop :=
  ∃ intervention,
    Generate oldPolicy intervention ∧
    Apply oldPolicy intervention newPolicy ∧
    HeldOutPolicyLearningImprovementOn
      retainedStates heldOutStates targets Landscape
      oldPolicy newPolicy

/-- Single retained state for the concrete policy-learning witness. -/
def SymmetricRetainedStateFamily : Set TwoStageOrganization :=
  { state | state = symmetricOrganization }

/-- Single changed state used as held-out evaluation. -/
def ValidationRichHeldOutStateFamily : Set TwoStageOrganization :=
  { state | state = validationRichOrganization }

/-- The fixed and bottleneck-aware policies choose the same allocation at the
retained symmetric state. -/
theorem fixedHalf_and_bottleneck_agree_at_symmetric :
    FixedHalfRatePolicy symmetricOrganization =
      BottleneckRatePolicy symmetricOrganization := by
  rw [bottleneckRatePolicy_on_witness_states.1]
  rfl

/-- The bottleneck-aware policy therefore preserves the scalar-lifted
functional rate on the retained symmetric state. -/
theorem bottleneckPolicy_preserves_fixedHalf_on_retained_state :
    FunctionalPolicyDominatesOn
      SymmetricRetainedStateFamily
      UnitTargetFamily
      (LiftScalarRateLandscape TwoStageRateLandscape)
      FixedHalfRatePolicy
      BottleneckRatePolicy := by
  intro state hState target hTarget
  have hStateEq : state = symmetricOrganization := hState
  subst state
  rw [fixedHalf_and_bottleneck_agree_at_symmetric]

/-- On the validation-rich held-out state, the state-sensitive policy strictly
improves the one-target functional-rate profile. -/
theorem bottleneckPolicy_strictlyImproves_fixedHalf_on_heldOut_state :
    StrictFunctionalPolicyImprovementOn
      ValidationRichHeldOutStateFamily
      UnitTargetFamily
      (LiftScalarRateLandscape TwoStageRateLandscape)
      FixedHalfRatePolicy
      BottleneckRatePolicy := by
  constructor
  · intro state hState target hTarget
    have hStateEq : state = validationRichOrganization := hState
    subst state
    have hPolicy := bottleneckRatePolicy_on_witness_states.2
    have hPreference :=
      allocation_preference_reverses_across_states.2
    simpa [ActionRateDominatesOn, LiftScalarRateLandscape,
      FixedHalfRatePolicy, hPolicy] using le_of_lt hPreference
  · refine ⟨validationRichOrganization, rfl, (), ?_, ?_⟩
    · trivial
    · have hPolicy := bottleneckRatePolicy_on_witness_states.2
      have hPreference :=
        allocation_preference_reverses_across_states.2
      simpa [LiftScalarRateLandscape,
        FixedHalfRatePolicy, hPolicy] using hPreference

/-- Concrete held-out policy-learning witness.

The new rule does not sacrifice rate on the old symmetric state and is strictly
better after the organizational state changes. -/
theorem bottleneckPolicy_is_heldOut_learning_improvement :
    HeldOutPolicyLearningImprovementOn
      SymmetricRetainedStateFamily
      ValidationRichHeldOutStateFamily
      UnitTargetFamily
      (LiftScalarRateLandscape TwoStageRateLandscape)
      FixedHalfRatePolicy
      BottleneckRatePolicy := by
  exact ⟨
    bottleneckPolicy_preserves_fixedHalf_on_retained_state,
    bottleneckPolicy_strictlyImproves_fixedHalf_on_heldOut_state
  ⟩

/-- Any held-out policy-learning improvement necessarily contains an explicit
held-out state-target witness on which the new rule is faster. -/
theorem heldOutPolicyLearningImprovement_has_faster_heldOut_witness
    (retainedStates heldOutStates : Set State)
    (targets : Set Target)
    (Landscape : FunctionalRateLandscape State Action Target)
    (oldPolicy newPolicy : RatePolicy State Action)
    (h :
      HeldOutPolicyLearningImprovementOn
        retainedStates heldOutStates targets Landscape
        oldPolicy newPolicy) :
    ∃ state ∈ heldOutStates, ∃ target ∈ targets,
      Landscape state (oldPolicy state) target <
        Landscape state (newPolicy state) target :=
  strictFunctionalPolicyImprovement_has_witness
    heldOutStates targets Landscape oldPolicy newPolicy h.2

/-- Endogenous policy learning implies ordinary held-out policy learning. -/
theorem endogenousPolicyLearning_implies_heldOutImprovement
    (retainedStates heldOutStates : Set State)
    (targets : Set Target)
    (Landscape : FunctionalRateLandscape State Action Target)
    (Generate : RatePolicy State Action → I → Prop)
    (Apply :
      RatePolicy State Action → I → RatePolicy State Action → Prop)
    (oldPolicy newPolicy : RatePolicy State Action)
    (h :
      EndogenousPolicyLearningImprovementOn
        retainedStates heldOutStates targets Landscape
        Generate Apply oldPolicy newPolicy) :
    HeldOutPolicyLearningImprovementOn
      retainedStates heldOutStates targets Landscape
      oldPolicy newPolicy := by
  rcases h with ⟨intervention, hGenerate, hApply, hImprove⟩
  exact hImprove

/-- Conditional bridge from the checked bottleneck-policy learning witness to
an endogenous policy-learning result.

The formal core intentionally leaves generation/application of the policy
change uninterpreted. A domain model must supply those premises. -/
theorem endogenous_bottleneckPolicy_learning_of_generated_update
    (Generate :
      RatePolicy TwoStageOrganization ℝ → I → Prop)
    (Apply :
      RatePolicy TwoStageOrganization ℝ →
        I → RatePolicy TwoStageOrganization ℝ → Prop)
    (intervention : I)
    (hGenerate : Generate FixedHalfRatePolicy intervention)
    (hApply :
      Apply FixedHalfRatePolicy intervention BottleneckRatePolicy) :
    EndogenousPolicyLearningImprovementOn
      SymmetricRetainedStateFamily
      ValidationRichHeldOutStateFamily
      UnitTargetFamily
      (LiftScalarRateLandscape TwoStageRateLandscape)
      Generate Apply
      FixedHalfRatePolicy
      BottleneckRatePolicy := by
  exact ⟨
    intervention,
    hGenerate,
    hApply,
    bottleneckPolicy_is_heldOut_learning_improvement
  ⟩

#print axioms fixedHalf_and_bottleneck_agree_at_symmetric
#print axioms bottleneckPolicy_preserves_fixedHalf_on_retained_state
#print axioms bottleneckPolicy_strictlyImproves_fixedHalf_on_heldOut_state
#print axioms bottleneckPolicy_is_heldOut_learning_improvement
#print axioms heldOutPolicyLearningImprovement_has_faster_heldOut_witness
#print axioms endogenousPolicyLearning_implies_heldOutImprovement
#print axioms endogenous_bottleneckPolicy_learning_of_generated_update

end FunctionalOrganization
end CumulativeAccessibility
