import AnchoredEvolution.Anchor

/-!
# Layers 2 and 3: minimal architecture and scale-invariant composition

Layer 1 derived one requirement from the anchor: the correction graph must be
strongly connected.  This file asks what that requirement costs, and whether it
survives when models meet.

**Layer 2, the minimal architecture.**
* Every model must be able both to send and to receive correction.  These are
  the two protections of the elephant parable, seen at the level of a node.
* One outgoing and one incoming route per model suffices (a ring), so the
  cost of correctability grows linearly with the number of models.

**Layer 3, composition.**
* Take correctable components joined by a correctable interface.  The
  composite is correctable, and it is again a system of the same type.  So the
  law holds at every nesting depth.
* The interface condition is necessary.
* Internal correctability of a component is *not* necessary: a model that
  cannot correct itself can be corrected through others.  Interdependence
  appears as a theorem.
* Absorption across a level boundary, in either direction, destroys
  correctability.
-/

universe u

namespace Anchored

/-! ## Layer 2: every model must send and receive correction -/

section Minimal

variable {α : Type u} {Edge : α → α → Prop}

/-- **Standing (sending).**  In a correctable system, every model with a
distinct peer has at least one outgoing correction route: its correction can
leave it. -/
theorem sc_every_model_sends (hsc : StronglyConnected Edge) {a b : α}
    (hab : a ≠ b) : ∃ c, Edge a c := by
  cases hsc a b with
  | refl _ => exact absurd rfl hab
  | step e _ => exact ⟨_, e⟩

/-- **Correctability (receiving).**  In a correctable system, every model with
a distinct peer has at least one incoming correction route: it can be
corrected. -/
theorem sc_every_model_receives (hsc : StronglyConnected Edge) {a b : α}
    (hab : a ≠ b) : ∃ c, Edge c a := by
  cases (hsc b a).last with
  | inl hba => exact absurd hba.symm hab
  | inr hex =>
      obtain ⟨c, _, hca⟩ := hex
      exact ⟨c, hca⟩

end Minimal

/-! ### The ring: one route out and one route in per model suffices -/

section Ring

variable (n : Nat)

/-- A ring of `n+1` models: each passes correction to the next, and the last
passes it back to the first. -/
def RingEdge (a b : Fin (n + 1)) : Prop :=
  (a.val < n ∧ b.val = a.val + 1) ∨ (a.val = n ∧ b.val = 0)

theorem ring_up : ∀ k : Nat, ∀ a b : Fin (n + 1), b.val = a.val + k →
    Reach (RingEdge n) a b := by
  intro k
  induction k with
  | zero =>
      intro a b h
      have : a = b := Fin.ext (by omega)
      subst this
      exact Reach.refl a
  | succ k ih =>
      intro a b h
      have hlt : a.val + 1 < n + 1 := by have := b.isLt; omega
      let m : Fin (n + 1) := ⟨a.val + 1, hlt⟩
      have e : RingEdge n a m := Or.inl ⟨by omega, rfl⟩
      exact Reach.step e (ih m b (by simp [m]; omega))

/-- **The ring is correctable.** -/
theorem ring_strongly_connected : StronglyConnected (RingEdge n) := by
  intro a b
  let top : Fin (n + 1) := ⟨n, by omega⟩
  let zero : Fin (n + 1) := ⟨0, by omega⟩
  have h1 : Reach (RingEdge n) a top :=
    ring_up n (n - a.val) a top (by have := a.isLt; simp [top]; omega)
  have h2 : RingEdge n top zero := Or.inr ⟨rfl, rfl⟩
  have h3 : Reach (RingEdge n) zero b := ring_up n b.val zero b (by simp [zero])
  exact h1.trans (Reach.step h2 h3)

/-- **Each model maintains exactly one outgoing route.** -/
theorem ring_out_unique {a b c : Fin (n + 1)} (h₁ : RingEdge n a b)
    (h₂ : RingEdge n a c) : b = c := by
  apply Fin.ext
  unfold RingEdge at h₁ h₂
  omega

/-- **Each model has exactly one incoming route.** -/
theorem ring_in_unique {a b c : Fin (n + 1)} (h₁ : RingEdge n b a)
    (h₂ : RingEdge n c a) : b = c := by
  apply Fin.ext
  unfold RingEdge at h₁ h₂
  omega

end Ring

/-! ## Layer 3: systems and their composition -/

/-- A system of models with its correction edges. -/
structure System where
  Node : Type u
  Edge : Node → Node → Prop

/-- A system is correctable when its correction graph is strongly connected. -/
def System.Correctable (S : System.{u}) : Prop :=
  StronglyConnected S.Edge

/-- Components indexed by `C`, plus interface edges between nodes of
components. -/
structure Composite (C : Type u) where
  comp : C → System.{u}
  iface : (Σ c, (comp c).Node) → (Σ c, (comp c).Node) → Prop

namespace Composite

variable {C : Type u} (K : Composite.{u} C)

/-- Correction edges of the composite: internal edges of each component, plus
the interface. -/
inductive CEdge : (Σ c, (K.comp c).Node) → (Σ c, (K.comp c).Node) → Prop
  | internal {c : C} {x y : (K.comp c).Node} :
      (K.comp c).Edge x y → CEdge ⟨c, x⟩ ⟨c, y⟩
  | iface {p q : Σ c, (K.comp c).Node} : K.iface p q → CEdge p q

/-- **Composition returns a system of the same type.**  This is what makes the
law recursive. -/
def toSystem : System.{u} where
  Node := Σ c, (K.comp c).Node
  Edge := K.CEdge

/-- The interface graph between components: `c → c'` when some interface edge
leads from a node of `c` to a node of `c'`. -/
def QEdge (c c' : C) : Prop :=
  ∃ x y, K.iface ⟨c, x⟩ ⟨c', y⟩

variable {K}

theorem lift_internal {c : C} {x y : (K.comp c).Node}
    (h : Reach (K.comp c).Edge x y) : Reach K.CEdge ⟨c, x⟩ ⟨c, y⟩ := by
  induction h with
  | refl a => exact Reach.refl _
  | step e _ ih => exact Reach.step (CEdge.internal e) ih

theorem lift_interface (hcomp : ∀ c, (K.comp c).Correctable) {c c' : C}
    (h : Reach K.QEdge c c') :
    ∀ x y, Reach K.CEdge ⟨c, x⟩ ⟨c', y⟩ := by
  induction h with
  | refl c => exact fun x y => lift_internal (hcomp c x y)
  | step e _ ih =>
      intro x y
      obtain ⟨u, v, huv⟩ := e
      exact (lift_internal (hcomp _ x u)).trans (Reach.step (CEdge.iface huv) (ih v y))

/-- **Composition theorem.**  Correctable components joined by a correctable
interface form a correctable composite. -/
theorem composite_correctable
    (hcomp : ∀ c, (K.comp c).Correctable)
    (hq : StronglyConnected K.QEdge) :
    K.toSystem.Correctable := by
  intro p q
  obtain ⟨c, x⟩ := p
  obtain ⟨c', y⟩ := q
  exact lift_interface hcomp (hq c c') x y

/-- Routes in the composite project to routes between components. -/
theorem project_reach {p q : Σ c, (K.comp c).Node}
    (h : Reach K.CEdge p q) : Reach K.QEdge p.1 q.1 := by
  induction h with
  | refl _ => exact Reach.refl _
  | @step a b _ e _ ih =>
      cases e with
      | internal _ => exact ih
      | iface hpq => exact Reach.step ⟨a.2, b.2, hpq⟩ ih

/-- **The interface condition is necessary.**  If the composite is correctable
and every component is inhabited, the interface graph is correctable. -/
theorem interface_necessary (hne : ∀ c, Nonempty (K.comp c).Node)
    (h : K.toSystem.Correctable) : StronglyConnected K.QEdge := by
  intro c c'
  obtain ⟨x⟩ := hne c
  obtain ⟨y⟩ := hne c'
  exact project_reach (h ⟨c, x⟩ ⟨c', y⟩)

/-- **Downward absorption destroys correctability.**  If component `c`'s
correction can never leave it (no outgoing interface edge), and some other
inhabited component `c'` exists, the composite is not correctable: the member's
model has been made epistemically nonexistent to the rest. -/
theorem sealed_outward_breaks {c c' : C} (hcc' : c ≠ c')
    (hx : Nonempty (K.comp c).Node) (hy : Nonempty (K.comp c').Node)
    (hseal : ∀ x q, K.iface ⟨c, x⟩ q → q.1 = c) :
    ¬ K.toSystem.Correctable := by
  intro h
  obtain ⟨x⟩ := hx
  obtain ⟨y⟩ := hy
  have hq : Reach K.QEdge c c' := project_reach (h ⟨c, x⟩ ⟨c', y⟩)
  have hclosed : ∀ a b, a = c → K.QEdge a b → b = c := by
    intro a b ha hab
    subst ha
    obtain ⟨u, v, huv⟩ := hab
    exact hseal u ⟨b, v⟩ huv
  exact hcc' (closed_set_traps (fun z => z = c) hclosed hq rfl).symm

/-- **Upward absorption destroys correctability.**  If no interface edge enters
component `c`, it can never be corrected by the rest, and the composite is not
correctable.  This is self-exemption at scale. -/
theorem sealed_inward_breaks {c c' : C} (hcc' : c ≠ c')
    (hx : Nonempty (K.comp c).Node) (hy : Nonempty (K.comp c').Node)
    (hseal : ∀ p y, K.iface p ⟨c, y⟩ → p.1 = c) :
    ¬ K.toSystem.Correctable := by
  intro h
  obtain ⟨x⟩ := hx
  obtain ⟨y⟩ := hy
  have hq : Reach K.QEdge c' c := project_reach (h ⟨c', y⟩ ⟨c, x⟩)
  have hclosed : ∀ a b, a ≠ c → K.QEdge a b → b ≠ c := by
    intro a b ha hab hbc
    subst hbc
    obtain ⟨u, v, huv⟩ := hab
    exact ha (hseal ⟨a, u⟩ v huv)
  exact closed_set_traps (fun z => z ≠ c) hclosed hq (Ne.symm hcc') rfl

end Composite

/-! ### Scale invariance: any nesting depth -/

/-- Systems obtained by repeatedly composing correctable parts along correctable
interfaces.  There is no bound on nesting depth: persons in teams, teams in
institutions, institutions in societies, and so on. -/
inductive Built : System.{u} → Prop
  | atom (S : System.{u}) : S.Correctable → Built S
  | compose {C : Type u} (K : Composite.{u} C) :
      (∀ c, Built (K.comp c)) → StronglyConnected K.QEdge → Built K.toSystem

/-- **Scale-invariance theorem.**  Every built system is correctable, at every
level of nesting. -/
theorem built_correctable {S : System.{u}} (h : Built S) : S.Correctable := by
  induction h with
  | atom S hS => exact hS
  | compose K _ hq ih => exact Composite.composite_correctable ih hq

/-! ### Interdependence: a part that cannot correct itself, corrected through others -/

section Interdependence

/-- Component `true`: two models with no internal correction edge.  Alone, it
is not correctable. -/
def isolatedPair : System.{0} where
  Node := Bool
  Edge := fun _ _ => False

/-- Component `false`: a single hub model. -/
def hub : System.{0} where
  Node := Unit
  Edge := fun _ _ => False

def pairAndHub : Composite.{0} Bool where
  comp := fun b => if b then isolatedPair else hub
  iface := fun p q => p.1 ≠ q.1

theorem isolatedPair_not_correctable : ¬ isolatedPair.Correctable := by
  intro h
  cases h true false with
  | step e _ => exact e

theorem pairAndHub_correctable : pairAndHub.toSystem.Correctable := by
  intro p q
  obtain ⟨c, x⟩ := p
  obtain ⟨c', y⟩ := q
  -- route: (c,x) → hub side or pair side → (c',y) via at most two interface hops
  cases c <;> cases c'
  · -- hub to hub: the hub has a single node
    cases x; cases y; exact Reach.refl _
  · -- hub to pair
    exact Reach.single (Composite.CEdge.iface (by simp [pairAndHub]))
  · -- pair to hub
    exact Reach.single (Composite.CEdge.iface (by simp [pairAndHub]))
  · -- pair to pair, via the hub
    have e1 : pairAndHub.CEdge ⟨true, x⟩ ⟨false, (() : Unit)⟩ :=
      Composite.CEdge.iface (by simp [pairAndHub])
    have e2 : pairAndHub.CEdge ⟨false, (() : Unit)⟩ ⟨true, y⟩ :=
      Composite.CEdge.iface (by simp [pairAndHub])
    exact Reach.step e1 (Reach.single e2)

/-- **Interdependence theorem.**  A component can be internally uncorrectable
while the composite it belongs to is correctable: its correction arrives
through others.  So internal correctability is sufficient for composition but
not necessary. -/
theorem correction_through_others :
    ¬ (pairAndHub.comp true).Correctable ∧ pairAndHub.toSystem.Correctable :=
  ⟨isolatedPair_not_correctable, pairAndHub_correctable⟩

end Interdependence

end Anchored
