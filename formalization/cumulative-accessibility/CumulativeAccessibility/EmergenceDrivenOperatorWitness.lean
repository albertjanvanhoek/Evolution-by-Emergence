import CumulativeAccessibility.EmergenceDrivenOperatorRecurrence

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Witnesses and knock-outs for emergence-driven operator evolution

This module provides the acceptance tests requested in external review.

1. An infinite recursive ladder satisfies the strong operator event at every
   step. The retained child at time t is a parent at time t+1, so recurrence is
   non-vacuous and genuinely linked.
2. A non-emergent twin cannot update emergent provenance.
3. If the same generated child is admitted as material but remains
   uncertified, promotion alone cannot expand full reach.

The ladder is a satisfiability witness, not an empirical model.
-/

section Ladder

abbrev OperatorLadderCap := ℕ ⊕ ℕ

/-- Background assembly rule: consecutive capacities build the next capacity. -/
def operatorLadderBase : HyperGenerator OperatorLadderCap :=
  fun parents child =>
    ∃ n,
      child = Sum.inl (n + 2) ∧
      parents = {Sum.inl n, Sum.inl (n + 1)}

/-- Once a capacity is active and emergence-certified, its operator makes a
distinct product. -/
def operatorLadderOp : EmergentOperatorMap OperatorLadderCap
  | Sum.inl n =>
      fun parents product =>
        parents = {Sum.inl n} ∧ product = Sum.inr n
  | Sum.inr _ => fun _ _ => False

/-- Joint realization: only the consecutive pair realizes the next capacity. -/
def operatorLadderRealizes :
    CapacityRelation (Finset OperatorLadderCap) Unit OperatorLadderCap :=
  fun config _ child =>
    ∃ n,
      child = Sum.inl (n + 2) ∧
      config = {Sum.inl n, Sum.inl (n + 1)}

def operatorLadderParents (t : ℕ) : Finset OperatorLadderCap :=
  {Sum.inl t, Sum.inl (t + 1)}

def operatorLadderChild (t : ℕ) : OperatorLadderCap :=
  Sum.inl (t + 2)

def operatorLadderProduct (t : ℕ) : OperatorLadderCap :=
  Sum.inr (t + 2)

/-- Active capacities 0,...,t+1. -/
def operatorLadderActive (t : ℕ) : Finset OperatorLadderCap :=
  (Finset.range (t + 2)).image Sum.inl

/-- Emergent provenance records capacities 2,...,t+1.

At t = 0 no emergent product has yet been admitted. Each event certifies exactly
the next capacity. -/
def operatorLadderCertified (t : ℕ) : OperatorLadderCap -> Prop
  | Sum.inl n => 2 ≤ n ∧ n < t + 2
  | Sum.inr _ => False

def operatorLadderCost : ResponseCost OperatorLadderCap := fun _ _ => 0
def operatorLadderBudget : ResponseBudget := fun _ => 0
def operatorLadderCriterion : ExternalCriterion OperatorLadderCap :=
  fun _ _ => True

theorem operatorLadder_emergent (t : ℕ) :
    EmergentUnder
      (FiniteProperSubconfig (Process := OperatorLadderCap))
      operatorLadderRealizes
      (operatorLadderParents t) () (operatorLadderChild t) := by
  refine ⟨⟨t, rfl, rfl⟩, ?_⟩
  rintro sub hProper ⟨n, hChild, hConfig⟩
  have hnt : n = t := by
    have hInj := Sum.inl.inj hChild
    omega
  subst hnt
  exact (lt_irrefl _) (hConfig ▸ hProper)

theorem operatorLadder_admissionLaw (t : ℕ) :
    IsolatedGateAdmissionLawAt
      operatorLadderCost operatorLadderBudget operatorLadderCriterion
      operatorLadderActive t (operatorLadderChild t) := by
  intro x
  cases x with
  | inl n =>
      simp [IsolatedGateAdmissionLawAt, EmergentAdmissionGateAt,
        operatorLadderActive, operatorLadderChild,
        operatorLadderCost, operatorLadderBudget, operatorLadderCriterion,
        ResourceFeasibleAt, AccessibleByCost]
      omega
  | inr n =>
      simp [IsolatedGateAdmissionLawAt, EmergentAdmissionGateAt,
        operatorLadderActive, operatorLadderChild,
        operatorLadderCost, operatorLadderBudget, operatorLadderCriterion,
        ResourceFeasibleAt, AccessibleByCost]

theorem operatorLadder_certificationLaw (t : ℕ) :
    IsolatedEmergenceCertificationLawAt
      operatorLadderRealizes operatorLadderCertified t
      (operatorLadderParents t) () (operatorLadderChild t) := by
  intro x
  cases x with
  | inl n =>
      constructor
      · intro hNext
        by_cases hOld : n < t + 2
        · exact Or.inl ⟨hNext.1, hOld⟩
        · have hEqNat : n = t + 2 := by
            change 2 ≤ n ∧ n < t + 3 at hNext
            omega
          subst hEqNat
          exact Or.inr ⟨rfl, operatorLadder_emergent t⟩
      · intro h
        rcases h with hPrev | ⟨hEq, hEmergent⟩
        · exact ⟨hPrev.1, by omega⟩
        · have hEqNat : n = t + 2 := Sum.inl.inj hEq
          subst hEqNat
          exact ⟨by omega, by omega⟩
  | inr n =>
      simp [operatorLadderCertified, operatorLadderChild]

/-- The newly operator-addressable product is outside the old full closure. -/
theorem operatorLadder_product_not_old_closure (t : ℕ) :
    ¬ FixedGenerativeClosure
      (CertifiedGeneratorAt
        operatorLadderBase operatorLadderOp
        operatorLadderActive operatorLadderCertified t)
      (fun x => x ∈ operatorLadderActive t)
      (operatorLadderProduct t) := by
  intro h
  cases h with
  | base hActive =>
      simpa [operatorLadderActive, operatorLadderProduct] using hActive
  | gen hParents hGenerate =>
      rcases hGenerate with hBase | ⟨phi, hActive, hCertified, hOp⟩
      · rcases hBase with ⟨n, hChild, hConfig⟩
        cases hChild
      · rcases phi with k | k
        · have hk : k = t + 2 := by
            exact Sum.inr.inj hOp.2
          subst hk
          simp [operatorLadderActive] at hActive
        · exact hOp.elim

/-- Every ladder step is a strong emergence-driven operator event. -/
theorem operatorLadder_event (t : ℕ) :
    EmergenceDrivenOperatorEventAt
      operatorLadderBase operatorLadderOp operatorLadderRealizes
      operatorLadderCost operatorLadderBudget operatorLadderCriterion
      operatorLadderActive operatorLadderCertified
      t (operatorLadderParents t) () (operatorLadderChild t) := by
  refine ⟨?_, ?_, ?_, operatorLadder_emergent t, ?_, ?_, ?_,
    operatorLadder_admissionLaw t, operatorLadder_certificationLaw t, ?_⟩
  · simp [operatorLadderParents]
  · intro x hx
    simp only [operatorLadderParents, Finset.mem_insert,
      Finset.mem_singleton] at hx
    rcases hx with rfl | rfl <;> simp [operatorLadderActive]
  · exact Or.inl ⟨t, rfl, rfl⟩
  · simp [operatorLadderActive, operatorLadderChild]
  · simp [operatorLadderCertified, operatorLadderChild]
  · simp [EmergentAdmissionGateAt, operatorLadderCost,
      operatorLadderBudget, operatorLadderCriterion,
      ResourceFeasibleAt, AccessibleByCost]
  · refine ⟨{operatorLadderChild t}, operatorLadderProduct t, ?_, ?_,
      operatorLadder_product_not_old_closure t⟩
    · simp [operatorLadderOp, operatorLadderChild, operatorLadderProduct]
    · intro x hx
      simp only [Finset.mem_singleton] at hx
      subst hx
      simp [operatorLadderActive, operatorLadderChild]

/-- The click is derived at every step. -/
theorem operatorLadder_click_every_step (t : ℕ) :
    ClosureStrictExpandsOn Set.univ
      (CertifiedGeneratorAt
        operatorLadderBase operatorLadderOp
        operatorLadderActive operatorLadderCertified t)
      (fun x => x ∈ operatorLadderActive t)
      (CertifiedGeneratorAt
        operatorLadderBase operatorLadderOp
        operatorLadderActive operatorLadderCertified (t + 1))
      (fun x => x ∈ operatorLadderActive (t + 1)) := by
  exact emergenceDrivenOperatorEvent_click
    operatorLadderBase operatorLadderOp operatorLadderRealizes
    operatorLadderCost operatorLadderBudget operatorLadderCriterion
    operatorLadderActive operatorLadderCertified t
    (operatorLadder_event t)

/-- The retained child of one event is a causal parent of the next event. -/
theorem operatorLadder_recursive (t : ℕ) :
    operatorLadderChild t ∈ operatorLadderParents (t + 1) := by
  simp [operatorLadderChild, operatorLadderParents]

theorem operatorLadderActive_mono :
    ∀ t, operatorLadderActive t ⊆ operatorLadderActive (t + 1) := by
  intro t x hx
  simp only [operatorLadderActive, Finset.mem_image, Finset.mem_range] at hx ⊢
  obtain ⟨k, hk, rfl⟩ := hx
  exact ⟨k, by omega, rfl⟩

/-- Non-vacuity of the generic arbitrary-late recurrence predicate. -/
theorem operatorLadder_recurring :
    RecurringEmergenceDrivenOperatorEvents
      operatorLadderBase operatorLadderOp operatorLadderRealizes
      operatorLadderCost operatorLadderBudget operatorLadderCriterion
      operatorLadderActive operatorLadderCertified := by
  intro n
  exact ⟨n, operatorLadderParents n, (), operatorLadderChild n,
    le_rfl, operatorLadder_event n⟩

/-- Stronger non-vacuity: for every finite length there is one explicit linked
lineage in which each retained child is a parent of the next event. -/
theorem operatorLadder_chain (n : ℕ) :
    EmergenceDrivenOperatorChain
      operatorLadderBase operatorLadderOp operatorLadderRealizes
      operatorLadderCost operatorLadderBudget operatorLadderCriterion
      operatorLadderActive operatorLadderCertified
      0 (Sum.inl 1) n (Sum.inl (n + 1)) := by
  induction n with
  | zero =>
      simpa using
        (TimedRecursiveChain.base :
          EmergenceDrivenOperatorChain
            operatorLadderBase operatorLadderOp operatorLadderRealizes
            operatorLadderCost operatorLadderBudget operatorLadderCriterion
            operatorLadderActive operatorLadderCertified
            0 (Sum.inl 1) 0 (Sum.inl 1))
  | succ n ih =>
      have hLink :
          EmergenceDrivenOperatorStepAt
            operatorLadderBase operatorLadderOp operatorLadderRealizes
            operatorLadderCost operatorLadderBudget operatorLadderCriterion
            operatorLadderActive operatorLadderCertified
            n (Sum.inl (n + 1)) (Sum.inl (n + 2)) := by
        exact ⟨operatorLadderParents n, (), by
          simp [operatorLadderParents], operatorLadder_event n⟩
      simpa [Nat.add_assoc] using
        (TimedRecursiveChain.step ih hLink)

/-- The recurring premise therefore has an actual open-ended model. -/
theorem operatorLadder_openEndedNovelty :
    OpenEndedCumulativeNovelty operatorLadderActive := by
  exact recurringOperatorEvents_imply_openEndedNovelty
    operatorLadderBase operatorLadderOp operatorLadderRealizes
    operatorLadderCost operatorLadderBudget operatorLadderCriterion
    operatorLadderActive operatorLadderCertified
    operatorLadderActive_mono operatorLadder_recurring

end Ladder

section NonEmergentKnockout

/-- Non-emergent twin: one member of the pair already realizes the child. -/
def operatorLadderNonEmergentRealizes :
    CapacityRelation (Finset OperatorLadderCap) Unit OperatorLadderCap :=
  fun config _ child =>
    ∃ n,
      child = Sum.inl (n + 2) ∧
      Sum.inl n ∈ config

theorem operatorLadder_nonEmergent (t : ℕ) :
    ¬ EmergentUnder
      (FiniteProperSubconfig (Process := OperatorLadderCap))
      operatorLadderNonEmergentRealizes
      (operatorLadderParents t) () (operatorLadderChild t) := by
  intro h
  apply h.2 {Sum.inl t}
  · rw [Finset.ssubset_iff_subset_ne]
    refine ⟨by simp [operatorLadderParents], ?_⟩
    intro hEq
    have hMem :
        Sum.inl (t + 1) ∈ ({Sum.inl t} : Finset OperatorLadderCap) := by
      rw [hEq]
      simp [operatorLadderParents]
    simp at hMem
  · exact ⟨t, rfl, by simp⟩

/-- Under the non-emergent twin, the certification transition used by the
positive ladder is impossible: the child cannot acquire emergent provenance. -/
theorem operatorLadder_nonEmergent_blocks_certification (t : ℕ) :
    ¬ IsolatedEmergenceCertificationLawAt
      operatorLadderNonEmergentRealizes operatorLadderCertified t
      (operatorLadderParents t) () (operatorLadderChild t) := by
  intro hLaw
  have hNext :
      operatorLadderCertified (t + 1) (operatorLadderChild t) := by
    simp [operatorLadderCertified, operatorLadderChild]
  have hOldOrEmergent := (hLaw (operatorLadderChild t)).1 hNext
  rcases hOldOrEmergent with hOld | ⟨hEq, hEmergent⟩
  · have hNotOld :
        ¬ operatorLadderCertified t (operatorLadderChild t) := by
      simp [operatorLadderCertified, operatorLadderChild]
    exact hNotOld hOld
  · exact operatorLadder_nonEmergent t hEmergent

/-- If the generated child is admitted as material but receives no new
emergence certificate, full closure still cannot expand. This is the repaired
Q2: retention of the label is insufficient without emergent provenance. -/
theorem operatorLadder_uncertified_admission_no_click (t : ℕ) :
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
        (operatorLadderChild t)) := by
  apply uncertified_generated_promotion_no_closure_click
    operatorLadderBase operatorLadderOp
    (fun x => x ∈ operatorLadderActive t)
    (operatorLadderCertified t)
    (operatorLadderChild t)
  · refine ⟨operatorLadderParents t, ?_, ?_⟩
    · intro x hx
      simp only [operatorLadderParents, Finset.mem_insert,
        Finset.mem_singleton] at hx
      rcases hx with rfl | rfl <;> simp [operatorLadderActive]
    · exact Or.inl ⟨t, rfl, rfl⟩
  · simp [operatorLadderCertified, operatorLadderChild]

end NonEmergentKnockout

#print axioms operatorLadder_event
#print axioms operatorLadder_click_every_step
#print axioms operatorLadder_recursive
#print axioms operatorLadder_recurring
#print axioms operatorLadder_chain
#print axioms operatorLadder_openEndedNovelty
#print axioms operatorLadder_nonEmergent_blocks_certification
#print axioms operatorLadder_uncertified_admission_no_click

end RecursiveAccessibility
end CumulativeAccessibility
