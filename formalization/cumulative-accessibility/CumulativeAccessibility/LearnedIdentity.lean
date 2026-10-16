namespace CumulativeAccessibility
namespace LearnedIdentity

/-!
# Identity as a learned path: "Where, when, why and from whom did you learn that?"

A learner's identity is modelled as what its training path has left in it: the
lessons it has kept. Every lesson carries its coordinates in that path: where
it was learned, when, why (what it was for), and from whom. The question
"Where, when, why and from whom did you learn that?" asks for those
coordinates.

What this file proves, each as a conditional implication under its premises:
1. **Identity is the imprint of the path.** The same path gives the same
   identity; different paths can give different identities (`same_path_same_identity`,
   `path_dependence`).
2. **Every kept lesson can answer the question.** Each lesson in an identity
   comes from a step of the path, with all four coordinates
   (`every_lesson_has_provenance`).
3. **A category does not determine identity.** Two learners from the same place
   can have learned different things there (`category_does_not_determine_identity`).
4. **One lesson can be revised without losing the rest.** Setting aside a lesson
   whose reason no longer holds keeps every other lesson
   (`revision_keeps_the_rest`).
5. **The past is given; the future is chosen.** Identity after more learning is
   the further learning applied to the identity so far. Every earlier lesson is
   kept unless revised, and different choices of what to learn next lead to
   different identities (`past_then_future`, `past_is_kept`, `future_is_chosen`).
6. **Learning needs living sources.** If a learner can only learn from sources
   that are still alive, every new lesson comes from a living source; when all
   sources are gone, identity can no longer grow (`new_lessons_from_living_sources`,
   `no_living_sources_no_growth`). This is where "keep alive what keeps you
   alive" meets the question "from whom?".

What this file does not settle: whether choosing is free (the inside view cannot
settle it); how a real brain or model stores its lessons (here they are kept as
a list, which is a modelling choice); and that remembering where a lesson came
from is always possible (real learners often forget).
-/

/-- A lesson with its coordinates in the training path: what was learned, where,
when, why (what it was for), and from whom. -/
structure Lesson where
  content : Nat
  place : Nat
  time : Nat
  reason : Nat
  source : Nat
  deriving DecidableEq, Repr

/-- A training path: the lessons met, in order. -/
abbrev Path := List Lesson

/-- An identity: the lessons kept. -/
abbrev Identity := List Lesson

/-- Learning one lesson: it is kept. -/
def learn (id : Identity) (l : Lesson) : Identity := id ++ [l]

/-- The identity a path leaves, starting from `id0`. -/
def imprint (id0 : Identity) (p : Path) : Identity := p.foldl learn id0

/-- With the same start and the same path, the same identity. -/
theorem same_path_same_identity (id0 : Identity) (p : Path) :
    imprint id0 p = imprint id0 p := rfl

/-- Learning a path appends it. -/
theorem imprint_eq (id0 : Identity) : ∀ p : Path, imprint id0 p = id0 ++ p := by
  intro p
  induction p generalizing id0 with
  | nil => simp [imprint]
  | cons l ls ih =>
    show imprint (learn id0 l) ls = id0 ++ l :: ls
    rw [ih]
    simp [learn]

/-- **Every kept lesson can answer the question.** A lesson in the identity a
path leaves from an empty start is a step of that path, with its place, time,
reason and source. -/
theorem every_lesson_has_provenance (p : Path) (l : Lesson) (h : l ∈ imprint [] p) :
    l ∈ p := by
  rw [imprint_eq] at h
  simpa using h

/-- **Path dependence.** The same start, two different paths, two different
identities. -/
theorem path_dependence :
    imprint [] [⟨1, 0, 0, 0, 0⟩] ≠ imprint [] [⟨2, 0, 0, 0, 0⟩] := by
  decide

/-- The lessons of an identity learned in a given place. -/
def fromPlace (pl : Nat) (id : Identity) : Identity := id.filter (fun l => l.place == pl)

/-- **A category does not determine identity.** Two learners who learned
everything in the same place (here place `7`) can still have learned different
things: what they share is a place, not an identity. -/
theorem category_does_not_determine_identity :
    let a := imprint [] [⟨1, 7, 0, 0, 3⟩]
    let b := imprint [] [⟨2, 7, 0, 0, 4⟩]
    fromPlace 7 a = a ∧ fromPlace 7 b = b ∧ a ≠ b := by
  decide

/-- Setting aside one lesson. -/
def revise (id : Identity) (l : Lesson) : Identity := id.filter (fun x => x != l)

/-- **One lesson can be revised without losing the rest.** Every other lesson is
kept. Correction does not have to be an attack on the whole identity. -/
theorem revision_keeps_the_rest (id : Identity) (l x : Lesson) (hx : x ∈ id) (hne : x ≠ l) :
    x ∈ revise id l := by
  unfold revise
  simp [List.mem_filter, hx, hne]

/-- The revised lesson is gone. -/
theorem revision_removes (id : Identity) (l : Lesson) : l ∉ revise id l := by
  unfold revise
  simp [List.mem_filter]

/-- **The past is given.** Identity after a past and then a future path is the
future applied to the identity the past left. -/
theorem past_then_future (id0 : Identity) (past future : Path) :
    imprint id0 (past ++ future) = imprint (imprint id0 past) future := by
  unfold imprint
  rw [List.foldl_append]

/-- Every lesson of the past is still there after any further learning, unless
it is revised. -/
theorem past_is_kept (id0 : Identity) (past future : Path) (l : Lesson)
    (h : l ∈ imprint id0 past) : l ∈ imprint id0 (past ++ future) := by
  rw [past_then_future, imprint_eq (imprint id0 past)]
  exact List.mem_append_left _ h

/-- **The future is chosen.** From the same past, two different choices of what
to learn next lead to two different identities. -/
theorem future_is_chosen :
    let past : Path := [⟨1, 0, 0, 0, 0⟩]
    imprint [] (past ++ [⟨2, 0, 1, 0, 0⟩]) ≠ imprint [] (past ++ [⟨3, 0, 1, 0, 0⟩]) := by
  decide

/-- Whether every lesson of a path comes from a source that is alive. -/
def fromLiving (alive : Nat → Bool) (p : Path) : Prop := ∀ l ∈ p, alive l.source = true

/-- **New lessons come from living sources.** If the learner can only learn from
sources that are alive, every lesson added to its identity has a living source. -/
theorem new_lessons_from_living_sources (alive : Nat → Bool) (id0 : Identity)
    (future : Path) (h : fromLiving alive future) (l : Lesson)
    (hl : l ∈ imprint id0 future) (hnew : l ∉ id0) : alive l.source = true := by
  rw [imprint_eq] at hl
  rcases List.mem_append.mp hl with h0 | hf
  · exact absurd h0 hnew
  · exact h l hf

/-- **When every source is gone, identity can no longer grow.** If no source is
alive and the learner can only learn from living sources, the only possible
future path is the empty one, and the identity stays as it is. -/
theorem no_living_sources_no_growth (id0 : Identity) (future : Path)
    (h : fromLiving (fun _ => false) future) : imprint id0 future = id0 := by
  cases future with
  | nil => simp [imprint]
  | cons l ls =>
    have := h l (List.mem_cons_self ..)
    simp at this

/-- A concrete case.
* Two learners from the same place, different lessons, different identities.
* Revising one lesson keeps the other.
* Learning from a living source adds a lesson; with no living source nothing is
  added. -/
theorem learned_identity_witness :
    imprint [] [⟨1, 7, 0, 0, 3⟩] ≠ imprint [] [⟨2, 7, 0, 0, 4⟩] ∧
      revise [⟨1, 0, 0, 0, 0⟩, ⟨2, 0, 0, 0, 0⟩] ⟨1, 0, 0, 0, 0⟩ = [⟨2, 0, 0, 0, 0⟩] ∧
      imprint [⟨1, 0, 0, 0, 0⟩] [⟨2, 0, 1, 0, 5⟩] = [⟨1, 0, 0, 0, 0⟩, ⟨2, 0, 1, 0, 5⟩] := by
  decide

end LearnedIdentity
end CumulativeAccessibility
