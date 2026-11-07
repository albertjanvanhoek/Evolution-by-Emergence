import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Data.Fin.VecNotation
import Mathlib.Tactic

/-!
# Covariance transfer under coarse-graining

The bridge in `LGT/Bridge/ScaleTransfer.lean` (Douglas and Rajasekaran) assumes
`|Cov_fine| ≤ |Cov_blocked|`. In general, for coarse variables `B`,

  Cov(f, g) = Cov(E[f|B], E[g|B]) + E[Cov(f, g | B)].

The bridge keeps the first term and drops the second.

* `blocked_bound_fails`: a two-point counterexample. With an uninformative
  coarse variable, the blocked covariance is 0 while the fine covariance is 1.
* `corrected_transfer`: the bridge with the conditional term kept. Fine decay
  follows from coarse decay (rate divided by the blocking scale) **and**
  decay of the conditional term.
* `corrected_transfer_min`: the same, as a single rate: the minimum of the two.

Nothing here is specific to Yang–Mills. The physics enters through the
hypotheses.
-/

namespace YMGap

open Real

section Counterexample

/-- Uniform expectation on a two-point space. -/
noncomputable def E2 (f : Fin 2 → ℝ) : ℝ := (f 0 + f 1) / 2

/-- Covariance under the uniform measure on a two-point space. -/
noncomputable def cov2 (f g : Fin 2 → ℝ) : ℝ := E2 (fun i => f i * g i) - E2 f * E2 g

/-- A fair ±1 variable. -/
noncomputable def spin : Fin 2 → ℝ := ![1, -1]

/-- Conditional expectation given an uninformative coarse variable: the constant `E2 f`. -/
noncomputable def trivialBlock (f : Fin 2 → ℝ) : Fin 2 → ℝ := fun _ => E2 f

theorem cov2_const (c d : ℝ) : cov2 (fun _ => c) (fun _ => d) = 0 := by
  simp only [cov2, E2]
  ring

theorem fine_cov_spin : cov2 spin spin = 1 := by
  norm_num [cov2, E2, spin]

theorem blocked_cov_spin : cov2 (trivialBlock spin) (trivialBlock spin) = 0 :=
  cov2_const _ _

/-- **The bridge assumption fails in general.** -/
theorem blocked_bound_fails :
    ¬ (|cov2 spin spin| ≤ |cov2 (trivialBlock spin) (trivialBlock spin)|) := by
  rw [fine_cov_spin, blocked_cov_spin]
  norm_num

end Counterexample

section Transfer

variable {I J : Type*}

/-- **Corrected bridge.** If coarse-graining compresses distances by the
factor `s` (up to an overhead `o`), the fine covariance is bounded by the
blocked covariance plus a conditional term, the blocked covariance decays at
rate `m₁` on the coarse lattice, and the conditional term decays at rate `m₂`
on the fine lattice, then the fine covariance is bounded by the sum of a term
decaying at rate `m₁ / s` and one decaying at rate `m₂`. -/
theorem corrected_transfer (block : I → J) (dF : I → I → ℝ) (dC : J → J → ℝ) (s o : ℝ)
    (hcomp : ∀ p q, dF p q / s ≤ dC (block p) (block q) + o)
    (covF covB covC : I → I → ℝ)
    (hsplit : ∀ p q, |covF p q| ≤ |covB p q| + |covC p q|)
    (C₁ C₂ m₁ m₂ : ℝ) (hC₁ : 0 ≤ C₁) (hm₁ : 0 ≤ m₁)
    (hB : ∀ p q, |covB p q| ≤ C₁ * exp (-m₁ * dC (block p) (block q)))
    (hC : ∀ p q, |covC p q| ≤ C₂ * exp (-m₂ * dF p q)) :
    ∀ p q, |covF p q| ≤
      C₁ * exp (m₁ * o) * exp (-(m₁ / s) * dF p q) + C₂ * exp (-m₂ * dF p q) := by
  intro p q
  have h1 : -m₁ * dC (block p) (block q) ≤ m₁ * o + -(m₁ / s) * dF p q := by
    have h' := mul_le_mul_of_nonneg_left (hcomp p q) hm₁
    linear_combination h'
  have h2 : exp (-m₁ * dC (block p) (block q)) ≤
      exp (m₁ * o) * exp (-(m₁ / s) * dF p q) := by
    rw [← Real.exp_add]
    exact Real.exp_le_exp.mpr h1
  calc |covF p q| ≤ |covB p q| + |covC p q| := hsplit p q
    _ ≤ C₁ * exp (-m₁ * dC (block p) (block q)) + C₂ * exp (-m₂ * dF p q) :=
        add_le_add (hB p q) (hC p q)
    _ ≤ C₁ * (exp (m₁ * o) * exp (-(m₁ / s) * dF p q)) + C₂ * exp (-m₂ * dF p q) :=
        add_le_add (mul_le_mul_of_nonneg_left h2 hC₁) le_rfl
    _ = C₁ * exp (m₁ * o) * exp (-(m₁ / s) * dF p q) + C₂ * exp (-m₂ * dF p q) := by
        ring

theorem exp_le_exp_min_left (a b d : ℝ) (hd : 0 ≤ d) :
    exp (-a * d) ≤ exp (-(min a b) * d) := by
  apply Real.exp_le_exp.mpr
  rw [neg_mul, neg_mul, neg_le_neg_iff]
  exact mul_le_mul_of_nonneg_right (min_le_left a b) hd

theorem exp_le_exp_min_right (a b d : ℝ) (hd : 0 ≤ d) :
    exp (-b * d) ≤ exp (-(min a b) * d) := by
  apply Real.exp_le_exp.mpr
  rw [neg_mul, neg_mul, neg_le_neg_iff]
  exact mul_le_mul_of_nonneg_right (min_le_right a b) hd

/-- **Corrected bridge, single rate.** The fine decay rate is the minimum of
the coarse rate divided by the blocking scale and the conditional rate. -/
theorem corrected_transfer_min (block : I → J) (dF : I → I → ℝ) (dC : J → J → ℝ) (s o : ℝ)
    (hcomp : ∀ p q, dF p q / s ≤ dC (block p) (block q) + o)
    (hd : ∀ p q, 0 ≤ dF p q)
    (covF covB covC : I → I → ℝ)
    (hsplit : ∀ p q, |covF p q| ≤ |covB p q| + |covC p q|)
    (C₁ C₂ m₁ m₂ : ℝ) (hC₁ : 0 ≤ C₁) (hC₂ : 0 ≤ C₂) (hm₁ : 0 ≤ m₁)
    (hB : ∀ p q, |covB p q| ≤ C₁ * exp (-m₁ * dC (block p) (block q)))
    (hC : ∀ p q, |covC p q| ≤ C₂ * exp (-m₂ * dF p q)) :
    ∀ p q, |covF p q| ≤
      (C₁ * exp (m₁ * o) + C₂) * exp (-(min (m₁ / s) m₂) * dF p q) := by
  intro p q
  have h := corrected_transfer block dF dC s o hcomp covF covB covC hsplit
    C₁ C₂ m₁ m₂ hC₁ hm₁ hB hC p q
  have hK : 0 ≤ C₁ * exp (m₁ * o) := mul_nonneg hC₁ (Real.exp_pos _).le
  calc |covF p q|
      ≤ C₁ * exp (m₁ * o) * exp (-(m₁ / s) * dF p q) + C₂ * exp (-m₂ * dF p q) := h
    _ ≤ C₁ * exp (m₁ * o) * exp (-(min (m₁ / s) m₂) * dF p q)
          + C₂ * exp (-(min (m₁ / s) m₂) * dF p q) :=
        add_le_add
          (mul_le_mul_of_nonneg_left (exp_le_exp_min_left _ _ _ (hd p q)) hK)
          (mul_le_mul_of_nonneg_left (exp_le_exp_min_right _ _ _ (hd p q)) hC₂)
    _ = (C₁ * exp (m₁ * o) + C₂) * exp (-(min (m₁ / s) m₂) * dF p q) := by ring

end Transfer

end YMGap
