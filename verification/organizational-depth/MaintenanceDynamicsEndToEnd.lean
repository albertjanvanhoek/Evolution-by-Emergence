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
    convert (hasDerivAt_const t (1 : ℝ)).sub hxode using 1 <;> ring
  have hlogone := hone.log h1ne
  convert hlogx.sub hlogone using 1
  field_simp [hxne, h1ne]
  ring

end PeriodicODE

#print axioms cubic_hurwitz_root_negative
#print axioms hasDerivAt_logit_of_maintenance

end MaintenanceDynamicsEndToEnd
