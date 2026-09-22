import Mathlib.Data.Finset.Basic
import Mathlib.Tactic

namespace CumulativeAccessibility
namespace PaidReuse

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-!
# Paid reuse and hierarchy

This module machine-checks the additive reuse threshold used in the v19
repetition/hierarchy notes.

For one reusable module:

* `n` = number of uses;
* `c` = inline cost per use;
* `r` = reference/reuse cost per use after retention;
* `h` = one-time retention/upkeep burden.

Inlining costs `n*c`. Retaining once and referencing thereafter costs
`c + h + n*r`.

The module also proves a generic finite-dictionary theorem: if adding any
omitted reusable level strictly lowers the objective, then every global
minimizer is the full dictionary.
-/

/-- Cost of representing `n` occurrences inline. -/
def InlineCost (n : ℕ) (c : ℝ) : ℝ :=
  (n : ℝ) * c

/-- Cost of one retained definition plus `n` references. -/
def RetainedReuseCost
    (n : ℕ)
    (c r h : ℝ) : ℝ :=
  c + h + (n : ℝ) * r

/-- Net saving produced by retention relative to inlining. -/
def ReuseGain
    (n : ℕ)
    (c r h : ℝ) : ℝ :=
  InlineCost n c - RetainedReuseCost n c r h

/-- Retention is strictly beneficial exactly when the v19 threshold holds. -/
theorem retainedReuseCost_lt_inlineCost_iff
    (n : ℕ)
    (c r h : ℝ) :
    RetainedReuseCost n c r h < InlineCost n c
      ↔
    ((n : ℝ) - 1) * c >
      (n : ℝ) * r + h := by
  unfold RetainedReuseCost InlineCost
  constructor <;> intro h0 <;> linarith

/-- The gain expression is the threshold margin. -/
theorem reuseGain_eq_thresholdMargin
    (n : ℕ)
    (c r h : ℝ) :
    ReuseGain n c r h =
      ((n : ℝ) - 1) * c - ((n : ℝ) * r + h) := by
  unfold ReuseGain InlineCost RetainedReuseCost
  ring

/-- One use cannot justify a purely representational retained scaffold when
reference and upkeep costs are nonnegative. -/
theorem singleUse_retention_not_strictly_beneficial
    (c r h : ℝ)
    (hr : 0 ≤ r)
    (hh : 0 ≤ h) :
    ¬ RetainedReuseCost 1 c r h < InlineCost 1 c := by
  intro hBenefit
  norm_num [RetainedReuseCost, InlineCost] at hBenefit
  linarith

/-- If the declared threshold margin is positive, retention is strictly
beneficial. -/
theorem positive_threshold_implies_retention_beneficial
    (n : ℕ)
    (c r h : ℝ)
    (hThreshold :
      (n : ℝ) * r + h <
        ((n : ℝ) - 1) * c) :
    RetainedReuseCost n c r h < InlineCost n c := by
  exact (retainedReuseCost_lt_inlineCost_iff n c r h).2 hThreshold

/-- Separable retained-dictionary objective. `base` is the all-inline cost;
each retained module subtracts its declared positive reuse gain. -/
def DictionaryObjective
    (base : ℝ)
    (gain : ι → ℝ)
    (D : Finset ι) : ℝ :=
  base - ∑ i in D, gain i

/-- Adding an omitted positive-gain module strictly lowers the dictionary
objective. -/
theorem insert_positiveGain_strictly_improves
    (base : ℝ)
    (gain : ι → ℝ)
    (D : Finset ι)
    (i : ι)
    (hi : i ∉ D)
    (hGain : 0 < gain i) :
    DictionaryObjective base gain (insert i D) <
      DictionaryObjective base gain D := by
  simp [DictionaryObjective, Finset.sum_insert, hi]
  linarith

/-- Generic finite hierarchy theorem: whenever every omitted level can be added
with strict objective improvement, any global minimizer must contain every
level. -/
theorem every_global_minimizer_is_full
    (F : Finset ι → ℝ)
    (hImprove :
      ∀ D i, i ∉ D → F (insert i D) < F D)
    (D : Finset ι)
    (hOptimal :
      ∀ D', F D ≤ F D') :
    D = Finset.univ := by
  apply Finset.eq_univ_of_forall
  intro i
  by_contra hi
  have hStrict := hImprove D i hi
  have hOpt := hOptimal (insert i D)
  linarith

/-- In the separable paid-reuse model, strictly positive gain at every level
forces every global minimizer to retain the full dictionary. -/
theorem positiveReuseGain_forces_full_dictionary
    (base : ℝ)
    (gain : ι → ℝ)
    (hGain : ∀ i, 0 < gain i)
    (D : Finset ι)
    (hOptimal :
      ∀ D', DictionaryObjective base gain D ≤
        DictionaryObjective base gain D') :
    D = Finset.univ := by
  apply every_global_minimizer_is_full
    (F := DictionaryObjective base gain)
    (hImprove := ?_)
    D hOptimal
  intro D' i hi
  exact insert_positiveGain_strictly_improves
    base gain D' i hi (hGain i)

/-- The v19 per-level repetition threshold is sufficient for the full-dictionary
result in the separable additive model. -/
theorem repetitionThresholds_force_full_dictionary
    (base : ℝ)
    (n : ι → ℕ)
    (c r h : ι → ℝ)
    (hThreshold :
      ∀ i,
        (n i : ℝ) * r i + h i <
          ((n i : ℝ) - 1) * c i)
    (D : Finset ι)
    (hOptimal :
      ∀ D',
        DictionaryObjective base
          (fun i => ReuseGain (n i) (c i) (r i) (h i))
          D
        ≤
        DictionaryObjective base
          (fun i => ReuseGain (n i) (c i) (r i) (h i))
          D') :
    D = Finset.univ := by
  apply positiveReuseGain_forces_full_dictionary
    (base := base)
    (gain := fun i => ReuseGain (n i) (c i) (r i) (h i))
    (hGain := ?_)
    D hOptimal
  intro i
  rw [reuseGain_eq_thresholdMargin]
  linarith [hThreshold i]

#print axioms retainedReuseCost_lt_inlineCost_iff
#print axioms singleUse_retention_not_strictly_beneficial
#print axioms repetitionThresholds_force_full_dictionary

end PaidReuse
end CumulativeAccessibility
