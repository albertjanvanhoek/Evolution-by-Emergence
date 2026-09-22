import CumulativeAccessibility.EmergentCapacity
import CumulativeAccessibility.RetainedOrganizationCore

namespace CumulativeAccessibility
namespace EmergentPaidTransfer

open RecursiveAccessibility
open RetainedOrganizationCore

variable {Config Context Capacity G R Γ X Target : Type*}

/-!
# Emergence feedback into retained organization

Emergence is not the universal centre. This module formalizes two optional
bridges for the same retained item X:

1. **self-support:** the configuration represented by X is compositionally
   emergent and the counterfactual slack gain attributable to retaining X covers
   X's marginal maintenance burden;
2. **paid transfer:** that same emergent retained item satisfies the full
   substrate-agnostic cumulative paid-transfer certificate.

This repairs the unit-of-retention seam: the emergent configuration and the
retained/ablated counterfactual are explicitly linked through one item x.
-/

/-- Application mapping from a retained item to the configuration whose
part/whole emergence is being tested. -/
abbrev ItemConfiguration (X Config : Type*) := X → Config

/-- The same retained item x represents the configuration that realizes the
declared compositional-emergence capacity. -/
def EmergentRetainedItem
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (ConfigOf : ItemConfiguration X Config)
    (x : X)
    (ctx : Context)
    (φ : Capacity) : Prop :=
  EmergentUnder Proper Realizes (ConfigOf x) ctx φ

/-- Application-specific usable slack/resource margin of one full system
state. This is separate from the gross/free budget used in the accessibility
comparison. -/
abbrev SlackMeasure (G R Γ : Type*) :=
  State G R Γ → ℝ

/-- Counterfactual slack contribution of retaining item x, relative to ablating
that same item while holding active organization, context, and gross budget
fixed. -/
def itemSlackGain
    (Retain : RetainItem R X)
    (Lose : LoseItem R X)
    (Slack : SlackMeasure G R Γ)
    (base : State G R Γ)
    (x : X) : ℝ :=
  Slack (retainedArm Retain base x) -
    Slack (ablatedArm Lose base x)

/-- Marginal maintenance burden of retaining the same item x. -/
def itemMarginalBurden
    (Retain : RetainItem R X)
    (Lose : LoseItem R X)
    (M : Maintenance R)
    (base : State G R Γ)
    (x : X) : ℝ :=
  M (Retain base.retained x) -
    M (Lose base.retained x)

/-- Law-D self-support certificate for one concrete retained item.

The emergence premise does not magically imply the ledger inequality. The
application must establish both for the same x. What Lean checks is that this is
one coherent item-level statement rather than two unrelated labels. -/
structure EmergentSelfSupport
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (ConfigOf : ItemConfiguration X Config)
    (Retain : RetainItem R X)
    (Lose : LoseItem R X)
    (Slack : SlackMeasure G R Γ)
    (M : Maintenance R)
    (base : State G R Γ)
    (x : X)
    (ctx : Context)
    (φ : Capacity) : Prop where
  emergent : EmergentRetainedItem Proper Realizes ConfigOf x ctx φ
  paid : StrictlyPaidItem Retain Lose M base x
  coversBurden :
    itemMarginalBurden Retain Lose M base x ≤
      itemSlackGain Retain Lose Slack base x

/-- A self-support certificate proves both the emergence classification and a
nonnegative net slack contribution after paying the same item's marginal
retention burden. -/
theorem emergentSelfSupport_leaves_nonnegative_netSlack
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (ConfigOf : ItemConfiguration X Config)
    (Retain : RetainItem R X)
    (Lose : LoseItem R X)
    (Slack : SlackMeasure G R Γ)
    (M : Maintenance R)
    (base : State G R Γ)
    (x : X)
    (ctx : Context)
    (φ : Capacity)
    (h :
      EmergentSelfSupport
        Proper Realizes ConfigOf
        Retain Lose Slack M base x ctx φ) :
    EmergentRetainedItem Proper Realizes ConfigOf x ctx φ ∧
    0 ≤
      itemSlackGain Retain Lose Slack base x -
      itemMarginalBurden Retain Lose M base x := by
  refine ⟨h.emergent, ?_⟩
  linarith [h.coversBurden]

/-- Emergent paid transfer requires the same item x to satisfy the strict
part/whole emergence predicate and the full cumulative paid-transfer firewall. -/
structure EmergentCumulativePaidTransfer
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (ConfigOf : ItemConfiguration X Config)
    (Endo : Endogenous X)
    (Slow : SlowRetained X)
    (Retain : RetainItem R X)
    (Lose : LoseItem R X)
    (x : X)
    (ctx : Context)
    (φ : Capacity)
    (Visited : Set Target)
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (base : State G R Γ)
    (y : Target) : Prop where
  emergent : EmergentRetainedItem Proper Realizes ConfigOf x ctx φ
  cumulative :
    CumulativePaidTransferEvent
      Endo Slow Retain Lose x
      Visited A M T base y

/-- The emergence-feedback transfer route exposes both the emergence
classification and the item-specific unvisited positive paid-transfer result. -/
theorem emergentPaidTransfer_opens_unvisited_budget_window
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (ConfigOf : ItemConfiguration X Config)
    (Endo : Endogenous X)
    (Slow : SlowRetained X)
    (Retain : RetainItem R X)
    (Lose : LoseItem R X)
    (x : X)
    (ctx : Context)
    (φ : Capacity)
    (Visited : Set Target)
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (base : State G R Γ)
    (y : Target)
    (h :
      EmergentCumulativePaidTransfer
        Proper Realizes ConfigOf
        Endo Slow Retain Lose x ctx φ
        Visited A M T base y) :
    EmergentRetainedItem Proper Realizes ConfigOf x ctx φ ∧
    y ∉ Visited ∧
    stateAccessibility A M T (ablatedArm Lose base x) y <
      stateAccessibility A M T (retainedArm Retain base x) y := by
  refine ⟨h.emergent, ?_⟩
  exact cumulativePaidTransfer_has_unvisited_positive_transfer
    Endo Slow Retain Lose x
    Visited A M T base y h.cumulative

/-- The same route also inherits the stronger same-free-budget interpretation:
the retained structure itself has a strict accessibility advantage at the
retained arm's lower free budget. -/
theorem emergentPaidTransfer_gain_exceeds_upkeep_penalty
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (ConfigOf : ItemConfiguration X Config)
    (Endo : Endogenous X)
    (Slow : SlowRetained X)
    (Retain : RetainItem R X)
    (Lose : LoseItem R X)
    (x : X)
    (ctx : Context)
    (φ : Capacity)
    (Visited : Set Target)
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (base : State G R Γ)
    (y : Target)
    (h :
      EmergentCumulativePaidTransfer
        Proper Realizes ConfigOf
        Endo Slow Retain Lose x ctx φ
        Visited A M T base y) :
    EmergentRetainedItem Proper Realizes ConfigOf x ctx φ ∧
    A T base.active (Lose base.retained x) base.context
        (freeBudget M (retainedArm Retain base x)) y
      <
    A T base.active (Retain base.retained x) base.context
        (freeBudget M (retainedArm Retain base x)) y := by
  refine ⟨h.emergent, ?_⟩
  exact cumulativePaidTransfer_gain_exceeds_upkeep_penalty
    Endo Slow Retain Lose x
    Visited A M T base y h.cumulative

#print axioms emergentSelfSupport_leaves_nonnegative_netSlack
#print axioms emergentPaidTransfer_opens_unvisited_budget_window
#print axioms emergentPaidTransfer_gain_exceeds_upkeep_penalty

end EmergentPaidTransfer
end CumulativeAccessibility
