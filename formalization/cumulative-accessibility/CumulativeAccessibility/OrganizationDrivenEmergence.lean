import CumulativeAccessibility.EmergentCapacity
import CumulativeAccessibility.ResponseDynamics
import CumulativeAccessibility.CapacityUptake

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Organization-driven emergence

Organization is the primary state variable.

A configuration has whatever functions the fixed realization relation assigns
to it.  No permission, certification, or activation label is required for a
function to exist.

Persistence is downstream: it decides whether an already-existing organization
remains available as material for what comes next.

The fixed ingredients are:

* retained organizations O_t;
* Proper: a declared proper-part relation between organizations;
* Realizes: organization × context × capacity;
* Base: a fixed background assembly law;
* Use: a fixed law describing how a realized function can participate in later
  construction.

The effective construction relation changes when the retained organizational
state changes, even if Base, Realizes, and Use themselves remain fixed.

Core causal order:

    retained parts
      -> assembled organization
      -> function of the whole                         [realization]
      -> function absent from proper parts             [emergence]
      -> persistence or loss                           [downstream]
      -> if retained: organization is reusable material
      -> all functions it realizes are automatically available
      -> later organizational accessibility may change.

Thus function exists before selection/persistence, and generator mutation is
not part of the definition of emergence.
-/

section FunctionalState

variable {Organization Context Capacity : Type*}
variable [DecidableEq Organization]

abbrev FunctionalUseRule (Capacity Organization : Type*) :=
  Capacity -> Finset Organization -> Organization -> Prop

def FunctionAvailable
    (Realizes : CapacityRelation Organization Context Capacity)
    (ctx : Context)
    (Available : Organization -> Prop)
    (phi : Capacity) : Prop :=
  ∃ organization, Available organization ∧ Realizes organization ctx phi

/-- Inclusion between construction relations, without implying that either
relation is a mutable generator object. -/
def ConstructionRelationLe
    (oldRel newRel : HyperGenerator Organization) : Prop :=
  ∀ parents child, oldRel parents child -> newRel parents child

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

theorem effectiveOrganizationGenerator_mono
    (Base : HyperGenerator Organization)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (ctx : Context)
    {oldAvailable newAvailable : Organization -> Prop}
    (hAvail : ∀ x, oldAvailable x -> newAvailable x) :
    ConstructionRelationLe
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
    (hGenerate : ConstructionRelationLe oldGenerate newGenerate) :
    ∀ z,
      OrganizationReach oldGenerate oldAvailable z ->
      OrganizationReach newGenerate newAvailable z := by
  intro z hz
  induction hz with
  | base h =>
      exact OrganizationReach.base (hAvail _ h)
  | gen hParents hRule ih =>
      exact OrganizationReach.gen ih (hGenerate _ _ hRule)

/-- P9 at the organization level: if an organization was already reachable
under a fixed construction relation, merely promoting it to primitive material
does not enlarge full transitive reach under that same relation. -/
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
      · cases hEq
        exact hReach
  | gen hParents hRule ih =>
      exact OrganizationReach.gen ih hRule

end Reachability

section Persistence

variable {Organization : Type*}
variable [DecidableEq Organization]

/-- Persistence/selection is downstream of function. -/
def OrganizationPersistenceGateAt
    (Cost : ResponseCost Organization)
    (Budget : ResponseBudget)
    (Keep : ExternalCriterion Organization)
    (t : ℕ)
    (organization : Organization) : Prop :=
  ResourceFeasibleAt Cost Budget t organization ∧ Keep t organization

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

section EmergenceBeforePersistence

variable {Organization Context Capacity : Type*}
variable [DecidableEq Organization]

/-- Emergence itself contains no persistence criterion.

The same retained parent set constructs the organization; each causal parent is
declared a proper part of the whole; and the whole realizes phi while no proper
part does. -/
def EmergentOrganizationAt
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
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
  organization ∉ O t

theorem emergentOrganization_function_exists
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (O : ℕ -> Finset Organization)
    (t : ℕ)
    {parents : Finset Organization}
    {organization : Organization}
    {ctx : Context}
    {phi : Capacity}
    (h :
      EmergentOrganizationAt
        Base Proper Realizes Use O
        t parents organization ctx phi) :
    Realizes organization ctx phi := by
  rcases h with ⟨_, _, _, _, hEmergent, _⟩
  exact hEmergent.1

theorem emergentOrganization_excludes_proper_part_function
    (Base : HyperGenerator Organization)
    (Proper : Organization -> Organization -> Prop)
    (Realizes : CapacityRelation Organization Context Capacity)
    (Use : FunctionalUseRule Capacity Organization)
    (O : ℕ -> Finset Organization)
    (t : ℕ)
    {parents : Finset Organization}
    {organization part : Organization}
    {ctx : Context}
    {phi : Capacity}
    (h :
      EmergentOrganizationAt
        Base Proper Realizes Use O
        t parents organization ctx phi)
    (hProper : Proper part organization) :
    ¬ Realizes part ctx phi := by
  rcases h with ⟨_, _, _, _, hEmergent, _⟩
  exact hEmergent.2 part hProper

/-- Persistence is a second event layered on top of an already-functional
emergent organization. -/
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
  EmergentOrganizationAt
      Base Proper Realizes Use O
      t parents organization ctx phi ∧
  OrganizationPersistenceGateAt Cost Budget Keep t organization ∧
  IsolatedOrganizationPersistenceLawAt
    Cost Budget Keep O t organization

/-- The function follows from emergence alone, not from persistence. -/
theorem emergentPersistentOrganization_function_preexists_gate
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
  exact emergentOrganization_function_exists
    Base Proper Realizes Use O t h.1

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
    Cost Budget Keep O t organization h.2.1 h.2.2

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
    Cost Budget Keep O t organization h.2.2

/-- Once retained, every function already realized by the organization becomes
available automatically. -/
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
    emergentPersistentOrganization_function_preexists_gate
      Base Proper Realizes Use Cost Budget Keep O t h⟩

/-- Explicit separation theorem: an emergent organization can already realize
its function while failing to persist. -/
theorem emergent_function_can_exist_without_persistence
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
    (hEmergent :
      EmergentOrganizationAt
        Base Proper Realizes Use O
        t parents organization ctx phi)
    (hFail :
      ¬ OrganizationPersistenceGateAt Cost Budget Keep t organization)
    (hLaw :
      IsolatedOrganizationPersistenceLawAt
        Cost Budget Keep O t organization) :
    Realizes organization ctx phi ∧ organization ∉ O (t + 1) := by
  constructor
  · exact emergentOrganization_function_exists
      Base Proper Realizes Use O t hEmergent
  · exact persistenceLaw_gateFailure_does_not_retain_new
      Cost Budget Keep O t organization
      hEmergent.2.2.2.2.2 hFail hLaw

end EmergenceBeforePersistence

section FunctionalVocabulary

variable {Organization Context Capacity : Type*}
variable [DecidableEq Organization]

def FunctionallyNovelToRetainedSystem
    (Realizes : CapacityRelation Organization Context Capacity)
    (ctx : Context)
    (O : ℕ -> Finset Organization)
    (t : ℕ)
    (phi : Capacity) : Prop :=
  ¬ FunctionAvailable Realizes ctx (fun x => x ∈ O t) phi

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
      ConstructionRelationLe
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

/-- Weaker operational ratchet: state change can expand immediate access under
an unchanged construction rule without implying a change in full closure. -/
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
#print axioms emergentPersistentOrganization_function_preexists_gate
#print axioms emergentOrganization_retained
#print axioms emergentOrganization_function_available_after_persistence
#print axioms emergent_function_can_exist_without_persistence
#print axioms retainedVocabularyEmergence_strictly_expands_availableFunctions
#print axioms retainedEmergentFunction_can_expand_fullReach
#print axioms retainedOrganization_can_expand_oneStep_under_fixedRule

end RecursiveAccessibility
end CumulativeAccessibility
