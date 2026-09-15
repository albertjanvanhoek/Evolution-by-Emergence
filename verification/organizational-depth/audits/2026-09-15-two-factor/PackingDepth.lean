/-
Copyright (c) 2026. Released under Apache 2.0.

# Machine-verified core of the two-factor bound on packing depth

Companion to `OrganizationalDepth.lean`.  It formalises the elementary
mathematical implications behind

  `D_δ ≤ min [ 1 + δ⁻¹ √(Σ_* N_* / 2) , P_δ(X) ]`

where `D_δ` is the packing depth of a family of retained states -- the largest
subfamily that is pairwise at operational distance at least `δ` -- and `P_δ(X)`
is the `δ`-packing number of the operational state space.

As in `OrganizationalDepth.lean`, this verifies **conditional implications
only**.  The per-block speed limit `2 * d k ^ 2 ≤ N k * S k` is a hypothesis
here; nothing in this file justifies it physically, and nothing here identifies
any metric with operational distinguishability.

Contents:

* `§1`  `gap_sum_le`: the Cauchy--Schwarz step over a finite family of blocks
  with disjoint budgets.
* `§2`  `packing_depth_thermo`: the thermodynamic factor,
  `D ≤ 1 + δ⁻¹ √(N_* S_* / 2)`, for a chronologically ordered `δ`-separated
  family with `D - 1` gaps.
* `§3`  `packing_depth_two_factor`: the two-factor statement, as a `min`.
* `§4`  `depth_le_of_budget_ceiling`: a uniform ceiling on the activity--entropy
  product uniformly bounds the achievable depth.
* `§5`  `packing_depth_thermo_witness` / `_sharp`: the hypotheses of §2 are
  satisfiable and the bound is attained with equality, so it is neither vacuous
  nor loose.

The separation hypothesis is imposed only on *consecutive* members of the
chronologically ordered subfamily, which is all the proof uses; pairwise
separation of the whole subfamily implies it.
-/

import Mathlib.Analysis.Real.Sqrt
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Algebra.Order.BigOperators.Ring.Finset

namespace OrgDepth

open Finset

/-! ## §1  The Cauchy--Schwarz step -/

/-- Over `m` blocks with non-negative activity and entropy budgets `N k`, `S k`
each obeying the speed limit `2 * d k ^ 2 ≤ N k * S k`, the total gap is bounded
by `√(N_* S_* / 2)` whenever the block budgets sum to at most `N_*` and `S_*`.

Disjointness of the blocks enters only through those two summation hypotheses. -/
theorem gap_sum_le
    (m : ℕ) (N S d : ℕ → ℝ) (Nstar Sstar : ℝ)
    (hN : ∀ k, 0 ≤ N k) (hS : ∀ k, 0 ≤ S k) (hd : ∀ k, 0 ≤ d k)
    (hsl : ∀ k, 2 * d k ^ 2 ≤ N k * S k)
    (hNsum : ∑ k ∈ range m, N k ≤ Nstar)
    (hSsum : ∑ k ∈ range m, S k ≤ Sstar) :
    ∑ k ∈ range m, d k ≤ Real.sqrt (Nstar * Sstar / 2) := by
  have h2 : (0:ℝ) < Real.sqrt 2 := Real.sqrt_pos.mpr (by norm_num)
  -- pointwise:  √2 * d k = √(2 * d k ^ 2) ≤ √(N k) * √(S k)
  have hpt : ∀ k, Real.sqrt 2 * d k ≤ Real.sqrt (N k) * Real.sqrt (S k) := by
    intro k
    have hrw : Real.sqrt 2 * d k = Real.sqrt (2 * d k ^ 2) := by
      rw [Real.sqrt_mul (by norm_num : (0:ℝ) ≤ 2), Real.sqrt_sq (hd k)]
    rw [hrw, ← Real.sqrt_mul (hN k)]
    exact Real.sqrt_le_sqrt (hsl k)
  -- sum, then Cauchy--Schwarz over the blocks
  have hsum : Real.sqrt 2 * ∑ k ∈ range m, d k
      ≤ Real.sqrt (∑ k ∈ range m, N k) * Real.sqrt (∑ k ∈ range m, S k) := by
    rw [Finset.mul_sum]
    exact (Finset.sum_le_sum (fun k _ => hpt k)).trans
      (Real.sum_sqrt_mul_sqrt_le (range m) (fun k => hN k) (fun k => hS k))
  -- relax to the global budgets
  have hNle : Real.sqrt (∑ k ∈ range m, N k) ≤ Real.sqrt Nstar :=
    Real.sqrt_le_sqrt hNsum
  have hSle : Real.sqrt (∑ k ∈ range m, S k) ≤ Real.sqrt Sstar :=
    Real.sqrt_le_sqrt hSsum
  have hNs : (0:ℝ) ≤ Nstar :=
    le_trans (Finset.sum_nonneg (fun k _ => hN k)) hNsum
  have hfin : Real.sqrt 2 * ∑ k ∈ range m, d k ≤ Real.sqrt (Nstar * Sstar) := by
    refine hsum.trans ?_
    rw [Real.sqrt_mul hNs]
    exact mul_le_mul hNle hSle (Real.sqrt_nonneg _) (Real.sqrt_nonneg _)
  -- divide by √2, and fold it back under the root
  have hdiv : Real.sqrt (Nstar * Sstar) / Real.sqrt 2
      = Real.sqrt (Nstar * Sstar / 2) := by
    rw [Real.sqrt_div' _ (by norm_num : (0:ℝ) ≤ 2)]
  rw [← hdiv, le_div_iff₀ h2, mul_comm]
  exact hfin

/-! ## §2  The thermodynamic factor -/

/-- **Thermodynamic factor of the two-factor bound.**

A chronologically ordered family of `m + 1` retained states whose consecutive
members are at operational distance at least `δ > 0`, with the blocks between
them obeying the speed limit and with disjoint budgets summing to at most `N_*`
and `S_*`, satisfies

  `m + 1 ≤ 1 + δ⁻¹ √(N_* S_* / 2)`.

Only consecutive separation is used, so the same bound holds for the
chronologically ordered subfamily extracted from any pairwise `δ`-separated
set -- which is how the packing depth is bounded. -/
theorem packing_depth_thermo
    (m : ℕ) (N S d : ℕ → ℝ) (delta Nstar Sstar : ℝ)
    (hdelta : 0 < delta)
    (hN : ∀ k, 0 ≤ N k) (hS : ∀ k, 0 ≤ S k) (hd : ∀ k, 0 ≤ d k)
    (hsl : ∀ k, 2 * d k ^ 2 ≤ N k * S k)
    (hgap : ∀ k ∈ range m, delta ≤ d k)
    (hNsum : ∑ k ∈ range m, N k ≤ Nstar)
    (hSsum : ∑ k ∈ range m, S k ≤ Sstar) :
    ((m : ℝ) + 1) ≤ 1 + (1 / delta) * Real.sqrt (Nstar * Sstar / 2) := by
  -- m * δ ≤ ∑ gaps ≤ √(N_* S_* / 2)
  have hcard : (m : ℝ) * delta ≤ ∑ k ∈ range m, d k := by
    have := Finset.card_nsmul_le_sum (range m) d delta hgap
    simpa [nsmul_eq_mul] using this
  have hsum := gap_sum_le m N S d Nstar Sstar hN hS hd hsl hNsum hSsum
  have hm : (m : ℝ) * delta ≤ Real.sqrt (Nstar * Sstar / 2) := hcard.trans hsum
  have hle : (m : ℝ) ≤ (1 / delta) * Real.sqrt (Nstar * Sstar / 2) := by
    rw [one_div, inv_mul_eq_div, le_div_iff₀ hdelta]
    exact hm
  linarith

/-! ## §3  The two factors together -/

/-- **Two-factor bound.**  The depth is bounded by the thermodynamic factor and
by the geometric factor `P` -- the `δ`-packing number of the operational state
space -- and therefore by the smaller of the two.

`hgeom` is the entirely geometric fact that a pairwise `δ`-separated family
cannot be larger than the packing number; it is a hypothesis here because this
file says nothing about the state space. -/
theorem packing_depth_two_factor
    (m : ℕ) (N S d : ℕ → ℝ) (delta Nstar Sstar P : ℝ)
    (hdelta : 0 < delta)
    (hN : ∀ k, 0 ≤ N k) (hS : ∀ k, 0 ≤ S k) (hd : ∀ k, 0 ≤ d k)
    (hsl : ∀ k, 2 * d k ^ 2 ≤ N k * S k)
    (hgap : ∀ k ∈ range m, delta ≤ d k)
    (hNsum : ∑ k ∈ range m, N k ≤ Nstar)
    (hSsum : ∑ k ∈ range m, S k ≤ Sstar)
    (hgeom : ((m : ℝ) + 1) ≤ P) :
    ((m : ℝ) + 1)
      ≤ min (1 + (1 / delta) * Real.sqrt (Nstar * Sstar / 2)) P :=
  le_min
    (packing_depth_thermo m N S d delta Nstar Sstar hdelta hN hS hd hsl hgap
      hNsum hSsum)
    hgeom

/-! ## §4  A uniformly bounded budget uniformly bounds the depth -/

/-- **Unbounded depth needs an unbounded budget.**  Given a family of runs
indexed by `j`, with achieved depth `D j` and activity/entropy budgets
`Nb j`, `Sb j`, a uniform ceiling `C` on the product `Nb j * Sb j` gives a
uniform ceiling on the depth.

Stated this way rather than as "there exists a bound on every `m`", which would
be vacuous: no real number bounds every natural, so such a statement would be a
proof that its own hypotheses are contradictory rather than a bound. -/
theorem depth_le_of_budget_ceiling
    (D : ℕ → ℕ) (Nb Sb : ℕ → ℝ) (delta C : ℝ)
    (hdelta : 0 < delta)
    (hbound : ∀ j, (D j : ℝ) ≤ 1 + (1 / delta) * Real.sqrt (Nb j * Sb j / 2))
    (hceil : ∀ j, Nb j * Sb j ≤ C) :
    ∀ j, (D j : ℝ) ≤ 1 + (1 / delta) * Real.sqrt (C / 2) := by
  intro j
  refine (hbound j).trans ?_
  have hs : Real.sqrt (Nb j * Sb j / 2) ≤ Real.sqrt (C / 2) :=
    Real.sqrt_le_sqrt (by linarith [hceil j])
  have hpos : 0 ≤ 1 / delta := le_of_lt (by positivity)
  nlinarith [hs, hpos]

/-! ## §5  The bound is attained -/

/-- The thermodynamic factor is not vacuous, and it is sharp: two blocks with
`N = 2`, `S = 1`, `d = 1` and `δ = 1` satisfy every hypothesis and meet the
bound with equality, `3 = 1 + √(4 * 2 / 2)`. -/
theorem packing_depth_thermo_sharp :
    ((2 : ℕ) : ℝ) + 1
      = 1 + (1 / (1:ℝ)) * Real.sqrt ((4:ℝ) * (2:ℝ) / 2)
    ∧ ((2 : ℕ) : ℝ) + 1
        ≤ 1 + (1 / (1:ℝ)) * Real.sqrt ((4:ℝ) * (2:ℝ) / 2) := by
  have hsqrt : Real.sqrt ((4:ℝ) * (2:ℝ) / 2) = 2 := by
    rw [show (4:ℝ) * (2:ℝ) / 2 = 2 ^ 2 by norm_num]
    exact Real.sqrt_sq (by norm_num)
  constructor
  · rw [hsqrt]; norm_num
  · exact le_of_eq (by rw [hsqrt]; norm_num)

/-- The witness above really is an instance of `packing_depth_thermo`: the
hypotheses hold for `m = 2`, `N ≡ 2`, `S ≡ 1`, `d ≡ 1`, `δ = 1`, `N_* = 4`,
`S_* = 2`. -/
theorem packing_depth_thermo_witness :
    ((2 : ℕ) : ℝ) + 1 ≤ 1 + (1 / (1:ℝ)) * Real.sqrt ((4:ℝ) * (2:ℝ) / 2) :=
  packing_depth_thermo 2 (fun _ => 2) (fun _ => 1) (fun _ => 1) 1 4 2
    (by norm_num) (fun _ => by norm_num) (fun _ => by norm_num)
    (fun _ => by norm_num) (fun _ => by norm_num)
    (fun _ _ => by norm_num) (by norm_num) (by norm_num)

end OrgDepth

#print axioms OrgDepth.gap_sum_le
#print axioms OrgDepth.packing_depth_thermo
#print axioms OrgDepth.packing_depth_two_factor
#print axioms OrgDepth.depth_le_of_budget_ceiling
#print axioms OrgDepth.packing_depth_thermo_sharp
#print axioms OrgDepth.packing_depth_thermo_witness