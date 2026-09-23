/-! Vendored verbatim from albertjanvanhoek/Evolution-by-Emergence at commit a870788f13643643f22a1c978f424fc4dcccdbfa, path papers/the-room-learning-constitution/TheRoom.lean. No changes except this header. -/
/-!
# The Room: fallible certainty, interdependence, and a learning constitution

Conceptual purpose
------------------
This file isolates a small logical skeleton behind a proposed "constitution for
learning systems".

It separates four levels:

1. incompatible claims cannot all be true;
2. certainty is not, by itself, a truth guarantee;
3. interdependent agents with incompatible exclusive requirements need a
   procedure rather than unilateral epistemic authority;
4. a procedure that aims to remain correctable cannot make a potentially
   corrective source, or the restriction imposed on that source, permanently
   immune to correction.

The file does NOT prove any empirical claim about human cognition and does NOT
prove that any legal right ought to exist.  Those are interpretation and
normative layers outside the deductive core.

Status: candidate Lean 4 source; intended for machine checking after repository
integration.
-/

namespace TheRoom

universe u
variable {Agent : Type u}

/-! ## 1. The Room: incompatible claims -/

/-- Three propositions are pairwise incompatible when no two can be true together. -/
def PairwiseIncompatible3 (P Q R : Prop) : Prop :=
  ¬ (P ∧ Q) ∧ ¬ (P ∧ R) ∧ ¬ (Q ∧ R)

/-- At most one of three propositions is true. -/
def AtMostOneTrue3 (P Q R : Prop) : Prop :=
  ¬ ((P ∧ Q) ∨ (P ∧ R) ∨ (Q ∧ R))

/-- At least two of three propositions are false. -/
def AtLeastTwoFalse3 (P Q R : Prop) : Prop :=
  (¬ P ∧ ¬ Q) ∨ (¬ P ∧ ¬ R) ∨ (¬ Q ∧ ¬ R)

/-- Pairwise incompatible claims cannot contain two truths. -/
theorem pairwise_incompatible_at_most_one
    {P Q R : Prop}
    (h : PairwiseIncompatible3 P Q R) :
    AtMostOneTrue3 P Q R := by
  intro hTwo
  rcases hTwo with hPQ | hPR | hQR
  · exact h.1 hPQ
  · exact h.2.1 hPR
  · exact h.2.2 hQR

/-- With three pairwise incompatible claims, at least two are false. -/
theorem pairwise_incompatible_at_least_two_false
    {P Q R : Prop}
    (h : PairwiseIncompatible3 P Q R) :
    AtLeastTwoFalse3 P Q R := by
  classical
  by_cases hP : P
  · have hQ : ¬ Q := by
      intro hq
      exact h.1 ⟨hP, hq⟩
    have hR : ¬ R := by
      intro hr
      exact h.2.1 ⟨hP, hr⟩
    exact Or.inr (Or.inr ⟨hQ, hR⟩)
  · by_cases hQ : Q
    · have hR : ¬ R := by
        intro hr
        exact h.2.2 ⟨hQ, hr⟩
      exact Or.inr (Or.inl ⟨hP, hR⟩)
    · exact Or.inl ⟨hP, hQ⟩

/-! ## 2. Certainty is not a truth guarantee -/

/- `Certain a P` is left abstract: agent `a` is represented as certain of `P`. -/
variable (Certain : Agent → Prop → Prop)

/-- Every proposition of which `a` is certain is true. -/
def TruthGuaranteed (a : Agent) : Prop :=
  ∀ P : Prop, Certain a P → P

/--
If two agents are certain of incompatible propositions, at least one certainty
is attached to a false proposition.  The theorem does not determine which one.
-/
theorem incompatible_certainties_force_error
    (a b : Agent)
    (P Q : Prop)
    (hA : Certain a P)
    (hB : Certain b Q)
    (hInc : ¬ (P ∧ Q)) :
    (Certain a P ∧ ¬ P) ∨ (Certain b Q ∧ ¬ Q) := by
  classical
  by_cases hP : P
  · right
    constructor
    · exact hB
    · intro hQ
      exact hInc ⟨hP, hQ⟩
  · left
    exact ⟨hA, hP⟩

/-- Incompatible certainties cannot both be truth-guaranteed. -/
theorem incompatible_certainties_no_joint_truth_guarantee
    (a b : Agent)
    (P Q : Prop)
    (hA : Certain a P)
    (hB : Certain b Q)
    (hInc : ¬ (P ∧ Q)) :
    ¬ (TruthGuaranteed Certain a ∧ TruthGuaranteed Certain b) := by
  intro hBoth
  exact hInc ⟨hBoth.1 P hA, hBoth.2 Q hB⟩

/-!
Pure logic does not imply that observing another fallible agent makes the
observer fallible.  The symmetry bridge must therefore be explicit.
-/

/-- Agents of the same relevant epistemic standing do not receive asymmetric
truth guarantees merely by identity. -/
def NoPrivilegedTruthAccess
    (SameStanding : Agent → Agent → Prop) : Prop :=
  ∀ {a b : Agent},
    SameStanding a b →
    (TruthGuaranteed Certain a ↔ TruthGuaranteed Certain b)

/--
Under equal epistemic standing and no privileged truth access, two agents with
incompatible certainties cannot assign an infallibility guarantee to either peer.
-/
theorem same_standing_blocks_either_infallibility
    (SameStanding : Agent → Agent → Prop)
    (a b : Agent)
    (P Q : Prop)
    (hA : Certain a P)
    (hB : Certain b Q)
    (hInc : ¬ (P ∧ Q))
    (hSame : SameStanding a b)
    (hNoPrivilege : NoPrivilegedTruthAccess Certain SameStanding) :
    (¬ TruthGuaranteed Certain a) ∧ (¬ TruthGuaranteed Certain b) := by
  have hNoJoint :
      ¬ (TruthGuaranteed Certain a ∧ TruthGuaranteed Certain b) :=
    incompatible_certainties_no_joint_truth_guarantee Certain a b P Q hA hB hInc
  have hEq := hNoPrivilege hSame
  constructor
  · intro hGA
    exact hNoJoint ⟨hGA, hEq.mp hGA⟩
  · intro hGB
    exact hNoJoint ⟨hEq.mpr hGB, hGB⟩

end TheRoom


namespace Interdependence

universe u v
variable {Agent : Type u}
variable {Outcome : Type v}

/-- Agent `a` accepts exactly one required shared outcome. -/
def ExclusiveRequirement
    (Accepts : Agent → Outcome → Prop)
    (a : Agent)
    (required : Outcome) : Prop :=
  ∀ o : Outcome, Accepts a o ↔ o = required

/-- There exists an outcome acceptable to both agents. -/
def SharedAcceptableOutcome
    (Accepts : Agent → Outcome → Prop)
    (a b : Agent) : Prop :=
  ∃ o : Outcome, Accepts a o ∧ Accepts b o

/-- Different exclusive requirements leave no mutually acceptable outcome. -/
theorem incompatible_exclusive_requirements_block_shared_acceptance
    (Accepts : Agent → Outcome → Prop)
    (a b : Agent)
    (requiredA requiredB : Outcome)
    (hDifferent : requiredA ≠ requiredB)
    (hReqA : ExclusiveRequirement Accepts a requiredA)
    (hReqB : ExclusiveRequirement Accepts b requiredB) :
    ¬ SharedAcceptableOutcome Accepts a b := by
  intro hShared
  rcases hShared with ⟨o, hA, hB⟩
  have hoA : o = requiredA := (hReqA o).mp hA
  have hoB : o = requiredB := (hReqB o).mp hB
  apply hDifferent
  exact hoA.symm.trans hoB

end Interdependence


namespace Correctability

universe u v w
variable {Agent : Type u}
variable {Evidence : Type v}
variable {State : Type w}

/-- Source `b` could in principle supply evidence that corrects state `s`. -/
def PotentiallyCorrectiveFrom
    (Origin : Evidence → Agent)
    (WouldCorrect : State → Evidence → Prop)
    (b : Agent)
    (s : State) : Prop :=
  ∃ e : Evidence, Origin e = b ∧ WouldCorrect s e

/-- A corrective route is open when corrective evidence from `b` is admissible. -/
def HasCorrectiveRouteFrom
    (Origin : Evidence → Agent)
    (WouldCorrect : State → Evidence → Prop)
    (Admissible : Evidence → Prop)
    (b : Agent)
    (s : State) : Prop :=
  ∃ e : Evidence,
    Origin e = b ∧ WouldCorrect s e ∧ Admissible e

/-- Source-based permanent closure: nothing from `b` is admissible. -/
def PermanentlyExcluded
    (Origin : Evidence → Agent)
    (Admissible : Evidence → Prop)
    (b : Agent) : Prop :=
  ∀ e : Evidence, Origin e = b → ¬ Admissible e

/-- Every potentially corrective source retains at least one corrective route. -/
def SourceRobustlyCorrectableAt
    (Origin : Evidence → Agent)
    (WouldCorrect : State → Evidence → Prop)
    (Admissible : Evidence → Prop)
    (s : State) : Prop :=
  ∀ b : Agent,
    PotentiallyCorrectiveFrom Origin WouldCorrect b s →
    HasCorrectiveRouteFrom Origin WouldCorrect Admissible b s

/-- Permanent exclusion blocks every corrective route from that source. -/
theorem permanent_exclusion_blocks_corrective_route
    (Origin : Evidence → Agent)
    (WouldCorrect : State → Evidence → Prop)
    (Admissible : Evidence → Prop)
    (b : Agent)
    (s : State)
    (hExcluded : PermanentlyExcluded Origin Admissible b) :
    ¬ HasCorrectiveRouteFrom Origin WouldCorrect Admissible b s := by
  intro hRoute
  rcases hRoute with ⟨e, hOrigin, _, hAdmissible⟩
  exact (hExcluded e hOrigin) hAdmissible

/--
If a source could supply a correction but is permanently excluded, source-robust
correctability fails.  The theorem does not assume that the source is presently
right, only that corrective information from that source is possible.
-/
theorem possible_correction_plus_exclusion_breaks_robust_correctability
    (Origin : Evidence → Agent)
    (WouldCorrect : State → Evidence → Prop)
    (Admissible : Evidence → Prop)
    (b : Agent)
    (s : State)
    (hPossible : PotentiallyCorrectiveFrom Origin WouldCorrect b s)
    (hExcluded : PermanentlyExcluded Origin Admissible b) :
    ¬ SourceRobustlyCorrectableAt Origin WouldCorrect Admissible s := by
  intro hRobust
  have hRoute := hRobust b hPossible
  exact permanent_exclusion_blocks_corrective_route
    Origin WouldCorrect Admissible b s hExcluded hRoute

end Correctability


namespace LearningConstitution

universe uA uS uC uE uD
variable {Agent : Type uA}
variable {State : Type uS}
variable {Claim : Type uC}
variable {Evidence : Type uE}
variable {Decision : Type uD}

/-- Learning verbs are process operations, not truth values. -/
inductive Verb (Agent : Type uA) (Claim : Type uC) (Evidence : Type uE)
  | assertClaim     : Agent → Claim → Verb Agent Claim Evidence
  | challenge       : Agent → Claim → Verb Agent Claim Evidence
  | presentEvidence : Agent → Evidence → Verb Agent Claim Evidence
  | respond         : Agent → Claim → Verb Agent Claim Evidence
  | revise          : Claim → Verb Agent Claim Evidence
  | reopen          : Claim → Verb Agent Claim Evidence
  | repair          : Agent → Agent → Verb Agent Claim Evidence
  | appealExclusion : Agent → Verb Agent Claim Evidence
  | restoreAccess   : Agent → Verb Agent Claim Evidence

/-- Abstract interface of a shared learning process. -/
structure Interface
    (Agent : Type uA)
    (State : Type uS)
    (Claim : Type uC)
    (Evidence : Type uE)
    (Decision : Type uD) where
  affected : State → Agent → Prop
  sharedClaim : State → Claim → Prop
  excluded : State → Agent → Prop
  permitted : State → Verb Agent Claim Evidence → Prop
  groundsForReview : State → Claim → Prop
  sameStanding : State → Agent → Agent → Prop
  restricts : State → Decision → Agent → Prop
  canChallengeDecision : State → Agent → Decision → Prop
  canReviseDecision : State → Decision → Prop
  step : State → Verb Agent Claim Evidence → State → Prop

/--
The local constitution protects learning conditions rather than conclusions.
It does not require that challenges succeed or that evidence receive equal weight.
-/
structure HoldsAt
    (I : Interface Agent State Claim Evidence Decision)
    (s : State) : Prop where
  challenge_access :
    ∀ a c,
      I.affected s a →
      I.sharedClaim s c →
      ¬ I.excluded s a →
      I.permitted s (.challenge a c)

  reopen_on_grounds :
    ∀ c,
      I.sharedClaim s c →
      I.groundsForReview s c →
      I.permitted s (.reopen c)

  standing_symmetry :
    ∀ a b c,
      I.sameStanding s a b →
      I.sharedClaim s c →
      (I.permitted s (.challenge a c) ↔
       I.permitted s (.challenge b c))

  restriction_correctable :
    ∀ d a,
      I.affected s a →
      I.restricts s d a →
      I.canChallengeDecision s a d ∧ I.canReviseDecision s d

  exclusion_appealable :
    ∀ a,
      I.affected s a →
      I.excluded s a →
      I.permitted s (.appealExclusion a)

/-- A restriction is self-sealing if it removes challenge or revision of itself. -/
def SelfSealingRestriction
    (I : Interface Agent State Claim Evidence Decision)
    (s : State)
    (d : Decision)
    (a : Agent) : Prop :=
  I.restricts s d a ∧
  (¬ I.canChallengeDecision s a d ∨ ¬ I.canReviseDecision s d)

/-- The learning constitution excludes self-sealing restrictions on affected agents. -/
theorem constitution_blocks_self_sealing_restriction
    (I : Interface Agent State Claim Evidence Decision)
    (s : State)
    (d : Decision)
    (a : Agent)
    (hConstitution : HoldsAt I s)
    (hAffected : I.affected s a) :
    ¬ SelfSealingRestriction I s d a := by
  intro hSeal
  rcases hSeal with ⟨hRestricts, hFailure⟩
  have hRecursive :=
    hConstitution.restriction_correctable d a hAffected hRestricts
  rcases hFailure with hNoChallenge | hNoRevision
  · exact hNoChallenge hRecursive.1
  · exact hNoRevision hRecursive.2

/-- An exclusion with no appeal route. -/
def UnappealableExclusion
    (I : Interface Agent State Claim Evidence Decision)
    (s : State)
    (a : Agent) : Prop :=
  I.excluded s a ∧ ¬ I.permitted s (.appealExclusion a)

/-- The learning constitution excludes unappealable exclusion of affected agents. -/
theorem constitution_blocks_unappealable_exclusion
    (I : Interface Agent State Claim Evidence Decision)
    (s : State)
    (a : Agent)
    (hConstitution : HoldsAt I s)
    (hAffected : I.affected s a) :
    ¬ UnappealableExclusion I s a := by
  intro hBad
  rcases hBad with ⟨hExcluded, hNoAppeal⟩
  exact hNoAppeal (hConstitution.exclusion_appealable a hAffected hExcluded)

/-- There is some labelled process step from `s` to `t`. -/
def Next
    (I : Interface Agent State Claim Evidence Decision)
    (s t : State) : Prop :=
  ∃ v : Verb Agent Claim Evidence, I.step s v t

/-- Reflexive-transitive reachability. -/
inductive Reachable (NextState : State → State → Prop) : State → State → Prop
  | refl (s : State) : Reachable NextState s s
  | tail {s t u : State} :
      Reachable NextState s t →
      NextState t u →
      Reachable NextState s u

/-- Every process step preserves the learning constitution. -/
def ConstitutionPreserved
    (I : Interface Agent State Claim Evidence Decision) : Prop :=
  ∀ s t, Next I s t → HoldsAt I s → HoldsAt I t

/-- If the constitution holds initially and every step preserves it, it is an invariant. -/
theorem constitution_is_reachable_invariant
    (I : Interface Agent State Claim Evidence Decision)
    (s0 s : State)
    (hInitial : HoldsAt I s0)
    (hPreserved : ConstitutionPreserved I)
    (hReach : Reachable (Next I) s0 s) :
    HoldsAt I s := by
  induction hReach with
  | refl =>
      exact hInitial
  | tail hPrev hStep ih =>
      exact hPreserved _ _ hStep ih

/--
Recursive non-closure: under an invariant learning constitution, no reachable
state may contain a self-sealing restriction on an affected participant.
-/
theorem no_reachable_self_sealing_restriction
    (I : Interface Agent State Claim Evidence Decision)
    (s0 s : State)
    (d : Decision)
    (a : Agent)
    (hInitial : HoldsAt I s0)
    (hPreserved : ConstitutionPreserved I)
    (hReach : Reachable (Next I) s0 s)
    (hAffected : I.affected s a) :
    ¬ SelfSealingRestriction I s d a := by
  have hConstitution : HoldsAt I s :=
    constitution_is_reachable_invariant I s0 s hInitial hPreserved hReach
  exact constitution_blocks_self_sealing_restriction
    I s d a hConstitution hAffected

end LearningConstitution
