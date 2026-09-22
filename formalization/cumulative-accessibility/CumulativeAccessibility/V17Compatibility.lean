import CumulativeAccessibility.RetainedOrganizationCore
import CumulativeAccessibility.EmergentCapacity
import CumulativeAccessibility.EndogenousEnvelopePromotion
import CumulativeAccessibility.ActiveHistory

namespace CumulativeAccessibility
namespace V17Compatibility

open RetainedOrganizationCore
open RecursiveAccessibility

/-!
# v17 compatibility with the retained-organization core

v17 is treated here as a library of generic formal results, not as the semantic
centre of the new theory.

Reusable pieces include:

* compositional emergence relative to a declared decomposition;
* explicit finite-parent generation;
* constructive configuration-level generation;
* essential-parent ablation under a fixed generator;
* active-versus-history separation;
* finite-capacity saturation boundaries.

The old recurrence and uniform-successor premises are NOT imported as primitive
assumptions of RetainedOrganizationCore. They remain optional sufficient
conditions for older open-endedness corollaries.

Most importantly, a v17 generated-access expansion is still only a binary
generability result. To count as the new cumulative criterion it requires an
additional application bridge to graded, paid transfer.
-/

variable {Config Context Capacity G R Γ Target : Type*}
variable [DecidableEq Capacity]

/-- The v17 compositional-emergence predicate is retained unchanged as the
strict part/whole emergence specialization. -/
theorem v17_emergence_is_strict_compositional_emergence
    (Proper : Config → Config → Prop)
    (Realizes : CapacityRelation Config Context Capacity)
    (config : Config)
    (ctx : Context)
    (φ : Capacity)
    (h : EmergentUnder Proper Realizes config ctx φ) :
    Realizes config ctx φ ∧
      ∀ subconfig, Proper subconfig config →
        ¬ Realizes subconfig ctx φ :=
  h

/-- A v17 generatively consequential promotion contains the stronger local
ablation fact: the promoted child is essential under the fixed next-step
generator. This is usable as one possible witness for the new 'reused later'
firewall clause. -/
theorem v17_consequentialPromotion_supplies_essentialReuse
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    (child next : Capacity)
    (h :
      GenerativelyConsequentialPromotionAt S H m child next) :
    GeneratedEssentiallyUsingParent
      (fun x => x ∈ S (m + 1))
      (H (m + 1))
      child next :=
  h.1

/-- The same v17 premise gives strict *binary generated-access* expansion. This
is useful but deliberately weaker than graded paid transfer. -/
theorem v17_consequentialPromotion_supplies_binary_generatedExpansion
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (m : ℕ)
    {child next : Capacity}
    (h :
      GenerativelyConsequentialPromotionAt S H m child next) :
    StrictExpandsOn Set.univ
      (GeneratedFromAvailable
        (fun x => x ∈ S (m + 1) ∧ x ≠ child)
        (H (m + 1)))
      (GeneratedFromAvailable
        (fun x => x ∈ S (m + 1))
        (H (m + 1))) :=
  generativelyConsequentialPromotion_strictly_expands_generated_access
    S H m h

/-- Historical trace at one time becomes an ordinary visited-target set in the
new language. -/
def VisitedFromHistory
    (History : ℕ → Finset Capacity)
    (t : ℕ) : Set Capacity :=
  {x | x ∈ History t}

theorem history_new_is_unvisited
    (History : ℕ → Finset Capacity)
    (t : ℕ)
    (x : Capacity)
    (hNew : x ∉ History t) :
    x ∉ VisitedFromHistory History t := by
  simpa [VisitedFromHistory] using hNew

/-!
## Explicit bridge seam

The next interface is intentionally NOT derivable from v17's binary
generability theorem alone.

An application must justify that the particular essential-parent contrast also
changes a declared graded accessibility measure after both retained states pay
their own maintenance costs.
-/

/-- Application-specific bridge from a v17 essential-use event to the new
graded paid-transfer criterion. -/
abbrev EssentialReuseToPaidTransferBridge
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (sMinus sPlus : State G R Γ)
    (encode : Capacity → Target) :=
  ∀ m child next,
    GenerativelyConsequentialPromotionAt S H m child next →
    PositiveTransferAt A M T sMinus sPlus (encode next)

/-- v17 essential reuse becomes a new-core paid-transfer result only after the
explicit graded bridge is supplied. -/
theorem v17_essentialReuse_plus_bridge_implies_paidTransfer
    (S : ℕ → Finset Capacity)
    (H : ℕ → HyperGenerator Capacity)
    (A : Accessibility G R Γ Target)
    (M : Maintenance R)
    (T : ℕ)
    (sMinus sPlus : State G R Γ)
    (encode : Capacity → Target)
    (bridge :
      EssentialReuseToPaidTransferBridge
        S H A M T sMinus sPlus encode)
    (m : ℕ)
    (child next : Capacity)
    (h :
      GenerativelyConsequentialPromotionAt S H m child next) :
    PositiveTransferAt
      A M T sMinus sPlus (encode next) :=
  bridge m child next h

#print axioms v17_emergence_is_strict_compositional_emergence
#print axioms v17_consequentialPromotion_supplies_essentialReuse
#print axioms v17_consequentialPromotion_supplies_binary_generatedExpansion
#print axioms history_new_is_unvisited
#print axioms v17_essentialReuse_plus_bridge_implies_paidTransfer

end V17Compatibility
end CumulativeAccessibility
