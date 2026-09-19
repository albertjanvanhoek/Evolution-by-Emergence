import CumulativeAccessibility.LocalEmergenceReproduction
import CumulativeAccessibility.VocabularyEmergence

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Endogenous moving envelopes from primitive promotion

PR #58 corrects the recursive theory by moving finiteness from a global
Capacity type to a finite time-local candidate envelope U_t.  This module asks
the next causal question:

    why should U_(t+1) contain anything that U_t did not?

The key distinction is that the child of a recursive-emergence event need not be
new to the candidate envelope: it may already have been represented in U_t
before being realized.  What changes at the event is its operational status.
A previously unavailable capacity is retained as reusable parent material.

The endogenous envelope step therefore lives one level later:

1. child is newly retained and becomes an operational primitive;
2. using that promoted child enables a downstream candidate next that could not
   be generated from the pre-promotion repertoire under the same next-step
   generator;
3. a finite promotion-admission policy selects which newly enabled
   possibilities enter the local search surface, and the responsive envelope
   represents admitted candidates in U_(t+1);
4. if an admitted candidate also passes emergence, resource, validation, and retention
   filtering, it is an actual local R_E successor.

The universal theory does not claim that every promotion is generatively
consequential, nor that every newly exposed candidate survives filtering.
Those remain explicit seams.
-/

section OperationalPromotion

variable {Config Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- Every recursive-emergence event promotes its child from operationally novel
at time m to available reusable material at time m+1.

With monotone retention, the entire operational integration
Active_m ∪ {child} is contained in the next retained repertoire. -/
theorem recursiveEmergenceStep_is_operationalPromotion
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    {parent child : Capacity}
    (hRetained : S m ⊆ S (m + 1))
    (hStep :
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H m parent child) :
    OperationallyNovel (fun x => x ∈ S m) child
    ∧
    ∀ x,
      IntegrateOperationalCapacity (fun y => y ∈ S m) child x →
      x ∈ S (m + 1) := by
  have hInt : RetainedIntegrationAt S m child :=
    recursiveEmergenceStep_retains_new_child
      Proper Realizes Cost Budget E S H m hStep
  constructor
  · exact hInt.1
  · intro x hx
    rcases hx with hOld | rfl
    · exact hRetained hOld
    · exact hInt.2

end OperationalPromotion

section PromotionGeneratedCandidates

variable {Capacity : Type*}
variable [DecidableEq Capacity]

/-- A downstream candidate is generatively consequential for the promotion of
child at time m when child is explicitly used as parent at the next step and
that candidate was not generable from the pre-promotion retained repertoire
under the same next-step generator.

Using the same generator H_(m+1) on both sides isolates the contribution of the
newly available parent material from changes in the rule itself. -/
def GenerativelyConsequentialPromotionAt
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    (child next : Capacity) : Prop :=
  GeneratedUsingParent
      (fun x => x ∈ S (m + 1))
      (H (m + 1))
      child next
  ∧
  ¬ GeneratedFromAvailable
      (fun x => x ∈ S m)
      (H (m + 1))
      next

/-- A finite/local envelope need not expose every possibility opened by a
promoted primitive.  An admission policy represents the application-specific
compression/attention rule selecting which newly enabled capacities become
locally represented candidates. -/
abbrev PromotionAdmissionPolicy (Capacity : Type*) :=
  ℕ → Capacity → Capacity → Prop

/-- The moving envelope is responsive to primitive promotion when each
*admitted* newly generable candidate is represented in the next local
candidate envelope.

The admission policy is the finite-selection/compression seam.  This definition
does not require a finite envelope to contain every capacity a promoted
primitive could in principle make generable. -/
def PromotionResponsiveEnvelope
    (Admit : PromotionAdmissionPolicy Capacity)
    (U S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity) : Prop :=
  ∀ m child next,
    RetainedIntegrationAt S m child →
    Admit m child next →
    GenerativelyConsequentialPromotionAt S H m child next →
    next ∈ U (m + 1)

/-- A newly enabled downstream candidate that was outside the old envelope
becomes a genuinely new entry of the next envelope under a responsive policy. -/
theorem promotionResponsiveEnvelope_exposes_new_entry
    (U S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (Admit : PromotionAdmissionPolicy Capacity)
    (hResponsive : PromotionResponsiveEnvelope Admit U S H)
    (m : ℕ)
    {child next : Capacity}
    (hPromoted : RetainedIntegrationAt S m child)
    (hAdmitted : Admit m child next)
    (hConsequential :
      GenerativelyConsequentialPromotionAt S H m child next)
    (hOutside : next ∉ U m) :
    next ∉ U m ∧ next ∈ U (m + 1) := by
  exact ⟨hOutside,
    hResponsive m child next hPromoted hAdmitted hConsequential⟩

/-- If the envelope itself is monotone, a new-entry witness becomes an ordinary
strict finite-set expansion.  Monotone envelopes are optional; the corrected
PR #58 theory only needs moving finite envelopes, not nested ones. -/
theorem promotion_new_entry_strictly_expands_monotone_envelope
    (U : ℕ → Finset Capacity)
    (m : ℕ)
    {next : Capacity}
    (hMono : U m ⊆ U (m + 1))
    (hOutside : next ∉ U m)
    (hNext : next ∈ U (m + 1)) :
    U m ⊂ U (m + 1) := by
  exact Finset.ssubset_iff_subset_ne.mpr ⟨hMono, by
    intro hEq
    exact hOutside (by simpa [hEq] using hNext)⟩

end PromotionGeneratedCandidates

section PromotionToSuccessor

variable {Config Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- A promotion-driven filtered successor separates candidate creation from
survival filtering.

The child is already newly retained by the preceding event.  The downstream
candidate next must be newly enabled by using that child, selected by the
finite admission policy, lie outside the old envelope, and independently pass
the full filtered emergent event at time m+1. -/
def PromotionDrivenFilteredSuccessorAt
    (Admit : PromotionAdmissionPolicy Capacity)
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    (child next : Capacity) : Prop :=
  GenerativelyConsequentialPromotionAt S H m child next
  ∧ Admit m child next
  ∧ next ∉ U m
  ∧ ResourceValidatedEmergentEventAt
      Proper Realizes Cost Budget E S (m + 1) next

/-- Under a promotion-responsive envelope, a newly enabled downstream candidate
that passes the full filter is an actual recursive-emergence successor in the
next local envelope. -/
theorem promotionDrivenFilteredSuccessor_implies_local_successor
    (Admit : PromotionAdmissionPolicy Capacity)
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (hResponsive : PromotionResponsiveEnvelope Admit U S H)
    (m : ℕ)
    {parent child next : Capacity}
    (hCurrent :
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H m parent child)
    (hNext :
      PromotionDrivenFilteredSuccessorAt
        Admit U Proper Realizes Cost Budget E S H m child next) :
    next ∈ U (m + 1)
    ∧
    RecursiveEmergenceStepAt
      Proper Realizes Cost Budget E S H (m + 1) child next := by
  have hPromoted : RetainedIntegrationAt S m child :=
    recursiveEmergenceStep_retains_new_child
      Proper Realizes Cost Budget E S H m hCurrent
  have hEnvelope :
      next ∈ U (m + 1) :=
    hResponsive m child next hPromoted hNext.2.1 hNext.1
  have hChildAvailable : child ∈ S (m + 1) :=
    hPromoted.2
  refine ⟨hEnvelope, hChildAvailable, hNext.1.1, hNext.2.2.2⟩

/-- Every realized event has a promotion-driven filtered successor.  This is
stronger and more causal than directly postulating local R_E >= 1: it exposes
the intermediate mechanism by which the promoted primitive opens a new
candidate in the moving envelope. -/
def UniformPromotionDrivenContinuation
    (Admit : PromotionAdmissionPolicy Capacity)
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity) : Prop :=
  ∀ m parent child,
    RecursiveEmergenceStepAt
      Proper Realizes Cost Budget E S H m parent child →
    ∃ next,
      PromotionDrivenFilteredSuccessorAt
        Admit U Proper Realizes Cost Budget E S H m child next

/-- Promotion-driven continuation plus a promotion-responsive envelope implies
the local deterministic criticality condition of PR #58. -/
theorem uniformPromotionDrivenContinuation_implies_uniformLocalCritical
    (Admit : PromotionAdmissionPolicy Capacity)
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (hResponsive : PromotionResponsiveEnvelope Admit U S H)
    (hContinuation :
      UniformPromotionDrivenContinuation
        Admit U Proper Realizes Cost Budget E S H) :
    UniformLocalCriticalEmergenceReproduction
      U Proper Realizes Cost Budget E S H := by
  intro m parent child hCurrent
  obtain ⟨next, hNext⟩ :=
    hContinuation m parent child hCurrent
  have hSuccessor :=
    promotionDrivenFilteredSuccessor_implies_local_successor
      Admit U Proper Realizes Cost Budget E S H
      hResponsive m hCurrent hNext
  exact
    (one_le_localEffectiveEmergenceSuccessorCount_iff_exists
      U Proper Realizes Cost Budget E S H m child).mpr
      ⟨next, hSuccessor.1, hSuccessor.2⟩

/-- The causal promotion route closes onto open-ended cumulative novelty without
a global finite capacity type. -/
theorem seed_and_uniformPromotionDrivenContinuation_imply_openEndedNovelty
    (Admit : PromotionAdmissionPolicy Capacity)
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    {seedParent seedChild : Capacity}
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hSeed :
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H 0 seedParent seedChild)
    (hResponsive : PromotionResponsiveEnvelope Admit U S H)
    (hContinuation :
      UniformPromotionDrivenContinuation
        Admit U Proper Realizes Cost Budget E S H) :
    OpenEndedCumulativeNovelty S := by
  exact
    seed_and_uniformLocalCriticalEmergenceReproduction_imply_openEndedNovelty
      U Proper Realizes Cost Budget E S H
      hRetained hSeed
      (uniformPromotionDrivenContinuation_implies_uniformLocalCritical
        Admit U Proper Realizes Cost Budget E S H
        hResponsive hContinuation)

/-- If retained organization is represented in the local envelope, the same
promotion-driven route forces the moving envelope to have unbounded capacity. -/
theorem seed_and_uniformPromotionDrivenContinuation_imply_unboundedEnvelope
    (Admit : PromotionAdmissionPolicy Capacity)
    (U : ℕ → Finset Capacity)
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    {seedParent seedChild : Capacity}
    (hRepresented : ∀ n, S n ⊆ U n)
    (hRetained : ∀ n, S n ⊆ S (n + 1))
    (hSeed :
      RecursiveEmergenceStepAt
        Proper Realizes Cost Budget E S H 0 seedParent seedChild)
    (hResponsive : PromotionResponsiveEnvelope Admit U S H)
    (hContinuation :
      UniformPromotionDrivenContinuation
        Admit U Proper Realizes Cost Budget E S H) :
    UnboundedEnvelopeCapacity U := by
  exact
    seed_and_uniformLocalCriticalEmergenceReproduction_imply_unboundedEnvelope
      U Proper Realizes Cost Budget E S H
      hRepresented hRetained hSeed
      (uniformPromotionDrivenContinuation_implies_uniformLocalCritical
        Admit U Proper Realizes Cost Budget E S H
        hResponsive hContinuation)

end PromotionToSuccessor

section PromotionSeparation

/-- Operational promotion does not automatically create a newly generable
downstream capacity.  The one-shot witness has a valid recursive-emergence seed
and therefore promotes `true`, but its next-step generator is empty. -/
theorem oneShot_promotion_has_no_generativelyConsequential_downstream :
    RecursiveEmergenceStepAt
      boolProper oneShotRealizes
      oneShotCost oneShotBudget oneShotCriterion
      oneShotRepertoire oneShotGenerator
      0 false true
    ∧
    ∀ next,
      ¬ GenerativelyConsequentialPromotionAt
        oneShotRepertoire oneShotGenerator 0 true next := by
  constructor
  · exact oneShot_seed
  · intro next hConsequential
    rcases hConsequential.1 with
      ⟨parents, hParent, hAvailable, hRule⟩
    simpa [oneShotGenerator] using hRule

end PromotionSeparation

section ProgressivePromotionWitness

/-- In the progressive architecture, primitive promotion is genuinely
generatively consequential: after n+1 is retained, it enables n+2 under the
next-step generator, while n+2 was not generable from the pre-promotion
repertoire. -/
theorem progressive_promotion_is_generatively_consequential
    (n : ℕ) :
    GenerativelyConsequentialPromotionAt
      progressiveRepertoire progressiveGenerator
      n (n + 1) (n + 2) := by
  constructor
  · refine ⟨{n + 1}, by simp, ?_, ?_⟩
    · intro x hx
      have hxEq : x = n + 1 := by simpa using hx
      subst x
      simp [progressiveRepertoire]
    · simp [progressiveGenerator]
  · intro hGenerated
    rcases hGenerated with ⟨parents, hAvailable, hRule⟩
    have hParents : parents = {n + 1} := hRule.1
    subst parents
    have hParentAvailable := hAvailable (n + 1) (by simp)
    simp [progressiveRepertoire] at hParentAvailable

/-- The progressive witness admits every promotion-enabled candidate.  Its
generator exposes only one relevant next candidate, but the generic theory
allows applications to use a much more selective finite admission policy. -/
def progressivePromotionAdmission : PromotionAdmissionPolicy ℕ :=
  fun _ _ _ => True

/-- The progressive moving envelope is responsive to newly enabled candidates
created by primitive promotion. -/
theorem progressive_has_promotionResponsiveEnvelope :
    PromotionResponsiveEnvelope
      progressivePromotionAdmission
      progressiveEnvelope progressiveRepertoire progressiveGenerator := by
  intro m child next hPromoted hAdmitted hConsequential
  rcases hConsequential.1 with
    ⟨parents, hChildParent, hAvailable, hRule⟩
  have hNext : next = (m + 1) + 1 := hRule.2
  subst next
  simp [progressiveEnvelope]

/-- The progressive architecture satisfies promotion-driven continuation at
every event. -/
theorem progressive_has_uniformPromotionDrivenContinuation :
    UniformPromotionDrivenContinuation
      progressivePromotionAdmission
      progressiveEnvelope
      boolProper progressiveEmergentRealizes
      progressiveEmergentCost progressiveEmergentBudget
      progressiveEmergentCriterion
      progressiveRepertoire progressiveGenerator := by
  intro m parent child hCurrent
  have hChild : child = m + 1 := by
    rcases hCurrent.2.1 with
      ⟨parents, hParent, hAvailable, hRule⟩
    exact hRule.2
  subst child
  refine ⟨m + 2, ?_, ?_, ?_, ?_⟩
  · exact progressive_promotion_is_generatively_consequential m
  · trivial
  · simp [progressiveEnvelope]
  · exact (progressive_recursiveEmergenceStep (m + 1)).2.2

/-- Non-vacuity of the new causal route: the progressive architecture is
open-ended specifically through primitive promotion -> new candidate exposure
-> filtered successor -> local critical reproduction. -/
theorem progressive_openEnded_via_endogenousEnvelopePromotion :
    OpenEndedCumulativeNovelty progressiveRepertoire := by
  exact
    seed_and_uniformPromotionDrivenContinuation_imply_openEndedNovelty
      progressivePromotionAdmission
      progressiveEnvelope
      boolProper progressiveEmergentRealizes
      progressiveEmergentCost progressiveEmergentBudget
      progressiveEmergentCriterion
      progressiveRepertoire progressiveGenerator
      progressiveRepertoire_retained
      (progressive_recursiveEmergenceStep 0)
      progressive_has_promotionResponsiveEnvelope
      progressive_has_uniformPromotionDrivenContinuation

theorem progressive_unboundedEnvelope_via_endogenousEnvelopePromotion :
    UnboundedEnvelopeCapacity progressiveEnvelope := by
  exact
    seed_and_uniformPromotionDrivenContinuation_imply_unboundedEnvelope
      progressivePromotionAdmission
      progressiveEnvelope
      boolProper progressiveEmergentRealizes
      progressiveEmergentCost progressiveEmergentBudget
      progressiveEmergentCriterion
      progressiveRepertoire progressiveGenerator
      progressiveRepertoire_represented
      progressiveRepertoire_retained
      (progressive_recursiveEmergenceStep 0)
      progressive_has_promotionResponsiveEnvelope
      progressive_has_uniformPromotionDrivenContinuation

end ProgressivePromotionWitness

#print axioms recursiveEmergenceStep_is_operationalPromotion
#print axioms promotionResponsiveEnvelope_exposes_new_entry
#print axioms promotion_new_entry_strictly_expands_monotone_envelope
#print axioms promotionDrivenFilteredSuccessor_implies_local_successor
#print axioms uniformPromotionDrivenContinuation_implies_uniformLocalCritical
#print axioms seed_and_uniformPromotionDrivenContinuation_imply_openEndedNovelty
#print axioms seed_and_uniformPromotionDrivenContinuation_imply_unboundedEnvelope
#print axioms oneShot_promotion_has_no_generativelyConsequential_downstream
#print axioms progressive_promotion_is_generatively_consequential
#print axioms progressive_has_promotionResponsiveEnvelope
#print axioms progressive_has_uniformPromotionDrivenContinuation
#print axioms progressive_openEnded_via_endogenousEnvelopePromotion
#print axioms progressive_unboundedEnvelope_via_endogenousEnvelopePromotion

end RecursiveAccessibility
end CumulativeAccessibility
