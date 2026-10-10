namespace CumulativeAccessibility
namespace PowerLayers

/-!
# Power in two speeds: a fast layer that must not rewrite the slow one

Entry D19 of `DIALOGUE.md` describes power with two speeds.  The fast part
(who holds power now, day-to-day decisions) changes quickly; the slow part (the
rules for how power is given, checked and taken back) changes reluctantly, but
must still be able to change.  The central claim is that the fast part must not
be able to change the slow part on its own: a ruler who can rewrite the rules
for removing rulers can remove the last route that corrects him.  This module
states that claim in its simplest form.

Setting: the slow layer is a set of rules with a number of independent removal
routes (elections, courts, a credible exit) and an amendment threshold, the
number of independent parties that must agree to change the rules.  A ruler
controls some number of parties, and takes an extraction `e` from the
governed.  The governed tolerate up to `τ`; above that, any working removal
route ends his rule.

Results:
* `removal_caps_extraction`: with at least one removal route, the ruler keeps
  power exactly when his extraction stays within what the governed tolerate.
  The route need never be used to set this limit.
* `sealed_ruler_unbounded`: with no removal route, he keeps power at any
  extraction.
* `controls_amendment_can_seal`: a ruler who controls enough parties to amend
  the rules alone can reach rules with no removal route.
* `capture_by_amendment`: so such a ruler can reach a state in which he keeps
  power at any extraction.
* `entrenched_rules_hold`: if amendment needs more parties than the ruler
  controls, the only rules he can reach on his own are the present ones.
* `entrenched_routes_cap_extraction`: so, with entrenched rules and a removal
  route, his extraction stays capped whatever he does alone.
* `frozen_rules_fall_behind`: rules that can never change cannot follow a
  requirement that changes.  The slow layer must be slow, not frozen.
* `power_layers_witness`: concrete numbers.

Not covered: how removal routes work, coalitions that form and break, rulers
who capture parties over time, and whether a rule is just.  Which interests
count is a value, not a result (D7).  These results are close to their
definitions; they fix the shape of the claim.
-/

/-- The slow layer: how many independent routes can remove a ruler, and how
many independent parties must agree to change the rules. -/
structure Rules where
  removalRoutes : Nat
  amendThreshold : Nat

/-- A ruler with extraction `e` keeps power when no removal route exists, or
when the extraction stays within what the governed tolerate (`τ`). -/
def keepsPower (routes τ e : Nat) : Prop := routes = 0 ∨ e ≤ τ

/-- A ruler controlling `own` parties can change the rules alone when that
meets the amendment threshold. -/
def canAmendAlone (r : Rules) (own : Nat) : Prop := r.amendThreshold ≤ own

/-- With at least one removal route, the ruler keeps power exactly when his
extraction is tolerated. -/
theorem removal_caps_extraction (routes τ e : Nat) (h : 0 < routes) :
    keepsPower routes τ e ↔ e ≤ τ := by
  unfold keepsPower
  constructor
  · intro hk
    cases hk with
    | inl h0 => omega
    | inr hle => exact hle
  · intro hle
    exact Or.inr hle

/-- With no removal route, the ruler keeps power at any extraction. -/
theorem sealed_ruler_unbounded (τ e : Nat) : keepsPower 0 τ e :=
  Or.inl rfl

/-- The rules a ruler can reach on his own: the present rules, or, if he can
amend alone, any rules at all. -/
def reachableAlone (r : Rules) (own : Nat) (r' : Rules) : Prop :=
  r' = r ∨ canAmendAlone r own

/-- A ruler who can amend alone can reach rules with no removal route. -/
theorem controls_amendment_can_seal (r : Rules) (own : Nat)
    (h : canAmendAlone r own) :
    ∃ r' : Rules, reachableAlone r own r' ∧ r'.removalRoutes = 0 :=
  ⟨{ removalRoutes := 0, amendThreshold := r.amendThreshold }, Or.inr h, rfl⟩

/-- So a ruler who can amend alone can reach a state in which he keeps power
at any extraction. -/
theorem capture_by_amendment (r : Rules) (own : Nat) (h : canAmendAlone r own) :
    ∃ r' : Rules, reachableAlone r own r' ∧ ∀ τ e, keepsPower r'.removalRoutes τ e := by
  obtain ⟨r', hr, h0⟩ := controls_amendment_can_seal r own h
  exact ⟨r', hr, fun τ e => by rw [h0]; exact sealed_ruler_unbounded τ e⟩

/-- If amendment needs more parties than the ruler controls, the only rules he
can reach on his own are the present ones. -/
theorem entrenched_rules_hold (r : Rules) (own : Nat)
    (h : own < r.amendThreshold) : ∀ r', reachableAlone r own r' → r' = r := by
  intro r' hr
  cases hr with
  | inl heq => exact heq
  | inr hc => unfold canAmendAlone at hc; omega

/-- So, with entrenched rules, a ruler cannot remove the existing removal
routes on his own, and his extraction stays capped. -/
theorem entrenched_routes_cap_extraction (r : Rules) (own τ e : Nat)
    (h : own < r.amendThreshold) (hr : 0 < r.removalRoutes) :
    ∀ r', reachableAlone r own r' → (keepsPower r'.removalRoutes τ e ↔ e ≤ τ) := by
  intro r' hreach
  rw [entrenched_rules_hold r own h r' hreach]
  exact removal_caps_extraction r.removalRoutes τ e hr

/-- Rules that never change cannot follow a requirement that takes two
different values: at some time they differ from it. -/
theorem frozen_rules_fall_behind (x : Nat) (req : Nat → Nat) (s t : Nat)
    (h : req s ≠ req t) : ∃ u, req u ≠ x := by
  by_cases hs : req s = x
  · exact ⟨t, fun ht => h (hs.trans ht.symm)⟩
  · exact ⟨s, hs⟩

/-- Concrete numbers: with one removal route and a tolerance of 3, an
extraction of 5 ends the ruler's power; with no route it does not; a ruler
with 2 parties cannot amend rules that need 3. -/
theorem power_layers_witness :
    ¬ keepsPower 1 3 5 ∧ keepsPower 0 3 5 ∧
      ¬ canAmendAlone { removalRoutes := 1, amendThreshold := 3 } 2 := by
  unfold keepsPower canAmendAlone
  decide

end PowerLayers
end CumulativeAccessibility
