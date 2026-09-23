import AnchoredEvolution.ModelProcess

/-!
# Executable relay routes

`Network.Relay` established semantic transport through a graph, and
`ModelProcess.lean` compiled one local revision into an executable two-step
process.  This file makes the missing quantitative middle explicit.

An operational route is a list of content channels.  A run now contains:

1. one challenge step;
2. one executable relay step per channel;
3. one local revision step at the receiver.

Every step costs one unit in this baseline model.  Therefore a route of `h`
hops answers within exactly the constructive upper bound `h + 2` steps and
`h + 2` resource units.

The semantic premise is **exact faithfulness** at every hop, not the weaker
legacy `Network.Honest` predicate.  Under exact faithfulness, the end-to-end
content has exactly the same meaning on candidate worlds as the source view.
A tracking receiver therefore answers the original source view after the relay.

This is the first point where network distance enters the same operational
object as semantic answerability and resource cost.
-/

universe u

namespace Anchored.RelayProcess

open LearningConstitution Operational Semantic Tracking Network UnifiedTracking ModelProcess

variable {World : Type u}

/-- Apply channels in route order. -/
def applyChannels : List (Channel World) → Content World → Content World
  | [], v => v
  | c :: cs, v => applyChannels cs (c v)

/-- Every hop on the operational route is exactly semantically faithful. -/
def FaithfulRoute (C : Content World) : List (Channel World) → Prop
  | [] => True
  | c :: cs => FaithfulChannel C c ∧ FaithfulRoute C cs

/-- Exact faithfulness preserves liveness end to end. -/
theorem faithfulRoute_live {C : Content World} :
    ∀ {route : List (Channel World)} {v : Content World},
      FaithfulRoute C route → LiveClaim den C v →
        LiveClaim den C (applyChannels route v)
  | [], _, _, hlive => hlive
  | c :: cs, v, ⟨hc, hcs⟩, ⟨w, hw, hv⟩ => by
      have hcv : c v w := hc.2 v w hw hv
      exact faithfulRoute_live hcs ⟨w, hw, hcv⟩

/-- Exact faithfulness also prevents a route from manufacturing content: if the
end-to-end content holds in a candidate world, the original content held there. -/
theorem faithfulRoute_refines {C : Content World} :
    ∀ {route : List (Channel World)} {v : Content World} {w : World},
      FaithfulRoute C route → C w → applyChannels route v w → v w
  | [], _, _, _, _, hv => hv
  | c :: cs, v, w, ⟨hc, hcs⟩, hw, hout => by
      have hcv : c v w := faithfulRoute_refines hcs hw hout
      exact hc.1 v w hw hcv

/-- End-to-end exact faithfulness: the relayed content and source content have
identical truth value on every candidate world. -/
theorem faithfulRoute_iff {C : Content World} {route : List (Channel World)}
    {v : Content World} (h : FaithfulRoute C route) {w : World} (hw : C w) :
    applyChannels route v w ↔ v w := by
  constructor
  · exact faithfulRoute_refines h hw
  · intro hv
    induction route generalizing v with
    | nil => exact hv
    | cons c cs ih =>
        rcases h with ⟨hc, hcs⟩
        exact ih hcs (hc.2 v w hw hv)

inductive Phase
  | idle | relaying | done
  deriving DecidableEq

/-- State of a receiving model while one item of content moves along a route. -/
structure State (M : Model World) where
  localState : M.State
  content : Content World
  remaining : List (Channel World)
  phase : Phase

/-- Public decision record: relay steps do not alter it; only the receiver's
final local revision can do so. -/
def record (M : Model World) : State M → One → Content World :=
  fun s _ => M.record s.localState

def start (M : Model World) (s : M.State) (v : Content World)
    (route : List (Channel World)) : State M :=
  ⟨s, v, route, Phase.idle⟩

def relaying (M : Model World) (s : M.State) (v : Content World)
    (route : List (Channel World)) : State M :=
  ⟨s, v, route, Phase.relaying⟩

def finish (M : Model World) (s : M.State) (v : Content World) : State M :=
  ⟨M.revise s v, v, [], Phase.done⟩

/-- Baseline executable relay process.  Each challenge, hop and local revision
costs one unit. -/
def process (M : Model World) (base : Content World) :
    Process One (State M) (Content World) One One where
  step := fun s verb t =>
    (s.phase = Phase.idle ∧
      verb = .challenge PUnit.unit (M.record s.localState) ∧
      t.localState = s.localState ∧ t.content = s.content ∧
      t.remaining = s.remaining ∧ t.phase = Phase.relaying) ∨
    (∃ c cs, s.phase = Phase.relaying ∧ s.remaining = c :: cs ∧
      verb = .respond PUnit.unit s.content ∧
      t.localState = s.localState ∧ t.content = c s.content ∧
      t.remaining = cs ∧ t.phase = Phase.relaying) ∨
    (s.phase = Phase.relaying ∧ s.remaining = [] ∧
      verb = .revise (M.record s.localState) ∧
      t.localState = M.revise s.localState s.content ∧
      t.content = s.content ∧ t.remaining = [] ∧ t.phase = Phase.done)
  cost := fun _ _ _ => 1
  affected := fun _ _ => True
  sharedClaim := fun _ _ => True
  excluded := fun _ _ => False
  groundsForReview := fun _ _ => True
  sameStanding := fun _ _ _ => True
  restricts := fun _ _ _ => True
  claimOf := fun _ => base

variable {M : Model World} {base : Content World}

theorem challenge_step (s : M.State) (v : Content World)
    (route : List (Channel World)) :
    (process M base).step (start M s v route)
      (.challenge PUnit.unit (M.record s)) (relaying M s v route) := by
  exact Or.inl ⟨rfl, rfl, rfl, rfl, rfl, rfl⟩

theorem relay_step (s : M.State) (v : Content World)
    (c : Channel World) (cs : List (Channel World)) :
    (process M base).step (relaying M s v (c :: cs))
      (.respond PUnit.unit v) (relaying M s (c v) cs) := by
  exact Or.inr (Or.inl ⟨c, cs, rfl, rfl, rfl, rfl, rfl, rfl, rfl⟩)

theorem revision_step (s : M.State) (v : Content World) :
    (process M base).step (relaying M s v [])
      (.revise (M.record s)) (finish M s v) := by
  exact Or.inr (Or.inr ⟨rfl, rfl, rfl, rfl, rfl, rfl, rfl⟩)

/-- Execute every relay hop, but not yet the receiving model's revision. -/
theorem relay_run (s : M.State) :
    ∀ (route : List (Channel World)) (v : Content World),
      (process M base).Run (relaying M s v route)
        (relaying M s (applyChannels route v) []) route.length route.length
  | [], _ => Process.Run.nil _
  | c :: cs, v => by
      have hs := relay_step (base := base) s v c cs
      have hr := relay_run s cs (c v)
      simpa [applyChannels] using Process.Run.cons hs hr

/-- Execute every relay hop and then the receiver's local revision. -/
theorem relay_revision_run (s : M.State) :
    ∀ (route : List (Channel World)) (v : Content World),
      (process M base).Run (relaying M s v route)
        (finish M s (applyChannels route v)) (route.length + 1) (route.length + 1)
  | [], v => by
      simpa using Process.Run.cons (revision_step (base := base) s v) (Process.Run.nil _)
  | c :: cs, v => by
      have hs := relay_step (base := base) s v c cs
      have hr := relay_revision_run s cs (c v)
      simpa [applyChannels, Nat.add_assoc] using Process.Run.cons hs hr

/-- **Operational network bound.**  A tracking receiver behind an exactly
faithful route of `h` channels answers the original live view within `h + 2`
steps and `h + 2` cost units. -/
theorem answerWithin_route {C : Content World}
    (hM : M.Tracking C) {s : M.State} {v : Content World}
    {route : List (Channel World)} (hroute : FaithfulRoute C route)
    (hlive : LiveClaim den C v) :
    AnswerWithin (process M base) den C (record M)
      (start M s v route) PUnit.unit PUnit.unit v
      (route.length + 2) (route.length + 2) := by
  let out := applyChannels route v
  have houtLive : LiveClaim den C out := faithfulRoute_live hroute hlive
  obtain ⟨w, hw, hr, hout⟩ := (hM s out).1 houtLive
  have hv : v w := faithfulRoute_refines hroute hw hout
  refine ⟨relaying M s v route, finish M s out, route.length + 1,
    route.length + 1, challenge_step (base := base) s v route, ?_, ?_, ?_, ?_⟩
  · exact relay_revision_run (base := base) s route v
  · exact ⟨w, hw, hr, hv⟩
  · omega
  · simp [process]

/-- Finite answerability follows immediately, with the bound retaining the
route length. -/
theorem answerable_route {C : Content World}
    (hM : M.Tracking C) {s : M.State} {v : Content World}
    {route : List (Channel World)} (hroute : FaithfulRoute C route)
    (hlive : LiveClaim den C v) :
    Answerable (process M base) den C (record M)
      (start M s v route) PUnit.unit PUnit.unit v :=
  ⟨route.length + 2, route.length + 2,
    answerWithin_route hM hroute hlive⟩

/-- The zero-hop case reduces to the local two-step compiler bound. -/
theorem zero_hop_two_step {C : Content World}
    (hM : M.Tracking C) {s : M.State} {v : Content World}
    (hlive : LiveClaim den C v) :
    AnswerWithin (process M base) den C (record M)
      (start M s v []) PUnit.unit PUnit.unit v 2 2 := by
  simpa using answerWithin_route (base := base) hM (route := []) trivial hlive

end Anchored.RelayProcess
