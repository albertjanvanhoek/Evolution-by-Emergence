import AnchoredEvolution.Semantics

/-!
# Layer 1d: answering graphs, evidence, content tracking, best-case cost

Four refinements, each ending in at least one result that is not a
restatement of a definition.

1. **The correction graph built from answers.**  An edge `a → b` now means that
   `a`'s view can get a decision restricting `b` *answered*, not merely
   revised.  Under record discipline this is a subgraph of the Layer-1b graph
   of responsive edges.  So a correctable answer graph implies a correctable
   response graph (`answer_correctable_implies_correctable`).  A participant
   whose view can be answered nowhere breaks correctability
   (`unanswered_voice_breaks`).

2. **Evidence.**  Candidate worlds now depend on the state, and presenting
   evidence narrows them.
   * The candidate set only shrinks along runs (`candidates_shrink`).
   * A scenario leaves the candidate set only through a step that presents
     evidence (`scenario_removed_only_by_evidence`).  Layer 1 said certainty
     cannot remove liveness; here, operationally, only evidence can.
   * Evidence can legitimately settle a room: `evidence_settles_room`.

3. **Content tracking (causal responsiveness).**  A family of processes indexed
   by the content of the challenge.  The process *tracks* view `v` when:
   * some answer admits `v`; and
   * every record reachable after the challenge changes minimally toward `v`:
     it opens only worlds where the old record or `v` holds.
   The main result is **`content_insensitive_cannot_track`**.  If the process
   does not depend on what was said, it cannot track two incompatible views
   that the current record excludes.  The anchor (incompatibility of the
   rival views) does the work.
   * `always_inclusive_answers_but_does_not_track`: an authority that always
     revises to "anything goes" answers every challenge, yet fails minimal
     change.  So answerable is strictly weaker than tracking.
   * `tracking_witness`: a content-sensitive process that tracks both rival
     views.

4. **Best-case cost and time.**
   * Least cost and least time exist whenever correction is responsive
     (`least_cost_exists`, `least_time_exists`; classical).
   * They can be achieved only by *different* runs (`cost_time_tradeoff`).
     The honest object is the set of achievable (time, cost) pairs, not one
     number.
-/

universe u

namespace Anchored.Tracking

open LearningConstitution Operational Semantic

/-! ## 1. The answer graph -/

section AnswerGraph

variable {Agent State Claim Evidence Decision World : Type u}
variable (P : Process Agent State Claim Evidence Decision)
variable (meaning : Claim → World → Prop) (Candidate : World → Prop)
variable (record : State → Decision → Claim) (view : Agent → Claim)

/-- Answer edge: some decision restricting `b` can be answered with respect to
`a`'s view through `a`'s own challenge. -/
def AnswerEdge (s : State) (a b : Agent) : Prop :=
  ∃ d, P.restricts s d b ∧ Answerable P meaning Candidate record s a d (view a)

/-- The answer graph at state `s`, as an anchored system. -/
def answerSystem (s : State) : System.{u} where
  Node := Agent
  Edge := AnswerEdge P meaning Candidate record view s

variable {P meaning Candidate record view}

/-- Under record discipline, with static decision claims agreeing with the
current records, and with current records excluding the views they restrict,
every answer edge is a responsive edge. -/
theorem answer_edge_is_responsive_edge (s : State)
    (hdisc : RecordDiscipline P record)
    (hclaim : ∀ d, P.claimOf d = record s d)
    (hex : ∀ d a b, P.restricts s d b → Excludes meaning Candidate record s d (view a))
    {a b : Agent} (h : AnswerEdge P meaning Candidate record view s a b) :
    P.CorrectionEdge s a b := by
  obtain ⟨d, hr, hans⟩ := h
  have hresp := answerable_implies_responsive hdisc (hex d a b hr) hans
  refine ⟨P.claimOf d, Or.inl ⟨d, hr, rfl⟩, ?_⟩
  rw [hclaim d]
  exact hresp

/-- **A correctable answer graph implies a correctable response graph.**  The
answer graph is the stronger requirement. -/
theorem answer_correctable_implies_correctable (s : State)
    (hdisc : RecordDiscipline P record)
    (hclaim : ∀ d, P.claimOf d = record s d)
    (hex : ∀ d a b, P.restricts s d b → Excludes meaning Candidate record s d (view a))
    (h : (answerSystem P meaning Candidate record view s).Correctable) :
    (P.correctionSystem s).Correctable :=
  fun a b => Reach.simulate
    (fun _ _ e => Reach.single (answer_edge_is_responsive_edge s hdisc hclaim hex e))
    (h a b)

/-- **An unanswered voice breaks correctability.**  If `a`'s view can be
answered on no decision restricting anyone, and `a` has a peer, the answer
graph is not correctable. -/
theorem unanswered_voice_breaks (s : State) {a b : Agent} (hab : a ≠ b)
    (hnone : ∀ d x, P.restricts s d x →
      ¬ Answerable P meaning Candidate record s a d (view a)) :
    ¬ (answerSystem P meaning Candidate record view s).Correctable :=
  sealing_breaks (E := AnswerEdge P meaning Candidate record view s) hab
    (fun x ⟨d, hr, hans⟩ => hnone d x hr hans)

end AnswerGraph

/-! ## 2. Evidence narrows the candidate worlds -/

section Evidence

variable {Agent State Claim Evidence Decision World : Type u}
variable (P : Process Agent State Claim Evidence Decision)
variable (cand : State → World → Prop) (evMeaning : Evidence → World → Prop)

/-- **Evidence discipline.**  A step presenting evidence `e` restricts the
candidate worlds to those where `e` holds.  Every other step leaves them
unchanged.  Certainty, assertion, challenge and revision do not remove
scenarios. -/
def EvidenceDiscipline : Prop :=
  ∀ s v t, P.step s v t →
    (∀ w, cand t w ↔ cand s w) ∨
    ∃ a e, v = .presentEvidence a e ∧ ∀ w, (cand t w ↔ cand s w ∧ evMeaning e w)

/-- Presenting evidence narrows the candidate worlds to those where it holds. -/
def EvidenceNarrows : Prop :=
  ∀ s a e t, P.step s (.presentEvidence a e) t → ∀ w, (cand t w ↔ cand s w ∧ evMeaning e w)

variable {P cand evMeaning}

/-- The candidate set only shrinks along runs. -/
theorem candidates_shrink (hdisc : EvidenceDiscipline P cand evMeaning) :
    ∀ {s t : State} {n k : Nat}, P.Run s t n k → ∀ w, cand t w → cand s w := by
  intro s t n k hrun
  induction hrun with
  | nil _ => exact fun _ h => h
  | @cons s₀ t₀ w₀ v _ _ hstep _ ih =>
      intro w hw
      have ht := ih w hw
      rcases hdisc s₀ v t₀ hstep with hsame | ⟨_, _, _, hev⟩
      · exact (hsame w).1 ht
      · exact ((hev w).1 ht).1

/-- **A scenario leaves the candidate set only through evidence.**  If a world
is a candidate at the start of a run and not at its end, some step in the run
presents evidence. -/
theorem scenario_removed_only_by_evidence (hdisc : EvidenceDiscipline P cand evMeaning) :
    ∀ {s t : State} {n k : Nat}, P.Run s t n k → ∀ w, cand s w → ¬ cand t w →
      ∃ x y a e, P.step x (.presentEvidence a e) y := by
  intro s t n k hrun
  induction hrun with
  | nil _ => exact fun _ h hn => absurd h hn
  | @cons s₀ t₀ w₀ v _ _ hstep _ ih =>
      intro w hs hnt
      rcases hdisc s₀ v t₀ hstep with hsame | ⟨a, e, hv, _⟩
      · exact ih w ((hsame w).2 hs) hnt
      · subst hv
        exact ⟨s₀, t₀, a, e, hstep⟩

/-- **Evidence can settle a room.**  Suppose evidence `e` is false wherever view
`vb` holds, but true in some candidate world where view `va` holds.  After the
evidence step, `vb` is no longer live and `va` still is.  This is the
legitimate way to rule out a scenario, which certainty alone could not do
(Layer 1). -/
theorem evidence_settles_room {Claim : Type u} (meaning : Claim → World → Prop)
    {s t : State} {a : Agent} {e : Evidence} {va vb : Claim}
    (hnarrow : EvidenceNarrows P cand evMeaning)
    (hstep : P.step s (.presentEvidence a e) t)
    (hkills : ∀ w, evMeaning e w → ¬ meaning vb w)
    (hkeeps : ∃ w, cand s w ∧ evMeaning e w ∧ meaning va w) :
    ¬ LiveClaim meaning (cand t) vb ∧ LiveClaim meaning (cand t) va := by
  have hev := hnarrow s a e t hstep
  refine ⟨?_, ?_⟩
  · rintro ⟨w, hw, hb⟩
    exact hkills w ((hev w).1 hw).2 hb
  · obtain ⟨w, hs, he, ha⟩ := hkeeps
    exact ⟨w, (hev w).2 ⟨hs, he⟩, ha⟩

end Evidence

/-! ## 3. Content tracking -/

section ContentTracking

variable {Agent State Claim Evidence Decision World : Type u}
variable (meaning : Claim → World → Prop) (Candidate : World → Prop)

/-- The new record `r'` changes minimally toward view `v` relative to old
record `r`: it opens only worlds where `r` or `v` already held. -/
def MinimalToward (r r' v : Claim) : Prop :=
  ∀ w, Candidate w → meaning r' w → meaning r w ∨ meaning v w

variable (Pf : Claim → Process Agent State Claim Evidence Decision)
variable (recf : Claim → State → Decision → Claim)

/-- States reachable after `a`'s challenge, when the challenge carries view `v`. -/
def AfterChallenge (v : Claim) (s : State) (a : Agent) (d : Decision) (t : State) : Prop :=
  ∃ t₁ n k, (Pf v).step s (.challenge a (recf v s d)) t₁ ∧ (Pf v).Run t₁ t n k

/-- **Tracking.**  With the challenge carrying view `v`:
* some reachable record admits `v` (the challenge can be answered);
* every reachable record changes minimally toward `v` (no answer throws away
  more than the challenge undermines). -/
def Tracks (v : Claim) (s : State) (a : Agent) (d : Decision) : Prop :=
  (∃ t, AfterChallenge Pf recf v s a d t ∧
      Compatible meaning Candidate (recf v t d) v) ∧
  (∀ t, AfterChallenge Pf recf v s a d t →
      MinimalToward meaning Candidate (recf v s d) (recf v t d) v)

/-- The process and its records do not depend on the content of the challenge. -/
def ContentInsensitive : Prop :=
  ∀ v v', Pf v = Pf v' ∧ recf v = recf v'

variable {meaning Candidate Pf recf}

/-- Record-level core: a record that changes minimally toward `v₂` cannot admit
a view `v₁` that is incompatible with `v₂` and excluded by the old record. -/
theorem minimal_toward_rival_blocks {r r' v₁ v₂ : Claim}
    (hinc : Incompatible meaning Candidate v₁ v₂)
    (hex : Incompatible meaning Candidate r v₁)
    (hmin : MinimalToward meaning Candidate r r' v₂) :
    ¬ Compatible meaning Candidate r' v₁ := by
  rintro ⟨w, hw, hr', hv₁⟩
  rcases hmin w hw hr' with hr | hv₂
  · exact hex w hw ⟨hr, hv₁⟩
  · exact hinc w hw ⟨hv₁, hv₂⟩

/-- **The challenge must matter.**  A content-insensitive process cannot track
two incompatible views that the current record excludes.  Suppose it tracks
`v₁`: some reachable record admits `v₁`.  Because nothing depends on content,
that record is also reachable when the challenge carries `v₂`, so it must
change minimally toward `v₂`.  By the anchor (incompatibility of `v₁` and
`v₂`) and the exclusion, it cannot then admit `v₁`. -/
theorem content_insensitive_cannot_track (hins : ContentInsensitive Pf recf)
    {s : State} {a : Agent} {d : Decision} {v₁ v₂ : Claim}
    (hinc : Incompatible meaning Candidate v₁ v₂)
    (hex : Incompatible meaning Candidate (recf v₁ s d) v₁)
    (h₁ : Tracks meaning Candidate Pf recf v₁ s a d)
    (h₂ : Tracks meaning Candidate Pf recf v₂ s a d) : False := by
  obtain ⟨⟨t, hafter, hadm⟩, _⟩ := h₁
  obtain ⟨hP, hR⟩ := hins v₁ v₂
  have hafter₂ : AfterChallenge Pf recf v₂ s a d t := by
    obtain ⟨t₁, n, k, hs, hr⟩ := hafter
    exact ⟨t₁, n, k, hP ▸ hR ▸ hs, hP ▸ hr⟩
  have hmin := h₂.2 t hafter₂
  rw [← hR] at hmin
  exact minimal_toward_rival_blocks hinc hex hmin hadm

/-- Tracking implies answerability for the process indexed by that content. -/
theorem tracks_implies_answerable {v : Claim} {s : State} {a : Agent} {d : Decision}
    (h : Tracks meaning Candidate Pf recf v s a d) :
    Answerable (Pf v) meaning Candidate (recf v) s a d v := by
  obtain ⟨⟨t, ⟨t₁, n, k, hs, hr⟩, hadm⟩, _⟩ := h
  exact ⟨n + 1, _, t₁, t, n, k, hs, hr, hadm, Nat.le_refl _, Nat.le_refl _⟩

end ContentTracking

/-! ### Witnesses: the always-inclusive authority and a tracking process -/

section TrackingWitnesses

/-- Claims: the current `policy`; two rival `view1`, `view2`; the minimal
answers `policyOr1`, `policyOr2`; and `anything`. -/
inductive TC
  | policy | view1 | view2 | policyOr1 | policyOr2 | anything
  deriving DecidableEq

/-- Worlds: 0 the policy is right, 1 view 1 is right, 2 view 2 is right. -/
def tcMeaning : TC → Fin 3 → Prop
  | .policy, w => w = 0
  | .view1, w => w = 1
  | .view2, w => w = 2
  | .policyOr1, w => w ≠ 2
  | .policyOr2, w => w ≠ 1
  | .anything, _ => True

def tcCandidate (_ : Fin 3) : Prop := True

inductive TS
  | open_ | filed | revised

/-- The same desk for every content: challenge, then revision. -/
def tcDesk : Process Unit TS TC Unit Unit where
  step := fun s v t =>
    (s = .open_ ∧ v = .challenge () .policy ∧ t = .filed) ∨
    (s = .filed ∧ v = .revise .policy ∧ t = .revised)
  cost := fun _ _ _ => 1
  affected := fun _ _ => True
  sharedClaim := fun _ _ => True
  excluded := fun _ _ => False
  groundsForReview := fun _ _ => False
  sameStanding := fun _ _ _ => True
  restricts := fun _ _ _ => True
  claimOf := fun _ => .policy

theorem tc_after_states {v : TC} {rec : TC → TS → Unit → TC}
    (hr0 : ∀ v, rec v .open_ () = .policy) {t : TS}
    (h : AfterChallenge (fun _ => tcDesk) rec v .open_ () () t) :
    t = .filed ∨ t = .revised := by
  obtain ⟨t₁, n, k, hs, hr⟩ := h
  rw [hr0] at hs
  have ht₁ : t₁ = .filed := by
    rcases hs with ⟨_, _, h⟩ | ⟨h, _⟩
    · exact h
    · cases h
  subst ht₁
  cases hr with
  | nil => exact Or.inl rfl
  | cons hs' hr' =>
      rcases hs' with ⟨h, _⟩ | ⟨_, _, ht⟩
      · cases h
      · subst ht
        cases hr' with
        | nil => exact Or.inr rfl
        | cons hs'' _ => rcases hs'' with ⟨h, _⟩ | ⟨h, _⟩ <;> cases h

/-- The always-inclusive authority: whatever is said, it revises to "anything". -/
def inclusiveRec : TC → TS → Unit → TC
  | _, .revised, _ => .anything
  | _, _, _ => .policy

/-- **Answers everything, tracks nothing.**  The always-inclusive authority
answers a challenge carrying `view1`, but does not track it: its answer also
opens world 2, where neither the policy nor view 1 holds. -/
theorem always_inclusive_answers_but_does_not_track :
    Answerable tcDesk tcMeaning tcCandidate (inclusiveRec .view1) .open_ () () .view1 ∧
    ¬ Tracks tcMeaning tcCandidate (fun _ => tcDesk) inclusiveRec .view1 .open_ () () := by
  constructor
  · exact ⟨2, 2, .filed, .revised, 1, 1, Or.inl ⟨rfl, rfl, rfl⟩,
      Process.Run.cons (Or.inr ⟨rfl, rfl, rfl⟩) (Process.Run.nil _),
      ⟨1, trivial, trivial, rfl⟩, by decide, by decide⟩
  · rintro ⟨_, hmin⟩
    have hafter : AfterChallenge (fun _ => tcDesk) inclusiveRec .view1 .open_ () () .revised :=
      ⟨.filed, 1, 1, Or.inl ⟨rfl, rfl, rfl⟩,
        Process.Run.cons (Or.inr ⟨rfl, rfl, rfl⟩) (Process.Run.nil _)⟩
    have := hmin .revised hafter 2 trivial trivial
    simp [tcMeaning, inclusiveRec] at this

/-- A content-sensitive authority: it revises to "policy or what you said". -/
def trackingRec : TC → TS → Unit → TC
  | .view1, .revised, _ => .policyOr1
  | .view2, .revised, _ => .policyOr2
  | _, .revised, _ => .anything
  | _, _, _ => .policy

theorem trackingRec_open : ∀ v, trackingRec v .open_ () = .policy := by
  intro v; cases v <;> rfl

theorem inclusiveRec_open : ∀ v, inclusiveRec v .open_ () = .policy := by
  intro v; cases v <;> rfl

/-- **Tracking witness.**  The content-sensitive authority tracks both rival
views. -/
theorem tracking_witness :
    Tracks tcMeaning tcCandidate (fun _ => tcDesk) trackingRec .view1 .open_ () () ∧
    Tracks tcMeaning tcCandidate (fun _ => tcDesk) trackingRec .view2 .open_ () () := by
  have hafter : ∀ v, AfterChallenge (fun _ => tcDesk) trackingRec v .open_ () () .revised :=
    fun v => ⟨.filed, 1, 1, by rw [trackingRec_open]; exact Or.inl ⟨rfl, rfl, rfl⟩,
      Process.Run.cons (Or.inr ⟨rfl, rfl, rfl⟩) (Process.Run.nil _)⟩
  refine ⟨⟨⟨.revised, hafter _, ⟨1, trivial, by simp [trackingRec, tcMeaning], rfl⟩⟩, ?_⟩,
          ⟨⟨.revised, hafter _, ⟨2, trivial, by simp [trackingRec, tcMeaning], rfl⟩⟩, ?_⟩⟩
  · intro t ht w _ hw
    rcases tc_after_states trackingRec_open ht with h | h <;> subst h
    · exact Or.inl hw
    · simp [trackingRec, tcMeaning] at hw ⊢; omega
  · intro t ht w _ hw
    rcases tc_after_states trackingRec_open ht with h | h <;> subst h
    · exact Or.inl hw
    · simp [trackingRec, tcMeaning] at hw ⊢; omega

/-- The two rival views are incompatible and both excluded by the policy, so
`content_insensitive_cannot_track` applies: the always-inclusive authority is
content-insensitive, and no content-insensitive authority tracks both. -/
theorem tc_rivals :
    Incompatible tcMeaning tcCandidate .view1 .view2 ∧
    Incompatible tcMeaning tcCandidate .policy .view1 ∧
    ContentInsensitive (fun _ : TC => tcDesk) inclusiveRec := by
  refine ⟨?_, ?_, fun _ _ => ⟨rfl, by funext s d; cases s <;> rfl⟩⟩
  · intro w _ ⟨h1, h2⟩; simp [tcMeaning] at h1 h2; omega
  · intro w _ ⟨h1, h2⟩; simp [tcMeaning] at h1 h2; omega

end TrackingWitnesses

/-! ## 4. Best-case cost and time -/

section BestCase

/-- Least element of a satisfiable predicate on `Nat` (classical). -/
theorem exists_least {p : Nat → Prop} (h : ∃ n, p n) :
    ∃ m, p m ∧ ∀ m', m' < m → ¬ p m' := by
  classical
  obtain ⟨n, hn⟩ := h
  induction n using Nat.strongRecOn with
  | ind n ih =>
      by_cases hlt : ∃ m', m' < n ∧ p m'
      · obtain ⟨m', hm', hp⟩ := hlt
        exact ih m' hm' hp
      · exact ⟨n, hn, fun m' hm' hp => hlt ⟨m', hm', hp⟩⟩

variable {Agent State Claim Evidence Decision : Type u}
variable {P : Process Agent State Claim Evidence Decision}

/-- **Least correction cost exists** whenever correction is responsive. -/
theorem least_cost_exists {s : State} {a : Agent} {c : Claim}
    (h : P.Responsive s a c) :
    ∃ K, (∃ T, P.CorrectionWithin s a c T K) ∧
      ∀ K', K' < K → ¬ ∃ T, P.CorrectionWithin s a c T K' := by
  obtain ⟨T, K, hc⟩ := h
  exact exists_least ⟨K, T, hc⟩

/-- **Least correction time exists** whenever correction is responsive. -/
theorem least_time_exists {s : State} {a : Agent} {c : Claim}
    (h : P.Responsive s a c) :
    ∃ T, (∃ K, P.CorrectionWithin s a c T K) ∧
      ∀ T', T' < T → ¬ ∃ K, P.CorrectionWithin s a c T' K := by
  obtain ⟨T, K, hc⟩ := h
  exact exists_least ⟨T, K, hc⟩

end BestCase

section Tradeoff

/-- Two routes to revision after a challenge: a fast expensive one and a slow
cheap one. -/
inductive TT
  | start | heard | discussed | done
  deriving DecidableEq

def tradeoffDesk : Process Unit TT Unit Unit Unit where
  step := fun s v t =>
    (s = .start ∧ v = .challenge () () ∧ t = .heard) ∨
    (s = .heard ∧ v = .revise () ∧ t = .done) ∨
    (s = .heard ∧ v = .respond () () ∧ t = .discussed) ∨
    (s = .discussed ∧ v = .revise () ∧ t = .done)
  cost := fun s _ t => if s = .heard ∧ t = .done then 10 else 1
  affected := fun _ _ => True
  sharedClaim := fun _ _ => True
  excluded := fun _ _ => False
  groundsForReview := fun _ _ => False
  sameStanding := fun _ _ _ => True
  restricts := fun _ _ _ => True
  claimOf := fun _ => ()

/-- **Fastest and cheapest are different runs.**  Correction is possible in 2
steps at cost 11, and in 3 steps at cost 3, but not in 2 steps at cost 3.  The
least time (2) and the least cost (3) are attained by different runs, so the
honest object is the set of achievable (time, cost) pairs. -/
theorem cost_time_tradeoff :
    tradeoffDesk.CorrectionWithin .start () () 2 11 ∧
    tradeoffDesk.CorrectionWithin .start () () 3 3 ∧
    ¬ tradeoffDesk.CorrectionWithin .start () () 2 3 := by
  refine ⟨⟨.heard, .heard, .done, 0, 0, Or.inl ⟨rfl, rfl, rfl⟩, Process.Run.nil _,
      Or.inr (Or.inl ⟨rfl, rfl, rfl⟩), by decide, by decide⟩,
    ⟨.heard, .discussed, .done, 1, 1, Or.inl ⟨rfl, rfl, rfl⟩,
      Process.Run.cons (Or.inr (Or.inr (Or.inl ⟨rfl, rfl, rfl⟩))) (Process.Run.nil _),
      Or.inr (Or.inr (Or.inr ⟨rfl, rfl, rfl⟩)), by decide, by decide⟩, ?_⟩
  rintro ⟨t₁, t₂, t₃, n, k, h1, hr, h3, hn, hk⟩
  have ht₁ : t₁ = .heard := by
    rcases h1 with ⟨_, _, h⟩ | ⟨h, _⟩ | ⟨h, _⟩ | ⟨h, _⟩
    · exact h
    all_goals cases h
  subst ht₁
  have hn0 : n = 0 := by omega
  subst hn0
  cases hr with
  | nil =>
      have ht₃ : t₃ = .done := by
        rcases h3 with ⟨h, _⟩ | ⟨_, _, h⟩ | ⟨_, h, _⟩ | ⟨h, _⟩
        · cases h
        · exact h
        · cases h
        · cases h
      subst ht₃
      simp [tradeoffDesk] at hk

end Tradeoff

end Anchored.Tracking
