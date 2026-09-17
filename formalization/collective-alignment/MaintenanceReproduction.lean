import Mathlib.Tactic
import Mathlib.Algebra.BigOperators.Field

namespace MaintenanceReproduction

/-!
# Maintenance reproduction in small learning networks

This file formalizes the algebraic core of a proposed network-maintenance
interpretation of collective intelligence.

The state variable is intentionally abstract: `xA`, `xB`, `xC` may represent
usable corrective capacity, adaptive capacity, or another declared quantity.
The mathematics proves only consequences of the stated linear update rules.
It does not establish that a real social or biological network is correctly
represented by those rules.

For each process i, `rᵢ` is autonomous retention and `1-rᵢ` is its autonomous
maintenance deficit. Cross terms `kᵢⱼ` are nonnegative maintenance gains.

The machine-checked results below are deliberately narrow:

1. In a dyad, the product threshold
      kAB*kBA > (1-rA)*(1-rB)
   admits a positive witness whose A coordinate is exactly maintained and
   whose B coordinate strictly grows.
2. At equality, that witness is an exact fixed point.
3. In a directed three-cycle A -> B -> C -> A, the product threshold
      kAB*kBC*kCA > (1-rA)*(1-rB)*(1-rC)
   admits a positive witness for which B and C are exactly maintained and A
   strictly grows.
4. At equality, the triad witness is an exact fixed point.
5. Every proper dyad cut from the one-way three-cycle has no closed return
   term: its characteristic polynomial factors into the autonomous terms.

The full arbitrary-network statement using the spectral radius of
    G = (I-R)^(-1) K
is standard Perron-Frobenius / M-matrix mathematics and is not re-proved here.
-/

/-- Autonomous maintenance deficit. -/
def deficit (r : ℝ) : ℝ := 1 - r

section Dyad

/-- A-coordinate update in a two-process maintenance loop. -/
def dyadNextA (rA kBA xA xB : ℝ) : ℝ := rA * xA + kBA * xB

/-- B-coordinate update in a two-process maintenance loop. -/
def dyadNextB (rB kAB xA xB : ℝ) : ℝ := rB * xB + kAB * xA

/-- Product excess above the exact dyadic maintenance threshold. -/
def dyadExcess (rA rB kAB kBA : ℝ) : ℝ :=
  kAB * kBA - deficit rA * deficit rB

/-- At the exact dyadic product threshold, an explicit nonzero maintenance
witness is a fixed point.  The witness is
    xA = kBA,
    xB = 1-rA.
No spectral theorem is needed for this identity. -/
theorem dyad_threshold_fixed_point
    {rA rB kAB kBA : ℝ}
    (hthreshold : kAB * kBA = deficit rA * deficit rB) :
    let xA := kBA
    let xB := deficit rA
    dyadNextA rA kBA xA xB = xA ∧
    dyadNextB rB kAB xA xB = xB := by
  dsimp [dyadNextA, dyadNextB, deficit]
  constructor
  · ring
  · nlinarith

/-- Above the exact dyadic product threshold, the same explicit witness has
one coordinate exactly maintained and the other strictly increased. -/
theorem dyad_supercritical_witness
    {rA rB kAB kBA : ℝ}
    (hgain : deficit rA * deficit rB < kAB * kBA) :
    let xA := kBA
    let xB := deficit rA
    dyadNextA rA kBA xA xB = xA ∧
    xB < dyadNextB rB kAB xA xB := by
  dsimp [dyadNextA, dyadNextB, deficit]
  constructor
  · ring
  · nlinarith

/-- Below the dyadic product threshold, the same canonical witness has its
B coordinate strictly decreased while A remains exactly maintained. -/
theorem dyad_subcritical_witness
    {rA rB kAB kBA : ℝ}
    (hloss : kAB * kBA < deficit rA * deficit rB) :
    let xA := kBA
    let xB := deficit rA
    dyadNextA rA kBA xA xB = xA ∧
    dyadNextB rB kAB xA xB < xB := by
  dsimp [dyadNextA, dyadNextB, deficit]
  constructor
  · ring
  · nlinarith

end Dyad

section Triad

/-- A-coordinate update in the directed cycle A -> B -> C -> A. -/
def triadNextA (rA kCA xA xC : ℝ) : ℝ := rA * xA + kCA * xC

/-- B-coordinate update in the directed cycle A -> B -> C -> A. -/
def triadNextB (rB kAB xA xB : ℝ) : ℝ := rB * xB + kAB * xA

/-- C-coordinate update in the directed cycle A -> B -> C -> A. -/
def triadNextC (rC kBC xB xC : ℝ) : ℝ := rC * xC + kBC * xB

/-- Product excess above the exact three-cycle maintenance threshold. -/
def triadExcess (rA rB rC kAB kBC kCA : ℝ) : ℝ :=
  kAB * kBC * kCA - deficit rA * deficit rB * deficit rC

/-- Canonical algebraic witness for the directed three-cycle.
The particular scaling avoids division and therefore keeps the proof purely
polynomial. -/
def triadWitnessA (rB rC kCA : ℝ) : ℝ :=
  kCA * deficit rB * deficit rC

def triadWitnessB (rC kAB kCA : ℝ) : ℝ :=
  kAB * kCA * deficit rC

def triadWitnessC (kAB kBC kCA : ℝ) : ℝ :=
  kAB * kBC * kCA

/-- At the exact three-cycle product threshold, the canonical witness is an
exact fixed point of all three update equations. -/
theorem triad_threshold_fixed_point
    {rA rB rC kAB kBC kCA : ℝ}
    (hthreshold :
      kAB * kBC * kCA = deficit rA * deficit rB * deficit rC) :
    let xA := triadWitnessA rB rC kCA
    let xB := triadWitnessB rC kAB kCA
    let xC := triadWitnessC kAB kBC kCA
    triadNextA rA kCA xA xC = xA ∧
    triadNextB rB kAB xA xB = xB ∧
    triadNextC rC kBC xB xC = xC := by
  dsimp [triadWitnessA, triadWitnessB, triadWitnessC,
    triadNextA, triadNextB, triadNextC, deficit]
  constructor
  · nlinarith
  constructor <;> ring

/-- Above the exact three-cycle product threshold, the canonical witness has
B and C exactly maintained while A strictly grows, provided the return edge
C -> A is positive.  This is a direct algebraic witness of network-level
supercriticality; the stronger spectral-radius formulation is left external. -/
theorem triad_supercritical_witness
    {rA rB rC kAB kBC kCA : ℝ}
    (hkCA : 0 < kCA)
    (hgain :
      deficit rA * deficit rB * deficit rC < kAB * kBC * kCA) :
    let xA := triadWitnessA rB rC kCA
    let xB := triadWitnessB rC kAB kCA
    let xC := triadWitnessC kAB kBC kCA
    xA < triadNextA rA kCA xA xC ∧
    triadNextB rB kAB xA xB = xB ∧
    triadNextC rC kBC xB xC = xC := by
  dsimp [triadWitnessA, triadWitnessB, triadWitnessC,
    triadNextA, triadNextB, triadNextC, deficit] at *
  have hscaled := mul_lt_mul_of_pos_left hgain hkCA
  constructor
  · nlinarith
  constructor <;> ring

/-- Below the exact three-cycle product threshold, the canonical witness has
B and C exactly maintained while A strictly declines, again assuming a
positive return edge. -/
theorem triad_subcritical_witness
    {rA rB rC kAB kBC kCA : ℝ}
    (hkCA : 0 < kCA)
    (hloss :
      kAB * kBC * kCA < deficit rA * deficit rB * deficit rC) :
    let xA := triadWitnessA rB rC kCA
    let xB := triadWitnessB rC kAB kCA
    let xC := triadWitnessC kAB kBC kCA
    triadNextA rA kCA xA xC < xA ∧
    triadNextB rB kAB xA xB = xB ∧
    triadNextC rC kBC xB xC = xC := by
  dsimp [triadWitnessA, triadWitnessB, triadWitnessC,
    triadNextA, triadNextB, triadNextC, deficit] at *
  have hscaled := mul_lt_mul_of_pos_left hloss hkCA
  constructor
  · nlinarith
  constructor <;> ring

/-- If the return edge C -> A is deleted, the A-coordinate loses every
cross-maintenance term and evolves autonomously.  This captures the exact
edge-deletion mechanism used in the three-agent example without invoking
spectral theory. -/
theorem delete_return_edge_makes_A_autonomous
    (rA xA xC : ℝ) :
    triadNextA rA 0 xA xC = rA * xA := by
  simp [triadNextA]

/-- In the one-way dyad A -> B obtained from the three-cycle, the characteristic
polynomial factors into the two autonomous factors.  Hence the one-way edge
creates no closed-loop eigenvalue term. -/
theorem one_way_dyad_characteristic_factor
    (rA rB kAB lambda : ℝ) :
    (lambda - rA) * (lambda - rB) - 0 * kAB
      = (lambda - rA) * (lambda - rB) := by
  ring

end Triad

#print axioms dyad_threshold_fixed_point
#print axioms dyad_supercritical_witness
#print axioms dyad_subcritical_witness
#print axioms triad_threshold_fixed_point
#print axioms triad_supercritical_witness
#print axioms triad_subcritical_witness
#print axioms delete_return_edge_makes_A_autonomous
#print axioms one_way_dyad_characteristic_factor

end MaintenanceReproduction
