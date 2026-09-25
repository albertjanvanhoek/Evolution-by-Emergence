import AnchoredEvolution.GlobalLayer

/-!
# Shared-layer dynamics: common determinant versus connector

`GlobalLayer` is static. This module adds time, while staying deliberately at
the level of **informational dependence** rather than causal intervention.

The core invariant is network-level and cut-relative. A safe update need not
preserve every old distinction, nor must each node keep every distinction it
personally held. What must not happen is narrower: a live cut of a retained
commitment that was distinguishable to the old network must not become
indistinguishable to the new network. This permits forgetting, replacement,
rewiring and handoff between nodes.

Two shared-layer patterns are then distinguished:

* **Hub-determined update.** Every node's next view carries no distinction that
  the current shared layer lacks. Hub blind spots can then become network blind
  spots.
* **Connector update.** The network preserves its still-needed old correction
  cuts while, as a group, carrying every distinction present in the shared
  layer. Shared information can therefore be integrated without requiring any
  particular node to freeze its previous view.

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

/-- If at most one node can be available, joint determination collapses to
individual determination by that node. The node itself need not be available:
when no node is available, joint determination already forces the hub to be
constant. -/
theorem at_most_one_contributor_implies_node_determines {n₀ : N}
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
    (at_most_one_contributor_implies_node_determines view S hub hsole hcoll.1)

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

/-- Full distinction preservation by one node. This is a strong sufficient
condition, not the network-level requirement. -/
def DistinctionPreserving (t : Nat) (n : N) : Prop :=
  ∀ v w,
    viewT (t + 1) n v = viewT (t + 1) n w →
    viewT t n v = viewT t n w

/-- Per-node preservation restricted to live cuts of retained commitments. This
is weaker than full preservation but still stronger than necessary, because a
distinction may safely be handed from one node to another. -/
def LiveCutPreserving (t : Nat) (n : N) : Prop :=
  ∀ a, K a → ∀ v w,
    C v → C w → a v → ¬ a w →
    viewT (t + 1) n v = viewT (t + 1) n w →
    viewT t n v = viewT t n w

/-- **Minimal transition invariant used here.** On a live cut of a retained
commitment, if the *new network as a whole* is blind between two worlds, then
the old network was already blind there. Thus an update may move a distinction
between nodes, but it may not erase the network's final separator for a live
cut. -/
def NetworkCutPreserving (t : Nat) : Prop :=
  ∀ a, K a → ∀ v w,
    C v → C w → a v → ¬ a w →
    Indist (netAt viewT S C K (t + 1)) v w →
    Indist (netAt viewT S C K t) v w

/-- The updated network carries the current hub's distinctions collectively:
if all new node views identify two worlds, then the hub identifies them too. -/
def NetworkCarriesHub (t : Nat) : Prop :=
  JointlyDetermined (viewT (t + 1)) S (hubT t)

/-- Connector update: the network preserves its old live correction cuts while
also carrying the hub's distinctions collectively. No individual node is
required to preserve or encode everything. -/
def ConnectorUpdate (t : Nat) : Prop :=
  NetworkCutPreserving viewT S C K t ∧
  NetworkCarriesHub viewT hubT S t

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

/-- Full distinction preservation implies per-node live-cut preservation. -/
theorem distinction_preserving_implies_live_cut_preserving
    {t : Nat} {n : N} (h : DistinctionPreserving viewT t n) :
    LiveCutPreserving viewT C K t n := by
  intro _ _ v w _ _ _ _ heq
  exact h v w heq

/-- If every available node preserves its own live-cut distinctions, then the
weaker network-level cut-preservation invariant holds. This is the handoff point:
the converse need not hold. -/
theorem nodewise_live_cut_preserving_implies_network_cut_preserving (t : Nat)
    (hpres : ∀ n, S n → LiveCutPreserving viewT C K t n) :
    NetworkCutPreserving viewT S C K t := by
  intro a hK v w hCv hCw hav hnaw hnew
  exact ⟨rfl, fun n hn => hpres n hn a hK v w hCv hCw hav hnaw (hnew.2 n hn)⟩

/-- **Core dynamic safety theorem.** A network-level cut-preserving update keeps
an anchor-safe network anchor-safe. This permits forgetting, replacement,
rewiring and handoff, provided no live retained-commitment cut loses its final
network-level distinction. -/
theorem network_cut_preserving_step_keeps_safety (t : Nat)
    (hpres : NetworkCutPreserving viewT S C K t)
    (h : Unsealed (netAt viewT S C K t)) :
    Unsealed (netAt viewT S C K (t + 1)) := by
  rintro a hK w hCw hnaw ⟨v, hCv, hav, hnew⟩
  exact h a hK w hCw hnaw
    ⟨v, hCv, hav, hpres a hK v w hCv hCw hav hnaw hnew⟩

/-- If every transition preserves live cuts at network level, an initially
anchor-safe network remains anchor-safe at every step. -/
theorem network_cut_preserving_stays_safe
    (hpres : ∀ t, NetworkCutPreserving viewT S C K t)
    (h₀ : Unsealed (netAt viewT S C K 0)) :
    ∀ t, Unsealed (netAt viewT S C K t)
  | 0 => h₀
  | t + 1 => network_cut_preserving_step_keeps_safety viewT S C K t (hpres t)
      (network_cut_preserving_stays_safe hpres h₀ t)

/-- Recoverability of a node's old view from its new view is a strong local
sufficient condition for full distinction preservation. The view may change
substantially; freezing old content is unnecessary. -/
theorem recoverable_update_preserves {t : Nat} {n : N}
    (g : O → O) (hrec : ∀ w, g (viewT (t + 1) n w) = viewT t n w) :
    DistinctionPreserving viewT t n := by
  intro v w heq
  rw [← hrec v, ← hrec w, heq]

/-- **Connector regime.** If every transition is a connector update, an
initially anchor-safe network remains anchor-safe. The connector condition
explicitly involves the shared layer but only requires the network collectively,
not every individual node, to carry its distinctions. -/
theorem connector_network_stays_safe
    (hconn : ∀ t, ConnectorUpdate viewT hubT S C K t)
    (h₀ : Unsealed (netAt viewT S C K 0)) :
    ∀ t, Unsealed (netAt viewT S C K t) :=
  network_cut_preserving_stays_safe viewT S C K (fun t => (hconn t).1) h₀

/-- At a live cut hidden from the hub, a previously safe network cannot both
make every next node hub-determined and satisfy the connector invariant. A
common determinant would erase the cut; a connector must preserve some route
for it, though that route may move between nodes. -/
theorem safe_hub_determined_not_connector_at_live_blind_cut
    {t : Nat} (hsafe : Unsealed (netAt viewT S C K t))
    (hdet : ∀ n, S n → HubDeterminedUpdate viewT hubT t n)
    {a : W → Prop} (hK : K a) {v w : W}
    (hCv : C v) (hCw : C w) (hav : a v) (hnaw : ¬ a w)
    (hblind : hubT t v = hubT t w) :
    ¬ ConnectorUpdate viewT hubT S C K t := by
  intro hconn
  have hnew : Indist (netAt viewT S C K (t + 1)) v w :=
    ⟨rfl, fun n hn => hdet n hn v w hblind⟩
  have hold := hconn.1 a hK v w hCv hCw hav hnaw hnew
  exact hsafe a hK w hCw hnaw ⟨v, hCv, hav, hold⟩

end Dynamics

end Anchored.SharedLayerDynamics
