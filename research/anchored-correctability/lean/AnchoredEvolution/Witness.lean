import AnchoredEvolution.Composition

/-!
# Non-vacuity witnesses

These show that the premises of the anchored development can all hold at
once, in a room where one model really is right, and that the scaling
construction works at several nesting levels.

* **Room of three.**
  - Worlds: `w = 0, 1, 2`; model `a` is correct exactly in world `a`.
  - The anchor holds in every world, and every model is live.
  - Correction runs around a ring.
  - All Layer-1 premises are satisfied, and no model is guaranteed.
* **Three levels.**
  - Level 1: rooms.
  - Level 2: a pair of rooms joined by a two-way interface.
  - Level 3: a pair of pairs.
  - Every level is `Built`, hence correctable.
-/

namespace Anchored

open Composite

/-! ## A room of three, in which one model is right -/

def roomHolds (a w : Fin 3) : Prop := a = w
def roomCandidate (_ : Fin 3) : Prop := True

theorem room_anchor : AnchorInEveryWorld roomHolds roomCandidate := by
  intro w _ a b hab h
  exact hab (h.1.trans h.2.symm)

theorem room_live : ∀ a, Live roomHolds roomCandidate a :=
  fun a => ⟨a, trivial, rfl⟩

theorem room_aim : CorrectabilityAim roomHolds roomCandidate (RingEdge 2) :=
  fun _ _ a _ d => ring_strongly_connected 2 a d

theorem room_rival : ∀ a : Fin 3, ∃ b : Fin 3, b ≠ a := by
  intro a
  by_cases h : a = 0
  · exact ⟨1, by subst h; decide⟩
  · exact ⟨0, fun h0 => h h0.symm⟩

/-- In the room, no model is guaranteed, although in each world one model is
right. -/
theorem room_no_guarantee : ∀ a, ¬ Guaranteed roomHolds roomCandidate a :=
  open_room_no_guarantee room_anchor room_live room_rival

/-- The skeleton theorem applied to the room. -/
theorem room_correctable : StronglyConnected (RingEdge 2) :=
  live_and_aim_force_strong_connectivity room_live room_aim

/-! ## Three levels of nesting -/

def roomSystem : System.{0} where
  Node := Fin 3
  Edge := RingEdge 2

theorem roomSystem_built : Built roomSystem :=
  Built.atom _ (ring_strongly_connected 2)

/-- Two systems joined by one route in each direction, between designated
contact nodes. -/
def pairOf (S : System.{0}) (hub : S.Node) : Composite.{0} Bool where
  comp := fun _ => S
  iface := fun p q => p.1 ≠ q.1 ∧ p.2 = hub ∧ q.2 = hub

theorem pairOf_interface (S : System.{0}) (hub : S.Node) :
    StronglyConnected (pairOf S hub).QEdge := by
  intro c c'
  by_cases h : c = c'
  · subst h; exact Reach.refl _
  · exact Reach.single ⟨hub, hub, h, rfl, rfl⟩

theorem pairOf_built (S : System.{0}) (hub : S.Node) (hS : Built S) :
    Built (pairOf S hub).toSystem :=
  Built.compose _ (fun _ => hS) (pairOf_interface S hub)

/-- Level 2: two rooms. -/
def level2 : System.{0} := (pairOf roomSystem (0 : Fin 3)).toSystem

/-- Level 3: two pairs of rooms. -/
def level3 : System.{0} := (pairOf level2 ⟨true, (0 : Fin 3)⟩).toSystem

theorem level2_built : Built level2 := pairOf_built _ _ roomSystem_built
theorem level3_built : Built level3 := pairOf_built _ _ level2_built

/-- **Scale witness.**  The twelve-model, three-level system is correctable,
by the same theorem that makes a single room correctable. -/
theorem level3_correctable : level3.Correctable := built_correctable level3_built

end Anchored
