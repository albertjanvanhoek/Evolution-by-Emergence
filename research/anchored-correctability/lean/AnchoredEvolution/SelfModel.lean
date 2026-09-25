import AnchoredEvolution.AnchorSafety

/-!
# Self-model layer: self-claims inherit the correctability law

The Anchor-Safety machinery is claim-generic: nothing in `State`, `Sealed`,
`Discoverable` or `Unsealed` distinguishes claims about the world from
claims an agent makes about itself. This layer makes that the headline and
treats three reflexive questions as *instantiations*, not as a new theory.

0. **No self-exemption** (`self_claims_inherit`). Restricting retained
   commitments to self-claims keeps anchor-safety. A self-model is one more
   retained commitment set, under the same law.
1. **Buffer dependence.** The inside history up to step `t` is a `State`
   whose effective routes are the past observation steps. Network dependence
   is *sealed* while the buffer lasts (`buffer_seals_dependence`). Once
   histories differ, the pair becomes distinguishable (`buffer_exhausted_pairwise`).
   This is pairwise distinguishability, not global recognition of dependence.
2. **Pivotal contribution.** A network of nodes is a `State` whose routes are
   nodes. Removing a *pivotal* node (the unique separator of a live cut) seals
   a live error (`pivotal_removal_seals`, via `last_route_removal_seals`).
   Removing a node determined by the others is a cut-preserving
   reconfiguration (`determined_removal_safe`, via
   `reconfiguration_preserves_safety`). Pivotal is not total contribution:
   a redundant node can hold robustness value, since it becomes pivotal as
   soon as its twin fails (`backup_becomes_pivotal`).
3. **Introspection.** Reports are the inside view of a `State` with no
   external routes. If two open worlds give the same reports and differ on a
   self-property, *both* polarities are sealed: "it holds" and "it does not
   hold" are each undiscoverable where false (`introspection_seals_both`).

Conceptual separation (see `SELF_MODEL.md`): the programme treats *identity* as a candidate
persisting-organised-process concept, not defined or proved here; the *self-model* is its representation of itself;
*relational particularity* is what the process makes available to the
larger network. The anchor constrains the self-model (parts 0, 1, 3). The
network theorems describe part of relational particularity (part 2).
Nothing here defines identity.
-/

namespace Anchored.SelfModel

open Anchored.AnchorSafety

universe u₁ u₂ u₃ u₄

/-! ## 0. No self-exemption -/

section NoExemption

variable {W : Type u₁} {O : Type u₂} {R : Type u₃} {M : Type u₄}

/-- The agent's self-model as a commitment set: the retained commitments
that are self-claims. `IsSelf` marks which claims are about the agent. -/
def selfPart (s : State W O R M) (IsSelf : (W → Prop) → Prop) : State W O R M :=
  { s with K := fun a => s.K a ∧ IsSelf a }

/-- **Self-claims inherit the correctability law.** An anchor-safe agent is
anchor-safe about its self-claims; no separate correctability law is needed in this framework.
(Instance of `dropping_commitments_preserves_safety`.) -/
theorem self_claims_inherit (s : State W O R M) (IsSelf : (W → Prop) → Prop)
    (h : Unsealed s) : Unsealed (selfPart s IsSelf) :=
  dropping_commitments_preserves_safety s _ (fun _ ha => ha.1) h

/-- **One sealed self-claim is enough to break whole-agent safety.**
The self-marker is load-bearing: the explicit sealed commitment is first
viewed inside the self-part, then inherited whole-agent safety is contradicted. -/
theorem sealed_self_claim_breaks_safety (s : State W O R M)
    (IsSelf : (W → Prop) → Prop) {a : W → Prop}
    (hK : s.K a) (hSelf : IsSelf a) {w : W}
    (hCw : s.C w) (hnaw : ¬ a w) (hS : Sealed s a w) :
    ¬ Unsealed s := by
  intro hs
  have hSelfSafe : Unsealed (selfPart s IsSelf) :=
    self_claims_inherit s IsSelf hs
  exact hSelfSafe a ⟨hK, hSelf⟩ w hCw hnaw hS

end NoExemption

/-! ## 1. Buffer dependence as a history state -/

section Buffer

variable {W : Type u₁} {O : Type u₂}

/-- The agent at step `t`, seen through its own history: the effective
routes are the observation steps `s ≤ t`. -/
def historyState (obsT : Nat → W → O) (C : W → Prop)
    (K : (W → Prop) → Prop) (t : Nat) : State W Unit Nat O where
  C   := C
  obs := fun _ => ()
  msg := fun s w => obsT s w
  eff := fun s => s ≤ t
  K   := K

variable (obsT : Nat → W → O) (C : W → Prop) (K : (W → Prop) → Prop)

/-- Indistinguishability in the history state is sameness of history up to `t`. -/
theorem historyState_indist_iff (t : Nat) (v w : W) :
    Indist (historyState obsT C K t) v w ↔ ∀ s, s ≤ t → obsT s v = obsT s w :=
  ⟨fun h => h.2, fun h => ⟨rfl, h⟩⟩

/-- **The buffer seals dependence.** Let `a` be the retained self-claim
"I sustain myself", true in open world `v` and false in open world `w`
(network-sustained). If the histories agree before the buffer `B` runs out,
then at every `t < B` the error in `w` is sealed, undiscoverable, and the
agent is not anchor-safe. (Instance of `discoverable_iff_not_sealed`.) -/
theorem buffer_seals_dependence (a : W → Prop) (hK : K a) {v w : W}
    (hCv : C v) (hCw : C w) (hav : a v) (hnaw : ¬ a w)
    (B : Nat) (hsame : ∀ s, s < B → obsT s v = obsT s w) {t : Nat} (ht : t < B) :
    Sealed (historyState obsT C K t) a w ∧
    ¬ Discoverable (historyState obsT C K t) a w ∧
    ¬ Unsealed (historyState obsT C K t) := by
  have hS : Sealed (historyState obsT C K t) a w :=
    ⟨v, hCv, hav, (historyState_indist_iff obsT C K t v w).2
      (fun s hs => hsame s (Nat.lt_of_le_of_lt hs ht))⟩
  exact ⟨hS, fun hD => (discoverable_iff_not_sealed _ a w).1 hD hS,
    fun hU => hU a hK w hCw hnaw hS⟩

/-- **The buffer runs out, pairwise.** If the histories differ at step `B`,
the pair `(v, w)` is distinguishable at `B`. This is pairwise
distinguishability only, not global recognition of dependence.
(Instance of `separated_not_indist`.) -/
theorem buffer_exhausted_pairwise {v w : W} (B : Nat)
    (hdiff : obsT B v ≠ obsT B w) :
    ¬ Indist (historyState obsT C K B) v w :=
  separated_not_indist _ (Or.inr ⟨B, Nat.le_refl B, hdiff⟩)

end Buffer

/-! ## 2. Pivotal contribution in a network of nodes -/

section Nodes

variable {W : Type u₁} {N : Type u₂} {O : Type u₃}

/-- A network seen from a receiver: routes are nodes, messages are views. -/
def nodeState (view : N → W → O) (S : N → Prop) (C : W → Prop)
    (K : (W → Prop) → Prop) : State W Unit N O where
  C := C
  obs := fun _ => ()
  msg := view
  eff := S
  K := K

variable (view : N → W → O) (S : N → Prop) (C : W → Prop) (K : (W → Prop) → Prop)

/-- The available nodes with `n` removed. -/
def without (T : N → Prop) (n : N) : N → Prop := fun m => T m ∧ m ≠ n

/-- `n` is *pivotal* for the pair `(v, w)`: available, separating, and every
other available node is blind on the pair. -/
def Pivotal (T : N → Prop) (n : N) (v w : W) : Prop :=
  T n ∧ view n v ≠ view n w ∧ ∀ m, T m → m ≠ n → view m v = view m w

/-- `n` is determined by the others: blind wherever all others are blind. -/
def DeterminedByOthers (n : N) : Prop :=
  ∀ v w, (∀ m, S m → m ≠ n → view m v = view m w) → view n v = view n w

/-- **Removing a pivotal node seals a live error.**
(Instance of `last_route_removal_seals`.) -/
theorem pivotal_removal_seals {a : W → Prop} (hK : K a) {v w : W}
    (hCv : C v) (hCw : C w) (hav : a v) (hnaw : ¬ a w) (n : N)
    (hp : Pivotal view S n v w) :
    ¬ Indist (nodeState view S C K) v w ∧
    Sealed { nodeState view S C K with eff := fun r => S r ∧ r ≠ n } a w ∧
    ¬ Unsealed { nodeState view S C K with eff := fun r => S r ∧ r ≠ n } :=
  last_route_removal_seals (nodeState view S C K) n hK hCv hCw hav hnaw rfl
    hp.1 hp.2.1 hp.2.2

/-- **Removing a determined node is cut-preserving, hence safe.**
(Instance of `reconfiguration_preserves_safety`.) -/
theorem determined_removal_safe [DecidableEq N] (n : N)
    (hdet : DeterminedByOthers view S n) (h : Unsealed (nodeState view S C K)) :
    Unsealed { nodeState view S C K with eff := without S n } := by
  apply reconfiguration_preserves_safety _ _ ?_ h
  intro _ _ v w _ _ _ _ hnew
  refine ⟨rfl, fun m hm => ?_⟩
  by_cases hmn : m = n
  · subst hmn
    exact hdet v w (fun k hk hkn => hnew.2 k ⟨hk, hkn⟩)
  · exact hnew.2 m ⟨hm, hmn⟩

/-- A determined node is never pivotal. -/
theorem determined_not_pivotal (n : N) (hdet : DeterminedByOthers view S n)
    (v w : W) : ¬ Pivotal view S n v w :=
  fun ⟨_, hsep, hothers⟩ => hsep (hdet v w hothers)

/-- **Redundancy as robustness.** If `n` and `m` both separate a pair that
every other node is blind on, neither is pivotal while both are present, yet
either becomes pivotal as soon as the other fails. Pivotal contribution is not
total contribution: a redundant node can carry robustness value as a backup.
(No axioms.) -/
theorem backup_becomes_pivotal {n m : N} (hnm : n ≠ m) {v w : W}
    (hn : S n) (hm : S m)
    (hsn : view n v ≠ view n w) (hsm : view m v ≠ view m w)
    (hothers : ∀ k, S k → k ≠ n → k ≠ m → view k v = view k w) :
    ¬ Pivotal view S n v w ∧
    ¬ Pivotal view S m v w ∧
    Pivotal view (without S m) n v w ∧
    Pivotal view (without S n) m v w := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · rintro ⟨_, _, h⟩
    exact hsm (h m hm (Ne.symm hnm))
  · rintro ⟨_, _, h⟩
    exact hsn (h n hn hnm)
  · refine ⟨⟨hn, hnm⟩, hsn, ?_⟩
    intro k hk hkn
    exact hothers k hk.1 hkn hk.2
  · refine ⟨⟨hm, Ne.symm hnm⟩, hsm, ?_⟩
    intro k hk hkm
    exact hothers k hk.1 hk.2 hkm

end Nodes

/-! ## 3. Introspection as a state without external routes -/

section Introspection

variable {W : Type u₁} {Rep : Type u₂}

/-- The agent judging itself from introspective reports alone. -/
def introState (report : W → Rep) (C : W → Prop) (K : (W → Prop) → Prop) :
    State W Rep Empty Unit where
  C := C
  obs := report
  msg := fun e => nomatch e
  eff := fun _ => False
  K := K

variable (report : W → Rep) (C : W → Prop) (K : (W → Prop) → Prop)

theorem introState_indist_iff (v w : W) :
    Indist (introState report C K) v w ↔ report v = report w :=
  ⟨fun h => h.1, fun h => ⟨h, fun _ hr => False.elim hr⟩⟩

/-- **Introspection seals both polarities.** If two open worlds give the
same reports and differ on a self-property `F`, then affirming `F` in `w` is
a real error there, and denying `F` in `v` is a real error there. Both errors
are sealed and neither is discoverable from reports. The question is left
open, not answered. (Instances of `discoverable_iff_not_sealed`.) -/
theorem introspection_seals_both (F : W → Prop) {v w : W}
    (hCv : C v) (hCw : C w) (hr : report v = report w)
    (hFv : F v) (hFw : ¬ F w) :
    (¬ F w ∧ Sealed (introState report C K) F w ∧
      ¬ Discoverable (introState report C K) F w) ∧
    (¬ (¬ F v) ∧ Sealed (introState report C K) (fun x => ¬ F x) v ∧
      ¬ Discoverable (introState report C K) (fun x => ¬ F x) v) := by
  have h1 : Sealed (introState report C K) F w :=
    ⟨v, hCv, hFv, (introState_indist_iff report C K v w).2 hr⟩
  have h2 : Sealed (introState report C K) (fun x => ¬ F x) v :=
    ⟨w, hCw, hFw, (introState_indist_iff report C K w v).2 hr.symm⟩
  have hnDenial : ¬ (¬ F v) := fun hnFv => hnFv hFv
  exact ⟨⟨hFw, h1, fun hD => (discoverable_iff_not_sealed _ F w).1 hD h1⟩,
         ⟨hnDenial, h2, fun hD => (discoverable_iff_not_sealed _ _ v).1 hD h2⟩⟩

end Introspection

end Anchored.SelfModel
