namespace CumulativeAccessibility
namespace ListeningCost

/-!
# The cost of listening, and feedback that misleads

`AdaptivePersistence` proves that a sealed configuration runs out of reserve in
some possible future, while one that follows reliable feedback persists.  The
second half assumes that the feedback is always right and that listening costs
nothing.  This file drops both assumptions and finds where listening pays.

Setting, in whole units per step, over a horizon of `T` steps.
* A configuration that fits the world at a step gains `f`; one that misfits
  loses `δ` (`f, δ ≥ 0`).
* A **sealed** configuration pays nothing to listen.  It misfits at the steps
  where the world is outside what it fits: `misses sealed T` of them.
* A **listener** pays `ℓ` every step to keep its feedback (sensors, reviewers,
  correction routes) and follows it.  It misfits only where the feedback
  misleads it: `misses heard T` of them.

Results:
* `total_eq`: a configuration's total over `T` steps is `T * f` minus
  `(f + δ)` for every misfit.
* `listening_pays_iff`: the listener does better exactly when the misfits it
  avoids are worth more than listening costs:
  `(misses sealed T - misses heard T) * (f + δ) > T * ℓ`.
* `misleading_feedback_does_not_pay`: if the feedback misleads at least as
  often as the world moves outside the sealed fit, listening never does better.
* `stable_world_favours_sealing`: while the world stays inside the sealed fit,
  any positive cost of listening makes listening worse.
* `unaffordable_listening_fails`: if listening costs more than fit gains, the
  listener exhausts any reserve, however good its feedback.
* `listening_cost_witness`: a changing world where listening pays, misleading
  feedback where it does not, and a stable world where sealing does better.

So the claim of step 4 holds where the world moves outside a fixed fit more
often, weighted by what misfit costs, than listening costs and the feedback
misleads.  In a world that can move anywhere and stay there
(`AdaptivePersistence.OpenWithDwell`), the sealed misfits grow without bound
along some course, while a listener's errors are bounded by the quality of its
feedback; the cost of listening is what the condition charges for it.  This is
SCAP's "affordable" and "faithful" made quantitative.  Not covered: feedback
whose errors depend on the world's course, delay, and a listener that chooses
how much to listen.  The results are close to arithmetic once the setting is
fixed; the substance is in the setting.
-/

/-- The gain at one step. -/
def gain (f δ : Int) (fit : Bool) : Int := if fit then f else -δ

/-- The total gain over `T` steps of a configuration that fits at the steps
where `fits` is true. -/
def total (f δ : Int) (fits : Nat → Bool) : Nat → Int
  | 0 => 0
  | T + 1 => total f δ fits T + gain f δ (fits T)

/-- The number of misfits in the first `T` steps. -/
def misses (fits : Nat → Bool) : Nat → Nat
  | 0 => 0
  | T + 1 => misses fits T + if fits T then 0 else 1

/-- A configuration's total is `T * f` minus `f + δ` for every misfit. -/
theorem total_eq (f δ : Int) (fits : Nat → Bool) :
    ∀ T, total f δ fits T = (T : Int) * f - (misses fits T : Int) * (f + δ) := by
  intro T
  induction T with
  | zero => simp [total, misses]
  | succ T ih =>
    show total f δ fits T + gain f δ (fits T) =
      ((T + 1 : Nat) : Int) * f - ((misses fits T + if fits T then 0 else 1 : Nat) : Int) * (f + δ)
    rw [ih]
    cases fits T <;> simp [gain] <;> push_cast <;> grind

/-- **When listening pays.**  The listener, paying `ℓ` per step and misfitting
where its feedback misleads, does better than the sealed configuration exactly
when the misfits it avoids are worth more than listening costs. -/
theorem listening_pays_iff (f δ ℓ : Int) (sealed heard : Nat → Bool) (T : Nat) :
    total f δ sealed T < total f δ heard T - (T : Int) * ℓ ↔
      (T : Int) * ℓ < ((misses sealed T : Int) - (misses heard T : Int)) * (f + δ) := by
  rw [total_eq, total_eq]
  have e : ((misses sealed T : Int) - (misses heard T : Int)) * (f + δ) =
      (misses sealed T : Int) * (f + δ) - (misses heard T : Int) * (f + δ) := by grind
  rw [e]
  omega

/-- **Misleading feedback does not pay.**  If the feedback misleads at least as
often as the world moves outside the sealed fit, listening at a nonnegative cost
never does better. -/
theorem misleading_feedback_does_not_pay {f δ ℓ : Int} (hfδ : 0 ≤ f + δ) (hℓ : 0 ≤ ℓ)
    {sealed heard : Nat → Bool} {T : Nat} (hmis : misses sealed T ≤ misses heard T) :
    total f δ heard T - (T : Int) * ℓ ≤ total f δ sealed T := by
  rw [total_eq, total_eq]
  have h1 : (misses sealed T : Int) * (f + δ) ≤ (misses heard T : Int) * (f + δ) :=
    Int.mul_le_mul_of_nonneg_right (by exact_mod_cast hmis) hfδ
  have h2 : 0 ≤ (T : Int) * ℓ := Int.mul_nonneg (by omega) hℓ
  omega

/-- **A stable world favours sealing.**  While the world stays inside the sealed
fit, any positive cost of listening makes listening do worse. -/
theorem stable_world_favours_sealing {f δ ℓ : Int} (hfδ : 0 ≤ f + δ) (hℓ : 0 < ℓ)
    {sealed heard : Nat → Bool} {T : Nat} (hT : 0 < T) (hstable : misses sealed T = 0) :
    total f δ heard T - (T : Int) * ℓ < total f δ sealed T := by
  rw [total_eq, total_eq, hstable]
  have h1 : 0 ≤ (misses heard T : Int) * (f + δ) := Int.mul_nonneg (by omega) hfδ
  have h2 : 0 < (T : Int) * ℓ := Int.mul_pos (by omega) hℓ
  simp only [Int.ofNat_zero, Int.zero_mul, Int.sub_zero]
  omega

/-- **Unaffordable listening fails.**  If listening costs more than fit gains,
the listener loses at least one unit per step even with perfect feedback, so
it exhausts any reserve `r0` within `r0 + 1` steps. -/
theorem unaffordable_listening_fails {f δ ℓ r0 : Int} (hfδ : 0 ≤ f + δ) (hcost : f < ℓ)
    (heard : Nat → Bool) :
    ∀ T : Nat, r0 < (T : Int) → r0 + (total f δ heard T - (T : Int) * ℓ) < 0 := by
  intro T hT
  rw [total_eq]
  have h1 : 0 ≤ (misses heard T : Int) * (f + δ) := Int.mul_nonneg (by omega) hfδ
  have h2 : (T : Int) * f + (T : Int) ≤ (T : Int) * ℓ := by
    have : (T : Int) * (f + 1) ≤ (T : Int) * ℓ := Int.mul_le_mul_of_nonneg_left (by omega) (by omega)
    have e : (T : Int) * (f + 1) = (T : Int) * f + (T : Int) := by grind
    omega
  omega

/-- Concrete cases over 10 steps, with fit worth 1, misfit costing 2 and
listening costing 1 per step.  The world leaves the sealed fit after step 6, so
the sealed configuration misfits 4 times: total `-2`.  A listener with perfect
feedback: total `0`, better.  A listener whose feedback misleads 4 times: total
`-12`, worse.  In a world that stays inside the sealed fit: sealed `10`,
listener `0`. -/
theorem listening_cost_witness :
    total 1 2 (fun t => decide (t < 6)) 10 = -2 ∧
      total 1 2 (fun _ => true) 10 - 10 * 1 = 0 ∧
      total 1 2 (fun t => decide (t % 5 < 3)) 10 - 10 * 1 = -12 ∧
      total 1 2 (fun _ => true) 10 = 10 := by
  decide

end ListeningCost
end CumulativeAccessibility
