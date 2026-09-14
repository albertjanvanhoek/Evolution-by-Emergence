import FunctionalCompetition

namespace ReturnPathPrice

open Finset
open scoped BigOperators
open FunctionalCompetition

variable {I : Type*} [Fintype I]

theorem mean_sub (p f g : I → ℝ) :
    mean p (fun i => f i - g i) = mean p f - mean p g := by
  simp only [mean]
  have h : ∀ i : I, p i * (f i - g i) = p i * f i - p i * g i := by
    intro i
    ring
  rw [Finset.sum_congr rfl (fun i _ => h i)]
  rw [Finset.sum_sub_distrib]

theorem price_with_state_change
    (p r zOld zNew : I → ℝ)
    (hp : ∑ i, p i = 1)
    (hr : (∑ i, p i * r i) ≠ 0) :
    mean (step p r) zNew - mean p zOld
      =
      cov p r zOld / (∑ i, p i * r i)
      + mean (step p r) (fun i => zNew i - zOld i) := by
  have hprice :
      mean (step p r) zOld - mean p zOld
        = cov p r zOld / (∑ i, p i * r i) := by
    exact price_equation p zOld r hp hr
  have hchange :
      mean (step p r) (fun i => zNew i - zOld i)
        = mean (step p r) zNew - mean (step p r) zOld :=
    mean_sub (step p r) zNew zOld
  rw [hchange]
  linarith

theorem mean_fitness_with_state_change
    (p rOld rNew : I → ℝ)
    (hp : ∑ i, p i = 1)
    (hr : (∑ i, p i * rOld i) ≠ 0) :
    mean (step p rOld) rNew - mean p rOld
      =
      variance p rOld / (∑ i, p i * rOld i)
      + mean (step p rOld) (fun i => rNew i - rOld i) := by
  rw [price_with_state_change p rOld rOld rNew hp hr]
  rfl

theorem mean_fitness_nondecreasing_iff_return_bound
    (p rOld rNew : I → ℝ)
    (hp : ∑ i, p i = 1)
    (hr : (∑ i, p i * rOld i) ≠ 0) :
    mean p rOld ≤ mean (step p rOld) rNew
      ↔
    -(variance p rOld / (∑ i, p i * rOld i))
      ≤ mean (step p rOld) (fun i => rNew i - rOld i) := by
  have h := mean_fitness_with_state_change p rOld rNew hp hr
  constructor <;> intro hs <;> linarith

theorem mean_fitness_nondecreasing_of_nonnegative_return
    (p rOld rNew : I → ℝ)
    (hp : ∑ i, p i = 1)
    (hpnn : ∀ i, 0 ≤ p i)
    (hrbar : 0 < ∑ i, p i * rOld i)
    (hreturn : 0 ≤ mean (step p rOld) (fun i => rNew i - rOld i)) :
    mean p rOld ≤ mean (step p rOld) rNew := by
  have h := mean_fitness_with_state_change p rOld rNew hp (ne_of_gt hrbar)
  have hvar : 0 ≤ variance p rOld := variance_nonneg p rOld hpnn
  have hsel : 0 ≤ variance p rOld / (∑ i, p i * rOld i) :=
    div_nonneg hvar (le_of_lt hrbar)
  linarith

theorem mean_fitness_decreases_of_return_below_selection
    (p rOld rNew : I → ℝ)
    (hp : ∑ i, p i = 1)
    (hr : (∑ i, p i * rOld i) ≠ 0)
    (hbad :
      mean (step p rOld) (fun i => rNew i - rOld i)
        < -(variance p rOld / (∑ i, p i * rOld i))) :
    mean (step p rOld) rNew < mean p rOld := by
  have h := mean_fitness_with_state_change p rOld rNew hp hr
  linarith

theorem trait_nondecreasing_iff_return_bound
    (p r zOld zNew : I → ℝ)
    (hp : ∑ i, p i = 1)
    (hr : (∑ i, p i * r i) ≠ 0) :
    mean p zOld ≤ mean (step p r) zNew
      ↔
    -(cov p r zOld / (∑ i, p i * r i))
      ≤ mean (step p r) (fun i => zNew i - zOld i) := by
  have h := price_with_state_change p r zOld zNew hp hr
  constructor <;> intro hs <;> linarith

#print axioms mean_sub
#print axioms price_with_state_change
#print axioms mean_fitness_with_state_change
#print axioms mean_fitness_nondecreasing_iff_return_bound
#print axioms mean_fitness_nondecreasing_of_nonnegative_return
#print axioms mean_fitness_decreases_of_return_below_selection
#print axioms trait_nondecreasing_iff_return_bound

end ReturnPathPrice
