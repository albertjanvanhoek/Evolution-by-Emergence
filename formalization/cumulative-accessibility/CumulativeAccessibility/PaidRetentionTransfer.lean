import CumulativeAccessibility.QuantitativeAccessibility

namespace CumulativeAccessibility
namespace PaidRetention

open RecursiveAccessibility

variable {α ρ : Type*}

/-!
# Paid retention and counterfactual transfer

This module formalizes the v19 paid-transfer ledger inside the same Lean package
as quantitative accessibility.

The key accounting rule is single-entry:

* `M R` is the burden of keeping retained organization `R`;
* `RunCost` is the subsequent use/construction cost and excludes that upkeep;
* total paid cost is their sum.

A positive paid transfer is therefore not merely a change in state. It is a
strict decrease in total cost after retention burden is included.
-/

/-- Declared burden of keeping/reconstructing a retained repertoire. -/
abbrev RetentionBurden (ρ : Type*) := ρ → ℝ

/-- Marginal burden of moving from baseline retained repertoire `Rminus` to
`Rplus`. -/
def MarginalRetentionBurden
    (M : RetentionBurden ρ)
    (Rminus Rplus : ρ) : ℝ :=
  M Rplus - M Rminus

/-- Accessibility cost after charging retention exactly once. -/
def PaidAccessibilityCost
    (M : RetentionBurden ρ)
    (R : ρ)
    (RunCost : AccessibilityCost α) :
    AccessibilityCost α :=
  fun x y => M R + RunCost x y

/-- Positive paid transfer at one target. -/
def PositivePaidTransferAt
    (M : RetentionBurden ρ)
    (Rminus Rplus : ρ)
    (minusRunCost plusRunCost : AccessibilityCost α)
    (sminus splus y : α) : Prop :=
  PaidAccessibilityCost M Rplus plusRunCost splus y <
    PaidAccessibilityCost M Rminus minusRunCost sminus y

/-- Positive paid transfer to a target not previously visited. -/
def PositivePaidTransferToUnvisited
    (Visited : Set α)
    (M : RetentionBurden ρ)
    (Rminus Rplus : ρ)
    (minusRunCost plusRunCost : AccessibilityCost α)
    (sminus splus y : α) : Prop :=
  y ∉ Visited ∧
    PositivePaidTransferAt
      M Rminus Rplus minusRunCost plusRunCost
      sminus splus y

/-- The marginal-burden ledger is exactly equivalent to comparing total paid
costs. This is the single-entry accounting identity used in v19. -/
theorem marginal_run_condition_iff_positivePaidTransfer
    (M : RetentionBurden ρ)
    (Rminus Rplus : ρ)
    (minusRunCost plusRunCost : AccessibilityCost α)
    (sminus splus y : α) :
    MarginalRetentionBurden M Rminus Rplus +
        plusRunCost splus y <
      minusRunCost sminus y
      ↔
    PositivePaidTransferAt
      M Rminus Rplus minusRunCost plusRunCost
      sminus splus y := by
  unfold MarginalRetentionBurden PositivePaidTransferAt PaidAccessibilityCost
  constructor <;> intro h <;> linarith

/-- A positive paid transfer creates a common gross-budget threshold at which
the retained arm can reach the target and the ablated arm cannot. -/
theorem positivePaidTransfer_opens_sameGrossBudget_window
    (M : RetentionBurden ρ)
    (Rminus Rplus : ρ)
    (minusRunCost plusRunCost : AccessibilityCost α)
    (sminus splus y : α)
    (h :
      PositivePaidTransferAt
        M Rminus Rplus minusRunCost plusRunCost
        sminus splus y) :
    ∃ B,
      ¬ AccessibleWithin
          (PaidAccessibilityCost M Rminus minusRunCost)
          B sminus y ∧
      AccessibleWithin
          (PaidAccessibilityCost M Rplus plusRunCost)
          B splus y := by
  refine ⟨PaidAccessibilityCost M Rplus plusRunCost splus y, ?_, le_rfl⟩
  exact not_le.mpr h

/-- The unvisited-target condition is preserved by the budget-window theorem. -/
theorem positivePaidTransferToUnvisited_opens_window
    (Visited : Set α)
    (M : RetentionBurden ρ)
    (Rminus Rplus : ρ)
    (minusRunCost plusRunCost : AccessibilityCost α)
    (sminus splus y : α)
    (h :
      PositivePaidTransferToUnvisited
        Visited M Rminus Rplus minusRunCost plusRunCost
        sminus splus y) :
    y ∉ Visited ∧
      ∃ B,
        ¬ AccessibleWithin
            (PaidAccessibilityCost M Rminus minusRunCost)
            B sminus y ∧
        AccessibleWithin
            (PaidAccessibilityCost M Rplus plusRunCost)
            B splus y := by
  refine ⟨h.1, ?_⟩
  exact positivePaidTransfer_opens_sameGrossBudget_window
    M Rminus Rplus minusRunCost plusRunCost
    sminus splus y h.2

/-- A paid transfer is a directional quantitative accessibility opening on the
singleton target set. -/
theorem positivePaidTransfer_hasCheaperFuture
    (M : RetentionBurden ρ)
    (Rminus Rplus : ρ)
    (minusRunCost plusRunCost : AccessibilityCost α)
    (sminus splus y : α)
    (h :
      PositivePaidTransferAt
        M Rminus Rplus minusRunCost plusRunCost
        sminus splus y) :
    HasCheaperFutureOn
      ({y} : Set α)
      (PaidAccessibilityCost M Rminus minusRunCost)
      (PaidAccessibilityCost M Rplus plusRunCost)
      sminus splus := by
  exact ⟨y, by simp, h⟩

#print axioms marginal_run_condition_iff_positivePaidTransfer
#print axioms positivePaidTransfer_opens_sameGrossBudget_window
#print axioms positivePaidTransferToUnvisited_opens_window

end PaidRetention
end CumulativeAccessibility
