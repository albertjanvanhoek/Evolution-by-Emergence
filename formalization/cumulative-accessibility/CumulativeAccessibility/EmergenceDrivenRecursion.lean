import CumulativeAccessibility.ConstructiveRecursiveEmergence
import CumulativeAccessibility.GeneratorRuleEvolution

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Emergence-driven recursion

This module synthesizes the previously separate emergence and second-order
accessibility strands.

The intended causal architecture is:

    parent organization
      -> compositional emergence
      -> resource / validation filtering
      -> retained integration
      -> changed operational or generative accessibility
      -> later emergent construction.

Two ratchets are deliberately separated.

1. Operational ratchet: a retained product becomes reusable material and can
   expand one-step or bounded accessibility while the next-step generator is
   held fixed.
2. Vocabulary ratchet: retained organization changes the repertoire-dependent
   generative rule itself and thereby changes full generative closure.

The fixed-generator closure theorem below makes the boundary explicit: if a
child was already generated under a fixed rule, merely promoting it cannot
enlarge the transitive closure of that same rule.
-/

section FixedClosure

variable {α : Type*} [DecidableEq α]

/-- Multi-step generative closure under one fixed finite-parent generator. -/
inductive FixedGenerativeClosure
    (G : HyperGenerator α) (A : α → Prop) : α → Prop
  | base {x} : A x → FixedGenerativeClosure G A x
  | gen {parents : Finset α} {z} :
      (∀ y, y ∈ parents → FixedGenerativeClosure G A y) →
      G parents z →
      FixedGenerativeClosure G A z

/-- Minimal hypothetical promotion of one retained child. -/
def PromotedAvailability
    (A : α → Prop) (child : α) : α → Prop :=
  fun x => A x ∨ x = child

/-- Full-closure strict expansion. Unlike one-step generated access, this asks
whether the set reachable after arbitrarily many applications of the declared
rules has genuinely enlarged. -/
def ClosureStrictExpandsOn
    (targets : Set α)
    (oldRule : HyperGenerator α) (oldAvailable : α → Prop)
    (newRule : HyperGenerator α) (newAvailable : α → Prop) : Prop :=
  (∀ z, z ∈ targets →
      FixedGenerativeClosure oldRule oldAvailable z →
      FixedGenerativeClosure newRule newAvailable z) ∧
  ∃ z, z ∈ targets ∧
    ¬ FixedGenerativeClosure oldRule oldAvailable z ∧
      FixedGenerativeClosure newRule newAvailable z

/-- Closure is monotone when both the available repertoire and the generative
rule are pointwise extended. -/
theorem fixedGenerativeClosure_mono
    (oldRule newRule : HyperGenerator α)
    (oldAvailable newAvailable : α → Prop)
    (hAvailable : ∀ x, oldAvailable x → newAvailable x)
    (hRule : GeneratorRuleLe oldRule newRule) :
    ∀ z,
      FixedGenerativeClosure oldRule oldAvailable z →
      FixedGenerativeClosure newRule newAvailable z := by
  intro z hz
  induction hz with
  | base h =>
      exact FixedGenerativeClosure.base (hAvailable _ h)
  | gen hParents hGenerate ih =>
      exact FixedGenerativeClosure.gen ih (hRule _ _ hGenerate)

/-- Reviewer P9, promoted into the core: under a fixed generator, promoting a
child already generated from the current repertoire cannot create anything
outside the old multi-step closure. -/
theorem generatedPromotion_preserves_fixedGeneratorClosure
    (G : HyperGenerator α)
    (A : α → Prop)
    {child : α}
    (hChild : GeneratedFromAvailable A G child) :
    ∀ z,
      FixedGenerativeClosure G (PromotedAvailability A child) z →
      FixedGenerativeClosure G A z := by
  obtain ⟨parents, hAvailable, hGenerate⟩ := hChild
  have hChildClosure : FixedGenerativeClosure G A child :=
    FixedGenerativeClosure.gen
      (fun y hy => FixedGenerativeClosure.base (hAvailable y hy))
      hGenerate
  intro z hz
  induction hz with
  | base h =>
      rcases h with hOld | hEq
      · exact FixedGenerativeClosure.base hOld
      · subst hEq
        exact hChildClosure
  | gen _ hGenerate ih =>
      exact FixedGenerativeClosure.gen ih hGenerate

/-- Therefore internal promotion under a fixed generator is closure-invariant:
it may shorten paths or change one-step access, but it cannot be a
closure-changing vocabulary event. -/
theorem generatedPromotion_fixedGeneratorClosure_iff
    (G : HyperGenerator α)
    (A : α → Prop)
    {child z : α}
    (hChild : GeneratedFromAvailable A G child) :
    FixedGenerativeClosure G (PromotedAvailability A child) z ↔
      FixedGenerativeClosure G A z := by
  constructor
  · exact generatedPromotion_preserves_fixedGeneratorClosure G A hChild z
  · intro hz
    exact fixedGenerativeClosure_mono
      G G A (PromotedAvailability A child)
      (fun x hx => Or.inl hx)
      (fun _ _ h => h)
      z hz

/-- In particular, a child already generated under a fixed rule cannot, merely
by promotion, witness strict closure expansion. -/
theorem internallyGeneratedPromotion_not_closureStrictExpansion
    (targets : Set α)
    (G : HyperGenerator α)
    (A : α → Prop)
    {child : α}
    (hChild : GeneratedFromAvailable A G child) :
    ¬ ClosureStrictExpandsOn
      targets G A G (PromotedAvailability A child) := by
  intro hExpansion
  obtain ⟨z, hzTarget, hzOld, hzNew⟩ := hExpansion.2
  exact hzOld
    (generatedPromotion_preserves_fixedGeneratorClosure
      G A hChild z hzNew)

end FixedClosure

section ParentFaithfulEmergence

variable {Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- A strong specialization in which the generating finite parent set is itself
the configuration whose organization is tested for compositional emergence.

This removes the constructive-equivalence seam: proper subconfigurations are
literally proper subsets of the causal parent configuration. -/
def ParentFaithfulRecursiveEmergenceStepAt
    (H : ℕ → HyperGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    (parent child : Capacity) : Prop :=
  parent ∈ S m ∧
  ∃ parents ctx,
    parent ∈ parents ∧
    (∀ x, x ∈ parents → x ∈ S m) ∧
    H m parents child ∧
    ResourceValidatedEmergentIntegrationAt
      (FiniteProperSubconfig (Process := Capacity))
      Realizes Cost Budget E S m parents ctx child

/-- The canonical parent-set construction rule associated with a generator. -/
def ParentSetConstructionFromGenerator
    (H : ℕ → HyperGenerator Capacity) :
    ℕ → ConfigurationConstructionRule (Finset Capacity) Capacity :=
  fun m parents config child =>
    config = parents ∧ H m parents child

/-- Parent-faithful emergence is a genuine instance of the earlier
constructive-recursive interface, with no freedom to attach an unrelated
configuration to the event. -/
theorem parentFaithful_implies_constructiveRecursiveEmergence
    (H : ℕ → HyperGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    {parent child : Capacity}
    (h :
      ParentFaithfulRecursiveEmergenceStepAt
        H Realizes Cost Budget E S m parent child) :
    ConstructiveRecursiveEmergenceStepAt
      (ParentSetConstructionFromGenerator H)
      (FiniteProperSubconfig (Process := Capacity))
      Realizes Cost Budget E S m parent child := by
  rcases h with
    ⟨hParent, parents, ctx,
      hParentIn, hAvailable, hGenerate, hEvent⟩
  exact
    ⟨hParent, parents, parents, ctx,
      hParentIn, hAvailable, ⟨rfl, hGenerate⟩, hEvent⟩

/-- The designated causal parent set really is an emergent realizer of the
retained child. -/
theorem parentFaithful_has_emergent_parent_configuration
    (H : ℕ → HyperGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    {parent child : Capacity}
    (h :
      ParentFaithfulRecursiveEmergenceStepAt
        H Realizes Cost Budget E S m parent child) :
    ∃ parents ctx,
      parent ∈ parents ∧
      (∀ x, x ∈ parents → x ∈ S m) ∧
      H m parents child ∧
      EmergentUnder
        (FiniteProperSubconfig (Process := Capacity))
        Realizes parents ctx child := by
  rcases h with
    ⟨_, parents, ctx,
      hParentIn, hAvailable, hGenerate, hEvent⟩
  exact
    ⟨parents, ctx, hParentIn, hAvailable, hGenerate, hEvent.1⟩

/-- Forgetting emergence and filtering yields ordinary generation from the
current retained repertoire. -/
theorem parentFaithful_implies_generated
    (H : ℕ → HyperGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    {parent child : Capacity}
    (h :
      ParentFaithfulRecursiveEmergenceStepAt
        H Realizes Cost Budget E S m parent child) :
    GeneratedFromAvailable (fun x => x ∈ S m) (H m) child := by
  rcases h with
    ⟨_, parents, _, _, hAvailable, hGenerate, _⟩
  exact ⟨parents, hAvailable, hGenerate⟩

/-- A parent-faithful emergent product is genuinely new to the active
repertoire and retained at the next step. -/
theorem parentFaithful_retains_new_child
    (H : ℕ → HyperGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    {parent child : Capacity}
    (h :
      ParentFaithfulRecursiveEmergenceStepAt
        H Realizes Cost Budget E S m parent child) :
    RetainedIntegrationAt S m child := by
  rcases h with
    ⟨_, _, _, _, _, _, hEvent⟩
  exact hEvent.2.1

end ParentFaithfulEmergence

section OperationalRatchet

variable {Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- Two successive parent-faithful emergence events in which the first child is
explicitly reused as a parent of the second, and the second child was not
one-step generable from the pre-retention repertoire when the next-step rule is
held fixed. -/
def EmergenceDrivenTwoGenerationRatchetAt
    (targets : Set Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    (seed first second : Capacity) : Prop :=
  ParentFaithfulRecursiveEmergenceStepAt
      H Realizes Cost Budget E S m seed first ∧
  ParentFaithfulRecursiveEmergenceStepAt
      H Realizes Cost Budget E S (m + 1) first second ∧
  second ∈ targets ∧
  ¬ GeneratedFromAvailable (fun x => x ∈ S m) (H (m + 1)) second

/-- The two-generation emergence ratchet derives a strict one-step
accessibility expansion across retention of the first emergent product, while
holding the next-step generator fixed for the comparison. -/
theorem twoGenerationRatchet_strictlyExpands_oneStepAccess
    (targets : Set Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    {seed first second : Capacity}
    (hPreserve : S m ⊆ S (m + 1))
    (hRatchet :
      EmergenceDrivenTwoGenerationRatchetAt
        targets H Realizes Cost Budget E S m seed first second) :
    StrictExpandsOn targets
      (GeneratedFromAvailable (fun x => x ∈ S m) (H (m + 1)))
      (GeneratedFromAvailable (fun x => x ∈ S (m + 1)) (H (m + 1))) := by
  refine ⟨?_, second, hRatchet.2.2.1, hRatchet.2.2.2, ?_⟩
  · exact generatedFromAvailable_mono
      targets
      (fun x => x ∈ S m)
      (fun x => x ∈ S (m + 1))
      (H (m + 1))
      hPreserve
  · exact parentFaithful_implies_generated
      H Realizes Cost Budget E S (m + 1) hRatchet.2.1

end OperationalRatchet

section RepertoireDrivenVocabulary

variable {Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- A generator whose rule is determined by the currently retained repertoire.
This is the explicit higher-order interface needed for vocabulary evolution. -/
abbrev RepertoireDependentGenerator (Capacity : Type*) :=
  (Capacity → Prop) → HyperGenerator Capacity

/-- Time-indexed generator induced by the active retained repertoire. -/
def GeneratorFromRepertoire
    (RuleOf : RepertoireDependentGenerator Capacity)
    (S : ℕ → Finset Capacity) :
    ℕ → HyperGenerator Capacity :=
  fun m => RuleOf (fun x => x ∈ S m)

/-- Isolation condition: the next repertoire differs from the old repertoire
only by integration of the declared child. This makes the counterfactual
attribution to that retained product explicit. -/
def IsolatedRetainedIntegrationAt
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    (child : Capacity) : Prop :=
  ∀ x, x ∈ S (m + 1) ↔ x ∈ S m ∨ x = child

/-- Strong vocabulary-emergence event: a parent-faithful emergent product is
retained as the only repertoire addition, the generator is a declared function
of that repertoire, and full generative closure strictly expands. -/
def EmergenceDrivenVocabularyExpansionAt
    (targets : Set Capacity)
    (RuleOf : RepertoireDependentGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    (parent child : Capacity) : Prop :=
  ParentFaithfulRecursiveEmergenceStepAt
      (GeneratorFromRepertoire RuleOf S)
      Realizes Cost Budget E S m parent child ∧
  IsolatedRetainedIntegrationAt S m child ∧
  ClosureStrictExpandsOn targets
      (RuleOf (fun x => x ∈ S m))
      (fun x => x ∈ S m)
      (RuleOf (fun x => x ∈ S (m + 1)))
      (fun x => x ∈ S (m + 1))

/-- If the repertoire-dependent generator is actually constant, an internally
generated emergent child cannot satisfy the strong vocabulary-expansion clause.
This is the fixed-generator no-go stated directly at the EbE event level. -/
theorem constantRule_parentFaithfulPromotion_not_vocabularyExpansion
    (targets : Set Capacity)
    (G : HyperGenerator Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ → Finset Capacity)
    (m : ℕ)
    {parent child : Capacity}
    (hEvent :
      ParentFaithfulRecursiveEmergenceStepAt
        (fun _ => G) Realizes Cost Budget E S m parent child)
    (hIsolated : IsolatedRetainedIntegrationAt S m child) :
    ¬ ClosureStrictExpandsOn targets
        G (fun x => x ∈ S m)
        G (fun x => x ∈ S (m + 1)) := by
  have hChild :
      GeneratedFromAvailable (fun x => x ∈ S m) G child :=
    parentFaithful_implies_generated
      (fun _ => G) Realizes Cost Budget E S m hEvent
  have hAvailabilityEq :
      (fun x => x ∈ S (m + 1)) =
        PromotedAvailability (fun x => x ∈ S m) child := by
    funext x
    apply propext
    exact hIsolated x
  rw [hAvailabilityEq]
  exact internallyGeneratedPromotion_not_closureStrictExpansion
    targets G (fun x => x ∈ S m) hChild

end RepertoireDrivenVocabulary

section ConcreteEndToEndWitness

/-- Four capacities suffice for a two-generation end-to-end witness. -/
inductive EmergenceToy
  | a | b | c | d
  deriving DecidableEq

open EmergenceToy

/-- Initial parts a,b; first emergent product c; then second product d. -/
def emergenceToyRepertoire : ℕ → Finset EmergenceToy
  | 0 => {a, b}
  | 1 => {a, b, c}
  | _ => {a, b, c, d}

/-- The construction vocabulary is repertoire-dependent.

Before c exists, {a,b} can construct c.
Once c is retained, a new rule {b,c} -> d becomes part of the generator. -/
def emergenceToyRuleOf
    (Available : EmergenceToy → Prop) : HyperGenerator EmergenceToy
  | parents, c => parents = {a, b}
  | parents, d => Available c ∧ parents = {b, c}
  | _, _ => False

def emergenceToyGenerator : ℕ → HyperGenerator EmergenceToy :=
  GeneratorFromRepertoire emergenceToyRuleOf emergenceToyRepertoire

/-- The first parent organization realizes c; the second realizes d.
Because realization requires the exact full parent set, no proper subset
realizes the respective capacity. -/
def emergenceToyRealizes :
    CapacityRelation (Finset EmergenceToy) ℕ EmergenceToy :=
  fun config ctx capacity =>
    (ctx = 0 ∧ config = {a, b} ∧ capacity = c) ∨
    (ctx = 1 ∧ config = {b, c} ∧ capacity = d)

def emergenceToyCost : ResponseCost EmergenceToy := fun _ _ => 0
def emergenceToyBudget : ResponseBudget := fun _ => 0
def emergenceToyCriterion : ExternalCriterion EmergenceToy := fun _ _ => True

theorem emergenceToy_first_parentFaithfulEmergence :
    ParentFaithfulRecursiveEmergenceStepAt
      emergenceToyGenerator emergenceToyRealizes
      emergenceToyCost emergenceToyBudget emergenceToyCriterion
      emergenceToyRepertoire 0 a c := by
  refine ⟨?_, {a, b}, 0, ?_, ?_, ?_, ?_⟩
  · simp [emergenceToyRepertoire]
  · simp
  · intro x hx
    simpa [emergenceToyRepertoire] using hx
  · simp [emergenceToyGenerator, GeneratorFromRepertoire,
      emergenceToyRuleOf]
  · constructor
    · constructor
      · simp [emergenceToyRealizes]
      · intro sub hProper hRealizes
        have hEq : sub = {a, b} := by
          simpa [emergenceToyRealizes] using hRealizes
        exact (Finset.ssubset_iff_subset_ne.mp hProper).2 hEq
    · refine ⟨?_, ?_, ?_⟩
      · simp [RetainedIntegrationAt, emergenceToyRepertoire]
      · simp [ResourceFeasibleAt, AccessibleByCost,
          emergenceToyCost, emergenceToyBudget]
      · simp [emergenceToyCriterion]

theorem emergenceToy_second_parentFaithfulEmergence :
    ParentFaithfulRecursiveEmergenceStepAt
      emergenceToyGenerator emergenceToyRealizes
      emergenceToyCost emergenceToyBudget emergenceToyCriterion
      emergenceToyRepertoire 1 c d := by
  refine ⟨?_, {b, c}, 1, ?_, ?_, ?_, ?_⟩
  · simp [emergenceToyRepertoire]
  · simp
  · intro x hx
    simpa [emergenceToyRepertoire] using hx
  · simp [emergenceToyGenerator, GeneratorFromRepertoire,
      emergenceToyRuleOf, emergenceToyRepertoire]
  · constructor
    · constructor
      · simp [emergenceToyRealizes]
      · intro sub hProper hRealizes
        have hEq : sub = {b, c} := by
          simpa [emergenceToyRealizes] using hRealizes
        exact (Finset.ssubset_iff_subset_ne.mp hProper).2 hEq
    · refine ⟨?_, ?_, ?_⟩
      · simp [RetainedIntegrationAt, emergenceToyRepertoire]
      · simp [ResourceFeasibleAt, AccessibleByCost,
          emergenceToyCost, emergenceToyBudget]
      · simp [emergenceToyCriterion]

/-- The first retained repertoire is exactly the old repertoire plus the first
emergent product; no other simultaneous addition can explain the rule change. -/
theorem emergenceToy_first_integration_isolated :
    IsolatedRetainedIntegrationAt emergenceToyRepertoire 0 c := by
  intro x
  simp [IsolatedRetainedIntegrationAt, emergenceToyRepertoire]
  aesop

/-- Holding the next rule fixed, d is not one-step generable before c is
retained because the required parent set {b,c} is unavailable. -/
theorem emergenceToy_d_not_generated_preRetention_under_nextRule :
    ¬ GeneratedFromAvailable
        (fun x => x ∈ emergenceToyRepertoire 0)
        (emergenceToyGenerator 1) d := by
  rintro ⟨parents, hAvailable, hRule⟩
  have hParents : parents = {b, c} := by
    simpa [emergenceToyGenerator, GeneratorFromRepertoire,
      emergenceToyRuleOf, emergenceToyRepertoire] using hRule
  subst parents
  have hc := hAvailable c (by simp)
  simp [emergenceToyRepertoire] at hc

theorem emergenceToy_first_retention_preserves_old :
    emergenceToyRepertoire 0 ⊆ emergenceToyRepertoire 1 := by
  intro x hx
  simp [emergenceToyRepertoire] at hx ⊢
  aesop

/-- Concrete operational ratchet: the first emergent product is retained and
explicitly reused in the second emergent construction, and this strictly
expands next-step generated access. -/
theorem emergenceToy_twoGeneration_operationalRatchet :
    EmergenceDrivenTwoGenerationRatchetAt
      Set.univ emergenceToyGenerator emergenceToyRealizes
      emergenceToyCost emergenceToyBudget emergenceToyCriterion
      emergenceToyRepertoire 0 a c d := by
  exact ⟨
    emergenceToy_first_parentFaithfulEmergence,
    emergenceToy_second_parentFaithfulEmergence,
    by simp,
    emergenceToy_d_not_generated_preRetention_under_nextRule⟩

theorem emergenceToy_twoGeneration_strict_oneStepExpansion :
    StrictExpandsOn Set.univ
      (GeneratedFromAvailable
        (fun x => x ∈ emergenceToyRepertoire 0)
        (emergenceToyGenerator 1))
      (GeneratedFromAvailable
        (fun x => x ∈ emergenceToyRepertoire 1)
        (emergenceToyGenerator 1)) := by
  exact twoGenerationRatchet_strictlyExpands_oneStepAccess
    Set.univ emergenceToyGenerator emergenceToyRealizes
    emergenceToyCost emergenceToyBudget emergenceToyCriterion
    emergenceToyRepertoire 0
    emergenceToy_first_retention_preserves_old
    emergenceToy_twoGeneration_operationalRatchet

/-- Under the old repertoire-dependent rule, d is outside full generative
closure: before c is retained, the rule that could construct d does not exist. -/
theorem emergenceToy_d_not_in_old_closure :
    ¬ FixedGenerativeClosure
        (emergenceToyRuleOf
          (fun x => x ∈ emergenceToyRepertoire 0))
        (fun x => x ∈ emergenceToyRepertoire 0)
        d := by
  intro h
  cases h with
  | base hAvailable =>
      simpa [emergenceToyRepertoire] using hAvailable
  | gen hParents hRule =>
      simpa [emergenceToyRuleOf, emergenceToyRepertoire] using hRule

/-- After c is retained, the repertoire-dependent rule exposes {b,c}->d,
so d enters full generative closure. -/
theorem emergenceToy_d_in_new_closure :
    FixedGenerativeClosure
      (emergenceToyRuleOf
        (fun x => x ∈ emergenceToyRepertoire 1))
      (fun x => x ∈ emergenceToyRepertoire 1)
      d := by
  refine FixedGenerativeClosure.gen (parents := {b, c}) ?_ ?_
  · intro x hx
    exact FixedGenerativeClosure.base (by
      simpa [emergenceToyRepertoire] using hx)
  · simp [emergenceToyRuleOf, emergenceToyRepertoire]

theorem emergenceToy_rule_preserves_old_generations :
    GeneratorRuleLe
      (emergenceToyRuleOf
        (fun x => x ∈ emergenceToyRepertoire 0))
      (emergenceToyRuleOf
        (fun x => x ∈ emergenceToyRepertoire 1)) := by
  intro parents z h
  cases z <;>
    simp [emergenceToyRuleOf, emergenceToyRepertoire] at h ⊢
  exact h

/-- The first emergent retained module genuinely changes full generative
closure because the generative rule is a function of retained organization. -/
theorem emergenceToy_closure_strictly_expands :
    ClosureStrictExpandsOn Set.univ
      (emergenceToyRuleOf
        (fun x => x ∈ emergenceToyRepertoire 0))
      (fun x => x ∈ emergenceToyRepertoire 0)
      (emergenceToyRuleOf
        (fun x => x ∈ emergenceToyRepertoire 1))
      (fun x => x ∈ emergenceToyRepertoire 1) := by
  refine ⟨?_, d, by simp, emergenceToy_d_not_in_old_closure,
    emergenceToy_d_in_new_closure⟩
  intro z hzTarget hzOld
  exact fixedGenerativeClosure_mono
    (emergenceToyRuleOf
      (fun x => x ∈ emergenceToyRepertoire 0))
    (emergenceToyRuleOf
      (fun x => x ∈ emergenceToyRepertoire 1))
    (fun x => x ∈ emergenceToyRepertoire 0)
    (fun x => x ∈ emergenceToyRepertoire 1)
    emergenceToy_first_retention_preserves_old
    emergenceToy_rule_preserves_old_generations
    z hzOld

/-- Strong vocabulary event: parent-faithful emergence, isolated retention, and
closure expansion all hold in one event. -/
theorem emergenceToy_first_is_vocabularyExpansion :
    EmergenceDrivenVocabularyExpansionAt
      Set.univ emergenceToyRuleOf emergenceToyRealizes
      emergenceToyCost emergenceToyBudget emergenceToyCriterion
      emergenceToyRepertoire 0 a c := by
  exact ⟨
    emergenceToy_first_parentFaithfulEmergence,
    emergenceToy_first_integration_isolated,
    emergenceToy_closure_strictly_expands⟩

/-- End-to-end milestone.

The first parent organization jointly realizes emergent c; c is filtered and
retained; because the generator is repertoire-dependent, that isolated
integration changes full generative closure and makes d reachable; retained c
is then explicitly reused in the parent configuration whose organization
realizes emergent d.

This is a satisfiability/causal-architecture witness, not a claim that every
emergence event changes the generator or that every real system follows these
toy rules. -/
theorem emergenceToy_endToEnd_emergenceDrivenRecursion :
    EmergenceDrivenVocabularyExpansionAt
        Set.univ emergenceToyRuleOf emergenceToyRealizes
        emergenceToyCost emergenceToyBudget emergenceToyCriterion
        emergenceToyRepertoire 0 a c ∧
    ParentFaithfulRecursiveEmergenceStepAt
        emergenceToyGenerator emergenceToyRealizes
        emergenceToyCost emergenceToyBudget emergenceToyCriterion
        emergenceToyRepertoire 1 c d ∧
    ¬ FixedGenerativeClosure
        (emergenceToyGenerator 0)
        (fun x => x ∈ emergenceToyRepertoire 0)
        d ∧
    FixedGenerativeClosure
        (emergenceToyGenerator 1)
        (fun x => x ∈ emergenceToyRepertoire 1)
        d := by
  refine ⟨
    emergenceToy_first_is_vocabularyExpansion,
    emergenceToy_second_parentFaithfulEmergence,
    ?_,
    ?_⟩
  · simpa [emergenceToyGenerator, GeneratorFromRepertoire] using
      emergenceToy_d_not_in_old_closure
  · simpa [emergenceToyGenerator, GeneratorFromRepertoire] using
      emergenceToy_d_in_new_closure

#print axioms generatedPromotion_preserves_fixedGeneratorClosure
#print axioms generatedPromotion_fixedGeneratorClosure_iff
#print axioms internallyGeneratedPromotion_not_closureStrictExpansion
#print axioms parentFaithful_implies_constructiveRecursiveEmergence
#print axioms parentFaithful_has_emergent_parent_configuration
#print axioms twoGenerationRatchet_strictlyExpands_oneStepAccess
#print axioms constantRule_parentFaithfulPromotion_not_vocabularyExpansion
#print axioms emergenceToy_first_parentFaithfulEmergence
#print axioms emergenceToy_second_parentFaithfulEmergence
#print axioms emergenceToy_twoGeneration_strict_oneStepExpansion
#print axioms emergenceToy_closure_strictly_expands
#print axioms emergenceToy_first_is_vocabularyExpansion
#print axioms emergenceToy_endToEnd_emergenceDrivenRecursion

end ConcreteEndToEndWitness

end RecursiveAccessibility
end CumulativeAccessibility
