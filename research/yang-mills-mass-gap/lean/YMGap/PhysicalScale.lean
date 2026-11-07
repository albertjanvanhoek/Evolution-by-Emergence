import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Tactic

/-!
# Reaching strong coupling in time: the physical-scale condition

Take a lattice with spacing `a`. Coarse-grain by a total factor `s` (for
example `s = 2^k` after `k` steps). Suppose the coarse model decays at rate at
least `m⋆` per coarse lattice unit. Then the fine model decays at rate `m⋆ / s`
per fine lattice unit, which is `m⋆ / (a s)` in physical units.

A *sufficient* condition for this rate to stay bounded below as `a → 0` is that
the coarse length `a s` stays below a fixed physical length `ℓ`. It is not
necessary: a coarse rate that grows with `a s` could also do it.

* `physical_rate_lower_bound`: if `a s ≤ ℓ` and the coarse rate is at least
  `m⋆`, the physical rate is at least `m⋆ / ℓ`, independent of `a`;
* `physical_decay`: the same, as a bound on decay in physical distance `D`;
* `combined_physical_rate`, `combined_physical_rate_pos`, `physical_decay_combined`:
  with the residual (conditional) term of `CovarianceTransfer` included, its
  rate `m₂` per fine lattice unit must also satisfy `m₂ ≥ a μ_R`. The physical
  rate is then at least `min (m⋆ / ℓ) μ_R`, which is positive when both are;
* `blockScale_residual_suffices`: residual decay on the *block* scale,
  `m₂ ≥ c / s`, already gives `m₂ ≥ a (c / ℓ)`. The conditional correlations
  only need to die out over one block, not over one lattice spacing.

`ℓ` is a fixed physical length chosen in advance, not derived from the gap, so
the condition is not circular. These are decay rates of correlations. They are
not, by themselves, the spectral gap of the physical Hamiltonian: that needs a
rich enough family of observables and a reconstruction argument. Uniformity of
the prefactors in volume and cutoff is also outside these statements.
-/

namespace YMGap

open Real

/-- **Physical rate bound.** With `a s ≤ ℓ` and coarse rate `m ≥ m⋆ ≥ 0`, the
physical rate `m / (a s)` is at least `m⋆ / ℓ`. -/
theorem physical_rate_lower_bound (a s ℓ m mstar : ℝ) (ha : 0 < a) (hs : 0 < s)
    (hscale : a * s ≤ ℓ) (hm : mstar ≤ m) (hmstar : 0 ≤ mstar) :
    mstar / ℓ ≤ m / (a * s) := by
  have has : 0 < a * s := mul_pos ha hs
  have hℓ : 0 < ℓ := lt_of_lt_of_le has hscale
  have hℓ0 : ℓ ≠ 0 := ne_of_gt hℓ
  rw [le_div_iff₀ has]
  have h1 : mstar / ℓ * (a * s) ≤ mstar / ℓ * ℓ :=
    mul_le_mul_of_nonneg_left hscale (div_nonneg hmstar hℓ.le)
  have h2 : mstar / ℓ * ℓ = mstar := by field_simp
  linarith

/-- **Physical decay.** Decay at rate `m / s` per fine lattice unit, over a
physical distance `D` (that is, `D / a` lattice units), is at least as fast as
decay at rate `m⋆ / ℓ` per unit of physical distance. -/
theorem physical_decay (a s ℓ m mstar D : ℝ) (ha : 0 < a) (hs : 0 < s)
    (hscale : a * s ≤ ℓ) (hm : mstar ≤ m) (hmstar : 0 ≤ mstar) (hD : 0 ≤ D) :
    exp (-(m / s) * (D / a)) ≤ exp (-(mstar / ℓ) * D) := by
  have key := physical_rate_lower_bound a s ℓ m mstar ha hs hscale hm hmstar
  have e : m / s * (D / a) = m / (a * s) * D := by ring
  apply Real.exp_le_exp.mpr
  rw [neg_mul, neg_mul, neg_le_neg_iff, e]
  exact mul_le_mul_of_nonneg_right key hD

/-- **Combined rate, both terms.** The fine rate `min (m₁ / s) m₂` (from
`corrected_transfer_min`) is at least `a` times `min (m⋆ / ℓ) μ_R`, so its
physical value is at least `min (m⋆ / ℓ) μ_R`. -/
theorem combined_physical_rate (a s ℓ m₁ m₂ mstar μR : ℝ) (ha : 0 < a) (hs : 0 < s)
    (hscale : a * s ≤ ℓ) (hm₁ : mstar ≤ m₁) (hmstar : 0 ≤ mstar)
    (hm₂ : a * μR ≤ m₂) :
    a * min (mstar / ℓ) μR ≤ min (m₁ / s) m₂ := by
  have key := physical_rate_lower_bound a s ℓ m₁ mstar ha hs hscale hm₁ hmstar
  have ha0 : a ≠ 0 := ne_of_gt ha
  have hs0 : s ≠ 0 := ne_of_gt hs
  apply le_min
  · calc a * min (mstar / ℓ) μR ≤ a * (mstar / ℓ) :=
          mul_le_mul_of_nonneg_left (min_le_left _ _) ha.le
      _ ≤ a * (m₁ / (a * s)) := mul_le_mul_of_nonneg_left key ha.le
      _ = m₁ / s := by field_simp
  · calc a * min (mstar / ℓ) μR ≤ a * μR :=
          mul_le_mul_of_nonneg_left (min_le_right _ _) ha.le
      _ ≤ m₂ := hm₂

/-- **The combined physical rate is strictly positive** when `m⋆ > 0`,
`μ_R > 0` and `ℓ > 0`. -/
theorem combined_physical_rate_pos (ℓ mstar μR : ℝ) (hℓ : 0 < ℓ) (hmstar : 0 < mstar)
    (hμR : 0 < μR) : 0 < min (mstar / ℓ) μR :=
  lt_min (div_pos hmstar hℓ) hμR

/-- **Combined physical decay.** A correlation bounded by decay at the fine rate
`min (m₁ / s) m₂` over `D / a` lattice units is bounded by decay at the physical
rate `min (m⋆ / ℓ) μ_R` over physical distance `D`. -/
theorem physical_decay_combined (a s ℓ m₁ m₂ mstar μR D K c : ℝ) (ha : 0 < a) (hs : 0 < s)
    (hscale : a * s ≤ ℓ) (hm₁ : mstar ≤ m₁) (hmstar : 0 ≤ mstar)
    (hm₂ : a * μR ≤ m₂) (hD : 0 ≤ D) (hK : 0 ≤ K)
    (hc : |c| ≤ K * exp (-(min (m₁ / s) m₂) * (D / a))) :
    |c| ≤ K * exp (-(min (mstar / ℓ) μR) * D) := by
  have h := combined_physical_rate a s ℓ m₁ m₂ mstar μR ha hs hscale hm₁ hmstar hm₂
  have ha0 : a ≠ 0 := ne_of_gt ha
  have e : exp (-(min (m₁ / s) m₂) * (D / a)) ≤ exp (-(min (mstar / ℓ) μR) * D) := by
    apply Real.exp_le_exp.mpr
    rw [neg_mul, neg_mul, neg_le_neg_iff]
    calc min (mstar / ℓ) μR * D = (a * min (mstar / ℓ) μR) * (D / a) := by
          field_simp
      _ ≤ min (m₁ / s) m₂ * (D / a) :=
          mul_le_mul_of_nonneg_right h (div_nonneg hD ha.le)
  exact hc.trans (mul_le_mul_of_nonneg_left e hK)

/-- **Residual decay on the block scale suffices.** If the conditional term
decays at rate at least `c / s` per fine lattice unit (that is, at rate `c`
per block), and `a s ≤ ℓ`, then `m₂ ≥ a (c / ℓ)`: the hypothesis of
`combined_physical_rate` holds with `μ_R = c / ℓ`. -/
theorem blockScale_residual_suffices (a s ℓ c m₂ : ℝ) (ha : 0 < a) (hs : 0 < s)
    (hscale : a * s ≤ ℓ) (hc : 0 ≤ c) (hm₂ : c / s ≤ m₂) :
    a * (c / ℓ) ≤ m₂ := by
  have key := physical_rate_lower_bound a s ℓ c c ha hs hscale le_rfl hc
  have ha0 : a ≠ 0 := ne_of_gt ha
  have hs0 : s ≠ 0 := ne_of_gt hs
  calc a * (c / ℓ) ≤ a * (c / (a * s)) := mul_le_mul_of_nonneg_left key ha.le
    _ = c / s := by field_simp
    _ ≤ m₂ := hm₂

end YMGap
