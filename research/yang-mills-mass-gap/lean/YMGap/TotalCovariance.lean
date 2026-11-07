import Mathlib
import YMGap.CovarianceTransfer

/-!
# Total covariance on a finite space: deriving the split

`CovarianceTransfer` assumes the split `|covF| ≤ |covB| + |covC|` for arbitrary
functions. Here the split is **derived** for actual conditional expectations,
on a finite configuration space `Ω` with nonnegative weights `w` and a coarse
variable `coarse : Ω → β` (for example, the block averages of a lattice field).

* `expect_condExp`: the tower property, E[E[f|B]] = E[f].
* `total_covariance`: Cov(f, g) = Cov(E[f|B], E[g|B]) + E[Cov(f, g | B)].
* `split_bound`: the split used by `corrected_transfer`, now as a theorem.
* `transfer_of_blocking`: `corrected_transfer_min` applied to actual blocked
  covariances and actual residual terms. Only the two decay bounds remain as
  hypotheses.

Normalization (total weight 1) is not needed. Blocks of zero weight are
harmless: their conditional expectation is set to 0 by division by zero, and
they carry no weight.

This covers finite lattices with a discretized field. Continuous gauge groups
(Haar measure) need the measure-theoretic version, which Mathlib has but which
is not used here.
-/

namespace YMGap

open Real

section Finite

variable {Ω β : Type*} [Fintype Ω] [Fintype β] [DecidableEq β]
variable (w : Ω → ℝ) (coarse : Ω → β)

/-- Expectation with weights `w`. -/
def expect (f : Ω → ℝ) : ℝ := ∑ ω, w ω * f ω

/-- Weight of the block where the coarse variable equals `j`. -/
def blockWeight (j : β) : ℝ := ∑ ω ∈ Finset.univ.filter (fun ω => coarse ω = j), w ω

/-- Weighted sum of `f` over that block. -/
def blockSum (f : Ω → ℝ) (j : β) : ℝ :=
  ∑ ω ∈ Finset.univ.filter (fun ω => coarse ω = j), w ω * f ω

/-- Conditional expectation of `f` given the coarse variable. -/
noncomputable def condExp (f : Ω → ℝ) : Ω → ℝ :=
  fun ω => blockSum w coarse f (coarse ω) / blockWeight w coarse (coarse ω)

/-- Covariance. -/
def covar (f g : Ω → ℝ) : ℝ := expect w (fun ω => f ω * g ω) - expect w f * expect w g

/-- Conditional covariance given the coarse variable. -/
noncomputable def condCov (f g : Ω → ℝ) : Ω → ℝ :=
  fun ω => condExp w coarse (fun ω => f ω * g ω) ω
    - condExp w coarse f ω * condExp w coarse g ω

theorem sum_block_fn (h : β → ℝ) :
    ∑ ω, w ω * h (coarse ω) = ∑ j, blockWeight w coarse j * h j := by
  rw [← Finset.sum_fiberwise Finset.univ coarse (fun ω => w ω * h (coarse ω))]
  apply Finset.sum_congr rfl
  intro j _
  unfold blockWeight
  rw [Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro ω hω
  rw [(Finset.mem_filter.mp hω).2]

theorem sum_blockSum (f : Ω → ℝ) :
    ∑ j, blockSum w coarse f j = ∑ ω, w ω * f ω := by
  unfold blockSum
  exact Finset.sum_fiberwise Finset.univ coarse (fun ω => w ω * f ω)

theorem weight_mul_div (hw : ∀ ω, 0 ≤ w ω) (f : Ω → ℝ) (j : β) :
    blockWeight w coarse j * (blockSum w coarse f j / blockWeight w coarse j)
      = blockSum w coarse f j := by
  by_cases h : blockWeight w coarse j = 0
  · have h' : ∑ ω ∈ Finset.univ.filter (fun ω => coarse ω = j), w ω = 0 := h
    have hz : ∀ ω ∈ Finset.univ.filter (fun ω => coarse ω = j), w ω = 0 :=
      (Finset.sum_eq_zero_iff_of_nonneg (fun ω _ => hw ω)).mp h'
    have hS : blockSum w coarse f j = 0 := by
      unfold blockSum
      exact Finset.sum_eq_zero (fun ω hω => by rw [hz ω hω, zero_mul])
    rw [h, hS]
    simp
  · field_simp

/-- **Tower property.** E[E[f|B]] = E[f]. -/
theorem expect_condExp (hw : ∀ ω, 0 ≤ w ω) (f : Ω → ℝ) :
    expect w (condExp w coarse f) = expect w f := by
  calc expect w (condExp w coarse f)
      = ∑ ω, w ω * (blockSum w coarse f (coarse ω) / blockWeight w coarse (coarse ω)) := rfl
    _ = ∑ j, blockWeight w coarse j * (blockSum w coarse f j / blockWeight w coarse j) :=
        sum_block_fn w coarse (fun j => blockSum w coarse f j / blockWeight w coarse j)
    _ = ∑ j, blockSum w coarse f j :=
        Finset.sum_congr rfl (fun j _ => weight_mul_div w coarse hw f j)
    _ = expect w f := sum_blockSum w coarse f

/-- **Law of total covariance.** -/
theorem total_covariance (hw : ∀ ω, 0 ≤ w ω) (f g : Ω → ℝ) :
    covar w f g = covar w (condExp w coarse f) (condExp w coarse g)
      + expect w (condCov w coarse f g) := by
  have hsub : expect w (condCov w coarse f g)
      = expect w (condExp w coarse (fun ω => f ω * g ω))
        - expect w (fun ω => condExp w coarse f ω * condExp w coarse g ω) := by
    simp only [expect, condCov, mul_sub, Finset.sum_sub_distrib]
  unfold covar
  rw [hsub, expect_condExp w coarse hw (fun ω => f ω * g ω),
    expect_condExp w coarse hw f, expect_condExp w coarse hw g]
  ring

/-- **The split, derived.** -/
theorem split_bound (hw : ∀ ω, 0 ≤ w ω) (f g : Ω → ℝ) :
    |covar w f g| ≤ |covar w (condExp w coarse f) (condExp w coarse g)|
      + |expect w (condCov w coarse f g)| := by
  rw [total_covariance w coarse hw f g]
  set x := covar w (condExp w coarse f) (condExp w coarse g)
  set y := expect w (condCov w coarse f g)
  have h1 := le_abs_self x
  have h2 := neg_abs_le x
  have h3 := le_abs_self y
  have h4 := neg_abs_le y
  exact abs_le.mpr ⟨by linarith, by linarith⟩

/-- **Transfer with actual conditional expectations.** For a family of
observables `F p`, fine covariances decay at rate `min (m₁ / s) m₂` once the
blocked covariances decay at rate `m₁` on the coarse lattice and the residual
terms decay at rate `m₂` on the fine lattice. The split is no longer assumed. -/
theorem transfer_of_blocking {I J : Type*} (hw : ∀ ω, 0 ≤ w ω) (F : I → Ω → ℝ)
    (block : I → J) (dF : I → I → ℝ) (dC : J → J → ℝ) (s o : ℝ)
    (hcomp : ∀ p q, dF p q / s ≤ dC (block p) (block q) + o)
    (hd : ∀ p q, 0 ≤ dF p q)
    (C₁ C₂ m₁ m₂ : ℝ) (hC₁ : 0 ≤ C₁) (hC₂ : 0 ≤ C₂) (hm₁ : 0 ≤ m₁)
    (hB : ∀ p q, |covar w (condExp w coarse (F p)) (condExp w coarse (F q))|
      ≤ C₁ * exp (-m₁ * dC (block p) (block q)))
    (hC : ∀ p q, |expect w (condCov w coarse (F p) (F q))| ≤ C₂ * exp (-m₂ * dF p q)) :
    ∀ p q, |covar w (F p) (F q)| ≤
      (C₁ * exp (m₁ * o) + C₂) * exp (-(min (m₁ / s) m₂) * dF p q) :=
  corrected_transfer_min block dF dC s o hcomp hd
    (fun p q => covar w (F p) (F q))
    (fun p q => covar w (condExp w coarse (F p)) (condExp w coarse (F q)))
    (fun p q => expect w (condCov w coarse (F p) (F q)))
    (fun p q => split_bound w coarse hw (F p) (F q))
    C₁ C₂ m₁ m₂ hC₁ hC₂ hm₁ hB hC

end Finite

end YMGap
