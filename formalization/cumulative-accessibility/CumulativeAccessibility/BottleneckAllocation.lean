import CumulativeAccessibility.StateDependentAllocation

namespace CumulativeAccessibility
namespace FunctionalOrganization

/-!
# Bottleneck equalization under inherited organization

StateDependentAllocation.lean showed that inherited validation infrastructure
changes the velocity-maximizing allocation of a new unit resource.

This file makes the symmetry explicit.

Let

* s >= 0 be inherited search/generation capacity;
* v >= 0 be inherited validation capacity;
* x be the fraction of one new resource unit allocated to search;
* 1-x be the fraction allocated to validation.

For a reduced multiplicative throughput model, define

    Q(s,v,x) = (s + x) (v + 1 - x).

The sum of the two final stage capacities is fixed:

    (s + x) + (v + 1 - x) = 1 + s + v.

Therefore the product is globally bounded by the square of half that total.
When the balancing allocation lies in [0,1], the optimum is

    x* = (1 + v - s)/2,

which exactly equalizes the final stage capacities.

If inherited search capacity exceeds inherited validation capacity by at least
one full resource unit, x*=0 lies beyond the feasible interval and all new
resource should go to validation. The converse holds symmetrically.

This is classical bottleneck/water-filling mathematics. Its role here is not a
novel optimization theorem. The EbE point is that inherited organization
(s,v) changes the velocity landscape faced by the next adaptive step.
-/

/-- Reduced two-stage throughput score with inherited stage capacities. -/
def TwoBaselineAllocationScore
    (searchBase validationBase allocationToSearch : ℝ) : ℝ :=
  (searchBase + allocationToSearch) *
    (validationBase + 1 - allocationToSearch)

/-- Unconstrained balancing allocation: the resource split that makes final
search and validation capacities equal. -/
noncomputable def TwoBaselineBalancingAllocation
    (searchBase validationBase : ℝ) : ℝ :=
  (1 + validationBase - searchBase) / 2

/-- Universal algebraic upper bound for the reduced two-stage product. -/
theorem twoBaselineAllocationScore_le_balancedUpperBound
    (searchBase validationBase allocationToSearch : ℝ) :
    TwoBaselineAllocationScore
        searchBase validationBase allocationToSearch
      ≤ ((1 + searchBase + validationBase) ^ 2) / 4 := by
  unfold TwoBaselineAllocationScore
  nlinarith [sq_nonneg
    ((searchBase + allocationToSearch) -
      (validationBase + 1 - allocationToSearch))]

/-- The balancing allocation attains the algebraic upper bound. -/
theorem twoBaselineAllocationScore_at_balancingAllocation
    (searchBase validationBase : ℝ) :
    TwoBaselineAllocationScore
        searchBase validationBase
        (TwoBaselineBalancingAllocation searchBase validationBase)
      =
      ((1 + searchBase + validationBase) ^ 2) / 4 := by
  unfold TwoBaselineAllocationScore TwoBaselineBalancingAllocation
  ring

/-- At the balancing allocation, final stage capacities are exactly equal. -/
theorem balancingAllocation_equalizes_final_capacities
    (searchBase validationBase : ℝ) :
    searchBase +
        TwoBaselineBalancingAllocation searchBase validationBase
      =
    validationBase + 1 -
        TwoBaselineBalancingAllocation searchBase validationBase := by
  unfold TwoBaselineBalancingAllocation
  ring

/-- The balancing allocation is feasible precisely under the stated pair of
baseline-gap bounds. -/
theorem balancingAllocation_mem_unitInterval
    {searchBase validationBase : ℝ}
    (hSearchNotTooFarAhead :
      searchBase ≤ validationBase + 1)
    (hValidationNotTooFarAhead :
      validationBase ≤ searchBase + 1) :
    0 ≤ TwoBaselineBalancingAllocation searchBase validationBase ∧
      TwoBaselineBalancingAllocation searchBase validationBase ≤ 1 := by
  unfold TwoBaselineBalancingAllocation
  constructor <;> nlinarith

/-- When inherited validation capacity is larger, the interior optimal
allocation of the new resource shifts toward search. -/
theorem validationAhead_shifts_balancingAllocation_toward_search
    {searchBase validationBase : ℝ}
    (h : searchBase < validationBase) :
    (1 / 2 : ℝ) <
      TwoBaselineBalancingAllocation searchBase validationBase := by
  unfold TwoBaselineBalancingAllocation
  nlinarith

/-- When inherited search capacity is larger, the interior optimal allocation
shifts toward validation. -/
theorem searchAhead_shifts_balancingAllocation_toward_validation
    {searchBase validationBase : ℝ}
    (h : validationBase < searchBase) :
    TwoBaselineBalancingAllocation searchBase validationBase <
      (1 / 2 : ℝ) := by
  unfold TwoBaselineBalancingAllocation
  nlinarith

/-- Equal inherited stage capacities recover the symmetric half-half split. -/
theorem equalBaselines_recover_half_allocation
    (base : ℝ) :
    TwoBaselineBalancingAllocation base base = 1 / 2 := by
  unfold TwoBaselineBalancingAllocation
  ring

/-- If inherited search capacity is at least one full new-resource unit ahead,
every feasible positive search allocation is weakly dominated by allocating the
whole new unit to validation. -/
theorem searchFarAhead_all_to_validation_is_optimal
    {searchBase validationBase allocationToSearch : ℝ}
    (hAhead : validationBase + 1 ≤ searchBase)
    (hx0 : 0 ≤ allocationToSearch)
    (hx1 : allocationToSearch ≤ 1) :
    TwoBaselineAllocationScore
        searchBase validationBase allocationToSearch
      ≤
      TwoBaselineAllocationScore
        searchBase validationBase 0 := by
  have hFactor :
      0 ≤ allocationToSearch *
        (searchBase - validationBase + allocationToSearch - 1) := by
    exact mul_nonneg hx0 (by linarith)
  unfold TwoBaselineAllocationScore
  nlinarith

/-- Symmetrically, if inherited validation capacity is at least one full
new-resource unit ahead, all new resource should go to search in this reduced
model. -/
theorem validationFarAhead_all_to_search_is_optimal
    {searchBase validationBase allocationToSearch : ℝ}
    (hAhead : searchBase + 1 ≤ validationBase)
    (hx0 : 0 ≤ allocationToSearch)
    (hx1 : allocationToSearch ≤ 1) :
    TwoBaselineAllocationScore
        searchBase validationBase allocationToSearch
      ≤
      TwoBaselineAllocationScore
        searchBase validationBase 1 := by
  have hLeft : allocationToSearch - 1 ≤ 0 := by linarith
  have hRight :
      searchBase - validationBase + allocationToSearch ≤ 0 := by
    linarith
  have hFactor :
      0 ≤ (allocationToSearch - 1) *
        (searchBase - validationBase + allocationToSearch) :=
    mul_nonneg_of_nonpos_of_nonpos hLeft hRight
  unfold TwoBaselineAllocationScore
  nlinarith

/-- The normalized one-baseline model from StateDependentAllocation is exactly
the searchBase=0 specialization of the two-baseline score, up to a positive
state-dependent scale factor. Hence both models have the same optimizer. -/
theorem validationBaselineVelocity_is_normalized_twoBaselineScore
    {b x : ℝ}
    (hb : 0 ≤ b) :
    ValidationBaselineVelocity b x =
      TwoBaselineAllocationScore 0 b x / (1 + b) := by
  have hd : 0 < 1 + b := by linarith
  rw [ValidationBaselineVelocity, BaselineValidationFraction]
  unfold TwoBaselineAllocationScore
  field_simp [ne_of_gt hd]
  ring

/-- Concrete bottleneck-migration witness: starting from equal baselines gives
a half-half allocation, while adding one-half unit of inherited validation
capacity shifts the balancing allocation to three quarters search. -/
theorem inherited_capacity_moves_the_bottleneck :
    TwoBaselineBalancingAllocation 0 0 = 1 / 2 ∧
      TwoBaselineBalancingAllocation 0 (1 / 2) = 3 / 4 := by
  norm_num [TwoBaselineBalancingAllocation]

#print axioms twoBaselineAllocationScore_le_balancedUpperBound
#print axioms twoBaselineAllocationScore_at_balancingAllocation
#print axioms balancingAllocation_equalizes_final_capacities
#print axioms balancingAllocation_mem_unitInterval
#print axioms validationAhead_shifts_balancingAllocation_toward_search
#print axioms searchAhead_shifts_balancingAllocation_toward_validation
#print axioms searchFarAhead_all_to_validation_is_optimal
#print axioms validationFarAhead_all_to_search_is_optimal
#print axioms validationBaselineVelocity_is_normalized_twoBaselineScore
#print axioms inherited_capacity_moves_the_bottleneck

end FunctionalOrganization
end CumulativeAccessibility
