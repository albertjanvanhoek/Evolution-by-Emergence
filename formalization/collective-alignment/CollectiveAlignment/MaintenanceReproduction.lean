import Mathlib.Tactic
import Mathlib.Algebra.BigOperators.Field

open scoped BigOperators

namespace CollectiveAlignment

/-!
# Maintenance reproduction in networks of subcritical learners

This file formalizes the elementary algebraic core behind the proposed
maintenance-reproduction interpretation of sufficient alignment.

The intended model is a network of learning/corrective processes. Process i
retains a fraction r_i of its usable corrective capacity autonomously, with
r_i < 1 in the subcritical case. Directed cross-maintenance gains k_ij can
close return loops that compensate those autonomous deficits.

This file deliberately proves only the elementary product-threshold algebra:

* exact dyadic loop threshold;
* exact three-agent loop threshold;
* an explicit witness where the closed triad is super-unit while every
  induced dyad is open-loop;
* the corresponding finite n-cycle product threshold.

The general equivalence between a nonnegative network system

    x(t+1) = (R + K) x(t)

and a normalized next-generation / maintenance matrix threshold expressed by
its spectral radius is classical Perron--Frobenius / M-matrix mathematics and
is not re-proved here. In particular, this file does not claim to machine-check
the full arbitrary-network spectral-radius theorem.
-/

section Dyad

/-- Normalized maintenance reproduction ratio for a two-process return loop.
The numerator is the closed cross-maintenance gain; the denominator is the
product of the two autonomous maintenance deficits. -/
def dyadMaintenanceRatio
    (rA rB kAB kBA : ℝ) : ℝ :=
  (kAB * kBA) / ((1 - rA) * (1 - rB))

/-- Exact dyadic product threshold when both autonomous retention factors are
strictly below one. -/
theorem dyadMaintenanceRatio_supercritical_iff
    {rA rB kAB kBA : ℝ}
    (hrA : rA < 1) (hrB : rB < 1) :
    1 < dyadMaintenanceRatio rA rB kAB kBA
      ↔
    (1 - rA) * (1 - rB) < kAB * kBA := by
  have hA : 0 < 1 - rA := sub_pos.mpr hrA
  have hB : 0 < 1 - rB := sub_pos.mpr hrB
  have hden : 0 < (1 - rA) * (1 - rB) := mul_pos hA hB
  unfold dyadMaintenanceRatio
  constructor
  · intro h
    have hm := (lt_div_iff₀ hden).1 h
    simpa using hm
  · intro h
    apply (lt_div_iff₀ hden).2
    simpa using h

/-- If one direction of a dyadic return loop is absent, the normalized loop
reproduction ratio is zero. -/
theorem dyad_open_loop_ratio_zero
    (rA rB kAB : ℝ) :
    dyadMaintenanceRatio rA rB kAB 0 = 0 := by
  simp [dyadMaintenanceRatio]

/-- An open dyadic loop is never super-unit in this normalized loop model. -/
theorem dyad_open_loop_not_supercritical
    (rA rB kAB : ℝ) :
    ¬ 1 < dyadMaintenanceRatio rA rB kAB 0 := by
  simp [dyadMaintenanceRatio]

end Dyad

section Triad

/-- Normalized maintenance reproduction ratio for the directed cycle
A -> B -> C -> A. -/
def triadMaintenanceRatio
    (rA rB rC kAB kBC kCA : ℝ) : ℝ :=
  (kAB * kBC * kCA) /
    ((1 - rA) * (1 - rB) * (1 - rC))

/-- Exact three-process product threshold when all three autonomous retention
factors are strictly below one. -/
theorem triadMaintenanceRatio_supercritical_iff
    {rA rB rC kAB kBC kCA : ℝ}
    (hrA : rA < 1) (hrB : rB < 1) (hrC : rC < 1) :
    1 < triadMaintenanceRatio rA rB rC kAB kBC kCA
      ↔
    (1 - rA) * (1 - rB) * (1 - rC)
      < kAB * kBC * kCA := by
  have hA : 0 < 1 - rA := sub_pos.mpr hrA
  have hB : 0 < 1 - rB := sub_pos.mpr hrB
  have hC : 0 < 1 - rC := sub_pos.mpr hrC
  have hAB : 0 < (1 - rA) * (1 - rB) := mul_pos hA hB
  have hden : 0 < (1 - rA) * (1 - rB) * (1 - rC) := mul_pos hAB hC
  unfold triadMaintenanceRatio
  constructor
  · intro h
    have hm := (lt_div_iff₀ hden).1 h
    simpa using hm
  · intro h
    apply (lt_div_iff₀ hden).2
    simpa using h

/-- Breaking any one edge of the simple three-process cycle collapses its
normalized closed-loop reproduction ratio to zero. -/
theorem triad_open_loop_ratio_zero
    (rA rB rC kAB kBC : ℝ) :
    triadMaintenanceRatio rA rB rC kAB kBC 0 = 0 := by
  simp [triadMaintenanceRatio]

/-- Exact witness used in the accompanying note: the full directed triad is
super-unit even though every induced two-node subsystem has only a one-way
edge and therefore no closed dyadic maintenance loop. -/
theorem triad_supercritical_with_all_induced_dyads_open :
    1 < triadMaintenanceRatio
          (7/10 : ℝ) (3/5 : ℝ) (1/2 : ℝ)
          (1/2 : ℝ) (1/2 : ℝ) (3/10 : ℝ)
      ∧
    ¬ 1 < dyadMaintenanceRatio
          (7/10 : ℝ) (3/5 : ℝ) (1/2 : ℝ) 0
      ∧
    ¬ 1 < dyadMaintenanceRatio
          (3/5 : ℝ) (1/2 : ℝ) (1/2 : ℝ) 0
      ∧
    ¬ 1 < dyadMaintenanceRatio
          (1/2 : ℝ) (7/10 : ℝ) (3/10 : ℝ) 0 := by
  norm_num [triadMaintenanceRatio, dyadMaintenanceRatio]

end Triad

section FiniteCycle

variable {ι : Type*} [Fintype ι]

/-- Product of directed cross-maintenance gains around a declared finite
cycle. -/
def cycleCrossGain (k : ι → ℝ) : ℝ :=
  ∏ i, k i

/-- Product of autonomous maintenance deficits around the same declared
finite cycle. -/
def cycleDeficit (r : ι → ℝ) : ℝ :=
  ∏ i, (1 - r i)

/-- Normalized reproduction ratio for a declared finite directed cycle. -/
def cycleMaintenanceRatio (r k : ι → ℝ) : ℝ :=
  cycleCrossGain k / cycleDeficit r

/-- If every autonomous retention factor is below one, the product of
maintenance deficits is strictly positive. -/
theorem cycleDeficit_pos
    (r : ι → ℝ) (hr : ∀ i, r i < 1) :
    0 < cycleDeficit r := by
  classical
  unfold cycleDeficit
  apply Finset.prod_pos
  intro i hi
  exact sub_pos.mpr (hr i)

/-- Exact finite-cycle product threshold. This theorem machine-checks the
algebraic part of the n-cycle criterion; connecting this ratio to the Perron
root of an arbitrary network is explicitly outside the scope of this file. -/
theorem cycleMaintenanceRatio_supercritical_iff
    (r k : ι → ℝ) (hr : ∀ i, r i < 1) :
    1 < cycleMaintenanceRatio r k
      ↔
    cycleDeficit r < cycleCrossGain k := by
  have hden : 0 < cycleDeficit r := cycleDeficit_pos r hr
  unfold cycleMaintenanceRatio
  constructor
  · intro h
    have hm := (lt_div_iff₀ hden).1 h
    simpa using hm
  · intro h
    apply (lt_div_iff₀ hden).2
    simpa using h

end FiniteCycle

#print axioms dyadMaintenanceRatio_supercritical_iff
#print axioms dyad_open_loop_ratio_zero
#print axioms dyad_open_loop_not_supercritical
#print axioms triadMaintenanceRatio_supercritical_iff
#print axioms triad_open_loop_ratio_zero
#print axioms triad_supercritical_with_all_induced_dyads_open
#print axioms cycleDeficit_pos
#print axioms cycleMaintenanceRatio_supercritical_iff

end CollectiveAlignment
