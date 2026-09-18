import CumulativeAccessibility.ConstrainedRatePolicy

namespace CumulativeAccessibility
namespace FunctionalOrganization

/-!
# Closed-loop state-dependent rate control

The preceding modules derived a globally feasible rate-maximizing allocation
policy for a reduced two-stage search/validation model.

This file closes the feedback loop:

    organization state
        -> state-dependent allocation policy
        -> next organization state
        -> next policy.

One unit of new resource is allocated at each step. The retained stage
capacities therefore become part of the next organizational state.

In the reduced linear-capacity model the signed bottleneck imbalance

    d = searchBase - validationBase

obeys a simple closed-loop rule under the bottleneck-aware policy:

    d > 1    -> d' = d - 1
    d < -1   -> d' = d + 1
    |d| <= 1 -> d' = 0.

Thus the policy that maximizes the current reduced rate score also moves the
two modeled stage capacities toward balance. This is a property of this toy
mechanism, not a universal theorem about adaptive systems.
-/

/-- Apply one unit of new resource according to allocation x, where x goes to
search/generation and 1-x goes to validation. -/
def ApplyUnitAllocation
    (state : TwoStageOrganization)
    (allocationToSearch : ℝ) : TwoStageOrganization where
  searchBase := state.searchBase + allocationToSearch
  validationBase := state.validationBase + 1 - allocationToSearch

/-- One closed-loop organizational update under the globally feasible
bottleneck-aware policy. -/
noncomputable def BottleneckClosedLoopStep
    (state : TwoStageOrganization) : TwoStageOrganization :=
  ApplyUnitAllocation state (BottleneckRatePolicy state)

/-- Signed stage-capacity imbalance. Positive means search is ahead; negative
means validation is ahead. -/
def StageImbalance
    (state : TwoStageOrganization) : ℝ :=
  state.searchBase - state.validationBase

/-- Every unit-allocation step raises total installed stage capacity by exactly
one unit. -/
theorem applyUnitAllocation_adds_one_total_capacity
    (state : TwoStageOrganization)
    (x : ℝ) :
    (ApplyUnitAllocation state x).searchBase +
        (ApplyUnitAllocation state x).validationBase
      =
    state.searchBase + state.validationBase + 1 := by
  unfold ApplyUnitAllocation
  ring

/-- The closed-loop step also adds exactly one total capacity unit. -/
theorem bottleneckClosedLoopStep_adds_one_total_capacity
    (state : TwoStageOrganization) :
    (BottleneckClosedLoopStep state).searchBase +
        (BottleneckClosedLoopStep state).validationBase
      =
    state.searchBase + state.validationBase + 1 := by
  unfold BottleneckClosedLoopStep
  exact applyUnitAllocation_adds_one_total_capacity
    state (BottleneckRatePolicy state)

/-- If search is more than one unit ahead, the policy spends the whole new unit
on validation, reducing the signed imbalance by exactly one. -/
theorem closedLoop_searchFarAhead_reduces_imbalance_by_one
    (state : TwoStageOrganization)
    (h : state.validationBase + 1 < state.searchBase) :
    StageImbalance (BottleneckClosedLoopStep state)
      =
    StageImbalance state - 1 := by
  have hPolicy :=
    bottleneckRatePolicy_eq_zero_of_search_far_ahead state h
  simp [StageImbalance, BottleneckClosedLoopStep,
    ApplyUnitAllocation, hPolicy]
  ring

/-- If validation is more than one unit ahead, the policy spends the whole new
unit on search, increasing the signed imbalance by exactly one toward zero. -/
theorem closedLoop_validationFarAhead_increases_imbalance_by_one
    (state : TwoStageOrganization)
    (h : state.searchBase + 1 < state.validationBase) :
    StageImbalance (BottleneckClosedLoopStep state)
      =
    StageImbalance state + 1 := by
  have hSearchNotFarAhead :
      ¬ state.validationBase + 1 < state.searchBase := by
    linarith
  have hPolicy :=
    bottleneckRatePolicy_eq_one_of_validation_far_ahead
      state hSearchNotFarAhead h
  simp [StageImbalance, BottleneckClosedLoopStep,
    ApplyUnitAllocation, hPolicy]
  ring

/-- In the interior regime, one balancing step makes the next two stage
capacities exactly equal, so signed imbalance becomes zero. -/
theorem closedLoop_interior_equalizes_capacities
    (state : TwoStageOrganization)
    (hInterior : InteriorAllocationState state) :
    StageImbalance (BottleneckClosedLoopStep state) = 0 := by
  have hPolicy :=
    bottleneckRatePolicy_eq_balancing_of_interior state hInterior
  have hEqual :=
    balancingAllocation_equalizes_final_capacities
      state.searchBase state.validationBase
  unfold StageImbalance BottleneckClosedLoopStep ApplyUnitAllocation
  rw [hPolicy]
  linarith

/-- Full piecewise imbalance law for the reduced closed-loop model. -/
theorem bottleneckClosedLoop_imbalance_law
    (state : TwoStageOrganization) :
    (1 < StageImbalance state ∧
      StageImbalance (BottleneckClosedLoopStep state) =
        StageImbalance state - 1)
    ∨
    (StageImbalance state < -1 ∧
      StageImbalance (BottleneckClosedLoopStep state) =
        StageImbalance state + 1)
    ∨
    (-1 ≤ StageImbalance state ∧
      StageImbalance state ≤ 1 ∧
      StageImbalance (BottleneckClosedLoopStep state) = 0) := by
  by_cases hSearchAhead :
      state.validationBase + 1 < state.searchBase
  · left
    constructor
    · unfold StageImbalance
      linarith
    · exact closedLoop_searchFarAhead_reduces_imbalance_by_one
        state hSearchAhead
  · by_cases hValidationAhead :
        state.searchBase + 1 < state.validationBase
    · right
      left
      constructor
      · unfold StageImbalance
        linarith
      · exact closedLoop_validationFarAhead_increases_imbalance_by_one
          state hValidationAhead
    · right
      right
      have hInterior :
          InteriorAllocationState state := by
        constructor
        · exact le_of_not_gt hSearchAhead
        · exact le_of_not_gt hValidationAhead
      constructor
      · unfold StageImbalance
        linarith
      · constructor
        · unfold StageImbalance
          linarith
        · exact closedLoop_interior_equalizes_capacities
            state hInterior

/-- A balanced installed-capacity state receives the symmetric half-half
allocation. -/
theorem bottleneckRatePolicy_half_of_balanced
    (state : TwoStageOrganization)
    (hBalanced : state.searchBase = state.validationBase) :
    BottleneckRatePolicy state = 1 / 2 := by
  have hInterior :
      InteriorAllocationState state := by
    constructor <;> linarith
  rw [bottleneckRatePolicy_eq_balancing_of_interior state hInterior]
  unfold BalancingRatePolicy
  rw [hBalanced]
  exact equalBaselines_recover_half_allocation state.validationBase

/-- A balanced state remains balanced after one closed-loop step. -/
theorem bottleneckClosedLoop_preserves_balance
    (state : TwoStageOrganization)
    (hBalanced : state.searchBase = state.validationBase) :
    (BottleneckClosedLoopStep state).searchBase =
      (BottleneckClosedLoopStep state).validationBase := by
  have hPolicy :=
    bottleneckRatePolicy_half_of_balanced state hBalanced
  unfold BottleneckClosedLoopStep ApplyUnitAllocation
  rw [hPolicy]
  linarith

/-- Any interior state is mapped in one closed-loop step to a balanced state. -/
theorem interior_closedLoopStep_is_balanced
    (state : TwoStageOrganization)
    (hInterior : InteriorAllocationState state) :
    (BottleneckClosedLoopStep state).searchBase =
      (BottleneckClosedLoopStep state).validationBase := by
  have hZero :=
    closedLoop_interior_equalizes_capacities state hInterior
  unfold StageImbalance at hZero
  linarith

/-- After an interior balancing step, the next rate-maximizing allocation is
the symmetric half-half action. -/
theorem interior_step_makes_next_policy_half
    (state : TwoStageOrganization)
    (hInterior : InteriorAllocationState state) :
    BottleneckRatePolicy (BottleneckClosedLoopStep state) = 1 / 2 := by
  exact bottleneckRatePolicy_half_of_balanced
    (BottleneckClosedLoopStep state)
    (interior_closedLoopStep_is_balanced state hInterior)

/-- The reduced model therefore exhibits an explicit recursive controller:
an optimal state-dependent action changes organization, and the changed
organization determines the next optimal action. -/
theorem closedLoop_policy_is_recursive_on_interior_state
    (state : TwoStageOrganization)
    (hInterior : InteriorAllocationState state) :
    PolicyOptimalAt
        TwoStageRateLandscape UnitAllocationFeasible
        BottleneckRatePolicy state
    ∧
    (BottleneckClosedLoopStep state).searchBase =
      (BottleneckClosedLoopStep state).validationBase
    ∧
    BottleneckRatePolicy (BottleneckClosedLoopStep state) = 1 / 2 := by
  exact ⟨
    bottleneckRatePolicy_optimalAt state,
    interior_closedLoopStep_is_balanced state hInterior,
    interior_step_makes_next_policy_half state hInterior
  ⟩

#print axioms applyUnitAllocation_adds_one_total_capacity
#print axioms bottleneckClosedLoopStep_adds_one_total_capacity
#print axioms closedLoop_searchFarAhead_reduces_imbalance_by_one
#print axioms closedLoop_validationFarAhead_increases_imbalance_by_one
#print axioms closedLoop_interior_equalizes_capacities
#print axioms bottleneckClosedLoop_imbalance_law
#print axioms bottleneckRatePolicy_half_of_balanced
#print axioms bottleneckClosedLoop_preserves_balance
#print axioms interior_closedLoopStep_is_balanced
#print axioms interior_step_makes_next_policy_half
#print axioms closedLoop_policy_is_recursive_on_interior_state

end FunctionalOrganization
end CumulativeAccessibility
