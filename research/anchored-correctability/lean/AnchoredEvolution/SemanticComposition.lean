import AnchoredEvolution.Semantics

/-!
# Layer 3b: semantic composition across a boundary

The graph layer proves that structural correction routes compose.  After the
operational and semantic layers, that is no longer enough: a member challenge
must cross the boundary without changing its meaning, and an answer in the
member process must remain an answer in the containing process.

This file states the boundary law as a faithful simulation between two learning
processes.  The source and target may use different agent, state, claim,
evidence and decision types, but they share the same candidate worlds.

There are two independent obligations:

1. **semantic faithfulness:** translating a claim preserves exactly the
   candidate worlds in which it holds;
2. **operational faithfulness:** every source step is executable after
   translation, records commute with translation, and the cost of a translated
   step is unchanged.

Under those conditions, responsive runs lift and, more importantly,
**answerability is preserved across the boundary**.  Applying the theorem twice
shows that the same law works through two nesting levels; no new semantic rule
is introduced at the second boundary.
-/

universe u

namespace Anchored.SemanticComposition

open LearningConstitution
open Operational
open Semantic

/-! ## 1. Heterogeneous translations -/

section Translation

variable {Claim₁ Claim₂ World : Type u}

/-- A heterogeneous translation is strengthening when the translated claim
never says less than the source claim on candidate worlds. -/
def HStrengthening (meaning₁ : Claim₁ → World → Prop)
    (meaning₂ : Claim₂ → World → Prop) (Candidate : World → Prop)
    (tr : Claim₁ → Claim₂) : Prop :=
  ∀ c w, Candidate w → meaning₂ (tr c) w → meaning₁ c w

/-- A heterogeneous translation is weakening when every source-world witness
is also a witness for its translation. -/
def HWeakening (meaning₁ : Claim₁ → World → Prop)
    (meaning₂ : Claim₂ → World → Prop) (Candidate : World → Prop)
    (tr : Claim₁ → Claim₂) : Prop :=
  ∀ c w, Candidate w → meaning₁ c w → meaning₂ (tr c) w

/-- Faithful translation: source and translated claims have exactly the same
meaning on every candidate world. -/
def HFaithful (meaning₁ : Claim₁ → World → Prop)
    (meaning₂ : Claim₂ → World → Prop) (Candidate : World → Prop)
    (tr : Claim₁ → Claim₂) : Prop :=
  HStrengthening meaning₁ meaning₂ Candidate tr ∧
  HWeakening meaning₁ meaning₂ Candidate tr

/-- Faithful heterogeneous translation preserves compatibility exactly. -/
theorem hfaithful_compatible_iff {meaning₁ : Claim₁ → World → Prop}
    {meaning₂ : Claim₂ → World → Prop} {Candidate : World → Prop}
    {tr : Claim₁ → Claim₂} (h : HFaithful meaning₁ meaning₂ Candidate tr)
    (c c' : Claim₁) :
    Compatible meaning₂ Candidate (tr c) (tr c') ↔
      Compatible meaning₁ Candidate c c' := by
  constructor
  · rintro ⟨w, hw, hc, hc'⟩
    exact ⟨w, hw, h.1 c w hw hc, h.1 c' w hw hc'⟩
  · rintro ⟨w, hw, hc, hc'⟩
    exact ⟨w, hw, h.2 c w hw hc, h.2 c' w hw hc'⟩

/-- Faithful heterogeneous translation preserves incompatibility exactly. -/
theorem hfaithful_incompatible_iff {meaning₁ : Claim₁ → World → Prop}
    {meaning₂ : Claim₂ → World → Prop} {Candidate : World → Prop}
    {tr : Claim₁ → Claim₂} (h : HFaithful meaning₁ meaning₂ Candidate tr)
    (c c' : Claim₁) :
    Incompatible meaning₂ Candidate (tr c) (tr c') ↔
      Incompatible meaning₁ Candidate c c' := by
  constructor
  · intro hi w hw hboth
    exact hi w hw ⟨h.2 c w hw hboth.1, h.2 c' w hw hboth.2⟩
  · intro hi w hw hboth
    exact hi w hw ⟨h.1 c w hw hboth.1, h.1 c' w hw hboth.2⟩

end Translation

/-! ## 2. Mapping process verbs across a boundary -/

section ProcessMap

variable {Agent₁ State₁ Claim₁ Evidence₁ Decision₁ : Type u}
variable {Agent₂ State₂ Claim₂ Evidence₂ Decision₂ : Type u}
variable {World : Type u}

/-- Translate every procedural verb. -/
def mapVerb (agent : Agent₁ → Agent₂) (claim : Claim₁ → Claim₂)
    (evidence : Evidence₁ → Evidence₂) :
    Verb Agent₁ Claim₁ Evidence₁ → Verb Agent₂ Claim₂ Evidence₂
  | .assertClaim a c => .assertClaim (agent a) (claim c)
  | .challenge a c => .challenge (agent a) (claim c)
  | .presentEvidence a e => .presentEvidence (agent a) (evidence e)
  | .respond a c => .respond (agent a) (claim c)
  | .revise c => .revise (claim c)
  | .reopen c => .reopen (claim c)
  | .repair a b => .repair (agent a) (agent b)
  | .appealExclusion a => .appealExclusion (agent a)
  | .restoreAccess a => .restoreAccess (agent a)

/-- A **faithful semantic embedding** of one learning process into another.
The target may contain additional steps; the requirement is only that every
source step, record and claim meaning survives the boundary faithfully. -/
structure Embedding
    (P : Process Agent₁ State₁ Claim₁ Evidence₁ Decision₁)
    (Q : Process Agent₂ State₂ Claim₂ Evidence₂ Decision₂)
    (meaning₁ : Claim₁ → World → Prop) (meaning₂ : Claim₂ → World → Prop)
    (Candidate : World → Prop)
    (record₁ : State₁ → Decision₁ → Claim₁)
    (record₂ : State₂ → Decision₂ → Claim₂) where
  agent : Agent₁ → Agent₂
  state : State₁ → State₂
  claim : Claim₁ → Claim₂
  evidence : Evidence₁ → Evidence₂
  decision : Decision₁ → Decision₂
  meaning_faithful : HFaithful meaning₁ meaning₂ Candidate claim
  record_commutes : ∀ s d, record₂ (state s) (decision d) = claim (record₁ s d)
  step_preserved : ∀ {s v t}, P.step s v t →
    Q.step (state s) (mapVerb agent claim evidence v) (state t)
  cost_preserved : ∀ {s v t}, P.step s v t →
    Q.cost (state s) (mapVerb agent claim evidence v) (state t) = P.cost s v t

namespace Embedding

variable {P : Process Agent₁ State₁ Claim₁ Evidence₁ Decision₁}
variable {Q : Process Agent₂ State₂ Claim₂ Evidence₂ Decision₂}
variable {meaning₁ : Claim₁ → World → Prop} {meaning₂ : Claim₂ → World → Prop}
variable {Candidate : World → Prop}
variable {record₁ : State₁ → Decision₁ → Claim₁}
variable {record₂ : State₂ → Decision₂ → Claim₂}
variable (F : Embedding P Q meaning₁ meaning₂ Candidate record₁ record₂)

/-- Runs lift across a faithful process boundary with exactly the same step
count and accumulated cost. -/
theorem liftRun {s t : State₁} {n k : Nat} (h : P.Run s t n k) :
    Q.Run (F.state s) (F.state t) n k := by
  induction h with
  | nil s => exact Process.Run.nil _
  | @cons s t w v n k hstep hrun ih =>
      have hs := F.step_preserved hstep
      have hc := F.cost_preserved hstep
      simpa [hc] using (Process.Run.cons hs ih)

/-- Semantic admission is preserved by a faithful boundary translation. -/
theorem admits_preserved {t : State₁} {d : Decision₁} {ca : Claim₁}
    (h : Admits meaning₁ Candidate record₁ t d ca) :
    Admits meaning₂ Candidate record₂ (F.state t) (F.decision d) (F.claim ca) := by
  unfold Admits at h ⊢
  rw [F.record_commutes]
  exact (hfaithful_compatible_iff F.meaning_faithful _ _).2 h

/-- **Answerability survives a faithful process boundary.**  If a member's
challenge can be answered in the member process, then the translated challenge
can be answered in the containing process with the same time and cost bounds.
This is the semantic analogue of structural correction-route composition. -/
theorem answerWithin_preserved {s : State₁} {a : Agent₁} {d : Decision₁}
    {ca : Claim₁} {T K : Nat}
    (h : AnswerWithin P meaning₁ Candidate record₁ s a d ca T K) :
    AnswerWithin Q meaning₂ Candidate record₂ (F.state s) (F.agent a)
      (F.decision d) (F.claim ca) T K := by
  obtain ⟨t₁, t, n, k, hchallenge, hrun, hadmits, hT, hK⟩ := h
  refine ⟨F.state t₁, F.state t, n, k, ?_, F.liftRun hrun,
    F.admits_preserved hadmits, hT, ?_⟩
  · have hs := F.step_preserved hchallenge
    rw [F.record_commutes]
    exact hs
  · have hc := F.cost_preserved hchallenge
    rw [F.record_commutes]
    simpa [hc] using hK

/-- Unbounded answerability is therefore preserved as well. -/
theorem answerable_preserved {s : State₁} {a : Agent₁} {d : Decision₁}
    {ca : Claim₁}
    (h : Answerable P meaning₁ Candidate record₁ s a d ca) :
    Answerable Q meaning₂ Candidate record₂ (F.state s) (F.agent a)
      (F.decision d) (F.claim ca) := by
  obtain ⟨T, K, hTK⟩ := h
  exact ⟨T, K, F.answerWithin_preserved hTK⟩

end Embedding

end ProcessMap

/-! ## 3. Two levels use the same law -/

section TwoLevels

variable {A₁ S₁ C₁ E₁ D₁ A₂ S₂ C₂ E₂ D₂ A₃ S₃ C₃ E₃ D₃ W : Type u}
variable {P₁ : Process A₁ S₁ C₁ E₁ D₁}
variable {P₂ : Process A₂ S₂ C₂ E₂ D₂}
variable {P₃ : Process A₃ S₃ C₃ E₃ D₃}
variable {m₁ : C₁ → W → Prop} {m₂ : C₂ → W → Prop} {m₃ : C₃ → W → Prop}
variable {Candidate : W → Prop}
variable {r₁ : S₁ → D₁ → C₁} {r₂ : S₂ → D₂ → C₂} {r₃ : S₃ → D₃ → C₃}

/-- **Scale reuse for semantic answerability.**  A challenge answerable in a
member process remains answerable after crossing a faithful member→group
boundary and then a faithful group→higher-group boundary.  The second level
needs no new rule; it is the same preservation theorem applied again. -/
theorem answerable_through_two_levels
    (F₁₂ : Embedding P₁ P₂ m₁ m₂ Candidate r₁ r₂)
    (F₂₃ : Embedding P₂ P₃ m₂ m₃ Candidate r₂ r₃)
    {s : S₁} {a : A₁} {d : D₁} {ca : C₁}
    (h : Answerable P₁ m₁ Candidate r₁ s a d ca) :
    Answerable P₃ m₃ Candidate r₃ (F₂₃.state (F₁₂.state s))
      (F₂₃.agent (F₁₂.agent a)) (F₂₃.decision (F₁₂.decision d))
      (F₂₃.claim (F₁₂.claim ca)) := by
  exact F₂₃.answerable_preserved (F₁₂.answerable_preserved h)

end TwoLevels

end Anchored.SemanticComposition
