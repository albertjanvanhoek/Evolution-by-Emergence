import Mathlib

namespace AffinityLayer

noncomputable section

/-! # Association strength before accessibility

Two independent sufficient mechanisms can create an interior association optimum.

1. Cost channel: productive coupling rises with association strength while
   maintained association overhead grows linearly.
2. Turnover channel: there is no maintained-association overhead, but productive
   turnover itself is Sabatier-shaped because binding that is too weak fails to
   hold and binding that is too strong fails to release.

The formalization checks only the algebra of these reduced models. It does not
claim a universal microscopic law of binding or derive the reduced forms from
molecular physics.
-/

/-- Productive mass in the normalized linear-affinity model. -/
noncomputable def productiveMass (lam a : ℝ) : ℝ :=
  2 - 1 / (a * lam)

/-- Productive mass remaining per unit linear association overhead. -/
noncomputable def costScore (lam c a : ℝ) : ℝ :=
  productiveMass lam a / (1 + c * a)

/-- Declared margin after multiplying productive mass by a positive capability
scale K. -/
noncomputable def costMargin (K lam c a : ℝ) : ℝ :=
  K * costScore lam c a - 1

/-- Exact global-optimum certificate for the linear-upkeep channel.
If a0 satisfies the stationary quadratic, the score gap is a nonnegative
square divided by a positive denominator. -/
theorem costScore_difference_of_stationary
    {lam c a a0 : ℝ}
    (ha : 0 < a) (ha0 : 0 < a0)
    (hlam : 0 < lam) (hc : 0 < c)
    (hstat : 2 * c * lam * a0^2 = 1 + 2 * c * a0) :
    costScore lam c a0 - costScore lam c a
      =
    (a - a0)^2 / (a * a0^2 * lam * (1 + c * a)) := by
  unfold costScore productiveMass
  have hane : a ≠ 0 := ne_of_gt ha
  have ha0ne : a0 ≠ 0 := ne_of_gt ha0
  have hlamne : lam ≠ 0 := ne_of_gt hlam
  have hca : 1 + c * a ≠ 0 := by nlinarith
  have hca0 : 1 + c * a0 ≠ 0 := by nlinarith
  field_simp [hane, ha0ne, hlamne, hca, hca0]
  ring_nf at hstat ⊢
  nlinarith [hstat]

/-- Any positive stationary point of the linear-upkeep score is a global
maximizer on positive affinity. -/
theorem costScore_le_of_stationary
    {lam c a a0 : ℝ}
    (ha : 0 < a) (ha0 : 0 < a0)
    (hlam : 0 < lam) (hc : 0 < c)
    (hstat : 2 * c * lam * a0^2 = 1 + 2 * c * a0) :
    costScore lam c a ≤ costScore lam c a0 := by
  rw [← sub_nonneg]
  rw [costScore_difference_of_stationary ha ha0 hlam hc hstat]
  have hden : 0 < a * a0^2 * lam * (1 + c * a) := by positivity
  exact div_nonneg (sq_nonneg (a - a0)) (le_of_lt hden)

/-- Explicit positive optimizer for the normalized linear-upkeep channel. -/
noncomputable def costAStar (lam c : ℝ) : ℝ :=
  (1 + Real.sqrt (1 + 2 * lam / c)) / (2 * lam)

theorem costAStar_pos
    {lam c : ℝ} (hlam : 0 < lam) (hc : 0 < c) :
    0 < costAStar lam c := by
  unfold costAStar
  have hs : 0 ≤ Real.sqrt (1 + 2 * lam / c) := Real.sqrt_nonneg _
  have hden : 0 < 2 * lam := by linarith
  positivity

/-- The explicit optimizer satisfies the stationary quadratic. -/
theorem costAStar_stationary
    {lam c : ℝ} (hlam : 0 < lam) (hc : 0 < c) :
    2 * c * lam * (costAStar lam c)^2
      =
    1 + 2 * c * costAStar lam c := by
  let s : ℝ := Real.sqrt (1 + 2 * lam / c)
  have harg : 0 ≤ 1 + 2 * lam / c := by positivity
  have hs2raw : s^2 = 1 + 2 * lam / c := by
    dsimp [s]
    simpa using Real.sq_sqrt harg
  have hcne : c ≠ 0 := ne_of_gt hc
  have hs2 : c * s^2 = c + 2 * lam := by
    field_simp [hcne] at hs2raw
    nlinarith [hs2raw]
  have hlamne : lam ≠ 0 := ne_of_gt hlam
  change 2 * c * lam * ((1 + s) / (2 * lam))^2
      = 1 + 2 * c * ((1 + s) / (2 * lam))
  field_simp [hlamne]
  nlinarith [hs2]

theorem costAStar_global_max
    {lam c a : ℝ}
    (ha : 0 < a) (hlam : 0 < lam) (hc : 0 < c) :
    costScore lam c a ≤ costScore lam c (costAStar lam c) := by
  apply costScore_le_of_stationary ha (costAStar_pos hlam hc) hlam hc
  exact costAStar_stationary hlam hc

/-- Auxiliary square-root variable used for the closed-form peak height. -/
noncomputable def costS (lam c : ℝ) : ℝ :=
  Real.sqrt (1 + 2 * lam / c)

/-- Closed-form peak score for the linear-upkeep channel. -/
theorem costScore_at_aStar
    {lam c : ℝ} (hlam : 0 < lam) (hc : 0 < c) :
    costScore lam c (costAStar lam c)
      =
    2 * (costS lam c - 1) / (costS lam c + 1) := by
  let s : ℝ := Real.sqrt (1 + 2 * lam / c)
  have harg : 0 ≤ 1 + 2 * lam / c := by positivity
  have hs2raw : s^2 = 1 + 2 * lam / c := by
    dsimp [s]
    simpa using Real.sq_sqrt harg
  have hcne : c ≠ 0 := ne_of_gt hc
  have hs2 : c * s^2 = c + 2 * lam := by
    field_simp [hcne] at hs2raw
    nlinarith [hs2raw]
  have hs : 0 ≤ s := by
    dsimp [s]
    exact Real.sqrt_nonneg _
  have hs1 : s + 1 ≠ 0 := by linarith
  have hlamne : lam ≠ 0 := ne_of_gt hlam
  change
    (2 - 1 / (((1 + s) / (2 * lam)) * lam)) /
        (1 + c * ((1 + s) / (2 * lam)))
      =
    2 * (s - 1) / (s + 1)
  field_simp [hlamne, hcne, hs1]
  nlinarith [hs2]

/-- Peak declared margin in closed form. -/
theorem costMargin_at_aStar
    {K lam c : ℝ} (hlam : 0 < lam) (hc : 0 < c) :
    costMargin K lam c (costAStar lam c)
      =
    2 * K * (costS lam c - 1) / (costS lam c + 1) - 1 := by
  unfold costMargin
  rw [costScore_at_aStar hlam hc]
  ring

/-- Closed-form linear-upkeep viability threshold. -/
noncomputable def costCritical (K lam : ℝ) : ℝ :=
  lam * (2 * K - 1)^2 / (4 * K)

/-! ## Turnover/Sabatier channel: no maintained-association overhead -/

/-- Symmetric association-turnover factor. It vanishes for arbitrarily weak
or strong association and peaks at one. -/
noncomputable def turnoverShape (a : ℝ) : ℝ :=
  4 * a / (1 + a)^2

theorem turnoverShape_pos {a : ℝ} (ha : 0 < a) :
    0 < turnoverShape a := by
  unfold turnoverShape
  have hden : 0 < (1 + a)^2 := by positivity
  exact div_pos (by positivity) hden

theorem turnoverShape_le_one {a : ℝ} (ha : 0 < a) :
    turnoverShape a ≤ 1 := by
  unfold turnoverShape
  have hden : 0 < (1 + a)^2 := by positivity
  apply (div_le_iff₀ hden).2
  nlinarith [sq_nonneg (a - 1)]

theorem turnoverShape_eq_one_iff {a : ℝ} (ha : 0 < a) :
    turnoverShape a = 1 ↔ a = 1 := by
  constructor
  · intro h
    unfold turnoverShape at h
    have hden : 0 < (1 + a)^2 := by positivity
    have hcross := (div_eq_iff (ne_of_gt hden)).1 h
    nlinarith [sq_nonneg (a - 1)]
  · intro h
    subst a
    norm_num [turnoverShape]

/-- Effective productive spectral scale in the turnover channel. -/
noncomputable def turnoverLambda (lam a : ℝ) : ℝ :=
  lam * turnoverShape a

theorem turnoverLambda_le_peak
    {lam a : ℝ} (hlam : 0 < lam) (ha : 0 < a) :
    turnoverLambda lam a ≤ lam := by
  unfold turnoverLambda
  nlinarith [turnoverShape_le_one ha]

/-- Productive mass with Sabatier-shaped turnover and no association overhead. -/
noncomputable def turnoverMass (lam a : ℝ) : ℝ :=
  2 - 1 / turnoverLambda lam a

/-- The no-upkeep turnover channel has its global productive-mass maximum at
intermediate association a=1. -/
theorem turnoverMass_le_peak
    {lam a : ℝ} (hlam : 0 < lam) (ha : 0 < a) :
    turnoverMass lam a ≤ turnoverMass lam 1 := by
  have hshape : 0 < turnoverShape a := turnoverShape_pos ha
  have hlamA : 0 < turnoverLambda lam a := by
    unfold turnoverLambda
    positivity
  have hle : turnoverLambda lam a ≤ lam := turnoverLambda_le_peak hlam ha
  have hinv : 1 / lam ≤ 1 / turnoverLambda lam a := by
    exact (div_le_div_iff₀ hlam hlamA).2 (by simpa using hle)
  have hpeak : turnoverLambda lam 1 = lam := by
    norm_num [turnoverLambda, turnoverShape]
  unfold turnoverMass
  rw [hpeak]
  linarith

/-- Exact normalized witness: with lam=6/5 and K=56/33, the no-upkeep
turnover channel peaks at a=1 with margin 97/99, while a=1/2 and a=2
give the lower symmetric margin 53/66. -/
theorem turnover_exact_witness :
    let lam : ℝ := 6 / 5
    let K : ℝ := 56 / 33
    let margin := fun a => K * turnoverMass lam a - 1
    margin 1 = 97 / 99
      ∧ margin (1 / 2) = 53 / 66
      ∧ margin 2 = 53 / 66 := by
  norm_num [turnoverMass, turnoverLambda, turnoverShape]

/-- In the same exact witness, sufficiently weak and sufficiently strong
association both fail the positive-mass condition, without any upkeep cost:
a=1/10 and a=10 produce turnover lambda 48/121 < 1/2. -/
theorem turnover_exact_two_sided_failure :
    turnoverLambda (6 / 5 : ℝ) (1 / 10) = 48 / 121
      ∧ turnoverLambda (6 / 5 : ℝ) 10 = 48 / 121
      ∧ (48 / 121 : ℝ) < 1 / 2 := by
  norm_num [turnoverLambda, turnoverShape]

#print axioms costScore_difference_of_stationary
#print axioms costScore_le_of_stationary
#print axioms costAStar_stationary
#print axioms costAStar_global_max
#print axioms costScore_at_aStar
#print axioms turnoverShape_le_one
#print axioms turnoverShape_eq_one_iff
#print axioms turnoverMass_le_peak
#print axioms turnover_exact_witness
#print axioms turnover_exact_two_sided_failure

end

end AffinityLayer
