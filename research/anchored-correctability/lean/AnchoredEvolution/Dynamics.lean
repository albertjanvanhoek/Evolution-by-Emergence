import AnchoredEvolution.Composition

/-!
# Layer 4: correctability through time

A system changes: routes are restricted, participants are excluded, and access
is restored.  Which changes keep the system correctable?

* **Characterization.**  Suppose the system is correctable now.  After a
  change, it is still correctable *if and only if* every old correction route
  remains realizable, directly or by a detour.
* **Legitimate restriction.**  A restriction or exclusion is legitimate exactly
  when correction can route around it.
* **Restoration.**  Adding routes is always safe.
* **Invariance.**  A trajectory of legitimate restrictions and restorations
  stays correctable forever.
* **Self-sealing.**  A change that removes all outgoing correction of a model
  that has a peer breaks correctability.  This is the formal version of an
  "unappealable exclusion".
-/

universe u

namespace Anchored

section Dynamics

variable {α : Type u}

/-- Every old correction route stays realizable in the new graph, possibly by
a detour. -/
def LegitimateRestriction (E₁ E₂ : α → α → Prop) : Prop :=
  ∀ a b, E₁ a b → Reach E₂ a b

/-- Restoration adds routes and removes none. -/
def Restoration (E₁ E₂ : α → α → Prop) : Prop :=
  ∀ a b, E₁ a b → E₂ a b

/-- The allowed transitions of a learning system. -/
inductive Allowed (E₁ E₂ : α → α → Prop) : Prop
  | restrict : LegitimateRestriction E₁ E₂ → Allowed E₁ E₂
  | restore : Restoration E₁ E₂ → Allowed E₁ E₂

theorem legitimate_preserves {E₁ E₂ : α → α → Prop}
    (h : LegitimateRestriction E₁ E₂) (hsc : StronglyConnected E₁) :
    StronglyConnected E₂ :=
  fun a b => Reach.simulate h (hsc a b)

theorem restoration_preserves {E₁ E₂ : α → α → Prop}
    (h : Restoration E₁ E₂) (hsc : StronglyConnected E₁) :
    StronglyConnected E₂ :=
  legitimate_preserves (fun a b e => Reach.single (h a b e)) hsc

theorem allowed_preserves {E₁ E₂ : α → α → Prop}
    (h : Allowed E₁ E₂) (hsc : StronglyConnected E₁) : StronglyConnected E₂ := by
  cases h with
  | restrict hr => exact legitimate_preserves hr hsc
  | restore hr => exact restoration_preserves hr hsc

/-- **Characterization.**  For a system that is correctable now, the changed
system is correctable exactly when the change is a legitimate restriction:
every old route survives, directly or by detour. -/
theorem correctable_after_iff_legitimate {E₁ E₂ : α → α → Prop}
    (hsc : StronglyConnected E₁) :
    StronglyConnected E₂ ↔ LegitimateRestriction E₁ E₂ :=
  ⟨fun h2 a b _ => h2 a b, fun hl => legitimate_preserves hl hsc⟩

/-- **Invariance through time.**  A system that starts correctable and changes
only by allowed transitions is correctable at every time. -/
theorem trajectory_correctable (E : Nat → α → α → Prop)
    (h0 : StronglyConnected (E 0))
    (hstep : ∀ t, Allowed (E t) (E (t + 1))) :
    ∀ t, StronglyConnected (E t) := by
  intro t
  induction t with
  | zero => exact h0
  | succ t ih => exact allowed_preserves (hstep t) ih

/-- **Self-sealing breaks correctability.**  If a change leaves a model with no
outgoing correction route while it has a peer, the system is no longer
correctable. -/
theorem sealing_breaks {E : α → α → Prop} {a b : α} (hab : a ≠ b)
    (hseal : ∀ c, ¬ E a c) : ¬ StronglyConnected E := by
  intro hsc
  obtain ⟨c, hc⟩ := sc_every_model_sends hsc hab
  exact hseal c hc

/-- Isolation from correction (no incoming route) also breaks it. -/
theorem isolation_breaks {E : α → α → Prop} {a b : α} (hab : a ≠ b)
    (hiso : ∀ c, ¬ E c a) : ¬ StronglyConnected E := by
  intro hsc
  obtain ⟨c, hc⟩ := sc_every_model_receives hsc hab
  exact hiso c hc

/-- **An exclusion with a detour is legitimate.**  Removing the single direct
route `x → y` is legitimate when some other route from `x` to `y` survives.
Exclusion is allowed; exclusion from all correction is not. -/
theorem exclusion_with_detour_legitimate [DecidableEq α] {E : α → α → Prop} {x y : α}
    (hdet : Reach (fun a b => E a b ∧ ¬ (a = x ∧ b = y)) x y) :
    LegitimateRestriction E (fun a b => E a b ∧ ¬ (a = x ∧ b = y)) := by
  intro a b e
  by_cases hxy : a = x ∧ b = y
  · obtain ⟨ha, hb⟩ := hxy
    subst ha; subst hb
    exact hdet
  · exact Reach.single ⟨e, hxy⟩

end Dynamics

end Anchored
