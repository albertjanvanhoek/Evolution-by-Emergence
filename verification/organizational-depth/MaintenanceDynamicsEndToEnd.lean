import Mathlib
import MaintenanceDynamics

namespace MaintenanceDynamicsEndToEnd

/-!
# End-to-end maintenance-dynamics formalization

This file closes two previously explicit seams:

1. the cubic Hurwitz step is proved directly over complex roots;
2. the periodic-average identities are derived from differentiable periodic
   trajectories and the maintenance ODE by the fundamental theorem of calculus.

No external Routh--Hurwitz theorem is assumed.
-/

section CubicHurwitz

/-- Direct cubic Hurwitz criterion. If A,B,C are positive and A*B > C,
then every complex root of z^3 + A z^2 + B z + C has strictly negative real part. -/
theorem cubic_hurwitz_root_negative
    {A B C : ℝ} (hA : 0 < A) (hB : 0 < B) (hC : 0 < C)
    (hAB : C < A * B) (z : ℂ)
    (hz : z^3 + (A : ℂ) * z^2 + (B : ℂ) * z + (C : ℂ) = 0) :
    z.re < 0 := by
  by_contra hnot
  have hx : 0 ≤ z.re := le_of_not_gt hnot
  have hre := congrArg Complex.re hz
  have him := congrArg Complex.im hz
  rw [← Complex.re_add_im z] at hre him
  norm_num [pow_two, pow_succ, Complex.mul_re, Complex.mul_im] at hre him
  by_cases hy : z.im = 0
  · rw [hy] at hre
    nlinarith
  · have hy2 : z.im ^ 2 = 3 * z.re ^ 2 + 2 * A * z.re + B := by
      apply (mul_left_cancel₀ hy)
      nlinarith [him]
    nlinarith [hre, hAB, sq_nonneg z.re, mul_nonneg (le_of_lt hA) hx,
      mul_nonneg (le_of_lt hB) hx]

/-- The explicit complex characteristic matrix lambda*I - J for the debt-aware
maintenance Jacobian at the interior equilibrium, with b = x*(1-x). -/
def debtCharMatrix (z : ℂ) (δ ε a α b γ : ℝ) : Matrix (Fin 3) (Fin 3) ℂ :=
  ![
    ![z + (a*b*γ : ℝ), -(δ*b*γ : ℝ), (α*b : ℝ)],
    ![-(a : ℝ), z + δ, 0],
    ![0, -(ε : ℝ), z + ε]
  ]

/-- Direct determinant calculation for the debt-aware Jacobian. -/
theorem debtCharMatrix_det
    (z : ℂ) (δ ε a α b γ : ℝ) :
    Matrix.det (debtCharMatrix z δ ε a α b γ)
      =
    z^3
      + ((δ + ε + a*b*γ : ℝ) : ℂ) * z^2
      + ((δ*ε + a*b*ε*γ : ℝ) : ℂ) * z
      + ((a*α*b*ε : ℝ) : ℂ) := by
  rw [Matrix.det_fin_three]
  simp [debtCharMatrix]
  ring

/-- End-to-end Hurwitz result for the actual debt-aware Jacobian characteristic
matrix. Under the exact stability inequality, every characteristic root has
strictly negative real part. -/
theorem debt_jacobian_hurwitz
    {δ ε a α b γ : ℝ}
    (hδ : 0 < δ) (hε : 0 < ε) (ha : 0 < a) (hα : 0 < α)
    (hb : 0 < b) (hγ : 0 ≤ γ)
    (hstable : a * α * b <
      (δ + ε + a*b*γ) * (δ + a*b*γ))
    (z : ℂ)
    (hz : Matrix.det (debtCharMatrix z δ ε a α b γ) = 0) :
    z.re < 0 := by
  have hA : 0 < δ + ε + a*b*γ := by positivity
  have hD : 0 < δ + a*b*γ := by positivity
  have hB : 0 < δ*ε + a*b*ε*γ := by
    rw [show δ*ε + a*b*ε*γ = ε * (δ + a*b*γ) by ring]
    positivity
  have hC : 0 < a*α*b*ε := by positivity
  have hAB0 : a*α*b*ε <
      (δ + ε + a*b*γ) * (δ*ε + a*b*ε*γ) := by
    have hm := mul_lt_mul_of_pos_right hstable hε
    rw [show δ*ε + a*b*ε*γ = ε * (δ + a*b*γ) by ring]
    nlinarith
  have hpoly :
      z^3
        + (((δ + ε + a*b*γ) : ℝ) : ℂ) * z^2
        + (((δ*ε + a*b*ε*γ) : ℝ) : ℂ) * z
        + (((a*α*b*ε) : ℝ) : ℂ) = 0 := by
    rw [← debtCharMatrix_det z δ ε a α b γ]
    exact hz
  exact cubic_hurwitz_root_negative hA hB hC hAB0 z hpoly

end CubicHurwitz

section PeriodicODE

open Set MeasureTheory intervalIntegral

/-- The replicator maintenance equation implies the claimed derivative of the
logit coordinate on the interior 0 < x < 1. -/
theorem hasDerivAt_logit_of_maintenance
    {x h : ℝ → ℝ} {t α c : ℝ}
    (hxpos : 0 < x t) (hxlt : x t < 1)
    (hxode : HasDerivAt x
      (x t * (1 - x t) * (α * (1 - h t) - c)) t) :
    HasDerivAt (fun s => Real.log (x s) - Real.log (1 - x s))
      (α * (1 - h t) - c) t := by
  have hxne : x t ≠ 0 := ne_of_gt hxpos
  have h1pos : 0 < 1 - x t := sub_pos.mpr hxlt
  have h1ne : 1 - x t ≠ 0 := ne_of_gt h1pos
  have hlogx := hxode.log hxne
  have hone : HasDerivAt (fun s => (1 : ℝ) - x s)
      (-(x t * (1 - x t) * (α * (1 - h t) - c))) t := by
    refine ((hasDerivAt_const t (1 : ℝ)).sub hxode).congr_deriv ?_
    ring
  have hlogone := hone.log h1ne
  refine (hlogx.sub hlogone).congr_deriv ?_
  field_simp [hxne, h1ne]
  ring

/-- End-to-end periodic-average theorem for the maintenance ODE.
Starting from differentiable periodic trajectories satisfying the ODEs, the
exact cycle averages are derived by the fundamental theorem of calculus. -/
theorem periodic_maintenance_cycle_averages
    {T α c a δ ε : ℝ} (hT : 0 < T) (hα : α ≠ 0) (ha : a ≠ 0) (hε : ε ≠ 0)
    (x K h : ℝ → ℝ)
    (hxint : ∀ t ∈ Set.uIcc 0 T, 0 < x t ∧ x t < 1)
    (hxode : ∀ t ∈ Set.uIcc 0 T, HasDerivAt x
      (x t * (1 - x t) * (α * (1 - h t) - c)) t)
    (hKode : ∀ t ∈ Set.uIcc 0 T, HasDerivAt K (a * x t - δ * K t) t)
    (hhode : ∀ t ∈ Set.uIcc 0 T, HasDerivAt h (ε * (K t - h t)) t)
    (hxp : x T = x 0) (hKp : K T = K 0) (hhp : h T = h 0) :
    (∫ t in 0..T, h t) / T = 1 - c / α ∧
    (∫ t in 0..T, K t) / T = 1 - c / α ∧
    (∫ t in 0..T, x t) / T = (δ / a) * (1 - c / α) := by
  have hhcont : ContinuousOn h (Set.uIcc 0 T) := HasDerivAt.continuousOn hhode
  have hKcont : ContinuousOn K (Set.uIcc 0 T) := HasDerivAt.continuousOn hKode
  have hxcont : ContinuousOn x (Set.uIcc 0 T) := HasDerivAt.continuousOn hxode

  have hlogderiv : ∀ t ∈ Set.uIcc 0 T,
      HasDerivAt (fun s => Real.log (x s) - Real.log (1 - x s))
        (α * (1 - h t) - c) t := by
    intro t ht
    exact hasDerivAt_logit_of_maintenance (hxint t ht).1 (hxint t ht).2 (hxode t ht)

  have hlogint : IntervalIntegrable (fun t => α * (1 - h t) - c) volume 0 T := by
    apply ContinuousOn.intervalIntegrable
    exact (((continuousOn_const.sub hhcont).const_mul α).sub continuousOn_const)

  have hftcLog := intervalIntegral.integral_eq_sub_of_hasDerivAt hlogderiv hlogint
  have hILog : (∫ t in 0..T, α * (1 - h t) - c) = 0 := by
    simpa [hxp] using hftcLog

  have hhInt : IntervalIntegrable (fun t => ε * (K t - h t)) volume 0 T := by
    apply ContinuousOn.intervalIntegrable
    exact (hKcont.sub hhcont).const_mul ε
  have hftch := intervalIntegral.integral_eq_sub_of_hasDerivAt hhode hhInt
  have hIhBal : (∫ t in 0..T, ε * (K t - h t)) = 0 := by
    simpa [hhp] using hftch

  have hKInt : IntervalIntegrable (fun t => a * x t - δ * K t) volume 0 T := by
    apply ContinuousOn.intervalIntegrable
    exact (hxcont.const_mul a).sub (hKcont.const_mul δ)
  have hftcK := intervalIntegral.integral_eq_sub_of_hasDerivAt hKode hKInt
  have hIKBal : (∫ t in 0..T, a * x t - δ * K t) = 0 := by
    simpa [hKp] using hftcK

  have hILog' := hILog
  have hIhBal' := hIhBal
  have hIKBal' := hIKBal
  simp only [intervalIntegral.integral_sub, intervalIntegral.integral_const_mul,
    intervalIntegral.integral_const, sub_zero, smul_eq_mul, mul_one] at hILog' hIhBal' hIKBal'

  have hTne : T ≠ 0 := ne_of_gt hT
  have hH : (∫ t in 0..T, h t) = T * (1 - c / α) := by
    field_simp [hα]
    nlinarith [hILog']
  have hKH : (∫ t in 0..T, K t) = (∫ t in 0..T, h t) := by
    apply sub_eq_zero.mp
    apply mul_left_cancel₀ hε
    nlinarith [hIhBal']
  have hXK : (∫ t in 0..T, x t) = (δ / a) * (∫ t in 0..T, K t) := by
    apply (eq_div_iff ha).2
    rw [mul_comm]
    nlinarith [hIKBal']

  constructor
  · rw [hH]
    field_simp [hTne]
  constructor
  · rw [hKH, hH]
    field_simp [hTne]
  · rw [hXK, hKH, hH]
    field_simp [hTne]

end PeriodicODE

#print axioms cubic_hurwitz_root_negative
#print axioms debtCharMatrix_det
#print axioms debt_jacobian_hurwitz
#print axioms hasDerivAt_logit_of_maintenance
#print axioms periodic_maintenance_cycle_averages

end MaintenanceDynamicsEndToEnd
