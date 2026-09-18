import CumulativeAccessibility.ResponseDynamics
import CumulativeAccessibility.FunctionalRatchetVelocity
import CumulativeAccessibility.RatchetVelocityLedger

open scoped BigOperators

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Bounded opportunity gaps and a deterministic update-rate bridge

The existing RecurringOpportunity predicate is qualitative: opportunities occur
arbitrarily late, but the waiting time may grow without bound. That is enough
for open-endedness, but it cannot imply any positive lower bound on update
frequency.

This module adds the minimal quantitative strengthening needed for a first
mechanism-to-speed theorem:

* opportunities occur within a bounded gap;
* each opportunity receives a resource-feasible validated response within a
  bounded lag.

Together they imply a bounded gap between resource-validated successful
updates. Equivalently, every sliding window of a derived finite width contains
at least one validated update.

A final application seam can connect each validated update to a minimum
functional gain on a declared target. This yields at least one such gain in
every derived window. It is a deterministic local rate certificate, not yet a
claim about a universal long-run stochastic average.
-/

section BoundedEventDefinitions

variable {α : Type*} [DecidableEq α]

/-- From every starting index, an opportunity occurs no later than gap steps
after that index. This strengthens qualitative RecurringOpportunity. -/
def OpportunityGapBound
    (gap : ℕ)
    (Opportunity : ℕ → Prop) : Prop :=
  ∀ n : ℕ, ∃ q : ℕ,
    n ≤ q ∧ q ≤ n + gap ∧ Opportunity q

/-- From every starting index, a complete resource-validated success occurs no
later than gap steps afterward. -/
def ResourceValidatedSuccessGapBound
    (gap : ℕ)
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α) : Prop :=
  ∀ n : ℕ, ∃ r : ℕ,
    n ≤ r ∧
    r ≤ n + gap ∧
    ResourceValidatedSuccessAt Cost Budget U H E S r

/-- Every sliding window of the declared positive width contains a
resource-validated success. The upper endpoint is exclusive. -/
def ResourceValidatedSuccessEveryWindow
    (window : ℕ)
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α) : Prop :=
  0 < window ∧
  ∀ n : ℕ, ∃ r : ℕ,
    n ≤ r ∧
    r < n + window ∧
    ResourceValidatedSuccessAt Cost Budget U H E S r

end BoundedEventDefinitions

section BoundedEventImplications

variable {α : Type*} [DecidableEq α]

/-- Persistent support plus a same-index support-to-opportunity connection
gives the strongest possible opportunity-gap certificate: gap zero. -/
theorem persistentSupport_and_connection_imply_zeroGapOpportunity
    (Support Opportunity : ℕ → Prop)
    (hSupport : ∀ n, Support n)
    (hConnection : SupportImpliesOpportunity Support Opportunity) :
    OpportunityGapBound 0 Opportunity := by
  intro n
  refine ⟨n, le_rfl, ?_, hConnection n (hSupport n)⟩
  simp

/-- A bounded opportunity gap immediately implies qualitative recurrence. -/
theorem opportunityGapBound_implies_recurringOpportunity
    (gap : ℕ)
    (Opportunity : ℕ → Prop)
    (h : OpportunityGapBound gap Opportunity) :
    RecurringOpportunity Opportunity := by
  intro n
  obtain ⟨q, hnq, hqBound, hOpp⟩ := h n
  exact ⟨q, hnq, hOpp⟩

/-- Core mechanism-to-frequency theorem.

If an opportunity appears within at most opportunityGap steps from every
starting index, and every opportunity receives a resource-feasible validated
response within responseLag steps, then a resource-validated success appears
within at most opportunityGap + responseLag steps from every starting index. -/
theorem boundedOpportunity_and_response_imply_successGapBound
    (opportunityGap responseLag : ℕ)
    (Opportunity : ℕ → Prop)
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hOpportunity : OpportunityGapBound opportunityGap Opportunity)
    (hResponse :
      OpportunityConditionedResourceResponseWithin
        responseLag Opportunity Cost Budget U H E S) :
    ResourceValidatedSuccessGapBound
      (opportunityGap + responseLag) Cost Budget U H E S := by
  intro n
  obtain ⟨q, hnq, hqBound, hOpp⟩ := hOpportunity n
  obtain ⟨r, hqr, hrBound, hSuccess⟩ := hResponse q hOpp
  refine ⟨r, le_trans hnq hqr, ?_, hSuccess⟩
  omega

/-- A gap bound of g is equivalently strong enough to certify one success in
every sliding window of width g+1. -/
theorem successGapBound_implies_everyWindow
    (gap : ℕ)
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (h :
      ResourceValidatedSuccessGapBound gap Cost Budget U H E S) :
    ResourceValidatedSuccessEveryWindow
      (gap + 1) Cost Budget U H E S := by
  constructor
  · omega
  · intro n
    obtain ⟨r, hnr, hrBound, hSuccess⟩ := h n
    refine ⟨r, hnr, ?_, hSuccess⟩
    omega

/-- Direct window form of the mechanism-to-speed bridge. -/
theorem boundedOpportunity_and_response_imply_successEveryWindow
    (opportunityGap responseLag : ℕ)
    (Opportunity : ℕ → Prop)
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hOpportunity : OpportunityGapBound opportunityGap Opportunity)
    (hResponse :
      OpportunityConditionedResourceResponseWithin
        responseLag Opportunity Cost Budget U H E S) :
    ResourceValidatedSuccessEveryWindow
      (opportunityGap + responseLag + 1)
      Cost Budget U H E S := by
  have hGap :
      ResourceValidatedSuccessGapBound
        (opportunityGap + responseLag) Cost Budget U H E S :=
    boundedOpportunity_and_response_imply_successGapBound
      opportunityGap responseLag Opportunity Cost Budget U H E S
      hOpportunity hResponse
  simpa [Nat.add_assoc] using
    successGapBound_implies_everyWindow
      (opportunityGap + responseLag) Cost Budget U H E S hGap

/-- The maintained canonical three-cycle supplies a zero-gap opportunity
certificate whenever its preserved quantitative support is explicitly declared
sufficient for the chosen opportunity predicate. -/
theorem supportedCycle3Maintenance_supplies_zeroGapOpportunity
    (Opportunity : ℕ → Prop)
    {rA rB rC kAB kBC kCA : ℝ}
    (hrA : 0 ≤ rA) (hrB : 0 ≤ rB) (hrC : 0 ≤ rC)
    (hdB : 0 < CollectiveAlignment.maintenanceDeficit rB)
    (hdC : 0 < CollectiveAlignment.maintenanceDeficit rC)
    (hkAB : 0 < kAB) (hkBC : 0 < kBC)
    (hkCA : 0 ≤ kCA)
    (hloop :
      CollectiveAlignment.maintenanceDeficit rA *
          CollectiveAlignment.maintenanceDeficit rB *
          CollectiveAlignment.maintenanceDeficit rC
        ≤ kAB * kBC * kCA)
    (hConnection :
      SupportImpliesOpportunity
        (cycle3MaintenanceSupport rA rB rC kAB kBC kCA)
        Opportunity) :
    OpportunityGapBound 0 Opportunity := by
  exact persistentSupport_and_connection_imply_zeroGapOpportunity
    (cycle3MaintenanceSupport rA rB rC kAB kBC kCA)
    Opportunity
    (cycle3MaintenanceSupport_persistent
      hrA hrB hrC hdB hdC hkAB hkBC hkCA hloop)
    hConnection

/-- First end-to-end maintenance-to-frequency theorem.

Under the exact maintained three-cycle assumptions, plus an explicit
support-to-opportunity connection and a bounded resource-feasible validated
response guarantee, every sliding window of width responseLag+1 contains a
resource-validated update. -/
theorem supportedCycle3Maintenance_and_boundedResponse_imply_successEveryWindow
    (responseLag : ℕ)
    (Opportunity : ℕ → Prop)
    {rA rB rC kAB kBC kCA : ℝ}
    (hrA : 0 ≤ rA) (hrB : 0 ≤ rB) (hrC : 0 ≤ rC)
    (hdB : 0 < CollectiveAlignment.maintenanceDeficit rB)
    (hdC : 0 < CollectiveAlignment.maintenanceDeficit rC)
    (hkAB : 0 < kAB) (hkBC : 0 < kBC)
    (hkCA : 0 ≤ kCA)
    (hloop :
      CollectiveAlignment.maintenanceDeficit rA *
          CollectiveAlignment.maintenanceDeficit rB *
          CollectiveAlignment.maintenanceDeficit rC
        ≤ kAB * kBC * kCA)
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (hConnection :
      SupportImpliesOpportunity
        (cycle3MaintenanceSupport rA rB rC kAB kBC kCA)
        Opportunity)
    (hResponse :
      OpportunityConditionedResourceResponseWithin
        responseLag Opportunity Cost Budget U H E S) :
    ResourceValidatedSuccessEveryWindow
      (responseLag + 1) Cost Budget U H E S := by
  have hOpp :
      OpportunityGapBound 0 Opportunity :=
    supportedCycle3Maintenance_supplies_zeroGapOpportunity
      Opportunity hrA hrB hrC hdB hdC hkAB hkBC hkCA hloop hConnection
  simpa using
    boundedOpportunity_and_response_imply_successEveryWindow
      0 responseLag Opportunity Cost Budget U H E S hOpp hResponse

/-- Bounded successful-update gaps imply the earlier qualitative validated
uptake predicate. This connects the rate layer back to the open-endedness
stack. -/
theorem successGapBound_implies_validatedUptake
    (gap : ℕ)
    (Cost : ResponseCost α)
    (Budget : ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → HyperGenerator α)
    (E : ExternalCriterion α)
    (S : ℕ → Finset α)
    (h :
      ResourceValidatedSuccessGapBound gap Cost Budget U H E S) :
    ValidatedGenerativeCapacityUptake U H E S := by
  intro n
  obtain ⟨r, hnr, hrBound, hSuccess⟩ := h n
  obtain ⟨z, hzU, hzNot, hGen, hResource, hEval, hzNext⟩ := hSuccess
  exact ⟨r, z, hnr, hzU, hzNot, hGen, hEval, hzNext⟩

end BoundedEventImplications

#print axioms persistentSupport_and_connection_imply_zeroGapOpportunity
#print axioms boundedOpportunity_and_response_imply_successGapBound
#print axioms boundedOpportunity_and_response_imply_successEveryWindow
#print axioms supportedCycle3Maintenance_supplies_zeroGapOpportunity
#print axioms supportedCycle3Maintenance_and_boundedResponse_imply_successEveryWindow
#print axioms successGapBound_implies_validatedUptake

end RecursiveAccessibility

namespace FunctionalOrganization

/-!
## Functional-gain specialization

A resource-validated novelty event is not automatically a functional
improvement. The bridge below therefore keeps one explicit application premise:
every declared successful update used in the rate calculation must yield at
least minGain on the chosen functional target.

Under that premise, the bounded opportunity/response theorem yields at least
one functional gain of minGain in every finite window of derived width.
-/

section FunctionalGainBridge

variable {α σ φ : Type*} [DecidableEq α]

/-- Application seam connecting a complete resource-validated update to a
minimum one-step functional gain on a declared target. -/
def ValidatedSuccessImpliesMinimumFunctionalGain
    (CostResponse : RecursiveAccessibility.ResponseCost α)
    (Budget : RecursiveAccessibility.ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → RecursiveAccessibility.HyperGenerator α)
    (E : RecursiveAccessibility.ExternalCriterion α)
    (S : ℕ → Finset α)
    (CostFunctional : FunctionalCost σ φ)
    (trajectory : ℕ → σ)
    (target : φ)
    (minGain : ℝ) : Prop :=
  ∀ r : ℕ,
    RecursiveAccessibility.ResourceValidatedSuccessAt
      CostResponse Budget U H E S r →
    minGain ≤
      TrajectoryFunctionalVelocity CostFunctional trajectory r target

/-- The chosen target realizes at least minGain once in every sliding window
of the declared width. -/
def FunctionalGainEveryWindow
    (window : ℕ)
    (CostFunctional : FunctionalCost σ φ)
    (trajectory : ℕ → σ)
    (target : φ)
    (minGain : ℝ) : Prop :=
  0 < window ∧
  ∀ n : ℕ, ∃ r : ℕ,
    n ≤ r ∧
    r < n + window ∧
    minGain ≤
      TrajectoryFunctionalVelocity CostFunctional trajectory r target

/-- Main deterministic mechanism-to-functional-speed theorem.

Bounded opportunity gaps plus bounded resource-feasible validated response,
together with a declared minimum functional gain per validated update, force
at least one gain of minGain in every window of width
opportunityGap + responseLag + 1. -/
theorem boundedMechanism_implies_functionalGainEveryWindow
    (opportunityGap responseLag : ℕ)
    (Opportunity : ℕ → Prop)
    (CostResponse : RecursiveAccessibility.ResponseCost α)
    (Budget : RecursiveAccessibility.ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → RecursiveAccessibility.HyperGenerator α)
    (E : RecursiveAccessibility.ExternalCriterion α)
    (S : ℕ → Finset α)
    (CostFunctional : FunctionalCost σ φ)
    (trajectory : ℕ → σ)
    (target : φ)
    (minGain : ℝ)
    (hOpportunity :
      RecursiveAccessibility.OpportunityGapBound opportunityGap Opportunity)
    (hResponse :
      RecursiveAccessibility.OpportunityConditionedResourceResponseWithin
        responseLag Opportunity CostResponse Budget U H E S)
    (hGain :
      ValidatedSuccessImpliesMinimumFunctionalGain
        CostResponse Budget U H E S
        CostFunctional trajectory target minGain) :
    FunctionalGainEveryWindow
      (opportunityGap + responseLag + 1)
      CostFunctional trajectory target minGain := by
  have hWindow :
      RecursiveAccessibility.ResourceValidatedSuccessEveryWindow
        (opportunityGap + responseLag + 1)
        CostResponse Budget U H E S :=
    RecursiveAccessibility.boundedOpportunity_and_response_imply_successEveryWindow
      opportunityGap responseLag Opportunity
      CostResponse Budget U H E S
      hOpportunity hResponse
  refine ⟨hWindow.1, ?_⟩
  intro n
  obtain ⟨r, hnr, hrWindow, hSuccess⟩ := hWindow.2 n
  exact ⟨r, hnr, hrWindow, hGain r hSuccess⟩

/-- End-to-end maintenance-to-functional-speed theorem.

The exact maintained three-cycle supplies support at every indexed time. If
that support is declared sufficient for opportunities, every opportunity is
answered within responseLag, and every resource-validated update produces at
least minGain on the chosen functional target, then every sliding window of
width responseLag+1 contains at least that functional gain. -/
theorem supportedCycle3Maintenance_boundedResponse_and_minGain_imply_functionalGainEveryWindow
    (responseLag : ℕ)
    (Opportunity : ℕ → Prop)
    {rA rB rC kAB kBC kCA : ℝ}
    (hrA : 0 ≤ rA) (hrB : 0 ≤ rB) (hrC : 0 ≤ rC)
    (hdB : 0 < CollectiveAlignment.maintenanceDeficit rB)
    (hdC : 0 < CollectiveAlignment.maintenanceDeficit rC)
    (hkAB : 0 < kAB) (hkBC : 0 < kBC)
    (hkCA : 0 ≤ kCA)
    (hloop :
      CollectiveAlignment.maintenanceDeficit rA *
          CollectiveAlignment.maintenanceDeficit rB *
          CollectiveAlignment.maintenanceDeficit rC
        ≤ kAB * kBC * kCA)
    (CostResponse : RecursiveAccessibility.ResponseCost α)
    (Budget : RecursiveAccessibility.ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → RecursiveAccessibility.HyperGenerator α)
    (E : RecursiveAccessibility.ExternalCriterion α)
    (S : ℕ → Finset α)
    (CostFunctional : FunctionalCost σ φ)
    (trajectory : ℕ → σ)
    (target : φ)
    (minGain : ℝ)
    (hConnection :
      RecursiveAccessibility.SupportImpliesOpportunity
        (RecursiveAccessibility.cycle3MaintenanceSupport
          rA rB rC kAB kBC kCA)
        Opportunity)
    (hResponse :
      RecursiveAccessibility.OpportunityConditionedResourceResponseWithin
        responseLag Opportunity CostResponse Budget U H E S)
    (hGain :
      ValidatedSuccessImpliesMinimumFunctionalGain
        CostResponse Budget U H E S
        CostFunctional trajectory target minGain) :
    FunctionalGainEveryWindow
      (responseLag + 1)
      CostFunctional trajectory target minGain := by
  have hOpp :
      RecursiveAccessibility.OpportunityGapBound 0 Opportunity :=
    RecursiveAccessibility.supportedCycle3Maintenance_supplies_zeroGapOpportunity
      Opportunity hrA hrB hrC hdB hdC hkAB hkBC hkCA hloop hConnection
  simpa using
    boundedMechanism_implies_functionalGainEveryWindow
      0 responseLag Opportunity
      CostResponse Budget U H E S
      CostFunctional trajectory target minGain
      hOpp hResponse hGain

/-- Sliding-window gain immediately yields the same gain guarantee on each
non-overlapping block of that width. This is the deterministic block-rate
interpretation. -/
theorem functionalGainEveryWindow_implies_everyBlock
    (window : ℕ)
    (CostFunctional : FunctionalCost σ φ)
    (trajectory : ℕ → σ)
    (target : φ)
    (minGain : ℝ)
    (h :
      FunctionalGainEveryWindow
        window CostFunctional trajectory target minGain) :
    ∀ k : ℕ, ∃ r : ℕ,
      k * window ≤ r ∧
      r < (k + 1) * window ∧
      minGain ≤
        TrajectoryFunctionalVelocity CostFunctional trajectory r target := by
  intro k
  obtain ⟨r, hkr, hrUpper, hGain⟩ := h.2 (k * window)
  refine ⟨r, hkr, ?_, hGain⟩
  simpa [Nat.add_mul] using hrUpper

/-- Total functional gain on one non-overlapping block. -/
def BlockFunctionalGain
    (window : ℕ)
    (CostFunctional : FunctionalCost σ φ)
    (trajectory : ℕ → σ)
    (target : φ)
    (k : ℕ) : ℝ :=
  (Finset.range window).sum (fun j =>
    TrajectoryFunctionalVelocity
      CostFunctional trajectory (k * window + j) target)

/-- Mean functional gain per indexed step on one block. -/
noncomputable def BlockAverageFunctionalRate
    (window : ℕ)
    (CostFunctional : FunctionalCost σ φ)
    (trajectory : ℕ → σ)
    (target : φ)
    (k : ℕ) : ℝ :=
  BlockFunctionalGain window CostFunctional trajectory target k /
    (window : ℝ)

/-- Conservative scalar attached to a block certificate: minimum gain divided
by block width. Before a nonnegative-gain condition is assumed, this number is
only a certificate scale; with nonnegative per-step gain it becomes a
machine-checked lower bound on each block's actual average functional rate. -/
noncomputable def CertifiedBlockGainRate
    (minGain : ℝ)
    (window : ℕ) : ℝ :=
  minGain / (window : ℝ)

/-- If every per-step gain on the target is nonnegative, then the one certified
gain of at least minGain in each block forces the total block gain to be at
least minGain. -/
theorem functionalGainEveryWindow_and_nonnegative_imply_blockGainLowerBound
    (window : ℕ)
    (CostFunctional : FunctionalCost σ φ)
    (trajectory : ℕ → σ)
    (target : φ)
    (minGain : ℝ)
    (hWindow :
      FunctionalGainEveryWindow
        window CostFunctional trajectory target minGain)
    (hNonnegative :
      ∀ t : ℕ,
        0 ≤ TrajectoryFunctionalVelocity
          CostFunctional trajectory t target) :
    ∀ k : ℕ,
      minGain ≤
        BlockFunctionalGain
          window CostFunctional trajectory target k := by
  intro k
  obtain ⟨r, hStart, hEnd, hGain⟩ :=
    functionalGainEveryWindow_implies_everyBlock
      window CostFunctional trajectory target minGain hWindow k
  let j : ℕ := r - k * window
  have hjlt : j < window := by
    dsimp [j]
    rw [Nat.sub_lt_iff_lt_add' hStart]
    simpa [Nat.add_mul] using hEnd
  have hjeq : k * window + j = r := by
    dsimp [j]
    exact Nat.add_sub_of_le hStart
  have hTerm :
      minGain ≤
        TrajectoryFunctionalVelocity
          CostFunctional trajectory (k * window + j) target := by
    rw [hjeq]
    exact hGain
  calc
    minGain ≤
        TrajectoryFunctionalVelocity
          CostFunctional trajectory (k * window + j) target := hTerm
    _ ≤ BlockFunctionalGain
          window CostFunctional trajectory target k := by
      unfold BlockFunctionalGain
      apply Finset.single_le_sum
      · intro i hi
        exact hNonnegative (k * window + i)
      · simpa using hjlt

/-- Under nonnegative per-step target gain, the block certificate now becomes a
genuine average-rate lower bound on every non-overlapping block. -/
theorem certifiedBlockGainRate_le_blockAverageFunctionalRate
    (window : ℕ)
    (CostFunctional : FunctionalCost σ φ)
    (trajectory : ℕ → σ)
    (target : φ)
    (minGain : ℝ)
    (hWindow :
      FunctionalGainEveryWindow
        window CostFunctional trajectory target minGain)
    (hNonnegative :
      ∀ t : ℕ,
        0 ≤ TrajectoryFunctionalVelocity
          CostFunctional trajectory t target) :
    ∀ k : ℕ,
      CertifiedBlockGainRate minGain window ≤
        BlockAverageFunctionalRate
          window CostFunctional trajectory target k := by
  intro k
  have hDen : 0 < (window : ℝ) := by
    exact_mod_cast hWindow.1
  unfold CertifiedBlockGainRate BlockAverageFunctionalRate
  exact (div_le_div_iff_of_pos_right hDen).2
    (functionalGainEveryWindow_and_nonnegative_imply_blockGainLowerBound
      window CostFunctional trajectory target minGain
      hWindow hNonnegative k)

theorem certifiedBlockGainRate_positive
    (minGain : ℝ)
    (window : ℕ)
    (hGain : 0 < minGain)
    (hWindow : 0 < window) :
    0 < CertifiedBlockGainRate minGain window := by
  unfold CertifiedBlockGainRate
  exact div_pos hGain (by exact_mod_cast hWindow)

/-- Strong ratchet steps on a retained target family supply the nonnegative
per-step premise needed by the block-average theorem for every member of that
family. -/
theorem trajectoryRatchetSteps_imply_target_nonnegative
    (targets : Set φ)
    (CostFunctional : FunctionalCost σ φ)
    (trajectory : ℕ → σ)
    (target : φ)
    (hTarget : target ∈ targets)
    (hSteps :
      ∀ t : ℕ,
        TrajectoryRatchetStepOn targets CostFunctional trajectory t) :
    ∀ t : ℕ,
      0 ≤ TrajectoryFunctionalVelocity
        CostFunctional trajectory t target := by
  intro t
  exact (hSteps t).1 target hTarget

/-- The conservative rate floor certified by opportunity-gap bound K,
response-lag bound Δ, and minimum functional gain g. -/
noncomputable def BoundedMechanismRateFloor
    (opportunityGap responseLag : ℕ)
    (minGain : ℝ) : ℝ :=
  CertifiedBlockGainRate
    minGain (opportunityGap + responseLag + 1)

/-- Full generic mechanism-to-average-rate theorem.

Once bounded opportunity and response produce the gain-window certificate, and
the chosen target never moves backward between certified gains, the mechanism
rate floor is a lower bound on every actual non-overlapping block average. -/
theorem boundedMechanism_implies_blockAverageRateFloor
    (opportunityGap responseLag : ℕ)
    (Opportunity : ℕ → Prop)
    (CostResponse : RecursiveAccessibility.ResponseCost α)
    (Budget : RecursiveAccessibility.ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → RecursiveAccessibility.HyperGenerator α)
    (E : RecursiveAccessibility.ExternalCriterion α)
    (S : ℕ → Finset α)
    (CostFunctional : FunctionalCost σ φ)
    (trajectory : ℕ → σ)
    (target : φ)
    (minGain : ℝ)
    (hOpportunity :
      RecursiveAccessibility.OpportunityGapBound opportunityGap Opportunity)
    (hResponse :
      RecursiveAccessibility.OpportunityConditionedResourceResponseWithin
        responseLag Opportunity CostResponse Budget U H E S)
    (hGain :
      ValidatedSuccessImpliesMinimumFunctionalGain
        CostResponse Budget U H E S
        CostFunctional trajectory target minGain)
    (hNonnegative :
      ∀ t : ℕ,
        0 ≤ TrajectoryFunctionalVelocity
          CostFunctional trajectory t target) :
    ∀ k : ℕ,
      BoundedMechanismRateFloor opportunityGap responseLag minGain ≤
        BlockAverageFunctionalRate
          (opportunityGap + responseLag + 1)
          CostFunctional trajectory target k := by
  have hWindow :
      FunctionalGainEveryWindow
        (opportunityGap + responseLag + 1)
        CostFunctional trajectory target minGain :=
    boundedMechanism_implies_functionalGainEveryWindow
      opportunityGap responseLag Opportunity
      CostResponse Budget U H E S
      CostFunctional trajectory target minGain
      hOpportunity hResponse hGain
  simpa [BoundedMechanismRateFloor] using
    (certifiedBlockGainRate_le_blockAverageFunctionalRate
      (opportunityGap + responseLag + 1)
      CostFunctional trajectory target minGain
      hWindow hNonnegative)

/-- Canonical-maintenance specialization of the generic rate floor. -/
noncomputable def MaintainedCycleRateFloor
    (responseLag : ℕ)
    (minGain : ℝ) : ℝ :=
  CertifiedBlockGainRate minGain (responseLag + 1)

/-- Under the maintained three-cycle route, nonnegative target gain turns the
Δ+1 window certificate into an actual block-average rate floor. -/
theorem supportedCycle3Maintenance_implies_blockAverageRateFloor
    (responseLag : ℕ)
    (Opportunity : ℕ → Prop)
    {rA rB rC kAB kBC kCA : ℝ}
    (hrA : 0 ≤ rA) (hrB : 0 ≤ rB) (hrC : 0 ≤ rC)
    (hdB : 0 < CollectiveAlignment.maintenanceDeficit rB)
    (hdC : 0 < CollectiveAlignment.maintenanceDeficit rC)
    (hkAB : 0 < kAB) (hkBC : 0 < kBC)
    (hkCA : 0 ≤ kCA)
    (hloop :
      CollectiveAlignment.maintenanceDeficit rA *
          CollectiveAlignment.maintenanceDeficit rB *
          CollectiveAlignment.maintenanceDeficit rC
        ≤ kAB * kBC * kCA)
    (CostResponse : RecursiveAccessibility.ResponseCost α)
    (Budget : RecursiveAccessibility.ResponseBudget)
    (U : ℕ → Finset α)
    (H : ℕ → RecursiveAccessibility.HyperGenerator α)
    (E : RecursiveAccessibility.ExternalCriterion α)
    (S : ℕ → Finset α)
    (CostFunctional : FunctionalCost σ φ)
    (trajectory : ℕ → σ)
    (target : φ)
    (minGain : ℝ)
    (hConnection :
      RecursiveAccessibility.SupportImpliesOpportunity
        (RecursiveAccessibility.cycle3MaintenanceSupport
          rA rB rC kAB kBC kCA)
        Opportunity)
    (hResponse :
      RecursiveAccessibility.OpportunityConditionedResourceResponseWithin
        responseLag Opportunity CostResponse Budget U H E S)
    (hGain :
      ValidatedSuccessImpliesMinimumFunctionalGain
        CostResponse Budget U H E S
        CostFunctional trajectory target minGain)
    (hNonnegative :
      ∀ t : ℕ,
        0 ≤ TrajectoryFunctionalVelocity
          CostFunctional trajectory t target) :
    ∀ k : ℕ,
      MaintainedCycleRateFloor responseLag minGain ≤
        BlockAverageFunctionalRate
          (responseLag + 1)
          CostFunctional trajectory target k := by
  have hWindow :
      FunctionalGainEveryWindow
        (responseLag + 1)
        CostFunctional trajectory target minGain :=
    supportedCycle3Maintenance_boundedResponse_and_minGain_imply_functionalGainEveryWindow
      responseLag Opportunity
      hrA hrB hrC hdB hdC hkAB hkBC hkCA hloop
      CostResponse Budget U H E S
      CostFunctional trajectory target minGain
      hConnection hResponse hGain
  simpa [MaintainedCycleRateFloor] using
    (certifiedBlockGainRate_le_blockAverageFunctionalRate
      (responseLag + 1)
      CostFunctional trajectory target minGain
      hWindow hNonnegative)

/-- Increasing the guaranteed minimum gain at fixed delays strictly raises the
certified mechanism rate floor. -/
theorem largerMinimumGain_strictlyRaises_rateFloor
    (opportunityGap responseLag : ℕ)
    {oldGain newGain : ℝ}
    (hGain : oldGain < newGain) :
    BoundedMechanismRateFloor opportunityGap responseLag oldGain <
      BoundedMechanismRateFloor opportunityGap responseLag newGain := by
  unfold BoundedMechanismRateFloor CertifiedBlockGainRate
  have hDen :
      0 < ((opportunityGap + responseLag + 1 : ℕ) : ℝ) := by
    exact_mod_cast (show 0 < opportunityGap + responseLag + 1 by omega)
  exact div_lt_div_of_pos_right hGain hDen

/-- At fixed opportunity gap and positive minimum gain, a strictly shorter
validated-response lag strictly raises the guaranteed rate floor. -/
theorem shorterResponseLag_strictlyRaises_rateFloor
    (opportunityGap : ℕ)
    {oldLag newLag : ℕ}
    (minGain : ℝ)
    (hGain : 0 < minGain)
    (hLag : newLag < oldLag) :
    BoundedMechanismRateFloor opportunityGap oldLag minGain <
      BoundedMechanismRateFloor opportunityGap newLag minGain := by
  unfold BoundedMechanismRateFloor CertifiedBlockGainRate
  have hNewDen :
      0 < ((opportunityGap + newLag + 1 : ℕ) : ℝ) := by
    exact_mod_cast (show 0 < opportunityGap + newLag + 1 by omega)
  have hDenLt :
      ((opportunityGap + newLag + 1 : ℕ) : ℝ) <
        ((opportunityGap + oldLag + 1 : ℕ) : ℝ) := by
    exact_mod_cast
      (show opportunityGap + newLag + 1 <
          opportunityGap + oldLag + 1 by omega)
  exact div_lt_div_of_pos_left hGain hNewDen hDenLt

/-- At fixed response lag and positive minimum gain, a strictly shorter maximum
wait for opportunity strictly raises the guaranteed rate floor. -/
theorem shorterOpportunityGap_strictlyRaises_rateFloor
    (responseLag : ℕ)
    {oldGap newGap : ℕ}
    (minGain : ℝ)
    (hGain : 0 < minGain)
    (hGap : newGap < oldGap) :
    BoundedMechanismRateFloor oldGap responseLag minGain <
      BoundedMechanismRateFloor newGap responseLag minGain := by
  unfold BoundedMechanismRateFloor CertifiedBlockGainRate
  have hNewDen :
      0 < ((newGap + responseLag + 1 : ℕ) : ℝ) := by
    exact_mod_cast (show 0 < newGap + responseLag + 1 by omega)
  have hDenLt :
      ((newGap + responseLag + 1 : ℕ) : ℝ) <
        ((oldGap + responseLag + 1 : ℕ) : ℝ) := by
    exact_mod_cast
      (show newGap + responseLag + 1 <
          oldGap + responseLag + 1 by omega)
  exact div_lt_div_of_pos_left hGain hNewDen hDenLt

#print axioms boundedMechanism_implies_functionalGainEveryWindow
#print axioms supportedCycle3Maintenance_boundedResponse_and_minGain_imply_functionalGainEveryWindow
#print axioms functionalGainEveryWindow_implies_everyBlock
#print axioms functionalGainEveryWindow_and_nonnegative_imply_blockGainLowerBound
#print axioms certifiedBlockGainRate_le_blockAverageFunctionalRate
#print axioms certifiedBlockGainRate_positive
#print axioms trajectoryRatchetSteps_imply_target_nonnegative
#print axioms boundedMechanism_implies_blockAverageRateFloor
#print axioms supportedCycle3Maintenance_implies_blockAverageRateFloor
#print axioms largerMinimumGain_strictlyRaises_rateFloor
#print axioms shorterResponseLag_strictlyRaises_rateFloor
#print axioms shorterOpportunityGap_strictlyRaises_rateFloor

end FunctionalGainBridge

end FunctionalOrganization
end CumulativeAccessibility
