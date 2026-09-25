import AnchoredEvolution.GlobalLayer

/-!
# Shared-layer dynamics: common determinant versus connector

`GlobalLayer` is static. This module adds time, while staying deliberately at
the level of **informational dependence** rather than causal intervention.

Two update patterns are distinguished:

* **Hub-determined update.** A node's next view carries no distinction that the
  current shared layer lacks. Blind spots of the layer can therefore propagate
  into the network.
* **Connector update.** A node's next view preserves every old distinction that
  still matters to a live cut of a retained commitment, while also carrying the
  distinctions available in the shared layer. The shared layer can therefore
  add information without erasing the node's still-needed correction routes.

The safety theorem is deliberately cut-relative. It does **not** require every
old distinction to survive: only distinctions crossing still-live cuts of
retained commitments must remain available. Full distinction preservation and
recoverability of the previous view are stronger sufficient conditions.

A separate one-moment notion captures collective informational irreducibility:
a shared representation may be jointly determined by the available nodes while
not being determined by any one available node. This is a structural signature
of collective dependence, not by itself the stronger Evolution-by-Emergence
notion of emergence, and says nothing about ownership or provenance.

Outside the theorem surface: causal influence, who trains or owns a layer,
data provenance, nationality, benefit distribution, and whether real human or
model updates satisfy these informational conditions.
-/

namespace Anchored.SharedLayerDynamics

open Anchored.AnchorSafety Anchored.SelfModel Anchored.GlobalLayer

universe u₁ u₂ u₃ u₄

/-! ## 1. Joint determination without individual reducibility -/

section Collective

variable {W : Type u₁} {N : Type u₂} {O : Type u₃} {H : Type u₄}
variable (view : N → W → O) (S : N → Prop) (hub : W → H)

/-- The shared representation is jointly determined by the **available** nodes:
if all available nodes identify two worlds, the hub identifies them too. Thus
the hub adds no distinction absent from the available views as a group. -/
def JointlyDetermined : Prop :=
  ∀ v w, (∀ n, S n → view n v = view n w) → hub v = hub w

/-- Available node `n` individually determines the hub at this information
level: whenever `n` identifies two worlds, so does the hub. -/
def NodeDeterminesHub (n : N) : Prop :=
  ∀ v w, view n v = view n w → hub v = hub w

/-- Jointly determined by the available set, but not individually determined by
any available node. We call this *collectively irreducible* rather than
`Emergent` to avoid overloading the stronger EbE notion of emergence. -/
def CollectivelyIrreducible : Prop :=
  JointlyDetermined view S hub ∧
  ∀ n, S n → ¬ NodeDeterminesHub view hub n

/-- If exactly one node is available, joint determination collapses to
individual determination by that node. -/
theorem sole_contributor_implies_node_determines {n₀ : N} (hn₀ : S n₀)
    (hsole : ∀ m, S m → m = n₀) (hjoint : JointlyDetermined view S hub) :
    NodeDeterminesHub view hub n₀ := by
  intro v w heq
  apply hjoint v w
  intro m hm
  rw [hsole m hm]
  exact heq

/-- A collectively irreducible shared representation cannot have exactly one
available contributor. This is an informational statement about the chosen
views and boundary, not a claim about historical authorship or ownership. -/
theorem collectively_irreducible_has_no_sole_contributor
    (hcoll : CollectivelyIrreducible view S hub)
    {n₀ : N} (hn₀ : S n₀) : ¬ ∀ m, S m → m = n₀ :=
  fun hsole => hcoll.2 n₀ hn₀
    (sole_contributor_implies_node_determines view S hub hn₀ hsole hcoll.1)

end Collective

/-! ## 2. Dynamics -/

section Dynamics

variable {W : Type u₁} {N : Type u₂} {O : Type u₃} {H : Type u₄}
variable (viewT : Nat → N → W → O) (hubT : Nat → W → H)
  (S : N → Prop) (C : W → Prop) (K : (W → Prop) → Prop)

/-- The node network at step `t`. In this first dynamic layer, membership `S`,
open worlds `C`, retained commitments `K`, and view type `O` are fixed over
time; only the node views and shared representation vary. -/
abbrev netAt (t : Nat) : State W Unit N O := nodeState (viewT t) S C K

/-- Hub-determined update: if the current shared layer cannot distinguish two
worlds, node `n` cannot distinguish them at the next step either. This is an
information-factorisation condition, not a causal intervention statement. -/
def HubDeterminedUpdate (t : Nat) (n : N) : Prop :=
  HubDetermined (viewT (t + 1)) (hubT t) n

/-- Full distinction preservation: equality after the update implies equality
before it. Equivalently, every distinction the node previously carried remains
available after the update. This is stronger than Anchor-Safety requires. -/
def DistinctionPreserving (t : Nat) (n : N) : Prop :=
  ∀ v w,
    viewT (t + 1) n v = viewT (t + 1) n w →
    viewT t n v = viewT t n w

/-- The weaker condition Anchor-Safety actually needs: only distinctions across
open, still-live cuts of retained commitments must survive the update. -/
def LiveCutPreserving (t : Nat) (n : N) : Prop :=
  ∀ a, K a → ∀ v w,
    C v → C w → a v → ¬ a w →
    viewT (t + 1) n v = viewT (t + 1) n w →
    viewT t n v = viewT t n w

/-- Connector update: the next local view (i) preserves the old distinctions
needed on live retained-commitment cuts and (ii) is at least as discriminating
as the current shared layer. Thus the new representation can contain shared
information without erasing the node's still-needed independent correction
routes. -/
def ConnectorUpdate (t : Nat) (n : N) : Prop :=
  LiveCutPreserving viewT C K t n ∧
  NodeDeterminesHub (viewT (t + 1)) (hubT t) n

/-- If every available node's next view is determined by the current hub, a
live retained-commitment cut on which the hub is blind is sealed for the whole
network at the next step. The error is also undiscoverable there. -/
theorem hub_determined_update_inherits_blind_spot (t : Nat)
    (hdet : ∀ n, S n → HubDeterminedUpdate viewT hubT t n)
    {a : W → Prop} (hK : K a) {v w : W}
    (hCv : C v) (hCw : C w) (hav : a v) (hnaw : ¬ a w)
    (hblind : hubT t v = hubT t w) :
    Sealed (netAt viewT S C K (t + 1)) a w ∧
    ¬ Discoverable (netAt viewT S C K (t + 1)) a w ∧
    ¬ Unsealed (netAt viewT S C K (t + 1)) :=
  hub_determined_network_inherits_blind_spot
    (viewT (t + 1)) S C K (hubT t) hdet hK hCv hCw hav hnaw hblind

/-- A hub-determined update cannot preserve *all* old distinctions if the node
previously separated a pair on which the hub is blind. -/
theorem hub_determined_not_distinction_preserving_at_independent_pair
    {t : Nat} {n : N} (hdet : HubDeterminedUpdate viewT hubT t n)
    {v w : W} (hblind : hubT t v = hubT t w)
    (hown : viewT t n v ≠ viewT t n w) :
    ¬ DistinctionPreserving viewT t n :=
  fun hpres => hown (hpres v w (hdet v w hblind))

/-- Full distinction preservation implies the weaker, cut-relative condition. -/
theorem distinction_preserving_implies_live_cut_preserving
    {t : Nat} {n : N} (h : DistinctionPreserving viewT t n) :
    LiveCutPreserving viewT C K t n := by
  intro _ _ v w _ _ _ _ heq
  exact h v w heq

/-- **Core dynamic safety theorem.** One update step preserves Anchor-Safety if
every available node preserves distinctions across the live cuts of retained
commitments. Irrelevant distinctions may disappear. -/
theorem live_cut_preserving_step_keeps_safety (t : Nat)
    (hpres : ∀ n, S n → LiveCutPreserving viewT C K t n)
    (h : Unsealed (netAt viewT S C K t)) :
    Unsealed (netAt viewT S C K (t + 1)) := by
  rintro a hK w hCw hnaw ⟨v, hCv, hav, _, hm⟩
  exact h a hK w hCw hnaw
    ⟨v, hCv, hav, rfl,
      fun n hn => hpres n hn a hK v w hCv hCw hav hnaw (hm n hn)⟩

/-- If every update preserves the distinctions needed on live cuts, an
initially anchor-safe network remains anchor-safe at every step. -/
theorem live_cut_preserving_network_stays_safe
    (hpres : ∀ t n, S n → LiveCutPreserving viewT C K t n)
    (h₀ : Unsealed (netAt viewT S C K 0)) :
    ∀ t, Unsealed (netAt viewT S C K t)
  | 0 => h₀
  | t + 1 => live_cut_preserving_step_keeps_safety viewT S C K t (hpres t)
      (live_cut_preserving_network_stays_safe hpres h₀ t)

/-- Recoverability of the old view from the new view is a stronger sufficient
condition for full distinction preservation. The view may change substantially;
freezing its old content is unnecessary. -/
theorem recoverable_update_preserves {t : Nat} {n : N}
    (g : O → O) (hrec : ∀ w, g (viewT (t + 1) n w) = viewT t n w) :
    DistinctionPreserving viewT t n := by
  intro v w heq
  rw [← hrec v, ← hrec w, heq]

/-- Every connector update preserves exactly the old live-cut distinctions
needed by the core safety theorem. -/
theorem connector_update_preserves_live_cuts {t : Nat} {n : N}
    (h : ConnectorUpdate viewT hubT C K t n) :
    LiveCutPreserving viewT C K t n :=
  h.1

/-- **Connector regime.** If every available node updates as a connector at
every step, an initially anchor-safe network remains anchor-safe. Unlike the
pure preservation theorem, this condition explicitly involves the shared layer:
the new node view also carries every distinction present in the current hub. -/
theorem connector_network_stays_safe
    (hconn : ∀ t n, S n → ConnectorUpdate viewT hubT C K t n)
    (h₀ : Unsealed (netAt viewT S C K 0)) :
    ∀ t, Unsealed (netAt viewT S C K t) :=
  live_cut_preserving_network_stays_safe viewT S C K
    (fun t n hn => (hconn t n hn).1) h₀

/-- At a live cut where a node has an independent distinction absent from the
hub, the same update cannot be both hub-determined and a connector: the former
erases the distinction while the latter is required to preserve it. -/
theorem hub_determined_not_connector_at_live_independent_cut
    {t : Nat} {n : N} (hdet : HubDeterminedUpdate viewT hubT t n)
    {a : W → Prop} (hK : K a) {v w : W}
    (hCv : C v) (hCw : C w) (hav : a v) (hnaw : ¬ a w)
    (hblind : hubT t v = hubT t w)
    (hown : viewT t n v ≠ viewT t n w) :
    ¬ ConnectorUpdate viewT hubT C K t n := by
  intro hconn
  exact hown (hconn.1 a hK v w hCv hCw hav hnaw (hdet v w hblind))

end Dynamics

end Anchored.SharedLayerDynamics
