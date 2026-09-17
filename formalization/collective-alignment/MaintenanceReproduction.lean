import Mathlib.Tactic

namespace CollectiveAlignment

/-!
# Recurrent maintenance: machine-checked finite algebraic core

This file formalizes a narrow extension of the sufficient-alignment framework.
It deliberately does **not** formalize the full Perron--Frobenius / spectral-radius
threshold theorem for arbitrary nonnegative matrices. Instead it machine-checks
the exact finite algebra that motivates that interpretation:

1. autonomous maintenance deficits are `1 - r`;
2. a two-node closed maintenance loop has an exact product threshold for an
   explicit positive canonical witness;
3. a three-node directed cycle has an exact product threshold for an explicit
   positive canonical witness;
4. above the strict three-cycle threshold, that witness is componentwise
   nondecreasing after one update and strictly increases in at least one
   component;
5. deleting the return edge makes a positive subcritical source decline.

The broader statement that `rho ((I-R)⁻¹ K) > 1` characterizes local
supercriticality is classical external nonnegative-matrix theory and is kept
outside the machine-checked claim boundary here.
-/

section Definitions

/-- Autonomous maintenance deficit for one process. -/
def maintenanceDeficit (r : ℝ) : ℝ := 1 - r

/-- One-step update of node A in a two-node reciprocal maintenance loop. -/
def dyadNextA (rA kBA xA xB : ℝ) : ℝ :=
  rA * xA + kBA * xB

/-- One-step update of node B in a two-node reciprocal maintenance loop. -/
def dyadNextB (rB kAB xA xB : ℝ) : ℝ :=
  rB * xB + kAB * xA

/-- Canonical A-coordinate used to expose the exact dyad product threshold. -/
def dyadWitnessA (rB : ℝ) : ℝ := maintenanceDeficit rB

/-- Canonical B-coordinate used to expose the exact dyad product threshold. -/
def dyadWitnessB (kAB : ℝ) : ℝ := kAB

/-- One-step update of A in the directed cycle A -> B -> C -> A. -/
def cycle3NextA (rA kCA xA xC : ℝ) : ℝ :=
  rA * xA + kCA * xC

/-- One-step update of B in the directed cycle A -> B -> C -> A. -/
def cycle3NextB (rB kAB xA xB : ℝ) : ℝ :=
  rB * xB + kAB * xA

/-- One-step update of C in the directed cycle A -> B -> C -> A. -/
def cycle3NextC (rC kBC xB xC : ℝ) : ℝ :=
  rC * xC + kBC * xB

/-- Canonical A-coordinate for the three-cycle witness. -/
def cycle3WitnessA (rB rC : ℝ) : ℝ :=
  maintenanceDeficit rB * maintenanceDeficit rC

/-- Canonical B-coordinate for the three-cycle witness. -/
def cycle3WitnessB (kAB rC : ℝ) : ℝ :=
  kAB * maintenanceDeficit rC

/-- Canonical C-coordinate for the three-cycle witness. -/
def cycle3WitnessC (kAB kBC : ℝ) : ℝ :=
  kAB * kBC

end Definitions

section Dyad

/-- Exact canonical-witness form of the two-node maintenance threshold.
At the declared witness, B is exactly at replacement and A is at or above
replacement iff closed-loop gain covers the product of autonomous deficits. -/
theorem dyad_canonical_threshold_iff
    (rA rB kAB kBA : ℝ) :
    let xA := dyadWitnessA rB
    let xB := dyadWitnessB kAB
    (xA ≤ dyadNextA rA kBA xA xB ∧
      xB = dyadNextB rB kAB xA xB)
      ↔
    maintenanceDeficit rA * maintenanceDeficit rB ≤ kAB * kBA := by
  dsimp [dyadWitnessA, dyadWitnessB, dyadNextA, dyadNextB, maintenanceDeficit]
  constructor
  · rintro ⟨hA, hB⟩
    nlinarith
  · intro h
    constructor
    · nlinarith
    · ring

/-- Under positive autonomous deficits and positive A -> B gain, the canonical
dyad witness is strictly positive. -/
theorem dyad_canonical_witness_positive
    {rB kAB : ℝ}
    (hdB : 0 < maintenanceDeficit rB)
    (hkAB : 0 < kAB) :
    0 < dyadWitnessA rB ∧ 0 < dyadWitnessB kAB := by
  constructor
  · simpa [dyadWitnessA] using hdB
  · simpa [dyadWitnessB] using hkAB

end Dyad

section ThreeCycle

/-- Exact canonical-witness form of the three-node directed-cycle threshold.
B and C are exactly at replacement for the chosen witness. A is at or above
replacement exactly when the product of cycle gains covers the product of
all three autonomous deficits. -/
theorem cycle3_canonical_threshold_iff
    (rA rB rC kAB kBC kCA : ℝ) :
    let xA := cycle3WitnessA rB rC
    let xB := cycle3WitnessB kAB rC
    let xC := cycle3WitnessC kAB kBC
    (xA ≤ cycle3NextA rA kCA xA xC ∧
      xB = cycle3NextB rB kAB xA xB ∧
      xC = cycle3NextC rC kBC xB xC)
      ↔
    maintenanceDeficit rA * maintenanceDeficit rB * maintenanceDeficit rC
      ≤ kAB * kBC * kCA := by
  dsimp [cycle3WitnessA, cycle3WitnessB, cycle3WitnessC,
    cycle3NextA, cycle3NextB, cycle3NextC, maintenanceDeficit]
  constructor
  · rintro ⟨hA, hB, hC⟩
    nlinarith
  · intro h
    constructor
    · nlinarith
    constructor <;> ring

/-- If all autonomous deficits and the first two cycle gains are positive,
the canonical three-cycle witness has three strictly positive coordinates. -/
theorem cycle3_canonical_witness_positive
    {rB rC kAB kBC : ℝ}
    (hdB : 0 < maintenanceDeficit rB)
    (hdC : 0 < maintenanceDeficit rC)
    (hkAB : 0 < kAB)
    (hkBC : 0 < kBC) :
    0 < cycle3WitnessA rB rC ∧
    0 < cycle3WitnessB kAB rC ∧
    0 < cycle3WitnessC kAB kBC := by
  constructor
  · unfold cycle3WitnessA
    exact mul_pos hdB hdC
  constructor
  · unfold cycle3WitnessB
    exact mul_pos hkAB hdC
  · unfold cycle3WitnessC
    exact mul_pos hkAB hkBC

/-- Strict closed-loop gain gives a concrete positive state whose A component
strictly increases while B and C remain exactly at replacement after one
update. This is a finite algebraic witness of a genuinely three-edge return
loop; it is not a formalization of the general spectral-radius theorem. -/
theorem cycle3_strict_threshold_gives_growth_witness
    {rA rB rC kAB kBC kCA : ℝ}
    (hdB : 0 < maintenanceDeficit rB)
    (hdC : 0 < maintenanceDeficit rC)
    (hkAB : 0 < kAB)
    (hkBC : 0 < kBC)
    (hloop :
      maintenanceDeficit rA * maintenanceDeficit rB * maintenanceDeficit rC
        < kAB * kBC * kCA) :
    let xA := cycle3WitnessA rB rC
    let xB := cycle3WitnessB kAB rC
    let xC := cycle3WitnessC kAB kBC
    0 < xA ∧ 0 < xB ∧ 0 < xC ∧
    xA < cycle3NextA rA kCA xA xC ∧
    xB = cycle3NextB rB kAB xA xB ∧
    xC = cycle3NextC rC kBC xB xC := by
  dsimp [cycle3WitnessA, cycle3WitnessB, cycle3WitnessC,
    cycle3NextA, cycle3NextB, cycle3NextC, maintenanceDeficit] at *
  have hxA : 0 < (1 - rB) * (1 - rC) := mul_pos hdB hdC
  have hxB : 0 < kAB * (1 - rC) := mul_pos hkAB hdC
  have hxC : 0 < kAB * kBC := mul_pos hkAB hkBC
  refine ⟨hxA, hxB, hxC, ?_, ?_, ?_⟩
  · nlinarith
  · ring
  · ring

/-- If the return edge C -> A is deleted, a positive A with subcritical
autonomous retention (`rA < 1`) strictly declines on the next update,
regardless of C's current state. This is the narrow machine-checked form of
"breaking the return path breaks this three-cycle maintenance witness." -/
theorem deleting_return_edge_makes_source_decline
    {rA xA xC : ℝ}
    (hrA : rA < 1)
    (hxA : 0 < xA) :
    cycle3NextA rA 0 xA xC < xA := by
  unfold cycle3NextA
  nlinarith

end ThreeCycle

#print axioms dyad_canonical_threshold_iff
#print axioms dyad_canonical_witness_positive
#print axioms cycle3_canonical_threshold_iff
#print axioms cycle3_canonical_witness_positive
#print axioms cycle3_strict_threshold_gives_growth_witness
#print axioms deleting_return_edge_makes_source_decline

end CollectiveAlignment
