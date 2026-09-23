import AnchoredEvolution.Tracking

/-!
# Layer 1e: one correction law for one, two, three, four … models

The earlier layers already scale in the correction *graph*: routes compose at
any depth (Layer 3).  This layer makes the correction *dynamics* scale too.  One
definition of a model and one tracking law apply unchanged to:
* a single person;
* a part of a person;
* a pair;
* a group;
* a group of groups.

A group of models is again a model of the same type.  Nothing new has to be
assumed when models meet.

**Model.**  A model has private state, a public record (the worlds it
currently admits) and a revision rule for incoming content.  Contents are sets
of worlds, so a claim is identified with its meaning.  Incompatibility,
liveness and minimal change are the definitions of Layers 1c–1d, reused
unchanged.

**Tracking** (Layer 1d, now as a dynamic law).  After any incoming content:
* a live content is admitted;
* the record opens only worlds where the old record or the content held.

## Results

1. **The canonical tracking rule** (`open_tracks`).  Keep what you admitted and
   admit what was said.  Challenges open records, and evidence closes candidate
   sets (Layer 1d, `scenario_removed_only_by_evidence`).
2. **The anchor forbids content-blind correction at every scale.**  If two
   rival contents lead to the same revision, the model cannot track
   (`same_revision_blocks`).  This covers:
   * content-insensitive models (`insensitive_model_cannot_track`);
   * confusing or blind channels (`confusing_channel_blocks`).
3. **Relays.**  A channel is honest when it may sharpen content but never
   blurs it or kills a live content.
   * Honest channels compose (`honest_comp`).
   * Every relay route through honest channels is honest (`relay_honest`).
   * A tracking receiver tracks through any honest route
     (`via_honest_tracks`).
   * So in a strongly connected network of honest channels, every voice is
     tracked by every member (`honest_network_tracks`).  The ring does this
     with one channel per member (`ring_tracks`).  For `n = 0` the ring is one
     model correcting itself: the individual.
4. **The blind cut.**  Suppose every channel leaving a set `A` of models
   forwards position rather than content.  Then:
   * every route out of `A` is content-blind (`blind_cut`);
   * no model outside `A` can track two rival views held inside `A`, however
     the rest of the network is wired (`blind_cut_blocks`).
5. **Groups are models.**  `group` aggregates members' records by union and
   routes incoming content through doors.
   * If every member tracks and every live content has a door, the group
     tracks (`group_tracks`).
   * A live content with no door, excluded by the group, breaks tracking
     (`closed_door_breaks`).
   * **The individual is the one-member group** (`solo_tracking_iff`).
   * **Any depth**: a sound tree of groups of groups tracks
     (`sound_tree_tracks`).
6. **Aggregation under the anchor** (`aggregation_under_anchor`).
   * Union keeps every member's live view admitted.
   * Consensus (intersection) of two rivals is refuted in *every* candidate
     world, the true one included.  By the anchor, a group that speaks only
     where all its members agree is certainly wrong as soon as it contains
     rivals.
7. **Provenance** (`provenance`, `tree_provenance`).  Along any sequence of
   challenges, a tracking model, and so any sound group at any depth, admits
   only candidate worlds that it admitted at the start or that someone voiced.
   Nothing is admitted without a source.
8. **Four persons** (`four_person_benchmark`, `pairs_position_blocks`).
   Compare:
   * flat four, with twelve channels;
   * two pairs forwarding content, with six channels.

   Both track every voice everywhere.  With two pairs whose interfaces forward
   position, no member of one pair can track the rival views of the other
   pair.  Hierarchy costs nothing in tracking exactly when its interfaces
   forward content.
-/

universe u v

namespace Anchored.Network

open Semantic Tracking

/-! ## 0. Contents, models and tracking -/

/-- A content is a set of worlds: a claim identified with its meaning. -/
abbrev Content (World : Type u) : Type u := World → Prop

/-- A channel transforms content in transit. -/
abbrev Channel (World : Type u) : Type u := Content World → Content World

/-- Contents mean themselves. -/
abbrev den {World : Type u} : Content World → World → Prop := fun c => c

/-- A model has private state, a public record (the worlds it currently admits)
and a revision rule for incoming content.  One type serves a person, a part of
a person, a pair, a group and a group of groups. -/
structure Model (World : Type u) where
  State : Type u
  record : State → Content World
  revise : State → Content World → State

section Models

variable {World : Type u} (C : Content World)

/-- **Tracking**, as a law of the revision dynamics.  For every state and every
incoming content:
* if the content is live, the revised record admits it;
* the revised record opens only worlds where the old record or the content
  held (minimal change, Layer 1d). -/
def Model.Tracking (M : Model World) : Prop :=
  ∀ s v, (LiveClaim den C v → Compatible den C (M.record (M.revise s v)) v) ∧
    MinimalToward den C (M.record s) (M.record (M.revise s v)) v

/-- The open model: keep what you admitted, and admit what was said. -/
def openModel : Model World where
  State := Content World
  record := fun r => r
  revise := fun r v => fun w => r w ∨ v w

/-- **The canonical tracking rule.**  The open model tracks on every candidate
set. -/
theorem open_tracks : (openModel (World := World)).Tracking C :=
  fun _ _ => ⟨fun ⟨w, hw, hv⟩ => ⟨w, hw, Or.inr hv, hv⟩, fun _ _ h => h⟩

/-- The model's revision does not depend on what was said. -/
def Model.ContentInsensitive (M : Model World) : Prop :=
  ∀ s v v', M.revise s v = M.revise s v'

/-- Receive content through a channel. -/
def Model.via (M : Model World) (ch : Channel World) : Model World where
  State := M.State
  record := M.record
  revise := fun s v => M.revise s (ch v)

/-- An honest channel may sharpen content, but never blurs it and never kills
a live content. -/
def Honest (ch : Channel World) : Prop :=
  ∀ v, (∀ w, C w → ch v w → v w) ∧ (LiveClaim den C v → LiveClaim den C (ch v))

/-- A blind channel forwards the same thing whatever it receives: position,
not content. -/
def Blind (ch : Channel World) : Prop :=
  ∀ v v', ch v = ch v'

variable {C}

/-- **Same revision, no tracking (the anchor at work).**  Suppose two
incompatible contents lead to the same revision, the first is live, and the
current record excludes it.  Then the model does not track.  Admitting the
first and changing minimally toward the second are incompatible demands. -/
theorem same_revision_blocks {M : Model World} {s : M.State} {v₁ v₂ : Content World}
    (hsame : M.revise s v₁ = M.revise s v₂)
    (hinc : Incompatible den C v₁ v₂) (hlive : LiveClaim den C v₁)
    (hex : Incompatible den C (M.record s) v₁) : ¬ M.Tracking C := by
  intro h
  have hadm := (h s v₁).1 hlive
  have hmin := (h s v₂).2
  rw [← hsame] at hmin
  exact minimal_toward_rival_blocks hinc hex hmin hadm

/-- A content-insensitive model cannot track once a live view it excludes has
a rival. -/
theorem insensitive_model_cannot_track {M : Model World} (hins : M.ContentInsensitive)
    {s : M.State} {v₁ v₂ : Content World}
    (hinc : Incompatible den C v₁ v₂) (hlive : LiveClaim den C v₁)
    (hex : Incompatible den C (M.record s) v₁) : ¬ M.Tracking C :=
  same_revision_blocks (hins s v₁ v₂) hinc hlive hex

theorem honest_id : Honest C (fun v => v) :=
  fun _ => ⟨fun _ _ h => h, fun h => h⟩

/-- **Honest channels compose.** -/
theorem honest_comp {f g : Channel World} (hf : Honest C f) (hg : Honest C g) :
    Honest C (g ∘ f) :=
  fun v => ⟨fun w hw h => (hf v).1 w hw ((hg (f v)).1 w hw h),
    fun hl => (hg (f v)).2 ((hf v).2 hl)⟩

/-- **A tracking receiver tracks through an honest channel.** -/
theorem via_honest_tracks {M : Model World} {ch : Channel World}
    (hM : M.Tracking C) (hch : Honest C ch) : (M.via ch).Tracking C := by
  intro s v
  obtain ⟨hsharp, hlive⟩ := hch v
  obtain ⟨hadm, hmin⟩ := hM s (ch v)
  refine ⟨fun hl => ?_, fun w hw hr => ?_⟩
  · obtain ⟨w, hw, hr, hc⟩ := hadm (hlive hl)
    exact ⟨w, hw, hr, hsharp w hw hc⟩
  · rcases hmin w hw hr with h | h
    · exact Or.inl h
    · exact Or.inr (hsharp w hw h)

/-- **A confusing channel blocks tracking, whatever the receiver.**  If the
channel maps two rival contents to the same thing, no model receiving through it
tracks. -/
theorem confusing_channel_blocks {M : Model World} {ch : Channel World}
    {s : M.State} {v₁ v₂ : Content World} (hconf : ch v₁ = ch v₂)
    (hinc : Incompatible den C v₁ v₂) (hlive : LiveClaim den C v₁)
    (hex : Incompatible den C (M.record s) v₁) : ¬ (M.via ch).Tracking C :=
  same_revision_blocks (M := M.via ch) (s := s)
    (show M.revise s (ch v₁) = M.revise s (ch v₂) by rw [hconf]) hinc hlive hex

theorem blind_channel_blocks {M : Model World} {ch : Channel World} (hb : Blind ch)
    {s : M.State} {v₁ v₂ : Content World}
    (hinc : Incompatible den C v₁ v₂) (hlive : LiveClaim den C v₁)
    (hex : Incompatible den C (M.record s) v₁) : ¬ (M.via ch).Tracking C :=
  confusing_channel_blocks (hb v₁ v₂) hinc hlive hex

/-! ### Provenance: nothing is admitted without a source -/

/-- Apply a sequence of incoming contents. -/
def Model.run (M : Model World) : M.State → List (Content World) → M.State
  | s, [] => s
  | s, v :: vs => M.run (M.revise s v) vs

/-- **Provenance.**  After any sequence of challenges, every candidate world a
tracking model admits was admitted at the start or was voiced. -/
theorem provenance {M : Model World} (hM : M.Tracking C) :
    ∀ (vs : List (Content World)) (s : M.State) (w : World), C w →
      M.record (M.run s vs) w → M.record s w ∨ ∃ v ∈ vs, v w
  | [], _, _, _, h => Or.inl h
  | v :: vs, s, w, hw, h => by
      rcases provenance hM vs (M.revise s v) w hw h with h' | ⟨v', hv', h'⟩
      · rcases (hM s v).2 w hw h' with h'' | h''
        · exact Or.inl h''
        · exact Or.inr ⟨v, List.Mem.head _, h''⟩
      · exact Or.inr ⟨v', List.Mem.tail _ hv', h'⟩

end Models

/-! ## 1. Relays: correction routes that carry content -/

section Relays

variable {World : Type u} {ι : Type v}
variable (E : ι → ι → Prop) (ch : ι → ι → Channel World)

/-- A relay route from `i` to `k` whose end-to-end channel is `f`.  Each hop
uses an existing correction edge, and its channel acts after the channels
before it. -/
inductive Relay : ι → ι → Channel World → Prop
  | here (i : ι) : Relay i i (fun v => v)
  | hop {i j k : ι} {f : Channel World} : E i j → Relay j k f → Relay i k (f ∘ ch i j)

variable {E ch} {C : Content World}

/-- Every correction route (Layer 1) is a relay route. -/
theorem reach_relay {i k : ι} (h : Reach E i k) : ∃ f, Relay E ch i k f := by
  induction h with
  | refl a => exact ⟨_, Relay.here a⟩
  | step e _ ih =>
      obtain ⟨f, hf⟩ := ih
      exact ⟨_, Relay.hop e hf⟩

/-- **Routes through honest channels are honest.** -/
theorem relay_honest (hE : ∀ i j, E i j → Honest C (ch i j)) {i k : ι}
    {f : Channel World} (h : Relay E ch i k f) : Honest C f := by
  induction h with
  | here _ => exact honest_id
  | hop e _ ih => exact honest_comp (hE _ _ e) ih

/-- **Every voice is tracked by every member.**  In a strongly connected
network of honest channels whose members track, every member tracks every
other member's content along some relay route. -/
theorem honest_network_tracks (M : ι → Model World) (hsc : StronglyConnected E)
    (hE : ∀ i j, E i j → Honest C (ch i j)) (hM : ∀ k, (M k).Tracking C) :
    ∀ i k, ∃ f, Relay E ch i k f ∧ ((M k).via f).Tracking C := by
  intro i k
  obtain ⟨f, hf⟩ := reach_relay (ch := ch) (hsc i k)
  exact ⟨f, hf, via_honest_tracks (hM k) (relay_honest hE hf)⟩

/-- **The blind cut.**  If every edge leaving `A` has a blind channel, every
relay route from inside `A` to outside `A` is blind. -/
theorem blind_cut (A : ι → Prop) [DecidablePred A]
    (hcut : ∀ i j, A i → ¬ A j → E i j → Blind (ch i j))
    {i k : ι} {f : Channel World} (h : Relay E ch i k f) : A i → ¬ A k → Blind f := by
  induction h with
  | here _ => exact fun hi hk => absurd hi hk
  | @hop i j k f e _ ih =>
      intro hi hk x y
      by_cases hj : A j
      · exact ih hj hk _ _
      · exact congrArg f (hcut i j hi hj e x y)

/-- **Rivals inside a blind cut cannot be tracked from outside.**  This holds
for any receiver outside `A` and any route. -/
theorem blind_cut_blocks (A : ι → Prop) [DecidablePred A]
    (hcut : ∀ i j, A i → ¬ A j → E i j → Blind (ch i j))
    {i k : ι} {f : Channel World} (h : Relay E ch i k f) (hi : A i) (hk : ¬ A k)
    (M : Model World) {s : M.State} {v₁ v₂ : Content World}
    (hinc : Incompatible den C v₁ v₂) (hlive : LiveClaim den C v₁)
    (hex : Incompatible den C (M.record s) v₁) : ¬ (M.via f).Tracking C :=
  blind_channel_blocks (blind_cut A hcut h hi hk) hinc hlive hex

end Relays

/-- **The ring tracks.**  One honest channel per member is enough for every
member to track every voice.  For `n = 0` this is one model correcting itself. -/
theorem ring_tracks {World : Type u} {C : Content World} (n : Nat)
    (ch : Fin (n + 1) → Fin (n + 1) → Channel World) (M : Fin (n + 1) → Model World)
    (hE : ∀ i j, RingEdge n i j → Honest C (ch i j)) (hM : ∀ k, (M k).Tracking C) :
    ∀ i k, ∃ f, Relay (RingEdge n) ch i k f ∧ ((M k).via f).Tracking C :=
  honest_network_tracks M (ring_strongly_connected n) hE hM

/-! ## 2. Groups are models -/

section Groups

variable {World : Type u} (C : Content World) {ι : Type u}

/-- A group of models is a model.
* Its state is the members' states.
* Its record is the union of the members' records: the group admits what any
  member admits.
* Incoming content is revised by the members whose door is open for it. -/
def group (M : ι → Model World) (door : Content World → ι → Bool) : Model World where
  State := (i : ι) → (M i).State
  record := fun s w => ∃ i, (M i).record (s i) w
  revise := fun s v i => if door v i then (M i).revise (s i) v else s i

/-- Every live content has an open door. -/
def Doors (door : Content World → ι → Bool) : Prop :=
  ∀ v, LiveClaim den C v → ∃ i, door v i = true

variable {C}

/-- **A group of tracking members with doors for every voice tracks.** -/
theorem group_tracks {M : ι → Model World} {door : Content World → ι → Bool}
    (hM : ∀ i, (M i).Tracking C) (hd : Doors C door) : (group M door).Tracking C := by
  intro s v
  refine ⟨fun hl => ?_, fun w hw hr => ?_⟩
  · obtain ⟨i, hi⟩ := hd v hl
    obtain ⟨w, hw, hr, hv⟩ := (hM i (s i) v).1 hl
    refine ⟨w, hw, ⟨i, ?_⟩, hv⟩
    show (M i).record (if door v i then (M i).revise (s i) v else s i) w
    rw [if_pos hi]
    exact hr
  · obtain ⟨i, hi⟩ := hr
    change (M i).record (if door v i then (M i).revise (s i) v else s i) w at hi
    by_cases hdi : door v i = true
    · rw [if_pos hdi] at hi
      rcases (hM i (s i) v).2 w hw hi with h | h
      · exact Or.inl ⟨i, h⟩
      · exact Or.inr h
    · rw [if_neg hdi] at hi
      exact Or.inl ⟨i, hi⟩

/-- **A closed door breaks tracking.**  Suppose a live content has no open door
and the group's record excludes it.  Then the group does not track: the content
changes nothing, so it is never admitted. -/
theorem closed_door_breaks {M : ι → Model World} {door : Content World → ι → Bool}
    {s : (group M door).State} {v : Content World}
    (hlive : LiveClaim den C v) (hshut : ∀ i, door v i = false)
    (hex : Incompatible den C ((group M door).record s) v) :
    ¬ (group M door).Tracking C := by
  intro h
  have hsame : (group M door).revise s v = s := by
    funext i
    show (if door v i then (M i).revise (s i) v else s i) = s i
    rw [hshut i]
    rfl
  obtain ⟨w, hw, hr, hv⟩ := (h s v).1 hlive
  rw [hsame] at hr
  exact hex w hw ⟨hr, hv⟩

/-- The individual: a group of one, with the door always open. -/
def solo (M : Model World) : Model World :=
  group (fun _ : PUnit.{u+1} => M) (fun _ _ => true)

/-- **The individual obeys the same law.**  The one-member group tracks exactly
when its member does.  Nothing about the law changes between one model and
many. -/
theorem solo_tracking_iff (M : Model World) : (solo M).Tracking C ↔ M.Tracking C := by
  constructor
  · intro h s v
    have hs := h (fun _ => s) v
    refine ⟨fun hl => ?_, fun w hw hr => ?_⟩
    · obtain ⟨w, hw, ⟨_, hr⟩, hv⟩ := hs.1 hl
      exact ⟨w, hw, hr, hv⟩
    · rcases hs.2 w hw ⟨PUnit.unit, hr⟩ with ⟨_, h'⟩ | h'
      · exact Or.inl h'
      · exact Or.inr h'
  · intro hM
    exact group_tracks (fun _ => hM) (fun _ _ => ⟨PUnit.unit, rfl⟩)

/-- Union and consensus of member records. -/
def unionRecord (r : ι → Content World) : Content World := fun w => ∃ i, r i w
def consensusRecord (r : ι → Content World) : Content World := fun w => ∀ i, r i w

/-- The group's record is the union of its members' records. -/
theorem group_record_is_union (M : ι → Model World) (door : Content World → ι → Bool)
    (s : (group M door).State) :
    (group M door).record s = unionRecord (fun i => (M i).record (s i)) := rfl

/-- **Aggregation under the anchor.**
* Union keeps every member's live view admitted: no voice is lost by
  aggregation.
* When the anchor holds among the members and two distinct members exist,
  consensus is refuted in every candidate world.  So it admits no member's
  view, and it is wrong in the true world, whichever that is. -/
theorem aggregation_under_anchor (r : ι → Content World) :
    (∀ i, LiveClaim den C (r i) → Compatible den C (unionRecord r) (r i)) ∧
    (AnchorInEveryWorld (fun i w => r i w) C → ∀ {i j : ι}, i ≠ j →
      ∀ w, C w → ¬ consensusRecord r w) :=
  ⟨fun i ⟨w, hw, hr⟩ => ⟨w, hw, ⟨i, hr⟩, hr⟩,
   fun hA {i j} hij w hw hcons =>
     anchor_not_two (i := i) (j := j) (hA w hw) (hcons i) (hcons j) hij⟩

end Groups

/-! ## 3. Any depth -/

section Trees

variable {World : Type u}

/-- Groups of groups of any depth.  A leaf is a model, and a node is a group of
subtrees. -/
inductive Tree (World : Type u) : Type (u + 1)
  | leaf (M : Model World)
  | node (ι : Type u) (child : ι → Tree World) (door : Content World → ι → Bool)

/-- The model a tree denotes. -/
def Tree.model : Tree World → Model World
  | .leaf M => M
  | .node _ child door => group (fun i => (child i).model) door

variable (C : Content World)

/-- A sound tree: tracking leaves, and at every node an open door for every
live content. -/
inductive Tree.Sound : Tree World → Prop
  | leaf {M : Model World} : M.Tracking C → Tree.Sound (.leaf M)
  | node {ι : Type u} {child : ι → Tree World} {door : Content World → ι → Bool} :
      (∀ i, Tree.Sound (child i)) → Doors C door → Tree.Sound (.node ι child door)

variable {C}

/-- **Tracking at any depth.**  A sound tree of groups of groups tracks. -/
theorem sound_tree_tracks {t : Tree World} (h : t.Sound C) : t.model.Tracking C := by
  induction h with
  | leaf hM => exact hM
  | node _ hd ih => exact group_tracks ih hd

/-- **Provenance at any depth.**  A sound tree admits only candidate worlds it
admitted at the start or that someone voiced. -/
theorem tree_provenance {t : Tree World} (h : t.Sound C) (vs : List (Content World))
    (s : t.model.State) (w : World) (hw : C w) (hr : t.model.record (t.model.run s vs) w) :
    t.model.record s w ∨ ∃ v ∈ vs, v w :=
  provenance (sound_tree_tracks h) vs s w hw hr

/-- Two pairs as a depth-two tree: a group of two groups of two open models,
with every door open. -/
def twoPairsTree : Tree (Fin 3) :=
  .node Bool (fun _ => .node Bool (fun _ => .leaf openModel) (fun _ _ => true))
    (fun _ _ => true)

/-- Non-vacuity at depth two: the two-pair tree is sound, so it tracks and
obeys provenance. -/
theorem twoPairsTree_sound (C : Content (Fin 3)) : twoPairsTree.Sound C :=
  .node (fun _ => .node (fun _ => .leaf (open_tracks C)) (fun _ _ => ⟨true, rfl⟩))
    (fun _ _ => ⟨true, rfl⟩)

end Trees

/-! ## 4. Four persons: flat four versus two pairs -/

section FourPersons

/-- Two pairs: `a1, a2` and `b1, b2`. -/
inductive Person
  | a1 | a2 | b1 | b2
  deriving DecidableEq

/-- Flat four: everyone talks to everyone (twelve channels). -/
def flatEdge (i j : Person) : Prop := i ≠ j

/-- Two pairs, linked by their spokespersons `a1` and `b1` (six channels). -/
def pairsEdge : Person → Person → Prop
  | .a1, .a2 | .a2, .a1 | .b1, .b2 | .b2, .b1 | .a1, .b1 | .b1, .a1 => True
  | _, _ => False

/-- The inter-pair edges. -/
def crossing : Person → Person → Bool
  | .a1, .b1 | .b1, .a1 => true
  | _, _ => false

/-- Channels in the two-pair layout.  Inside a pair content passes unchanged.
Across pairs the interface applies `fwd`. -/
def pairsCh (fwd : Channel (Fin 3)) (i j : Person) : Channel (Fin 3) :=
  if crossing i j then fwd else fun v => v

def inA : Person → Bool
  | .a1 | .a2 => true
  | _ => false

theorem flat_sc : StronglyConnected flatEdge := by
  intro i j
  by_cases h : i = j
  · subst h; exact Reach.refl _
  · exact Reach.single h

theorem pairs_sc : StronglyConnected pairsEdge := by
  have to : ∀ i, Reach pairsEdge i .a1 := by
    intro i
    cases i
    · exact Reach.refl _
    · exact Reach.single trivial
    · exact Reach.single trivial
    · exact Reach.step (show pairsEdge .b2 .b1 from trivial)
        (Reach.single (show pairsEdge .b1 .a1 from trivial))
  have fr : ∀ j, Reach pairsEdge .a1 j := by
    intro j
    cases j
    · exact Reach.refl _
    · exact Reach.single trivial
    · exact Reach.single trivial
    · exact Reach.step (show pairsEdge .a1 .b1 from trivial)
        (Reach.single (show pairsEdge .b1 .b2 from trivial))
  exact fun i j => (to i).trans (fr j)

/-- **Four persons.**  Take members who track (for example `openModel`).
* Flat four: every voice is tracked by everyone.
* Two pairs forwarding content: the same, with half the channels.
* Two pairs forwarding position (a fixed `p`): every route from pair A to pair
  B is blind. -/
theorem four_person_benchmark (C : Content (Fin 3)) (M : Person → Model (Fin 3))
    (hM : ∀ k, (M k).Tracking C) (p : Content (Fin 3)) :
    (∀ i k, ∃ f, Relay flatEdge (fun _ _ v => v) i k f ∧ ((M k).via f).Tracking C) ∧
    (∀ i k, ∃ f, Relay pairsEdge (pairsCh (fun v => v)) i k f ∧ ((M k).via f).Tracking C) ∧
    (∀ i k f, Relay pairsEdge (pairsCh (fun _ => p)) i k f →
      inA i = true → inA k = false → Blind f) := by
  refine ⟨honest_network_tracks M flat_sc (fun _ _ _ => honest_id) hM,
    honest_network_tracks M pairs_sc
      (fun i j _ => by unfold pairsCh; split <;> exact honest_id) hM, ?_⟩
  intro i k f hf hi hk
  refine blind_cut (fun x => inA x = true) ?_ hf hi (by rw [hk]; decide)
  intro x y hx hy e
  cases x <;> cases y
  all_goals first
    | exact absurd hx (by decide)
    | exact absurd (by decide) hy
    | exact (e : False).elim
    | exact fun _ _ => rfl

/-- **Position forwarding silences the rivals in pair A.**  In pair A, `a1`
holds world 1 and `a2` holds world 2: rival views.  Take any member of pair B
whose record currently admits only world 0.  Through any route from pair A it
cannot track, whatever its revision rule.  With content forwarding it can
(`four_person_benchmark`). -/
theorem pairs_position_blocks (p : Content (Fin 3)) {i k : Person} {f : Channel (Fin 3)}
    (hf : Relay pairsEdge (pairsCh (fun _ => p)) i k f)
    (hi : inA i = true) (hk : inA k = false)
    (M : Model (Fin 3)) (s : M.State) (hrec : ∀ w, M.record s w → w = 0) :
    ¬ (M.via f).Tracking (fun _ => True) := by
  have hblind := (four_person_benchmark (fun _ => True) (fun _ => openModel)
    (fun _ => open_tracks _) p).2.2 i k f hf hi hk
  refine blind_channel_blocks (s := s) (v₁ := fun w => w = 1) (v₂ := fun w => w = 2) hblind
    ?_ ⟨1, trivial, rfl⟩ ?_
  · intro w _ ⟨h1, h2⟩
    rw [h1] at h2
    exact absurd h2 (by decide)
  · intro w _ ⟨h0, h1⟩
    rw [hrec w h0] at h1
    exact absurd h1 (by decide)

end FourPersons

end Anchored.Network
