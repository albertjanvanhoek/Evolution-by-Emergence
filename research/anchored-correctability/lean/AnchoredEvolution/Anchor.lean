/-!
# Layer 0 and Layer 1: the anchor and the relational skeleton it forces

**Layer 0, the anchor.**  Pairwise incompatible models cannot all be correct.
The core theorems are constructive: they use no excluded middle, only the
meaning of incompatibility.

**Layer 1, the skeleton.**  Add two explicit premises:

* *liveness*: no model has been refuted by evidence, so each model is correct
  in at least one candidate world;
* *the aim*: in every candidate world, the correct model's correction can reach
  every model.

With the anchor, these give the relational part of every model:

* no model can be treated as fact (`open_room_no_guarantee`);
* every missing route leaves a live scenario in which the system is wrong and
  cannot be corrected (`missing_route_leaves_uncorrectable_error`);
* the correction graph must be strongly connected
  (`live_and_aim_force_strong_connectivity`).

Every premise that is not the anchor appears as a named hypothesis.  No
normative or empirical content is hidden in a definition.
-/

universe u v

namespace Anchored

/-! ## Layer 0: the anchor, for any number of models -/

section AnchorCore

variable {ι : Type u} (claim : ι → Prop)

/-- Models indexed by `ι` are pairwise incompatible: no two distinct models are
correct together.  `ι` may be persons, times of one person, or groups. -/
def PairwiseIncompatible : Prop :=
  ∀ i j : ι, i ≠ j → ¬ (claim i ∧ claim j)

variable {claim}

/-- **The anchor (constructive).**  Two correct models cannot be distinct. -/
theorem anchor_not_two (h : PairwiseIncompatible claim) {i j : ι}
    (hi : claim i) (hj : claim j) : ¬ i ≠ j :=
  fun hne => h i j hne ⟨hi, hj⟩

/-- The anchor with decidable identity: at most one model is correct.
This still uses no classical axiom. -/
theorem anchor_at_most_one [DecidableEq ι] (h : PairwiseIncompatible claim)
    {i j : ι} (hi : claim i) (hj : claim j) : i = j :=
  if hij : i = j then hij else absurd hij (anchor_not_two h hi hj)

/-- If one model is correct, every other model is wrong (constructive). -/
theorem anchor_others_wrong (h : PairwiseIncompatible claim) {i : ι}
    (hi : claim i) : ∀ j, j ≠ i → ¬ claim j :=
  fun j hji hj => h j i hji ⟨hj, hi⟩

/-- **The anchor as a statement about the whole room (classical).**  There is
one index such that every other model is wrong.  Nobody needs to know which
index it is. -/
theorem anchor_all_but_one_wrong [Nonempty ι] (h : PairwiseIncompatible claim) :
    ∃ i, ∀ j, j ≠ i → ¬ claim j := by
  classical
  by_cases hex : ∃ i, claim i
  · obtain ⟨i, hi⟩ := hex
    exact ⟨i, anchor_others_wrong h hi⟩
  · obtain ⟨i⟩ := (inferInstance : Nonempty ι)
    exact ⟨i, fun j _ hj => hex ⟨j, hj⟩⟩

/-- **The anchor lifts to groups (constructive).**  Suppose each group's
consensus entails the claim of a representative member, and distinct groups
have distinct representatives.  Then the group models are pairwise
incompatible, so the anchor holds again one level up. -/
theorem anchor_lifts {κ : Type v} {group : κ → Prop} (rep : κ → ι)
    (h : PairwiseIncompatible claim)
    (hent : ∀ g, group g → claim (rep g))
    (hinj : ∀ g g', rep g = rep g' → g = g') :
    PairwiseIncompatible group :=
  fun g g' hne ⟨hg, hg'⟩ =>
    h (rep g) (rep g') (fun heq => hne (hinj g g' heq)) ⟨hent g hg, hent g' hg'⟩

/-- The anchor as a single proposition that every agent can hold. -/
def AnchorProp (claim : ι → Prop) : Prop :=
  PairwiseIncompatible claim → ∀ i j, claim i → claim j → ¬ i ≠ j

/-- The anchor is true for any family of models (constructive). -/
theorem anchor_true (claim : ι → Prop) : AnchorProp claim :=
  fun h _ _ hi hj => anchor_not_two h hi hj

/-- **Reflexive stability.**  Any model incompatible with the anchor is false.
Applying the Room to the anchor cannot unseat it, so every agent can hold it at
once without the anchor itself becoming one of the incompatible certainties. -/
theorem anchor_has_no_true_rival (claim : ι → Prop) (Q : Prop)
    (hinc : ¬ (AnchorProp claim ∧ Q)) : ¬ Q :=
  fun hq => hinc ⟨anchor_true claim, hq⟩

end AnchorCore

/-! ## Certainty is not a truth certificate: the scenario version

A model's standing is judged across the **candidate worlds**: the scenarios
that evidence has not ruled out.  Certainty is internal, so it is the same in
every candidate world, and it cannot by itself remove a world from the
candidate set.

* `holds a w`: model `a` is correct in world `w`.
* `Live a`: some candidate world makes `a` correct, so evidence has not refuted
  `a`.
* `Guaranteed a`: every candidate world makes `a` correct, so `a` could be
  treated as fact.

The anchor applies inside each world.
-/

section Worlds

variable {Agent : Type u} {World : Type v}
variable (holds : Agent → World → Prop) (Candidate : World → Prop)

/-- The anchor in every candidate world: the models are pairwise
incompatible. -/
def AnchorInEveryWorld : Prop :=
  ∀ w, Candidate w → PairwiseIncompatible (fun a => holds a w)

/-- Model `a` is correct in some candidate world: not refuted by evidence. -/
def Live (a : Agent) : Prop :=
  ∃ w, Candidate w ∧ holds a w

/-- Model `a` is correct in every candidate world. -/
def Guaranteed (a : Agent) : Prop :=
  ∀ w, Candidate w → holds a w

variable {holds Candidate}

/-- **A live rival rules out a guarantee (constructive, uses the anchor).**
If a rival model is correct in some candidate world, my model is wrong in that
world, so it is not guaranteed. -/
theorem live_rival_blocks_guarantee (hA : AnchorInEveryWorld holds Candidate)
    {a b : Agent} (hba : b ≠ a) (hb : Live holds Candidate b) :
    ¬ Guaranteed holds Candidate a := by
  intro hga
  obtain ⟨w, hw, hbw⟩ := hb
  exact hA w hw b a hba ⟨hbw, hga w hw⟩

/-- **The open room (constructive).**  If every model is live and every model
has a rival, no model is guaranteed.  From inside the room, no one's certainty
can be taken as fact. -/
theorem open_room_no_guarantee (hA : AnchorInEveryWorld holds Candidate)
    (hlive : ∀ a, Live holds Candidate a)
    (hrival : ∀ a : Agent, ∃ b : Agent, b ≠ a) :
    ∀ a, ¬ Guaranteed holds Candidate a := by
  intro a
  obtain ⟨b, hba⟩ := hrival a
  exact live_rival_blocks_guarantee hA hba (hlive b)

/-- **A guarantee would seal every rival (uses the anchor).**  The only
certainty-based ground for treating a rival as refuted is a guarantee of one's
own model.  Given a guarantee, every rival is wrong in every candidate world. -/
theorem guarantee_would_refute_rivals (hA : AnchorInEveryWorld holds Candidate)
    {a b : Agent} (hba : b ≠ a) (hga : Guaranteed holds Candidate a) :
    ∀ w, Candidate w → ¬ holds b w :=
  fun w hw hbw => hA w hw b a hba ⟨hbw, hga w hw⟩

end Worlds

/-! ### Diagnostic: why the factual reading of "truth guarantee" is too weak -/

section FactualGuarantee

variable {Agent : Type u} (Certain : Agent → Prop → Prop)

/-- Factual reading: every proposition the agent is certain of happens to be
true in the actual world.  This is the reading used in `TheRoom.lean`. -/
def TruthGuaranteed (a : Agent) : Prop :=
  ∀ P : Prop, Certain a P → P

/-- Symmetry premise stated with the factual reading. -/
def NoPrivilegedTruthAccess (SameStanding : Agent → Agent → Prop) : Prop :=
  ∀ a b, SameStanding a b → (TruthGuaranteed Certain a ↔ TruthGuaranteed Certain b)

variable {Certain}

/-- **Diagnostic.**  Under the factual reading, the symmetry premise is false in
exactly the situation the Room cares about: one agent happens to be right and
the other does not.  Theorems that assume the premise then apply only in worlds
where everyone is already wrong.  The scenario version above (`Live`,
`Guaranteed`) avoids this: it is satisfiable in a world where one model is
right. -/
theorem factual_symmetry_fails_when_someone_is_right
    (SameStanding : Agent → Agent → Prop) {a b : Agent}
    (hsame : SameStanding a b)
    (ha : TruthGuaranteed Certain a) (hb : ¬ TruthGuaranteed Certain b) :
    ¬ NoPrivilegedTruthAccess Certain SameStanding :=
  fun hnp => hb ((hnp a b hsame).1 ha)

end FactualGuarantee

/-! ## Correction routes -/

section Routes

variable {α : Type u} (Edge : α → α → Prop)

/-- A correction route: a finite chain of correction edges.  `Edge a b` means
that correction originating in model `a` can enter model `b`. -/
inductive Reach : α → α → Prop
  | refl (a : α) : Reach a a
  | step {a b c : α} : Edge a b → Reach b c → Reach a c

/-- Every model's correction can reach every model. -/
def StronglyConnected : Prop :=
  ∀ a b : α, Reach Edge a b

variable {Edge}

theorem Reach.trans {a b c : α} (h₁ : Reach Edge a b) (h₂ : Reach Edge b c) :
    Reach Edge a c := by
  induction h₁ with
  | refl _ => exact h₂
  | step e _ ih => exact Reach.step e (ih h₂)

theorem Reach.single {a b : α} (e : Edge a b) : Reach Edge a b :=
  Reach.step e (Reach.refl b)

/-- Reachability ends with a last edge, unless the route is trivial. -/
theorem Reach.last {a b : α} (h : Reach Edge a b) :
    a = b ∨ ∃ c, Reach Edge a c ∧ Edge c b := by
  induction h with
  | refl x => exact Or.inl rfl
  | @step x y z e _ ih =>
      cases ih with
      | inl hyz => exact Or.inr ⟨x, Reach.refl x, hyz ▸ e⟩
      | inr hex =>
          obtain ⟨c, hyc, hcz⟩ := hex
          exact Or.inr ⟨c, Reach.step e hyc, hcz⟩

/-- **Closed sets are traps.**  If a set of models has no correction edge
leaving it, no route leaves it.  This is the graph form of self-sealing. -/
theorem closed_set_traps (S : α → Prop)
    (hclosed : ∀ x y, S x → Edge x y → S y) {a b : α}
    (h : Reach Edge a b) (ha : S a) : S b := by
  induction h with
  | refl _ => exact ha
  | step e _ ih => exact ih (hclosed _ _ ha e)

/-- Reachability is preserved when every old edge remains realizable by some
route in the new graph. -/
theorem Reach.simulate {E₁ E₂ : α → α → Prop}
    (hsim : ∀ a b, E₁ a b → Reach E₂ a b) {x y : α}
    (h : Reach E₁ x y) : Reach E₂ x y := by
  induction h with
  | refl a => exact Reach.refl a
  | step e _ ih => exact (hsim _ _ e).trans ih

end Routes

/-! ## Layer 1: the anchor forces the relational skeleton -/

section Skeleton

variable {Agent : Type u} {World : Type v}
variable (holds : Agent → World → Prop) (Candidate : World → Prop)
variable (Edge : Agent → Agent → Prop)

/-- **The aim, an explicit chosen premise.**  In every candidate world, the
correct model's correction can reach every model.  The system aims to stay
correctable in whichever scenario turns out to be actual, without knowing
which. -/
def CorrectabilityAim : Prop :=
  ∀ w, Candidate w → ∀ a, holds a w → ∀ d, Reach Edge a d

variable {holds Candidate Edge}

/-- **Liveness + aim ⇒ strong connectivity (constructive).**  If no model is
refuted by evidence, the aim forces every model's correction to reach every
model.  The anchor's role is to ensure that certainty cannot remove liveness
(`open_room_no_guarantee`, `guarantee_would_refute_rivals`); only evidence
can. -/
theorem live_and_aim_force_strong_connectivity
    (hlive : ∀ a, Live holds Candidate a)
    (haim : CorrectabilityAim holds Candidate Edge) :
    StronglyConnected Edge := by
  intro a d
  obtain ⟨w, hw, haw⟩ := hlive a
  exact haim w hw a haw d

/-- **Every missing route leaves an uncorrectable error (constructive, uses the
anchor).**  Suppose:
* the system protects routes only for a working set of worlds `Working`;
* model `b` is live on the evidential set `Candidate`;
* the route from `b` to `d` is missing.

Then some evidentially open world exists that the working set dropped.  In that
world `b` is right, every other model (including `d`) is wrong, and `b`'s
correction cannot reach `d`.  The system has made itself uncorrectable in
exactly the scenario in which it is wrong. -/
theorem missing_route_leaves_uncorrectable_error
    (Working : World → Prop)
    (hA : AnchorInEveryWorld holds Candidate)
    (haim : CorrectabilityAim holds Working Edge)
    {b d : Agent} (hb : Live holds Candidate b) (hmiss : ¬ Reach Edge b d) :
    ∃ w, Candidate w ∧ ¬ Working w ∧ holds b w ∧
      (∀ a, a ≠ b → ¬ holds a w) := by
  obtain ⟨w, hw, hbw⟩ := hb
  refine ⟨w, hw, ?_, hbw, ?_⟩
  · intro hwork
    exact hmiss (haim w hwork b hbw d)
  · intro a hab haw
    exact hA w hw a b hab ⟨haw, hbw⟩

end Skeleton

end Anchored
