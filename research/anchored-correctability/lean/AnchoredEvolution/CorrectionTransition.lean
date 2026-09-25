import AnchoredEvolution.SharedLayerDynamics

/-!
# Correction-preserving transitions

One abstraction for changes to a correction architecture: rewiring routes,
shrinking candidate worlds or commitments, changing representations, replacing
members, handing distinctions between nodes, and integrating a shared layer.

A transition goes from `s : State W O R M` to `s' : State W O' R' M'` over the
same world type. The inside-view type, route/member type and message type may all
change.

The central object is a **blind live cut**: a retained commitment `a`, two open
worlds on opposite sides of that commitment, and an information state that
cannot distinguish them. `CorrectionPreserving s s'` means every blind live cut
after the transition was already a blind live cut before it. Equivalently, the
set of unresolved blind cuts does not expand.

This makes the role of safety transparent: an anchor-safe state is exactly one
with no blind live cuts. From a safe state, correction preservation is therefore
exactly equivalent to target safety. From an unsafe state the relation remains
informative: existing blind cuts may persist or disappear, but no new blind live
cut may be introduced.

This is the intelligent/correctability specialization of an accessibility
invariant, not a universal EbE law.
-/

namespace Anchored.CorrectionTransition

open Anchored.AnchorSafety Anchored.SelfModel Anchored.SharedLayerDynamics

universe u₁ u₂ u₃ u₄ u₅ u₆ u₇ u₈ u₉ u₁₀

section Core

variable {W : Type u₁}
  {O : Type u₂} {R : Type u₃} {M : Type u₄}
  {O' : Type u₅} {R' : Type u₆} {M' : Type u₇}

/-- A retained, open, truth-opposed pair that the state cannot distinguish. -/
def BlindLiveCut (s : State W O R M) (a : W → Prop) (v w : W) : Prop :=
  s.K a ∧ s.C v ∧ s.C w ∧ a v ∧ ¬ a w ∧ Indist s v w

/-- Anchor-safety is exactly absence of blind live cuts. -/
theorem unsealed_iff_no_blind_live_cut (s : State W O R M) :
    Unsealed s ↔ ¬ ∃ a v w, BlindLiveCut s a v w := by
  constructor
  · intro h ⟨a, v, w, hK, hCv, hCw, hav, hnaw, hi⟩
    exact h a hK w hCw hnaw ⟨v, hCv, hav, hi⟩
  · intro h a hK w hCw hnaw hS
    obtain ⟨v, hCv, hav, hi⟩ := hS
    exact h ⟨a, v, w, hK, hCv, hCw, hav, hnaw, hi⟩

/-- Every blind live cut after the transition was already one before it. -/
def CorrectionPreserving (s : State W O R M) (s' : State W O' R' M') : Prop :=
  ∀ a v w, BlindLiveCut s' a v w → BlindLiveCut s a v w

/-- Correction preservation is reflexive. -/
theorem correction_preserving_refl (s : State W O R M) :
    CorrectionPreserving s s :=
  fun _ _ _ h => h

/-- Correction-preserving transitions preserve anchor-safety. -/
theorem transition_preserves_safety {s : State W O R M} {s' : State W O' R' M'}
    (h : Unsealed s) (ht : CorrectionPreserving s s') : Unsealed s' := by
  apply (unsealed_iff_no_blind_live_cut s').2
  intro hex
  apply (unsealed_iff_no_blind_live_cut s).1 h
  obtain ⟨a, v, w, hcut⟩ := hex
  exact ⟨a, v, w, ht a v w hcut⟩

/-- From a safe state, any blind live cut created in the target violates
correction preservation. -/
theorem new_blind_cut_breaks_transition {s : State W O R M}
    {s' : State W O' R' M'} (h : Unsealed s)
    {a : W → Prop} {v w : W} (hcut : BlindLiveCut s' a v w) :
    ¬ CorrectionPreserving s s' := by
  intro ht
  exact (unsealed_iff_no_blind_live_cut s).1 h ⟨a, v, w, ht a v w hcut⟩

/-- Equivalent error-oriented form: from a safe state, sealing a live error in
a retained target commitment is not correction-preserving. -/
theorem new_seal_breaks_transition {s : State W O R M} {s' : State W O' R' M'}
    (h : Unsealed s) {a : W → Prop} (hK : s'.K a) {w : W}
    (hCw : s'.C w) (hnaw : ¬ a w) (hS : Sealed s' a w) :
    ¬ CorrectionPreserving s s' := by
  obtain ⟨v, hCv, hav, hi⟩ := hS
  exact new_blind_cut_breaks_transition h
    ⟨hK, hCv, hCw, hav, hnaw, hi⟩

/-- A safe target is correction-preserving relative to any source because it
contains no blind live cut to reflect backwards. -/
theorem unsealed_target_is_correction_preserving (s : State W O R M)
    {s' : State W O' R' M'} (h' : Unsealed s') : CorrectionPreserving s s' := by
  intro a v w hcut
  exact False.elim ((unsealed_iff_no_blind_live_cut s').1 h' ⟨a, v, w, hcut⟩)

/-- From a safe source, correction preservation is exactly target safety. -/
theorem correction_preserving_iff_safe_target {s : State W O R M}
    {s' : State W O' R' M'} (h : Unsealed s) :
    CorrectionPreserving s s' ↔ Unsealed s' :=
  ⟨transition_preserves_safety h, unsealed_target_is_correction_preserving s⟩

/-- Correction-preserving transitions compose across changing types. -/
theorem correction_preserving_trans {O'' : Type u₈} {R'' : Type u₉} {M'' : Type u₁₀}
    {s : State W O R M} {s' : State W O' R' M'} {s'' : State W O'' R'' M''}
    (h₁ : CorrectionPreserving s s') (h₂ : CorrectionPreserving s' s'') :
    CorrectionPreserving s s'' :=
  fun a v w hcut => h₁ a v w (h₂ a v w hcut)

end Core

section Trajectory

variable {W : Type u₁} (Ot : Nat → Type u₂) (Rt : Nat → Type u₃) (Mt : Nat → Type u₄)

/-- A trajectory whose representation/member/message types may change at every
step remains safe if every step is correction-preserving. -/
theorem trajectory_stays_safe (st : (t : Nat) → State W (Ot t) (Rt t) (Mt t))
    (hstep : ∀ t, CorrectionPreserving (st t) (st (t + 1)))
    (h₀ : Unsealed (st 0)) : ∀ t, Unsealed (st t)
  | 0 => h₀
  | t + 1 => transition_preserves_safety
      (trajectory_stays_safe st hstep h₀ t) (hstep t)

end Trajectory

section Specialisations

variable {W : Type u₁} {O : Type u₂} {R : Type u₃} {M : Type u₄}

/-- Route rewiring: cut-preserving reconfiguration is a correction-preserving
transition. -/
theorem reconfiguration_is_correction_preserving (s : State W O R M)
    (eff' : R → Prop) (hcfg : CutPreservingReconfiguration s eff') :
    CorrectionPreserving s { s with eff := eff' } := by
  rintro a v w ⟨hK, hCv, hCw, hav, hnaw, hi⟩
  exact ⟨hK, hCv, hCw, hav, hnaw,
    hcfg a hK v w hCv hCw hav hnaw hi⟩

/-- Shrinking candidate worlds and/or retained commitments while leaving the
correction architecture unchanged is correction-preserving. This theorem does
not itself establish that the shrink is evidentially justified; that requires
the separate evidence-discipline/reliability layer. -/
theorem shrink_is_correction_preserving (s : State W O R M)
    (C' : W → Prop) (K' : (W → Prop) → Prop)
    (hC : ∀ w, C' w → s.C w) (hK : ∀ a, K' a → s.K a) :
    CorrectionPreserving s { s with C := C', K := K' } := by
  rintro a v w ⟨hKa, hCv, hCw, hav, hnaw, hi⟩
  exact ⟨hK a hKa, hC v hCv, hC w hCw, hav, hnaw, hi⟩

/-- Re-encoding the inside view through a map with a left inverse is
correction-preserving even though the inside-view type changes. -/
theorem reencoding_is_correction_preserving {O' : Type u₅}
    (s : State W O R M) (e : O → O') (g : O' → O) (hg : ∀ o, g (e o) = o) :
    CorrectionPreserving s
      ({ C := s.C, obs := fun w => e (s.obs w), msg := s.msg, eff := s.eff,
         K := s.K } : State W O' R M) := by
  rintro a v w ⟨hK, hCv, hCw, hav, hnaw, hi⟩
  refine ⟨hK, hCv, hCw, hav, hnaw, ?_, hi.2⟩
  have h := congrArg g hi.1
  simp only [hg] at h
  exact h

/-- Membership replacement, possibly with a different member type, is itself a
correction-preserving transition when every new-network blind live cut was
already blind in the old network. -/
theorem membership_change_is_correction_preserving {N : Type u₂} {N' : Type u₃}
    (view : N → W → O) (S : N → Prop) (view' : N' → W → O) (S' : N' → Prop)
    (C : W → Prop) (K : (W → Prop) → Prop)
    (hcut : ∀ a, K a → ∀ v w, C v → C w → a v → ¬ a w →
      (∀ n', S' n' → view' n' v = view' n' w) →
      (∀ n, S n → view n v = view n w)) :
    CorrectionPreserving (nodeState view S C K) (nodeState view' S' C K) := by
  rintro a v w ⟨hK, hCv, hCw, hav, hnaw, hi⟩
  exact ⟨hK, hCv, hCw, hav, hnaw,
    ⟨rfl, hcut a hK v w hCv hCw hav hnaw hi.2⟩⟩

/-- Safety corollary for membership replacement. -/
theorem membership_change_preserves_safety {N : Type u₂} {N' : Type u₃}
    (view : N → W → O) (S : N → Prop) (view' : N' → W → O) (S' : N' → Prop)
    (C : W → Prop) (K : (W → Prop) → Prop)
    (hcut : ∀ a, K a → ∀ v w, C v → C w → a v → ¬ a w →
      (∀ n', S' n' → view' n' v = view' n' w) →
      (∀ n, S n → view n v = view n w))
    (h : Unsealed (nodeState view S C K)) :
    Unsealed (nodeState view' S' C K) :=
  transition_preserves_safety h
    (membership_change_is_correction_preserving view S view' S' C K hcut)

/-- For shared-layer dynamics, `NetworkCutPreserving` is exactly the generic
correction-preserving relation between consecutive network states. -/
theorem network_cut_preserving_iff_correction_preserving {N : Type u₂}
    (viewT : Nat → N → W → O) (S : N → Prop) (C : W → Prop)
    (K : (W → Prop) → Prop) (t : Nat) :
    NetworkCutPreserving viewT S C K t ↔
      CorrectionPreserving (netAt viewT S C K t) (netAt viewT S C K (t + 1)) := by
  constructor
  · intro hnet a v w hcut
    obtain ⟨hK, hCv, hCw, hav, hnaw, hi⟩ := hcut
    exact ⟨hK, hCv, hCw, hav, hnaw,
      hnet a hK v w hCv hCw hav hnaw hi⟩
  · intro hcp a hK v w hCv hCw hav hnaw hi
    obtain ⟨_, _, _, _, _, hold⟩ :=
      hcp a v w ⟨hK, hCv, hCw, hav, hnaw, hi⟩
    exact hold

/-- Connector updates are correction-preserving transitions. -/
theorem connector_is_correction_preserving {N : Type u₂} {H : Type u₃}
    (viewT : Nat → N → W → O) (hubT : Nat → W → H) (S : N → Prop)
    (C : W → Prop) (K : (W → Prop) → Prop) (t : Nat)
    (hcon : ConnectorUpdate viewT hubT S C K t) :
    CorrectionPreserving (netAt viewT S C K t) (netAt viewT S C K (t + 1)) :=
  (network_cut_preserving_iff_correction_preserving viewT S C K t).1 hcon.1

end Specialisations

end Anchored.CorrectionTransition
