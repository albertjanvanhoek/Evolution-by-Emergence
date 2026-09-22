import CumulativeAccessibility.EmergentCapacity
import CumulativeAccessibility.ResponseDynamics
import CumulativeAccessibility.CapacityUptake

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Organization-driven emergence

This module makes organization, rather than capacity labels or certified
operators, the primary state variable.

The fixed ingredients are:

* retained organizations O_t;
* a context-dependent realization relation Realizes organization context phi;
* a proper-part relation between organizations;
* a fixed background assembly rule;
* a fixed rule describing how a realized function can be used.

No permission or certification predicate is present.

If an organization exists, it has every function that Realizes assigns to it.
Persistence decides whether that organization remains available to the system.
Once retained, all functions it realizes are automatically available for later
construction.

The causal architecture is therefore:

    retained organizations
      -> assemble a new organization
      -> the whole realizes a function
      -> proper parts do not realize that function       [emergence]
      -> persistence gate decides whether the whole remains
      -> if retained, its realized function is available automatically
      -> that function may alter later organizational accessibility.

The underlying realization, assembly, and use laws may remain fixed throughout.
A change in effective accessibility therefore need not be a mutation of a
fundamental generator.
-/

section FunctionalState

variable {Organization Context Capacity : Type*}
variable [DecidableEq Organization]

/-- A fixed law saying how a realized capacity can participate in later
organization. -/
abbrev FunctionalUseRule (Capacity Organization : Type*) :=
  Capacity -> Finset Organization -> Organization -> Prop

/-- Capacity phi is functionally available when some retained organization
realizes it in the declared context. -/
def FunctionAvailable
    (Realizes : CapacityRelation Organization Context Capacity)
    (ctx : Context)
    (Available : Organization -> Prop)
    (phi : Capacity) : Prop :=
  ∃ organization, Available organization ∧ Realizes organization ctx phi

/-- The effective construction relation induced by the currently retained
organizations.

The laws Base, Realizes, and Use are fixed.  State dependence enters only
through which organizations are currently available. -/
def EffectiveOrganizationGenerator
    (Base : HyperGenerator Organization)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (ctx : Context)
    (Available : Organization -> Prop) :
    HyperGenerator Organization :=
  fun parents child =>
    Base parents child ∨
      ∃ phi,
        FunctionAvailable Realizes ctx Available phi ∧
        Use phi parents child

/-- Functional availability is monotone when retained organization is added. -/
theorem functionAvailable_mono
    (Realizes : CapacityRelation Organization Context Capacity)
    (ctx : Context)
    {oldAvailable newAvailable : Organization -> Prop}
    (hAvail : ∀ x, oldAvailable x -> newAvailable x) :
    ∀ phi,
      FunctionAvailable Realizes ctx oldAvailable phi ->
      FunctionAvailable Realizes ctx newAvailable phi := by
  intro phi h
  rcases h with ⟨organization, hOld, hRealizes⟩
  exact ⟨organization, hAvail organization hOld, hRealizes⟩

/-- Effective construction is monotone under retention when the underlying
laws themselves are unchanged. -/
theorem effectiveOrganizationGenerator_mono
    (Base : HyperGenerator Organization)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (ctx : Context)
    {oldAvailable newAvailable : Organization -> Prop}
    (hAvail : ∀ x, oldAvailable x -> newAvailable x) :
    GeneratorRuleLe
      (EffectiveOrganizationGenerator Base Realizes Use ctx oldAvailable)
      (EffectiveOrganizationGenerator Base Realizes Use ctx newAvailable) := by
  intro parents child h
  rcases h with hBase | ⟨phi, hFunction, hUse⟩
  · exact Or.inl hBase
  · exact Or.inr
      ⟨phi,
        functionAvailable_mono Realizes ctx hAvail phi hFunction,
        hUse⟩

end FunctionalState

section Reachability

variable {Organization : Type*}
variable [DecidableEq Organization]

/-- Full multi-step organizational reach under one declared effective
construction relation. -/
inductive OrganizationReach
    (Generate : HyperGenerator Organization)
    (Available : Organization -> Prop) : Organization -> Prop
  | base {x} :
      Available x ->
      OrganizationReach Generate Available x
  | gen {parents : Finset Organization} {z} :
      (∀ x, x ∈ parents -> OrganizationReach Generate Available x) ->
      Generate parents z ->
      OrganizationReach Generate Available z

theorem organizationReach_mono
    (oldGenerate newGenerate : HyperGenerator Organization)
    (oldAvailable newAvailable : Organization -> Prop)
    (hAvail : ∀ x, oldAvailable x -> newAvailable x)
    (hGenerate : GeneratorRuleLe oldGenerate newGenerate) :
    ∀ z,
      OrganizationReach oldGenerate oldAvailable z ->
      OrganizationReach newGenerate newAvailable z := by
  intro z hz
  induction hz with
  | base h =>
      exact OrganizationReach.base (hAvail _ h)
  | gen hParents hRule ih =>
      exact OrganizationReach.gen ih (hGenerate _ _ hRule)

/-- Pure promotion of an organization already reachable under a fixed
construction relation does not enlarge full transitive reach.  This is the
organization-level form of the P9 boundary. -/
theorem reachableOrganizationPromotion_preserves_fixedReach
    (Generate : HyperGenerator Organization)
    (Available : Organization -> Prop)
    {organization : Organization}
    (hReach : OrganizationReach Generate Available organization) :
    ∀ z,
      OrganizationReach Generate
        (fun x => Available x ∨ x = organization) z ->
      OrganizationReach Generate Available z := by
  intro z hz
  induction hz with
  | base h =>
      rcases h with hOld | hEq
      · exact OrganizationReach.base hOld
      · subst hEq
        exact hReach
  | gen hParents hRule ih =>
      exact OrganizationReach.gen ih hRule

end Reachability

section Persistence

variable {Organization : Type*}
variable [DecidableEq Organization]

/-- The downstream persistence gate.  Function exists before this gate;
the gate decides only whether the organization remains available. -/
def OrganizationPersistenceGateAt
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (t : ℕ)
    (organization : Organization) : Prop :=
  ResourceFeasibleAt Cost Budget t organization ∧ Keep t organization

/-- Isolated one-event persistence law: old organization remains, and the
declared organization is added exactly when it passes the persistence gate. -/
def IsolatedOrganizationPersistenceLawAt
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (t : ℕ)
    (organization : Organization) : Prop :=
  ∀ x,
    x ∈ O (t + 1) ↔
      x ∈ O t ∨
        (x = organization ∧
          OrganizationPersistenceGateAt Cost Budget Keep t organization)

theorem persistenceLaw_preserves_old
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (t : ℕ)
    (organization : Organization)
    (hLaw :
      IsolatedOrganizationPersistenceLawAt
        Cost Budget Keep O t organization) :
    O t ⊆ O (t + 1) := by
  intro x hx
  exact (hLaw x).2 (Or.inl hx)

theorem persistenceLaw_gate_retains
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (t : ℕ)
    (organization : Organization)
    (hGate :
      OrganizationPersistenceGateAt Cost Budget Keep t organization)
    (hLaw :
      IsolatedOrganizationPersistenceLawAt
        Cost Budget Keep O t organization) :
    organization ∈ O (t + 1) := by
  exact (hLaw organization).2 (Or.inr ⟨rfl, hGate⟩)

theorem persistenceLaw_gateFailure_does_not_retain_new
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (t : ℕ)
    (organization : Organization)
    (hNew : organization ∉ O t)
    (hFail :
      ¬ OrganizationPersistenceGateAt Cost Budget Keep t organization)
    (hLaw :
      IsolatedOrganizationPersistenceLawAt
        Cost Budget Keep O t organization) :
    organization ∉ O (t + 1) := by
  intro hNext
  rcases (hLaw organization).1 hNext with hOld | ⟨_, hGate⟩
  · exact hNew hOld
  · exact hFail hGate

end Persistence

section EmergentOrganizationEvent

variable {Organization Context Capacity : Type*}
variable [DecidableEq Organization]

/-- One organization-driven emergence-and-persistence event.

The causal parent organizations are declared proper parts of the constructed
whole.  The whole realizes phi emergently.  Function realization is immediate;
the persistence gate acts only after function exists. -/
def EmergentOrganizationPersistenceAt
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (t : ℕ)
    (parents : Finset Organization)
    (organization : Organization)
    (ctx : Context)
    (phi : Capacity) : Prop :=
  2 ≤ parents.card ∧
  (∀ x, x ∈ parents -> x ∈ O t) ∧
  (∀ x, x ∈ parents -> Proper x organization) ∧
  EffectiveOrganizationGenerator
      Base Realizes Use ctx (fun x => x ∈ O t)
      parents organization ∧
  EmergentUnder Proper Realizes organization ctx phi ∧
  organization ∉ O t ∧
  OrganizationPersistenceGateAt Cost Budget Keep t organization ∧
  IsolatedOrganizationPersistenceLawAt
    Cost Budget Keep O t organization

theorem emergentOrganization_function_exists
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (t : ℕ)
    {parents : Finset Organization}
    {organization : Organization}
    {ctx : Context}
    {phi : Capacity}
    (h :
      EmergentOrganizationPersistenceAt
        Base Proper Realizes Use Cost Budget Keep O
        t parents organization ctx phi) :
    Realizes organization ctx phi := by
  exact h.2.2.2.2.1.1

theorem emergentOrganization_excludes_proper_part_function
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (t : ℕ)
    {parents : Finset Organization}
    {organization part : Organization}
    {ctx : Context}
    {phi : Capacity}
    (h :
      EmergentOrganizationPersistenceAt
        Base Proper Realizes Use Cost Budget Keep O
        t parents organization ctx phi)
    (hProper : Proper part organization) :
    ¬ Realizes part ctx phi := by
  exact h.2.2.2.2.1.2 part hProper

theorem emergentOrganization_retained
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (t : ℕ)
    {parents : Finset Organization}
    {organization : Organization}
    {ctx : Context}
    {phi : Capacity}
    (h :
      EmergentOrganizationPersistenceAt
        Base Proper Realizes Use Cost Budget Keep O
        t parents organization ctx phi) :
    organization ∈ O (t + 1) := by
  exact persistenceLaw_gate_retains
    Cost Budget Keep O t organization
    h.2.2.2.2.2.2.1
    h.2.2.2.2.2.2.2

theorem emergentOrganization_old_retained
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (t : ℕ)
    {parents : Finset Organization}
    {organization : Organization}
    {ctx : Context}
    {phi : Capacity}
    (h :
      EmergentOrganizationPersistenceAt
        Base Proper Realizes Use Cost Budget Keep O
        t parents organization ctx phi) :
    O t ⊆ O (t + 1) := by
  exact persistenceLaw_preserves_old
    Cost Budget Keep O t organization
    h.2.2.2.2.2.2.2

/-- Once the whole persists, its already-existing function is automatically
available.  There is no additional authorization step. -/
theorem emergentOrganization_function_available_after_persistence
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (t : ℕ)
    {parents : Finset Organization}
    {organization : Organization}
    {ctx : Context}
    {phi : Capacity}
    (h :
      EmergentOrganizationPersistenceAt
        Base Proper Realizes Use Cost Budget Keep O
        t parents organization ctx phi) :
    FunctionAvailable Realizes ctx (fun x => x ∈ O (t + 1)) phi := by
  exact ⟨organization,
    emergentOrganization_retained
      Base Proper Realizes Use Cost Budget Keep O t h,
    emergentOrganization_function_exists
      Base Proper Realizes Use Cost Budget Keep O t h⟩

end EmergentOrganizationEvent

section FunctionalVocabulary

variable {Organization Context Capacity : Type*}
variable [DecidableEq Organization]

/-- The emergent function is new to the currently retained system when no
retained organization already realizes it. -/
def FunctionallyNovelToRetainedSystem
    (Realizes : CapacityRelation Organization Context Capacity)
    (ctx : Context)
    (O : ℕ -> Finset Organization)
    (t : ℕ)
    (phi : Capacity) : Prop :=
  ¬ FunctionAvailable Realizes ctx (fun x => x ∈ O t) phi

/-- Strong vocabulary-emergence specialization: an emergent organization
persists and the function it realizes was absent from every previously retained
organization. -/
def RetainedVocabularyEmergenceAt
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (t : ℕ)
    (parents : Finset Organization)
    (organization : Organization)
    (ctx : Context)
    (phi : Capacity) : Prop :=
  EmergentOrganizationPersistenceAt
    Base Proper Realizes Use Cost Budget Keep O
    t parents organization ctx phi ∧
  FunctionallyNovelToRetainedSystem Realizes ctx O t phi

theorem retainedVocabularyEmergence_strictly_expands_availableFunctions
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (t : ℕ)
    {parents : Finset Organization}
    {organization : Organization}
    {ctx : Context}
    {phi : Capacity}
    (h :
      RetainedVocabularyEmergenceAt
        Base Proper Realizes Use Cost Budget Keep O
        t parents organization ctx phi) :
    StrictExpandsOn Set.univ
      (FunctionAvailable Realizes ctx (fun x => x ∈ O t))
      (FunctionAvailable Realizes ctx (fun x => x ∈ O (t + 1))) := by
  refine ⟨?_, phi, by simp, h.2, ?_⟩
  · intro psi hTarget hOld
    exact functionAvailable_mono
      Realizes ctx
      (fun x hx =>
        emergentOrganization_old_retained
          Base Proper Realizes Use Cost Budget Keep O t h.1 hx)
      psi hOld
  · exact emergentOrganization_function_available_after_persistence
      Base Proper Realizes Use Cost Budget Keep O t h.1

end FunctionalVocabulary

section AccessibilityConsequence

variable {Organization Context Capacity : Type*}
variable [DecidableEq Organization]

/-- If the retained emergent function can be used to construct a product that
was outside the old full reach, then retaining the organization strictly
expands organizational reach.

The underlying Base, Realizes, and Use laws are unchanged.  The accessibility
change comes from retaining a new organization with an already-realized
function. -/
theorem retainedEmergentFunction_can_expand_fullReach
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (O : ℕ -> Finset Organization)
    (t : ℕ)
    {parents : Finset Organization}
    {organization : Organization}
    {ctx : Context}
    {phi : Capacity}
    (h :
      EmergentOrganizationPersistenceAt
        Base Proper Realizes Use Cost Budget Keep O
        t parents organization ctx phi)
    {useParents : Finset Organization}
    {product : Organization}
    (hUse : Use phi useParents product)
    (hUseParents : ∀ x, x ∈ useParents -> x ∈ O (t + 1))
    (hOldNot :
      ¬ OrganizationReach
        (EffectiveOrganizationGenerator
          Base Realizes Use ctx (fun x => x ∈ O t))
        (fun x => x ∈ O t)
        product) :
    StrictExpandsOn Set.univ
      (OrganizationReach
        (EffectiveOrganizationGenerator
          Base Realizes Use ctx (fun x => x ∈ O t))
        (fun x => x ∈ O t))
      (OrganizationReach
        (EffectiveOrganizationGenerator
          Base Realizes Use ctx (fun x => x ∈ O (t + 1)))
        (fun x => x ∈ O (t + 1))) := by
  have hAvail :
      ∀ x, x ∈ O t -> x ∈ O (t + 1) :=
    fun x hx =>
      emergentOrganization_old_retained
        Base Proper Realizes Use Cost Budget Keep O t h hx
  have hGen :
      GeneratorRuleLe
        (EffectiveOrganizationGenerator
          Base Realizes Use ctx (fun x => x ∈ O t))
        (EffectiveOrganizationGenerator
          Base Realizes Use ctx (fun x => x ∈ O (t + 1))) :=
    effectiveOrganizationGenerator_mono
      Base Realizes Use ctx hAvail
  refine ⟨?_, product, by simp, hOldNot, ?_⟩
  · intro z hzTarget hzOld
    exact organizationReach_mono
      (EffectiveOrganizationGenerator
        Base Realizes Use ctx (fun x => x ∈ O t))
      (EffectiveOrganizationGenerator
        Base Realizes Use ctx (fun x => x ∈ O (t + 1)))
      (fun x => x ∈ O t)
      (fun x => x ∈ O (t + 1))
      hAvail hGen z hzOld
  · refine OrganizationReach.gen
      (parents := useParents)
      (fun x hx => OrganizationReach.base (hUseParents x hx))
      ?_
    exact Or.inr
      ⟨phi,
        emergentOrganization_function_available_after_persistence
          Base Proper Realizes Use Cost Budget Keep O t h,
        hUse⟩

/-- The same retained organization may expand immediate one-step access even
when the underlying construction relation itself is fixed.  This is the weaker
operational ratchet and does not imply full-closure expansion. -/
theorem retainedOrganization_can_expand_oneStep_under_fixedRule
    (Generate : HyperGenerator Organization)
    (oldAvailable newAvailable : Organization -> Prop)
    (hAvail : ∀ x, oldAvailable x -> newAvailable x)
    {product : Organization}
    (hNewGenerated :
      GeneratedFromAvailable newAvailable Generate product)
    (hOldNot :
      ¬ GeneratedFromAvailable oldAvailable Generate product) :
    StrictExpandsOn Set.univ
      (GeneratedFromAvailable oldAvailable Generate)
      (GeneratedFromAvailable newAvailable Generate) := by
  refine ⟨?_, product, by simp, hOldNot, hNewGenerated⟩
  exact generatedFromAvailable_mono
    Set.univ oldAvailable newAvailable Generate hAvail

end AccessibilityConsequence

#print axioms functionAvailable_mono
#print axioms effectiveOrganizationGenerator_mono
#print axioms reachableOrganizationPromotion_preserves_fixedReach
#print axioms persistenceLaw_gateFailure_does_not_retain_new
#print axioms emergentOrganization_function_exists
#print axioms emergentOrganization_excludes_proper_part_function
#print axioms emergentOrganization_retained
#print axioms emergentOrganization_function_available_after_persistence
#print axioms retainedVocabularyEmergence_strictly_expands_availableFunctions
#print axioms retainedEmergentFunction_can_expand_fullReach
#print axioms retainedOrganization_can_expand_oneStep_under_fixedRule

end RecursiveAccessibility
end CumulativeAccessibility
