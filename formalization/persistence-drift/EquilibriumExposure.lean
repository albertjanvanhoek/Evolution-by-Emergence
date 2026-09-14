import Mathlib

namespace EquilibriumExposure

/-- Resource level at a positive Perron equilibrium. -/
noncomputable def rStar (d lambda : ℝ) : ℝ := d / lambda

/-- Total maintained abundance at the positive equilibrium. -/
noncomputable def xStar (J ell d lambda : ℝ) : ℝ :=
  (J - ell * rStar d lambda) / d

/-- Critical external supply for positive abundance. -/
noncomputable def jCrit (ell d lambda : ℝ) : ℝ :=
  ell * rStar d lambda

/-- Gross mean production/replacement rate at a Perron equilibrium. -/
noncomputable def grossMeanStar (d lambda : ℝ) : ℝ :=
  rStar d lambda * lambda

/-- External supply required to maintain a chosen total abundance X at a
positive Perron equilibrium. This is the natural fixed-scale budget. -/
noncomputable def requiredSupply (X ell d lambda : ℝ) : ℝ :=
  d * X + ell * rStar d lambda

/-- Maximum number of realizations compatible with total abundance X when each
realization requires at least mMin units of abundance. This is an upper bound,
not an equality or a prediction of actual N. -/
noncomputable def realizationUpperBound (X mMin : ℝ) : ℝ :=
  X / mMin

/-- Candidate-generation exposure if attempts occur at per-abundance rate nu. -/
noncomputable def candidateExposure (J ell d nu lambda : ℝ) : ℝ :=
  nu * xStar J ell d lambda

/-- The equilibrium gross mean production rate is pinned to the loss rate.
Thus mean fitness cannot distinguish positive equilibria with different
production efficiencies lambda. -/
theorem gross_mean_star_eq_loss
    (d lambda : ℝ) (hlambda : lambda ≠ 0) :
    grossMeanStar d lambda = d := by
  unfold grossMeanStar rStar
  field_simp

/-- Increasing collective production efficiency lowers the equilibrium
resource level required for maintenance. -/
theorem r_star_strictly_decreases
    (d lambda1 lambda2 : ℝ)
    (hd : 0 < d)
    (hlambda1 : 0 < lambda1)
    (hlt : lambda1 < lambda2) :
    rStar d lambda2 < rStar d lambda1 := by
  have hlambda2 : 0 < lambda2 := lt_trans hlambda1 hlt
  unfold rStar
  apply (div_lt_div_iff₀ hlambda2 hlambda1).2
  nlinarith

/-- The critical external supply for maintenance decreases with production
efficiency. -/
theorem jcrit_strictly_decreases
    (ell d lambda1 lambda2 : ℝ)
    (hell : 0 < ell)
    (hd : 0 < d)
    (hlambda1 : 0 < lambda1)
    (hlt : lambda1 < lambda2) :
    jCrit ell d lambda2 < jCrit ell d lambda1 := by
  unfold jCrit
  have hr := r_star_strictly_decreases d lambda1 lambda2 hd hlambda1 hlt
  exact mul_lt_mul_of_pos_left hr hell

/-- At fixed external inflow, increasing production efficiency increases the
amount of organization that can be maintained at equilibrium. -/
theorem x_star_strictly_increases
    (J ell d lambda1 lambda2 : ℝ)
    (hell : 0 < ell)
    (hd : 0 < d)
    (hlambda1 : 0 < lambda1)
    (hlt : lambda1 < lambda2) :
    xStar J ell d lambda1 < xStar J ell d lambda2 := by
  have hr := r_star_strictly_decreases d lambda1 lambda2 hd hlambda1 hlt
  have hscaled :
      ell * rStar d lambda2 < ell * rStar d lambda1 :=
    mul_lt_mul_of_pos_left hr hell
  have hnum :
      J - ell * rStar d lambda1 < J - ell * rStar d lambda2 := by
    linarith
  unfold xStar
  exact (div_lt_div_iff₀ hd hd).2 (mul_lt_mul_of_pos_right hnum hd)

/-- If candidate generation is proportional to maintained abundance, the same
efficiency gain strictly increases candidate-generation exposure. -/
theorem candidate_exposure_strictly_increases
    (J ell d nu lambda1 lambda2 : ℝ)
    (hnu : 0 < nu)
    (hell : 0 < ell)
    (hd : 0 < d)
    (hlambda1 : 0 < lambda1)
    (hlt : lambda1 < lambda2) :
    candidateExposure J ell d nu lambda1
      < candidateExposure J ell d nu lambda2 := by
  unfold candidateExposure
  have hx :=
    x_star_strictly_increases J ell d lambda1 lambda2 hell hd hlambda1 hlt
  exact mul_lt_mul_of_pos_left hx hnu

/-- A compact model-specific statement of the budgetary bias:
higher production efficiency leaves equilibrium mean production pinned at d,
but lowers resource requirement and increases maintained abundance/exposure. -/
theorem efficiency_changes_exposure_not_equilibrium_mean_fitness
    (J ell d nu lambda1 lambda2 : ℝ)
    (hnu : 0 < nu)
    (hell : 0 < ell)
    (hd : 0 < d)
    (hlambda1 : 0 < lambda1)
    (hlt : lambda1 < lambda2) :
    grossMeanStar d lambda1 = grossMeanStar d lambda2
    ∧ rStar d lambda2 < rStar d lambda1
    ∧ xStar J ell d lambda1 < xStar J ell d lambda2
    ∧ candidateExposure J ell d nu lambda1
        < candidateExposure J ell d nu lambda2 := by
  have hlambda2 : 0 < lambda2 := lt_trans hlambda1 hlt
  constructor
  · rw [gross_mean_star_eq_loss d lambda1 (ne_of_gt hlambda1),
        gross_mean_star_eq_loss d lambda2 (ne_of_gt hlambda2)]
  constructor
  · exact r_star_strictly_decreases d lambda1 lambda2 hd hlambda1 hlt
  constructor
  · exact x_star_strictly_increases J ell d lambda1 lambda2 hell hd hlambda1 hlt
  · exact candidate_exposure_strictly_increases
      J ell d nu lambda1 lambda2 hnu hell hd hlambda1 hlt


/-- At fixed maintained scale X, increasing production efficiency strictly
reduces the external supply required. This is the model-specific budgetary
dividend; no idle resource pool is assumed. -/
theorem required_supply_strictly_decreases
    (X ell d lambda1 lambda2 : ℝ)
    (hell : 0 < ell)
    (hd : 0 < d)
    (hlambda1 : 0 < lambda1)
    (hlt : lambda1 < lambda2) :
    requiredSupply X ell d lambda2
      < requiredSupply X ell d lambda1 := by
  unfold requiredSupply
  have hr := r_star_strictly_decreases d lambda1 lambda2 hd hlambda1 hlt
  have hscaled :
      ell * rStar d lambda2 < ell * rStar d lambda1 :=
    mul_lt_mul_of_pos_left hr hell
  linarith

/-- If each realization needs at least mMin abundance, greater maintained
abundance raises only the upper bound on realization count. -/
theorem realization_upper_bound_strictly_increases
    (X1 X2 mMin : ℝ)
    (hm : 0 < mMin)
    (hX : X1 < X2) :
    realizationUpperBound X1 mMin < realizationUpperBound X2 mMin := by
  unfold realizationUpperBound
  exact (div_lt_div_iff₀ hm hm).2 (mul_lt_mul_of_pos_right hX hm)

/-- Combining the equilibrium result with the finite-material bound: higher
lambda raises the ceiling X*/mMin on the number of realizations, but this does
NOT assert that actual N rises. -/
theorem efficiency_raises_realization_ceiling
    (J ell d mMin lambda1 lambda2 : ℝ)
    (hell : 0 < ell)
    (hd : 0 < d)
    (hm : 0 < mMin)
    (hlambda1 : 0 < lambda1)
    (hlt : lambda1 < lambda2) :
    realizationUpperBound (xStar J ell d lambda1) mMin
      < realizationUpperBound (xStar J ell d lambda2) mMin := by
  apply realization_upper_bound_strictly_increases
  · exact hm
  · exact x_star_strictly_increases
      J ell d lambda1 lambda2 hell hd hlambda1 hlt

#print axioms required_supply_strictly_decreases
#print axioms realization_upper_bound_strictly_increases
#print axioms efficiency_raises_realization_ceiling

#print axioms gross_mean_star_eq_loss
#print axioms r_star_strictly_decreases
#print axioms jcrit_strictly_decreases
#print axioms x_star_strictly_increases
#print axioms candidate_exposure_strictly_increases
#print axioms efficiency_changes_exposure_not_equilibrium_mean_fitness

end EquilibriumExposure
