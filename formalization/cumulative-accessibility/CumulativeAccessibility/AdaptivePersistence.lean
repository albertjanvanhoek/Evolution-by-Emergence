import CumulativeAccessibility.EndogenousBudgetBridge

namespace CumulativeAccessibility
namespace AdaptivePersistence

open RecursiveAccessibility

/-!
# Adaptive persistence: the bridge from fit to the ledger

Two results already exist separately.

* The **learning law** (`Anchored.Persistence` in the anchored-correctability
  package): under open change, a configuration that does not depend on the
  course of the world is in step in every possible future only if it rules
  nothing out, while a configuration that follows reliable feedback stays in
  step.  Its mathematics is about predicates over world states, so it is
  domain-free, although it sits in the intelligence package.
* The **ledger** (`EndogenousBudgetBridge`): an organization is viable exactly
  while its slack, uptake minus maintenance, is nonnegative.

Neither says that being out of step costs persistence.  This file joins them,
in domain-free terms, with no reciprocity premise.

Setting:

* `World` is the set of states the world can be in, and a course of the world is
  a sequence `τ : ℕ → World`.  `Fut` is the set of possible courses.
* A configuration's fit is `fits t w`: at time `t` it fits world state `w`.
  A **sealed** configuration's fit does not depend on the course of the world:
  `fits` is fixed in advance, and every state it fits lies inside a constraint
  `S` that rules something out.
* **Open change with dwell** (`OpenWithDwell`): the world can move to any state
  and stay there for any length of time.
* **Misfit is costly**: at a step where the configuration does not fit the
  current world state, its slack is at most `-δ`, with `δ > 0`.
* **Fit pays**: at a step where it fits, its slack is nonnegative.
* **The buffer**: the configuration holds a reserve that starts at `r0`, gains
  each step's slack and cannot exceed a capacity `cap` (`reserve`).  It persists
  while the reserve stays nonnegative.

Results:

* `sealed_configuration_does_not_persist`: a sealed configuration exhausts its
  reserve in some possible future.  The buffer sets how long; it cannot make
  sealing safe.
* `rigid_configuration_does_not_persist`: the special case of one fixed
  configuration that rules something out.
* `listening_configuration_persists`: a configuration that follows reliable
  feedback stays in step, so with fit paying its reserve never becomes negative.
* `sealed_configuration_fails_on_vortex_ledger` and
  `listening_persists_on_vortex_ledger`: the same two results stated on the
  vortex ledger's `InternalSlackAt`, with the world's course driving the
  gradient.
* `adaptive_persistence_witness`: one rule (slack `1` when fitting, `-1`
  otherwise) under which a sealed configuration runs out and a listening one
  persists along every course.

What this file does **not** show: that real systems pay for misfit in this way,
what feedback costs to maintain and what happens when it misleads (see
`ListeningCost`), or where
feedback comes from.  In the intelligence specialization, feedback arrives
through the correction network (`Anchored.Persistence.reality`).
-/

section Reserve

/-- The reserve of a configuration: it starts at `r0`, gains each step's slack,
and cannot exceed the capacity `cap`. -/
noncomputable def reserve (cap r0 : ℝ) (slack : ℕ → ℝ) : ℕ → ℝ
  | 0 => r0
  | t + 1 => min cap (reserve cap r0 slack t + slack t)

/-- The reserve never exceeds its capacity. -/
theorem reserve_le_cap {cap r0 : ℝ} {slack : ℕ → ℝ} (h0 : r0 ≤ cap) :
    ∀ t, reserve cap r0 slack t ≤ cap
  | 0 => by simp only [reserve]; exact h0
  | t + 1 => by simp only [reserve]; exact min_le_left _ _

/-- One step can raise the reserve by at most that step's slack. -/
theorem reserve_succ_le (cap r0 : ℝ) (slack : ℕ → ℝ) (t : ℕ) :
    reserve cap r0 slack (t + 1) ≤ reserve cap r0 slack t + slack t := by
  simp only [reserve]
  exact min_le_right _ _

/-- During a window in which every step costs at least `δ`, the reserve falls
by at least `δ` per step from at most its capacity. -/
theorem reserve_window_le {cap r0 δ : ℝ} {slack : ℕ → ℝ} (h0 : r0 ≤ cap)
    {t0 N : ℕ} (hdef : ∀ i, i < N → slack (t0 + i) ≤ -δ) :
    ∀ n, n ≤ N → reserve cap r0 slack (t0 + n) ≤ cap - (n : ℝ) * δ := by
  intro n
  induction n with
  | zero =>
      intro _
      have h := reserve_le_cap (slack := slack) h0 t0
      simpa using h
  | succ n ih =>
      intro hn
      have h1 := ih (by omega)
      have h2 := reserve_succ_le cap r0 slack (t0 + n)
      have h3 := hdef n (by omega)
      have e : t0 + (n + 1) = t0 + n + 1 := by omega
      have hring : ((n + 1 : ℕ) : ℝ) * δ = (n : ℝ) * δ + δ := by
        push_cast
        ring
      rw [e, hring]
      linarith

end Reserve

section Bridge

variable {World : Type*}

/-- Open change with dwell: the world can move to any state and stay there for
any length of time. -/
def OpenWithDwell (Fut : (ℕ → World) → Prop) : Prop :=
  ∀ (w : World) (N : ℕ), ∃ τ, Fut τ ∧ ∃ t0, ∀ i, i < N → τ (t0 + i) = w

/-- **A sealed configuration does not persist.**  Its fit is fixed in advance
and confined to a constraint `S` that rules out some world state `w`.  If the
world can stay at `w` for any length of time and misfit costs at least `δ > 0`
per step, then in some possible future the reserve becomes negative. -/
theorem sealed_configuration_does_not_persist
    (Fut : (ℕ → World) → Prop) (hopen : OpenWithDwell Fut)
    (fits : ℕ → World → Prop) (S : World → Prop)
    (hseal : ∀ t w, fits t w → S w) {w : World} (hw : ¬ S w)
    (slack : (ℕ → World) → ℕ → ℝ) {δ cap r0 : ℝ} (hδ : 0 < δ) (h0 : r0 ≤ cap)
    (hmisfit : ∀ τ t, ¬ fits t (τ t) → slack τ t ≤ -δ) :
    ∃ τ, Fut τ ∧ ∃ t, reserve cap r0 (slack τ) t < 0 := by
  obtain ⟨N, hN⟩ := exists_nat_gt (cap / δ)
  obtain ⟨τ, hτ, t0, hdwell⟩ := hopen w N
  refine ⟨τ, hτ, t0 + N, ?_⟩
  have hdef : ∀ i, i < N → slack τ (t0 + i) ≤ -δ := by
    intro i hi
    apply hmisfit
    intro hfit
    rw [hdwell i hi] at hfit
    exact hw (hseal _ _ hfit)
  have hwin := reserve_window_le (slack := slack τ) h0 hdef N (le_refl N)
  have hδne : δ ≠ 0 := ne_of_gt hδ
  have hkey : cap / δ * δ = cap := by
    field_simp
  have hlt : cap / δ * δ < (N : ℝ) * δ := mul_lt_mul_of_pos_right hN hδ
  linarith

/-- **A rigid configuration does not persist**: the special case of one fixed
configuration that rules some world state out. -/
theorem rigid_configuration_does_not_persist
    (Fut : (ℕ → World) → Prop) (hopen : OpenWithDwell Fut)
    (fits0 : World → Prop) (hinf : ∃ w, ¬ fits0 w)
    (slack : (ℕ → World) → ℕ → ℝ) {δ cap r0 : ℝ} (hδ : 0 < δ) (h0 : r0 ≤ cap)
    (hmisfit : ∀ τ t, ¬ fits0 (τ t) → slack τ t ≤ -δ) :
    ∃ τ, Fut τ ∧ ∃ t, reserve cap r0 (slack τ) t < 0 := by
  obtain ⟨w, hw⟩ := hinf
  exact sealed_configuration_does_not_persist Fut hopen (fun _ => fits0) fits0
    (fun _ _ h => h) hw slack hδ h0 hmisfit

/-- **A listening configuration persists.**  If the configuration fits whatever
the feedback admits, the feedback is reliable along the actual course of the
world, and fitting pays its way, then the reserve is never negative. -/
theorem listening_configuration_persists
    (τ : ℕ → World) (fits feedback : ℕ → World → Prop)
    (hfollows : ∀ t w, feedback t w → fits t w)
    (hreliable : ∀ t, feedback t (τ t))
    (slack : ℕ → ℝ) (hpays : ∀ t, fits t (τ t) → 0 ≤ slack t)
    {cap r0 : ℝ} (hr0 : 0 ≤ r0) (hcap : 0 ≤ cap) :
    ∀ t, 0 ≤ reserve cap r0 slack t := by
  intro t
  induction t with
  | zero =>
      simp only [reserve]
      exact hr0
  | succ t ih =>
      simp only [reserve]
      have hs := hpays t (hfollows t _ (hreliable t))
      exact le_min hcap (by linarith)

end Bridge

section VortexLedger

variable {World σ : Type*}

/-- The sealed result on the vortex ledger: the organization's state sequence is
fixed in advance, while the world's course drives the gradient.  If misfit
leaves internal slack at most `-δ`, the reserve runs out in some possible
future. -/
theorem sealed_configuration_fails_on_vortex_ledger
    (Fut : (ℕ → World) → Prop) (hopen : OpenWithDwell Fut)
    (fits : ℕ → World → Prop) (S : World → Prop)
    (hseal : ∀ t w, fits t w → S w) {w : World} (hw : ¬ S w)
    (state : ℕ → σ) (gradient : (ℕ → World) → GradientStream)
    (uptake : UptakeFunction σ) (maintenance : MaintenanceDemand σ)
    {δ cap r0 : ℝ} (hδ : 0 < δ) (h0 : r0 ≤ cap)
    (hmisfit : ∀ τ t, ¬ fits t (τ t) →
      InternalSlackAt state (gradient τ) uptake maintenance t ≤ -δ) :
    ∃ τ, Fut τ ∧ ∃ t,
      reserve cap r0 (InternalSlackAt state (gradient τ) uptake maintenance) t < 0 :=
  sealed_configuration_does_not_persist Fut hopen fits S hseal hw
    (fun τ => InternalSlackAt state (gradient τ) uptake maintenance) hδ h0 hmisfit

/-- The listening result on the vortex ledger: if fitting the current world
state makes the organization viable, a configuration that follows reliable
feedback keeps a nonnegative reserve. -/
theorem listening_persists_on_vortex_ledger
    (τ : ℕ → World) (fits feedback : ℕ → World → Prop)
    (hfollows : ∀ t w, feedback t w → fits t w)
    (hreliable : ∀ t, feedback t (τ t))
    (state : ℕ → σ) (gradient : GradientStream)
    (uptake : UptakeFunction σ) (maintenance : MaintenanceDemand σ)
    (hviable : ∀ t, fits t (τ t) →
      InternallyViableAt state gradient uptake maintenance t)
    {cap r0 : ℝ} (hr0 : 0 ≤ r0) (hcap : 0 ≤ cap) :
    ∀ t, 0 ≤ reserve cap r0 (InternalSlackAt state gradient uptake maintenance) t :=
  listening_configuration_persists τ fits feedback hfollows hreliable
    (InternalSlackAt state gradient uptake maintenance)
    (fun t h =>
      (internallyViableAt_iff_internalSlack_nonneg state gradient uptake maintenance t).mp
        (hviable t h))
    hr0 hcap

end VortexLedger

/-- **Non-vacuity.**  The world is `Bool`, every course is possible, and slack
is `1` when a configuration fits the current world state and `-1` otherwise.
The sealed configuration that only fits `true` runs out of reserve in some
course, while the configuration that fits whatever the world currently is
keeps a nonnegative reserve along every course. -/
theorem adaptive_persistence_witness :
    (∃ τ : ℕ → Bool, ∃ t,
      reserve 3 1 (fun t => if τ t = true then (1 : ℝ) else -1) t < 0) ∧
    (∀ τ : ℕ → Bool, ∀ t,
      0 ≤ reserve 3 1 (fun t => if τ t = τ t then (1 : ℝ) else -1) t) := by
  have hopen : OpenWithDwell (fun _ : ℕ → Bool => True) :=
    fun w _ => ⟨fun _ => w, trivial, 0, fun _ _ => rfl⟩
  constructor
  · obtain ⟨τ, _, t, ht⟩ :=
      rigid_configuration_does_not_persist (fun _ : ℕ → Bool => True) hopen
        (fun w => w = true) ⟨false, by decide⟩
        (fun τ t => if τ t = true then (1 : ℝ) else -1)
        (δ := 1) (cap := 3) (r0 := 1) one_pos (by norm_num)
        (fun τ t (h : ¬ τ t = true) => le_of_eq (if_neg h))
    exact ⟨τ, t, ht⟩
  · intro τ
    exact listening_configuration_persists τ (fun t w => w = τ t) (fun t w => w = τ t)
      (fun _ _ h => h) (fun _ => rfl)
      (fun t => if τ t = τ t then (1 : ℝ) else -1)
      (fun t _ => by simp)
      (by norm_num) (by norm_num)

#print axioms reserve_le_cap
#print axioms reserve_window_le
#print axioms sealed_configuration_does_not_persist
#print axioms rigid_configuration_does_not_persist
#print axioms listening_configuration_persists
#print axioms sealed_configuration_fails_on_vortex_ledger
#print axioms listening_persists_on_vortex_ledger
#print axioms adaptive_persistence_witness

end AdaptivePersistence
end CumulativeAccessibility
