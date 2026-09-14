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

#print axioms gross_mean_star_eq_loss
#print axioms r_star_strictly_decreases
#print axioms jcrit_strictly_decreases
#print axioms x_star_strictly_increases
#print axioms candidate_exposure_strictly_increases
#print axioms efficiency_changes_exposure_not_equilibrium_mean_fitness

end EquilibriumExposure
