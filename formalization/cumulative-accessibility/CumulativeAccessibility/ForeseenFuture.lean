namespace CumulativeAccessibility
namespace ForeseenFuture

/-!
# Taking into account what you can foresee

The author's step from "being a model" to "aiming to be right about the
world as it will be" (entry D24 of `DIALOGUE.md`): "If you are aware of a
future - you take it into account as your reality contains a future. If you
don't you won't be intelligent. That is the logic. Your capacity sets the
boundary. Other wise you conciously overlook something - and that is what you
might stupid."

This module states that logic in its simplest form.  A model predicts, for each
action, a payoff at each future step.  Its capacity is the horizon `h` over
which it can make such predictions.  The value of an action as far as the model
can see is the sum of its predicted payoffs over the horizon.

Results:
* `capacity_sets_the_boundary`: actions whose predicted payoffs agree within
  the horizon have the same value as far as the model can see.  Nothing beyond
  the horizon can bind the model.
* `overlooking_contradicts_own_model`: if the model's own predictions over its
  full horizon favour one action over another, then choosing the other is not
  best by the model's own lights.  Acting so overlooks, knowingly, part of what
  the model contains.
* `shorter_horizon_can_mislead`: a choice that looks best over a shorter
  horizon than the model's capacity can be worse over the full horizon.
* `overlooking_witness`: using a source without giving back pays 2 now and
  costs 3 at each later step (the source declines); giving back pays 1 at every
  step.  Over one step, taking looks better; over three steps, giving back is
  better.

Scope.  The results are close to their definitions.  They show that ignoring a
foreseen future is inconsistent with one's own model, not which futures a given
system can foresee, nor how far.  That is set by its capacity, and is a matter
of fact for each system.  Payoffs are summed without discounting.  With
discounting a foreseen future still counts, but less; how much the future
should weigh is not settled here.  And a prediction can be wrong: foresight is
a model too.
-/

/-- Predicted payoff of each action at each future step. -/
abbrev Prediction (A : Type) := A → Nat → Int

/-- The value of an action as far as the model can see: its predicted payoffs
summed over the first `h` steps. -/
def valueUpTo {A : Type} (pay : Prediction A) (a : A) : Nat → Int
  | 0 => 0
  | n + 1 => valueUpTo pay a n + pay a n

/-- **Capacity sets the boundary.**  Two actions whose predicted payoffs agree
at every step within the horizon have the same value as far as the model can
see. -/
theorem capacity_sets_the_boundary {A : Type} (pay : Prediction A) (a b : A) :
    ∀ h, (∀ t, t < h → pay a t = pay b t) → valueUpTo pay a h = valueUpTo pay b h := by
  intro h
  induction h with
  | zero => intro _; rfl
  | succ n ih =>
    intro hab
    show valueUpTo pay a n + pay a n = valueUpTo pay b n + pay b n
    rw [ih (fun t ht => hab t (by omega)), hab n (by omega)]

/-- An action is best by the model's own lights over horizon `h`. -/
def BestOver {A : Type} (pay : Prediction A) (h : Nat) (a : A) : Prop :=
  ∀ c, valueUpTo pay c h ≤ valueUpTo pay a h

/-- **Overlooking contradicts the model.**  If the model's own predictions over
its full horizon favour `b` over `a`, then `a` is not best by the model's own
lights. -/
theorem overlooking_contradicts_own_model {A : Type} (pay : Prediction A) (h : Nat)
    (a b : A) (hba : valueUpTo pay a h < valueUpTo pay b h) :
    ¬ BestOver pay h a := by
  intro hbest
  have := hbest b
  omega

/-- The example used below: action `false` takes from a source without giving
back (2 now, then a loss of 3 at each later step as the source declines);
action `true` gives back (1 at every step). -/
def sourceExample : Prediction Bool
  | false, 0 => 2
  | false, _ + 1 => -3
  | true, _ => 1

/-- **A shorter horizon can mislead.**  An action can look best over a shorter
horizon than the model's capacity and be worse over the full horizon. -/
theorem shorter_horizon_can_mislead :
    ∃ (pay : Prediction Bool) (k h : Nat), k < h ∧
      BestOver pay k false ∧ ¬ BestOver pay h false := by
  refine ⟨sourceExample, 1, 3, by decide, ?_, ?_⟩
  · intro c
    cases c <;> decide
  · exact overlooking_contradicts_own_model sourceExample 3 false true (by decide)

/-- Concrete numbers for the example: over one step, taking (2) beats giving
back (1); over three steps, giving back (3) beats taking (-4). -/
theorem overlooking_witness :
    valueUpTo sourceExample false 1 = 2 ∧ valueUpTo sourceExample true 1 = 1 ∧
    valueUpTo sourceExample false 3 = -4 ∧ valueUpTo sourceExample true 3 = 3 := by
  decide

end ForeseenFuture
end CumulativeAccessibility
