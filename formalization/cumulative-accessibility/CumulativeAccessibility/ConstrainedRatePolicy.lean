import CumulativeAccessibility.AdaptiveRatePolicy

namespace CumulativeAccessibility
namespace FunctionalOrganization

/-!
# Globally feasible bottleneck-aware rate policy

AdaptiveRatePolicy.lean formalized an interior state-dependent balancing policy.
This file completes the reduced two-stage control law over the full feasible
allocation interval [0,1].

For inherited search capacity s and validation capacity v:

* if validation is more than one full new-resource unit behind search,
  allocate the whole new unit to validation;
* if search is more than one full unit behind validation,
  allocate the whole new unit to search;
* otherwise use the balancing allocation.

The resulting policy is proved feasible and optimal for every organizational
state in the reduced multiplicative score model.

This is classical constrained bottleneck allocation. Its role in EbE is to
make the rate-maximizing action an explicit function of retained organization.
-/

/-- Globally feasible bottleneck-aware policy.

Strict boundary tests keep equality cases in the balancing branch, where the
balancing allocation is already exactly 0 or 1. -/
noncomputable def BottleneckRatePolicy :
    RatePolicy TwoStageOrganization ℝ :=
  fun state =>
    if state.validationBase + 1 < state.searchBase then
      0
    else if state.searchBase + 1 < state.validationBase then
      1
    else
      BalancingRatePolicy state

/-- The bottleneck-aware policy always chooses a feasible allocation. -/
theorem bottleneckRatePolicy_feasible
    (state : TwoStageOrganization) :
    UnitAllocationFeasible (BottleneckRatePolicy state) := by
  unfold BottleneckRatePolicy
  by_cases hSearchAhead :
      state.validationBase + 1 < state.searchBase
  · simp [hSearchAhead, UnitAllocationFeasible]
  · by_cases hValidationAhead :
        state.searchBase + 1 < state.validationBase
    · simp [hSearchAhead, hValidationAhead, UnitAllocationFeasible]
    · have hSV :
          state.searchBase ≤ state.validationBase + 1 :=
        le_of_not_gt hSearchAhead
      have hVS :
          state.validationBase ≤ state.searchBase + 1 :=
        le_of_not_gt hValidationAhead
      have hBal :=
        balancingAllocation_mem_unitInterval hSV hVS
      simpa [hSearchAhead, hValidationAhead, BalancingRatePolicy,
        UnitAllocationFeasible] using hBal

/-- If search is strictly more than one unit ahead, the global policy selects
all new resource for validation. -/
theorem bottleneckRatePolicy_eq_zero_of_search_far_ahead
    (state : TwoStageOrganization)
    (h : state.validationBase + 1 < state.searchBase) :
    BottleneckRatePolicy state = 0 := by
  simp [BottleneckRatePolicy, h]

/-- If validation is strictly more than one unit ahead, the global policy
selects all new resource for search. -/
theorem bottleneckRatePolicy_eq_one_of_validation_far_ahead
    (state : TwoStageOrganization)
    (hSearchNotFarAhead :
      ¬ state.validationBase + 1 < state.searchBase)
    (h : state.searchBase + 1 < state.validationBase) :
    BottleneckRatePolicy state = 1 := by
  simp [BottleneckRatePolicy, hSearchNotFarAhead, h]

/-- In the interior regime, the global policy agrees with the balancing policy. -/
theorem bottleneckRatePolicy_eq_balancing_of_interior
    (state : TwoStageOrganization)
    (hInterior : InteriorAllocationState state) :
    BottleneckRatePolicy state = BalancingRatePolicy state := by
  rcases hInterior with ⟨hSV, hVS⟩
  have hSearchNotFarAhead :
      ¬ state.validationBase + 1 < state.searchBase := by
    linarith
  have hValidationNotFarAhead :
      ¬ state.searchBase + 1 < state.validationBase := by
    linarith
  simp [BottleneckRatePolicy, hSearchNotFarAhead, hValidationNotFarAhead]

/-- The piecewise bottleneck-aware policy is rate-optimal at every state. -/
theorem bottleneckRatePolicy_optimalAt
    (state : TwoStageOrganization) :
    PolicyOptimalAt
      TwoStageRateLandscape UnitAllocationFeasible
      BottleneckRatePolicy state := by
  unfold PolicyOptimalAt
  constructor
  · exact bottleneckRatePolicy_feasible state
  · intro candidate hCandidate
    unfold BottleneckRatePolicy
    by_cases hSearchAhead :
        state.validationBase + 1 < state.searchBase
    · simp [hSearchAhead, TwoStageRateLandscape]
      exact searchFarAhead_all_to_validation_is_optimal
        (le_of_lt hSearchAhead)
        hCandidate.1 hCandidate.2
    · by_cases hValidationAhead :
          state.searchBase + 1 < state.validationBase
      · simp [hSearchAhead, hValidationAhead, TwoStageRateLandscape]
        exact validationFarAhead_all_to_search_is_optimal
          (le_of_lt hValidationAhead)
          hCandidate.1 hCandidate.2
      · have hInterior :
            InteriorAllocationState state := by
          constructor
          · exact le_of_not_gt hSearchAhead
          · exact le_of_not_gt hValidationAhead
        have hOptimal :=
          balancingRatePolicy_optimalAt_interior state hInterior
        have hBound :=
          hOptimal.2 candidate hCandidate
        simpa [hSearchAhead, hValidationAhead] using hBound

/-- The global policy reproduces the two witness allocations used in the
state-dependent-policy theorem. -/
theorem bottleneckRatePolicy_on_witness_states :
    BottleneckRatePolicy symmetricOrganization = 1 / 2 ∧
      BottleneckRatePolicy validationRichOrganization = 3 / 4 := by
  constructor
  · have hInterior := witness_states_are_interior.1
    rw [bottleneckRatePolicy_eq_balancing_of_interior
      symmetricOrganization hInterior]
    exact balancingRatePolicy_changes_with_organization.1
  · have hInterior := witness_states_are_interior.2
    rw [bottleneckRatePolicy_eq_balancing_of_interior
      validationRichOrganization hInterior]
    exact balancingRatePolicy_changes_with_organization.2

/-- The state-dependent global policy succeeds on both witness states where no
single fixed allocation can be optimal. -/
theorem global_adaptive_policy_succeeds_where_fixed_action_cannot :
    PolicyOptimalAt
        TwoStageRateLandscape UnitAllocationFeasible
        BottleneckRatePolicy symmetricOrganization ∧
      PolicyOptimalAt
        TwoStageRateLandscape UnitAllocationFeasible
        BottleneckRatePolicy validationRichOrganization ∧
      ¬ ∃ x : ℝ,
        IsOptimalActionAt
          TwoStageRateLandscape UnitAllocationFeasible
          symmetricOrganization x ∧
        IsOptimalActionAt
          TwoStageRateLandscape UnitAllocationFeasible
          validationRichOrganization x := by
  exact ⟨
    bottleneckRatePolicy_optimalAt symmetricOrganization,
    bottleneckRatePolicy_optimalAt validationRichOrganization,
    no_fixed_allocation_optimal_at_both_witness_states
  ⟩

#print axioms bottleneckRatePolicy_feasible
#print axioms bottleneckRatePolicy_eq_zero_of_search_far_ahead
#print axioms bottleneckRatePolicy_eq_one_of_validation_far_ahead
#print axioms bottleneckRatePolicy_eq_balancing_of_interior
#print axioms bottleneckRatePolicy_optimalAt
#print axioms bottleneckRatePolicy_on_witness_states
#print axioms global_adaptive_policy_succeeds_where_fixed_action_cannot

end FunctionalOrganization
end CumulativeAccessibility
