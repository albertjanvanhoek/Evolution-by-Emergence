import CumulativeAccessibility.PolicyLearning

namespace CumulativeAccessibility
namespace FunctionalOrganization

/-!
# Rate regret from organizational mismatch

For the reduced two-stage search/validation model, the final sum of stage
capacities after allocating one new unit is fixed. The product score is
therefore maximized when the final capacities are balanced.

This file quantifies the loss from failing to make that state-dependent
allocation.

Let

    Q(s,v,x) = (s+x)(v+1-x)

and let

    U(s,v) = (1+s+v)^2 / 4

be the algebraic balanced upper bound. Define allocation regret as

    R(s,v,x) = U(s,v) - Q(s,v,x).

Then exactly

    R(s,v,x)
      = ((s+x) - (v+1-x))^2 / 4.

Thus the rate penalty is one quarter of the squared residual bottleneck
imbalance.

For the fixed half-half policy, residual imbalance equals inherited imbalance,
so

    R(s,v,1/2) = (s-v)^2 / 4.

The balancing policy eliminates this regret whenever the balancing action is
feasible. This is elementary algebra, not a new optimization theorem. Its role
in EbE is to make the cost of policy-organization mismatch explicit.
-/

/-- Algebraic balanced upper bound on the reduced two-stage score. -/
noncomputable def TwoStageBalancedUpperBound
    (searchBase validationBase : ℝ) : ℝ :=
  ((1 + searchBase + validationBase) ^ 2) / 4

/-- Residual stage imbalance after allocating one new resource unit. -/
def ResidualStageImbalance
    (searchBase validationBase allocationToSearch : ℝ) : ℝ :=
  (searchBase + allocationToSearch) -
    (validationBase + 1 - allocationToSearch)

/-- Rate regret relative to the algebraic balanced upper bound. -/
noncomputable def AllocationRateRegret
    (searchBase validationBase allocationToSearch : ℝ) : ℝ :=
  TwoStageBalancedUpperBound searchBase validationBase -
    TwoBaselineAllocationScore
      searchBase validationBase allocationToSearch

/-- Exact mismatch identity: regret is one quarter of squared residual
bottleneck imbalance. -/
theorem allocationRateRegret_eq_residualImbalance_sq_div_four
    (searchBase validationBase allocationToSearch : ℝ) :
    AllocationRateRegret
        searchBase validationBase allocationToSearch
      =
      (ResidualStageImbalance
        searchBase validationBase allocationToSearch) ^ 2 / 4 := by
  unfold AllocationRateRegret TwoStageBalancedUpperBound
    ResidualStageImbalance TwoBaselineAllocationScore
  ring

/-- Allocation regret is always nonnegative. -/
theorem allocationRateRegret_nonnegative
    (searchBase validationBase allocationToSearch : ℝ) :
    0 ≤ AllocationRateRegret
      searchBase validationBase allocationToSearch := by
  rw [allocationRateRegret_eq_residualImbalance_sq_div_four]
  positivity

/-- Zero regret is equivalent to exact balance of final stage capacities. -/
theorem allocationRateRegret_eq_zero_iff_final_balance
    (searchBase validationBase allocationToSearch : ℝ) :
    AllocationRateRegret
        searchBase validationBase allocationToSearch = 0
    ↔
    searchBase + allocationToSearch =
      validationBase + 1 - allocationToSearch := by
  rw [allocationRateRegret_eq_residualImbalance_sq_div_four]
  unfold ResidualStageImbalance
  constructor
  · intro h
    have hSq :
        ((searchBase + allocationToSearch) -
          (validationBase + 1 - allocationToSearch)) ^ 2 = 0 := by
      nlinarith
    nlinarith [sq_nonneg
      ((searchBase + allocationToSearch) -
        (validationBase + 1 - allocationToSearch))]
  · intro h
    rw [h]
    norm_num

/-- For the fixed half-half rule, residual mismatch is exactly the inherited
stage-capacity imbalance. -/
theorem fixedHalf_rateRegret_eq_baselineImbalance_sq_div_four
    (searchBase validationBase : ℝ) :
    AllocationRateRegret
        searchBase validationBase (1 / 2)
      =
      (searchBase - validationBase) ^ 2 / 4 := by
  rw [allocationRateRegret_eq_residualImbalance_sq_div_four]
  unfold ResidualStageImbalance
  ring

/-- Therefore the fixed half-half rule has zero regret exactly when inherited
search and validation capacities are balanced. -/
theorem fixedHalf_rateRegret_eq_zero_iff_baselines_equal
    (searchBase validationBase : ℝ) :
    AllocationRateRegret
        searchBase validationBase (1 / 2) = 0
    ↔
    searchBase = validationBase := by
  rw [fixedHalf_rateRegret_eq_baselineImbalance_sq_div_four]
  constructor
  · intro h
    have hSq : (searchBase - validationBase) ^ 2 = 0 := by
      nlinarith
    nlinarith [sq_nonneg (searchBase - validationBase)]
  · intro h
    subst validationBase
    norm_num

/-- The unconstrained balancing allocation has exactly zero algebraic regret. -/
theorem balancingAllocation_has_zero_rateRegret
    (searchBase validationBase : ℝ) :
    AllocationRateRegret
      searchBase validationBase
      (TwoBaselineBalancingAllocation searchBase validationBase)
      = 0 := by
  rw [allocationRateRegret_eq_zero_iff_final_balance]
  exact balancingAllocation_equalizes_final_capacities
    searchBase validationBase

/-- The score advantage of the balancing allocation over a fixed half-half rule
is exactly one quarter of squared inherited imbalance.

For interpretation as a feasible policy improvement, the balancing allocation
must lie inside the feasible interval. -/
theorem balancing_gain_over_fixedHalf_eq_baselineImbalance_sq_div_four
    (searchBase validationBase : ℝ) :
    TwoBaselineAllocationScore
        searchBase validationBase
        (TwoBaselineBalancingAllocation searchBase validationBase)
      -
      TwoBaselineAllocationScore
        searchBase validationBase (1 / 2)
      =
      (searchBase - validationBase) ^ 2 / 4 := by
  have hBalZero :=
    balancingAllocation_has_zero_rateRegret searchBase validationBase
  have hHalf :=
    fixedHalf_rateRegret_eq_baselineImbalance_sq_div_four
      searchBase validationBase
  unfold AllocationRateRegret at hBalZero hHalf
  linarith

/-- Concrete held-out magnitude: with one-half unit of inherited validation
capacity and none of inherited search capacity, the fixed half-half rule loses
exactly 1/16 of the reduced rate score relative to balancing. -/
theorem validationRich_fixedHalf_rateRegret_is_one_sixteenth :
    AllocationRateRegret 0 (1 / 2) (1 / 2) = 1 / 16 := by
  norm_num [fixedHalf_rateRegret_eq_baselineImbalance_sq_div_four]

/-- The checked bottleneck-aware policy realizes that exact 1/16 score gain over
the fixed half-half policy in the validation-rich witness state. -/
theorem validationRich_bottleneckPolicy_gain_over_fixedHalf_is_one_sixteenth :
    TwoStageRateLandscape
        validationRichOrganization
        (BottleneckRatePolicy validationRichOrganization)
      -
      TwoStageRateLandscape
        validationRichOrganization
        (FixedHalfRatePolicy validationRichOrganization)
      =
      1 / 16 := by
  have hPolicy := bottleneckRatePolicy_on_witness_states.2
  rw [hPolicy]
  norm_num [TwoStageRateLandscape, validationRichOrganization,
    FixedHalfRatePolicy, TwoBaselineAllocationScore]

#print axioms allocationRateRegret_eq_residualImbalance_sq_div_four
#print axioms allocationRateRegret_nonnegative
#print axioms allocationRateRegret_eq_zero_iff_final_balance
#print axioms fixedHalf_rateRegret_eq_baselineImbalance_sq_div_four
#print axioms fixedHalf_rateRegret_eq_zero_iff_baselines_equal
#print axioms balancingAllocation_has_zero_rateRegret
#print axioms balancing_gain_over_fixedHalf_eq_baselineImbalance_sq_div_four
#print axioms validationRich_fixedHalf_rateRegret_is_one_sixteenth
#print axioms validationRich_bottleneckPolicy_gain_over_fixedHalf_is_one_sixteenth

end FunctionalOrganization
end CumulativeAccessibility
