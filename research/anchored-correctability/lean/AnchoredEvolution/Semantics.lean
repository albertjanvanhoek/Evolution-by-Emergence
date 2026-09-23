import AnchoredEvolution.Operational

/-!
# Layer 1c: what represented claims mean, and when a revision answers a challenge

Step 1 made correction operational: a challenge is *responsive* when a run
starting with it reaches a revision.  But any revision counted, even one that
changes the wording and keeps excluding the challenger's view.  This layer
gives claims a meaning and connects them to the anchor.

**Meaning.**  A claim's content is the set of candidate worlds in which it
holds (`meaning c w`).
* *Holding* a claim is a property of an agent's state.
* *Truth* is a property of the world.
* The two are separate predicates.

**Results.**
1. **The anchor reaches represented claims.**
   - Agents' views with pairwise incompatible meanings satisfy the Layer-1
     anchor (`views_anchor`), so all Layer-1 theorems apply to them.
   - The Room's own first theorem applies verbatim to represented claims
     (`room_applies_to_represented_claims`).
2. **Perspective.**  One agent's rendering of another's claim is a translation.
   - Faithful translations preserve incompatibility exactly.
   - Strengthening translations preserve incompatibility but can
     *manufacture* it: "it is like a snake" rendered as "it is a snake"
     (`overgeneralization_manufactures_conflict`).
   - Weakening translations can *hide* a real conflict
     (`caricature_dissolves_conflict`).
3. **Answering.**  A decision's current record *admits* the challenger's view
   when some candidate world makes both true.
   - A challenge is *answerable* when a run starting with it reaches a state
     whose record admits the challenger's view.
   - Under record discipline, answerable implies responsive
     (`answerable_implies_responsive`), and the converse fails
     (`revised_but_unanswered`).  So the hierarchy is strict: answerable
     implies responsive, which implies permitted-and-revisable, with neither
     converse holding.
   - Under record discipline, answering requires an actual revision
     (`answer_requires_revision`).
4. **The Room's error, made operational.**  An unanswerable challenge from a
   live view fixes an error.  There is a candidate world where the challenger
   is right, and in *every* state the challenge can lead to, the decision is
   wrong there (`unanswerable_challenge_fixes_error`).
5. **The metamodel is under its own anchor.**  A claim about the correction
   procedure is a claim like any other, so it is not guaranteed while a rival
   self-model is live (`self_model_not_guaranteed`).  A sealed procedural rule
   falls under (4) (`sealed_rule_fixes_error`).
-/

universe u

namespace Anchored.Semantic

open LearningConstitution Operational

/-! ## 1. Meaning, incompatibility and the anchor on represented claims -/

section Meaning

variable {Claim World : Type u} (meaning : Claim → World → Prop)
  (Candidate : World → Prop)

/-- Two claims are incompatible: no candidate world makes both true. -/
def Incompatible (c c' : Claim) : Prop :=
  ∀ w, Candidate w → ¬ (meaning c w ∧ meaning c' w)

/-- A claim is live: some candidate world makes it true. -/
def LiveClaim (c : Claim) : Prop :=
  ∃ w, Candidate w ∧ meaning c w

/-- Two claims are compatible: some candidate world makes both true. -/
def Compatible (c c' : Claim) : Prop :=
  ∃ w, Candidate w ∧ meaning c w ∧ meaning c' w

variable {meaning Candidate}

theorem compatible_not_incompatible {c c' : Claim}
    (h : Compatible meaning Candidate c c') :
    ¬ Incompatible meaning Candidate c c' := by
  intro hi
  obtain ⟨w, hw, hc, hc'⟩ := h
  exact hi w hw ⟨hc, hc'⟩

variable {Agent : Type u}

/-- **The anchor on represented views.**  If distinct agents hold views with
incompatible meanings, the Layer-1 anchor holds for the models `w ↦ meaning
(view a) w`. -/
theorem views_anchor (view : Agent → Claim)
    (h : ∀ a b, a ≠ b → Incompatible meaning Candidate (view a) (view b)) :
    AnchorInEveryWorld (fun a w => meaning (view a) w) Candidate :=
  fun w hw a b hab hboth => h a b hab w hw hboth

/-- Liveness of views is liveness of the Layer-1 models. -/
theorem views_live (view : Agent → Claim)
    (h : ∀ a, LiveClaim meaning Candidate (view a)) :
    ∀ a, Live (fun a w => meaning (view a) w) Candidate a :=
  fun a => h a

/-- **No represented view can be treated as fact.**  Layer 1's no-guarantee
theorem, applied to the meanings of the views agents hold. -/
theorem represented_views_no_guarantee (view : Agent → Claim)
    (hinc : ∀ a b, a ≠ b → Incompatible meaning Candidate (view a) (view b))
    (hlive : ∀ a, LiveClaim meaning Candidate (view a))
    (hrival : ∀ a : Agent, ∃ b : Agent, b ≠ a) :
    ∀ a, ¬ Guaranteed (fun a w => meaning (view a) w) Candidate a :=
  open_room_no_guarantee (views_anchor view hinc) (views_live view hlive) hrival

end Meaning

/-! ## 2. The Room's first theorem applies to represented claims -/

section RoomLink

variable {Agent Claim World : Type u}

/-- Certainty interpreted through represented claims: agent `a` is certain of
`P` at world `w` when it holds a claim whose meaning at `w` is `P`. -/
def InterpretedCertain (meaning : Claim → World → Prop) (Holds : Agent → Claim → Prop)
    (w : World) (a : Agent) (P : Prop) : Prop :=
  ∃ c, Holds a c ∧ (P ↔ meaning c w)

/-- **The Room on represented claims.**  If `a` holds `c`, `b` holds `c'`, and
the two meanings cannot both hold at `w`, then at least one of them is
certain of a falsehood at `w`.  This uses `TheRoom.lean`'s own theorem,
unchanged, through the interpretation above. -/
theorem room_applies_to_represented_claims (meaning : Claim → World → Prop)
    (Holds : Agent → Claim → Prop) (w : World) {a b : Agent} {c c' : Claim}
    (ha : Holds a c) (hb : Holds b c') (hinc : ¬ (meaning c w ∧ meaning c' w)) :
    (InterpretedCertain meaning Holds w a (meaning c w) ∧ ¬ meaning c w) ∨
      (InterpretedCertain meaning Holds w b (meaning c' w) ∧ ¬ meaning c' w) :=
  TheRoom.incompatible_certainties_force_error
    (InterpretedCertain meaning Holds w) a b (meaning c w) (meaning c' w)
    ⟨c, ha, Iff.rfl⟩ ⟨c', hb, Iff.rfl⟩ hinc

end RoomLink

/-! ## 3. Perspective: translating another agent's claim -/

section Perspective

variable {Claim World : Type u} {meaning : Claim → World → Prop}
  {Candidate : World → Prop}

/-- The translation says at least as much as the original. -/
def Strengthening (meaning : Claim → World → Prop) (Candidate : World → Prop)
    (tr : Claim → Claim) : Prop :=
  ∀ c w, Candidate w → meaning (tr c) w → meaning c w

/-- The translation says at most as much as the original. -/
def Weakening (meaning : Claim → World → Prop) (Candidate : World → Prop)
    (tr : Claim → Claim) : Prop :=
  ∀ c w, Candidate w → meaning c w → meaning (tr c) w

/-- Faithful translation: same meaning in every candidate world. -/
def Faithful (meaning : Claim → World → Prop) (Candidate : World → Prop)
    (tr : Claim → Claim) : Prop :=
  Strengthening meaning Candidate tr ∧ Weakening meaning Candidate tr

theorem strengthening_preserves_incompatibility {tr : Claim → Claim}
    (h : Strengthening meaning Candidate tr) {c c' : Claim}
    (hi : Incompatible meaning Candidate c c') :
    Incompatible meaning Candidate (tr c) (tr c') :=
  fun w hw ⟨h1, h2⟩ => hi w hw ⟨h c w hw h1, h c' w hw h2⟩

theorem weakening_reflects_incompatibility {tr : Claim → Claim}
    (h : Weakening meaning Candidate tr) {c c' : Claim}
    (hi : Incompatible meaning Candidate (tr c) (tr c')) :
    Incompatible meaning Candidate c c' :=
  fun w hw ⟨h1, h2⟩ => hi w hw ⟨h c w hw h1, h c' w hw h2⟩

/-- **Faithful perspective change preserves incompatibility exactly.** -/
theorem faithful_preserves_incompatibility {tr : Claim → Claim}
    (h : Faithful meaning Candidate tr) (c c' : Claim) :
    Incompatible meaning Candidate (tr c) (tr c') ↔ Incompatible meaning Candidate c c' :=
  ⟨weakening_reflects_incompatibility h.2, strengthening_preserves_incompatibility h.1⟩

end Perspective

/-! ### The elephant, formally -/

section Elephant

/-- Parts of the parable: the flank is like a wall, the trunk is like a snake;
"only wall" and "only snake" are the over-generalizations. -/
inductive EClaim
  | wall | snake | onlyWall | onlySnake | anything

/-- Worlds: `0` the elephant, where wall and snake are both true of its parts;
`1` a wall-world; `2` a snake-world. -/
def eMeaning : EClaim → Fin 3 → Prop
  | .wall, w => w ≠ 2
  | .snake, w => w ≠ 1
  | .onlyWall, w => w = 1
  | .onlySnake, w => w = 2
  | .anything, _ => True

def eCandidate (_ : Fin 3) : Prop := True

/-- Over-generalizing translation: "like a wall" becomes "only a wall". -/
def overgeneralize : EClaim → EClaim
  | .wall => .onlyWall
  | .snake => .onlySnake
  | c => c

/-- **Over-generalization manufactures conflict.**  "Wall" and "snake" are
compatible (the elephant world makes both true).  The strengthening
translation turns them into incompatible claims.  Apparent incompatibility can
be produced by how one perspective renders another. -/
theorem overgeneralization_manufactures_conflict :
    Compatible eMeaning eCandidate .wall .snake ∧
    Strengthening eMeaning eCandidate overgeneralize ∧
    Incompatible eMeaning eCandidate (overgeneralize .wall) (overgeneralize .snake) := by
  refine ⟨⟨0, trivial, (by show (0 : Fin 3) ≠ 2; decide), (by show (0 : Fin 3) ≠ 1; decide)⟩, ?_, ?_⟩
  · intro c w _ h
    cases c <;> simp [overgeneralize, eMeaning] at h ⊢ <;> omega
  · intro w _ ⟨h1, h2⟩
    simp [overgeneralize, eMeaning] at h1 h2
    omega

/-- **A caricature hides a real conflict.**  "Only wall" and "only snake" are
incompatible.  Weakening both to "anything" makes them compatible. -/
theorem caricature_dissolves_conflict :
    Incompatible eMeaning eCandidate .onlyWall .onlySnake ∧
    Weakening eMeaning eCandidate (fun _ => EClaim.anything) ∧
    Compatible eMeaning eCandidate EClaim.anything EClaim.anything := by
  refine ⟨?_, fun _ _ _ _ => trivial, ⟨0, trivial, trivial, trivial⟩⟩
  intro w _ ⟨h1, h2⟩
  simp [eMeaning] at h1 h2
  omega

end Elephant

/-! ## 4. Answering: a revision that admits the challenger's view -/

section Answering

variable {Agent State Claim Evidence Decision World : Type u}
variable (P : Process Agent State Claim Evidence Decision)
variable (meaning : Claim → World → Prop) (Candidate : World → Prop)
variable (record : State → Decision → Claim)

/-- The current record of decision `d` at state `t` **admits** view `ca`: some
candidate world makes both true. -/
def Admits (t : State) (d : Decision) (ca : Claim) : Prop :=
  Compatible meaning Candidate (record t d) ca

/-- The current record excludes view `ca`: no candidate world makes both true. -/
def Excludes (t : State) (d : Decision) (ca : Claim) : Prop :=
  Incompatible meaning Candidate (record t d) ca

/-- **Answered within time `T` and cost `K`.**  Agent `a` challenges the current
record of `d`, and the continuation reaches a state whose record admits `a`'s
view `ca`. -/
def AnswerWithin (s : State) (a : Agent) (d : Decision) (ca : Claim) (T K : Nat) : Prop :=
  ∃ t₁ t n k,
    P.step s (.challenge a (record s d)) t₁ ∧ P.Run t₁ t n k ∧
    Admits meaning Candidate record t d ca ∧
    n + 1 ≤ T ∧ P.cost s (.challenge a (record s d)) t₁ + k ≤ K

/-- The challenge can be answered at some finite time and cost. -/
def Answerable (s : State) (a : Agent) (d : Decision) (ca : Claim) : Prop :=
  ∃ T K, AnswerWithin P meaning Candidate record s a d ca T K

/-- **Record discipline.**  A step changes the record of `d` only if it is a
revision of that record. -/
def RecordDiscipline : Prop :=
  ∀ s v t d, P.step s v t → record t d = record s d ∨ v = .revise (record s d)

variable {P meaning Candidate record}

/-- If a record admits a view that an earlier record excluded, the record has
changed. -/
theorem admits_after_excludes_changed {s t : State} {d : Decision} {ca : Claim}
    (hex : Excludes meaning Candidate record s d ca)
    (had : Admits meaning Candidate record t d ca) :
    ¬ record t d = record s d := by
  intro heq
  apply compatible_not_incompatible had
  unfold Excludes at hex
  rw [heq]
  exact hex

/-- Under record discipline, a run that ends with a different record contains a
revision step of the then-current record. -/
theorem record_change_needs_revision (hdisc : RecordDiscipline P record)
    {d : Decision} : ∀ {s t : State} {n k : Nat}, P.Run s t n k →
      ¬ record t d = record s d → ∃ x y, P.step x (.revise (record x d)) y := by
  intro s t n k hrun
  induction hrun with
  | nil _ => exact fun h => absurd rfl h
  | @cons s₀ t₀ w₀ v _ _ hstep _ ih =>
      intro hne
      cases hdisc s₀ v t₀ d hstep with
      | inl hsame =>
          exact ih (fun h => hne (h.trans hsame))
      | inr hv =>
          subst hv
          exact ⟨s₀, t₀, hstep⟩

/-- **Answering requires an actual revision.**  Under record discipline, if the
current record excludes the challenger's view and the challenge is answered,
some revision step occurs along the way.  Hearing alone does not answer. -/
theorem answer_requires_revision (hdisc : RecordDiscipline P record)
    {s : State} {a : Agent} {d : Decision} {ca : Claim} {T K : Nat}
    (hex : Excludes meaning Candidate record s d ca)
    (h : AnswerWithin P meaning Candidate record s a d ca T K) :
    ∃ x y, P.step x (.revise (record x d)) y := by
  obtain ⟨t₁, t, n, k, h1, hrun, had, _, _⟩ := h
  have hne := admits_after_excludes_changed hex had
  cases hdisc s _ t₁ d h1 with
  | inl hsame =>
      exact record_change_needs_revision hdisc hrun
        (fun h => hne (h.trans hsame))
  | inr hv => cases hv

/-- Under record discipline, a run whose final record differs from its initial
record reaches, while the record is still unchanged, a revision of exactly
the initial record. -/
theorem first_revision (hdisc : RecordDiscipline P record) {d : Decision} :
    ∀ {s t : State} {n k : Nat}, P.Run s t n k → ¬ record t d = record s d →
      ∃ x y n' k', P.Run s x n' k' ∧ n' ≤ n ∧ k' ≤ k ∧ record x d = record s d ∧
        P.step x (.revise (record s d)) y := by
  intro s t n k hrun
  induction hrun with
  | nil _ => exact fun h => absurd rfl h
  | @cons s₀ t₀ w₀ v n₀ k₀ hstep hrest ih =>
      intro hne
      cases hdisc s₀ v t₀ d hstep with
      | inl hsame =>
          obtain ⟨x, y, n', k', hrx, hn, hk, hrec, hrev⟩ :=
            ih (fun h => hne (h.trans hsame))
          refine ⟨x, y, n' + 1, P.cost s₀ v t₀ + k', Process.Run.cons hstep hrx,
            by omega, by omega, hrec.trans hsame, ?_⟩
          rw [← hsame]
          exact hrev
      | inr hv =>
          subst hv
          exact ⟨s₀, t₀, 0, 0, Process.Run.nil _, by omega, by omega, rfl, hstep⟩

/-- **Answerable implies responsive.**  Under record discipline, if the current
record excludes the challenger's view, an answered challenge is also
responsive in the Step-1 sense.  The run reaches a revision of the challenged
record, within the same time and cost bounds plus one revision step.  With
`revised_but_unanswered` below, the hierarchy is strict:
permitted ⊋ responsive ⊋ answerable. -/
theorem answerable_implies_responsive (hdisc : RecordDiscipline P record)
    {s : State} {a : Agent} {d : Decision} {ca : Claim}
    (hex : Excludes meaning Candidate record s d ca)
    (h : Answerable P meaning Candidate record s a d ca)
    : P.Responsive s a (record s d) := by
  obtain ⟨T, K, t₁, t, n, k, h1, hrun, had, _, _⟩ := h
  have hne := admits_after_excludes_changed hex had
  cases hdisc s _ t₁ d h1 with
  | inl hsame =>
      obtain ⟨x, y, n', k', hrx, _, _, _, hrev⟩ :=
        first_revision hdisc hrun (fun h => hne (h.trans hsame))
      rw [hsame] at hrev
      exact ⟨n' + 2, P.cost s (.challenge a (record s d)) t₁ + k' +
          P.cost x (.revise (record s d)) y,
        t₁, x, y, n', k', h1, hrx, hrev, Nat.le_refl _, Nat.le_refl _⟩
  | inr hv => cases hv

/-- **The Room's error, made operational (constructive).**  Suppose the
challenger's view `ca` is live and its challenge is unanswerable.  Then there is
a candidate world where the challenger is right, and in *every* state the
challenge can lead to, the decision's record is false in that world. -/
theorem unanswerable_challenge_fixes_error {s : State} {a : Agent} {d : Decision}
    {ca : Claim} (hlive : LiveClaim meaning Candidate ca)
    (hno : ¬ Answerable P meaning Candidate record s a d ca) :
    ∃ w, Candidate w ∧ meaning ca w ∧
      ∀ t₁ t n k, P.step s (.challenge a (record s d)) t₁ → P.Run t₁ t n k →
        ¬ meaning (record t d) w := by
  obtain ⟨w, hw, hca⟩ := hlive
  refine ⟨w, hw, hca, ?_⟩
  intro t₁ t n k h1 hrun hrec
  exact hno ⟨n + 1, P.cost s (.challenge a (record s d)) t₁ + k,
    t₁, t, n, k, h1, hrun, ⟨w, hw, hrec, hca⟩, Nat.le_refl _, Nat.le_refl _⟩

/-- **Executable form of the fixed-error theorem.**  If the challenge actually
executes, the witness is non-vacuous: there is a concrete post-challenge branch
and a live world in which every state reachable along that branch keeps the
decision record false. -/
theorem executable_unanswerable_challenge_fixes_error {s : State} {a : Agent}
    {d : Decision} {ca : Claim} (hlive : LiveClaim meaning Candidate ca)
    (hexec : ∃ t₁, P.step s (.challenge a (record s d)) t₁)
    (hno : ¬ Answerable P meaning Candidate record s a d ca) :
    ∃ w t₁, Candidate w ∧ meaning ca w ∧
      P.step s (.challenge a (record s d)) t₁ ∧
      ∀ t n k, P.Run t₁ t n k → ¬ meaning (record t d) w := by
  obtain ⟨w, hw, hca, hall⟩ :=
    unanswerable_challenge_fixes_error (P := P) (meaning := meaning)
      (Candidate := Candidate) (record := record) hlive hno
  obtain ⟨t₁, hstep⟩ := hexec
  refine ⟨w, t₁, hw, hca, hstep, ?_⟩
  intro t n k hrun
  exact hall t₁ t n k hstep hrun

end Answering

/-! ### Revised but unanswered: responsiveness is strictly weaker than answering -/

section RevisedButUnanswered

/-- Claims in the policy example: `policyA`, a reworded `policyA'` that still
excludes the challenger, an `inclusive` policy, and the challenger's `view`. -/
inductive Pol
  | policyA | policyA' | inclusive | view

/-- Worlds: `true` = the challenger is right; `false` = the policy is right. -/
def pMeaning : Pol → Bool → Prop
  | .policyA, w => w = false
  | .policyA', w => w = false
  | .inclusive, _ => True
  | .view, w => w = true

def pCandidate (_ : Bool) : Prop := True

inductive DeskS
  | open_ | filed | revised

/-- The rewording desk: a challenge is filed, and the filed record is revised,
but only to a rewording that still excludes the challenger. -/
def rewordingDesk : Process Unit DeskS Pol Unit Unit where
  step := fun s v t =>
    (s = .open_ ∧ v = .challenge () .policyA ∧ t = .filed) ∨
    (s = .filed ∧ v = .revise .policyA ∧ t = .revised)
  cost := fun _ _ _ => 1
  affected := fun _ _ => True
  sharedClaim := fun _ _ => True
  excluded := fun _ _ => False
  groundsForReview := fun _ _ => False
  sameStanding := fun _ _ _ => True
  restricts := fun _ _ _ => True
  claimOf := fun _ => .policyA

def rewordingRecord : DeskS → Unit → Pol
  | .revised, _ => .policyA'
  | _, _ => .policyA

theorem rewording_run_states {t : DeskS} {n k : Nat}
    (h : rewordingDesk.Run .filed t n k) : t = .filed ∨ t = .revised := by
  cases h with
  | nil => exact Or.inl rfl
  | cons hs hr =>
      rcases hs with ⟨h, _⟩ | ⟨_, _, ht⟩
      · cases h
      · subst ht
        cases hr with
        | nil => exact Or.inr rfl
        | cons hs' _ =>
            rcases hs' with ⟨h', _⟩ | ⟨h', _⟩ <;> cases h'

/-- **Revised but unanswered.**  The challenge is responsive in the Step-1
sense: it leads to a revision of `policyA`, within 2 steps at cost 2.  Yet it
is not answerable: no reachable record admits the challenger's view. -/
theorem revised_but_unanswered :
    rewordingDesk.Responsive .open_ () .policyA ∧
    ¬ Answerable rewordingDesk pMeaning pCandidate rewordingRecord .open_ () () .view := by
  constructor
  · exact ⟨2, 2, .filed, .filed, .revised, 0, 0, Or.inl ⟨rfl, rfl, rfl⟩,
      Process.Run.nil _, Or.inr ⟨rfl, rfl, rfl⟩, by decide, by decide⟩
  · rintro ⟨T, K, t₁, t, n, k, h1, hrun, ⟨w, _, hrec, hview⟩, _, _⟩
    have ht₁ : t₁ = .filed := by
      rcases h1 with ⟨_, _, h⟩ | ⟨h, _⟩
      · exact h
      · cases h
    subst ht₁
    rcases rewording_run_states hrun with ht | ht <;> subst ht <;>
      simp [rewordingRecord, pMeaning] at hrec hview <;> simp_all

/-- The answering desk: the filed challenge is revised to the inclusive policy. -/
def answeringDesk : Process Unit DeskS Pol Unit Unit :=
  { rewordingDesk with
    step := fun s v t =>
      (s = .open_ ∧ v = .challenge () .policyA ∧ t = .filed) ∨
      (s = .filed ∧ v = .revise .policyA ∧ t = .revised) }

def answeringRecord : DeskS → Unit → Pol
  | .revised, _ => .inclusive
  | _, _ => .policyA

/-- **Non-vacuity of answering.**  The challenge is answered within 2 steps at
cost 2.  Record discipline holds, the initial record excludes the challenger,
and so an actual revision was needed and made. -/
theorem answeringDesk_answers :
    AnswerWithin answeringDesk pMeaning pCandidate answeringRecord .open_ () () .view 2 2 ∧
    RecordDiscipline answeringDesk answeringRecord ∧
    Excludes pMeaning pCandidate answeringRecord .open_ () .view := by
  refine ⟨⟨.filed, .revised, 1, 1, Or.inl ⟨rfl, rfl, rfl⟩,
      Process.Run.cons (Or.inr ⟨rfl, rfl, rfl⟩) (Process.Run.nil _),
      ⟨true, trivial, trivial, rfl⟩, by decide, by decide⟩, ?_, ?_⟩
  · intro s v t d h
    rcases h with ⟨hs, _, ht⟩ | ⟨hs, hv, _⟩
    · subst hs; subst ht; exact Or.inl rfl
    · subst hs; subst hv; exact Or.inr rfl
  · intro w _ ⟨h1, h2⟩
    simp [answeringRecord, pMeaning] at h1 h2
    simp_all

end RevisedButUnanswered

/-! ## 5. The metamodel is subject to its own anchor -/

section SelfModel

variable {Claim World : Type u} {meaning : Claim → World → Prop}
  {Candidate : World → Prop}

/-- **Self-models are not guaranteed.**  Let `rule` be a claim about the
correction procedure itself (for example "challenges here are answered"), and
`rival` an incompatible self-model.  If the rival is live, `rule` is not
guaranteed.  The metamodel's claims about itself fall under the same anchor as
every other claim. -/
theorem self_model_not_guaranteed {rule rival : Claim}
    (hinc : Incompatible meaning Candidate rule rival)
    (hlive : LiveClaim meaning Candidate rival) :
    ¬ ∀ w, Candidate w → meaning rule w := by
  intro hg
  obtain ⟨w, hw, hr⟩ := hlive
  exact hinc w hw ⟨hg w hw, hr⟩

variable {Agent State Evidence Decision : Type u}
  {P : Process Agent State Claim Evidence Decision}
  {record : State → Decision → Claim}

/-- **A sealed procedural rule fixes an error.**  Let `d` be the decision that
records the procedure's own rule, and let a participant hold a live rival
self-model.  If that participant's challenge to the rule is unanswerable, there
is a live world where the rival is right and the rule is wrong in every state
the challenge can lead to.  The correction mechanism must itself remain
correctable, and here that is a theorem instance, not a slogan. -/
theorem sealed_rule_fixes_error {s : State} {a : Agent} {d : Decision}
    {rival : Claim} (hlive : LiveClaim meaning Candidate rival)
    (hno : ¬ Answerable P meaning Candidate record s a d rival) :
    ∃ w, Candidate w ∧ meaning rival w ∧
      ∀ t₁ t n k, P.step s (.challenge a (record s d)) t₁ → P.Run t₁ t n k →
        ¬ meaning (record t d) w :=
  unanswerable_challenge_fixes_error hlive hno

end SelfModel

end Anchored.Semantic
