namespace CumulativeAccessibility
namespace ConnectionIndependence

/-!
# Connection against independence

A shared layer passes its blind spots to every node it determines
(`Anchored.GlobalLayer.hub_determined_network_inherits_blind_spot`): to catch
such an error, a network needs a node that does not share the layer.  To
correct it, that node must also reach the others.  The two pull against each
other: links spread a correction, but they also pull nodes into line, and a
node in line has lost the independence that finds the error.  This is the
open reachability–independence trade-off, in its simplest form (compare
Zollman on the epistemic value of transient diversity).

Setting, over levels of connection `ℓ = 0, 1, 2, ...`.
* `reach ℓ`: at level `ℓ`, a correction found by an independent node reaches
  the rest.  More connection does not lose reach: `reach` is monotone.
* `resist ℓ`: how many steps an independent node stays independent before it
  falls into line.  More connection does not raise it: `resist` is antitone.
* `find`: how many steps it takes an independent node to find the error.
* The network **corrects** the error at level `ℓ` when the correction reaches
  the rest and the node finds the error before it falls into line:
  `reach ℓ ∧ find ≤ resist ℓ`.

Results:
* `isolation_cannot_correct`: where a found error reaches nobody, nothing is
  corrected.
* `full_conformity_cannot_correct`: where nodes fall into line before they can
  find the error, nothing is corrected.
* `correcting_levels_form_interval`: the levels at which the network corrects
  form an interval: between two that work, every level works.
* `connection_independence_witness`: five levels where only the middle one
  corrects.

So more connection is not always better: the correctable network sits between
isolation and conformity, and keeping independent nodes is the price of
correction, not a failure of connection.  Not covered: how the levels map to
real network structures, and errors that need several independent nodes.  The
results are close to arithmetic once monotonicity is assumed; the substance is
in the setting.
-/

/-- The network corrects the error at level `ℓ`. -/
def Corrects (reach : Nat → Bool) (resist : Nat → Nat) (find ℓ : Nat) : Prop :=
  reach ℓ = true ∧ find ≤ resist ℓ

/-- **Isolation cannot correct.** -/
theorem isolation_cannot_correct {reach : Nat → Bool} {resist : Nat → Nat} {find ℓ : Nat}
    (h : reach ℓ = false) : ¬ Corrects reach resist find ℓ := by
  rintro ⟨hr, _⟩
  rw [h] at hr
  exact Bool.false_ne_true hr

/-- **Full conformity cannot correct.** -/
theorem full_conformity_cannot_correct {reach : Nat → Bool} {resist : Nat → Nat} {find ℓ : Nat}
    (h : resist ℓ < find) : ¬ Corrects reach resist find ℓ := by
  rintro ⟨_, hf⟩
  omega

/-- **The correcting levels form an interval.**  If connection never loses
reach and never raises resistance, then between two levels at which the
network corrects, every level corrects. -/
theorem correcting_levels_form_interval {reach : Nat → Bool} {resist : Nat → Nat} {find : Nat}
    (hreach : ∀ a b, a ≤ b → reach a = true → reach b = true)
    (hresist : ∀ a b, a ≤ b → resist b ≤ resist a)
    {a b m : Nat} (ha : Corrects reach resist find a) (hb : Corrects reach resist find b)
    (ham : a ≤ m) (hmb : m ≤ b) : Corrects reach resist find m :=
  ⟨hreach a m ham ha.1, Nat.le_trans hb.2 (hresist m b hmb)⟩

/-- Five levels of connection: a correction reaches the rest from level 2 on,
resistance falls from 4 to 0, and finding the error takes 2 steps.  Level 0 is
isolated, levels 3 and 4 conform too fast, and only level 2 corrects. -/
theorem connection_independence_witness :
    let reach : Nat → Bool := fun ℓ => decide (2 ≤ ℓ)
    let resist : Nat → Nat := fun ℓ => 4 - ℓ
    ¬ Corrects reach resist 2 0 ∧ ¬ Corrects reach resist 2 1 ∧ Corrects reach resist 2 2 ∧
      ¬ Corrects reach resist 2 3 ∧ ¬ Corrects reach resist 2 4 := by
  simp only [Corrects]
  decide

end ConnectionIndependence
end CumulativeAccessibility
