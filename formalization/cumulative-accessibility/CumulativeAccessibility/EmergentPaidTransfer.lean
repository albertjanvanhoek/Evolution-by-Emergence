import CumulativeAccessibility.EmergentCapacity
import CumulativeAccessibility.PaidRetentionTransfer

namespace CumulativeAccessibility
namespace EmergentPaidTransfer

open RecursiveAccessibility
open PaidRetention

variable {Config Context Capacity α ρ : Type*}

/-!
# Emergence-to-retention feedback

The v19 theory deliberately does not require every retained update to be
compositionally emergent. This module instead formalizes two explicit candidate
Law-D bridges without smuggling causation into the definition of emergence.

Route 1: an emergent capability contributes enough declared slack to cover its
marginal retention burden.

Route 2: an emergent organization is retained and shows positive paid transfer
to an unvisited later target.
-/

/-- Law-D self-support route: compositional emergence plus a declared
capability-contributed slack increment large enough to cover marginal retention
burden. -/
def EmergentSelfSupport
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (config : Config)
    (ctx : Context)
    (φ : Capacity)
    (deltaSlack marginalBurden : ℝ) : Prop :=
  EmergentUnder Proper Realizes config ctx φ ∧
    marginalBurden ≤ deltaSlack

/-- If an emergent capability covers its marginal burden, post-retention
incremental slack is nonnegative. -/
theorem emergentSelfSupport_leaves_nonnegative_netSlack
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (config : Config)
    (ctx : Context)
    (φ : Capacity)
    (deltaSlack marginalBurden : ℝ)
    (h :
      EmergentSelfSupport
        Proper Realizes config ctx φ
        deltaSlack marginalBurden) :
    0 ≤ deltaSlack - marginalBurden := by
  linarith [h.2]

/-- Law-D essential-transfer route: an emergent capacity is paired with a paid
transfer to a later target that is absent from the declared history. The
definition does not claim that emergence itself caused the transfer. -/
def EmergentPaidTransferToUnvisited
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (config : Config)
    (ctx : Context)
    (φ : Capacity)
    (Visited : Set α)
    (M : RetentionBurden ρ)
    (Rminus Rplus : ρ)
    (minusRunCost plusRunCost : AccessibilityCost α)
    (sminus splus y : α) : Prop :=
  EmergentUnder Proper Realizes config ctx φ ∧
    PositivePaidTransferToUnvisited
      Visited M Rminus Rplus
      minusRunCost plusRunCost
      sminus splus y

/-- The Law-D transfer route exposes the same common gross-budget witness as the
underlying paid-transfer theorem. -/
theorem emergentPaidTransfer_opens_unvisited_budget_window
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (config : Config)
    (ctx : Context)
    (φ : Capacity)
    (Visited : Set α)
    (M : RetentionBurden ρ)
    (Rminus Rplus : ρ)
    (minusRunCost plusRunCost : AccessibilityCost α)
    (sminus splus y : α)
    (h :
      EmergentPaidTransferToUnvisited
        Proper Realizes config ctx φ
        Visited M Rminus Rplus
        minusRunCost plusRunCost
        sminus splus y) :
    EmergentUnder Proper Realizes config ctx φ ∧
      y ∉ Visited ∧
      ∃ B,
        ¬ AccessibleWithin
          (PaidAccessibilityCost M Rminus minusRunCost)
          B sminus y ∧
        AccessibleWithin
          (PaidAccessibilityCost M Rplus plusRunCost)
          B splus y := by
  refine ⟨h.1, h.2.1, ?_⟩
  exact positivePaidTransfer_opens_sameGrossBudget_window
    M Rminus Rplus minusRunCost plusRunCost
    sminus splus y h.2.2

#print axioms emergentSelfSupport_leaves_nonnegative_netSlack
#print axioms emergentPaidTransfer_opens_unvisited_budget_window

end EmergentPaidTransfer
end CumulativeAccessibility
