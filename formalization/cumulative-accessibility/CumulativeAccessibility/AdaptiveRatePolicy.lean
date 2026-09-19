import CumulativeAccessibility.BottleneckAllocation

namespace CumulativeAccessibility
namespace FunctionalOrganization

/-!
# Adaptive policy on a state-dependent rate landscape

The previous allocation modules showed that inherited organization changes the
allocation that maximizes a reduced retained-rate score.

This file lifts that result one abstraction level.

A rate landscape is a map

    state -> action -> real-valued rate score.

An action is optimal at a state when no feasible alternative has a larger
score. A policy chooses an action as a function of state.

The concrete two-stage model then proves:

1. the balancing policy is optimal whenever its interior balancing point is
   feasible;
2. the preferred allocation reverses across two organizational states;
3. no single fixed allocation can be globally optimal in both witness states.

This is the formal reason that an adaptive system may need to change not only
its organization but also the policy by which it allocates resources for the
next improvement.
-/

/-- A state-dependent scalar rate landscape. -/
abbrev RateLandscape (State Action : Type*) :=
  State → Action → ℝ

/-- An action is optimal among the declared feasible actions at one state. -/
def IsOptimalActionAt
    (Landscape : RateLandscape State Action)
    (Feasible : Action → Prop)
    (state : State)
    (action : Action) : Prop :=
  Feasible action ∧
    ∀ candidate, Feasible candidate →
      Landscape state candidate ≤ Landscape state action

/-- A policy chooses an action from the current organizational state. -/
abbrev RatePolicy (State Action : Type*) :=
  State → Action

/-- A policy is locally optimal at a particular state. -/
def PolicyOptimalAt
    (Landscape : RateLandscape State Action)
    (Feasible : Action → Prop)
    (policy : RatePolicy State Action)
    (state : State) : Prop :=
  IsOptimalActionAt Landscape Feasible state (policy state)

/-- Two actions reverse their strict ranking between two states. -/
def PreferenceReversal
    (Landscape : RateLandscape State Action)
    (state₀ state₁ : State)
    (action₀ action₁ : Action) : Prop :=
  Landscape state₀ action₀ > Landscape state₀ action₁ ∧
    Landscape state₁ action₀ < Landscape state₁ action₁

/-- Organizational state for the reduced search-validation allocation model. -/
structure TwoStageOrganization where
  searchBase : ℝ
  validationBase : ℝ

/-- Feasible fraction of one new resource unit assigned to search. -/
def UnitAllocationFeasible (x : ℝ) : Prop :=
  0 ≤ x ∧ x ≤ 1

/-- The reduced two-stage rate landscape induced by inherited organization. -/
def TwoStageRateLandscape :
    RateLandscape TwoStageOrganization ℝ :=
  fun state x =>
    TwoBaselineAllocationScore
      state.searchBase state.validationBase x

/-- State-dependent interior balancing policy. -/
noncomputable def BalancingRatePolicy :
    RatePolicy TwoStageOrganization ℝ :=
  fun state =>
    TwoBaselineBalancingAllocation
      state.searchBase state.validationBase

/-- Interior regime in which the algebraic balancing point lies inside the
physical allocation interval. -/
def InteriorAllocationState
    (state : TwoStageOrganization) : Prop :=
  state.searchBase ≤ state.validationBase + 1 ∧
    state.validationBase ≤ state.searchBase + 1

/-- The balancing policy is feasible and globally optimal on the unit interval
whenever the inherited capacities are in the interior regime. -/
theorem balancingRatePolicy_optimalAt_interior
    (state : TwoStageOrganization)
    (hInterior : InteriorAllocationState state) :
    PolicyOptimalAt
      TwoStageRateLandscape UnitAllocationFeasible
      BalancingRatePolicy state := by
  rcases hInterior with ⟨hSV, hVS⟩
  constructor
  · exact balancingAllocation_mem_unitInterval hSV hVS
  · intro candidate hCandidate
    unfold TwoStageRateLandscape BalancingRatePolicy
    calc
      TwoBaselineAllocationScore
          state.searchBase state.validationBase candidate
        ≤ ((1 + state.searchBase + state.validationBase) ^ 2) / 4 :=
          twoBaselineAllocationScore_le_balancedUpperBound
            state.searchBase state.validationBase candidate
      _ =
        TwoBaselineAllocationScore
          state.searchBase state.validationBase
          (TwoBaselineBalancingAllocation
            state.searchBase state.validationBase) := by
          symm
          exact twoBaselineAllocationScore_at_balancingAllocation
            state.searchBase state.validationBase

/-- Equality with the algebraic global upper bound uniquely identifies the
balancing allocation. -/
theorem twoBaselineAllocationScore_eq_upperBound_iff_balancing
    (searchBase validationBase allocationToSearch : ℝ) :
    TwoBaselineAllocationScore
        searchBase validationBase allocationToSearch
        =
      ((1 + searchBase + validationBase) ^ 2) / 4
    ↔
    allocationToSearch =
      TwoBaselineBalancingAllocation searchBase validationBase := by
  constructor
  · intro h
    unfold TwoBaselineAllocationScore at h
    unfold TwoBaselineBalancingAllocation
    nlinarith [sq_nonneg
      ((searchBase + allocationToSearch) -
        (validationBase + 1 - allocationToSearch))]
  · intro h
    rw [h]
    exact twoBaselineAllocationScore_at_balancingAllocation
      searchBase validationBase

/-- In the interior regime, any feasible optimum is the balancing allocation. -/
theorem optimalActionAt_interior_eq_balancing
    (state : TwoStageOrganization)
    (action : ℝ)
    (hInterior : InteriorAllocationState state)
    (hOptimal :
      IsOptimalActionAt
        TwoStageRateLandscape UnitAllocationFeasible state action) :
    action = BalancingRatePolicy state := by
  have hBalFeasible :
      UnitAllocationFeasible (BalancingRatePolicy state) := by
    rcases hInterior with ⟨hSV, hVS⟩
    exact balancingAllocation_mem_unitInterval hSV hVS
  have hLower :=
    hOptimal.2 (BalancingRatePolicy state) hBalFeasible
  have hUpper :=
    twoBaselineAllocationScore_le_balancedUpperBound
      state.searchBase state.validationBase action
  have hBalEq :=
    twoBaselineAllocationScore_at_balancingAllocation
      state.searchBase state.validationBase
  unfold TwoStageRateLandscape at hLower
  have hLower' :
      ((1 + state.searchBase + state.validationBase) ^ 2) / 4
        ≤
      TwoBaselineAllocationScore
        state.searchBase state.validationBase action := by
    calc
      ((1 + state.searchBase + state.validationBase) ^ 2) / 4
        =
      TwoBaselineAllocationScore
        state.searchBase state.validationBase
        (TwoBaselineBalancingAllocation
          state.searchBase state.validationBase) := by
          symm
          exact hBalEq
      _ ≤
      TwoBaselineAllocationScore
        state.searchBase state.validationBase action := by
          simpa [BalancingRatePolicy] using hLower
  have hEq :
      TwoBaselineAllocationScore
          state.searchBase state.validationBase action
        =
      ((1 + state.searchBase + state.validationBase) ^ 2) / 4 :=
    le_antisymm hUpper hLower'
  exact (twoBaselineAllocationScore_eq_upperBound_iff_balancing
    state.searchBase state.validationBase action).1 hEq

/-- Concrete states used to witness policy adaptation. -/
def symmetricOrganization : TwoStageOrganization where
  searchBase := 0
  validationBase := 0

noncomputable def validationRichOrganization : TwoStageOrganization where
  searchBase := 0
  validationBase := 1 / 2

/-- The balancing policy changes from one-half search to three-quarters search
after validation capacity has accumulated. -/
theorem balancingRatePolicy_changes_with_organization :
    BalancingRatePolicy symmetricOrganization = 1 / 2 ∧
      BalancingRatePolicy validationRichOrganization = 3 / 4 := by
  constructor <;>
    norm_num [BalancingRatePolicy, symmetricOrganization,
      validationRichOrganization, TwoBaselineBalancingAllocation]

/-- The ranking of the half-half and three-quarter allocations reverses across
the two organizational states. -/
theorem allocation_preference_reverses_across_states :
    PreferenceReversal
      TwoStageRateLandscape
      symmetricOrganization
      validationRichOrganization
      (1 / 2 : ℝ)
      (3 / 4 : ℝ) := by
  constructor <;>
    norm_num [PreferenceReversal, TwoStageRateLandscape,
      symmetricOrganization, validationRichOrganization,
      TwoBaselineAllocationScore]

/-- Both witness states lie in the interior regime. -/
theorem witness_states_are_interior :
    InteriorAllocationState symmetricOrganization ∧
      InteriorAllocationState validationRichOrganization := by
  constructor <;>
    norm_num [InteriorAllocationState,
      symmetricOrganization, validationRichOrganization]

/-- There is no single fixed allocation that is optimal at both witness states.

This is stronger than saying that two chosen allocations swap ranking: any
feasible optimum at the symmetric state must equal one-half, while any feasible
optimum at the validation-rich state must equal three-quarters. -/
theorem no_fixed_allocation_optimal_at_both_witness_states :
    ¬ ∃ x : ℝ,
      IsOptimalActionAt
        TwoStageRateLandscape UnitAllocationFeasible
        symmetricOrganization x ∧
      IsOptimalActionAt
        TwoStageRateLandscape UnitAllocationFeasible
        validationRichOrganization x := by
  rintro ⟨x, hSym, hVal⟩
  have hSymEq :
      x = BalancingRatePolicy symmetricOrganization :=
    optimalActionAt_interior_eq_balancing
      symmetricOrganization x witness_states_are_interior.1 hSym
  have hValEq :
      x = BalancingRatePolicy validationRichOrganization :=
    optimalActionAt_interior_eq_balancing
      validationRichOrganization x witness_states_are_interior.2 hVal
  have hPolicy := balancingRatePolicy_changes_with_organization
  rw [hPolicy.1] at hSymEq
  rw [hPolicy.2] at hValEq
  nlinarith

/-- The state-dependent balancing policy is optimal at both witness states even
though no fixed action is. -/
theorem adaptive_policy_succeeds_where_fixed_action_cannot :
    PolicyOptimalAt
        TwoStageRateLandscape UnitAllocationFeasible
        BalancingRatePolicy symmetricOrganization ∧
      PolicyOptimalAt
        TwoStageRateLandscape UnitAllocationFeasible
        BalancingRatePolicy validationRichOrganization := by
  constructor
  · exact balancingRatePolicy_optimalAt_interior
      symmetricOrganization witness_states_are_interior.1
  · exact balancingRatePolicy_optimalAt_interior
      validationRichOrganization witness_states_are_interior.2

#print axioms balancingRatePolicy_optimalAt_interior
#print axioms twoBaselineAllocationScore_eq_upperBound_iff_balancing
#print axioms optimalActionAt_interior_eq_balancing
#print axioms balancingRatePolicy_changes_with_organization
#print axioms allocation_preference_reverses_across_states
#print axioms no_fixed_allocation_optimal_at_both_witness_states
#print axioms adaptive_policy_succeeds_where_fixed_action_cannot

end FunctionalOrganization
end CumulativeAccessibility
