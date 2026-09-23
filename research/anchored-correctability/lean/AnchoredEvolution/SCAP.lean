import AnchoredEvolution.Persistence
import AnchoredEvolution.UnifiedTracking

/-!
# SCAP: a top-level persistence invariant

This file packages the five conditions that the metamodel keeps separate in
prose into one Lean object.  It is deliberately a **conjunction of explicit
premises**, not a claim that all five follow from the anchor.

For a baseline correction web `E0`, its time-varying realization `Et`, a
candidate-world set `C`, communication channels `ch`, temporal public records
and evidence, and a finite ledger, `SCAP.Invariant` requires:

1. **Connected** — the baseline correction web is strongly connected.
2. **Faithful** — every baseline link preserves claim meaning exactly on the
   candidate worlds (`FaithfulChannel`), rather than merely sharpening a live
   claim.
3. **Open to evidence** — each temporal public record follows the evidence it
   receives; reliable evidence therefore keeps it in step with the changing
   world.
4. **Repairable** — every baseline link reappears within a bounded delay `R`.
5. **Affordable** — the maintained correction structure fits the stated CRM
   ledger.

The stochastic forgiveness threshold `k*r/(p+r) > 1` is intentionally **not**
a field of this invariant: it is a model-specific sufficient criterion studied
by simulation.  The theorem-level repair condition is `Persistence.RepairWithin`.

The main theorem, `scap_persistent_correctability`, combines three levels that
were previously separate:

* an implemented baseline web is a Layer-1b correctable process;
* exact semantic routes exist between every pair and bounded repair makes the
  same baseline route temporally reachable within `m*(R+1)` steps;
* the maintained structure is affordable under the supplied ledger.

This does not yet turn the temporal waiting steps into one global timestamped
`Operational.Process.Run`; concurrency and attention/capacity remain open.
-/

universe u

namespace Anchored.SCAP

open LearningConstitution
open Operational
open Semantic
open Network
open Realization
open Persistence
open UnifiedTracking
open CumulativeReproduction

variable {World ι : Type u}

/-- The five-part SCAP condition at theorem level.

`maintainedItems` is the number of retained correction-structure items charged
to the ledger.  A concrete topology may specialize this to directed link count
or another explicitly justified maintenance count. -/
structure Invariant
    (E0 : ι → ι → Prop)
    (Et : Nat → ι → ι → Prop)
    (C : Content World)
    (ch : ι → ι → Channel World)
    (record evidence : ι → Nat → Content World)
    (ℓ : Ledger) (maintainedItems R : Nat) : Prop where
  connected : StronglyConnected E0
  faithful : ∀ i j, E0 i j → FaithfulChannel C (ch i j)
  evidence_open : ∀ i, FollowsEvidence (record i) (evidence i)
  repairable : RepairWithin Et E0 R
  affordable : ℓ.Affordable maintainedItems

/-! ## Exact semantic transport through a baseline route -/

/-- The identity channel is exactly faithful. -/
theorem faithful_id (C : Content World) :
    FaithfulChannel C (fun v => v) := by
  constructor <;> intro v w hw hv <;> exact hv

/-- Exact semantic faithfulness is closed under channel composition. -/
theorem faithful_comp {C : Content World} {f g : Channel World}
    (hf : FaithfulChannel C f) (hg : FaithfulChannel C g) :
    FaithfulChannel C (g ∘ f) := by
  constructor
  · intro v w hw hgf
    exact hf.1 v w hw (hg.1 (f v) w hw hgf)
  · intro v w hw hv
    exact hg.2 (f v) w hw (hf.2 v w hw hv)

/-- A counted network relay made entirely from faithful edges is faithful from
end to end. -/
theorem relayN_faithful {E0 : ι → ι → Prop} {C : Content World}
    {ch : ι → ι → Channel World}
    (hE : ∀ i j, E0 i j → FaithfulChannel C (ch i j)) :
    ∀ {i k : ι} {f : Channel World} {m : Nat},
      RelayN E0 ch i k f m → FaithfulChannel C f := by
  intro i k f m h
  induction h with
  | here i => exact faithful_id C
  | @hop i j k f m e r ih =>
      exact faithful_comp (hE i j e) ih

/-- SCAP connectivity plus exact interfaces gives a counted, exactly faithful
semantic route between any pair. -/
theorem faithful_route_exists
    {E0 : ι → ι → Prop} {Et : Nat → ι → ι → Prop}
    {C : Content World} {ch : ι → ι → Channel World}
    {record evidence : ι → Nat → Content World}
    {ℓ : Ledger} {maintainedItems R : Nat}
    (h : Invariant E0 Et C ch record evidence ℓ maintainedItems R)
    (a b : ι) :
    ∃ m f, ReachIn E0 a b m ∧ RelayN E0 ch a b f m ∧ FaithfulChannel C f := by
  obtain ⟨m, hm⟩ := reach_counted (h.connected a b)
  obtain ⟨f, hf⟩ := reachIn_relayN (ch := ch) hm
  exact ⟨m, f, hm, hf, relayN_faithful h.faithful hf⟩

/-! ## Openness to reliable evidence -/

/-- Under the SCAP openness condition, reliable evidence keeps every member's
record in step with the same changing world trajectory. -/
theorem members_in_step
    {E0 : ι → ι → Prop} {Et : Nat → ι → ι → Prop}
    {C : Content World} {ch : ι → ι → Channel World}
    {record evidence : ι → Nat → Content World}
    {ℓ : Ledger} {maintainedItems R : Nat}
    (h : Invariant E0 Et C ch record evidence ℓ maintainedItems R)
    (τ : Trajectory World) (hrel : ∀ i, ReliableAlong (evidence i) τ) :
    ∀ i t, InStep (record i) τ t := by
  intro i
  exact learner_in_step (h.evidence_open i) (hrel i)

/-! ## Persistence under bounded repair -/

/-- A SCAP web has an exactly faithful baseline route whose links remain
reachable through time under bounded repair.  For a route of `m` baseline
links, temporal access is restored within `m*(R+1)` steps from any start time. -/
theorem persistent_faithful_access
    {E0 : ι → ι → Prop} {Et : Nat → ι → ι → Prop}
    {C : Content World} {ch : ι → ι → Channel World}
    {record evidence : ι → Nat → Content World}
    {ℓ : Ledger} {maintainedItems R : Nat}
    (h : Invariant E0 Et C ch record evidence ℓ maintainedItems R)
    (a b : ι) (t : Nat) :
    ∃ m f, ReachIn E0 a b m ∧ RelayN E0 ch a b f m ∧ FaithfulChannel C f ∧
      TReach Et a b t (t + m * (R + 1)) := by
  obtain ⟨m, f, hm, hf, hfaith⟩ := faithful_route_exists h a b
  exact ⟨m, f, hm, hf, hfaith, repair_bounds_delay h.repairable hm t⟩

/-! ## Connection to the executable Layer-1b process -/

section Executable

variable {ι S World Evidence Decision : Type u}

/-- If the baseline SCAP web is implemented by one addressed-content process,
its process-level correction graph is correctable at every state, subject to
the explicit governance premise already required by `Realization`. -/
theorem implemented_scap_correctable
    {E0 : ι → ι → Prop} {Et : Nat → ι → ι → Prop}
    {C : Content World} {ch : ι → ι → Channel World}
    {record evidence : ι → Nat → Content World}
    {ℓ : Ledger} {maintainedItems R : Nat}
    (h : Invariant E0 Et C ch record evidence ℓ maintainedItems R)
    {P : Process ι S (ι × Content World) Evidence Decision}
    {M : ι → Model World} {α : S → (i : ι) → (M i).State} {T K : Nat}
    (hI : Implements P M E0 ch α T K)
    (hgov : ∀ s j, ∃ u, P.Governs s (j, u) j) (s : S) :
    (P.correctionSystem s).Correctable :=
  implemented_correctable hI h.connected hgov s

/-- **Top-level SCAP persistence theorem.**  Under one explicit SCAP invariant
and an implementation contract:

* the Layer-1b process is structurally correctable now;
* between any two members there is an exactly faithful counted baseline relay;
* bounded repair restores temporal access along that route within
  `m*(R+1)` steps from any start time;
* the maintained correction structure is affordable under the stated ledger.

The theorem deliberately keeps temporal graph access and executable process
runs as separate conjuncts; a globally clocked concurrent process is a later
refinement, not hidden in this statement. -/
theorem scap_persistent_correctability
    {E0 : ι → ι → Prop} {Et : Nat → ι → ι → Prop}
    {C : Content World} {ch : ι → ι → Channel World}
    {record evidence : ι → Nat → Content World}
    {ℓ : Ledger} {maintainedItems R : Nat}
    (h : Invariant E0 Et C ch record evidence ℓ maintainedItems R)
    {P : Process ι S (ι × Content World) Evidence Decision}
    {M : ι → Model World} {α : S → (i : ι) → (M i).State} {T K : Nat}
    (hI : Implements P M E0 ch α T K)
    (hgov : ∀ s j, ∃ u, P.Governs s (j, u) j)
    (s : S) (a b : ι) (t : Nat) :
    (P.correctionSystem s).Correctable ∧
      ∃ m f, ReachIn E0 a b m ∧ RelayN E0 ch a b f m ∧ FaithfulChannel C f ∧
        TReach Et a b t (t + m * (R + 1)) ∧ ℓ.Affordable maintainedItems := by
  refine ⟨implemented_scap_correctable h hI hgov s, ?_⟩
  obtain ⟨m, f, hm, hf, hfaith, htime⟩ := persistent_faithful_access h a b t
  exact ⟨m, f, hm, hf, hfaith, htime, h.affordable⟩

end Executable

end Anchored.SCAP
