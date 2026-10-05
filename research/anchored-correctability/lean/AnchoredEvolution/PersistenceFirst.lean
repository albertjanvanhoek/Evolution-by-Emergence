import AnchoredEvolution.Anchor

/-!
# Persistence first: correctability derived from persistence

`Anchor.lean` takes correctability as an explicit chosen premise
(`CorrectabilityAim`). This file derives it instead, from persistence and two
premises about the world:

* **Substrate dependence (with a buffer `B`).** An agent exists only while it is
  sustained by others. It can bridge at most `B` steps without a maintained
  link; to persist `B + 1` steps after `t` it needs a link at some time in
  `[t, t + B]`.
* **Reciprocity.** A link is still maintained at `s + 1` only if the agent
  answered correction arriving on it at `s`. Partners stop sustaining an agent
  that does not answer them.

Results:

* `persistence_requires_correction_within`: an agent that persists `B + 2`
  steps after `t` answered correction at some time in `[t, t + B]`.
* `sealing_is_fatal_after_buffer`: an agent that answers no correction during
  `[t, t + B]` does not persist at `t + B + 2`. The buffer sets how long sealing
  can go unpunished; it cannot make sealing safe.
* `indefinite_persistence_requires_recurring_correction`: an agent that persists
  at every time answers correction arbitrarily late.
* `interdependence_and_persistence_force_correctability`: if every agent needs
  each of its supporters, support is reciprocal, the support graph is strongly
  connected, and every agent persists through the window, then the correction
  edges operating in that window form a strongly connected graph.
* `persistence_replaces_the_aim`: under the same premises, `CorrectabilityAim`
  holds for those correction edges, for any candidate worlds and any models.
  The aim is no longer chosen; it is what persistence requires.
* `reciprocity_is_load_bearing`: without reciprocity, an agent can persist at
  every time while never answering correction. Persistence alone does not force
  correction; dependence on partners who require answers does.

Scope: discrete time, a declared support relation, and reciprocity stated as a
premise about the world. Reciprocity holds for collaborations and relationships;
it can fail for monopolies, parasites or coercive regimes, which can persist for
long periods without answering correction. Those are exactly the cases the
countermodel covers.
-/

universe u

namespace Anchored.PersistenceFirst

open Anchored

/-! ## One agent -/

section Node

variable {Agent : Type u}
variable (Persists : Agent → Nat → Prop) (Linked : Agent → Nat → Prop)
variable (Corrects : Agent → Nat → Prop)

/-- Substrate dependence with buffer `B`: persisting at `t + B + 1` requires a
maintained link at some time in `[t, t + B]`. -/
def SubstrateDependent (B : Nat) : Prop :=
  ∀ a t, Persists a (t + B + 1) → ∃ s, t ≤ s ∧ s ≤ t + B ∧ Linked a s

/-- Reciprocity: a link is still maintained at `s + 1` only if the agent
answered correction at `s`. -/
def Reciprocal : Prop :=
  ∀ a s, Linked a (s + 1) → Corrects a s

variable {Persists Linked Corrects}

/-- **Persistence requires correction within the buffer.** -/
theorem persistence_requires_correction_within {B : Nat}
    (hSub : SubstrateDependent Persists Linked B)
    (hRec : Reciprocal Linked Corrects)
    {a : Agent} {t : Nat} (hP : Persists a (t + B + 2)) :
    ∃ s, t ≤ s ∧ s ≤ t + B ∧ Corrects a s := by
  have hP' : Persists a ((t + 1) + B + 1) := by
    have e : (t + 1) + B + 1 = t + B + 2 := by omega
    rw [e]
    exact hP
  obtain ⟨s, h1, h2, hl⟩ := hSub a (t + 1) hP'
  obtain ⟨s', hs'⟩ : ∃ s', s = s' + 1 := ⟨s - 1, by omega⟩
  subst hs'
  exact ⟨s', by omega, by omega, hRec a s' hl⟩

/-- **Sealing is fatal after the buffer.** An agent that answers no correction
during `[t, t + B]` does not persist at `t + B + 2`. -/
theorem sealing_is_fatal_after_buffer {B : Nat}
    (hSub : SubstrateDependent Persists Linked B)
    (hRec : Reciprocal Linked Corrects)
    {a : Agent} {t : Nat}
    (hSealed : ∀ s, t ≤ s → s ≤ t + B → ¬ Corrects a s) :
    ¬ Persists a (t + B + 2) := by
  intro hP
  obtain ⟨s, h1, h2, hc⟩ := persistence_requires_correction_within hSub hRec hP
  exact hSealed s h1 h2 hc

/-- **Indefinite persistence requires recurring correction.** -/
theorem indefinite_persistence_requires_recurring_correction {B : Nat}
    (hSub : SubstrateDependent Persists Linked B)
    (hRec : Reciprocal Linked Corrects)
    {a : Agent} (hAlways : ∀ t, Persists a t) :
    ∀ t, ∃ s, t ≤ s ∧ Corrects a s := by
  intro t
  obtain ⟨s, h1, _, hc⟩ :=
    persistence_requires_correction_within hSub hRec (hAlways (t + B + 2))
  exact ⟨s, h1, hc⟩

end Node

/-! ## A network of interdependent agents -/

section Network

variable {Agent : Type u}
variable (Persists : Agent → Nat → Prop)
variable (Support : Agent → Agent → Prop)
variable (Maintained : Nat → Agent → Agent → Prop)
variable (Answers : Nat → Agent → Agent → Prop)

/-- Each agent needs each of its supporters: if `b` supports `a`, then for `a`
to persist at `t + B + 1` the link from `b` must be maintained at some time in
`[t, t + B]`. -/
def NeedsEachSupporter (B : Nat) : Prop :=
  ∀ a b t, Support b a → Persists a (t + B + 1) →
    ∃ s, t ≤ s ∧ s ≤ t + B ∧ Maintained s b a

/-- Reciprocal support: `b` still sustains `a` at `s + 1` only if `a` answered
correction from `b` at `s`. -/
def ReciprocalSupport : Prop :=
  ∀ s b a, Maintained (s + 1) b a → Answers s b a

/-- The correction edges operating within the window `[t, t + B]`: correction
from `b` entered `a` and was answered. -/
def WindowCorrection (t B : Nat) (b a : Agent) : Prop :=
  ∃ s, t ≤ s ∧ s ≤ t + B ∧ Answers s b a

variable {Persists Support Maintained Answers}

theorem support_edge_is_window_correction {B t : Nat}
    (hNeed : NeedsEachSupporter Persists Support Maintained B)
    (hRec : ReciprocalSupport Maintained Answers)
    {a b : Agent} (hab : Support b a) (hP : Persists a (t + B + 2)) :
    WindowCorrection Answers t B b a := by
  have hP' : Persists a ((t + 1) + B + 1) := by
    have e : (t + 1) + B + 1 = t + B + 2 := by omega
    rw [e]
    exact hP
  obtain ⟨s, h1, h2, hm⟩ := hNeed a b (t + 1) hab hP'
  obtain ⟨s', hs'⟩ : ∃ s', s = s' + 1 := ⟨s - 1, by omega⟩
  subst hs'
  exact ⟨s', by omega, by omega, hRec s' b a hm⟩

/-- **Interdependence plus persistence forces correctability.** If the support
graph is strongly connected, support is reciprocal, every agent needs each of
its supporters, and every agent persists through the window, then the
correction edges operating in that window form a strongly connected graph. -/
theorem interdependence_and_persistence_force_correctability {B : Nat}
    (hNeed : NeedsEachSupporter Persists Support Maintained B)
    (hRec : ReciprocalSupport Maintained Answers)
    (hInter : StronglyConnected Support)
    (t : Nat) (hAll : ∀ a, Persists a (t + B + 2)) :
    StronglyConnected (WindowCorrection Answers t B) := by
  intro x y
  apply Reach.simulate _ (hInter x y)
  intro b a hab
  exact Reach.single (support_edge_is_window_correction hNeed hRec hab (hAll a))

/-- **Persistence replaces the aim.** Under the same premises, the
correctability aim of `Anchor.lean` holds for the correction edges operating in
the window, whatever the candidate worlds and whichever model turns out to be
correct. It is no longer a chosen premise. -/
theorem persistence_replaces_the_aim {World : Type u} {B : Nat}
    (holds : Agent → World → Prop) (Candidate : World → Prop)
    (hNeed : NeedsEachSupporter Persists Support Maintained B)
    (hRec : ReciprocalSupport Maintained Answers)
    (hInter : StronglyConnected Support)
    (t : Nat) (hAll : ∀ a, Persists a (t + B + 2)) :
    CorrectabilityAim holds Candidate (WindowCorrection Answers t B) :=
  fun _ _ a _ d =>
    interdependence_and_persistence_force_correctability hNeed hRec hInter t hAll a d

end Network

/-! ## Witness and countermodel -/

/-- **Non-vacuity.** Two agents support each other, every link is maintained,
every correction is answered and both agents persist: all premises hold, so the
derived aim holds. -/
theorem persistence_first_witness :
    NeedsEachSupporter (fun (_ : Bool) (_ : Nat) => True) (fun a b => a ≠ b)
        (fun _ _ _ => True) 0 ∧
      ReciprocalSupport (fun _ (_ : Bool) (_ : Bool) => True) (fun _ _ _ => True) ∧
      StronglyConnected (fun (a b : Bool) => a ≠ b) ∧
      CorrectabilityAim (fun (_ : Bool) (_ : Bool) => True) (fun _ => True)
        (WindowCorrection (fun _ (_ : Bool) (_ : Bool) => True) 0 0) := by
  have hInter : StronglyConnected (fun (a b : Bool) => a ≠ b) := by
    intro x y
    by_cases h : x = y
    · subst h
      exact Reach.refl x
    · exact Reach.single h
  have hNeed : NeedsEachSupporter (fun (_ : Bool) (_ : Nat) => True) (fun a b => a ≠ b)
      (fun _ _ _ => True) 0 :=
    fun _ _ t _ _ => ⟨t, Nat.le_refl t, by omega, trivial⟩
  have hRec : ReciprocalSupport (fun _ (_ : Bool) (_ : Bool) => True) (fun _ _ _ => True) :=
    fun _ _ _ _ => trivial
  exact ⟨hNeed, hRec, hInter,
    persistence_replaces_the_aim _ _ hNeed hRec hInter 0 (fun _ => trivial)⟩

/-- **Reciprocity is load-bearing.** Without reciprocity, an agent can be
substrate-dependent, keep its links and persist at every time while never
answering any correction. Persistence alone does not force correction;
dependence on partners who require answers does. -/
theorem reciprocity_is_load_bearing :
    SubstrateDependent (fun (_ : Unit) (_ : Nat) => True) (fun _ _ => True) 0 ∧
      ¬ Reciprocal (fun (_ : Unit) (_ : Nat) => True) (fun _ _ => False) ∧
      (∀ t, (fun (_ : Unit) (_ : Nat) => True) () t) ∧
      (∀ s, ¬ (fun (_ : Unit) (_ : Nat) => False) () s) := by
  refine ⟨fun _ t _ => ⟨t, Nat.le_refl t, by omega, trivial⟩, ?_,
    fun _ => trivial, fun _ h => h⟩
  intro h
  exact h () 0 trivial

end Anchored.PersistenceFirst

#print axioms Anchored.PersistenceFirst.persistence_requires_correction_within
#print axioms Anchored.PersistenceFirst.sealing_is_fatal_after_buffer
#print axioms Anchored.PersistenceFirst.indefinite_persistence_requires_recurring_correction
#print axioms Anchored.PersistenceFirst.interdependence_and_persistence_force_correctability
#print axioms Anchored.PersistenceFirst.persistence_replaces_the_aim
#print axioms Anchored.PersistenceFirst.persistence_first_witness
#print axioms Anchored.PersistenceFirst.reciprocity_is_load_bearing
