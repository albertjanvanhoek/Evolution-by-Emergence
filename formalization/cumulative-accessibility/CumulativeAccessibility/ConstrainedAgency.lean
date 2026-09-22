import Mathlib.Data.Set.Basic

namespace CumulativeAccessibility
namespace ConstrainedAgency

variable {State Agent Action : Type*}

/-!
# Constrained local agency

This module gives a minimal formal interpretation of the older EbE phrase
"forced free will" without making a metaphysical claim.

An agent can have several locally available actions, while viability,
continuation, or shared-process constraints select a subset of those actions.
-/

/-- Locally available actions for an agent in a state. -/
abbrev AvailableActions (State Agent Action : Type*) :=
  State → Agent → Set Action

/-- Application-specific viability predicate for choosing an action. -/
abbrev ViableAction (State Agent Action : Type*) :=
  State → Agent → Action → Prop

/-- Viable actions are the available actions that also satisfy the declared
continuation/viability condition. -/
def ViableActions
    (Available : AvailableActions State Agent Action)
    (Viable : ViableAction State Agent Action)
    (s : State)
    (a : Agent) : Set Action :=
  {x | x ∈ Available s a ∧ Viable s a x}

/-- Viable local agency is always a subset of local availability. -/
theorem viableActions_subset_available
    (Available : AvailableActions State Agent Action)
    (Viable : ViableAction State Agent Action)
    (s : State)
    (a : Agent) :
    ViableActions Available Viable s a ⊆ Available s a := by
  intro x hx
  exact hx.1

/-- Nontrivial local agency: two distinct actions are available. -/
def HasLocalAlternative
    (Available : AvailableActions State Agent Action)
    (s : State)
    (a : Agent) : Prop :=
  ∃ x y, x ≠ y ∧ x ∈ Available s a ∧ y ∈ Available s a

/-- Network/substrate constraint is behaviorally nontrivial when at least one
available action is excluded by the declared viability predicate. -/
def HasBindingConstraint
    (Available : AvailableActions State Agent Action)
    (Viable : ViableAction State Agent Action)
    (s : State)
    (a : Agent) : Prop :=
  ∃ x, x ∈ Available s a ∧ x ∉ ViableActions Available Viable s a

/-- The formal content of constrained local agency is the conjunction of local
alternatives and a binding viability constraint. -/
def ConstrainedLocalAgency
    (Available : AvailableActions State Agent Action)
    (Viable : ViableAction State Agent Action)
    (s : State)
    (a : Agent) : Prop :=
  HasLocalAlternative Available s a ∧
    HasBindingConstraint Available Viable s a

theorem constrainedLocalAgency_has_choice
    (Available : AvailableActions State Agent Action)
    (Viable : ViableAction State Agent Action)
    (s : State)
    (a : Agent)
    (h : ConstrainedLocalAgency Available Viable s a) :
    HasLocalAlternative Available s a :=
  h.1

theorem constrainedLocalAgency_has_constraint
    (Available : AvailableActions State Agent Action)
    (Viable : ViableAction State Agent Action)
    (s : State)
    (a : Agent)
    (h : ConstrainedLocalAgency Available Viable s a) :
    HasBindingConstraint Available Viable s a :=
  h.2

#print axioms viableActions_subset_available
#print axioms constrainedLocalAgency_has_choice
#print axioms constrainedLocalAgency_has_constraint

end ConstrainedAgency
end CumulativeAccessibility
