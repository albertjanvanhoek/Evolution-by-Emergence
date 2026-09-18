import CumulativeAccessibility.SearchValidationTradeoff

namespace CumulativeAccessibility
namespace FunctionalOrganization

/-!
# State-dependent allocation of ratchet-producing resources

SearchValidationTradeoff.lean proved an intentionally symmetric toy result:

    v(x) = x (1 - x)

with optimum x = 1/2.

That optimum is not universal. It follows from the assumed response functions.

This file makes the dependence on inherited organization explicit. Let b >= 0
represent retained validation infrastructure that remains available before new
resource is allocated. If x is the fraction of a new unit resource allocated to
search, normalize validation capacity to the interval [0,1] by

    validation_b(x) = (b + 1 - x) / (1 + b).

The resulting reduced retained-rate score is

    v_b(x) = x * validation_b(x).

For 0 <= b <= 1, the global optimum over the feasible allocation interval
0 <= x <= 1 is

    x* = (1 + b) / 2.

Thus b = 0 recovers the symmetric x* = 1/2 model, while positive inherited
validation capacity shifts new resource toward search. The result is not a new
resource-allocation theorem; it is a formal witness that the velocity-maximizing
control policy depends on the organization already present.

This is the intended EbE lesson:

    optimal allocation is state-dependent because organization changes the
    response functions that map resource allocation into retained velocity.
-/

/-- Normalized validation capacity when retained validation infrastructure b is
already present and x of a new unit resource is allocated to search. -/
noncomputable def BaselineValidationFraction
    (b x : ℝ) : ℝ :=
  (b + 1 - x) / (1 + b)

/-- Reduced retained-velocity score with inherited validation infrastructure. -/
noncomputable def ValidationBaselineVelocity
    (b x : ℝ) : ℝ :=
  x * BaselineValidationFraction b x

/-- With no inherited validation infrastructure, the state-dependent model
reduces exactly to the previous symmetric search-validation model. -/
theorem validationBaseline_zero_recovers_searchValidation
    (x : ℝ) :
    ValidationBaselineVelocity 0 x =
      SearchValidationVelocity x := by
  rw [ValidationBaselineVelocity, BaselineValidationFraction,
    searchValidationVelocity_eq]
  ring

/-- For nonnegative inherited validation capacity and feasible resource
allocation, the normalized validation factor remains between zero and one. -/
theorem baselineValidationFraction_mem_unitInterval
    {b x : ℝ}
    (hb : 0 ≤ b)
    (hx0 : 0 ≤ x)
    (hx1 : x ≤ 1) :
    0 ≤ BaselineValidationFraction b x ∧
      BaselineValidationFraction b x ≤ 1 := by
  have hd : 0 < 1 + b := by linarith
  constructor
  · rw [BaselineValidationFraction]
    exact div_nonneg (by linarith) (le_of_lt hd)
  · rw [BaselineValidationFraction]
    apply (div_le_one hd).2
    linarith

/-- Exact global upper bound induced by inherited validation capacity. -/
theorem validationBaselineVelocity_le_stateDependentMaximum
    {b x : ℝ}
    (hb : 0 ≤ b) :
    ValidationBaselineVelocity b x ≤ (1 + b) / 4 := by
  have hd : 0 < 1 + b := by linarith
  rw [ValidationBaselineVelocity, BaselineValidationFraction]
  calc
    x * ((b + 1 - x) / (1 + b)) =
        (x * (b + 1 - x)) / (1 + b) := by ring
    _ ≤ (1 + b) / 4 := by
      apply (div_le_iff₀ hd).2
      nlinarith [sq_nonneg (2 * x - (1 + b))]

/-- The upper bound is attained at the state-dependent allocation
x* = (1+b)/2. -/
theorem validationBaselineVelocity_at_stateDependentOptimum
    {b : ℝ}
    (hb : 0 ≤ b) :
    ValidationBaselineVelocity b ((1 + b) / 2) =
      (1 + b) / 4 := by
  have hd : 0 < 1 + b := by linarith
  rw [ValidationBaselineVelocity, BaselineValidationFraction]
  field_simp
  ring

/-- When inherited validation capacity lies between zero and one, the exact
global optimizer lies inside the feasible allocation interval. -/
theorem stateDependentOptimum_mem_unitInterval
    {b : ℝ}
    (hb0 : 0 ≤ b)
    (hb1 : b ≤ 1) :
    0 ≤ (1 + b) / 2 ∧ (1 + b) / 2 ≤ 1 := by
  constructor <;> nlinarith

/-- Positive inherited validation capacity shifts the optimal allocation of new
resource strictly toward search. -/
theorem positive_validation_baseline_shifts_optimum_toward_search
    {b : ℝ}
    (hb : 0 < b) :
    (1 / 2 : ℝ) < (1 + b) / 2 := by
  nlinarith

/-- More inherited validation infrastructure monotonically shifts the
velocity-maximizing allocation of new resource toward search, as long as both
optima remain in the modeled feasible interval. -/
theorem more_validation_baseline_shifts_optimum_toward_search
    {b₀ b₁ : ℝ}
    (h : b₀ < b₁) :
    (1 + b₀) / 2 < (1 + b₁) / 2 := by
  linarith

/-- Concrete state-dependence witness.

With no inherited validation capacity the optimum is x=1/2. With baseline
b=1/2, the exact optimum is x=3/4. -/
theorem validation_baseline_half_has_optimum_three_quarters :
    ValidationBaselineVelocity (1 / 2 : ℝ) (3 / 4 : ℝ) =
      3 / 8 := by
  norm_num [ValidationBaselineVelocity, BaselineValidationFraction]

/-- The old symmetric allocation is strictly suboptimal after the validation
baseline has changed. -/
theorem inherited_organization_changes_optimal_allocation :
    ValidationBaselineVelocity (1 / 2 : ℝ) (1 / 2 : ℝ) <
      ValidationBaselineVelocity (1 / 2 : ℝ) (3 / 4 : ℝ) := by
  norm_num [ValidationBaselineVelocity, BaselineValidationFraction]

/-- There is therefore no single allocation that is optimal in both the
zero-baseline and positive-baseline witness environments. -/
theorem symmetric_and_inherited_validation_optima_differ :
    SearchValidationVelocity (3 / 4 : ℝ) <
        SearchValidationVelocity (1 / 2 : ℝ) ∧
      ValidationBaselineVelocity (1 / 2 : ℝ) (1 / 2 : ℝ) <
        ValidationBaselineVelocity (1 / 2 : ℝ) (3 / 4 : ℝ) := by
  constructor
  · norm_num [searchValidationVelocity_eq]
  · exact inherited_organization_changes_optimal_allocation

#print axioms validationBaseline_zero_recovers_searchValidation
#print axioms baselineValidationFraction_mem_unitInterval
#print axioms validationBaselineVelocity_le_stateDependentMaximum
#print axioms validationBaselineVelocity_at_stateDependentOptimum
#print axioms stateDependentOptimum_mem_unitInterval
#print axioms positive_validation_baseline_shifts_optimum_toward_search
#print axioms more_validation_baseline_shifts_optimum_toward_search
#print axioms validation_baseline_half_has_optimum_three_quarters
#print axioms inherited_organization_changes_optimal_allocation
#print axioms symmetric_and_inherited_validation_optima_differ

end FunctionalOrganization
end CumulativeAccessibility
