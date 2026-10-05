import CumulativeAccessibility.DynamicVortex
import CumulativeAccessibility.RatchetVelocityLedger

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Network vortex ledger: transfer versus creation inside the vortex

`EndogenousBudgetBridge.lean` and `DynamicVortex.lean` treat the vortex as one
organization:

  slack  = uptake(organization, gradient) - maintenance(organization)
  budget = beta * slack

A network has parts. This file splits the same ledger over parts and adds one
distinction the single-organization ledger cannot express: whether a part's
gain is

* **creation**: more uptake from the external gradient or less maintenance, or
* **transfer**: an internal flow received from other parts, which sums to zero.

No new dynamics are introduced. Every result below is stated in the existing
vortex quantities `InternalSlackAt`, `InternallyViableAt` and
`EndogenousResponseBudget`.

Results:

* Transfers cancel: the whole's slack, and hence the vortex response budget, is
  the sum of part slacks for every pure transfer
  (`internalSlack_eq_sum_partSlack`, `endogenousResponseBudget_eq_sum_partSlack`,
  `partSlack_sum_transfer_invariant`).
* A transfer raises one part's slack by exactly what it lowers another's, while
  the whole is unchanged (`moveFlow_partSlack`, `moveFlow_pureTransfer`):
  ranking parts by their own slack rewards a move that adds nothing to the
  vortex.
* Transfers decide survival, not size. If every part covers its own maintenance
  the whole is viable (`networkViable_implies_internallyViable`); the whole is
  viable exactly when some pure transfer lets every part cover its maintenance
  (`internallyViable_iff_exists_viable_transfer`); and a transfer can break a
  part while the whole's slack is unchanged
  (`transfer_breaks_part_with_whole_unchanged`).
* Creation in any part raises the whole's response budget
  (`part_improvement_increases_endogenousResponseBudget`), and a strict creation
  opens a window of newly affordable responses
  (`part_creation_opens_response_window`).
* A non-viable whole cannot afford any positive-cost response
  (`nonviable_blocks_positive_cost_responses`), so under the velocity-ledger
  seam its ratchet velocity is zero (`nonviable_vortex_zero_velocity`).

Scope: one indexed time at a time, linear additive accounting, and a declared
part decomposition. The file does not say which real flows are transfers, does
not model how a failed part changes the shared transition machinery, and does
not derive normative conclusions.
-/

section NetworkLedger

variable {σ ι : Type*}

/-- Internal flow between parts: `flow t i` is what part `i` receives from other
parts at time `t` (negative when it gives). -/
abbrev InternalFlow (ι : Type*) := ℕ → ι → ℝ

/-- A flow is a pure transfer on `parts` when it creates nothing: what the parts
receive sums to zero at every time. -/
def PureTransfer (parts : Finset ι) (flow : InternalFlow ι) : Prop :=
  ∀ t, ∑ i ∈ parts, flow t i = 0

/-- The whole's uptake and maintenance are the sums of its parts'. -/
def AggregatesParts
    (parts : Finset ι)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (partUptake : ι → UptakeFunction σ)
    (partMaintenance : ι → MaintenanceDemand σ) : Prop :=
  (∀ x g, uptake x g = ∑ i ∈ parts, partUptake i x g) ∧
  (∀ x, maintenance x = ∑ i ∈ parts, partMaintenance i x)

/-- Slack of one part: its own uptake from the gradient, plus what it receives
from other parts, minus its own maintenance. -/
def PartSlackAt
    (state : ℕ → σ)
    (gradient : GradientStream)
    (partUptake : ι → UptakeFunction σ)
    (partMaintenance : ι → MaintenanceDemand σ)
    (flow : InternalFlow ι)
    (i : ι)
    (t : ℕ) : ℝ :=
  partUptake i (state t) (gradient t) + flow t i - partMaintenance i (state t)

/-- Every part covers its own maintenance. -/
def NetworkViableAt
    (parts : Finset ι)
    (state : ℕ → σ)
    (gradient : GradientStream)
    (partUptake : ι → UptakeFunction σ)
    (partMaintenance : ι → MaintenanceDemand σ)
    (flow : InternalFlow ι)
    (t : ℕ) : Prop :=
  ∀ i ∈ parts, 0 ≤ PartSlackAt state gradient partUptake partMaintenance flow i t

/-- **Transfers cancel.** The whole's vortex slack is the sum of part slacks for
every pure transfer. -/
theorem internalSlack_eq_sum_partSlack
    (parts : Finset ι)
    (state : ℕ → σ)
    (gradient : GradientStream)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (partUptake : ι → UptakeFunction σ)
    (partMaintenance : ι → MaintenanceDemand σ)
    (flow : InternalFlow ι)
    (hAgg : AggregatesParts parts uptake maintenance partUptake partMaintenance)
    (hFlow : PureTransfer parts flow)
    (t : ℕ) :
    InternalSlackAt state gradient uptake maintenance t =
      ∑ i ∈ parts,
        PartSlackAt state gradient partUptake partMaintenance flow i t := by
  unfold InternalSlackAt PartSlackAt
  rw [hAgg.1, hAgg.2, Finset.sum_sub_distrib, Finset.sum_add_distrib, hFlow t]
  ring

/-- The vortex response budget sees only the sum of part slacks. -/
theorem endogenousResponseBudget_eq_sum_partSlack
    (parts : Finset ι)
    (state : ℕ → σ)
    (gradient : GradientStream)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (beta : ReinvestmentFraction)
    (partUptake : ι → UptakeFunction σ)
    (partMaintenance : ι → MaintenanceDemand σ)
    (flow : InternalFlow ι)
    (hAgg : AggregatesParts parts uptake maintenance partUptake partMaintenance)
    (hFlow : PureTransfer parts flow)
    (t : ℕ) :
    EndogenousResponseBudget state gradient uptake maintenance beta t =
      beta t * ∑ i ∈ parts,
        PartSlackAt state gradient partUptake partMaintenance flow i t := by
  unfold EndogenousResponseBudget
  rw [internalSlack_eq_sum_partSlack parts state gradient uptake maintenance
    partUptake partMaintenance flow hAgg hFlow t]

/-- **No transfer changes the size of the vortex.** Any two pure transfers give
the same total part slack. -/
theorem partSlack_sum_transfer_invariant
    (parts : Finset ι)
    (state : ℕ → σ)
    (gradient : GradientStream)
    (partUptake : ι → UptakeFunction σ)
    (partMaintenance : ι → MaintenanceDemand σ)
    (flow flow' : InternalFlow ι)
    (hFlow : PureTransfer parts flow)
    (hFlow' : PureTransfer parts flow')
    (t : ℕ) :
    ∑ i ∈ parts, PartSlackAt state gradient partUptake partMaintenance flow i t =
      ∑ i ∈ parts, PartSlackAt state gradient partUptake partMaintenance flow' i t := by
  unfold PartSlackAt
  simp only [Finset.sum_sub_distrib, Finset.sum_add_distrib, hFlow t, hFlow' t]

section Move

variable [DecidableEq ι]

/-- Move `δ` from part `j` to part `i` at every time. -/
def moveFlow (flow : InternalFlow ι) (i j : ι) (δ : ℝ) : InternalFlow ι :=
  fun t k => flow t k + (if k = i then δ else 0) - (if k = j then δ else 0)

/-- Moving between two parts of the network keeps a pure transfer pure. -/
theorem moveFlow_pureTransfer
    (parts : Finset ι) (flow : InternalFlow ι) {i j : ι}
    (hi : i ∈ parts) (hj : j ∈ parts) (δ : ℝ)
    (hFlow : PureTransfer parts flow) :
    PureTransfer parts (moveFlow flow i j δ) := by
  intro t
  unfold moveFlow
  rw [Finset.sum_sub_distrib, Finset.sum_add_distrib, hFlow t,
    Finset.sum_ite_eq' parts i, Finset.sum_ite_eq' parts j]
  simp [hi, hj]

/-- **The selection gap.** Moving `δ` from `j` to `i` raises `i`'s slack by `δ`
and lowers `j`'s by `δ`; with `partSlack_sum_transfer_invariant`, the whole is
unchanged. -/
theorem moveFlow_partSlack
    (state : ℕ → σ)
    (gradient : GradientStream)
    (partUptake : ι → UptakeFunction σ)
    (partMaintenance : ι → MaintenanceDemand σ)
    (flow : InternalFlow ι) {i j : ι} (hij : i ≠ j) (δ : ℝ) (t : ℕ) :
    PartSlackAt state gradient partUptake partMaintenance (moveFlow flow i j δ) i t =
        PartSlackAt state gradient partUptake partMaintenance flow i t + δ ∧
    PartSlackAt state gradient partUptake partMaintenance (moveFlow flow i j δ) j t =
        PartSlackAt state gradient partUptake partMaintenance flow j t - δ := by
  simp only [PartSlackAt, moveFlow, if_pos rfl, if_neg hij, if_neg hij.symm]
  constructor <;> ring

end Move

/-- If every part covers its own maintenance, the whole is viable. -/
theorem networkViable_implies_internallyViable
    (parts : Finset ι)
    (state : ℕ → σ)
    (gradient : GradientStream)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (partUptake : ι → UptakeFunction σ)
    (partMaintenance : ι → MaintenanceDemand σ)
    (flow : InternalFlow ι)
    (hAgg : AggregatesParts parts uptake maintenance partUptake partMaintenance)
    (hFlow : PureTransfer parts flow)
    (t : ℕ)
    (hNet : NetworkViableAt parts state gradient partUptake partMaintenance flow t) :
    InternallyViableAt state gradient uptake maintenance t := by
  rw [internallyViableAt_iff_internalSlack_nonneg,
    internalSlack_eq_sum_partSlack parts state gradient uptake maintenance
      partUptake partMaintenance flow hAgg hFlow t]
  exact Finset.sum_nonneg hNet

/-- **Transfers decide survival, not size.** A nonempty whole is viable exactly
when some pure transfer lets every part cover its own maintenance. -/
theorem internallyViable_iff_exists_viable_transfer
    (parts : Finset ι)
    (hParts : parts.Nonempty)
    (state : ℕ → σ)
    (gradient : GradientStream)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (partUptake : ι → UptakeFunction σ)
    (partMaintenance : ι → MaintenanceDemand σ)
    (hAgg : AggregatesParts parts uptake maintenance partUptake partMaintenance)
    (t : ℕ) :
    InternallyViableAt state gradient uptake maintenance t ↔
      ∃ flow : InternalFlow ι, PureTransfer parts flow ∧
        NetworkViableAt parts state gradient partUptake partMaintenance flow t := by
  constructor
  · intro hViable
    have hn : (parts.card : ℝ) ≠ 0 := by
      exact_mod_cast (Finset.card_pos.mpr hParts).ne'
    -- Equal shares of the whole's slack.
    let share : ℕ → ℝ := fun t' =>
      InternalSlackAt state gradient uptake maintenance t' / parts.card
    let flow : InternalFlow ι := fun t' i =>
      partMaintenance i (state t') - partUptake i (state t') (gradient t') + share t'
    refine ⟨flow, ?_, ?_⟩
    · intro t'
      have hsum :
          ∑ i ∈ parts, flow t' i =
            maintenance (state t') - uptake (state t') (gradient t')
              + parts.card * share t' := by
        simp only [flow]
        rw [Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.sum_const,
          nsmul_eq_mul, ← hAgg.1, ← hAgg.2]
      rw [hsum]
      simp only [share, InternalSlackAt]
      field_simp
      ring
    · intro i _
      have hslack :=
        (internallyViableAt_iff_internalSlack_nonneg
          state gradient uptake maintenance t).mp hViable
      have hshare : 0 ≤ share t := div_nonneg hslack (Nat.cast_nonneg _)
      unfold PartSlackAt
      simp only [flow]
      linarith
  · intro h
    obtain ⟨flow, hFlow, hNet⟩ := h
    exact networkViable_implies_internallyViable parts state gradient uptake
      maintenance partUptake partMaintenance flow hAgg hFlow t hNet

/-- **A transfer can break a part while the whole is unchanged.** Two parts: a
commons with uptake 3 and maintenance 3, and a taker with uptake 2 and no
maintenance. Without transfer both cover their maintenance. If the taker takes 1
from the commons, the commons can no longer cover its maintenance, while the
whole's slack is 2 in both cases. -/
theorem transfer_breaks_part_with_whole_unchanged :
    let state : ℕ → Unit := fun _ => ()
    let gradient : GradientStream := fun _ => 0
    let partUptake : Bool → UptakeFunction Unit :=
      fun i _ _ => if i then 3 else 2
    let partMaintenance : Bool → MaintenanceDemand Unit :=
      fun i _ => if i then 3 else 0
    let noFlow : InternalFlow Bool := fun _ _ => 0
    let take : InternalFlow Bool := fun _ i => if i then -1 else 1
    PureTransfer Finset.univ noFlow ∧
    PureTransfer Finset.univ take ∧
    NetworkViableAt Finset.univ state gradient partUptake partMaintenance noFlow 0 ∧
    ¬ NetworkViableAt Finset.univ state gradient partUptake partMaintenance take 0 ∧
    ∑ i, PartSlackAt state gradient partUptake partMaintenance noFlow i 0 = 2 ∧
    ∑ i, PartSlackAt state gradient partUptake partMaintenance take i 0 = 2 := by
  intro state gradient partUptake partMaintenance noFlow take
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩
  · intro t
    simp [noFlow]
  · intro t
    simp [take]
  · intro i _
    cases i <;> simp [PartSlackAt, partUptake, partMaintenance, noFlow]
  · intro h
    have := h true (Finset.mem_univ _)
    norm_num [PartSlackAt, partUptake, partMaintenance, take] at this
  · norm_num [PartSlackAt, partUptake, partMaintenance, noFlow]
  · norm_num [PartSlackAt, partUptake, partMaintenance, take]

/-- **Creation anywhere raises the vortex budget.** If no part loses uptake and
no part gains maintenance, the whole's response budget does not fall. This is
the existing single-organization improvement theorem, applied part by part. -/
theorem part_improvement_increases_endogenousResponseBudget
    (parts : Finset ι)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (partUptake : ι → UptakeFunction σ)
    (partMaintenance : ι → MaintenanceDemand σ)
    (hAgg : AggregatesParts parts uptake maintenance partUptake partMaintenance)
    (oldState newState : σ)
    (g beta : ℝ)
    (hBeta : 0 ≤ beta)
    (hUptake : ∀ i ∈ parts, partUptake i oldState g ≤ partUptake i newState g)
    (hMaintenance :
      ∀ i ∈ parts, partMaintenance i newState ≤ partMaintenance i oldState) :
    beta * (uptake oldState g - maintenance oldState)
      ≤ beta * (uptake newState g - maintenance newState) :=
  organization_improvement_increases_endogenousResponseBudget
    oldState newState g beta uptake maintenance hBeta
    (by rw [hAgg.1, hAgg.1]; exact Finset.sum_le_sum hUptake)
    (by rw [hAgg.2, hAgg.2]; exact Finset.sum_le_sum hMaintenance)

/-- **Strict creation opens new responses.** If, in addition, one part strictly
gains uptake and reinvestment is positive, there is a response cost that the
whole could not afford before and can afford after. -/
theorem part_creation_opens_response_window
    (parts : Finset ι)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (partUptake : ι → UptakeFunction σ)
    (partMaintenance : ι → MaintenanceDemand σ)
    (hAgg : AggregatesParts parts uptake maintenance partUptake partMaintenance)
    (oldState newState : σ)
    (g beta : ℝ)
    (hBeta : 0 < beta)
    (hUptake : ∀ i ∈ parts, partUptake i oldState g ≤ partUptake i newState g)
    (hStrict : ∃ i ∈ parts, partUptake i oldState g < partUptake i newState g)
    (hMaintenance :
      ∀ i ∈ parts, partMaintenance i newState ≤ partMaintenance i oldState) :
    ∃ responseCost : ℝ,
      beta * (uptake oldState g - maintenance oldState) < responseCost ∧
      responseCost ≤ beta * (uptake newState g - maintenance newState) := by
  apply responseBudget_increase_opens_cost_window
  apply mul_lt_mul_of_pos_left _ hBeta
  have hU : uptake oldState g < uptake newState g := by
    rw [hAgg.1, hAgg.1]
    exact Finset.sum_lt_sum hUptake hStrict
  have hM : maintenance newState ≤ maintenance oldState := by
    rw [hAgg.2, hAgg.2]
    exact Finset.sum_le_sum hMaintenance
  linarith

end NetworkLedger

section Stall

variable {σ α : Type*}

/-- **A non-viable vortex cannot afford any positive-cost response.** -/
theorem nonviable_blocks_positive_cost_responses
    (Cost : ResponseCost α)
    (state : ℕ → σ)
    (gradient : GradientStream)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (beta : ReinvestmentFraction)
    (t : ℕ)
    (z : α)
    (hNot : ¬ InternallyViableAt state gradient uptake maintenance t)
    (hBeta : 0 ≤ beta t)
    (hCost : 0 < Cost t z) :
    ¬ ResourceFeasibleAt Cost
      (EndogenousResponseBudget state gradient uptake maintenance beta) t z := by
  intro hFeasible
  have hSlack : InternalSlackAt state gradient uptake maintenance t < 0 := by
    rw [internallyViableAt_iff_internalSlack_nonneg] at hNot
    exact lt_of_not_ge hNot
  have hBudget :
      EndogenousResponseBudget state gradient uptake maintenance beta t ≤ 0 := by
    unfold EndogenousResponseBudget
    exact mul_nonpos_of_nonneg_of_nonpos hBeta hSlack.le
  unfold ResourceFeasibleAt AccessibleByCost at hFeasible
  linarith

/-- **A stalled vortex has zero ratchet velocity.** If every candidate has
positive response cost and the whole is not viable, no candidate is
resource-feasible. Under the declared seam that the resource-feasibility
fraction of the velocity ledger is then zero, the ledger velocity is zero. -/
theorem nonviable_vortex_zero_velocity
    (Cost : ResponseCost α)
    (state : ℕ → σ)
    (gradient : GradientStream)
    (uptake : UptakeFunction σ)
    (maintenance : MaintenanceDemand σ)
    (beta : ReinvestmentFraction)
    (t : ℕ)
    (hNot : ¬ InternallyViableAt state gradient uptake maintenance t)
    (hBeta : 0 ≤ beta t)
    (hCost : ∀ z, 0 < Cost t z)
    (opportunityRate pGenerate pResource pValidate pRetain meanGain : ℝ)
    (hSeam :
      (∀ z, ¬ ResourceFeasibleAt Cost
        (EndogenousResponseBudget state gradient uptake maintenance beta) t z) →
      pResource = 0) :
    FunctionalOrganization.MechanisticRatchetVelocity
      opportunityRate pGenerate pResource pValidate pRetain meanGain = 0 := by
  have hNone := fun z =>
    nonviable_blocks_positive_cost_responses Cost state gradient uptake
      maintenance beta t z hNot hBeta (hCost z)
  rw [hSeam hNone]
  exact FunctionalOrganization.mechanisticRatchetVelocity_zero_no_resource_feasibility
    opportunityRate pGenerate pValidate pRetain meanGain

end Stall

#print axioms internalSlack_eq_sum_partSlack
#print axioms endogenousResponseBudget_eq_sum_partSlack
#print axioms partSlack_sum_transfer_invariant
#print axioms moveFlow_pureTransfer
#print axioms moveFlow_partSlack
#print axioms networkViable_implies_internallyViable
#print axioms internallyViable_iff_exists_viable_transfer
#print axioms transfer_breaks_part_with_whole_unchanged
#print axioms part_improvement_increases_endogenousResponseBudget
#print axioms part_creation_opens_response_window
#print axioms nonviable_blocks_positive_cost_responses
#print axioms nonviable_vortex_zero_velocity

end RecursiveAccessibility
end CumulativeAccessibility
