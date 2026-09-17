import MaintenanceReproduction

namespace CollectiveAlignment

/-!
# Recurrent maintenance dynamics

`MaintenanceReproduction.lean` proves finite algebraic replacement/growth
conditions for a three-node maintenance cycle.  This module adds the missing
time index.

The construction is deliberately narrow.  We start the deterministic discrete-
time system at the canonical three-cycle witness and prove that, for nonnegative
self-retention and coupling coefficients, the order cone above that witness is
forward invariant whenever the closed-loop product threshold is met.  If the
canonical witness is strictly positive, the resulting trajectory is positive at
every time.

Thus the finite maintenance witness is promoted to an arbitrarily-late
availability statement:

    closed maintenance threshold + positivity/nonnegativity
        -> positive maintained trajectory at every time
        -> arbitrarily late maintenance availability.

This still does not imply novelty, external validation, or learning.  It only
supplies the recurrent-maintenance side of the interface used by the cumulative
accessibility stack.
-/

structure Cycle3State where
  a : ℝ
  b : ℝ
  c : ℝ

/-- One synchronous update of the three-node maintenance cycle. -/
def cycle3StateStep
    (rA rB rC kAB kBC kCA : ℝ)
    (x : Cycle3State) : Cycle3State :=
  { a := cycle3NextA rA kCA x.a x.c
    b := cycle3NextB rB kAB x.a x.b
    c := cycle3NextC rC kBC x.b x.c }

/-- The canonical state used by the finite three-cycle threshold theorem. -/
def cycle3CanonicalState
    (rB rC kAB kBC : ℝ) : Cycle3State :=
  { a := cycle3WitnessA rB rC
    b := cycle3WitnessB kAB rC
    c := cycle3WitnessC kAB kBC }

/-- Coordinatewise order relative to the canonical maintenance witness. -/
def cycle3AtOrAboveCanonical
    (rB rC kAB kBC : ℝ)
    (x : Cycle3State) : Prop :=
  cycle3WitnessA rB rC ≤ x.a ∧
  cycle3WitnessB kAB rC ≤ x.b ∧
  cycle3WitnessC kAB kBC ≤ x.c

/-- Strict positivity of all three maintained components. -/
def cycle3Positive (x : Cycle3State) : Prop :=
  0 < x.a ∧ 0 < x.b ∧ 0 < x.c

/-- The order cone above the canonical witness is forward invariant under a
nonnegative cycle update once the closed-loop product threshold is met. -/
theorem cycle3StateStep_preserves_canonical_lower_bound
    {rA rB rC kAB kBC kCA : ℝ}
    (hrA : 0 ≤ rA) (hrB : 0 ≤ rB) (hrC : 0 ≤ rC)
    (hkAB : 0 ≤ kAB) (hkBC : 0 ≤ kBC) (hkCA : 0 ≤ kCA)
    (hloop :
      maintenanceDeficit rA * maintenanceDeficit rB * maintenanceDeficit rC
        ≤ kAB * kBC * kCA)
    {x : Cycle3State}
    (hx : cycle3AtOrAboveCanonical rB rC kAB kBC x) :
    cycle3AtOrAboveCanonical rB rC kAB kBC
      (cycle3StateStep rA rB rC kAB kBC kCA x) := by
  rcases hx with ⟨hxA, hxB, hxC⟩
  have hcanon :
      cycle3WitnessA rB rC ≤
          cycle3NextA rA kCA
            (cycle3WitnessA rB rC) (cycle3WitnessC kAB kBC) ∧
      cycle3WitnessB kAB rC =
          cycle3NextB rB kAB
            (cycle3WitnessA rB rC) (cycle3WitnessB kAB rC) ∧
      cycle3WitnessC kAB kBC =
          cycle3NextC rC kBC
            (cycle3WitnessB kAB rC) (cycle3WitnessC kAB kBC) := by
    simpa using
      (cycle3_canonical_threshold_iff rA rB rC kAB kBC kCA).2 hloop
  change
    cycle3WitnessA rB rC ≤ cycle3NextA rA kCA x.a x.c ∧
    cycle3WitnessB kAB rC ≤ cycle3NextB rB kAB x.a x.b ∧
    cycle3WitnessC kAB kBC ≤ cycle3NextC rC kBC x.b x.c
  constructor
  · have hAself := mul_le_mul_of_nonneg_left hxA hrA
    have hAcross := mul_le_mul_of_nonneg_left hxC hkCA
    have hmono :
        cycle3NextA rA kCA
            (cycle3WitnessA rB rC) (cycle3WitnessC kAB kBC)
          ≤ cycle3NextA rA kCA x.a x.c := by
      unfold cycle3NextA
      linarith
    exact le_trans hcanon.1 hmono
  constructor
  · have hBself := mul_le_mul_of_nonneg_left hxB hrB
    have hBcross := mul_le_mul_of_nonneg_left hxA hkAB
    have hmono :
        cycle3NextB rB kAB
            (cycle3WitnessA rB rC) (cycle3WitnessB kAB rC)
          ≤ cycle3NextB rB kAB x.a x.b := by
      unfold cycle3NextB
      linarith
    calc
      cycle3WitnessB kAB rC =
          cycle3NextB rB kAB
            (cycle3WitnessA rB rC) (cycle3WitnessB kAB rC) := hcanon.2.1
      _ ≤ cycle3NextB rB kAB x.a x.b := hmono
  · have hCself := mul_le_mul_of_nonneg_left hxC hrC
    have hCcross := mul_le_mul_of_nonneg_left hxB hkBC
    have hmono :
        cycle3NextC rC kBC
            (cycle3WitnessB kAB rC) (cycle3WitnessC kAB kBC)
          ≤ cycle3NextC rC kBC x.b x.c := by
      unfold cycle3NextC
      linarith
    calc
      cycle3WitnessC kAB kBC =
          cycle3NextC rC kBC
            (cycle3WitnessB kAB rC) (cycle3WitnessC kAB kBC) := hcanon.2.2
      _ ≤ cycle3NextC rC kBC x.b x.c := hmono

/-- Deterministic trajectory started at the canonical maintenance witness. -/
def cycle3Trajectory
    (rA rB rC kAB kBC kCA : ℝ) : ℕ → Cycle3State
  | 0 => cycle3CanonicalState rB rC kAB kBC
  | n + 1 =>
      cycle3StateStep rA rB rC kAB kBC kCA
        (cycle3Trajectory rA rB rC kAB kBC kCA n)

/-- Every point on the canonical trajectory stays at or above the canonical
witness when the update is nonnegative and the loop meets replacement. -/
theorem cycle3Trajectory_stays_above_canonical
    {rA rB rC kAB kBC kCA : ℝ}
    (hrA : 0 ≤ rA) (hrB : 0 ≤ rB) (hrC : 0 ≤ rC)
    (hkAB : 0 ≤ kAB) (hkBC : 0 ≤ kBC) (hkCA : 0 ≤ kCA)
    (hloop :
      maintenanceDeficit rA * maintenanceDeficit rB * maintenanceDeficit rC
        ≤ kAB * kBC * kCA) :
    ∀ n : ℕ,
      cycle3AtOrAboveCanonical rB rC kAB kBC
        (cycle3Trajectory rA rB rC kAB kBC kCA n) := by
  intro n
  induction n with
  | zero =>
      change
        cycle3WitnessA rB rC ≤ cycle3WitnessA rB rC ∧
        cycle3WitnessB kAB rC ≤ cycle3WitnessB kAB rC ∧
        cycle3WitnessC kAB kBC ≤ cycle3WitnessC kAB kBC
      exact ⟨le_rfl, le_rfl, le_rfl⟩
  | succ n ih =>
      change cycle3AtOrAboveCanonical rB rC kAB kBC
        (cycle3StateStep rA rB rC kAB kBC kCA
          (cycle3Trajectory rA rB rC kAB kBC kCA n))
      exact cycle3StateStep_preserves_canonical_lower_bound
        hrA hrB hrC hkAB hkBC hkCA hloop ih

/-- Under the physically natural sign conditions and a strict closed-loop
threshold, the canonical trajectory is strictly positive at every time. -/
theorem cycle3_strict_loop_trajectory_positive
    {rA rB rC kAB kBC kCA : ℝ}
    (hrA : 0 ≤ rA) (hrB : 0 ≤ rB) (hrC : 0 ≤ rC)
    (hdA : 0 < maintenanceDeficit rA)
    (hdB : 0 < maintenanceDeficit rB)
    (hdC : 0 < maintenanceDeficit rC)
    (hkAB : 0 < kAB) (hkBC : 0 < kBC) (hkCA : 0 < kCA)
    (hloop :
      maintenanceDeficit rA * maintenanceDeficit rB * maintenanceDeficit rC
        < kAB * kBC * kCA) :
    ∀ n : ℕ,
      cycle3Positive (cycle3Trajectory rA rB rC kAB kBC kCA n) := by
  intro n
  have habove := cycle3Trajectory_stays_above_canonical
    hrA hrB hrC (le_of_lt hkAB) (le_of_lt hkBC) (le_of_lt hkCA)
    (le_of_lt hloop) n
  have hpositive := cycle3_canonical_witness_positive hdB hdC hkAB hkBC
  rcases habove with ⟨hA, hB, hC⟩
  rcases hpositive with ⟨hwA, hwB, hwC⟩
  exact ⟨lt_of_lt_of_le hwA hA, lt_of_lt_of_le hwB hB,
    lt_of_lt_of_le hwC hC⟩

/-- Concrete maintenance-availability predicate supplied by the trajectory. -/
def cycle3MaintenanceAvailable
    (rA rB rC kAB kBC kCA : ℝ)
    (n : ℕ) : Prop :=
  cycle3Positive (cycle3Trajectory rA rB rC kAB kBC kCA n)

/-- The strict three-cycle maintenance conditions imply arbitrarily late
maintenance availability.  In fact availability holds at every time, so each
requested horizon can choose itself as the witness time.

This theorem has exactly the recurrence shape needed by the accessibility-side
`RecurringOpportunity` interface, without claiming that maintenance by itself
creates novelty or corrects error. -/
theorem cycle3_strict_loop_has_arbitrarily_late_availability
    {rA rB rC kAB kBC kCA : ℝ}
    (hrA : 0 ≤ rA) (hrB : 0 ≤ rB) (hrC : 0 ≤ rC)
    (hdA : 0 < maintenanceDeficit rA)
    (hdB : 0 < maintenanceDeficit rB)
    (hdC : 0 < maintenanceDeficit rC)
    (hkAB : 0 < kAB) (hkBC : 0 < kBC) (hkCA : 0 < kCA)
    (hloop :
      maintenanceDeficit rA * maintenanceDeficit rB * maintenanceDeficit rC
        < kAB * kBC * kCA) :
    ∀ n : ℕ, ∃ m : ℕ,
      n ≤ m ∧ cycle3MaintenanceAvailable rA rB rC kAB kBC kCA m := by
  intro n
  refine ⟨n, le_rfl, ?_⟩
  exact cycle3_strict_loop_trajectory_positive
    hrA hrB hrC hdA hdB hdC hkAB hkBC hkCA hloop n

#print axioms cycle3StateStep_preserves_canonical_lower_bound
#print axioms cycle3Trajectory_stays_above_canonical
#print axioms cycle3_strict_loop_trajectory_positive
#print axioms cycle3_strict_loop_has_arbitrarily_late_availability

end CollectiveAlignment
