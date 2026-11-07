import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Tactic

/-!
# Reaching strong coupling in time: the physical-scale condition

Take a lattice with spacing `a`. Coarse-grain by a total factor `s` (for
example `s = 2^k` after `k` steps). Suppose the coarse model decays at rate at
least `m⋆` per coarse lattice unit. Then the fine model decays at rate `m⋆ / s`
per fine lattice unit, which is `m⋆ / (a s)` in physical units.

The physical mass stays bounded below as `a → 0` exactly when the coarse length
`a s` stays below a fixed physical length `ℓ`:

* `physical_rate_lower_bound`: if `a s ≤ ℓ` and the coarse rate is at least
  `m⋆`, the physical rate is at least `m⋆ / ℓ`, independent of `a`;
* `physical_decay`: the same, as a bound on decay in physical distance `D`.

`ℓ` is a fixed physical length chosen in advance, not derived from the gap, so
the condition is not circular. The open problem is to show that, for every
small `a`, some coarse-graining with `a s ≤ ℓ` reaches a model that decays at
rate at least `m⋆`.
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

end YMGap
