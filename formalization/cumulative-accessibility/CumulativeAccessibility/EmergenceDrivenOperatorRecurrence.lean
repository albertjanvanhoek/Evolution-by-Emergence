import CumulativeAccessibility.EmergenceDrivenOperatorEvolution
import CumulativeAccessibility.CapacityUptake

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Recurrence for emergence-driven operator evolution

This file separates two claims that must not be conflated:

1. linked lineage: each retained child is explicitly a parent of the next
   operator event;
2. arbitrary-late recurrence: strong operator events occur arbitrarily late,
   without claiming one lineage.

The latter is enough for open-ended counting under monotone retention.  The
former is the stronger recursive-descent object.
-/

section Linked

variable {Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- Binary link used for recursive chains: the designated parent must be a
member of the exact parent configuration of the strong event. -/
def EmergenceDrivenOperatorStepAt
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (m : ℕ)
    (parent child : Capacity) : Prop :=
  ∃ parents ctx,
    parent ∈ parents ∧
    EmergenceDrivenOperatorEventAt
      Base Op Realizes Cost Budget E S Certified
      m parents ctx child

abbrev EmergenceDrivenOperatorChain
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (start : ℕ)
    (seed : Capacity)
    (n : ℕ)
    (endpoint : Capacity) : Prop :=
  TimedRecursiveChain
    (EmergenceDrivenOperatorStepAt
      Base Op Realizes Cost Budget E S Certified)
    start seed n endpoint

/-- A linked chain ends in an active retained capacity. -/
theorem emergenceDrivenOperatorChain_endpoint_active
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (start : ℕ)
    (seed : Capacity)
    {n : ℕ}
    {endpoint : Capacity}
    (hSeed : seed ∈ S start)
    (hChain :
      EmergenceDrivenOperatorChain
        Base Op Realizes Cost Budget E S Certified
        start seed n endpoint) :
    endpoint ∈ S (start + n) := by
  induction hChain with
  | base =>
      simpa using hSeed
  | @step n parent child hPrefix hLink ih =>
      rcases hLink with ⟨parents, ctx, hParentIn, hEvent⟩
      have hRet :
          RetainedIntegrationAt S (start + n) child :=
        operatorEvent_retainedIntegration
          Base Op Realizes Cost Budget E S Certified
          (start + n) hEvent
      simpa [Nat.add_assoc] using hRet.2

/-- Every link in the lineage carries a derived full-closure click. -/
theorem emergenceDrivenOperatorChain_click_at_each_link
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (start : ℕ)
    (seed : Capacity)
    {n : ℕ}
    {endpoint : Capacity}
    (hChain :
      EmergenceDrivenOperatorChain
        Base Op Realizes Cost Budget E S Certified
        start seed n endpoint) :
    ∀ k, k < n ->
      ClosureStrictExpandsOn Set.univ
        (CertifiedGeneratorAt Base Op S Certified (start + k))
        (fun x => x ∈ S (start + k))
        (CertifiedGeneratorAt Base Op S Certified (start + k + 1))
        (fun x => x ∈ S (start + k + 1)) := by
  induction hChain with
  | base =>
      intro k hk
      omega
  | @step n parent child hPrefix hLink ih =>
      intro k hk
      by_cases hkn : k < n
      · exact ih k hkn
      · have hEq : k = n := by omega
        subst hEq
        rcases hLink with ⟨parents, ctx, hParentIn, hEvent⟩
        exact emergenceDrivenOperatorEvent_click
          Base Op Realizes Cost Budget E S Certified
          (start + n) hEvent

end Linked

section Recurring

variable {Context Capacity : Type*}
variable [DecidableEq Capacity]

def RecurringEmergenceDrivenOperatorEvents
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop) : Prop :=
  ∀ n : ℕ, ∃ m parents ctx child,
    n ≤ m ∧
    EmergenceDrivenOperatorEventAt
      Base Op Realizes Cost Budget E S Certified
      m parents ctx child

theorem recurringOperatorEvents_imply_arbitrarilyLateClicks
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (hRecurring :
      RecurringEmergenceDrivenOperatorEvents
        Base Op Realizes Cost Budget E S Certified) :
    ∀ n : ℕ, ∃ m, n ≤ m ∧
      ClosureStrictExpandsOn Set.univ
        (CertifiedGeneratorAt Base Op S Certified m)
        (fun x => x ∈ S m)
        (CertifiedGeneratorAt Base Op S Certified (m + 1))
        (fun x => x ∈ S (m + 1)) := by
  intro n
  obtain ⟨m, parents, ctx, child, hnm, hEvent⟩ := hRecurring n
  exact ⟨m, hnm,
    emergenceDrivenOperatorEvent_click
      Base Op Realizes Cost Budget E S Certified m hEvent⟩

/-- Strong operator-event recurrence implies the older eventual-novelty
bookkeeping condition. -/
theorem recurringOperatorEvents_imply_eventualNovelUptake
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (hRecurring :
      RecurringEmergenceDrivenOperatorEvents
        Base Op Realizes Cost Budget E S Certified) :
    EventualNovelUptake (fun m => S (m + 1)) S := by
  intro n
  obtain ⟨m, parents, ctx, child, hnm, hEvent⟩ := hRecurring n
  have hRet :
      RetainedIntegrationAt S m child :=
    operatorEvent_retainedIntegration
      Base Op Realizes Cost Budget E S Certified m hEvent
  exact ⟨m, child, hnm, hRet.2, hRet.1, hRet.2⟩

theorem recurringOperatorEvents_imply_openEndedNovelty
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hRecurring :
      RecurringEmergenceDrivenOperatorEvents
        Base Op Realizes Cost Budget E S Certified) :
    OpenEndedCumulativeNovelty S := by
  exact eventualNovelUptake_implies_openEndedNovelty
    (fun m => S (m + 1)) S hRetained
    (recurringOperatorEvents_imply_eventualNovelUptake
      Base Op Realizes Cost Budget E S Certified hRecurring)

end Recurring

#print axioms emergenceDrivenOperatorChain_endpoint_active
#print axioms emergenceDrivenOperatorChain_click_at_each_link
#print axioms recurringOperatorEvents_imply_arbitrarilyLateClicks
#print axioms recurringOperatorEvents_imply_openEndedNovelty

end RecursiveAccessibility
end CumulativeAccessibility
