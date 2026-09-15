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

section JacobianFromVectorField

/-- Debt-aware maintenance flow for the behavioral coordinate. -/
def debtXFlow (α c a δ γ x K h : ℝ) : ℝ :=
  x * (1 - x) * (α * (1 - h) - c + γ * (δ * K - a * x))

/-- Capital-stock coordinate. -/
def debtKFlow (a δ x K : ℝ) : ℝ := a * x - δ * K

/-- Visible-health coordinate. -/
def debtHFlow (ε K h : ℝ) : ℝ := ε * (K - h)

/-- The x-partial of the nonlinear behavioral flow at an equilibrium satisfying
both the visible-balance and maintenance-debt balance equations. -/
theorem debtXFlow_dx_at_equilibrium
    {α c a δ γ x₀ K₀ h₀ : ℝ}
    (hbase : α * (1 - h₀) - c = 0)
    (hdebt : δ * K₀ - a * x₀ = 0) :
    HasDerivAt (fun x => debtXFlow α c a δ γ x K₀ h₀)
      (-a * γ * (x₀ * (1 - x₀))) x₀ := by
  have hg0 := (hasDerivAt_id x₀).mul
    ((hasDerivAt_const x₀ (1 : ℝ)).sub (hasDerivAt_id x₀))
  have hg : HasDerivAt (fun x : ℝ => x * (1 - x)) (1 - 2*x₀) x₀ := by
    exact hg0.congr_deriv (by ring)
  have hlin0 := (hasDerivAt_const x₀ (δ*K₀)).sub
    (HasDerivAt.const_mul a (hasDerivAt_id x₀))
  have hlin : HasDerivAt (fun x : ℝ => δ*K₀ - a*x) (-a) x₀ := by
    exact hlin0.congr_deriv (by ring)
  have hq0 := (hasDerivAt_const x₀ (α*(1-h₀)-c)).add
    (HasDerivAt.const_mul γ hlin)
  have hq : HasDerivAt
      (fun x : ℝ => α*(1-h₀)-c + γ*(δ*K₀-a*x)) (-γ*a) x₀ := by
    exact hq0.congr_deriv (by ring)
  have hqeq : α*(1-h₀)-c + γ*(δ*K₀-a*x₀) = 0 := by
    rw [hbase, hdebt]
    ring
  unfold debtXFlow
  refine (hg.mul hq).congr_deriv ?_
  rw [hqeq]
  ring

/-- The K-partial of the nonlinear behavioral flow at equilibrium. -/
theorem debtXFlow_dK_at_equilibrium
    {α c a δ γ x₀ K₀ h₀ : ℝ}
    (hbase : α * (1 - h₀) - c = 0)
    (hdebt : δ * K₀ - a * x₀ = 0) :
    HasDerivAt (fun K => debtXFlow α c a δ γ x₀ K h₀)
      (δ * γ * (x₀ * (1 - x₀))) K₀ := by
  have hlin : HasDerivAt (fun K : ℝ => δ*K - a*x₀) δ K₀ := by
    have h := (HasDerivAt.const_mul δ (hasDerivAt_id K₀)).sub
      (hasDerivAt_const K₀ (a*x₀))
    exact h.congr_deriv (by ring)
  have hq0 := (hasDerivAt_const K₀ (α*(1-h₀)-c)).add
    (HasDerivAt.const_mul γ hlin)
  have hq : HasDerivAt
      (fun K : ℝ => α*(1-h₀)-c + γ*(δ*K-a*x₀)) (γ*δ) K₀ := by
    exact hq0.congr_deriv (by ring)
  have hb := HasDerivAt.const_mul (x₀*(1-x₀)) hq
  unfold debtXFlow
  exact hb.congr_deriv (by ring)

/-- The h-partial of the nonlinear behavioral flow at equilibrium. -/
theorem debtXFlow_dh_at_equilibrium
    {α c a δ γ x₀ K₀ h₀ : ℝ}
    (hbase : α * (1 - h₀) - c = 0)
    (hdebt : δ * K₀ - a * x₀ = 0) :
    HasDerivAt (fun h => debtXFlow α c a δ γ x₀ K₀ h)
      (-α * (x₀ * (1 - x₀))) h₀ := by
  have hone := (hasDerivAt_const h₀ (1 : ℝ)).sub (hasDerivAt_id h₀)
  have hbasefun0 := HasDerivAt.const_mul α hone
  have hbasefun : HasDerivAt (fun h : ℝ => α*(1-h)-c) (-α) h₀ := by
    have h := hbasefun0.sub (hasDerivAt_const h₀ c)
    exact h.congr_deriv (by ring)
  have hq := hbasefun.add
    (hasDerivAt_const h₀ (γ*(δ*K₀-a*x₀)))
  have hb := HasDerivAt.const_mul (x₀*(1-x₀)) hq
  unfold debtXFlow
  exact hb.congr_deriv (by ring)

/-- Remaining two nontrivial linear-coordinate derivatives. -/
theorem debtKFlow_partials {a δ x₀ K₀ : ℝ} :
    HasDerivAt (fun x => debtKFlow a δ x K₀) a x₀ ∧
    HasDerivAt (fun K => debtKFlow a δ x₀ K) (-δ) K₀ := by
  constructor
  · unfold debtKFlow
    exact ((HasDerivAt.const_mul a (hasDerivAt_id x₀)).sub
      (hasDerivAt_const x₀ (δ*K₀))).congr_deriv (by ring)
  · unfold debtKFlow
    exact ((hasDerivAt_const K₀ (a*x₀)).sub
      (HasDerivAt.const_mul δ (hasDerivAt_id K₀))).congr_deriv (by ring)

/-- Visible-health coordinate derivatives. -/
theorem debtHFlow_partials {ε K₀ h₀ : ℝ} :
    HasDerivAt (fun K => debtHFlow ε K h₀) ε K₀ ∧
    HasDerivAt (fun h => debtHFlow ε K₀ h) (-ε) h₀ := by
  constructor
  · unfold debtHFlow
    have h := HasDerivAt.const_mul ε
      ((hasDerivAt_id K₀).sub (hasDerivAt_const K₀ h₀))
    exact h.congr_deriv (by ring)
  · unfold debtHFlow
    have h := HasDerivAt.const_mul ε
      ((hasDerivAt_const h₀ K₀).sub (hasDerivAt_id h₀))
    exact h.congr_deriv (by ring)

end JacobianFromVectorField

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

/-- Closed-form critical-gain theorem all the way to the characteristic roots
of the explicit debt-aware Jacobian. -/
theorem critical_gain_implies_jacobian_hurwitz
    {δ ε a α b γ : ℝ}
    (hδ : 0 < δ) (hε : 0 < ε) (ha : 0 < a) (hα : 0 < α)
    (hb : 0 < b) (hγ0 : 0 ≤ γ)
    (hγcrit : MaintenanceDynamics.criticalGamma δ ε a α b < γ)
    (z : ℂ)
    (hz : Matrix.det (debtCharMatrix z δ ε a α b γ) = 0) :
    z.re < 0 := by
  have hstable := MaintenanceDynamics.stable_above_criticalGamma
    (le_of_lt hε) ha (le_of_lt hα) hb hγcrit
  exact debt_jacobian_hurwitz hδ hε ha hα hb hγ0 hstable z hz

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

  have hxI : IntervalIntegrable x volume 0 T := hxcont.intervalIntegrable
  have hKI : IntervalIntegrable K volume 0 T := hKcont.intervalIntegrable
  have hhI : IntervalIntegrable h volume 0 T := hhcont.intervalIntegrable
  have hOneI : IntervalIntegrable (fun _ : ℝ => (1 : ℝ)) volume 0 T :=
    intervalIntegrable_const

  have hILog' := hILog
  rw [intervalIntegral.integral_sub
        ((hOneI.sub hhI).const_mul α) intervalIntegrable_const,
      intervalIntegral.integral_const_mul,
      intervalIntegral.integral_sub hOneI hhI,
      intervalIntegral.integral_const,
      intervalIntegral.integral_const] at hILog'
  simp only [sub_zero, smul_eq_mul, mul_one] at hILog'

  have hIhBal' := hIhBal
  rw [intervalIntegral.integral_const_mul,
      intervalIntegral.integral_sub hKI hhI] at hIhBal'

  have hIKBal' := hIKBal
  rw [intervalIntegral.integral_sub (hxI.const_mul a) (hKI.const_mul δ),
      intervalIntegral.integral_const_mul,
      intervalIntegral.integral_const_mul] at hIKBal'

  have hTne : T ≠ 0 := ne_of_gt hT
  have hH : (∫ t in 0..T, h t) = T * (1 - c / α) := by
    field_simp [hα]
    nlinarith [hILog']
  have hKH : (∫ t in 0..T, K t) = (∫ t in 0..T, h t) := by
    have hz : (∫ t in 0..T, K t) - (∫ t in 0..T, h t) = 0 :=
      (mul_eq_zero.mp hIhBal').resolve_left hε
    exact sub_eq_zero.mp hz
  have hXK : (∫ t in 0..T, x t) = (δ / a) * (∫ t in 0..T, K t) := by
    rw [div_mul_eq_mul_div]
    apply (eq_div_iff ha).2
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

#print axioms debtXFlow_dx_at_equilibrium
#print axioms debtXFlow_dK_at_equilibrium
#print axioms debtXFlow_dh_at_equilibrium
#print axioms debtKFlow_partials
#print axioms debtHFlow_partials
#print axioms cubic_hurwitz_root_negative
#print axioms debtCharMatrix_det
#print axioms debt_jacobian_hurwitz
#print axioms critical_gain_implies_jacobian_hurwitz
#print axioms hasDerivAt_logit_of_maintenance
#print axioms periodic_maintenance_cycle_averages

end MaintenanceDynamicsEndToEnd
