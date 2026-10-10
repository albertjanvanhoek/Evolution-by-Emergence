namespace CumulativeAccessibility
namespace CrossScaleLedger

/-!
# Cross-scale ledger: when coupling between scales creates, and when it only moves

`NetworkVortexLedger.lean` splits the vortex ledger over parts.  The whole's
slack is the sum of the parts' slack, and pure transfers cancel: they decide
which part survives, not how much the whole has.  That ledger assumes the
whole can be decomposed into separable parts.

Milinkovic and Aru (2026, Neuroscience and Biobehavioral Reviews 181:106524)
argue that in brains the scales are coupled in both directions: lower scales
generate higher ones, and higher scales constrain lower ones.  A field produced
by neurons changes the excitability, and so the cost, of the neurons that
produce it.  Such a coupling is neither an outside resource nor a zero-sum
transfer.  A review of the paper against this repository (entry D21 of
`DIALOGUE.md`) proposed adding an interaction term to the ledger and checking
that the additive results return when the interaction is zero.

This module is that step in its smallest form: two scales, a coupling effect in
each direction, and a separate upkeep for the coupling itself, so that coupling
cannot be a free lunch.

  slackLo = ownLo + hiToLo        (own slack, plus what upper-scale
  slackHi = ownHi + loToHi         organization does to this scale)
  whole   = slackLo + slackHi - couplingUpkeep

Results:
* `whole_eq_separable_add_net`: the whole's slack is the separable slack plus
  the net coupling effect minus the coupling's upkeep.
* `separable_recovers_additive_ledger`: with no coupling, the ledger is the
  additive one.
* `free_redistribution_recovers_transfer_cancel`: coupling whose effects cancel
  and that costs nothing to keep changes nothing for the whole: transfers
  cancel, as in `NetworkVortexLedger`.
* `redistribution_never_pays`: coupling whose effects cancel never raises the
  whole, and loses its upkeep.
* `coupling_creates_iff`: coupling raises the whole above the separable ledger
  exactly when its net effect exceeds its own upkeep.
* `coupling_not_free`: if the net effect does not exceed the upkeep, the whole
  is no better off than without the coupling.
* `separable_accounting_exact_iff`: scale-by-scale bookkeeping gives the
  whole's slack exactly when net effect and upkeep balance; otherwise it is
  wrong.
* `cut_breaks_iff`: without its coupling the whole is not viable exactly when
  its separable slack is negative.  So a viable whole breaks when cut exactly
  when it was living on the coupling.
* `viable_only_coupled`: a whole and both its scales can be viable while
  neither the uncoupled whole nor its lower scale is.
* `nested_upper_sees_external`, `nested_upper_falls_with_lower`: what one scale
  draws on as an outside gradient can be organization maintained at another
  scale.  While that scale holds, it looks external; when it fails, the scale
  that draws on it fails too.
* `cross_scale_ledger_witness`: concrete numbers.

Scope.  Two scales, integer quantities, one time.  The coupling effects are
inputs: the file does not say that any real coupling creates, or how much.
Whether neural fields, astrocytes or oscillations have a positive net effect
after their own upkeep is an empirical question.  The file says nothing about
consciousness: a configuration can persist without being conscious (D17).  The
version with many scales and with parts inside each scale is open.  These
results are close to their definitions; they fix the shape of the accounting.
-/

/-- Two coupled scales.  `ownLo` and `ownHi` are each scale's own uptake minus
its own maintenance.  `hiToLo` is the effect of upper-scale organization on the
lower scale's effective slack (for example a field that lowers the cost of the
activity that produces it); `loToHi` the reverse.  `couplingUpkeep` is what it
costs to keep the coupling going. -/
structure TwoScale where
  ownLo : Int
  ownHi : Int
  hiToLo : Int
  loToHi : Int
  couplingUpkeep : Int

/-- Effective slack of the lower scale. -/
def slackLo (x : TwoScale) : Int := x.ownLo + x.hiToLo

/-- Effective slack of the upper scale. -/
def slackHi (x : TwoScale) : Int := x.ownHi + x.loToHi

/-- Net effect of the coupling, summed over both directions. -/
def netCoupling (x : TwoScale) : Int := x.hiToLo + x.loToHi

/-- The whole's slack: both scales' effective slack, minus the coupling's upkeep. -/
def wholeSlack (x : TwoScale) : Int := slackLo x + slackHi x - x.couplingUpkeep

/-- What scale-by-scale bookkeeping sees: own slacks only. -/
def separableSlack (x : TwoScale) : Int := x.ownLo + x.ownHi

/-- No coupling at all. -/
def Separable (x : TwoScale) : Prop :=
  x.hiToLo = 0 ∧ x.loToHi = 0 ∧ x.couplingUpkeep = 0

/-- The coupling only moves slack between scales: its effects cancel. -/
def Redistributes (x : TwoScale) : Prop := netCoupling x = 0

/-- Remove the coupling and its upkeep. -/
def cut (x : TwoScale) : TwoScale :=
  { x with hiToLo := 0, loToHi := 0, couplingUpkeep := 0 }

/-- Each scale covers its own costs, coupling included. -/
def ScalesViable (x : TwoScale) : Prop := 0 ≤ slackLo x ∧ 0 ≤ slackHi x

/-- The whole covers its costs. -/
def WholeViable (x : TwoScale) : Prop := 0 ≤ wholeSlack x

/-- The accounting identity: separable slack, plus net coupling, minus its upkeep. -/
theorem whole_eq_separable_add_net (x : TwoScale) :
    wholeSlack x = separableSlack x + netCoupling x - x.couplingUpkeep := by
  unfold wholeSlack slackLo slackHi separableSlack netCoupling
  omega

/-- With no coupling the ledger is additive: the whole is the sum of the scales,
and equals what scale-by-scale bookkeeping sees. -/
theorem separable_recovers_additive_ledger (x : TwoScale) (h : Separable x) :
    wholeSlack x = slackLo x + slackHi x ∧ wholeSlack x = separableSlack x := by
  unfold Separable at h
  unfold wholeSlack slackLo slackHi separableSlack
  omega

/-- Coupling whose effects cancel and that costs nothing changes nothing for the
whole: the transfer-cancellation result of `NetworkVortexLedger`. -/
theorem free_redistribution_recovers_transfer_cancel (x : TwoScale)
    (hr : Redistributes x) (hk : x.couplingUpkeep = 0) :
    wholeSlack x = separableSlack x := by
  unfold Redistributes netCoupling at hr
  unfold wholeSlack slackLo slackHi separableSlack
  omega

/-- Coupling whose effects cancel never raises the whole, and loses its upkeep. -/
theorem redistribution_never_pays (x : TwoScale)
    (hr : Redistributes x) (hk : 0 ≤ x.couplingUpkeep) :
    wholeSlack x = separableSlack x - x.couplingUpkeep ∧
      wholeSlack x ≤ separableSlack x := by
  unfold Redistributes netCoupling at hr
  unfold wholeSlack slackLo slackHi separableSlack
  omega

/-- **Coupling as creation.** The whole has more than the separable ledger exactly
when the coupling's net effect exceeds its own upkeep. -/
theorem coupling_creates_iff (x : TwoScale) :
    separableSlack x < wholeSlack x ↔ x.couplingUpkeep < netCoupling x := by
  unfold wholeSlack slackLo slackHi separableSlack netCoupling
  omega

/-- **No free lunch.** If the net effect does not exceed the upkeep, the whole is
no better off than without the coupling. -/
theorem coupling_not_free (x : TwoScale) (h : netCoupling x ≤ x.couplingUpkeep) :
    wholeSlack x ≤ separableSlack x := by
  unfold netCoupling at h
  unfold wholeSlack slackLo slackHi separableSlack
  omega

/-- Scale-by-scale bookkeeping is right about the whole exactly when net effect
and upkeep balance. -/
theorem separable_accounting_exact_iff (x : TwoScale) :
    wholeSlack x = separableSlack x ↔ netCoupling x = x.couplingUpkeep := by
  unfold wholeSlack slackLo slackHi separableSlack netCoupling
  omega

/-- Cutting the coupling leaves the separable ledger. -/
theorem cut_eq_separable (x : TwoScale) :
    wholeSlack (cut x) = separableSlack x := by
  unfold wholeSlack slackLo slackHi separableSlack cut
  simp

/-- **Cutting the coupling.** Without its coupling the whole is not viable exactly
when its separable slack is negative.  Applied to a viable whole: it breaks
when cut exactly when it was living on the coupling. -/
theorem cut_breaks_iff (x : TwoScale) :
    ¬ WholeViable (cut x) ↔ separableSlack x < 0 := by
  unfold WholeViable
  rw [cut_eq_separable]
  omega

/-- A whole and both its scales can be viable while neither the uncoupled whole
nor its lower scale on its own is. -/
theorem viable_only_coupled :
    ∃ x : TwoScale,
      WholeViable x ∧ ScalesViable x ∧ ¬ WholeViable (cut x) ∧ x.ownLo < 0 := by
  refine ⟨⟨-2, 1, 3, 1, 1⟩, ?_, ?_, ?_, ?_⟩ <;>
    simp [WholeViable, ScalesViable, wholeSlack, slackLo, slackHi, cut]

/-- What a scale draws on as its gradient, when that gradient is organization
maintained at another scale: available while the supplying scale covers its
costs, gone when it does not. -/
def nestedUptake (supplierSlack u : Int) : Int :=
  if 0 ≤ supplierSlack then u else 0

/-- While the supplying scale holds, the gradient looks external: the drawing
scale's slack does not depend on the supplier's details. -/
theorem nested_upper_sees_external (supplierSlack u m : Int)
    (h : 0 ≤ supplierSlack) :
    nestedUptake supplierSlack u - m = u - m := by
  simp [nestedUptake, h]

/-- When the supplying scale fails, a scale with positive maintenance that draws
on it fails too. -/
theorem nested_upper_falls_with_lower (supplierSlack u m : Int)
    (hm : 0 < m) (h : supplierSlack < 0) :
    nestedUptake supplierSlack u - m < 0 := by
  have h' : ¬ (0 ≤ supplierSlack) := by omega
  simp [nestedUptake, h']
  omega

/-- Concrete numbers.  Lower scale -2 on its own, upper scale 1, coupling effects
3 and 1, upkeep 1.  Separable: -1, not viable.  Coupled: lower 1, upper 2,
whole 2, all viable; the coupling creates 3 net of upkeep.  A coupling with
effects 2 and -2 and upkeep 1 only moves slack and costs 1. -/
theorem cross_scale_ledger_witness :
    separableSlack ⟨-2, 1, 3, 1, 1⟩ = -1 ∧
    wholeSlack ⟨-2, 1, 3, 1, 1⟩ = 2 ∧
    slackLo ⟨-2, 1, 3, 1, 1⟩ = 1 ∧
    slackHi ⟨-2, 1, 3, 1, 1⟩ = 2 ∧
    wholeSlack (cut ⟨-2, 1, 3, 1, 1⟩) = -1 ∧
    wholeSlack ⟨0, 0, 2, -2, 1⟩ = -1 ∧
    nestedUptake (-1) 5 - 2 = -2 := by
  decide

end CrossScaleLedger
end CumulativeAccessibility
