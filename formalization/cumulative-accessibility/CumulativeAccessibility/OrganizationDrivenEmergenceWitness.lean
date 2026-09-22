import CumulativeAccessibility.OrganizationDrivenEmergenceRecurrence

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Witnesses for organization-driven emergence

The ladder uses two kinds of organization:

* inl n : a reusable retained organization;
* inr n : a downstream product.

At time t the retained system contains inl 0,...,inl (t+1).
The fixed background assembly law combines inl t and inl (t+1) into
inl (t+2).

Organization inl n realizes function n.  Proper parts of inl (t+2) are exactly
inl t and inl (t+1), so function t+2 is emergent relative to that organization.

Persistence retains the whole.  Once retained, its already-existing function is
automatically functionally available.  A fixed Use law can then use function
t+2 to construct inr (t+2).

A non-emergent twin is also supplied.  In that twin the whole still realizes
the function, but one retained proper part realizes it too.  The function is
therefore already available before the whole persists.  Non-emergence does not
block function; it blocks attribution of functional novelty to the whole.
-/

section PositiveLadder

abbrev OrganizationLadderOrg := ℕ ⊕ ℕ

def organizationLadderParents (t : ℕ) : Finset OrganizationLadderOrg :=
  {Sum.inl t, Sum.inl (t + 1)}

def organizationLadderWhole (t : ℕ) : OrganizationLadderOrg :=
  Sum.inl (t + 2)

def organizationLadderProduct (t : ℕ) : OrganizationLadderOrg :=
  Sum.inr (t + 2)

/-- Proper parts are exactly the two organizations assembled into the whole. -/
def organizationLadderProper :
    OrganizationLadderOrg -> OrganizationLadderOrg -> Prop
  | part, Sum.inl whole =>
      ∃ n,
        whole = n + 2 ∧
        (part = Sum.inl n ∨ part = Sum.inl (n + 1))
  | _, Sum.inr _ => False

/-- An organization has its function intrinsically whenever it exists. -/
def organizationLadderRealizes :
    CapacityRelation OrganizationLadderOrg Unit ℕ
  | Sum.inl n, _, phi => phi = n
  | Sum.inr _, _, _ => False

/-- Fixed background assembly law. -/
def organizationLadderBase : HyperGenerator OrganizationLadderOrg :=
  fun parents child =>
    ∃ n,
      parents = organizationLadderParents n ∧
      child = organizationLadderWhole n

/-- Fixed law for using a realized function. -/
def organizationLadderUse : FunctionalUseRule ℕ OrganizationLadderOrg :=
  fun phi parents child =>
    parents = {Sum.inl phi} ∧
    child = Sum.inr phi

/-- Retained organizations inl 0,...,inl (t+1). -/
def organizationLadderRetained (t : ℕ) : Finset OrganizationLadderOrg :=
  (Finset.range (t + 2)).image Sum.inl

def organizationLadderCost : ResponseCost OrganizationLadderOrg :=
  fun _ _ => 0

def organizationLadderBudget : ResponseBudget :=
  fun _ => 0

def organizationLadderKeep : ExternalCriterion OrganizationLadderOrg :=
  fun _ _ => True

theorem organizationLadder_emergent (t : ℕ) :
    EmergentUnder
      organizationLadderProper
      organizationLadderRealizes
      (organizationLadderWhole t) () (t + 2) := by
  constructor
  · simp [organizationLadderRealizes, organizationLadderWhole]
  · intro part hProper hRealizes
    rcases hProper with ⟨n, hWhole, hPart⟩
    have hnt : n = t := by
      simp [organizationLadderWhole] at hWhole
      omega
    subst n
    rcases hPart with rfl | rfl
    · simp [organizationLadderRealizes] at hRealizes
    · simp [organizationLadderRealizes] at hRealizes
      omega

theorem organizationLadder_persistenceLaw (t : ℕ) :
    IsolatedOrganizationPersistenceLawAt
      organizationLadderCost organizationLadderBudget organizationLadderKeep
      organizationLadderRetained t (organizationLadderWhole t) := by
  intro x
  cases x with
  | inl n =>
      simp [IsolatedOrganizationPersistenceLawAt,
        OrganizationPersistenceGateAt,
        organizationLadderRetained, organizationLadderWhole,
        organizationLadderCost, organizationLadderBudget,
        organizationLadderKeep, ResourceFeasibleAt, AccessibleByCost]
      omega
  | inr n =>
      simp [IsolatedOrganizationPersistenceLawAt,
        OrganizationPersistenceGateAt,
        organizationLadderRetained, organizationLadderWhole,
        organizationLadderCost, organizationLadderBudget,
        organizationLadderKeep, ResourceFeasibleAt, AccessibleByCost]

theorem organizationLadder_emergence_event (t : ℕ) :
    EmergentOrganizationAt
      organizationLadderBase
      organizationLadderProper
      organizationLadderRealizes
      organizationLadderUse
      organizationLadderRetained
      t
      (organizationLadderParents t)
      (organizationLadderWhole t)
      ()
      (t + 2) := by
  refine ⟨?_, ?_, ?_, ?_, organizationLadder_emergent t, ?_⟩
  · simp [organizationLadderParents]
  · intro x hx
    simp only [organizationLadderParents, Finset.mem_insert,
      Finset.mem_singleton] at hx
    rcases hx with rfl | rfl <;> simp [organizationLadderRetained]
  · intro x hx
    simp only [organizationLadderParents, Finset.mem_insert,
      Finset.mem_singleton] at hx
    rcases hx with rfl | rfl
    · exact ⟨t, rfl, Or.inl rfl⟩
    · exact ⟨t, rfl, Or.inr rfl⟩
  · exact Or.inl ⟨t, rfl, rfl⟩
  · simp [organizationLadderRetained, organizationLadderWhole]

theorem organizationLadder_function_exists_before_persistence (t : ℕ) :
    organizationLadderRealizes
      (organizationLadderWhole t) () (t + 2) := by
  exact emergentOrganization_function_exists
    organizationLadderBase organizationLadderProper
    organizationLadderRealizes organizationLadderUse
    organizationLadderRetained t
    (organizationLadder_emergence_event t)

theorem organizationLadder_event (t : ℕ) :
    EmergentOrganizationPersistenceAt
      organizationLadderBase
      organizationLadderProper
      organizationLadderRealizes
      organizationLadderUse
      organizationLadderCost
      organizationLadderBudget
      organizationLadderKeep
      organizationLadderRetained
      t
      (organizationLadderParents t)
      (organizationLadderWhole t)
      ()
      (t + 2) := by
  refine ⟨organizationLadder_emergence_event t, ?_,
    organizationLadder_persistenceLaw t⟩
  simp [OrganizationPersistenceGateAt,
    organizationLadderCost, organizationLadderBudget,
    organizationLadderKeep, ResourceFeasibleAt, AccessibleByCost]

theorem organizationLadder_function_novel (t : ℕ) :
    FunctionallyNovelToRetainedSystem
      organizationLadderRealizes ()
      organizationLadderRetained t (t + 2) := by
  rintro ⟨organization, hAvailable, hRealizes⟩
  cases organization with
  | inl n =>
      simp [organizationLadderRetained] at hAvailable
      simp [organizationLadderRealizes] at hRealizes
      omega
  | inr n =>
      simp [organizationLadderRealizes] at hRealizes

theorem organizationLadder_vocabulary_event (t : ℕ) :
    RetainedVocabularyEmergenceAt
      organizationLadderBase
      organizationLadderProper
      organizationLadderRealizes
      organizationLadderUse
      organizationLadderCost
      organizationLadderBudget
      organizationLadderKeep
      organizationLadderRetained
      t
      (organizationLadderParents t)
      (organizationLadderWhole t)
      ()
      (t + 2) := by
  exact ⟨organizationLadder_event t, organizationLadder_function_novel t⟩

theorem organizationLadder_functions_strictly_expand (t : ℕ) :
    StrictExpandsOn Set.univ
      (FunctionAvailable organizationLadderRealizes ()
        (fun x => x ∈ organizationLadderRetained t))
      (FunctionAvailable organizationLadderRealizes ()
        (fun x => x ∈ organizationLadderRetained (t + 1))) := by
  exact retainedVocabularyEmergence_strictly_expands_availableFunctions
    organizationLadderBase organizationLadderProper
    organizationLadderRealizes organizationLadderUse
    organizationLadderCost organizationLadderBudget organizationLadderKeep
    organizationLadderRetained t
    (organizationLadder_vocabulary_event t)

/-- The new product is outside old full reach because no retained organization
yet realizes function t+2. -/
theorem organizationLadder_product_not_old_reach (t : ℕ) :
    ¬ OrganizationReach
      (EffectiveOrganizationGenerator
        organizationLadderBase organizationLadderRealizes
        organizationLadderUse ()
        (fun x => x ∈ organizationLadderRetained t))
      (fun x => x ∈ organizationLadderRetained t)
      (organizationLadderProduct t) := by
  intro h
  cases h with
  | base hAvailable =>
      simpa [organizationLadderRetained, organizationLadderProduct]
        using hAvailable
  | gen hParents hRule =>
      rcases hRule with hBase | ⟨phi, hFunction, hUse⟩
      · rcases hBase with ⟨n, hParentsEq, hChildEq⟩
        cases hChildEq
      · rcases hFunction with ⟨organization, hAvailable, hRealizes⟩
        have hPhi : phi = t + 2 := by
          exact Sum.inr.inj hUse.2
        subst phi
        cases organization with
        | inl n =>
            simp [organizationLadderRetained] at hAvailable
            simp [organizationLadderRealizes] at hRealizes
            omega
        | inr n =>
            simp [organizationLadderRealizes] at hRealizes

theorem organizationLadder_fullReach_click (t : ℕ) :
    StrictExpandsOn Set.univ
      (OrganizationReach
        (EffectiveOrganizationGenerator
          organizationLadderBase organizationLadderRealizes
          organizationLadderUse ()
          (fun x => x ∈ organizationLadderRetained t))
        (fun x => x ∈ organizationLadderRetained t))
      (OrganizationReach
        (EffectiveOrganizationGenerator
          organizationLadderBase organizationLadderRealizes
          organizationLadderUse ()
          (fun x => x ∈ organizationLadderRetained (t + 1)))
        (fun x => x ∈ organizationLadderRetained (t + 1))) := by
  apply retainedEmergentFunction_can_expand_fullReach
    organizationLadderBase organizationLadderProper
    organizationLadderRealizes organizationLadderUse
    organizationLadderCost organizationLadderBudget organizationLadderKeep
    organizationLadderRetained t
    (organizationLadder_event t)
    (useParents := {organizationLadderWhole t})
    (product := organizationLadderProduct t)
  · simp [organizationLadderUse,
      organizationLadderWhole, organizationLadderProduct]
  · intro x hx
    simp only [Finset.mem_singleton] at hx
    subst x
    exact emergentOrganization_retained
      organizationLadderBase organizationLadderProper
      organizationLadderRealizes organizationLadderUse
      organizationLadderCost organizationLadderBudget organizationLadderKeep
      organizationLadderRetained t
      (organizationLadder_event t)
  · exact organizationLadder_product_not_old_reach t

theorem organizationLadder_retained_mono :
    ∀ t,
      organizationLadderRetained t ⊆
        organizationLadderRetained (t + 1) := by
  intro t x hx
  simp only [organizationLadderRetained,
    Finset.mem_image, Finset.mem_range] at hx ⊢
  obtain ⟨n, hn, rfl⟩ := hx
  exact ⟨n, by omega, rfl⟩

theorem organizationLadder_recursive_reuse (t : ℕ) :
    organizationLadderWhole t ∈ organizationLadderParents (t + 1) := by
  simp [organizationLadderWhole, organizationLadderParents]

theorem organizationLadder_recurring_vocabulary :
    RecurringRetainedVocabularyEmergence
      organizationLadderBase organizationLadderProper
      organizationLadderRealizes organizationLadderUse
      organizationLadderCost organizationLadderBudget organizationLadderKeep
      organizationLadderRetained := by
  intro n
  exact ⟨n, organizationLadderParents n, organizationLadderWhole n,
    (), n + 2, le_rfl, organizationLadder_vocabulary_event n⟩

theorem organizationLadder_chain (n : ℕ) :
    OrganizationEmergenceChain
      organizationLadderBase organizationLadderProper
      organizationLadderRealizes organizationLadderUse
      organizationLadderCost organizationLadderBudget organizationLadderKeep
      organizationLadderRetained
      0 (Sum.inl 1) n (Sum.inl (n + 1)) := by
  induction n with
  | zero =>
      simpa using
        (TimedRecursiveChain.base :
          OrganizationEmergenceChain
            organizationLadderBase organizationLadderProper
            organizationLadderRealizes organizationLadderUse
            organizationLadderCost organizationLadderBudget
            organizationLadderKeep organizationLadderRetained
            0 (Sum.inl 1) 0 (Sum.inl 1))
  | succ n ih =>
      have hLink :
          OrganizationEmergenceStepAt
            organizationLadderBase organizationLadderProper
            organizationLadderRealizes organizationLadderUse
            organizationLadderCost organizationLadderBudget
            organizationLadderKeep organizationLadderRetained
            n (Sum.inl (n + 1)) (Sum.inl (n + 2)) := by
        exact ⟨organizationLadderParents n, (), n + 2,
          by simp [organizationLadderParents],
          organizationLadder_event n⟩
      simpa [Nat.add_assoc] using TimedRecursiveChain.step ih hLink

theorem organizationLadder_openEndedOrganization :
    OpenEndedCumulativeNovelty organizationLadderRetained := by
  exact recurringVocabularyEmergence_implies_openEndedOrganization
    organizationLadderBase organizationLadderProper
    organizationLadderRealizes organizationLadderUse
    organizationLadderCost organizationLadderBudget organizationLadderKeep
    organizationLadderRetained organizationLadder_retained_mono
    organizationLadder_recurring_vocabulary

end PositiveLadder

section NonEmergentTwin

/-- In the twin, the whole still realizes its function, but the first proper
part realizes that same function too. -/
def organizationLadderNonEmergentRealizes :
    CapacityRelation OrganizationLadderOrg Unit ℕ
  | Sum.inl n, _, phi =>
      phi = n ∨ phi = n + 2
  | Sum.inr _, _, _ => False

theorem organizationLadder_nonEmergent_whole_still_functions (t : ℕ) :
    organizationLadderNonEmergentRealizes
      (organizationLadderWhole t) () (t + 2) := by
  simp [organizationLadderNonEmergentRealizes, organizationLadderWhole]

theorem organizationLadder_nonEmergent (t : ℕ) :
    ¬ EmergentUnder
      organizationLadderProper
      organizationLadderNonEmergentRealizes
      (organizationLadderWhole t) () (t + 2) := by
  intro h
  have hProper :
      organizationLadderProper
        (Sum.inl t) (organizationLadderWhole t) :=
    ⟨t, rfl, Or.inl rfl⟩
  have hPartRealizes :
      organizationLadderNonEmergentRealizes
        (Sum.inl t) () (t + 2) := by
    simp [organizationLadderNonEmergentRealizes]
  exact (h.2 (Sum.inl t) hProper) hPartRealizes

/-- Crucial regression test: non-emergence does not disable the function.
Instead, the function is already available through a retained proper part. -/
theorem organizationLadder_nonEmergent_function_already_available (t : ℕ) :
    FunctionAvailable
      organizationLadderNonEmergentRealizes ()
      (fun x => x ∈ organizationLadderRetained t)
      (t + 2) := by
  exact ⟨Sum.inl t,
    by simp [organizationLadderRetained],
    by simp [organizationLadderNonEmergentRealizes]⟩

theorem organizationLadder_nonEmergent_not_functionally_novel (t : ℕ) :
    ¬ FunctionallyNovelToRetainedSystem
      organizationLadderNonEmergentRealizes ()
      organizationLadderRetained t (t + 2) := by
  exact organizationLadder_nonEmergent_function_already_available t

end NonEmergentTwin

#print axioms organizationLadder_emergent
#print axioms organizationLadder_emergence_event
#print axioms organizationLadder_function_exists_before_persistence
#print axioms organizationLadder_event
#print axioms organizationLadder_function_novel
#print axioms organizationLadder_functions_strictly_expand
#print axioms organizationLadder_product_not_old_reach
#print axioms organizationLadder_fullReach_click
#print axioms organizationLadder_recursive_reuse
#print axioms organizationLadder_recurring_vocabulary
#print axioms organizationLadder_chain
#print axioms organizationLadder_openEndedOrganization
#print axioms organizationLadder_nonEmergent_whole_still_functions
#print axioms organizationLadder_nonEmergent
#print axioms organizationLadder_nonEmergent_function_already_available
#print axioms organizationLadder_nonEmergent_not_functionally_novel

end RecursiveAccessibility
end CumulativeAccessibility
