namespace CumulativeAccessibility
namespace ExistenceLemmas

/-!
# Two first steps toward the existence conjecture

Entry D16 of `DIALOGUE.md` adopts the maintenance-and-response conjecture of
research report 1 (`research/existence/`): an organization keeps a function
going through declared disturbances only if the responses it can deploy in
time keep every indispensable resource above its floor, using a policy that
sees only what it can observe.  The report named two lemmas that can be proved
now.  This module proves both in their simplest form.

**The deficit window.**  A buffer starts at reserve `R` and changes by a net
flow each step.  A response takes effect only after a lag `d`; before that the
net flow is at most `-μ` per step.

* `buffer_drop_before_response`: after `d` steps the buffer is at most
  `R - d·μ`.
* `late_response_cannot_save`: if `d·μ > R`, the buffer is below zero at step
  `d`, whatever happens afterwards.
* `after_lag_irrelevant`: two flows that agree before the lag give the same
  buffer up to the lag, so no quality of response after the lag changes it.
  Timing is a condition of its own, not a matter of quality.

**Indistinguishability.**  A policy chooses an action at time `t` from what it
has observed up to `t`.

* `same_observations_same_action`: two courses of the world that look the same
  up to `t` get the same action at `t`.
* `no_policy_safe_for_both`: if those two courses need disjoint actions at `t`
  to stay safe, no observation-based policy is safe on both.  More sensing, or
  a reserve that covers the wrong guess, is then required.
* `existence_lemmas_witness`: concrete numbers.

Not covered: several resources at once, stochastic flows, partial responses
before the lag, and the link to the repository's other ledgers.  These results
are close to arithmetic; they fix two conditions the conjecture must respect.
-/

/-- The buffer after `t` steps, from reserve `R` and net flow `net`. -/
def buffer (R : Int) (net : Nat → Int) : Nat → Int
  | 0 => R
  | t + 1 => buffer R net t + net t

/-- If the net flow is at most `-μ` in every step before `d`, then after `d`
steps the buffer is at most `R - d·μ`. -/
theorem buffer_drop_before_response (R μ : Int) (net : Nat → Int) :
    ∀ d : Nat, (∀ t, t < d → net t ≤ -μ) → buffer R net d ≤ R - (d : Int) * μ := by
  intro d
  induction d with
  | zero => intro _; simp [buffer]
  | succ n ih =>
    intro h
    have h1 := ih (fun t ht => h t (by omega))
    have h2 := h n (by omega)
    have h3 : ((n + 1 : Nat) : Int) * μ = (n : Int) * μ + μ := by
      rw [Int.natCast_add, Int.add_mul]; simp
    simp only [buffer]
    rw [h3]
    generalize (n : Int) * μ = a at h1 ⊢
    omega

/-- A response that comes too late cannot save the buffer: if the shortfall
before the lag exceeds the reserve, the buffer is below zero at the lag. -/
theorem late_response_cannot_save (R μ : Int) (net : Nat → Int) (d : Nat)
    (h : ∀ t, t < d → net t ≤ -μ) (hlate : R < (d : Int) * μ) :
    buffer R net d < 0 := by
  have := buffer_drop_before_response R μ net d h
  generalize (d : Int) * μ = a at this hlate
  omega

/-- Two flows that agree before the lag give the same buffer up to the lag. -/
theorem after_lag_irrelevant (R : Int) (net net' : Nat → Int) :
    ∀ d : Nat, (∀ t, t < d → net t = net' t) → buffer R net d = buffer R net' d := by
  intro d
  induction d with
  | zero => intro _; rfl
  | succ n ih =>
    intro h
    simp only [buffer]
    rw [ih (fun t ht => h t (by omega)), h n (by omega)]

/-- What a policy has seen up to time `t`. -/
def seen {O : Type} (obs : Nat → O) (t : Nat) : Fin (t + 1) → O :=
  fun i => obs i.val

/-- The action of an observation-based policy at time `t`. -/
def act {O A : Type} (p : (t : Nat) → (Fin (t + 1) → O) → A)
    (obs : Nat → O) (t : Nat) : A :=
  p t (seen obs t)

/-- Two courses that look the same up to `t` get the same action at `t`. -/
theorem same_observations_same_action {O A : Type}
    (p : (t : Nat) → (Fin (t + 1) → O) → A) (o1 o2 : Nat → O) (t : Nat)
    (h : ∀ s, s ≤ t → o1 s = o2 s) : act p o1 t = act p o2 t := by
  unfold act
  have : seen o1 t = seen o2 t := by
    funext i
    exact h i.val (by have := i.isLt; omega)
  rw [this]

/-- If two indistinguishable courses need disjoint actions at `t` to stay
safe, no observation-based policy is safe on both. -/
theorem no_policy_safe_for_both {O A : Type}
    (p : (t : Nat) → (Fin (t + 1) → O) → A) (o1 o2 : Nat → O) (t : Nat)
    (good1 good2 : A → Prop)
    (h : ∀ s, s ≤ t → o1 s = o2 s) (disjoint : ∀ a, ¬ (good1 a ∧ good2 a)) :
    ¬ (good1 (act p o1 t) ∧ good2 (act p o2 t)) := by
  rw [same_observations_same_action p o1 o2 t h]
  exact disjoint _

/-- Concrete numbers: a reserve of 5 with a loss of 2 per step and a lag of 3
is below zero at the lag; with a lag of 2 it is not forced below zero. -/
theorem existence_lemmas_witness :
    buffer 5 (fun _ => -2) 3 < 0 ∧ 0 ≤ buffer 5 (fun _ => -2) 2 := by
  decide

end ExistenceLemmas
end CumulativeAccessibility
