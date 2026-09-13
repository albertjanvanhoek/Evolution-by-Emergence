/-
Copyright (c) 2026. Released under Apache 2.0.

# Machine-verified mathematical core of the fixed-resolution no-go argument

This file formalises the elementary mathematical implications underlying the main
results of *Organizational Depth at Finite Time: A Fixed-Resolution No-Go Boundary*.

It verifies **conditional implications only**.  It does not formalise, and says
nothing about, the physical applicability of the hypotheses -- in particular it
does not justify the speed--distance law `c n * d n ^ 2 ≤ ε n * τ n`, nor the
identification of any metric with operational distinguishability.

Contents:

* `§1`  Closure of the stochastic route.  The uniform rate bound
  `λ n = N n * ν n * p n ≤ Λ` derived from a material budget, a positive
  per-realization material floor, a per-realization generation-rate ceiling and
  `p n ≤ 1`; and the resulting obstruction: a positive rate sequence bounded
  above has divergent reciprocal series.
* `§2`  The weighted finite-action bound
  `∑ √(c n) * d n ≤ √(∑ ε) * √(∑ τ)`.
* `§3`  The uniform finite-action bound
  `∑ d n ≤ (1/√c_*) * √(∑ ε) * √(∑ τ)`.
* `§4`  The fixed-resolution counting bound
  `card s * δ ≤ (1/√c_*) * √(∑ ε) * √(∑ τ)`.

Every statement is proved from Lean's axioms via `Mathlib`; see `#print axioms`
at the end of the file.
-/

import Mathlib.Analysis.Real.Sqrt
import Mathlib.Topology.Algebra.InfiniteSum.Real
import Mathlib.Topology.Algebra.InfiniteSum.Order
import Mathlib.Topology.Algebra.InfiniteSum.NatInt

namespace OrgDepth

open Finset Filter

/-! ## §1  Closure of the stochastic route -/

/-- A material budget `M n ≤ M_*` together with a positive material floor
`m_min` per independently counted realization bounds the number of realizations.
This is the step that converts an extensive resource bound into a bound on a
count.  `m_min > 0` is required; no other positivity is assumed. -/
theorem realizations_le_of_material
    (N M : ℕ → ℝ) (Mstar mmin : ℝ) (hmmin : 0 < mmin)
    (hfloor : ∀ n, mmin * N n ≤ M n) (hbudget : ∀ n, M n ≤ Mstar) :
    ∀ n, N n ≤ Mstar / mmin := by
  intro n
  rw [le_div_iff₀ hmmin, mul_comm]
  exact (hfloor n).trans (hbudget n)

-- `hp0 : 0 ≤ p n` is retained below because "`p` is a probability" is the modelling
-- hypothesis the paper states; only the upper bound `p n ≤ 1` is needed for the proof.
set_option linter.unusedVariables false in
/-- The uniform rate bound.  `p n ≤ 1` holds because `p n` is a probability; it
is a hypothesis of the model, not an extra empirical assumption.  Note that the
bound does **not** require `p n` to be bounded below. -/
theorem rate_le
    (N nu p : ℕ → ℝ) (Nmax numax : ℝ)
    (hN0 : ∀ n, 0 ≤ N n) (hnu0 : ∀ n, 0 ≤ nu n)
    (hp0 : ∀ n, 0 ≤ p n) (hp1 : ∀ n, p n ≤ 1)
    (hN : ∀ n, N n ≤ Nmax) (hnu : ∀ n, nu n ≤ numax) :
    ∀ n, N n * nu n * p n ≤ Nmax * numax := by
  intro n
  have h1 : N n * nu n * p n ≤ N n * nu n := by
    calc N n * nu n * p n
        ≤ N n * nu n * 1 :=
          mul_le_mul_of_nonneg_left (hp1 n) (mul_nonneg (hN0 n) (hnu0 n))
      _ = N n * nu n := mul_one _
  have h2 : N n * nu n ≤ Nmax * numax :=
    mul_le_mul (hN n) (hnu n) (hnu0 n) ((hN0 n).trans (hN n))
  exact h1.trans h2

/-- Finite-prefix form of the obstruction: if `0 < lam n ≤ Λ` then the partial
sums of the reciprocal rates grow at least linearly. -/
theorem sum_inv_rate_ge
    (lam : ℕ → ℝ) (Lam : ℝ)
    (hpos : ∀ n, 0 < lam n) (hle : ∀ n, lam n ≤ Lam) :
    ∀ k : ℕ, (k : ℝ) * (1 / Lam) ≤ ∑ i ∈ range k, 1 / lam i := by
  intro k
  have hterm : ∀ i ∈ range k, 1 / Lam ≤ 1 / lam i := by
    intro i _
    exact one_div_le_one_div_of_le (hpos i) (hle i)
  have := Finset.card_nsmul_le_sum (range k) (fun i => 1 / lam i) (1 / Lam) hterm
  simpa [Finset.card_range, nsmul_eq_mul] using this

/-- **Closure of the stochastic route.**  A rate sequence that is positive and
uniformly bounded above cannot have a summable reciprocal series.  Since the
pure-birth explosion criterion is exactly `Summable (fun n => 1 / lam n)`, this
is the mathematical content of the non-explosion claim.

The stochastic-process theory itself is not formalised here: this is the
deterministic series obstruction that the criterion reduces to. -/
theorem not_summable_inv_rate
    (lam : ℕ → ℝ) (Lam : ℝ) (hLam : 0 < Lam)
    (hpos : ∀ n, 0 < lam n) (hle : ∀ n, lam n ≤ Lam) :
    ¬ Summable (fun n => 1 / lam n) := by
  intro hS
  -- a summable real sequence tends to zero
  have htend : Tendsto (fun n => 1 / lam n) atTop (nhds 0) := hS.tendsto_atTop_zero
  -- but every term is at least `1 / Lam > 0`
  have hge : ∀ n, 1 / Lam ≤ 1 / lam n := fun n =>
    one_div_le_one_div_of_le (hpos n) (hle n)
  have : (1 : ℝ) / Lam ≤ 0 := ge_of_tendsto' htend hge
  exact absurd this (not_le.mpr (by positivity))

/-- The two halves combined, in the form used in the paper: under a material
budget, a positive per-realization material floor, a generation-rate ceiling and
`0 ≤ p n ≤ 1`, the reciprocal-rate series diverges.  Positivity of the rate at
every reachable level is an explicit hypothesis (the paper stops the chain at any
level where the rate vanishes). -/
theorem stochastic_route_closed
    (N nu p M : ℕ → ℝ) (Mstar mmin numax : ℝ)
    (hmmin : 0 < mmin) (hnumax : 0 < numax) (hMstar : 0 < Mstar)
    (hfloor : ∀ n, mmin * N n ≤ M n) (hbudget : ∀ n, M n ≤ Mstar)
    (hN0 : ∀ n, 0 ≤ N n) (hnu0 : ∀ n, 0 ≤ nu n)
    (hp0 : ∀ n, 0 ≤ p n) (hp1 : ∀ n, p n ≤ 1)
    (hnu : ∀ n, nu n ≤ numax)
    (hrate : ∀ n, 0 < N n * nu n * p n) :
    ¬ Summable (fun n => 1 / (N n * nu n * p n)) := by
  have hNle : ∀ n, N n ≤ Mstar / mmin :=
    realizations_le_of_material N M Mstar mmin hmmin hfloor hbudget
  have hbound : ∀ n, N n * nu n * p n ≤ (Mstar / mmin) * numax :=
    rate_le N nu p (Mstar / mmin) numax hN0 hnu0 hp0 hp1 hNle hnu
  exact not_summable_inv_rate _ ((Mstar / mmin) * numax)
    (by positivity) hrate hbound

/-! ## §2  The weighted finite-action bound -/

/-- Cauchy--Schwarz on a finite prefix, with the tail absorbed into the tsums.
This is the only analytic ingredient of the finite-action results. -/
private theorem prefix_sqrt_bound
    (eps tau : ℕ → ℝ)
    (heps : ∀ n, 0 ≤ eps n) (htau : ∀ n, 0 ≤ tau n)
    (hSe : Summable eps) (hSt : Summable tau) (k : ℕ) :
    ∑ i ∈ range k, Real.sqrt (eps i * tau i)
      ≤ Real.sqrt (∑' n, eps n) * Real.sqrt (∑' n, tau n) := by
  have hsplit : ∀ i ∈ range k,
      Real.sqrt (eps i * tau i) = Real.sqrt (eps i) * Real.sqrt (tau i) := by
    intro i _; exact Real.sqrt_mul (heps i) _
  rw [Finset.sum_congr rfl hsplit]
  refine (Real.sum_sqrt_mul_sqrt_le (range k) heps htau).trans ?_
  have he : ∑ i ∈ range k, eps i ≤ ∑' n, eps n :=
    Summable.sum_le_tsum (range k) (fun i _ => heps i) hSe
  have ht : ∑ i ∈ range k, tau i ≤ ∑' n, tau n :=
    Summable.sum_le_tsum (range k) (fun i _ => htau i) hSt
  exact mul_le_mul (Real.sqrt_le_sqrt he) (Real.sqrt_le_sqrt ht)
    (Real.sqrt_nonneg _) (Real.sqrt_nonneg _)

/-- **Weighted finite-action bound.**  From the speed--distance law
`c n * d n ^ 2 ≤ ε n * τ n` with a finite total charged cost and a finite total
time, the weighted accumulated distance `∑ √(c n) * d n` is finite and bounded by
`√(∑ ε) * √(∑ τ)`.

No lower bound on `c n` is assumed; `c n ≥ 0` and `d n ≥ 0` suffice. -/
theorem weighted_finite_action
    (c eps tau d : ℕ → ℝ)
    (hc : ∀ n, 0 ≤ c n) (hd : ∀ n, 0 ≤ d n)
    (heps : ∀ n, 0 ≤ eps n) (htau : ∀ n, 0 ≤ tau n)
    (hact : ∀ n, c n * d n ^ 2 ≤ eps n * tau n)
    (hSe : Summable eps) (hSt : Summable tau) :
    Summable (fun n => Real.sqrt (c n) * d n) ∧
      ∑' n, Real.sqrt (c n) * d n
        ≤ Real.sqrt (∑' n, eps n) * Real.sqrt (∑' n, tau n) := by
  -- pointwise: √(c n) * d n = √(c n * d n ^ 2) ≤ √(ε n * τ n)
  have hpt : ∀ n, Real.sqrt (c n) * d n ≤ Real.sqrt (eps n * tau n) := by
    intro n
    have hrw : Real.sqrt (c n) * d n = Real.sqrt (c n * d n ^ 2) := by
      rw [Real.sqrt_mul (hc n), Real.sqrt_sq (hd n)]
    rw [hrw]
    exact Real.sqrt_le_sqrt (hact n)
  have hnn : ∀ n, 0 ≤ Real.sqrt (c n) * d n := fun n =>
    mul_nonneg (Real.sqrt_nonneg _) (hd n)
  -- every partial sum is bounded by the same constant
  have hpre : ∀ k : ℕ, ∑ i ∈ range k, Real.sqrt (c i) * d i
      ≤ Real.sqrt (∑' n, eps n) * Real.sqrt (∑' n, tau n) := by
    intro k
    refine (Finset.sum_le_sum (fun i _ => hpt i)).trans ?_
    exact prefix_sqrt_bound eps tau heps htau hSe hSt k
  exact ⟨summable_of_sum_range_le hnn hpre, Real.tsum_le_of_sum_range_le hnn hpre⟩

/-! ## §3  The uniform finite-action bound -/

/-- **Finite-action bound.**  With a uniform positive kinetic coefficient
`c_* > 0`, the accumulated physical distance is finite and bounded by
`(1/√c_*) * √(∑ ε) * √(∑ τ)`.

`c_* > 0` is required precisely so that the division is defined; the degenerate
case `c_* = 0` gives no bound, as the weighted statement above makes explicit. -/
theorem finite_action
    (eps tau d : ℕ → ℝ) (cstar : ℝ) (hcstar : 0 < cstar)
    (hd : ∀ n, 0 ≤ d n) (heps : ∀ n, 0 ≤ eps n) (htau : ∀ n, 0 ≤ tau n)
    (hact : ∀ n, cstar * d n ^ 2 ≤ eps n * tau n)
    (hSe : Summable eps) (hSt : Summable tau) :
    Summable d ∧
      ∑' n, d n
        ≤ (1 / Real.sqrt cstar)
            * (Real.sqrt (∑' n, eps n) * Real.sqrt (∑' n, tau n)) := by
  obtain ⟨hSum, hle⟩ :=
    weighted_finite_action (fun _ => cstar) eps tau d
      (fun _ => le_of_lt hcstar) hd heps htau (fun n => hact n) hSe hSt
  have hsq : 0 < Real.sqrt cstar := Real.sqrt_pos.mpr hcstar
  -- `∑ √c_* * d n = √c_* * ∑ d n`, so divide through
  have hSd : Summable d := by
    have := hSum.div_const (Real.sqrt cstar)
    refine this.congr (fun n => ?_)
    field_simp
  constructor
  · exact hSd
  · have hmul : Real.sqrt cstar * ∑' n, d n
        ≤ Real.sqrt (∑' n, eps n) * Real.sqrt (∑' n, tau n) := by
      rw [← tsum_mul_left]
      exact hle
    rw [one_div, inv_mul_eq_div, le_div_iff₀ hsq, mul_comm]
    exact hmul

/-- **Finite-action bound from a kinetic floor.**  This is the exact manuscript
form of Theorem 5.1: a variable coefficient `c n` obeys the weighted
speed--distance law, while `cstar > 0` is a uniform lower bound on that
coefficient.  The conclusion is the uniform finite-action bound. -/
theorem finite_action_of_kinetic_floor
    (c eps tau d : ℕ → ℝ) (cstar : ℝ) (hcstar : 0 < cstar)
    (_hc : ∀ n, 0 ≤ c n) (hfloor : ∀ n, cstar ≤ c n)
    (hd : ∀ n, 0 ≤ d n) (heps : ∀ n, 0 ≤ eps n) (htau : ∀ n, 0 ≤ tau n)
    (hact : ∀ n, c n * d n ^ 2 ≤ eps n * tau n)
    (hSe : Summable eps) (hSt : Summable tau) :
    Summable d ∧
      ∑' n, d n
        ≤ (1 / Real.sqrt cstar)
            * (Real.sqrt (∑' n, eps n) * Real.sqrt (∑' n, tau n)) := by
  have hactstar : ∀ n, cstar * d n ^ 2 ≤ eps n * tau n := by
    intro n
    exact (mul_le_mul_of_nonneg_right (hfloor n) (sq_nonneg (d n))).trans (hact n)
  exact finite_action eps tau d cstar hcstar hd heps htau hactstar hSe hSt

/-! ## §4  The fixed-resolution counting bound -/

-- `hdelta : 0 < delta` is retained in the next statement for faithfulness to the
-- paper (the bound is vacuous otherwise) even though the proof does not need it.
set_option linter.unusedVariables false in
/-- **Fixed-resolution no-go.**  If a finite set `s` of transitions each move the
state by at least `δ > 0` in the physical metric, then `card s * δ` is bounded by
the finite-action bound.  Consequently no infinite such family exists.

This is the counting form of the corollary in the paper; the finite-set
formulation makes the "for every finite collection" argument explicit. -/
theorem fixed_resolution_count
    (eps tau d : ℕ → ℝ) (cstar delta : ℝ)
    (hcstar : 0 < cstar) (hdelta : 0 < delta)
    (hd : ∀ n, 0 ≤ d n) (heps : ∀ n, 0 ≤ eps n) (htau : ∀ n, 0 ≤ tau n)
    (hact : ∀ n, cstar * d n ^ 2 ≤ eps n * tau n)
    (hSe : Summable eps) (hSt : Summable tau)
    (s : Finset ℕ) (hs : ∀ n ∈ s, delta ≤ d n) :
    (s.card : ℝ) * delta
      ≤ (1 / Real.sqrt cstar)
          * (Real.sqrt (∑' n, eps n) * Real.sqrt (∑' n, tau n)) := by
  obtain ⟨hSd, hbound⟩ :=
    finite_action eps tau d cstar hcstar hd heps htau hact hSe hSt
  have h1 : (s.card : ℝ) * delta ≤ ∑ n ∈ s, d n := by
    have := Finset.card_nsmul_le_sum s d delta hs
    simpa [nsmul_eq_mul] using this
  have h2 : ∑ n ∈ s, d n ≤ ∑' n, d n :=
    Summable.sum_le_tsum s (fun i _ => hd i) hSd
  exact h1.trans (h2.trans hbound)

/-- The counting bound excludes an infinite family of fixed-resolution
transitions: the set of indices with `d n ≥ δ` is finite. -/
theorem fixed_resolution_finite
    (eps tau d : ℕ → ℝ) (cstar delta : ℝ)
    (hcstar : 0 < cstar) (hdelta : 0 < delta)
    (hd : ∀ n, 0 ≤ d n) (heps : ∀ n, 0 ≤ eps n) (htau : ∀ n, 0 ≤ tau n)
    (hact : ∀ n, cstar * d n ^ 2 ≤ eps n * tau n)
    (hSe : Summable eps) (hSt : Summable tau) :
    {n : ℕ | delta ≤ d n}.Finite := by
  by_contra hinf
  rw [Set.not_finite] at hinf
  -- an infinite set of naturals contains finite subsets of every cardinality
  obtain ⟨s, hsub, hcard⟩ :=
    hinf.exists_subset_card_eq
      (Nat.ceil ((1 / Real.sqrt cstar)
        * (Real.sqrt (∑' n, eps n) * Real.sqrt (∑' n, tau n)) / delta) + 1)
  have hs : ∀ n ∈ s, delta ≤ d n := fun n hn => hsub hn
  have hb := fixed_resolution_count eps tau d cstar delta hcstar hdelta
    hd heps htau hact hSe hSt s hs
  set B := (1 / Real.sqrt cstar)
    * (Real.sqrt (∑' n, eps n) * Real.sqrt (∑' n, tau n)) with hB
  have hBnn : 0 ≤ B := by
    have : 0 ≤ 1 / Real.sqrt cstar := by positivity
    exact mul_nonneg this (mul_nonneg (Real.sqrt_nonneg _) (Real.sqrt_nonneg _))
  rw [hcard] at hb
  have hgt : B / delta < ((Nat.ceil (B / delta) + 1 : ℕ) : ℝ) := by
    push_cast
    exact lt_of_le_of_lt (Nat.le_ceil _) (by linarith)
  have hlt : B < ((Nat.ceil (B / delta) + 1 : ℕ) : ℝ) * delta :=
    (div_lt_iff₀ hdelta).mp hgt
  linarith

/-- Exact manuscript form of the fixed-resolution counting corollary when the
speed--distance coefficient is variable but has a positive uniform floor. -/
theorem fixed_resolution_count_of_kinetic_floor
    (c eps tau d : ℕ → ℝ) (cstar delta : ℝ)
    (hcstar : 0 < cstar) (hdelta : 0 < delta)
    (_hc : ∀ n, 0 ≤ c n) (hfloor : ∀ n, cstar ≤ c n)
    (hd : ∀ n, 0 ≤ d n) (heps : ∀ n, 0 ≤ eps n) (htau : ∀ n, 0 ≤ tau n)
    (hact : ∀ n, c n * d n ^ 2 ≤ eps n * tau n)
    (hSe : Summable eps) (hSt : Summable tau)
    (s : Finset ℕ) (hs : ∀ n ∈ s, delta ≤ d n) :
    (s.card : ℝ) * delta
      ≤ (1 / Real.sqrt cstar)
          * (Real.sqrt (∑' n, eps n) * Real.sqrt (∑' n, tau n)) := by
  have hactstar : ∀ n, cstar * d n ^ 2 ≤ eps n * tau n := by
    intro n
    exact (mul_le_mul_of_nonneg_right (hfloor n) (sq_nonneg (d n))).trans (hact n)
  exact fixed_resolution_count eps tau d cstar delta hcstar hdelta
    hd heps htau hactstar hSe hSt s hs

/-- Exact manuscript finiteness consequence under a positive uniform kinetic floor. -/
theorem fixed_resolution_finite_of_kinetic_floor
    (c eps tau d : ℕ → ℝ) (cstar delta : ℝ)
    (hcstar : 0 < cstar) (hdelta : 0 < delta)
    (_hc : ∀ n, 0 ≤ c n) (hfloor : ∀ n, cstar ≤ c n)
    (hd : ∀ n, 0 ≤ d n) (heps : ∀ n, 0 ≤ eps n) (htau : ∀ n, 0 ≤ tau n)
    (hact : ∀ n, c n * d n ^ 2 ≤ eps n * tau n)
    (hSe : Summable eps) (hSt : Summable tau) :
    {n : ℕ | delta ≤ d n}.Finite := by
  have hactstar : ∀ n, cstar * d n ^ 2 ≤ eps n * tau n := by
    intro n
    exact (mul_le_mul_of_nonneg_right (hfloor n) (sq_nonneg (d n))).trans (hact n)
  exact fixed_resolution_finite eps tau d cstar delta hcstar hdelta
    hd heps htau hactstar hSe hSt

/-! ## Axiom audit -/

#print axioms realizations_le_of_material
#print axioms rate_le
#print axioms sum_inv_rate_ge
#print axioms not_summable_inv_rate
#print axioms stochastic_route_closed
#print axioms weighted_finite_action
#print axioms finite_action
#print axioms finite_action_of_kinetic_floor
#print axioms fixed_resolution_count
#print axioms fixed_resolution_finite
#print axioms fixed_resolution_count_of_kinetic_floor
#print axioms fixed_resolution_finite_of_kinetic_floor

end OrgDepth