import AnchoredEvolution.DynamicEvidence

/-!
# Compiling a scale-free model into an executable process

`Network.Model` is the scale-free semantic object: private state, public record,
and a content-sensitive revision rule. `Operational.Process` is the executable
object: labelled steps with time and resource cost.

This file supplies the first concrete bridge between them. For a fixed incoming
content `v`, a model is compiled into a two-stage process:

1. challenge: `idle → heard` (cost 1);
2. local revision using `M.revise _ v`: `heard → done` (cost 1).

The public record is always `M.record` of the model's local state.

If the model tracks a live view, the compiled process tracks the same view and
answers it within two steps and cost two. Thus the abstract model-level
revision law is realizable by an actual `Operational.Process`; time and cost are
no longer merely external annotations at the local-model boundary.

This is deliberately a **local compiler**. Relay steps between different models
are the next construction; they should compose these local processes along a
network route rather than reintroduce a second correction law.
-/

universe u

namespace Anchored.ModelProcess

open LearningConstitution Operational Semantic Tracking Network

variable {World : Type u}

/-- A one-element type living in the same universe as the model.  `Process`
requires all five of its type parameters to inhabit one universe; using
ordinary `Unit` would incorrectly force a higher-universe model down to
`Type 0`. -/
abbrev One : Type u := PUnit.{u+1}

inductive Phase
  | idle | heard | done
  deriving DecidableEq

/-- Operational state of one compiled model. -/
structure ExecState (M : Model World) where
  localState : M.State
  phase : Phase

/-- Public decision record of the compiled process. -/
def execRecord (M : Model World) : ExecState M → One → Content World :=
  fun s _ => M.record s.localState

/-- Initial process state corresponding to model state `s`. -/
def start (M : Model World) (s : M.State) : ExecState M :=
  ⟨s, Phase.idle⟩

/-- Intermediate state after the challenge has been heard. -/
def heard (M : Model World) (s : M.State) : ExecState M :=
  ⟨s, Phase.heard⟩

/-- Final state after revising toward content `v`. -/
def done (M : Model World) (s : M.State) (v : Content World) : ExecState M :=
  ⟨M.revise s v, Phase.done⟩

/-- Compile one model and one incoming content into an executable two-step
process. `base` only fills the legacy state-independent `claimOf` field of
`Operational.Process`; semantic answering uses the state-dependent
`execRecord`. -/
def compile (M : Model World) (base v : Content World) :
    Process One (ExecState M) (Content World) One One where
  step := fun s verb t =>
    (s.phase = Phase.idle ∧ verb = .challenge PUnit.unit (M.record s.localState) ∧
      t.localState = s.localState ∧ t.phase = Phase.heard) ∨
    (s.phase = Phase.heard ∧ verb = .revise (M.record s.localState) ∧
      t.localState = M.revise s.localState v ∧ t.phase = Phase.done)
  cost := fun _ _ _ => 1
  affected := fun _ _ => True
  sharedClaim := fun _ _ => True
  excluded := fun _ _ => False
  groundsForReview := fun _ _ => True
  sameStanding := fun _ _ _ => True
  restricts := fun _ _ _ => True
  claimOf := fun _ => base

variable (M : Model World) (base : Content World)

/-- Content-indexed family used by `Tracking.Tracks`. -/
def processFamily : Content World → Process One (ExecState M) (Content World) One One :=
  fun v => compile M base v

/-- The record family is content-independent because the same model exposes the
same public record regardless of which challenge we use to inspect it. -/
def recordFamily : Content World → ExecState M → One → Content World :=
  fun _ => execRecord M

variable {M base}

/-- The challenge step is always executable from an initial state. -/
theorem challenge_step (s : M.State) (v : Content World) :
    (compile M base v).step (start M s)
      (.challenge PUnit.unit (M.record s)) (heard M s) := by
  exact Or.inl ⟨rfl, rfl, rfl, rfl⟩

/-- The local revision step executes after hearing the challenge. -/
theorem revision_step (s : M.State) (v : Content World) :
    (compile M base v).step (heard M s)
      (.revise (M.record s)) (done M s v) := by
  exact Or.inr ⟨rfl, rfl, rfl, rfl⟩

/-- Any state reachable after the challenge is either the unchanged `heard`
state or the uniquely revised `done` state. -/
theorem after_challenge_cases (s : M.State) (v : Content World)
    {t : ExecState M}
    (h : AfterChallenge (processFamily M base) (recordFamily M) v
      (start M s) PUnit.unit PUnit.unit t) :
    (t.localState = s ∧ t.phase = Phase.heard) ∨
      (t.localState = M.revise s v ∧ t.phase = Phase.done) := by
  obtain ⟨t₁, n, k, hs, hr⟩ := h
  have ht₁p : t₁.localState = s := by
    rcases hs with h1 | h2
    · exact h1.2.2.1
    · cases h2.1
  have ht₁phase : t₁.phase = Phase.heard := by
    rcases hs with h1 | h2
    · exact h1.2.2.2
    · cases h2.1
  cases hr with
  | nil =>
      exact Or.inl ⟨ht₁p, ht₁phase⟩
  | @cons _ t₂ t₃ verb n k hstep hrun =>
      have ht₂p : t₂.localState = M.revise s v := by
        rcases hstep with h1 | h2
        · rw [ht₁phase] at h1
          contradiction
        · rw [ht₁p] at h2
          exact h2.2.2.1
      have ht₂phase : t₂.phase = Phase.done := by
        rcases hstep with h1 | h2
        · rw [ht₁phase] at h1
          contradiction
        · exact h2.2.2.2
      cases hrun with
      | nil => exact Or.inr ⟨ht₂p, ht₂phase⟩
      | cons hnext _ =>
          rcases hnext with h1 | h2
          · rw [ht₂phase] at h1
            contradiction
          · rw [ht₂phase] at h2
            contradiction

/-- **The model-level law is operationally realizable.** If `M` tracks and `v`
is live, the compiled step-and-cost process tracks `v` in the stronger
process-level sense of `Tracking.Tracks`. -/
theorem compiled_tracks_of_live {C : Content World}
    (hM : M.Tracking C) {s : M.State} {v : Content World}
    (hlive : LiveClaim den C v) :
    Tracks den C (processFamily M base) (recordFamily M) v
      (start M s) PUnit.unit PUnit.unit := by
  refine ⟨?_, ?_⟩
  · refine ⟨done M s v, ?_, (hM s v).1 hlive⟩
    refine ⟨heard M s, 1, 1, challenge_step s v, ?_⟩
    exact Process.Run.cons (revision_step s v) (Process.Run.nil _)
  · intro t ht w hw hr
    rcases after_challenge_cases s v ht with hheard | hdone
    · have hp : t.localState = s := hheard.1
      change M.record t.localState w at hr
      rw [hp] at hr
      exact Or.inl hr
    · have hp : t.localState = M.revise s v := hdone.1
      change M.record t.localState w at hr
      rw [hp] at hr
      exact (hM s v).2 w hw hr

/-- The compiled process answers a tracked live view within the obvious upper
bound: two steps and cost two. -/
theorem compiled_answerWithin_two {C : Content World}
    (hM : M.Tracking C) {s : M.State} {v : Content World}
    (hlive : LiveClaim den C v) :
    AnswerWithin (compile M base v) den C (execRecord M)
      (start M s) PUnit.unit PUnit.unit v 2 2 := by
  refine ⟨heard M s, done M s v, 1, 1, challenge_step s v, ?_,
    (hM s v).1 hlive, by decide, by decide⟩
  exact Process.Run.cons (revision_step s v) (Process.Run.nil _)

/-- Consequently every live content tracked by the abstract model is
operationally answerable at finite time and cost after compilation. -/
theorem compiled_answerable_of_live {C : Content World}
    (hM : M.Tracking C) {s : M.State} {v : Content World}
    (hlive : LiveClaim den C v) :
    Answerable (compile M base v) den C (execRecord M)
      (start M s) PUnit.unit PUnit.unit v :=
  ⟨2, 2, compiled_answerWithin_two hM hlive⟩

end Anchored.ModelProcess
