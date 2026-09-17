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

This file deliberately proves only the elementary product-threshold algebra
and explicit finite witnesses:

* exact dyadic loop threshold;
* exact three-agent loop threshold;
* an explicit witness where the closed triad is super-unit while every
  induced dyad is open-loop;
* the corresponding finite n-cycle product threshold;
* an explicit recurrent-module witness in which every simple two- and
  three-edge loop has product below one but the combined positive mode expands;
* an explicit acyclic three-node chain whose pure cross-maintenance operator
  vanishes after three steps.

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

section RecurrentModuleWitnesses

/-- A normalized three-process recurrent module with gain 3/5 on every
cross-edge and no self-loop. Written directly as a state update to avoid
claiming that the general matrix spectral theorem is formalized here. -/
def denseThreeStep
    (x : ℝ × ℝ × ℝ) : ℝ × ℝ × ℝ :=
  let a := x.1
  let b := x.2.1
  let c := x.2.2
  ((3/5 : ℝ) * b + (3/5 : ℝ) * c,
   (3/5 : ℝ) * a + (3/5 : ℝ) * c,
   (3/5 : ℝ) * a + (3/5 : ℝ) * b)

/-- Explicit witness that viability need not reside in one individually
super-unit simple cycle. Every two-edge loop has product (3/5)^2 < 1 and every
three-edge simple loop has product (3/5)^3 < 1, yet the combined recurrent
module expands the uniform positive state by the factor 6/5. -/
theorem subunit_simple_cycles_can_combine_into_expanding_module :
    (3/5 : ℝ)^2 < 1
      ∧
    (3/5 : ℝ)^3 < 1
      ∧
    denseThreeStep (1, 1, 1)
      = ((6/5 : ℝ), (6/5 : ℝ), (6/5 : ℝ)) := by
  constructor
  · norm_num
  constructor
  · norm_num
  · norm_num [denseThreeStep]

/-- A pure cross-maintenance chain A -> B -> C with no return edge. -/
def openChain3Step
    (kAB kBC : ℝ) (x : ℝ × ℝ × ℝ) : ℝ × ℝ × ℝ :=
  (0, kAB * x.1, kBC * x.2.1)

/-- In the three-node acyclic chain, cross-maintenance alone is nilpotent:
after three steps no contribution remains. This is a concrete finite witness
of the recurrence requirement; it is not a formal proof of the general DAG
nilpotence theorem. -/
theorem open_chain_three_steps_vanish
    (kAB kBC : ℝ) (x : ℝ × ℝ × ℝ) :
    openChain3Step kAB kBC
      (openChain3Step kAB kBC
        (openChain3Step kAB kBC x))
      = (0, 0, 0) := by
  rcases x with ⟨a, b, c⟩
  simp [openChain3Step]

end RecurrentModuleWitnesses

#print axioms dyadMaintenanceRatio_supercritical_iff
#print axioms dyad_open_loop_ratio_zero
#print axioms dyad_open_loop_not_supercritical
#print axioms triadMaintenanceRatio_supercritical_iff
#print axioms triad_open_loop_ratio_zero
#print axioms triad_supercritical_with_all_induced_dyads_open
#print axioms cycleDeficit_pos
#print axioms cycleMaintenanceRatio_supercritical_iff
#print axioms subunit_simple_cycles_can_combine_into_expanding_module
#print axioms open_chain_three_steps_vanish

end CollectiveAlignment
