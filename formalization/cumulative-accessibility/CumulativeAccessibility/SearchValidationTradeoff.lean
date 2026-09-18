import CumulativeAccessibility.RatchetVelocityLedger

namespace CumulativeAccessibility
namespace FunctionalOrganization

/-!
# Search-validation allocation trade-off

The general velocity ledger is monotone in each coordinate when all others are
held fixed. Real systems need not vary one coordinate independently.

This file gives the smallest exact counterexample to the idea that "more
plasticity/search is always faster". A unit processing budget is split between

* x       : candidate-generation/search allocation;
* 1 - x   : validation allocation.

All other ledger factors are fixed to one, as is mean retained gain. The
resulting reduced velocity is

    x (1 - x).

On the feasible interval 0 <= x <= 1 this is nonnegative, is maximized exactly
at x = 1/2, and vanishes at both extremes.

This is not proposed as a universal law of learning or evolution. It is a
machine-checked reduced mechanism showing why ceteris-paribus monotonicity of
the ledger factors does not imply monotonicity when mechanism coordinates are
coupled by a shared constraint.
-/

/-- Unit-budget search/validation allocation embedded directly in the
mechanistic ratchet-velocity ledger. -/
def SearchValidationVelocity (x : ℝ) : ℝ :=
  MechanisticRatchetVelocity
    1 x 1 (1 - x) 1 1

theorem searchValidationVelocity_eq
    (x : ℝ) :
    SearchValidationVelocity x = x * (1 - x) := by
  simp [SearchValidationVelocity, MechanisticRatchetVelocity,
    RetainedSuccessFraction]

theorem searchValidationVelocity_nonneg
    {x : ℝ}
    (hx0 : 0 ≤ x)
    (hx1 : x ≤ 1) :
    0 ≤ SearchValidationVelocity x := by
  rw [searchValidationVelocity_eq]
  exact mul_nonneg hx0 (sub_nonneg.mpr hx1)

/-- Exact global upper bound for the reduced allocation model. -/
theorem four_mul_searchValidationVelocity_le_one
    (x : ℝ) :
    4 * SearchValidationVelocity x ≤ 1 := by
  rw [searchValidationVelocity_eq]
  nlinarith [sq_nonneg (2 * x - 1)]

/-- The balanced allocation reaches the upper bound exactly. -/
theorem searchValidationVelocity_at_half :
    SearchValidationVelocity (1 / 2 : ℝ) = 1 / 4 := by
  norm_num [searchValidationVelocity_eq]

/-- Exact optimum statement in ordinary velocity units. -/
theorem searchValidationVelocity_le_quarter
    (x : ℝ) :
    SearchValidationVelocity x ≤ 1 / 4 := by
  have h := four_mul_searchValidationVelocity_le_one x
  nlinarith

/-- Equality at the upper bound occurs only at the balanced allocation. -/
theorem searchValidationVelocity_eq_quarter_iff
    (x : ℝ) :
    SearchValidationVelocity x = 1 / 4 ↔ x = 1 / 2 := by
  constructor
  · intro h
    rw [searchValidationVelocity_eq] at h
    nlinarith [sq_nonneg (2 * x - 1)]
  · intro h
    subst x
    exact searchValidationVelocity_at_half

/-- More search strictly increases velocity on the search-limited side. -/
theorem searchValidationVelocity_strictMono_left
    {x y : ℝ}
    (hx0 : 0 ≤ x)
    (hxy : x < y)
    (hy : y ≤ 1 / 2) :
    SearchValidationVelocity x < SearchValidationVelocity y := by
  rw [searchValidationVelocity_eq, searchValidationVelocity_eq]
  have hsum : x + y < 1 := by
    nlinarith
  have hprod : 0 < (y - x) * (1 - x - y) := by
    positivity
  nlinarith

/-- More search strictly decreases velocity on the validation-limited side. -/
theorem searchValidationVelocity_strictAnti_right
    {x y : ℝ}
    (hx : 1 / 2 ≤ x)
    (hxy : x < y)
    (hy1 : y ≤ 1) :
    SearchValidationVelocity y < SearchValidationVelocity x := by
  rw [searchValidationVelocity_eq, searchValidationVelocity_eq]
  have hsum : 1 < x + y := by
    nlinarith
  have hprod : 0 < (y - x) * (x + y - 1) := by
    positivity
  nlinarith

/-- Pure search with no validation has zero retained ledger velocity. -/
theorem searchValidationVelocity_all_search_zero :
    SearchValidationVelocity 1 = 0 := by
  norm_num [searchValidationVelocity_eq]

/-- Pure validation with no candidate generation also has zero ledger
velocity. -/
theorem searchValidationVelocity_all_validation_zero :
    SearchValidationVelocity 0 = 0 := by
  norm_num [searchValidationVelocity_eq]

/-- A concrete separation: raising search allocation from the balanced point to
the maximum lowers, rather than raises, retained ledger velocity. -/
theorem more_search_can_reduce_velocity :
    SearchValidationVelocity 1 <
      SearchValidationVelocity (1 / 2 : ℝ) := by
  norm_num [searchValidationVelocity_eq]

#print axioms searchValidationVelocity_nonneg
#print axioms four_mul_searchValidationVelocity_le_one
#print axioms searchValidationVelocity_at_half
#print axioms searchValidationVelocity_le_quarter
#print axioms searchValidationVelocity_eq_quarter_iff
#print axioms searchValidationVelocity_strictMono_left
#print axioms searchValidationVelocity_strictAnti_right
#print axioms more_search_can_reduce_velocity

end FunctionalOrganization
end CumulativeAccessibility
