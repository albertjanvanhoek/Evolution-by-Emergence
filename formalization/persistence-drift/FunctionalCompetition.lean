import Mathlib

namespace FunctionalCompetition

open Finset
open scoped BigOperators

variable {I : Type*} [Fintype I]
variable (p c r : I → ℝ) (b α : ℝ)

noncomputable def mean (p f : I → ℝ) : ℝ := ∑ i, p i * f i

noncomputable def cov (p f g : I → ℝ) : ℝ :=
  ∑ i, p i * (f i - mean p f) * (g i - mean p g)

noncomputable def variance (p f : I → ℝ) : ℝ := cov p f f

theorem cov_eq_sub (f g : I → ℝ) (hp : ∑ i, p i = 1) :
    cov p f g = (∑ i, p i * f i * g i) - mean p f * mean p g := by
  simp only [cov, mean]
  have expand : ∀ i : I,
      p i * (f i - ∑ j, p j * f j) * (g i - ∑ j, p j * g j)
        = p i * f i * g i
          - (∑ j, p j * g j) * (p i * f i)
          - (∑ j, p j * f j) * (p i * g i)
          + ((∑ j, p j * f j) * (∑ j, p j * g j)) * p i := by
    intro i; ring
  rw [Finset.sum_congr rfl (fun i _ => expand i)]
  rw [Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.sum_sub_distrib,
      ← Finset.mul_sum, ← Finset.mul_sum, ← Finset.mul_sum, hp]
  ring

theorem variance_nonneg (f : I → ℝ) (hpnn : ∀ i, 0 ≤ p i) :
    0 ≤ variance p f := by
  simp only [variance, cov]
  refine Finset.sum_nonneg (fun i _ => ?_)
  have h : p i * (f i - mean p f) * (f i - mean p f)
      = p i * (f i - mean p f) ^ 2 := by ring
  rw [h]
  exact mul_nonneg (hpnn i) (sq_nonneg _)

theorem mean_linear (hp : ∑ i, p i = 1) (hlin : ∀ i, r i = b - α * c i) :
    mean p r = b - α * mean p c := by
  simp only [mean]
  have h : ∀ i : I, p i * r i = b * p i - α * (p i * c i) := by
    intro i; rw [hlin i]; ring
  rw [Finset.sum_congr rfl (fun i _ => h i)]
  rw [Finset.sum_sub_distrib, ← Finset.mul_sum, ← Finset.mul_sum, hp]
  ring

theorem sum_fitness_cost (hlin : ∀ i, r i = b - α * c i) :
    (∑ i, p i * r i * c i)
      = b * (∑ i, p i * c i) - α * (∑ i, p i * c i * c i) := by
  have h : ∀ i : I, p i * r i * c i
      = b * (p i * c i) - α * (p i * c i * c i) := by
    intro i; rw [hlin i]; ring
  rw [Finset.sum_congr rfl (fun i _ => h i)]
  rw [Finset.sum_sub_distrib, ← Finset.mul_sum, ← Finset.mul_sum]

theorem cov_linear (hp : ∑ i, p i = 1) (hlin : ∀ i, r i = b - α * c i) :
    cov p r c = - α * variance p c := by
  have hvar : variance p c = (∑ i, p i * c i * c i) - mean p c * mean p c :=
    cov_eq_sub p c c hp
  rw [cov_eq_sub p r c hp, sum_fitness_cost p c r b α hlin,
      mean_linear p c r b α hp hlin, hvar]
  simp only [mean]
  ring

/-- Mean reproduction when productive return may vary across implementations:
    r_i = h_i - alpha c_i. -/
theorem mean_return_cost (h : I → ℝ)
    (hlin : ∀ i, r i = h i - α * c i) :
    mean p r = mean p h - α * mean p c := by
  simp only [mean]
  have ht : ∀ i : I,
      p i * r i = p i * h i - α * (p i * c i) := by
    intro i
    rw [hlin i]
    ring
  rw [Finset.sum_congr rfl (fun i _ => ht i)]
  rw [Finset.sum_sub_distrib, ← Finset.mul_sum]

/-- Mixed second moment for varying productive return. -/
theorem sum_return_cost (h : I → ℝ)
    (hlin : ∀ i, r i = h i - α * c i) :
    (∑ i, p i * r i * c i)
      = (∑ i, p i * h i * c i)
        - α * (∑ i, p i * c i * c i) := by
  have ht : ∀ i : I,
      p i * r i * c i
        = p i * h i * c i - α * (p i * c i * c i) := by
    intro i
    rw [hlin i]
    ring
  rw [Finset.sum_congr rfl (fun i _ => ht i)]
  rw [Finset.sum_sub_distrib, ← Finset.mul_sum]

/-- General benefit-cost covariance decomposition:
    cov(r,c) = cov(h,c) - alpha var(c). -/
theorem cov_return_cost (h : I → ℝ)
    (hp : ∑ i, p i = 1)
    (hlin : ∀ i, r i = h i - α * c i) :
    cov p r c = cov p h c - α * variance p c := by
  rw [cov_eq_sub p r c hp,
      cov_eq_sub p h c hp,
      cov_eq_sub p c c hp,
      sum_return_cost p c r α h hlin,
      mean_return_cost p c r α h hlin]
  ring

/-- Continuous-time replicator vector field for a Malthusian growth rate.
Unlike a discrete reproduction factor, the entries of m may be negative. -/
noncomputable def replicatorVelocity (p m : I → ℝ) : I → ℝ :=
  fun i => p i * (m i - mean p m)

/-- Instantaneous velocity of the mean of a fixed trait under the replicator
vector field. -/
noncomputable def meanTraitVelocity (p m trait : I → ℝ) : ℝ :=
  ∑ i, replicatorVelocity p m i * trait i

/-- Continuous Price/covariance identity for the replicator vector field. -/
theorem meanTraitVelocity_eq_cov (m trait : I → ℝ)
    (hp : ∑ i, p i = 1) :
    meanTraitVelocity p m trait = cov p m trait := by
  rw [cov_eq_sub p m trait hp]
  simp only [meanTraitVelocity, replicatorVelocity, mean]
  have ht : ∀ i : I,
      p i * (m i - ∑ j, p j * m j) * trait i
        = p i * m i * trait i
          - (∑ j, p j * m j) * (p i * trait i) := by
    intro i
    ring
  rw [Finset.sum_congr rfl (fun i _ => ht i)]
  rw [Finset.sum_sub_distrib, ← Finset.mul_sum]
  ring

/-- General continuous-time cost drift with varying productive return. -/
theorem continuous_cost_velocity_return_cost (h : I → ℝ)
    (hp : ∑ i, p i = 1)
    (hlin : ∀ i, r i = h i - α * c i) :
    meanTraitVelocity p r c = cov p h c - α * variance p c := by
  rw [meanTraitVelocity_eq_cov p r c hp,
      cov_return_cost p c r α h hp hlin]

/-- Exact same-function fibre: continuous competition drives implementation
cost downward at rate alpha times the weighted cost variance. -/
theorem continuous_cost_velocity_linear
    (hp : ∑ i, p i = 1)
    (hlin : ∀ i, r i = b - α * c i) :
    meanTraitVelocity p r c = - α * variance p c := by
  rw [meanTraitVelocity_eq_cov p r c hp,
      cov_linear p c r b α hp hlin]

theorem continuous_cost_velocity_nonpos
    (hp : ∑ i, p i = 1)
    (hpnn : ∀ i, 0 ≤ p i)
    (hα : 0 ≤ α)
    (hlin : ∀ i, r i = b - α * c i) :
    meanTraitVelocity p r c ≤ 0 := by
  rw [continuous_cost_velocity_linear p c r b α hp hlin]
  have hvar : 0 ≤ variance p c := variance_nonneg p c hpnn
  nlinarith

noncomputable def step (p r : I → ℝ) : I → ℝ :=
  fun i => p i * r i / (∑ j, p j * r j)

theorem step_sum_one (hr : (∑ j, p j * r j) ≠ 0) :
    ∑ i, step p r i = 1 := by
  simp only [step, ← Finset.sum_div]
  exact div_self hr

/-- If pre-selection weights and reproduction factors are non-negative and
mean fitness is positive, the replicator step has non-negative weights. -/
theorem step_nonneg
    (hpnn : ∀ i, 0 ≤ p i) (hrnn : ∀ i, 0 ≤ r i)
    (hrbar : 0 < ∑ j, p j * r j) :
    ∀ i, 0 ≤ step p r i := by
  intro i
  unfold step
  exact div_nonneg (mul_nonneg (hpnn i) (hrnn i)) (le_of_lt hrbar)

/-- Under the same assumptions, the selection step is a genuine probability
distribution: non-negative weights summing to one. -/
theorem step_is_distribution
    (hpnn : ∀ i, 0 ≤ p i) (hrnn : ∀ i, 0 ≤ r i)
    (hrbar : 0 < ∑ j, p j * r j) :
    (∀ i, 0 ≤ step p r i) ∧ (∑ i, step p r i = 1) := by
  constructor
  · exact step_nonneg p r hpnn hrnn hrbar
  · exact step_sum_one p r (ne_of_gt hrbar)

/-- Pure selection cannot create an implementation absent before selection.
Novel implementations require a separate variation/injection mechanism. -/
theorem step_zero_of_zero (i : I) (hzero : p i = 0) :
    step p r i = 0 := by
  simp [step, hzero]

theorem price_equation (hp : ∑ i, p i = 1) (hr : (∑ j, p j * r j) ≠ 0) :
    mean (step p r) c - mean p c = cov p r c / (∑ j, p j * r j) := by
  have hlhs : mean (step p r) c
      = (∑ i, p i * r i * c i) / (∑ j, p j * r j) := by
    simp only [mean, step, div_mul_eq_mul_div, ← Finset.sum_div]
  have hcov : cov p r c
      = (∑ i, p i * r i * c i) - (∑ j, p j * r j) * mean p c := by
    rw [cov_eq_sub p r c hp]; rfl
  rw [hlhs, hcov]
  field_simp

/-- The general fixed-fitness selection arrow: mean reproduction factor
changes by variance divided by mean reproduction factor. -/
theorem mean_fitness_change
    (hp : ∑ i, p i = 1) (hr : (∑ j, p j * r j) ≠ 0) :
    mean (step p r) r - mean p r
      = variance p r / (∑ j, p j * r j) := by
  rw [price_equation p r r hp hr]
  rfl

theorem mean_fitness_nondecreasing
    (hp : ∑ i, p i = 1) (hpnn : ∀ i, 0 ≤ p i)
    (hrbar : 0 < ∑ j, p j * r j) :
    mean p r ≤ mean (step p r) r := by
  have key := mean_fitness_change p r hp (ne_of_gt hrbar)
  have hvar : 0 ≤ variance p r := variance_nonneg p r hpnn
  have hdiv : 0 ≤ variance p r / (∑ j, p j * r j) :=
    div_nonneg hvar (le_of_lt hrbar)
  linarith

theorem mean_fitness_strictly_increases
    (hp : ∑ i, p i = 1) (hpnn : ∀ i, 0 ≤ p i)
    (hrbar : 0 < ∑ j, p j * r j)
    (hvar : 0 < variance p r) :
    mean p r < mean (step p r) r := by
  have key := mean_fitness_change p r hp (ne_of_gt hrbar)
  have hdiv : 0 < variance p r / (∑ j, p j * r j) :=
    div_pos hvar hrbar
  linarith

theorem price_linear (hp : ∑ i, p i = 1) (hr : (∑ j, p j * r j) ≠ 0)
    (hlin : ∀ i, r i = b - α * c i) :
    mean (step p r) c - mean p c
      = - α * variance p c / (∑ j, p j * r j) := by
  rw [price_equation p c r hp hr, cov_linear p c r b α hp hlin]

/-- General Price identity for the return-cost tradeoff. -/
theorem price_return_cost (h : I → ℝ)
    (hp : ∑ i, p i = 1) (hr : (∑ j, p j * r j) ≠ 0)
    (hlin : ∀ i, r i = h i - α * c i) :
    mean (step p r) c - mean p c
      = (cov p h c - α * variance p c) / (∑ j, p j * r j) := by
  rw [price_equation p c r hp hr, cov_return_cost p c r α h hp hlin]

/-- With positive mean reproduction, mean implementation cost decreases whenever
the covariance between productive return and cost does not exceed the
cost-selection term alpha Var(c). -/
theorem mean_cost_nonincreasing_of_return_tradeoff (h : I → ℝ)
    (hp : ∑ i, p i = 1)
    (hrbar : 0 < ∑ j, p j * r j)
    (hlin : ∀ i, r i = h i - α * c i)
    (htrade : cov p h c ≤ α * variance p c) :
    mean (step p r) c ≤ mean p c := by
  have key := price_return_cost p c r α h hp (ne_of_gt hrbar) hlin
  have hnum : cov p h c - α * variance p c ≤ 0 :=
    sub_nonpos.mpr htrade
  have hdiv :
      (cov p h c - α * variance p c) / (∑ j, p j * r j) ≤ 0 :=
    div_nonpos_of_nonpos_of_nonneg hnum (le_of_lt hrbar)
  linarith

theorem mean_cost_nonincreasing
    (hp : ∑ i, p i = 1) (hpnn : ∀ i, 0 ≤ p i)
    (hα : 0 ≤ α) (hrbar : 0 < ∑ j, p j * r j)
    (hlin : ∀ i, r i = b - α * c i) :
    mean (step p r) c ≤ mean p c := by
  have key := price_linear p c r b α hp (ne_of_gt hrbar) hlin
  have hvar : 0 ≤ variance p c := variance_nonneg p c hpnn
  have hnum : - α * variance p c ≤ 0 := by nlinarith
  have hdiv : - α * variance p c / (∑ j, p j * r j) ≤ 0 :=
    div_nonpos_of_nonpos_of_nonneg hnum (le_of_lt hrbar)
  linarith

theorem slack_nondecreasing (H : ℝ)
    (hp : ∑ i, p i = 1) (hpnn : ∀ i, 0 ≤ p i)
    (hα : 0 ≤ α) (hrbar : 0 < ∑ j, p j * r j)
    (hlin : ∀ i, r i = b - α * c i) :
    H - mean p c ≤ H - mean (step p r) c := by
  have := mean_cost_nonincreasing p c r b α hp hpnn hα hrbar hlin
  linarith

theorem drift_eq_zero_iff_variance_eq_zero
    (hp : ∑ i, p i = 1) (hα : 0 < α) (hrbar : 0 < ∑ j, p j * r j)
    (hlin : ∀ i, r i = b - α * c i) :
    mean (step p r) c = mean p c ↔ variance p c = 0 := by
  have key := price_linear p c r b α hp (ne_of_gt hrbar) hlin
  constructor
  · intro h
    have hz : - α * variance p c / (∑ j, p j * r j) = 0 := by
      rw [← key, h, sub_self]
    rcases div_eq_zero_iff.mp hz with h1 | h1
    · have h2 : α * variance p c = 0 := by linarith
      rcases mul_eq_zero.mp h2 with h3 | h3
      · exact absurd h3 (ne_of_gt hα)
      · exact h3
    · exact absurd h1 (ne_of_gt hrbar)
  · intro h
    rw [h] at key
    simp only [mul_zero, neg_mul, neg_zero, zero_div] at key
    linarith

theorem mean_cost_nondecreasing_of_neg_mean_fitness
    (hp : ∑ i, p i = 1) (hpnn : ∀ i, 0 ≤ p i)
    (hα : 0 ≤ α) (hrbar : (∑ j, p j * r j) < 0)
    (hlin : ∀ i, r i = b - α * c i) :
    mean p c ≤ mean (step p r) c := by
  have key := price_linear p c r b α hp (ne_of_lt hrbar) hlin
  have hvar : 0 ≤ variance p c := variance_nonneg p c hpnn
  have hnum : - α * variance p c ≤ 0 := by nlinarith
  have hnumpos : 0 ≤ α * variance p c := mul_nonneg hα hvar
  have hdenpos : 0 ≤ -(∑ j, p j * r j) := by linarith
  have hpos : 0 ≤ (α * variance p c) / (-(∑ j, p j * r j)) :=
    div_nonneg hnumpos hdenpos
  have heq :
      - α * variance p c / (∑ j, p j * r j)
        = (α * variance p c) / (-(∑ j, p j * r j)) := by
    simp [div_eq_mul_inv]
  have hdiv : 0 ≤ - α * variance p c / (∑ j, p j * r j) := by
    rw [heq]
    exact hpos
  linarith

#print axioms cov_eq_sub
#print axioms variance_nonneg
#print axioms mean_linear
#print axioms sum_fitness_cost
#print axioms cov_linear
#print axioms mean_return_cost
#print axioms sum_return_cost
#print axioms cov_return_cost
#print axioms meanTraitVelocity_eq_cov
#print axioms continuous_cost_velocity_return_cost
#print axioms continuous_cost_velocity_linear
#print axioms continuous_cost_velocity_nonpos
#print axioms price_return_cost
#print axioms mean_cost_nonincreasing_of_return_tradeoff
#print axioms step_sum_one
#print axioms step_nonneg
#print axioms step_is_distribution
#print axioms step_zero_of_zero
#print axioms price_equation
#print axioms mean_fitness_change
#print axioms mean_fitness_nondecreasing
#print axioms mean_fitness_strictly_increases
#print axioms price_linear
#print axioms mean_cost_nonincreasing
#print axioms slack_nondecreasing
#print axioms drift_eq_zero_iff_variance_eq_zero\n#print axioms mean_cost_nondecreasing_of_neg_mean_fitness

end FunctionalCompetition
