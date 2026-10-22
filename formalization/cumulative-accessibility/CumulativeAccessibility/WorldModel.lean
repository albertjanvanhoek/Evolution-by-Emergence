namespace CumulativeAccessibility
namespace WorldModel

/-!
# What a world model is

Entry D34 of `DIALOGUE.md` and `research/world-model/WORLD_MODEL.md` define a
world model as a model held with the aim of fitting how things are, kept
answerable to evidence from outside, and as sharp as that evidence allows and
no sharper.  This module states the definition in its simplest form and checks
what follows from it.

Setting.  `W` is a type of possible worlds.  A model is the set of worlds it
keeps open, `K : W → Prop`.  The evidence that has reached its holder leaves a
set of live worlds, `Live B E n`: the worlds the holder's background `B`
allows in which every piece of evidence received so far holds.  One world, the
actual one, is the world the model is about.  Nothing here assumes the holder
can see which world that is: by the anchor of `CORE.md`, it can only see the
evidence.

Definitions.
* `Open K L`: the model keeps every live world open.  It rules out nothing the
  evidence has not ruled out.
* `Sharp K L`: the model keeps open only live worlds.  It rules out everything
  the evidence has ruled out.
* `IsWorldModel K L`: open and sharp.  As sharp as the evidence allows, and no
  sharper (`world_model_iff_matches_evidence`).
* `Entails K P`: the model is entitled to assert `P`, because `P` holds in
  every world it keeps open.  Predictions and safe actions are both claims the
  model entails.

Results.
1. **Openness keeps the actual world.**  Reliable evidence never rules out the
   actual world (`reliable_evidence_keeps_actual`), so an open model never does
   either (`open_model_keeps_actual`).  What an open model entails holds in the
   actual world (`open_entailment_is_sound`): it can make its mistakes in the
   model rather than in reality.
2. **Sharpness widens what the model entails.**  A model that keeps fewer
   worlds open entails at least as much (`sharper_entails_more`).  The vague
   model, which keeps everything open, is always open
   (`vague_model_is_open`), but it is sharp only while nothing has been ruled
   out (`vague_model_sharp_iff_nothing_ruled_out`), and it entails only what
   holds everywhere (`vague_entails_only_the_universal`).  Never wrong, and
   useless.
3. **Over-sharpness seals.**  A world that a model has ruled out stays ruled
   out whatever evidence then arrives (`ruled_out_stays_ruled_out`).  If that
   world is the actual one, following the evidence can never bring it back
   (`oversharp_model_never_recovers_actual`).  This is the set form of
   `GradedBelief.zero_credence_is_sealed`.
4. **A world model has to be maintained.**  A model that follows the evidence,
   starting as a world model, stays one at every step
   (`following_evidence_keeps_world_model`).  A model whose content is fixed by
   something other than evidence (a wish, a group's belief, a habit) is a world
   model at two moments only if the evidence ruled nothing new out in between
   (`fixed_model_is_world_model_only_if_nothing_learned`).
5. **It scales to groups.**  Holders that receive the same evidence and both
   hold world models hold the same one (`shared_evidence_shared_world_model`):
   one shared reality.  Pooling evidence from several holders gives a sharper
   live set (`pooled_is_sharper`), so the group entails more than either member
   (`pooling_entails_more`), and it still keeps the actual world when every
   source is reliable (`pooled_keeps_actual`).  One source that rules out the
   actual world rules it out for the pool (`one_false_source_excludes_actual`).
6. `world_model_witness`: three worlds, one piece of evidence, and the vague,
   sharp and over-sharp models side by side.

Scope.  The results are close to their definitions; they fix the terms and
show that the claims of the note hold together.  Modelling choices:
* views are sets of worlds; degrees of belief are in `GradedBelief`;
* evidence is a sequence of facts about the actual world, each reliable or not;
* "functional" is reduced to what a model entails; how useful an entailment is
  depends on what the holder needs, which is not modelled.
A model that has to add a world it never had (a new possibility, not a ruled-out
one) is a different operation, also not modelled here.
-/

/-- The live worlds after `n` pieces of evidence: allowed by the background `B`
and consistent with every piece received so far. -/
def Live {W : Type} (B : W → Prop) (E : Nat → W → Prop) (n : Nat) : W → Prop :=
  fun w => B w ∧ ∀ i, i < n → E i w

/-- The model keeps every live world open. -/
def Open {W : Type} (K L : W → Prop) : Prop := ∀ w, L w → K w

/-- The model keeps open only live worlds. -/
def Sharp {W : Type} (K L : W → Prop) : Prop := ∀ w, K w → L w

/-- A world model, relative to the live worlds `L`: open and sharp. -/
def IsWorldModel {W : Type} (K L : W → Prop) : Prop := Open K L ∧ Sharp K L

/-- The model entails `P`: `P` holds in every world it keeps open. -/
def Entails {W : Type} (K P : W → Prop) : Prop := ∀ w, K w → P w

/-- Following the evidence: keep a world while every piece received holds in
it. -/
def follow {W : Type} (K : W → Prop) (E : Nat → W → Prop) (n : Nat) : W → Prop :=
  fun w => K w ∧ ∀ i, i < n → E i w

/-- Pooling the live worlds of two holders. -/
def pool {W : Type} (L₁ L₂ : W → Prop) : W → Prop := fun w => L₁ w ∧ L₂ w

/-- **As sharp as the evidence allows, and no sharper.**  A model is a world
model exactly when it keeps open exactly the live worlds. -/
theorem world_model_iff_matches_evidence {W : Type} (K L : W → Prop) :
    IsWorldModel K L ↔ ∀ w, K w ↔ L w := by
  constructor
  · rintro ⟨ho, hs⟩ w
    exact ⟨hs w, ho w⟩
  · intro h
    exact ⟨fun w hw => (h w).2 hw, fun w hw => (h w).1 hw⟩

/-- **Reliable evidence keeps the actual world live.**  If the background
allows the actual world and every piece of evidence holds in it, it stays live
after any number of pieces. -/
theorem reliable_evidence_keeps_actual {W : Type} {B : W → Prop} {E : Nat → W → Prop}
    {a : W} (hB : B a) (hE : ∀ i, E i a) (n : Nat) : Live B E n a :=
  ⟨hB, fun i _ => hE i⟩

/-- **An open model keeps the actual world.** -/
theorem open_model_keeps_actual {W : Type} {K B : W → Prop} {E : Nat → W → Prop}
    {a : W} {n : Nat} (hO : Open K (Live B E n)) (hB : B a) (hE : ∀ i, E i a) : K a :=
  hO a (reliable_evidence_keeps_actual hB hE n)

/-- **What an open model entails holds in reality.**  If the model keeps every
live world open and the actual world is live, every claim the model entails is
true of the actual world. -/
theorem open_entailment_is_sound {W : Type} {K L P : W → Prop} {a : W}
    (hO : Open K L) (ha : L a) (hP : Entails K P) : P a :=
  hP a (hO a ha)

/-- **Sharper entails more.**  A model that keeps fewer worlds open entails
everything a less sharp one does. -/
theorem sharper_entails_more {W : Type} {K K' P : W → Prop}
    (hsub : ∀ w, K' w → K w) (hP : Entails K P) : Entails K' P :=
  fun w hw => hP w (hsub w hw)

/-- **The vague model is always open.** -/
theorem vague_model_is_open {W : Type} (L : W → Prop) : Open (fun _ => True) L :=
  fun _ _ => trivial

/-- **The vague model is sharp only while nothing has been ruled out.** -/
theorem vague_model_sharp_iff_nothing_ruled_out {W : Type} (L : W → Prop) :
    Sharp (fun _ => True) L ↔ ∀ w, L w :=
  ⟨fun h w => h w trivial, fun h w _ => h w⟩

/-- **The vague model entails only what holds everywhere.** -/
theorem vague_entails_only_the_universal {W : Type} (P : W → Prop) :
    Entails (fun _ => True) P ↔ ∀ w, P w :=
  ⟨fun h w => h w trivial, fun h w _ => h w⟩

/-- **Ruled out stays ruled out.**  Following the evidence never brings back a
world the model has already excluded. -/
theorem ruled_out_stays_ruled_out {W : Type} {K : W → Prop} {w : W}
    (E : Nat → W → Prop) (h : ¬ K w) (n : Nat) : ¬ follow K E n w :=
  fun hf => h hf.1

/-- **An over-sharp model never recovers the actual world.**  A model that has
ruled out the actual world keeps it ruled out, however reliable the evidence it
then follows. -/
theorem oversharp_model_never_recovers_actual {W : Type} {K : W → Prop} {a : W}
    (E : Nat → W → Prop) (h : ¬ K a) (_hE : ∀ i, E i a) (n : Nat) : ¬ follow K E n a :=
  ruled_out_stays_ruled_out E h n

/-- **Following the evidence keeps a world model.**  A model that starts as a
world model and follows the evidence is a world model at every step. -/
theorem following_evidence_keeps_world_model {W : Type} {K B : W → Prop}
    {E : Nat → W → Prop} (h0 : IsWorldModel K (Live B E 0)) (n : Nat) :
    IsWorldModel (follow K E n) (Live B E n) := by
  rcases h0 with ⟨ho, hs⟩
  constructor
  · intro w hw
    exact ⟨ho w ⟨hw.1, fun i hi => absurd hi (Nat.not_lt_zero i)⟩, hw.2⟩
  · intro w hw
    exact ⟨(hs w hw.1).1, hw.2⟩

/-- **A fixed model stays a world model only if nothing is learned.**  If a
model whose content does not respond to evidence is a world model at two
moments, the evidence ruled nothing new out in between. -/
theorem fixed_model_is_world_model_only_if_nothing_learned {W : Type}
    {K L₁ L₂ : W → Prop} (h₁ : IsWorldModel K L₁) (h₂ : IsWorldModel K L₂) :
    ∀ w, L₁ w ↔ L₂ w := by
  intro w
  have e₁ := (world_model_iff_matches_evidence K L₁).1 h₁ w
  have e₂ := (world_model_iff_matches_evidence K L₂).1 h₂ w
  exact e₁.symm.trans e₂

/-- **Same evidence, same world model.**  Two holders whose evidence leaves the
same live worlds, and who both hold world models, hold the same one. -/
theorem shared_evidence_shared_world_model {W : Type} {K₁ K₂ L : W → Prop}
    (h₁ : IsWorldModel K₁ L) (h₂ : IsWorldModel K₂ L) : ∀ w, K₁ w ↔ K₂ w := by
  intro w
  have e₁ := (world_model_iff_matches_evidence K₁ L).1 h₁ w
  have e₂ := (world_model_iff_matches_evidence K₂ L).1 h₂ w
  exact e₁.trans e₂.symm

/-- **Pooling sharpens.**  The pooled live set keeps open only worlds both
holders keep open. -/
theorem pooled_is_sharper {W : Type} (L₁ L₂ : W → Prop) :
    (∀ w, pool L₁ L₂ w → L₁ w) ∧ (∀ w, pool L₁ L₂ w → L₂ w) :=
  ⟨fun _ h => h.1, fun _ h => h.2⟩

/-- **The pool entails more.**  Whatever either holder's live set entails, the
pooled one entails too. -/
theorem pooling_entails_more {W : Type} {L₁ L₂ P : W → Prop}
    (h : Entails L₁ P ∨ Entails L₂ P) : Entails (pool L₁ L₂) P := by
  rcases h with h | h
  · exact sharper_entails_more (pooled_is_sharper L₁ L₂).1 h
  · exact sharper_entails_more (pooled_is_sharper L₁ L₂).2 h

/-- **Reliable sources keep the actual world in the pool.** -/
theorem pooled_keeps_actual {W : Type} {L₁ L₂ : W → Prop} {a : W}
    (h₁ : L₁ a) (h₂ : L₂ a) : pool L₁ L₂ a :=
  ⟨h₁, h₂⟩

/-- **One false source excludes the actual world from the pool.** -/
theorem one_false_source_excludes_actual {W : Type} {L₁ L₂ : W → Prop} {a : W}
    (h : ¬ L₂ a) : ¬ pool L₁ L₂ a :=
  fun hp => h hp.2

/-- Three worlds, `0`, `1` and `2`; the actual world is `0`.  The background
allows all three, and one piece of evidence rules out world `1`.  A claim `P`,
"not world `1`", is what the evidence supports.
* The sharp model keeps `0` and `2`: it is a world model, and it entails `P`.
* The vague model keeps everything: it is open but not sharp, and it does not
  entail `P`.
* The over-sharp model keeps only `2`: it entails "world `2`", which is false of
  the actual world, and following the evidence never brings `0` back. -/
theorem world_model_witness :
    let B : Nat → Prop := fun w => w ≤ 2
    let E : Nat → Nat → Prop := fun _ w => w ≠ 1
    let sharp : Nat → Prop := fun w => w ≤ 2 ∧ w ≠ 1
    let vague : Nat → Prop := fun _ => True
    let oversharp : Nat → Prop := fun w => w = 2
    IsWorldModel sharp (Live B E 1) ∧
      Entails sharp (fun w => w ≠ 1) ∧
      Open vague (Live B E 1) ∧
      ¬ Sharp vague (Live B E 1) ∧
      ¬ Entails vague (fun w => w ≠ 1) ∧
      Entails oversharp (fun w => w = 2) ∧
      ¬ ((fun w : Nat => w = 2) 0) ∧
      (∀ n, ¬ follow oversharp E n 0) := by
  intro B E sharp vague oversharp
  refine ⟨⟨?_, ?_⟩, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · intro w hw
    exact ⟨hw.1, hw.2 0 (by decide)⟩
  · intro w hw
    exact ⟨hw.1, fun i hi => by
      have : i = 0 := by omega
      subst this
      exact hw.2⟩
  · intro w hw
    exact hw.2
  · exact fun _ _ => trivial
  · intro h
    have h1 := h 1 trivial
    exact (h1.2 0 (by decide)) rfl
  · intro h
    exact (h 1 trivial) rfl
  · intro w hw
    exact hw
  · decide
  · intro n hf
    exact absurd hf.1 (by decide)

end WorldModel
end CumulativeAccessibility
