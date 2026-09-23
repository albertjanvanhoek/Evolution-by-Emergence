import AnchoredEvolution.RelayProcess
import AnchoredEvolution.Bridge

/-!
# Network economics: maintenance, correction cost, and latency

The executable relay layer gives an exact baseline operational bound: a route
with `h` channels answers a live view in `h + 2` steps and costs `h + 2` units
(one challenge, `h` relay steps, one receiver revision).

This file keeps that **per-correction** cost separate from the **standing
maintenance** cost of keeping links available.  It then connects link count to
the same Cumulative Reproduction ledger already used for retained correction
structure.

The point is deliberately modest but useful: topology induces a real trade-off.
For the four-person witness already in `Network.lean`, the flat architecture
has 12 directed links and one-hop diameter, while the two-pair architecture has
6 directed links and three-hop diameter.  Thus the latter halves standing link
maintenance in the homogeneous baseline, while increasing worst-case relay
latency by two steps.  Hierarchy is therefore not cost-free; it can exchange
maintenance cost for relay distance without losing tracking when interfaces are
faithful.
-/

universe u

namespace Anchored.NetworkEconomics

open CumulativeReproduction
open LearningConstitution Operational Semantic Tracking Network
open UnifiedTracking RelayProcess ModelProcess

variable {World : Type u}

/-- A coarse architecture profile: how many directed links must be maintained,
and the maximum relay-hop distance relevant to correction. -/
structure ArchitectureProfile where
  links : Nat
  maxHops : Nat

/-- Standing upkeep when every maintained directed link costs `mu`. -/
def maintenanceCost (A : ArchitectureProfile) (mu : Nat) : Nat :=
  A.links * mu

/-- Baseline worst-case correction latency: challenge + relay hops + revision. -/
def worstCaseLatency (A : ArchitectureProfile) : Nat :=
  A.maxHops + 2

/-- In the current unit-step relay process, correction-run cost equals latency. -/
def worstCaseCorrectionCost (A : ArchitectureProfile) : Nat :=
  A.maxHops + 2

/-- Everyone-to-everyone among four participants: 4*3 = 12 directed links,
and every nontrivial correction needs at most one relay hop. -/
def flatFour : ArchitectureProfile := ⟨12, 1⟩

/-- Two internally connected pairs with one directed link in each direction
between spokespersons: 6 directed links; the longest route uses three hops. -/
def pairedFour : ArchitectureProfile := ⟨6, 3⟩

/-- The paired architecture uses exactly half as many maintained links. -/
theorem paired_four_half_links : pairedFour.links * 2 = flatFour.links := by
  decide

/-- Consequently homogeneous standing maintenance is exactly halved. -/
theorem paired_four_half_maintenance (mu : Nat) :
    maintenanceCost pairedFour mu * 2 = maintenanceCost flatFour mu := by
  simp [maintenanceCost, pairedFour, flatFour]
  omega

/-- The maintenance saving is bought with two additional worst-case process
steps in the four-person witness. -/
theorem paired_four_latency_tradeoff :
    worstCaseLatency pairedFour = worstCaseLatency flatFour + 2 := by
  decide

/-- Route-level operational theorem packaged as the cost/latency statement:
for an exactly faithful route, a tracking receiver answers a live source view
within `route.length + 2` steps and the same resource bound. -/
theorem faithful_route_profile_answers {C : Content World}
    {M : Model World} {base : Content World}
    (hM : M.Tracking C) {s : M.State} {v : Content World}
    {route : List (Channel World)} (hroute : FaithfulRoute C route)
    (hlive : LiveClaim den C v) :
    AnswerWithin (process M base) den C (record M)
      (start M s v route) PUnit.unit PUnit.unit v
      (route.length + 2) (route.length + 2) :=
  answerWithin_route hM hroute hlive

/-- Link affordability is exactly the CRM ledger affordability predicate when
maintained links are treated as retained organizational items. -/
def LinkAffordable (ell : Ledger) (links : Nat) : Prop :=
  ell.mu * links <= ell.B0 + ell.eta * links

 theorem link_affordable_iff_ledger (ell : Ledger) (links : Nat) :
    LinkAffordable ell links ↔ ell.Affordable links := by
  rfl

/-- Under net-cost retention, an affordable correction architecture cannot
maintain more directed links than the ledger cap. -/
theorem affordable_links_bounded_by_cap (ell : Ledger) (hnet : ell.eta < ell.mu)
    {links : Nat} (h : LinkAffordable ell links) :
    links <= ell.cap := by
  exact le_cap_of_affordable ell hnet ((link_affordable_iff_ledger ell links).1 h)

/-- If correction links finance at least their own upkeep, there is no link-count
ceiling from this ledger. -/
theorem self_financing_links_unbounded (ell : Ledger) (h : ell.mu <= ell.eta) :
    ∀ links, LinkAffordable ell links := by
  intro links
  exact (link_affordable_iff_ledger ell links).2 (self_financing_never_binds ell h links)

/-- A topology whose required link count exceeds the net-cost ledger cap is
unaffordable. -/
theorem links_above_cap_unaffordable (ell : Ledger) (hnet : ell.eta < ell.mu)
    {links : Nat} (hcap : ell.cap < links) :
    ¬ LinkAffordable ell links := by
  intro h
  have := affordable_links_bounded_by_cap ell hnet h
  omega

/-- There is a concrete budget regime in which the six-link paired architecture
fits while the twelve-link flat architecture cannot: any net-cost ledger whose
cap lies in `[6, 11]`. -/
theorem paired_fits_when_flat_does_not (ell : Ledger) (hnet : ell.eta < ell.mu)
    (h6 : 6 <= ell.cap) (h12 : ell.cap < 12) :
    LinkAffordable ell pairedFour.links ∧ ¬ LinkAffordable ell flatFour.links := by
  constructor
  · apply (link_affordable_iff_ledger ell pairedFour.links).2
    apply affordable_of_le_cap ell hnet
    simpa [pairedFour] using h6
  · apply links_above_cap_unaffordable ell hnet
    simpa [flatFour] using h12

end Anchored.NetworkEconomics
