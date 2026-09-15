import Mathlib

namespace MaintenanceDynamics

/-!
# Machine-checked algebraic core for maintenance dynamics

This file verifies the algebraic implications used in the maintenance-oscillator
analysis. It intentionally does not formalize the ODE theory that produces the
periodic-orbit balance identities, nor the Routh--Hurwitz theorem itself.

The two targets are:

1. Periodic balance identities imply the exact cycle averages
   hbar = 1 - c/alpha, Kbar = hbar, xbar = (delta/a) hbar and zero mean maintenance debt.
2. The debt-aware cubic Routh--Hurwitz inequality
   (delta + epsilon + a b gamma)(delta + a b gamma) > a alpha b
   is exactly the claimed stability condition after setting y = delta + a b gamma,
   and its left-hand side is monotone in gamma under nonnegative parameters.
-/

section CycleAverages

variable {α c a δ xbar Kbar hbar : ℝ}

/-- Algebraic core of the periodic-orbit average theorem.

The assumptions hbeh, hK, and hx are exactly the three balance identities
obtained by integrating one period of

  d/dt log(x/(1-x)) = alpha(1-h)-c,
  hdot = epsilon(K-h),
  Kdot = a x - delta K.

The analytic step from a periodic ODE solution to these identities is deliberately
outside this theorem. -/
theorem cycle_average_balances
    (hα : α ≠ 0) (ha : a ≠ 0)
    (hbeh : α * (1 - hbar) - c = 0)
    (hK : Kbar = hbar)
    (hx : a * xbar = δ * Kbar) :
    hbar = 1 - c / α ∧
    Kbar = 1 - c / α ∧
    xbar = (δ / a) * (1 - c / α) := by
  have hh : hbar = 1 - c / α := by
    field_simp [hα]
    nlinarith [hbeh]
  constructor
  · exact hh
  constructor
  · calc
      Kbar = hbar := hK
      _ = 1 - c / α := hh
  · rw [hK, hh] at hx
    rw [div_mul_eq_mul_div]
    apply (eq_div_iff ha).2
    simpa [mul_comm] using hx

/-- The mean maintenance debt delta*Kbar - a*xbar vanishes whenever the
stock-balance identity a*xbar = delta*Kbar holds. -/
theorem mean_maintenance_debt_zero
    (hx : a * xbar = δ * Kbar) :
    δ * Kbar - a * xbar = 0 := by
  linarith

end CycleAverages

section DebtAwareStability

variable {δ ε a α b γ γ₁ γ₂ : ℝ}

/-- Pure algebra: introducing y = delta + a*b*gamma turns the debt-aware
Routh--Hurwitz inequality into y(y+epsilon) > a*alpha*b. -/
theorem debt_stability_rewrite :
    (δ + ε + a * b * γ) * (δ + a * b * γ) > a * α * b ↔
    (δ + a * b * γ) * ((δ + a * b * γ) + ε) > a * α * b := by
  ring_nf

/-- Under nonnegative parameters, the Routh--Hurwitz left-hand side is
monotone nondecreasing in the debt-response gain gamma. -/
theorem debt_stability_lhs_monotone
    (hδ : 0 ≤ δ) (hε : 0 ≤ ε) (ha : 0 ≤ a) (hb : 0 ≤ b)
    (hγ₁ : 0 ≤ γ₁) (hγ : γ₁ ≤ γ₂) :
    (δ + ε + a * b * γ₁) * (δ + a * b * γ₁)
      ≤ (δ + ε + a * b * γ₂) * (δ + a * b * γ₂) := by
  have hab : 0 ≤ a * b := mul_nonneg ha hb
  have hγ₂ : 0 ≤ γ₂ := hγ₁.trans hγ
  have h1 : δ + a * b * γ₁ ≤ δ + a * b * γ₂ := by
    exact add_le_add_left (mul_le_mul_of_nonneg_left hγ hab) δ
  have h2 : δ + ε + a * b * γ₁ ≤ δ + ε + a * b * γ₂ := by
    exact add_le_add_left (mul_le_mul_of_nonneg_left hγ hab) (δ + ε)
  have hn1 : 0 ≤ δ + a * b * γ₁ := by positivity
  exact mul_le_mul h2 h1 hn1 (by positivity)

/-- Hence once the debt-aware Routh--Hurwitz inequality holds at some gain,
it continues to hold for every larger nonnegative gain. -/
theorem debt_stability_upward_closed
    (hδ : 0 ≤ δ) (hε : 0 ≤ ε) (ha : 0 ≤ a) (hb : 0 ≤ b)
    (hγ₁ : 0 ≤ γ₁) (hγ : γ₁ ≤ γ₂)
    (hstable : a * α * b <
      (δ + ε + a * b * γ₁) * (δ + a * b * γ₁)) :
    a * α * b <
      (δ + ε + a * b * γ₂) * (δ + a * b * γ₂) := by
  exact lt_of_lt_of_le hstable
    (debt_stability_lhs_monotone hδ hε ha hb hγ₁ hγ)

/-- Expanded characteristic polynomial coefficient identity for the debt-aware
Jacobian. This checks the manuscript-facing coefficient formula algebraically. -/
theorem debt_characteristic_polynomial_identity (z : ℝ) :
    z^3
      + (δ + ε + a*b*γ) * z^2
      + (δ*ε + a*b*ε*γ) * z
      + a*α*b*ε
    =
    z^3
      + (δ + ε + a*b*γ) * z^2
      + ε * (δ + a*b*γ) * z
      + a*α*b*ε := by
  ring

end DebtAwareStability

#print axioms cycle_average_balances
#print axioms mean_maintenance_debt_zero
#print axioms debt_stability_rewrite
#print axioms debt_stability_lhs_monotone
#print axioms debt_stability_upward_closed
#print axioms debt_characteristic_polynomial_identity

end MaintenanceDynamics
