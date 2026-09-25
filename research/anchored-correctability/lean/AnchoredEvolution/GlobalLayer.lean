import AnchoredEvolution.SelfModel

/-!
# Global representation layer: shared blind spots and local correction

This module is a structural extension of the node-network instance in
`AnchoredEvolution.SelfModel`.  It does **not** formalise nations, ownership,
training provenance, cultural identity, conflict, or benefit distribution.
Those are application-level or empirical/normative questions.

The formal setting has:
* nodes `N` with local views `view`,
* a shared/global representation `hub`,
* currently available nodes `S`,
* open worlds `C`, and retained commitments `K`.

The key condition is deliberately functional, not causal: a node is
`HubDetermined` when equality at the hub implies equality at that node.  Thus
any pair the hub fails to distinguish is also invisible to that node.

Results:
1. If every available node is hub-determined, every live commitment cut on
   which the hub is blind is sealed for the combined node network.
2. If all other nodes are hub-determined but one node independently separates
   that cut, the independent node is pivotal there; removing it seals the live
   error.
3. If, for every node, the hub distinguishes some pair that node does not,
   then the hub is not a function of any single node's view.  This is a
   non-reducibility statement only; it says nothing about legal or political
   ownership, nationality, neutrality, or who supplied training data.
-/

namespace Anchored.GlobalLayer

open Anchored.AnchorSafety Anchored.SelfModel

universe u₁ u₂ u₃ u₄

variable {W : Type u₁} {N : Type u₂} {O : Type u₃} {H : Type u₄}
variable (view : N → W → O) (S : N → Prop) (C : W → Prop)
  (K : (W → Prop) → Prop) (hub : W → H)

/-- Node `n` is determined by the shared representation at the level relevant
here: whenever the hub is blind between two worlds, so is the node. -/
def HubDetermined (n : N) : Prop :=
  ∀ v w, hub v = hub w → view n v = view n w

/-- **Inherited shared blind spot.** If every available node is hub-determined,
then a live retained-commitment cut on which the hub is blind is sealed for the
whole node network.  Consequently the error is not discoverable from the
combined available node views, and the network is not anchor-safe. -/
theorem hub_determined_network_inherits_blind_spot
    (hdet : ∀ n, S n → HubDetermined view hub n)
    {a : W → Prop} (hK : K a) {v w : W}
    (hCv : C v) (hCw : C w) (hav : a v) (hnaw : ¬ a w)
    (hblind : hub v = hub w) :
    Sealed (nodeState view S C K) a w ∧
    ¬ Discoverable (nodeState view S C K) a w ∧
    ¬ Unsealed (nodeState view S C K) := by
  have hS : Sealed (nodeState view S C K) a w :=
    ⟨v, hCv, hav, rfl, fun n hn => hdet n hn v w hblind⟩
  exact ⟨hS, fun hD => (discoverable_iff_not_sealed _ a w).1 hD hS,
    fun hU => hU a hK w hCw hnaw hS⟩

/-- **Independent local correction.** If every available node except `m` is
hub-determined at a pair the hub cannot distinguish, while `m` does distinguish
that pair, then `m` is pivotal for that pair.  Any independent source with this
structure could play the same role; the theorem is not specific to geography
or nationality. -/
theorem independent_node_pivotal_at_hub_blind_spot {m : N} (hm : S m)
    (hdet : ∀ n, S n → n ≠ m → HubDetermined view hub n)
    {v w : W} (hblind : hub v = hub w) (hsep : view m v ≠ view m w) :
    Pivotal view S m v w :=
  ⟨hm, hsep, fun n hn hnm => hdet n hn hnm v w hblind⟩

/-- **Losing the sole independent separator seals the error.** This is the
node-level pivotal-removal theorem applied at a blind spot of the hub. -/
theorem losing_independent_node_seals {m : N} (hm : S m)
    (hdet : ∀ n, S n → n ≠ m → HubDetermined view hub n)
    {a : W → Prop} (hK : K a) {v w : W}
    (hCv : C v) (hCw : C w) (hav : a v) (hnaw : ¬ a w)
    (hblind : hub v = hub w) (hsep : view m v ≠ view m w) :
    Sealed { nodeState view S C K with eff := fun r => S r ∧ r ≠ m } a w ∧
    ¬ Unsealed { nodeState view S C K with eff := fun r => S r ∧ r ≠ m } :=
  (pivotal_removal_seals view S C K hK hCv hCw hav hnaw m
    (independent_node_pivotal_at_hub_blind_spot view S hub hm hdet hblind hsep)).2

/-- **Not reducible to any single node.** If, for every node, there is some
pair of worlds that node identifies but the hub distinguishes, then the hub's
view cannot be reconstructed as a function of any one node's view. -/
theorem hub_not_reducible_to_any_single_node
    (hwide : ∀ n, ∃ v w, view n v = view n w ∧ hub v ≠ hub w) :
    ¬ ∃ n, ∃ f : O → H, ∀ w, hub w = f (view n w) := by
  rintro ⟨n, f, hf⟩
  obtain ⟨v, w, heq, hne⟩ := hwide n
  exact hne (by rw [hf v, hf w, heq])

end Anchored.GlobalLayer
