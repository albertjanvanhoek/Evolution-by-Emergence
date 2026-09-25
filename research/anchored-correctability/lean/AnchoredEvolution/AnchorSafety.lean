import AnchoredEvolution.Alignment

/-!
# Anchor-Safety: learn, act and commit, but never self-seal

Policy-level continuation of the anchor/common-ground layer in
`AnchoredEvolution.Alignment`. Lean 4 core only, no `sorry`, no Mathlib.

This file does **not** introduce a `CommonGroundCore.lean` dependency. The
current repository already carries the relevant anchor, tracking, blind-channel,
persistence and common-ground results in the AnchoredEvolution modules.

Question: what is the aim of an intelligence that understands the anchor?
Conditional answer (premise stated, not derived):

  *Objective.*  Improve the correspondence between model and reality.
  *Constraint.* Do not make a remaining error in a retained commitment
                impossible to discover.

This file formalises the constraint at one moment and over time.

Modelling choices (stated, as in the paper)
* `W`: worlds. `C w`: world `w` is still open given the evidence.
* `obs : W → O`: everything available inside the model.
* `msg r : W → M`: what route `r` delivers in world `w`.
* `eff r`: route `r` is *effective*. It reaches the agent, is accessible,
  and takes part in revision. Effectiveness is an **assumption about the
  route**, not derived here. Faithfulness is captured informationally:
  a route only counts through the distinctions its messages preserve.
  (Semantic faithfulness and deception stay open, as in the paper.)
* `K a`: `a` is a *retained commitment*, a claim the agent currently relies
  on. Correction obligations attach only to commitments, so a distinction
  that no commitment depends on (the colour of someone's shoes when judging
  a bridge) can be dropped without cost.

There is deliberately no "certainty" field: certainty is at most part of
`obs`, so nothing in this file can let it certify a commitment.

Main results
1. `discoverable_iff_not_sealed`: a live error is *informationally*
   discoverable from the available distinctions iff it is not sealed (no open
   world where the commitment holds looks identical). Two independent
   definitions, no axioms. This is extensional/information-level, not yet an
   executable decoder theorem; executable realization remains in the existing
   Operational/ModelProcess/RelayProcess layers.
2. `anchorSafe_iff_cuts_separated`: semantic anchor-safety iff every cut
   pair of every retained commitment is separated by the inside view or by
   some effective route (the cut-separation form; the reverse direction is
   classical). `R` is an abstract route index here, not yet a graph path.
3. `sealed_error_invisible`: once sealed, no available judge decides the
   commitment correctly on the open worlds. The claim has not become truer;
   its falsity has become undetectable.
4. `evidence_preserves_safety`: closing worlds never breaks anchor-safety.
   `dropping_commitments_preserves_safety`: fewer commitments, fewer obligations.
5. `reconfiguration_preserves_safety`: a route reconfiguration is safe when
   no live commitment cut that was distinguishable becomes indistinguishable;
   this genuinely permits replacement/rewiring. `prune_safe` is a stronger
   route-wise corollary: old informative routes are kept, while redundant or
   irrelevant ones may be removed and new routes may be activated.
6. `last_route_removal_seals`: from an anchor-safe state, removing a stated
   unique effective separator of a live commitment cut breaks anchor-safety.
   `redundant_never_last` is the corresponding local redundancy lemma: a route
   that is a function of the inside view cannot separate an inside-blind pair.
7. Time: `permanent_seal_permanent_error` (an irreversible seal on the actual
   world is an error that is never discovered) and
   `repairable_seal_is_delay` (a seal repaired within `R` steps only delays
   discovery by at most `R`).
-/

namespace Anchored.AnchorSafety

universe u₁ u₂ u₃ u₄

/-- An agent's epistemic situation at one moment. -/
structure State (W : Type u₁) (O : Type u₂) (R : Type u₃) (M : Type u₄) where
  /-- worlds the evidence still leaves open -/
  C   : W → Prop
  /-- everything available inside the model -/
  obs : W → O
  /-- what route `r` delivers in world `w` -/
  msg : R → W → M
  /-- route `r` is effective: reaches the agent, accessible, enters revision -/
  eff : R → Prop
  /-- retained commitments: claims the agent currently relies on -/
  K   : (W → Prop) → Prop

variable {W : Type u₁} {O : Type u₂} {R : Type u₃} {M : Type u₄}

section OneMoment

variable (s : State W O R M)

/-- `v` and `w` look the same through everything the agent can use:
its own view and every effective route. -/
def Indist (v w : W) : Prop :=
  s.obs v = s.obs w ∧ ∀ r, s.eff r → s.msg r v = s.msg r w

theorem indist_refl (w : W) : Indist s w w :=
  ⟨rfl, fun _ _ => rfl⟩

theorem indist_symm {v w : W} (h : Indist s v w) : Indist s w v :=
  ⟨h.1.symm, fun r hr => (h.2 r hr).symm⟩

theorem indist_trans {u v w : W} (h₁ : Indist s u v) (h₂ : Indist s v w) :
    Indist s u w :=
  ⟨h₁.1.trans h₂.1, fun r hr => (h₁.2 r hr).trans (h₂.2 r hr)⟩

/-- An **information-respecting** judgement: it is constant on worlds that
look the same through all currently available distinctions.

This is an extensional information-level notion, not a computability or
executability claim. Existing operational layers handle actual executable
challenge/revision processes. -/
def Available (J : W → Prop) : Prop :=
  ∀ v w, Indist s v w → J v → J w

/-- **Semantic/information-level** notion. The error "`a` is false in `w`"
is *discoverable in principle from the available distinctions*: some
information-respecting judgement fires in `w` and never fires in an open world
where `a` holds. This does not by itself construct an executable decoder. -/
def Discoverable (a : W → Prop) (w : W) : Prop :=
  ∃ J : W → Prop, Available s J ∧ (∀ v, s.C v → J v → ¬ a v) ∧ J w

/-- **Structural** notion. `w` is *sealed* against `a`: some open world in
which `a` holds is indistinguishable from `w`. -/
def Sealed (a : W → Prop) (w : W) : Prop :=
  ∃ v, s.C v ∧ a v ∧ Indist s v w

/-- **Result 1.** Discoverable iff not sealed. Constructive, no axioms. -/
theorem discoverable_iff_not_sealed (a : W → Prop) (w : W) :
    Discoverable s a w ↔ ¬ Sealed s a w := by
  constructor
  · rintro ⟨J, hAv, hSound, hJw⟩ ⟨v, hCv, hav, hvw⟩
    exact hSound v hCv (hAv w v (indist_symm s hvw) hJw) hav
  · intro hNS
    refine ⟨fun x => ¬ Sealed s a x, ?_, ?_, hNS⟩
    · intro x y hxy hx ⟨v, hCv, hav, hvy⟩
      exact hx ⟨v, hCv, hav, indist_trans s hvy (indist_symm s hxy)⟩
    · intro v hCv hJv hav
      exact hJv ⟨v, hCv, hav, indist_refl s v⟩

/-- **Semantic anchor-safety**: every live error of every retained
commitment is discoverable from what is available now. -/
def AnchorSafe : Prop :=
  ∀ a, s.K a → ∀ w, s.C w → ¬ a w → Discoverable s a w

/-- **Structural anchor-safety**: no live error is sealed. -/
def Unsealed : Prop :=
  ∀ a, s.K a → ∀ w, s.C w → ¬ a w → ¬ Sealed s a w

theorem anchorSafe_iff_unsealed : AnchorSafe s ↔ Unsealed s :=
  ⟨fun h a hK w hC hn => (discoverable_iff_not_sealed s a w).1 (h a hK w hC hn),
   fun h a hK w hC hn => (discoverable_iff_not_sealed s a w).2 (h a hK w hC hn)⟩

/-- A cut pair of `a` is *separated* if the inside view or some effective
route tells its two worlds apart. -/
def Separated (v w : W) : Prop :=
  s.obs v ≠ s.obs w ∨ ∃ r, s.eff r ∧ s.msg r v ≠ s.msg r w

/-- Cut-separation form: every cut pair (open `v` with `a`, open `w` without)
of every retained commitment is separated. This becomes a graph-cut statement
only under an application-specific interpretation of `R` as reachable routes. -/
def CutsSeparated : Prop :=
  ∀ a, s.K a → ∀ v w, s.C v → s.C w → a v → ¬ a w → Separated s v w

theorem separated_not_indist {v w : W} (h : Separated s v w) : ¬ Indist s v w := by
  rintro ⟨ho, hm⟩
  rcases h with h | ⟨r, hr, hne⟩
  · exact h ho
  · exact hne (hm r hr)

/-- Converse uses classical logic (a failed conjunction names a witness). -/
theorem not_indist_separated {v w : W} (h : ¬ Indist s v w) : Separated s v w := by
  apply Classical.byContradiction
  intro hns
  apply h
  refine ⟨Classical.byContradiction fun ho => hns (Or.inl ho), fun r hr => ?_⟩
  exact Classical.byContradiction fun hne => hns (Or.inr ⟨r, hr, hne⟩)

/-- **Result 2.** Semantic anchor-safety iff every commitment cut is separated.
(→ constructive via result 1 up to the classical step; ← constructive.) -/
theorem anchorSafe_iff_cuts_separated : AnchorSafe s ↔ CutsSeparated s := by
  rw [anchorSafe_iff_unsealed]
  constructor
  · intro h a hK v w hCv hCw hav hnaw
    exact not_indist_separated s fun hvw => h a hK w hCw hnaw ⟨v, hCv, hav, hvw⟩
  · rintro h a hK w hCw hnaw ⟨v, hCv, hav, hvw⟩
    exact separated_not_indist s (h a hK v w hCv hCw hav hnaw) hvw

/-- **Result 3.** A sealed error is invisible: no available judgement agrees
with `a` on all open worlds. Sealing changes what can be known, not what is true. -/
theorem sealed_error_invisible {a : W → Prop} {w : W}
    (hCw : s.C w) (hnaw : ¬ a w) (hS : Sealed s a w)
    (J : W → Prop) (hAv : Available s J) :
    ¬ (∀ x, s.C x → (J x ↔ a x)) := by
  intro hJ
  obtain ⟨v, hCv, hav, hvw⟩ := hS
  exact hnaw ((hJ w hCw).1 (hAv v w hvw ((hJ v hCv).2 hav)))

end OneMoment

/-! ## What is allowed: learning, dropping commitments, compressing -/

/-- **Result 4a.** Evidence may close worlds freely. -/
theorem evidence_preserves_safety (s : State W O R M) (C' : W → Prop)
    (hsub : ∀ w, C' w → s.C w) (h : Unsealed s) :
    Unsealed { s with C := C' } := by
  rintro a hK w hCw hnaw ⟨v, hCv, hav, hvw⟩
  exact h a hK w (hsub w hCw) hnaw ⟨v, hsub v hCv, hav, hvw⟩

/-- **Result 4b.** Fewer commitments, fewer correction obligations. -/
theorem dropping_commitments_preserves_safety (s : State W O R M)
    (K' : (W → Prop) → Prop) (hsub : ∀ a, K' a → s.K a) (h : Unsealed s) :
    Unsealed { s with K := K' } :=
  fun a hK w hCw hnaw hS => h a (hsub a hK) w hCw hnaw hS

/-- A route *cuts no commitment* if it never separates a cut pair that the
inside view leaves unseparated. -/
def CutsNothing (s : State W O R M) (r : R) : Prop :=
  ∀ a, s.K a → ∀ v w, s.C v → s.C w → a v → ¬ a w →
    s.obs v = s.obs w → s.msg r v = s.msg r w

/-- A route is *redundant* if its message is a function of the inside view. -/
def Redundant (s : State W O R M) (r : R) : Prop :=
  ∃ f : O → M, ∀ w, s.msg r w = f (s.obs w)

theorem redundant_cutsNothing (s : State W O R M) (r : R) (h : Redundant s r) :
    CutsNothing s r := by
  obtain ⟨f, hf⟩ := h
  intro _ _ v w _ _ _ _ ho
  rw [hf v, hf w, ho]

/-- A reconfiguration preserves live commitment cuts when any pair that becomes
indistinguishable after the change was already indistinguishable before it.
This condition is extensional: a new route may replace an old informative route. -/
def CutPreservingReconfiguration (s : State W O R M) (eff' : R → Prop) : Prop :=
  ∀ a, s.K a → ∀ v w, s.C v → s.C w → a v → ¬ a w →
    Indist { s with eff := eff' } v w → Indist s v w

/-- **Result 5a.** Genuine route replacement/rewiring is safe whenever it
preserves every distinction on every still-live cut of a retained commitment.
Constructive, no axioms. -/
theorem reconfiguration_preserves_safety (s : State W O R M) (eff' : R → Prop)
    (hcfg : CutPreservingReconfiguration s eff') (h : Unsealed s) :
    Unsealed { s with eff := eff' } := by
  rintro a hK w hCw hnaw ⟨v, hCv, hav, hnew⟩
  exact h a hK w hCw hnaw ⟨v, hCv, hav, hcfg a hK v w hCv hCw hav hnaw hnew⟩

/-- **Result 5b.** Route-wise pruning is a sufficient specialization: every old
effective route that distinguishes some relevant inside-blind cut is retained.
Old irrelevant/redundant routes may be removed, and new routes may be activated.
Unlike `reconfiguration_preserves_safety`, this corollary does not permit
replacing an old informative route by a different one. -/
theorem prune_safe (s : State W O R M) (eff' : R → Prop)
    (hkeep : ∀ r, s.eff r → eff' r ∨ CutsNothing s r)
    (h : Unsealed s) : Unsealed { s with eff := eff' } := by
  apply reconfiguration_preserves_safety s eff' ?_ h
  intro a hK v w hCv hCw hav hnaw hnew
  refine ⟨hnew.1, fun r hr => ?_⟩
  rcases hkeep r hr with h' | hn
  · exact hnew.2 r h'
  · exact hn a hK v w hCv hCw hav hnaw hnew.1

theorem prune_redundant_safe (s : State W O R M) (eff' : R → Prop)
    (hkeep : ∀ r, s.eff r → eff' r ∨ Redundant s r)
    (h : Unsealed s) : Unsealed { s with eff := eff' } :=
  prune_safe s eff'
    (fun r hr => (hkeep r hr).imp id (redundant_cutsNothing s r)) h

/-! ## What is forbidden: closing the last route -/

/-- **Result 6.** Causal last-route statement. Start from an anchor-safe
state. If `r₀` is effective, separates a live cut pair that the inside view
cannot separate, and every other effective route is blind on that pair, then
removing `r₀` takes the state from safe to unsafe. -/
theorem last_route_removal_seals (s : State W O R M) (r₀ : R)
    (hsafe : Unsealed s) {a : W → Prop} (hK : s.K a) {v w : W}
    (hCv : s.C v) (hCw : s.C w) (hav : a v) (hnaw : ¬ a w)
    (ho : s.obs v = s.obs w)
    (hr₀eff : s.eff r₀) (hr₀sep : s.msg r₀ v ≠ s.msg r₀ w)
    (hothers : ∀ r, s.eff r → r ≠ r₀ → s.msg r v = s.msg r w) :
    Unsealed s ∧ ¬ Unsealed { s with eff := fun r => s.eff r ∧ r ≠ r₀ } := by
  refine ⟨hsafe, ?_⟩
  intro hnew
  exact hnew a hK w hCw hnaw
    ⟨v, hCv, hav, ho, fun r hr => hothers r hr.1 hr.2⟩

/-- Local redundancy lemma corresponding to the information principle behind
Theorem 6: a route that is a function of the inside view cannot separate a pair
the inside view itself cannot separate. -/
theorem redundant_never_last (s : State W O R M) (r : R) (hr : Redundant s r)
    {v w : W} (ho : s.obs v = s.obs w) : s.msg r v = s.msg r w := by
  obtain ⟨f, hf⟩ := hr
  rw [hf v, hf w, ho]

/-! ## Over time: irreversible sealing versus repair -/

section Time

variable (traj : Nat → State W O R M) (a : W → Prop) (wstar : W)

/-- The actual world is never closed by (truthful) evidence, and `a` is
false in it: a real error. -/
def RealError : Prop := (∀ t, (traj t).C wstar) ∧ ¬ a wstar

/-- **Result 7a.** If `a` is genuinely false in the actual world and truthful
evidence never closes that world, then a seal that is never lifted makes that
real error informationally undiscoverable for as long as the seal persists. -/
theorem permanent_seal_permanent_error (t₀ : Nat)
    (_herr : RealError traj a wstar)
    (hseal : ∀ t, t₀ ≤ t → Sealed (traj t) a wstar) :
    ∀ t, t₀ ≤ t → ¬ Discoverable (traj t) a wstar :=
  fun t ht hD => (discoverable_iff_not_sealed (traj t) a wstar).1 hD (hseal t ht)

/-- Repairable within `R`: from any time, within `R` steps the error is
unsealed again. -/
def RepairableWithin (Rh : Nat) : Prop :=
  ∀ t, ∃ t', t ≤ t' ∧ t' ≤ t + Rh ∧ ¬ Sealed (traj t') a wstar

/-- **Result 7b.** For a real error, bounded unsealing turns an
information-level seal into bounded delay: from any time the error becomes
informationally discoverable within `R` steps. -/
theorem repairable_seal_is_delay (Rh : Nat) (_herr : RealError traj a wstar)
    (h : RepairableWithin traj a wstar Rh) :
    ∀ t, ∃ t', t ≤ t' ∧ t' ≤ t + Rh ∧ Discoverable (traj t') a wstar := by
  intro t
  obtain ⟨t', h1, h2, h3⟩ := h t
  exact ⟨t', h1, h2, (discoverable_iff_not_sealed (traj t') a wstar).2 h3⟩

/-- The two regimes exclude each other: an irreversible seal is not repairable. -/
theorem irreversible_not_repairable (Rh t₀ : Nat)
    (hseal : ∀ t, t₀ ≤ t → Sealed (traj t) a wstar) :
    ¬ RepairableWithin traj a wstar Rh := by
  intro h
  obtain ⟨t', h1, _, h3⟩ := h t₀
  exact h3 (hseal t' h1)

end Time

end Anchored.AnchorSafety
