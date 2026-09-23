import AnchoredEvolution.UnifiedTracking

/-!
# Dynamic evidence-aware resolution

The earlier semantic layer used one fixed candidate-world set during a run.
`Tracking.lean` then proved that, under evidence discipline, candidate worlds
can disappear only through evidence. This file joins those ideas.

A challenge is **resolved** at a later state in exactly one of two ways:

1. the challenged record admits the view while that view remains live; or
2. the view is no longer live under the evidence available at that later state.

The second case is not a procedural escape hatch. If the view was live at the
start and the later state is reachable, evidence discipline implies that some
present-evidence step occurred on the route. Thus the full learning rule is:

* accommodate a still-live possibility, or
* acquire evidence that removes it from the live set.
-/

universe u

namespace Anchored.DynamicEvidence

open LearningConstitution Operational Semantic Tracking

section Resolution

variable {State Claim Decision World : Type u}

/-- A view is resolved at state `t` when the current record admits it, or when
new evidence has made the view no longer live. -/
def ResolvedAt (meaning : Claim → World → Prop) (cand : State → World → Prop)
    (record : State → Decision → Claim) (t : State) (d : Decision) (v : Claim) : Prop :=
  Compatible meaning (cand t) (record t d) v ∨ ¬ LiveClaim meaning (cand t) v

/-- If the view is still live, resolution is exactly semantic admission. -/
theorem resolved_of_live_iff_admits {meaning : Claim → World → Prop}
    {cand : State → World → Prop} {record : State → Decision → Claim}
    {t : State} {d : Decision} {v : Claim}
    (hlive : LiveClaim meaning (cand t) v) :
    ResolvedAt meaning cand record t d v ↔
      Compatible meaning (cand t) (record t d) v := by
  constructor
  · rintro (hadm | hdead)
    · exact hadm
    · exact False.elim (hdead hlive)
  · exact fun hadm => Or.inl hadm

/-- A genuinely refuted view is resolved without requiring the record to adopt
or admit it. -/
theorem not_live_is_resolved {meaning : Claim → World → Prop}
    {cand : State → World → Prop} {record : State → Decision → Claim}
    {t : State} {d : Decision} {v : Claim}
    (hdead : ¬ LiveClaim meaning (cand t) v) :
    ResolvedAt meaning cand record t d v :=
  Or.inr hdead

end Resolution

section DynamicAnswer

variable {Agent State Claim Evidence Decision World : Type u}
variable (P : Process Agent State Claim Evidence Decision)
variable (meaning : Claim → World → Prop) (cand : State → World → Prop)
variable (record : State → Decision → Claim)

/-- Evidence-aware answerability within time and cost bounds. The challenge must
execute, and its continuation must reach a state where the view is resolved. -/
def DynamicAnswerWithin (s : State) (a : Agent) (d : Decision) (v : Claim)
    (T K : Nat) : Prop :=
  ∃ t₁ t n k,
    P.step s (.challenge a (record s d)) t₁ ∧ P.Run t₁ t n k ∧
    ResolvedAt meaning cand record t d v ∧
    n + 1 ≤ T ∧ P.cost s (.challenge a (record s d)) t₁ + k ≤ K

/-- A challenge is dynamically answerable when it can be resolved at some
finite time and cost. -/
def DynamicAnswerable (s : State) (a : Agent) (d : Decision) (v : Claim) : Prop :=
  ∃ T K, DynamicAnswerWithin P meaning cand record s a d v T K

variable {P meaning cand record}

/-- Ordinary semantic answerability is the special case where the candidate
set does not change during the run. -/
theorem answerWithin_implies_dynamic_static {Candidate : World → Prop}
    {s : State} {a : Agent} {d : Decision} {v : Claim} {T K : Nat}
    (h : AnswerWithin P meaning Candidate record s a d v T K) :
    DynamicAnswerWithin P meaning (fun _ => Candidate) record s a d v T K := by
  obtain ⟨t₁, t, n, k, hchallenge, hrun, hadmits, hT, hK⟩ := h
  exact ⟨t₁, t, n, k, hchallenge, hrun, Or.inl hadmits, hT, hK⟩

/-- A route that ends by genuinely eliminating the challenged view from the
live set is dynamically answerable. -/
theorem evidential_refutation_answers {s : State} {a : Agent} {d : Decision}
    {v : Claim} {t₁ t : State} {n k T K : Nat}
    (hchallenge : P.step s (.challenge a (record s d)) t₁)
    (hrun : P.Run t₁ t n k)
    (hdead : ¬ LiveClaim meaning (cand t) v)
    (hT : n + 1 ≤ T)
    (hK : P.cost s (.challenge a (record s d)) t₁ + k ≤ K) :
    DynamicAnswerWithin P meaning cand record s a d v T K :=
  ⟨t₁, t, n, k, hchallenge, hrun, Or.inr hdead, hT, hK⟩

end DynamicAnswer

section EvidenceNecessity

variable {Agent State Claim Evidence Decision World : Type u}
variable {P : Process Agent State Claim Evidence Decision}
variable {meaning : Claim → World → Prop}
variable {cand : State → World → Prop} {evMeaning : Evidence → World → Prop}
variable {record : State → Decision → Claim}

/-- **The dynamic learning dichotomy.** Suppose a view is live initially, a
reachable later state resolves it, and candidate worlds obey evidence
discipline. Then either the later record admits the still-live view, or an
actual evidence-presenting step occurred along the route.

So a system cannot legitimately make a live challenge disappear merely by
procedure: if it does not accommodate the possibility, the run must contain
evidence that removes it. -/
theorem resolution_is_admission_or_evidence
    (hdisc : EvidenceDiscipline P cand evMeaning)
    {s t : State} {n k : Nat} {d : Decision} {v : Claim}
    (hrun : P.Run s t n k)
    (hlive0 : LiveClaim meaning (cand s) v)
    (hresolved : ResolvedAt meaning cand record t d v) :
    Compatible meaning (cand t) (record t d) v ∨
      ∃ x y a e, P.step x (.presentEvidence a e) y := by
  rcases hresolved with hadm | hdead
  · exact Or.inl hadm
  · right
    obtain ⟨w, hcs, hv⟩ := hlive0
    have hnct : ¬ cand t w := by
      intro hct
      exact hdead ⟨w, hct, hv⟩
    exact scenario_removed_only_by_evidence hdisc hrun w hcs hnct

/-- If a dynamically resolved view remains live, the record must admit it. This
prevents "evidence occurred somewhere" from being used as a substitute for
answering a view that the evidence did not actually refute. -/
theorem live_dynamic_resolution_requires_admission
    {t : State} {d : Decision} {v : Claim}
    (hlive : LiveClaim meaning (cand t) v)
    (hresolved : ResolvedAt meaning cand record t d v) :
    Compatible meaning (cand t) (record t d) v :=
  (resolved_of_live_iff_admits hlive).1 hresolved

end EvidenceNecessity

end Anchored.DynamicEvidence
