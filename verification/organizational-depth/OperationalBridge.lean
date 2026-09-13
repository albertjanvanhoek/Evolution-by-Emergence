/-
# The physical-to-operational bridge, machine-checked

Companion to `OrganizationalDepth.lean`.  That file verified the finite-action
and fixed-resolution results for an abstract sequence `d n` of "physical
distances".  This file supplies the missing comparison for one concrete model
class: finite-state Markov jump dynamics, where the physical metric of the
speed limit is the total variation distance itself.

The mathematical content is the **data-processing inequality for total
variation**: no measurement channel can increase total variation distance.  It
follows that the operational distinguishability

  `d_op(x,y) = sup over admissible measurements M of d_TV(M p_x, M p_y)`

is dominated by `d_TV(p_x, p_y)` with constant `1`, globally and with no
regularity, compactness or positivity assumptions.  Composed with the speed
limit this makes the fixed-resolution no-go operational rather than conditional.

What is **not** formalised here: that the speed limit
`2 d_TV² ≤ Σ · N` holds for the dynamics (it is a hypothesis below), and the
identification of the measurement class with anything physical.
-/

import Mathlib.Analysis.Real.Sqrt
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Order.BigOperators.Ring.Finset

namespace OrgBridge

open Finset

variable {S O : Type*} [Fintype S] [Fintype O]

/-! ## §1  Total variation and measurement channels -/

/-- Total variation distance between two finite signed weightings. -/
noncomputable def dTV (p q : S → ℝ) : ℝ := (1 / 2) * ∑ i, |p i - q i|

/-- A measurement: a row-stochastic kernel from states to outcomes.  This is the
weakest possible notion -- any physical measurement whose statistics depend only
on the state distribution is of this form. -/
structure Channel (S O : Type*) [Fintype S] [Fintype O] where
  k : S → O → ℝ
  nonneg : ∀ i o, 0 ≤ k i o
  row_sum : ∀ i, ∑ o, k i o = 1

/-- The readout distribution induced by a channel. -/
noncomputable def push (Phi : Channel S O) (p : S → ℝ) : O → ℝ :=
  fun o => ∑ i, p i * Phi.k i o

/-! ## §2  The data-processing inequality -/

/-- `L¹` form: a channel does not increase the `L¹` distance. -/
theorem l1_push_le (Phi : Channel S O) (p q : S → ℝ) :
    ∑ o, |push Phi p o - push Phi q o| ≤ ∑ i, |p i - q i| := by
  have key : ∀ o : O, |push Phi p o - push Phi q o| ≤ ∑ i, |p i - q i| * Phi.k i o := by
    intro o
    have hrw : push Phi p o - push Phi q o = ∑ i, (p i - q i) * Phi.k i o := by
      simp only [push, sub_mul, Finset.sum_sub_distrib]
    rw [hrw]
    refine (Finset.abs_sum_le_sum_abs _ _).trans (le_of_eq ?_)
    exact Finset.sum_congr rfl fun i _ => by
      rw [abs_mul, abs_of_nonneg (Phi.nonneg i o)]
  calc ∑ o, |push Phi p o - push Phi q o|
      ≤ ∑ o, ∑ i, |p i - q i| * Phi.k i o := Finset.sum_le_sum fun o _ => key o
    _ = ∑ i, ∑ o, |p i - q i| * Phi.k i o := Finset.sum_comm
    _ = ∑ i, |p i - q i| * ∑ o, Phi.k i o := by
          exact Finset.sum_congr rfl fun i _ => (Finset.mul_sum _ _ _).symm
    _ = ∑ i, |p i - q i| := by
          exact Finset.sum_congr rfl fun i _ => by rw [Phi.row_sum i, mul_one]

/-- **Data-processing inequality for total variation.**  No measurement can make
two distributions more distinguishable than they already are.  The comparison
constant is `1`: global, and free of any regularity or positivity hypothesis. -/
theorem dTV_push_le (Phi : Channel S O) (p q : S → ℝ) :
    dTV (push Phi p) (push Phi q) ≤ dTV p q := by
  unfold dTV
  have h := l1_push_le Phi p q
  linarith

/-- The identity channel, witnessing that the constant `1` is sharp. -/
noncomputable def idChannel [DecidableEq S] : Channel S S where
  k i j := if i = j then 1 else 0
  nonneg i j := by split <;> norm_num
  row_sum i := by simp

theorem push_idChannel [DecidableEq S] (p : S → ℝ) : push idChannel p = p := by
  funext o; simp [push, idChannel]

/-- Sharpness: for the identity channel the inequality is an equality, so no
constant smaller than `1` works. -/
theorem dTV_push_idChannel [DecidableEq S] (p q : S → ℝ) :
    dTV (push (idChannel : Channel S S) p) (push idChannel q) = dTV p q := by
  rw [push_idChannel, push_idChannel]

/-! ## §3  Transfer of the speed limit to the operational metric

If the physical speed limit is stated in total variation, and operational
distinguishability is any channel readout of the same state, then the speed
limit holds verbatim for the operational distance. -/

/-- Pointwise transfer.  `dop n ≤ dTVn n` is supplied by `dTV_push_le`;
`hSL` is the speed limit, a hypothesis about the dynamics. -/
theorem speed_limit_operational
    (dTVn dop Sig Nact : ℕ → ℝ)
    (hdop0 : ∀ n, 0 ≤ dop n)
    (hdom : ∀ n, dop n ≤ dTVn n)
    (hSL : ∀ n, 2 * dTVn n ^ 2 ≤ Sig n * Nact n) :
    ∀ n, 2 * dop n ^ 2 ≤ Sig n * Nact n := by
  intro n
  refine le_trans ?_ (hSL n)
  have : dop n ^ 2 ≤ dTVn n ^ 2 := by
    apply sq_le_sq' (by linarith [hdop0 n, hdom n]) (hdom n)
  linarith

/-! ## §4  The operational fixed-resolution bound

Self-contained restatement of the counting argument of `OrganizationalDepth.lean`,
specialised to `c = 2` and to the operational distance.  The two budgets are
dimensionless: `Sig n` is entropy production in units of `k_B` and `Nact n` is
the expected number of jumps. -/

private theorem prefix_bound
    (Sig Nact : ℕ → ℝ) (SigTot NactTot : ℝ)
    (hS0 : ∀ n, 0 ≤ Sig n) (hN0 : ∀ n, 0 ≤ Nact n)
    (hSsum : ∀ s : Finset ℕ, ∑ n ∈ s, Sig n ≤ SigTot)
    (hNsum : ∀ s : Finset ℕ, ∑ n ∈ s, Nact n ≤ NactTot)
    (s : Finset ℕ) :
    ∑ n ∈ s, Real.sqrt (Sig n * Nact n)
      ≤ Real.sqrt SigTot * Real.sqrt NactTot := by
  have hsplit : ∀ n ∈ s, Real.sqrt (Sig n * Nact n)
      = Real.sqrt (Sig n) * Real.sqrt (Nact n) := fun n _ => Real.sqrt_mul (hS0 n) _
  rw [Finset.sum_congr rfl hsplit]
  refine (Real.sum_sqrt_mul_sqrt_le s hS0 hN0).trans ?_
  exact mul_le_mul (Real.sqrt_le_sqrt (hSsum s)) (Real.sqrt_le_sqrt (hNsum s))
    (Real.sqrt_nonneg _) (Real.sqrt_nonneg _)

-- `hdelta : 0 < delta` is kept for faithfulness (the bound is vacuous otherwise)
-- though the counting argument itself does not need it.
set_option linter.unusedVariables false in
/-- **Operational fixed-resolution no-go.**  Under a total entropy-production
budget `SigTot` and a total activity budget `NactTot`, the number of transitions
that are operationally distinguishable at resolution `delta` is bounded by
`(1/(delta * sqrt 2)) * sqrt SigTot * sqrt NactTot`.

Every quantity on the right is dimensionless and measurable. -/
theorem operational_fixed_resolution
    (dop Sig Nact : ℕ → ℝ) (SigTot NactTot delta : ℝ)
    (hdelta : 0 < delta)
    (hdop0 : ∀ n, 0 ≤ dop n)
    (hS0 : ∀ n, 0 ≤ Sig n) (hN0 : ∀ n, 0 ≤ Nact n)
    (hSL : ∀ n, 2 * dop n ^ 2 ≤ Sig n * Nact n)
    (hSsum : ∀ s : Finset ℕ, ∑ n ∈ s, Sig n ≤ SigTot)
    (hNsum : ∀ s : Finset ℕ, ∑ n ∈ s, Nact n ≤ NactTot)
    (s : Finset ℕ) (hs : ∀ n ∈ s, delta ≤ dop n) :
    (s.card : ℝ) * delta
      ≤ (1 / Real.sqrt 2) * (Real.sqrt SigTot * Real.sqrt NactTot) := by
  -- pointwise: sqrt 2 * dop n ≤ sqrt (Sig n * Nact n)
  have hpt : ∀ n, Real.sqrt 2 * dop n ≤ Real.sqrt (Sig n * Nact n) := by
    intro n
    have hrw : Real.sqrt 2 * dop n = Real.sqrt (2 * dop n ^ 2) := by
      rw [Real.sqrt_mul (by norm_num), Real.sqrt_sq (hdop0 n)]
    rw [hrw]; exact Real.sqrt_le_sqrt (hSL n)
  have h2 : (0 : ℝ) < Real.sqrt 2 := by positivity
  -- card * delta ≤ ∑ dop ≤ (1/√2) ∑ √(Σ N) ≤ (1/√2) √Σ √N
  have hcard : (s.card : ℝ) * delta ≤ ∑ n ∈ s, dop n := by
    have := Finset.card_nsmul_le_sum s dop delta hs
    simpa [nsmul_eq_mul] using this
  have hsum : Real.sqrt 2 * ∑ n ∈ s, dop n ≤ Real.sqrt SigTot * Real.sqrt NactTot := by
    rw [Finset.mul_sum]
    exact (Finset.sum_le_sum fun n _ => hpt n).trans
      (prefix_bound Sig Nact SigTot NactTot hS0 hN0 hSsum hNsum s)
  rw [one_div, inv_mul_eq_div, le_div_iff₀ h2, mul_comm]
  calc Real.sqrt 2 * ((s.card : ℝ) * delta)
      ≤ Real.sqrt 2 * ∑ n ∈ s, dop n := by
        exact mul_le_mul_of_nonneg_left hcard (le_of_lt h2)
    _ ≤ Real.sqrt SigTot * Real.sqrt NactTot := hsum

/-! ## Axiom audit -/

#print axioms l1_push_le
#print axioms dTV_push_le
#print axioms dTV_push_idChannel
#print axioms speed_limit_operational
#print axioms operational_fixed_resolution

end OrgBridge
