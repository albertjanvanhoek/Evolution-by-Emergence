import AnchoredEvolution.Vendor.TheRoom
import AnchoredEvolution.Dynamics

/-!
# Operational layer: permissions, availability and cost derived from steps

The Learning Constitution (`TheRoom.lean`) declares `permitted`,
`canChallengeDecision`, `canReviseDecision` and `step` as separate fields of an
`Interface`.  Nothing ties them together:

* a verb can be "permitted" with no executable step;
* revision can be "available" while no challenge ever leads to it.

`ConstitutionAccessibility.lean` then assigns correction cost `⊤` or a declared
base cost from those declared flags.

This file makes **executable steps primary** and derives everything else:

* `permitted s v` means some step labelled `v` can execute from `s`;
* `canChallengeDecision` means the challenge step can execute;
* `canReviseDecision` means a revision step is reachable;
* **responsiveness** means a run starting with the challenge reaches a revision;
* **correction cost and time** are the step count and summed cost of such a
  run.  "Infinite cost" means that no run exists.

Main results:

1. `paper_constitution`: the declared interface admits a constitution that
   holds while nothing at all can happen.  This confirms the gap.
2. `derived_permission_executable`: in the derived interface every permission
   is executable by construction.
3. `heard_but_unanswerable`: even the derived constitution can hold while every
   challenge leads to a dead end.  "Permitted and revisable" is strictly weaker
   than "responsive".
4. `responsive_implies_restriction_clause`: responsiveness implies the Room's
   restriction clause.  Together with (3), responsiveness is strictly stronger.
   `declared_available_but_sealed`: `ConstitutionAccessibility` would give
   such a sealed restriction a finite cost.
5. `sealed_iff_no_finite_cost`: an operationally self-sealing restriction is
   exactly one whose correction has no finite time or cost.  The `⊤` of
   `ConstitutionAccessibility` becomes a theorem about runs, not a declaration.
6. `correctionSystem`: every process induces a correction graph among agents,
   so all anchored Layers 2–4 apply to it.  `commons_responsive_correctable`
   gives a sufficient condition.
7. `responsive_invariant`: responsiveness preserved by every step holds in every
   reachable state.  This reuses the Room's own `Reachable` and `Next`.
-/

universe u

namespace Anchored.Operational

open LearningConstitution

variable {Agent State Claim Evidence Decision : Type u}

/-- An operational learning process: executable steps (with resource cost) are
primary.  The observational predicates say who is affected, what is shared,
what restricts whom, and which shared claim records a decision. -/
structure Process (Agent State Claim Evidence Decision : Type u) where
  step : State → Verb Agent Claim Evidence → State → Prop
  cost : State → Verb Agent Claim Evidence → State → Nat
  affected : State → Agent → Prop
  sharedClaim : State → Claim → Prop
  excluded : State → Agent → Prop
  groundsForReview : State → Claim → Prop
  sameStanding : State → Agent → Agent → Prop
  restricts : State → Decision → Agent → Prop
  claimOf : Decision → Claim

namespace Process

variable (P : Process Agent State Claim Evidence Decision)

/-- A run from `s` to `t` taking `n` steps with total cost `k`. -/
inductive Run : State → State → Nat → Nat → Prop
  | nil (s : State) : Run s s 0 0
  | cons {s t w : State} {v : Verb Agent Claim Evidence} {n k : Nat} :
      P.step s v t → Run t w n k → Run s w (n + 1) (P.cost s v t + k)

/-- A verb is executable from `s`. -/
def Enabled (s : State) (v : Verb Agent Claim Evidence) : Prop :=
  ∃ t, P.step s v t

/-- A revision of claim `c` is reachable from `s`, by any route. -/
def RevisionReachable (s : State) (c : Claim) : Prop :=
  ∃ t w n k, P.Run s t n k ∧ P.step t (.revise c) w

/-- **Responsive correction within time `T` and cost `K`.**  Agent `a`'s
challenge of `c` executes, and the continuation after it reaches a revision of
`c`.  The whole run uses at most `T` steps and at most `K` resources. -/
def CorrectionWithin (s : State) (a : Agent) (c : Claim) (T K : Nat) : Prop :=
  ∃ t₁ t₂ t₃ n k,
    P.step s (.challenge a c) t₁ ∧ P.Run t₁ t₂ n k ∧ P.step t₂ (.revise c) t₃ ∧
    n + 2 ≤ T ∧
    P.cost s (.challenge a c) t₁ + k + P.cost t₂ (.revise c) t₃ ≤ K

/-- A challenge leads to revision: responsive correction exists at some finite
time and cost. -/
def Responsive (s : State) (a : Agent) (c : Claim) : Prop :=
  ∃ T K, P.CorrectionWithin s a c T K

/-- **The derived interface.**  Permissions and availability are defined from
executable steps; the transition relation is the process's own. -/
def toInterface : Interface Agent State Claim Evidence Decision where
  affected := P.affected
  sharedClaim := P.sharedClaim
  excluded := P.excluded
  permitted := P.Enabled
  groundsForReview := P.groundsForReview
  sameStanding := P.sameStanding
  restricts := P.restricts
  canChallengeDecision := fun s a d => P.Enabled s (.challenge a (P.claimOf d))
  canReviseDecision := fun s d => P.RevisionReachable s (P.claimOf d)
  step := P.step

/-! ## 1. Derived permissions are executable -/

/-- **No paper permissions.**  In the derived interface every permitted verb has
an executable step. -/
theorem derived_permission_executable {s : State} {v : Verb Agent Claim Evidence}
    (h : P.toInterface.permitted s v) : ∃ t, P.toInterface.step s v t := h

/-- Under the derived constitution, an affected, non-excluded participant's
challenge of a shared claim actually executes. -/
theorem derived_challenge_executes {s : State} (hc : HoldsAt P.toInterface s)
    {a : Agent} {c : Claim} (haff : P.affected s a) (hsh : P.sharedClaim s c)
    (hnx : ¬ P.excluded s a) : ∃ t, P.step s (.challenge a c) t :=
  hc.challenge_access a c haff hsh hnx

/-- Under the derived constitution, an excluded affected participant's appeal
actually executes. -/
theorem derived_appeal_executes {s : State} (hc : HoldsAt P.toInterface s)
    {a : Agent} (haff : P.affected s a) (hx : P.excluded s a) :
    ∃ t, P.step s (.appealExclusion a) t :=
  hc.exclusion_appealable a haff hx

/-! ## 2. Responsiveness, cost and time -/

theorem correctionWithin_mono {s : State} {a : Agent} {c : Claim}
    {T K T' K' : Nat} (h : P.CorrectionWithin s a c T K) (hT : T ≤ T')
    (hK : K ≤ K') : P.CorrectionWithin s a c T' K' := by
  obtain ⟨t₁, t₂, t₃, n, k, h1, hr, h3, hn, hk⟩ := h
  exact ⟨t₁, t₂, t₃, n, k, h1, hr, h3, by omega, by omega⟩

/-- Operationally self-sealing: `a` is restricted by `d` and `a`'s challenge of
`d` can never lead to its revision. -/
def OperationallySealed (s : State) (d : Decision) (a : Agent) : Prop :=
  P.restricts s d a ∧ ¬ P.Responsive s a (P.claimOf d)

/-- **Self-sealing is exactly infinite correction cost.**  A restriction is
operationally sealed iff no finite time and resource bound admits a
responsive correction.  In `ConstitutionAccessibility.lean` the value `⊤` is
declared; here it is a theorem about runs. -/
theorem sealed_iff_no_finite_cost (s : State) (d : Decision) (a : Agent)
    (hr : P.restricts s d a) :
    P.OperationallySealed s d a ↔
      ∀ T K, ¬ P.CorrectionWithin s a (P.claimOf d) T K :=
  ⟨fun h T K hc => h.2 ⟨T, K, hc⟩,
   fun h => ⟨hr, fun ⟨T, K, hc⟩ => h T K hc⟩⟩

/-- Budget-gated correction: with resource budget `B`, correction is affordable
iff some responsive run fits the budget.  A sealed restriction is unaffordable
at every budget. -/
theorem sealed_unaffordable_at_every_budget {s : State} {d : Decision} {a : Agent}
    (h : P.OperationallySealed s d a) (B : Nat) :
    ¬ ∃ T, P.CorrectionWithin s a (P.claimOf d) T B :=
  fun ⟨T, hc⟩ => h.2 ⟨T, B, hc⟩

/-! ## 3. The responsive constitution -/

/-- **Responsive constitution at state `s`.**
* Every affected participant restricted by a decision can get it revised
  through its own challenge.
* Every affected excluded participant's appeal can lead to restored access.
-/
structure ResponsiveAt (s : State) : Prop where
  restriction_responsive :
    ∀ d a, P.affected s a → P.restricts s d a → P.Responsive s a (P.claimOf d)
  exclusion_restorable :
    ∀ a, P.affected s a → P.excluded s a →
      ∃ t₁ t₂ t₃ n k, P.step s (.appealExclusion a) t₁ ∧ P.Run t₁ t₂ n k ∧
        P.step t₂ (.restoreAccess a) t₃

/-- Revision reachable after a challenge is revision reachable from the start. -/
theorem responsive_revision_reachable {s : State} {a : Agent} {c : Claim}
    (h : P.Responsive s a c) : P.RevisionReachable s c := by
  obtain ⟨_, _, t₁, t₂, t₃, n, k, h1, hr, h3, _, _⟩ := h
  exact ⟨t₂, t₃, n + 1, _ + k, Run.cons h1 hr, h3⟩

/-- **Responsiveness implies the Room's restriction clause** (in the derived
interface): the challenge executes and revision is reachable. -/
theorem responsive_implies_restriction_clause {s : State} {d : Decision}
    {a : Agent} (h : P.Responsive s a (P.claimOf d)) :
    P.toInterface.canChallengeDecision s a d ∧
      P.toInterface.canReviseDecision s d := by
  refine ⟨?_, P.responsive_revision_reachable h⟩
  obtain ⟨_, _, t₁, _, _, _, _, h1, _⟩ := h
  exact ⟨t₁, h1⟩

/-- A responsive constitution rules out operational self-sealing. -/
theorem responsive_blocks_sealing {s : State} (h : P.ResponsiveAt s)
    {d : Decision} {a : Agent} (haff : P.affected s a) :
    ¬ P.OperationallySealed s d a :=
  fun ⟨hr, hnot⟩ => hnot (h.restriction_responsive d a haff hr)

/-- **Invariance through time**, reusing the Room's `Reachable` and `Next`.  If
the responsive constitution holds initially and every step preserves it, it
holds in every reachable state. -/
theorem responsive_invariant (s0 s : State) (h0 : P.ResponsiveAt s0)
    (hpres : ∀ x y, Next P.toInterface x y → P.ResponsiveAt x → P.ResponsiveAt y)
    (hreach : Reachable (Next P.toInterface) s0 s) : P.ResponsiveAt s := by
  induction hreach with
  | refl => exact h0
  | tail _ hstep ih => exact hpres _ _ hstep ih

/-! ## 4. The induced correction graph and the anchored layers -/

/-- Claim `c` governs agent `b` at `s`: it records a decision restricting `b`,
or it is a shared claim affecting `b`. -/
def Governs (s : State) (c : Claim) (b : Agent) : Prop :=
  (∃ d, P.restricts s d b ∧ P.claimOf d = c) ∨ (P.affected s b ∧ P.sharedClaim s c)

/-- Operational correction edge: `a`'s challenge of some claim governing `b`
can lead to that claim's revision. -/
def CorrectionEdge (s : State) (a b : Agent) : Prop :=
  ∃ c, P.Governs s c b ∧ P.Responsive s a c

/-- **Every process induces an anchored correction system at each state.**  All
Layer 2–4 theorems (sending and receiving, composition, sealing, legitimate
restriction) apply to it. -/
def correctionSystem (s : State) : System.{u} where
  Node := Agent
  Edge := P.CorrectionEdge s

/-- **Commons sufficiency.**  Suppose some shared claim governs every
participant, and every participant's challenge of it is responsive.  Then the
induced correction system is correctable. -/
theorem commons_responsive_correctable (s : State) (c : Claim)
    (hgov : ∀ b, P.Governs s c b) (hresp : ∀ a, P.Responsive s a c) :
    (P.correctionSystem s).Correctable := by
  intro a b
  exact Reach.single ⟨c, hgov b, hresp a⟩

/-- **Operational sealing breaks correctability.**  If none of `a`'s challenges
can lead to the revision of any claim governing anyone, and `a` has a peer, the
induced system is not correctable. -/
theorem operational_voice_sealed_breaks (s : State) {a b : Agent} (hab : a ≠ b)
    (hsealed : ∀ c x, P.Governs s c x → ¬ P.Responsive s a c) :
    ¬ (P.correctionSystem s).Correctable :=
  sealing_breaks (E := P.CorrectionEdge s) hab
    (fun x ⟨c, hg, hr⟩ => hsealed c x hg hr)

end Process

/-! ## 5. Countermodels -/

section Countermodels

/-- **The paper constitution.**  With the declared interface, the full Learning
Constitution can hold at a state from which no step of any kind can execute.
Declared permissions and availability do not imply that anything can happen. -/
theorem paper_constitution :
    ∃ (I : Interface Unit Unit Unit Unit Unit) (s : Unit),
      HoldsAt I s ∧ ∀ v t, ¬ I.step s v t := by
  let I : Interface Unit Unit Unit Unit Unit :=
    { affected := fun _ _ => True
      sharedClaim := fun _ _ => True
      excluded := fun _ _ => False
      permitted := fun _ _ => True
      groundsForReview := fun _ _ => True
      sameStanding := fun _ _ _ => True
      restricts := fun _ _ _ => True
      canChallengeDecision := fun _ _ _ => True
      canReviseDecision := fun _ _ => True
      step := fun _ _ _ => False }
  refine ⟨I, (), ?_, fun _ _ h => h⟩
  exact
    { challenge_access := fun _ _ _ _ _ => trivial
      reopen_on_grounds := fun _ _ _ => trivial
      standing_symmetry := fun _ _ _ _ _ => Iff.rfl
      restriction_correctable := fun _ _ _ _ => ⟨trivial, trivial⟩
      exclusion_appealable := fun _ _ h => h.elim }

/-- States of the "heard but unanswerable" process. -/
inductive Desk
  | open_ | filed | revised

/-- Challenges are filed and go nowhere; the authority can revise on its own
initiative, but no challenge ever leads there. -/
def deskProcess : Process Unit Desk Unit Unit Unit where
  step := fun s v t =>
    (s = .open_ ∧ v = .challenge () () ∧ t = .filed) ∨
    (s = .open_ ∧ v = .revise () ∧ t = .revised)
  cost := fun _ _ _ => 1
  affected := fun _ _ => True
  sharedClaim := fun _ _ => True
  excluded := fun _ _ => False
  groundsForReview := fun _ _ => False
  sameStanding := fun _ _ _ => True
  restricts := fun _ _ _ => True
  claimOf := fun _ => ()

theorem desk_filed_stuck : ∀ v t, ¬ deskProcess.step .filed v t := by
  intro v t h
  rcases h with ⟨h, _⟩ | ⟨h, _⟩ <;> cases h

theorem desk_run_from_filed {t : Desk} {n k : Nat}
    (h : deskProcess.Run .filed t n k) : t = .filed := by
  cases h with
  | nil => rfl
  | cons hs _ => exact absurd hs (desk_filed_stuck _ _)

/-- The derived Learning Constitution holds at the open desk: the challenge
executes and revision is reachable. -/
theorem desk_constitution_holds : HoldsAt deskProcess.toInterface .open_ where
  challenge_access := fun a c _ _ _ => by
    cases a; cases c
    exact ⟨.filed, Or.inl ⟨rfl, rfl, rfl⟩⟩
  reopen_on_grounds := fun _ _ h => h.elim
  standing_symmetry := fun a b c _ _ => by cases a; cases b; exact Iff.rfl
  restriction_correctable := fun d a _ _ => by
    cases d; cases a
    exact ⟨⟨.filed, Or.inl ⟨rfl, rfl, rfl⟩⟩,
           ⟨.open_, .revised, 0, 0, Process.Run.nil _, Or.inr ⟨rfl, rfl, rfl⟩⟩⟩
  exclusion_appealable := fun _ _ h => h.elim

/-- **Heard but unanswerable.**  At the open desk the derived constitution holds,
yet no challenge can lead to revision: the process is operationally
self-sealing, and correction has no finite cost.  Permission plus revisability
is strictly weaker than responsiveness. -/
theorem heard_but_unanswerable :
    HoldsAt deskProcess.toInterface .open_ ∧
      deskProcess.OperationallySealed .open_ () () := by
  refine ⟨desk_constitution_holds, trivial, ?_⟩
  rintro ⟨T, K, t₁, t₂, t₃, n, k, h1, hr, h3, _, _⟩
  have ht₁ : t₁ = .filed := by
    rcases h1 with ⟨_, _, h⟩ | ⟨_, hv, _⟩
    · exact h
    · cases hv
  subst ht₁
  have ht₂ := desk_run_from_filed hr
  subst ht₂
  exact desk_filed_stuck _ _ h3

/-- Verbatim form of `DecisionCorrectionAvailable` from
`ConstitutionAccessibility.lean`: the declared challenge flag and the declared
revision flag. -/
def DeclaredCorrectionAvailable {A S C E D : Type u} (I : Interface A S C E D)
    (s : S) (d : D) (a : A) : Prop :=
  I.canChallengeDecision s a d ∧ I.canReviseDecision s d

/-- **Finite declared cost for a sealed restriction.**  At the open desk,
`DecisionCorrectionAvailable` holds even in the *derived* interface.
`ConstitutionAccessibility.EffectiveCorrectionCost` would therefore assign the
finite base cost, yet the restriction is operationally sealed: no challenge can
ever lead to revision.  Correction cost must be computed from responsive runs,
not from availability flags. -/
theorem declared_available_but_sealed :
    DeclaredCorrectionAvailable deskProcess.toInterface Desk.open_ () () ∧
      deskProcess.OperationallySealed .open_ () () :=
  ⟨desk_constitution_holds.restriction_correctable () () trivial trivial,
   heard_but_unanswerable.2⟩

/-- The repaired desk: a filed challenge can be answered by revision. -/
def answeringDesk : Process Unit Desk Unit Unit Unit :=
  { deskProcess with
    step := fun s v t =>
      (s = .open_ ∧ v = .challenge () () ∧ t = .filed) ∨
      (s = .filed ∧ v = .revise () ∧ t = .revised) }

/-- **Non-vacuity of responsiveness.**  In the answering desk the challenge is
answered within 2 steps at cost 2, and the responsive constitution holds. -/
theorem answeringDesk_responsive : answeringDesk.ResponsiveAt .open_ where
  restriction_responsive := fun d a _ _ => by
    cases d; cases a
    exact ⟨2, 2, .filed, .filed, .revised, 0, 0, Or.inl ⟨rfl, rfl, rfl⟩,
      Process.Run.nil _, Or.inr ⟨rfl, rfl, rfl⟩, by decide, by decide⟩
  exclusion_restorable := fun _ _ h => h.elim

end Countermodels

end Anchored.Operational
