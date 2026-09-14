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

noncomputable def step (p r : I → ℝ) : I → ℝ :=
  fun i => p i * r i / (∑ j, p j * r j)

theorem step_sum_one (hr : (∑ j, p j * r j) ≠ 0) :
    ∑ i, step p r i = 1 := by
  simp only [step, ← Finset.sum_div]
  exact div_self hr

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

theorem price_linear (hp : ∑ i, p i = 1) (hr : (∑ j, p j * r j) ≠ 0)
    (hlin : ∀ i, r i = b - α * c i) :
    mean (step p r) c - mean p c
      = - α * variance p c / (∑ j, p j * r j) := by
  rw [price_equation p c r hp hr, cov_linear p c r b α hp hlin]

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
  have hdiv : 0 ≤ - α * variance p c / (∑ j, p j * r j) :=
    div_nonneg_of_nonpos_of_nonpos hnum (le_of_lt hrbar)
  linarith

#print axioms cov_eq_sub
#print axioms variance_nonneg
#print axioms mean_linear
#print axioms sum_fitness_cost
#print axioms cov_linear
#print axioms step_sum_one
#print axioms price_equation
#print axioms price_linear
#print axioms mean_cost_nonincreasing
#print axioms slack_nondecreasing
#print axioms drift_eq_zero_iff_variance_eq_zero

end FunctionalCompetition
