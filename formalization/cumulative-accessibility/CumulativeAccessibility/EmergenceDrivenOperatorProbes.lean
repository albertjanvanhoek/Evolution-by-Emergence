import CumulativeAccessibility.EmergenceDrivenOperatorWitness

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Adversarial probes for the operator-evolution candidate

These are the successor acceptance tests to the external PR #62 Q1-Q3 probes.
They target the candidate causal surface rather than the older RuleOf route.
-/

section GenericKnockouts

variable {Context Capacity : Type*}
variable [DecidableEq Capacity]

/-- Q1/Q2 successor.  Retaining a child that was already generable, while
withholding new emergent provenance, cannot widen full closure. -/
theorem operatorProbe_uncertified_promotion_cannot_click
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
      (PromotedAvailability A child) :=
  uncertified_generated_promotion_no_closure_click
    Base Op A Certified child hGenerated hNotCertified

/-- Emergence failure is a genuine break in the causal chain: under the declared
certification transition it blocks the child from acquiring provenance. -/
theorem operatorProbe_nonEmergence_blocks_certification
    (Realizes : CapacityRelation (Finset Capacity) Context Capacity)
    (Certified : ℕ -> Capacity -> Prop)
    (m : ℕ)
    (parents : Finset Capacity)
    (ctx : Context)
    (child : Capacity)
    (hNew : ¬ Certified m child)
    (hLaw :
      IsolatedEmergenceCertificationLawAt
        Realizes Certified m parents ctx child)
    (hNotEmergent :
      ¬ EmergentUnder
        (FiniteProperSubconfig (Process := Capacity))
        Realizes parents ctx child) :
    ¬ Certified (m + 1) child :=
  certificationLaw_nonEmergence_blocks_child
    Realizes Certified m parents ctx child hNew hLaw hNotEmergent

/-- Resource/validation failure is a separate genuine break: the child cannot
enter the next Active repertoire. -/
theorem operatorProbe_gateFailure_blocks_admission
    (Cost : ResponseCost Capacity)
    (Budget : ResponseBudget)
    (E : ExternalCriterion Capacity)
    (S : ℕ -> Finset Capacity)
    (m : ℕ)
    (child : Capacity)
    (hNew : child ∉ S m)
    (hLaw : IsolatedGateAdmissionLawAt Cost Budget E S m child)
    (hFail : ¬ EmergentAdmissionGateAt Cost Budget E m child) :
    child ∉ S (m + 1) :=
  admissionLaw_gateFailure_blocks_child
    Cost Budget E S m child hNew hLaw hFail

end GenericKnockouts

section LadderRegression

/-- Q2 successor in a concrete model: the non-emergent twin cannot use the
positive model's emergence-certification transition. -/
theorem operatorProbe_nonEmergent_twin_fails_certification (t : ℕ) :
    ¬ IsolatedEmergenceCertificationLawAt
      operatorLadderNonEmergentRealizes operatorLadderCertified t
      (operatorLadderParents t) () (operatorLadderChild t) :=
  operatorLadder_nonEmergent_blocks_certification t

/-- Even after material admission, withholding the emergent certificate keeps
the full-closure click impossible. -/
theorem operatorProbe_nonEmergent_twin_no_click_after_uncertified_admission
    (t : ℕ) :
    ¬ ClosureStrictExpandsOn Set.univ
      (CertifiedInducedGenerator
        operatorLadderBase operatorLadderOp
        (fun x => x ∈ operatorLadderActive t)
        (operatorLadderCertified t))
      (fun x => x ∈ operatorLadderActive t)
      (CertifiedInducedGenerator
        operatorLadderBase operatorLadderOp
        (PromotedAvailability
          (fun x => x ∈ operatorLadderActive t)
          (operatorLadderChild t))
        (operatorLadderCertified t))
      (PromotedAvailability
        (fun x => x ∈ operatorLadderActive t)
        (operatorLadderChild t)) :=
  operatorLadder_uncertified_admission_no_click t

/-- Whole-versus-parts regression: proper parts fail in the emergent ladder. -/
theorem operatorProbe_emergent_whole_irreducible (t : ℕ) :
    ¬ FixedGenerativeClosure
      (ProperPartEnabledGenerator
        operatorLadderBase operatorLadderOp operatorLadderRealizes
        (operatorLadderParents t) ()
        (fun x => x ∈ operatorLadderActive t))
      (fun x =>
        x ∈ operatorLadderActive t ∨
          PartRealizedAt operatorLadderRealizes
            (operatorLadderParents t) () x)
      (operatorLadderProduct t) :=
  operatorLadder_product_irreducible t

/-- Matching non-emergent twin: a proper part can enable the operator product. -/
theorem operatorProbe_nonEmergent_part_reaches_product (t : ℕ) :
    FixedGenerativeClosure
      (ProperPartEnabledGenerator
        operatorLadderBase operatorLadderOp operatorLadderNonEmergentRealizes
        (operatorLadderParents t) ()
        (fun x => x ∈ operatorLadderActive t))
      (fun x =>
        x ∈ operatorLadderActive t ∨
          PartRealizedAt operatorLadderNonEmergentRealizes
            (operatorLadderParents t) () x)
      (operatorLadderProduct t) :=
  operatorLadder_nonEmergent_parts_reach_product t

/-- Q3 successor: the recurring premise is inhabited by an explicit infinite
ladder. -/
theorem operatorProbe_recurring_is_nonvacuous :
    RecurringEmergenceDrivenOperatorEvents
      operatorLadderBase operatorLadderOp operatorLadderRealizes
      operatorLadderCost operatorLadderBudget operatorLadderCriterion
      operatorLadderActive operatorLadderCertified :=
  operatorLadder_recurring

/-- Stronger Q3: arbitrarily long linked lineages exist. -/
theorem operatorProbe_linked_chain_is_nonvacuous (n : ℕ) :
    EmergenceDrivenOperatorChain
      operatorLadderBase operatorLadderOp operatorLadderRealizes
      operatorLadderCost operatorLadderBudget operatorLadderCriterion
      operatorLadderActive operatorLadderCertified
      0 (Sum.inl 1) n (Sum.inl (n + 1)) :=
  operatorLadder_chain n

end LadderRegression

#print axioms operatorProbe_uncertified_promotion_cannot_click
#print axioms operatorProbe_nonEmergence_blocks_certification
#print axioms operatorProbe_gateFailure_blocks_admission
#print axioms operatorProbe_nonEmergent_twin_fails_certification
#print axioms operatorProbe_nonEmergent_twin_no_click_after_uncertified_admission
#print axioms operatorProbe_emergent_whole_irreducible
#print axioms operatorProbe_nonEmergent_part_reaches_product
#print axioms operatorProbe_recurring_is_nonvacuous
#print axioms operatorProbe_linked_chain_is_nonvacuous

end RecursiveAccessibility
end CumulativeAccessibility
