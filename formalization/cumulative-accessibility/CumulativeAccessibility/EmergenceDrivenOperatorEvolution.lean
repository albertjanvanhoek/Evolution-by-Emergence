import CumulativeAccessibility.EmergenceDrivenRecursion

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Emergence-driven operator evolution

This module closes the remaining seam exposed by external review of PR #62.

The earlier repertoire-dependent route used an application-supplied

    RuleOf : (Capacity -> Prop) -> HyperGenerator Capacity

and included full-closure expansion as a conjunct of a strong event.

Here the generator is derived from two state variables:

1. Active retained capacities;
2. capacities carrying an explicit emergent-origin certificate.

Each capacity may carry an operator `Op phi`, but that operator participates
in the current generator only when `phi` is both active and certified as the
product of the declared parent-faithful emergence event.

Thus the causal chain is:

    same parent set generates child
      -> same parent set realizes child emergently
      -> emergence updates certified provenance
      -> feasibility/validation updates Active
      -> Active AND certified activates Op child
      -> a previously unreachable product becomes reachable.

Full-closure expansion is a theorem, not an event premise.
-/

section Core

variable {Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- Each capacity may contribute a finite-parent generative operator. -/
abbrev EmergentOperatorMap (Capacity : Type*) :=
  Capacity -> HyperGenerator Capacity

/-- The active generator contains the fixed background rules plus operators
belonging to capacities that are both active and emergence-certified. -/
def CertifiedInducedGenerator
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Active Certified : Capacity -> Prop) :
    HyperGenerator Capacity :=
  fun parents child =>
    Base parents child ∨
      ∃ phi, Active phi ∧ Certified phi ∧ Op phi parents child

/-- Time-indexed generator induced by active state and emergent provenance. -/
def CertifiedGeneratorAt
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (S : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (m : ℕ) :
    HyperGenerator Capacity :=
  CertifiedInducedGenerator Base Op (fun x => x ∈ S m) (Certified m)

/-- Feasibility and external validation are the admission gate. -/
def EmergentAdmissionGateAt
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (m : ℕ)
    (child : Capacity) : Prop :=
  ResourceFeasibleAt Cost Budget m child ∧ E m child

/-- In the isolated one-event specialization, old active material is preserved
and the declared child is added exactly when the admission gate passes. -/
def IsolatedGateAdmissionLawAt
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (m : ℕ)
    (child : Capacity) : Prop :=
  ∀ x,
    x ∈ S (m + 1) ↔
      x ∈ S m ∨ (x = child ∧ EmergentAdmissionGateAt Cost Budget E m child)

/-- Emergent provenance is a separate state variable.

In this isolated specialization the only new certificate at the next step is
the declared child, and it is added exactly when the declared parent
configuration realizes that child emergently. -/
def IsolatedEmergenceCertificationLawAt
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (m : ℕ)
    (parents : Finset Capacity)
    (ctx : Context)
    (child : Capacity) : Prop :=
  ∀ x,
    Certified (m + 1) x ↔
      Certified m x ∨
        (x = child ∧
          EmergentUnder
            (FiniteProperSubconfig (Process := Capacity))
            Realizes parents ctx child)

/-- The new strong EbE event.

The same finite parent set:
- is available in the current Active repertoire;
- generates the child under the current certified generator;
- realizes the child emergently relative to proper parent subsets.

The child is new both to Active and to emergent provenance. Feasibility and
validation control Active admission; emergence controls provenance
certification. The final operator witness is local: it says what the child's
operator can do after activation and that the witness product was outside the
old full generative closure. Closure expansion itself is not assumed. -/
def EmergenceDrivenOperatorEventAt
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (m : ℕ)
    (parents : Finset Capacity)
    (ctx : Context)
    (child : Capacity) : Prop :=
  2 ≤ parents.card ∧
  (∀ x, x ∈ parents -> x ∈ S m) ∧
  CertifiedGeneratorAt Base Op S Certified m parents child ∧
  EmergentUnder
    (FiniteProperSubconfig (Process := Capacity))
    Realizes parents ctx child ∧
  child ∉ S m ∧
  ¬ Certified m child ∧
  EmergentAdmissionGateAt Cost Budget E m child ∧
  IsolatedGateAdmissionLawAt Cost Budget E S m child ∧
  IsolatedEmergenceCertificationLawAt
    Realizes Certified m parents ctx child ∧
  ∃ operatorParents product,
    Op child operatorParents product ∧
    (∀ x, x ∈ operatorParents -> x ∈ S (m + 1)) ∧
    ¬ FixedGenerativeClosure
      (CertifiedGeneratorAt Base Op S Certified m)
      (fun x => x ∈ S m)
      product

theorem certifiedInducedGenerator_mono
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    {A B CA CB : Capacity -> Prop}
    (hActive : ∀ x, A x -> B x)
    (hCertified : ∀ x, CA x -> CB x) :
    GeneratorRuleLe
      (CertifiedInducedGenerator Base Op A CA)
      (CertifiedInducedGenerator Base Op B CB) := by
  intro parents child h
  rcases h with hBase | ⟨phi, hA, hC, hOp⟩
  · exact Or.inl hBase
  · exact Or.inr ⟨phi, hActive phi hA, hCertified phi hC, hOp⟩

theorem operatorEvent_active_mono
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (m : ℕ)
    {parents : Finset Capacity}
    {ctx : Context}
    {child : Capacity}
    (h :
      EmergenceDrivenOperatorEventAt
        Base Op Realizes Cost Budget E S Certified m parents ctx child) :
    S m ⊆ S (m + 1) := by
  rcases h with
    ⟨_, _, _, _, _, _, _, hAdmission, _, _⟩
  intro x hx
  exact (hAdmission x).2 (Or.inl hx)

theorem operatorEvent_certified_mono
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (m : ℕ)
    {parents : Finset Capacity}
    {ctx : Context}
    {child : Capacity}
    (h :
      EmergenceDrivenOperatorEventAt
        Base Op Realizes Cost Budget E S Certified m parents ctx child) :
    ∀ x, Certified m x -> Certified (m + 1) x := by
  rcases h with
    ⟨_, _, _, _, _, _, _, _, hCertification, _⟩
  intro x hx
  exact (hCertification x).2 (Or.inl hx)

theorem operatorEvent_retains_child
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (m : ℕ)
    {parents : Finset Capacity}
    {ctx : Context}
    {child : Capacity}
    (h :
      EmergenceDrivenOperatorEventAt
        Base Op Realizes Cost Budget E S Certified m parents ctx child) :
    child ∈ S (m + 1) := by
  rcases h with
    ⟨_, _, _, _, _, _, hGate, hAdmission, _, _⟩
  exact (hAdmission child).2 (Or.inr ⟨rfl, hGate⟩)

theorem operatorEvent_certifies_child
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (m : ℕ)
    {parents : Finset Capacity}
    {ctx : Context}
    {child : Capacity}
    (h :
      EmergenceDrivenOperatorEventAt
        Base Op Realizes Cost Budget E S Certified m parents ctx child) :
    Certified (m + 1) child := by
  rcases h with
    ⟨_, _, _, hEmergent, _, _, _, _, hCertification, _⟩
  exact (hCertification child).2 (Or.inr ⟨rfl, hEmergent⟩)

/-- Main click theorem.

Full multi-step reach expands because the event's emergent realization creates
the child's provenance certificate, the admission gate makes the child active,
and only the conjunction Active AND Certified activates `Op child`.

Unlike the older RuleOf route, closure expansion is not a premise. -/
theorem emergenceDrivenOperatorEvent_click
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (m : ℕ)
    {parents : Finset Capacity}
    {ctx : Context}
    {child : Capacity}
    (h :
      EmergenceDrivenOperatorEventAt
        Base Op Realizes Cost Budget E S Certified m parents ctx child) :
    ClosureStrictExpandsOn Set.univ
      (CertifiedGeneratorAt Base Op S Certified m)
      (fun x => x ∈ S m)
      (CertifiedGeneratorAt Base Op S Certified (m + 1))
      (fun x => x ∈ S (m + 1)) := by
  rcases h with
    ⟨hCard, hParentsActive, hGenerate, hEmergent, hNewActive, hNewCertified,
      hGate, hAdmission, hCertification,
      operatorParents, product, hOp, hInputs, hOldNot⟩
  have hActive :
      ∀ x, x ∈ S m -> x ∈ S (m + 1) := by
    intro x hx
    exact (hAdmission x).2 (Or.inl hx)
  have hCertified :
      ∀ x, Certified m x -> Certified (m + 1) x := by
    intro x hx
    exact (hCertification x).2 (Or.inl hx)
  have hChildActive : child ∈ S (m + 1) :=
    (hAdmission child).2 (Or.inr ⟨rfl, hGate⟩)
  have hChildCertified : Certified (m + 1) child :=
    (hCertification child).2 (Or.inr ⟨rfl, hEmergent⟩)
  refine ⟨?_, product, by simp, hOldNot, ?_⟩
  · intro z hzTarget hzOld
    exact fixedGenerativeClosure_mono
      (CertifiedGeneratorAt Base Op S Certified m)
      (CertifiedGeneratorAt Base Op S Certified (m + 1))
      (fun x => x ∈ S m)
      (fun x => x ∈ S (m + 1))
      hActive
      (certifiedInducedGenerator_mono Base Op hActive hCertified)
      z hzOld
  · refine FixedGenerativeClosure.gen (parents := operatorParents) ?_ ?_
    · intro x hx
      exact FixedGenerativeClosure.base (hInputs x hx)
    · exact Or.inr ⟨child, hChildActive, hChildCertified, hOp⟩

/-- A strong event also forces the certified generator itself to change.

The child was generated under the old generator. The active transition is an
isolated promotion. If the generator were unchanged, the fixed-generator P9
theorem would forbid the closure expansion just derived. -/
theorem emergenceDrivenOperatorEvent_forces_generatorChange
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (m : ℕ)
    {parents : Finset Capacity}
    {ctx : Context}
    {child : Capacity}
    (h :
      EmergenceDrivenOperatorEventAt
        Base Op Realizes Cost Budget E S Certified m parents ctx child) :
    CertifiedGeneratorAt Base Op S Certified m ≠
      CertifiedGeneratorAt Base Op S Certified (m + 1) := by
  rcases h with
    ⟨hCard, hParentsActive, hGenerate, hEmergent, hNewActive, hNewCertified,
      hGate, hAdmission, hCertification, hWitness⟩
  intro hRuleEq
  have hGenerated :
      GeneratedFromAvailable
        (fun x => x ∈ S m)
        (CertifiedGeneratorAt Base Op S Certified m)
        child :=
    ⟨parents, hParentsActive, hGenerate⟩
  have hActiveEq :
      (fun x => x ∈ S (m + 1)) =
        PromotedAvailability (fun x => x ∈ S m) child := by
    funext x
    apply propext
    constructor
    · intro hx
      rcases (hAdmission x).1 hx with hxOld | ⟨hxEq, _⟩
      · exact Or.inl hxOld
      · exact Or.inr hxEq
    · intro hx
      rcases hx with hxOld | hxEq
      · exact (hAdmission x).2 (Or.inl hxOld)
      · exact (hAdmission x).2 (Or.inr ⟨hxEq, hGate⟩)
  have hExpansion :
      ClosureStrictExpandsOn Set.univ
        (CertifiedGeneratorAt Base Op S Certified m)
        (fun x => x ∈ S m)
        (CertifiedGeneratorAt Base Op S Certified (m + 1))
        (fun x => x ∈ S (m + 1)) :=
    emergenceDrivenOperatorEvent_click
      Base Op Realizes Cost Budget E S Certified m
      ⟨hCard, hParentsActive, hGenerate, hEmergent, hNewActive, hNewCertified,
        hGate, hAdmission, hCertification, hWitness⟩
  rw [← hRuleEq, hActiveEq] at hExpansion
  exact
    (internallyGeneratedPromotion_not_closureStrictExpansion
      Set.univ
      (CertifiedGeneratorAt Base Op S Certified m)
      (fun x => x ∈ S m)
      hGenerated) hExpansion

end Core

section NoEmergenceNoClick

variable {Capacity : Type*}
variable [DecidableEq Capacity]

/-- If an internally generated child is admitted as material but receives no
new emergence certificate, and no existing certificate changes, then the
certified generator is unchanged. -/
theorem certifiedGenerator_unchanged_by_uncertified_promotion
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (A Certified : Capacity -> Prop)
    (child : Capacity)
    (hNotCertified : ¬ Certified child) :
    CertifiedInducedGenerator
        Base Op (PromotedAvailability A child) Certified =
      CertifiedInducedGenerator Base Op A Certified := by
  funext parents z
  apply propext
  constructor
  · intro h
    rcases h with hBase | ⟨phi, hActive, hCert, hOp⟩
    · exact Or.inl hBase
    · rcases hActive with hOld | hEq
      · exact Or.inr ⟨phi, hOld, hCert, hOp⟩
      · subst hEq
        exact (hNotCertified hCert).elim
  · intro h
    rcases h with hBase | ⟨phi, hActive, hCert, hOp⟩
    · exact Or.inl hBase
    · exact Or.inr ⟨phi, Or.inl hActive, hCert, hOp⟩

/-- Retention without new emergent provenance cannot produce a full-closure
click merely by promoting a child that was already internally generated. -/
theorem uncertified_generated_promotion_no_closure_click
    (Base : HyperGenerator Capacity)
    (Op : EmergentOperatorMap Capacity)
    (A Certified : Capacity -> Prop)
    (child : Capacity)
    (hGenerated :
      GeneratedFromAvailable
        A (CertifiedInducedGenerator Base Op A Certified) child)
    (hNotCertified : ¬ Certified child) :
    ¬ ClosureStrictExpandsOn Set.univ
      (CertifiedInducedGenerator Base Op A Certified) A
      (CertifiedInducedGenerator
        Base Op (PromotedAvailability A child) Certified)
      (PromotedAvailability A child) := by
  rw [certifiedGenerator_unchanged_by_uncertified_promotion
    Base Op A Certified child hNotCertified]
  exact internallyGeneratedPromotion_not_closureStrictExpansion
    Set.univ
    (CertifiedInducedGenerator Base Op A Certified)
    A hGenerated

end NoEmergenceNoClick

#print axioms emergenceDrivenOperatorEvent_click
#print axioms emergenceDrivenOperatorEvent_forces_generatorChange
#print axioms certifiedGenerator_unchanged_by_uncertified_promotion
#print axioms uncertified_generated_promotion_no_closure_click

end RecursiveAccessibility
end CumulativeAccessibility
