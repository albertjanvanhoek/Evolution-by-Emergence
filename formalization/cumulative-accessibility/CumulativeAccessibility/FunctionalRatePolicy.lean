import CumulativeAccessibility.ConstrainedRatePolicy

namespace CumulativeAccessibility
namespace FunctionalOrganization

/-!
# Vector-valued functional rate policy

The resource-allocation examples optimize a scalar projection of retained
ratchet velocity. The universal functional layer must not silently identify that
projection with "the amount of organization".

This file therefore lifts state-dependent control back to a target-indexed rate
landscape.

    state -> action -> functional target -> rate.

Actions and policies are compared by Pareto-like dominance on an explicitly
declared target family. Scalar optimization remains an application-specific
special case.

No claim is made here that a Pareto-undominated action is unique, or that every
application admits a single best action.
-/

/-- State- and action-conditioned functional-rate profile. -/
abbrev FunctionalRateLandscape
    (State Action Target : Type*) :=
  State → Action → Target → ℝ

/-- A new action is no slower than an old action on every declared functional
target. -/
def ActionRateDominatesOn
    (targets : Set Target)
    (Landscape : FunctionalRateLandscape State Action Target)
    (state : State)
    (oldAction newAction : Action) : Prop :=
  ∀ target ∈ targets,
    Landscape state oldAction target ≤
      Landscape state newAction target

/-- Strict Pareto improvement of one action over another: no declared target is
slower and at least one is strictly faster. -/
def StrictlyFasterActionOn
    (targets : Set Target)
    (Landscape : FunctionalRateLandscape State Action Target)
    (state : State)
    (oldAction newAction : Action) : Prop :=
  ActionRateDominatesOn targets Landscape state oldAction newAction ∧
    ∃ target ∈ targets,
      Landscape state oldAction target <
        Landscape state newAction target

/-- A feasible action is Pareto-undominated on the declared functional target
family when no feasible alternative strictly dominates it. -/
def ParetoUndominatedActionOn
    (targets : Set Target)
    (Landscape : FunctionalRateLandscape State Action Target)
    (Feasible : Action → Prop)
    (state : State)
    (action : Action) : Prop :=
  Feasible action ∧
    ¬ ∃ candidate,
      Feasible candidate ∧
      StrictlyFasterActionOn
        targets Landscape state action candidate

/-- Policy-level weak dominance across a declared family of organizational
states and functional targets. -/
def FunctionalPolicyDominatesOn
    (states : Set State)
    (targets : Set Target)
    (Landscape : FunctionalRateLandscape State Action Target)
    (oldPolicy newPolicy : RatePolicy State Action) : Prop :=
  ∀ state ∈ states,
    ActionRateDominatesOn
      targets Landscape state
      (oldPolicy state) (newPolicy state)

/-- Strict policy improvement: weak dominance across all declared states and
targets, with strict improvement for at least one state-target pair. -/
def StrictFunctionalPolicyImprovementOn
    (states : Set State)
    (targets : Set Target)
    (Landscape : FunctionalRateLandscape State Action Target)
    (oldPolicy newPolicy : RatePolicy State Action) : Prop :=
  FunctionalPolicyDominatesOn
      states targets Landscape oldPolicy newPolicy ∧
    ∃ state ∈ states, ∃ target ∈ targets,
      Landscape state (oldPolicy state) target <
        Landscape state (newPolicy state) target

/-- Lift a scalar state-dependent rate score to a one-target functional-rate
landscape. This makes explicit that the scalar allocation models are a special
case, not the universal primitive. -/
def LiftScalarRateLandscape
    (Landscape : RateLandscape State Action) :
    FunctionalRateLandscape State Action Unit :=
  fun state action _ => Landscape state action

/-- The declared target family for the one-target scalar specialization. -/
def UnitTargetFamily : Set Unit :=
  Set.univ

/-- Scalar feasibility/optimality implies Pareto-undominated status after the
one-target lift. -/
theorem scalarOptimal_implies_unitLift_paretoUndominated
    (Landscape : RateLandscape State Action)
    (Feasible : Action → Prop)
    (state : State)
    (action : Action)
    (hOptimal :
      IsOptimalActionAt Landscape Feasible state action) :
    ParetoUndominatedActionOn
      UnitTargetFamily
      (LiftScalarRateLandscape Landscape)
      Feasible state action := by
  constructor
  · exact hOptimal.1
  · rintro ⟨candidate, hCandidate, hStrict⟩
    have hUpper := hOptimal.2 candidate hCandidate
    obtain ⟨target, hTarget, hFaster⟩ := hStrict.2
    unfold LiftScalarRateLandscape at hFaster
    exact (not_lt_of_ge hUpper) hFaster

/-- The globally optimal scalar bottleneck policy is therefore
Pareto-undominated in its explicit one-target functional lift. -/
theorem bottleneckRatePolicy_unitLift_paretoUndominated
    (state : TwoStageOrganization) :
    ParetoUndominatedActionOn
      UnitTargetFamily
      (LiftScalarRateLandscape TwoStageRateLandscape)
      UnitAllocationFeasible
      state
      (BottleneckRatePolicy state) := by
  exact scalarOptimal_implies_unitLift_paretoUndominated
    TwoStageRateLandscape
    UnitAllocationFeasible
    state
    (BottleneckRatePolicy state)
    (bottleneckRatePolicy_optimalAt state)

/-- Strict functional action improvement is asymmetric. -/
theorem strictlyFasterActionOn_not_reverse
    (targets : Set Target)
    (Landscape : FunctionalRateLandscape State Action Target)
    (state : State)
    (a b : Action)
    (h : StrictlyFasterActionOn targets Landscape state a b) :
    ¬ StrictlyFasterActionOn targets Landscape state b a := by
  intro hReverse
  obtain ⟨target, hTarget, hStrict⟩ := h.2
  have hBack := hReverse.1 target hTarget
  exact (not_lt_of_ge hBack) hStrict

/-- Strict policy improvement immediately exposes at least one declared state
and target on which the new policy is faster. -/
theorem strictFunctionalPolicyImprovement_has_witness
    (states : Set State)
    (targets : Set Target)
    (Landscape : FunctionalRateLandscape State Action Target)
    (oldPolicy newPolicy : RatePolicy State Action)
    (h :
      StrictFunctionalPolicyImprovementOn
        states targets Landscape oldPolicy newPolicy) :
    ∃ state ∈ states, ∃ target ∈ targets,
      Landscape state (oldPolicy state) target <
        Landscape state (newPolicy state) target :=
  h.2

#print axioms scalarOptimal_implies_unitLift_paretoUndominated
#print axioms bottleneckRatePolicy_unitLift_paretoUndominated
#print axioms strictlyFasterActionOn_not_reverse
#print axioms strictFunctionalPolicyImprovement_has_witness

end FunctionalOrganization
end CumulativeAccessibility
