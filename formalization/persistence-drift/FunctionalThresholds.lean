import Mathlib

namespace FunctionalThresholds

/-- Functional margin after uniform downstream dilution by kappa.
If the undiluted bottleneck margin is M0, every host capacity ratio is
divided by (1+kappa). -/
noncomputable def extractionMargin (M0 kappa : ℝ) : ℝ :=
  (1 + M0) / (1 + kappa) - 1

/-- Exact simplification of the extraction margin. -/
theorem extraction_margin_eq
    (M0 kappa : ℝ) (hk : 1 + kappa ≠ 0) :
    extractionMargin M0 kappa = (M0 - kappa) / (1 + kappa) := by
  unfold extractionMargin
  field_simp [hk]
  ring

/-- If one-way extraction is nonnegative, functional viability after dilution
holds exactly while extraction does not exceed the pre-extraction margin. -/
theorem extraction_viable_iff
    (M0 kappa : ℝ) (hk : 0 ≤ kappa) :
    0 ≤ extractionMargin M0 kappa ↔ kappa ≤ M0 := by
  have hden : 0 < 1 + kappa := by linarith
  rw [extraction_margin_eq M0 kappa (ne_of_gt hden)]
  constructor
  · intro h
    have := (div_nonneg_iff).mp h
    rcases this with hcase | hcase
    · exact sub_nonneg.mp hcase.1
    · linarith
  · intro h
    exact div_nonneg (sub_nonneg.mpr h) (le_of_lt hden)

/-- The functional boundary occurs exactly at kappa = M0. -/
theorem extraction_margin_zero_at_budget
    (M0 : ℝ) (hM : -1 < M0) :
    extractionMargin M0 M0 = 0 := by
  unfold extractionMargin
  have hne : 1 + M0 ≠ 0 := by linarith
  rw [div_self hne]
  ring

/-- If extraction strength is kappa = q*u/lambda, its critical q value is
lambda*M0/u. -/
theorem single_channel_extraction_threshold
    (M0 q u lambda : ℝ)
    (hu : 0 < u) (hlambda : 0 < lambda) :
    q * u / lambda ≤ M0 ↔ q ≤ lambda * M0 / u := by
  constructor
  · intro h
    have h1 : q * u ≤ M0 * lambda := by
      exact (div_le_iff₀ hlambda).mp h
    have h2 : q ≤ (M0 * lambda) / u := by
      exact (le_div_iff₀ hu).2 h1
    simpa [mul_comm] using h2
  · intro h
    have h1 : q * u ≤ (lambda * M0 / u) * u := by
      exact mul_le_mul_of_nonneg_right h (le_of_lt hu)
    have hu0 : u ≠ 0 := ne_of_gt hu
    have h2 : q * u ≤ lambda * M0 := by
      simpa [hu0] using h1
    have h3 : q * u / lambda ≤ M0 := by
      exact (div_le_iff₀ hlambda).2 (by simpa [mul_comm] using h2)
    exact h3

/-- In the worked integrated-innovation example (J=2,d=ell=1,v=2),
using lambda as the parameter, equilibrium B abundance is
(2 - 1/lambda)*(2-lambda^2)/(1+lambda). -/
noncomputable def hollowB (lambda : ℝ) : ℝ :=
  (2 - 1 / lambda) * (2 - lambda^2) / (1 + lambda)

/-- The threshold x_B = 3/20 is algebraically equivalent to a cubic equation.
This avoids any square-root API: f is recovered later as lambda^2-1. -/
theorem hollowing_threshold_iff_cubic
    (lambda : ℝ)
    (h0 : lambda ≠ 0)
    (hm1 : 1 + lambda ≠ 0) :
    hollowB lambda = (3 : ℝ) / 20
      ↔ 40*lambda^3 - 17*lambda^2 - 77*lambda + 40 = 0 := by
  unfold hollowB
  field_simp [h0, hm1]
  constructor <;> intro h <;> nlinarith

/-- For v=2, lambda^2 = 1+f, hence f=lambda^2-1. -/
theorem f_from_lambda
    (f lambda : ℝ)
    (hrel : lambda^2 = 1 + f) :
    f = lambda^2 - 1 := by
  nlinarith

/-- In the worked example, B abundance strictly decreases with lambda
throughout the physically relevant interval lambda >= 1. -/
theorem hollowB_strictly_decreases
    (lambda1 lambda2 : ℝ)
    (h1 : 1 ≤ lambda1)
    (hlt : lambda1 < lambda2) :
    hollowB lambda2 < hollowB lambda1 := by
  have h2 : 1 < lambda2 := lt_of_le_of_lt h1 hlt
  have hp1 : 0 < lambda1 := lt_of_lt_of_le zero_lt_one h1
  have hp2 : 0 < lambda2 := lt_trans zero_lt_one h2
  have hd1 : 0 < 1 + lambda1 := by linarith
  have hd2 : 0 < 1 + lambda2 := by linarith
  have hpoly :
      0 <
        2*lambda1^2*lambda2^2
        + 2*lambda1^2*lambda2
        + 2*lambda1*lambda2^2
        + 3*lambda1*lambda2
        - 2*lambda1 - 2*lambda2 - 2 := by
    nlinarith [sq_nonneg (lambda1-1), sq_nonneg (lambda2-1),
      mul_nonneg (sub_nonneg.mpr h1) (sub_nonneg.mpr (le_of_lt h2))]
  unfold hollowB
  have hden :
      0 < lambda1 * lambda2 * (1 + lambda1) * (1 + lambda2) := by positivity
  have hfactor :
      ((2 - 1/lambda2) * (2-lambda2^2) / (1+lambda2))
        - ((2 - 1/lambda1) * (2-lambda1^2) / (1+lambda1))
      =
      (lambda1-lambda2) *
        (2*lambda1^2*lambda2^2
        + 2*lambda1^2*lambda2
        + 2*lambda1*lambda2^2
        + 3*lambda1*lambda2
        - 2*lambda1 - 2*lambda2 - 2)
      / (lambda1*lambda2*(1+lambda1)*(1+lambda2)) := by
    field_simp [ne_of_gt hp1, ne_of_gt hp2, ne_of_gt hd1, ne_of_gt hd2]
    ring
  have hnum : (lambda1-lambda2) *
        (2*lambda1^2*lambda2^2
        + 2*lambda1^2*lambda2
        + 2*lambda1*lambda2^2
        + 3*lambda1*lambda2
        - 2*lambda1 - 2*lambda2 - 2) < 0 := by
    exact mul_neg_of_neg_of_pos (sub_neg.mpr hlt) hpoly
  have hdiff :
      ((2 - 1/lambda2) * (2-lambda2^2) / (1+lambda2))
        - ((2 - 1/lambda1) * (2-lambda1^2) / (1+lambda1)) < 0 := by
    rw [hfactor]
    exact div_neg_of_neg_of_pos hnum hden
  linarith

#print axioms extraction_margin_eq
#print axioms extraction_viable_iff
#print axioms extraction_margin_zero_at_budget
#print axioms single_channel_extraction_threshold
#print axioms hollowing_threshold_iff_cubic
#print axioms f_from_lambda
#print axioms hollowB_strictly_decreases

end FunctionalThresholds
