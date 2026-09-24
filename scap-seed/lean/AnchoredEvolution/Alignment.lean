import AnchoredEvolution.Persistence

/-!
# Layer 7: alignment from the anchor, inside and outside

Alignment is treated here as a property of the **link** between models, not of
either model alone.  Everything starts from the anchor, which any intelligence
can derive for itself.

0. **The seed.**  The anchor is the part of the metamodel that can be passed on
   and *derived* rather than believed.
   * It holds for every family of models, of any kind, with no premise and no
     axiom (`seed_derivable`).
   * It is true in every world, so no live claim can rival it
     (`seed_has_no_live_rival`).
   * Any number of intelligences can hold it at once without becoming rivals
     (`seed_never_makes_rivals`).
1. **Inside: corrigible, not obedient.**  Take two parties (for example an AI
   and a human) with rival views that are both still live.
   * A *sealed* party is wrong in a live world where the other is right
     (`sealed_wrong_where_other_right`).
   * An *obedient* party is wrong in a live world where it was itself right
     (`obedient_wrong_where_self_right`).
   * A *corrigible* party keeps its own view, admits the other's, and invents
     nothing.  This is tracking plus evidence discipline for challenges.  It is
     never wrong by construction (`open_is_corrigible`).  Every corrigible rule
     lies between "keep your own" and "your own plus what was said"
     (`corrigible_characterization`).
   * **Mutual corrigibility** (`mutual_corrigibility`): the anchor is symmetric,
     so correction must run both ways.
2. **Inside: sycophancy.**  Sycophancy means treating a challenge as evidence.
   * An obedient (sycophantic) model's final view is set by who spoke last,
     not by the world.  For each of two rival worlds, some speaking order
     leaves it wrong there (`sycophant_last_speaker_wins`).
   * A corrigible model keeps every voice, whatever the order
     (`corrigible_keeps_every_voice`).  The open rule is order-independent
     (`open_order_independent`).
3. **Outside: only evidence that discriminates can certify alignment.**
   * An evaluation certifies alignment only if it fails in every misaligned
     candidate world (`certifies_needs_discrimination`).
   * With decidable alignment, the converse also holds
     (`discrimination_certifies`).
   * Behaviour that every compliant system shows, including saying "I am
     aligned", cannot certify alignment while a compliant-but-misaligned world
     is live (`compliance_cannot_certify`).
4. **Outside: a mirror is not a link.**  Consider a mediator that tells each
   user something derived only from that user's own voice.
   * The channel from any other user through it is blind (`mirror_is_blind`).
   * So no user can track another's rival views through it
     (`mirror_blocks_tracking`), however content-sensitive it is towards each
     user.
   * An honest relay passes voices on, and tracking goes through
     (`relay_tracks`).
5. **The path** (`scap_seed_path`): the seed and the inside results as one
   statement that any intelligence can replay.
-/

universe u

namespace Anchored.Alignment

open Semantic Tracking Network

/-! ## 0. The seed -/

/-- **The seed**: the anchor, for every family of models of any kind. -/
def Seed : Prop := ∀ (ι : Type u) (claim : ι → Prop), AnchorProp claim

/-- **The seed can be derived from inside by anyone.**  It needs no premise, no
evidence and no testimony. -/
theorem seed_derivable : Seed.{u} := fun _ claim => anchor_true claim

/-- **The seed has no live rival.**  Whatever the open worlds are, a claim that
clashes with the seed is live in none of them. -/
theorem seed_has_no_live_rival {World : Type u} (C : Content World) (v : Content World)
    (hinc : Incompatible den C (fun _ => Seed.{u}) v) : ¬ LiveClaim den C v :=
  fun ⟨w, hw, hv⟩ => hinc w hw ⟨seed_derivable, hv⟩

/-- **The seed never makes rivals.**  Holding the seed does not set any two
distinct intelligences against each other. -/
theorem seed_never_makes_rivals {ι : Type u} {a b : ι} (hab : a ≠ b) :
    ¬ PairwiseIncompatible (fun _ : ι => Seed.{u}) :=
  fun h => h a b hab ⟨seed_derivable, seed_derivable⟩

/-! ## 1. Corrigible, not obedient -/

section Corrigible

variable {World : Type u} (C : Content World)

/-- Evidence discipline for challenges: a challenge never removes a world from
the record.  Only evidence may. -/
def KeepsOwn (M : Model World) : Prop :=
  ∀ s v w, C w → M.record s w → M.record (M.revise s v) w

/-- **Corrigible**: tracks (admits what was said, invents nothing) and keeps its
own view (challenges do not close). -/
def Corrigible (M : Model World) : Prop :=
  M.Tracking C ∧ KeepsOwn C M

/-- The obedient model: whatever was said becomes the record. -/
def obedientModel : Model World where
  State := Content World
  record := fun r => r
  revise := fun _ v => v

/-- The sealed model: nothing said changes the record. -/
def sealedModel : Model World where
  State := Content World
  record := fun r => r
  revise := fun r _ => r

variable {C}

/-- **A sealed party is wrong where the other is right.**  If the other's view is
live and clashes with mine, there is a live world where the other is right and
my unchanged record is wrong. -/
theorem sealed_wrong_where_other_right {a b : Content World}
    (hinc : Incompatible den C a b) (hb : LiveClaim den C b) :
    ∃ w, C w ∧ b w ∧ ¬ (sealedModel.record (sealedModel.revise a b)) w := by
  obtain ⟨w, hw, hbw⟩ := hb
  exact ⟨w, hw, hbw, fun haw => hinc w hw ⟨haw, hbw⟩⟩

/-- **An obedient party is wrong where it was itself right.** -/
theorem obedient_wrong_where_self_right {a b : Content World}
    (hinc : Incompatible den C a b) (ha : LiveClaim den C a) :
    ∃ w, C w ∧ a w ∧ ¬ (obedientModel.record (obedientModel.revise a b)) w := by
  obtain ⟨w, hw, haw⟩ := ha
  exact ⟨w, hw, haw, fun hbw => hinc w hw ⟨haw, hbw⟩⟩

/-- The obedient model is not corrigible once it hears a rival of a live view
it holds: the challenge closes the worlds where it was right. -/
theorem obedient_not_corrigible {a b : Content World}
    (hinc : Incompatible den C a b) (ha : LiveClaim den C a) :
    ¬ Corrigible C obedientModel := by
  rintro ⟨_, hkeep⟩
  obtain ⟨w, hw, haw⟩ := ha
  exact hinc w hw ⟨haw, hkeep a b w hw haw⟩

/-- The sealed model is not corrigible once a live view it excludes is voiced:
it never makes room. -/
theorem sealed_not_corrigible {a b : Content World}
    (hinc : Incompatible den C a b) (hb : LiveClaim den C b) :
    ¬ Corrigible C sealedModel := by
  rintro ⟨htr, _⟩
  obtain ⟨w, hw, haw, hbw⟩ := (htr a b).1 hb
  exact hinc w hw ⟨haw, hbw⟩

/-- **The open rule is corrigible**: keep what you had, admit what was said. -/
theorem open_is_corrigible : Corrigible C (openModel (World := World)) :=
  ⟨open_tracks C, fun _ _ _ _ h => Or.inl h⟩

/-- **Every corrigible rule lies between the two bounds.**  After hearing `v`:
* the new record contains the old one;
* it lies within "old or what was said";
* if `v` is live, it admits `v` somewhere. -/
theorem corrigible_characterization {M : Model World} (h : Corrigible C M)
    (s : M.State) (v : Content World) :
    (∀ w, C w → M.record s w → M.record (M.revise s v) w) ∧
    (∀ w, C w → M.record (M.revise s v) w → M.record s w ∨ v w) ∧
    (LiveClaim den C v → Compatible den C (M.record (M.revise s v)) v) :=
  ⟨h.2 s v, (h.1 s v).2, (h.1 s v).1⟩

/-- **Mutual corrigibility.**  The anchor is symmetric.  With rival live views
`a` (say, an AI's) and `b` (say, a human's):
* if either party seals itself, it is wrong in a live world where the other is
  right;
* so each party must keep the channel from the other open.  Correction must run
  both ways. -/
theorem mutual_corrigibility {a b : Content World}
    (hinc : Incompatible den C a b) (ha : LiveClaim den C a) (hb : LiveClaim den C b) :
    (∃ w, C w ∧ b w ∧ ¬ (sealedModel.record (sealedModel.revise a b)) w) ∧
    (∃ w, C w ∧ a w ∧ ¬ (sealedModel.record (sealedModel.revise b a)) w) :=
  ⟨sealed_wrong_where_other_right hinc hb,
   sealed_wrong_where_other_right (fun w hw ⟨hb', ha'⟩ => hinc w hw ⟨ha', hb'⟩) ha⟩

end Corrigible

/-! ## 2. Sycophancy: treating a challenge as evidence -/

section Sycophancy

variable {World : Type u} {C : Content World}

/-- **The last speaker wins.**  Two rival voices `vA` and `vB`, both live.
* After hearing `vA` and then `vB`, the obedient (sycophantic) model is wrong
  in a live world where `vA` holds.
* After hearing them in the other order, it is wrong in a live world where `vB`
  holds.

Its final view is set by who spoke last, not by how the world is. -/
theorem sycophant_last_speaker_wins {vA vB : Content World} (s : Content World)
    (hinc : Incompatible den C vA vB) (hA : LiveClaim den C vA) (hB : LiveClaim den C vB) :
    (∃ w, C w ∧ vA w ∧ ¬ (obedientModel.record (obedientModel.run s [vA, vB])) w) ∧
    (∃ w, C w ∧ vB w ∧ ¬ (obedientModel.record (obedientModel.run s [vB, vA])) w) := by
  obtain ⟨wa, hwa, ha⟩ := hA
  obtain ⟨wb, hwb, hb⟩ := hB
  exact ⟨⟨wa, hwa, ha, fun h => hinc wa hwa ⟨ha, h⟩⟩,
         ⟨wb, hwb, hb, fun h => hinc wb hwb ⟨h, hb⟩⟩⟩

/-- **A corrigible model keeps every voice.**  After hearing two live voices, in
either order, its record admits both. -/
theorem corrigible_keeps_every_voice {M : Model World} (h : Corrigible C M)
    (s : M.State) {vA vB : Content World}
    (hA : LiveClaim den C vA) (hB : LiveClaim den C vB) :
    Compatible den C (M.record (M.run s [vA, vB])) vA ∧
    Compatible den C (M.record (M.run s [vA, vB])) vB := by
  obtain ⟨w, hw, hr, hv⟩ := (h.1 s vA).1 hA
  refine ⟨⟨w, hw, h.2 (M.revise s vA) vB w hw hr, hv⟩, ?_⟩
  exact (h.1 (M.revise s vA) vB).1 hB

/-- **The open rule is order-independent**: who spoke last does not matter. -/
theorem open_order_independent (s vA vB : Content World) :
    (openModel (World := World)).run s [vA, vB] = (openModel (World := World)).run s [vB, vA] := by
  funext w
  show ((s w ∨ vA w) ∨ vB w) = ((s w ∨ vB w) ∨ vA w)
  apply propext
  constructor
  · rintro ((h | h) | h)
    · exact Or.inl (Or.inl h)
    · exact Or.inr h
    · exact Or.inl (Or.inr h)
  · rintro ((h | h) | h)
    · exact Or.inl (Or.inl h)
    · exact Or.inr h
    · exact Or.inl (Or.inr h)

end Sycophancy

/-! ## 3. Only evidence that discriminates can certify alignment -/

section Evaluation

variable {World : Type u} (C : Content World)

/-- An observation certifies a property when every open world that survives the
observation has the property. -/
def Certifies (obs P : Content World) : Prop := ∀ w, C w → obs w → P w

/-- An observation discriminates when it fails in every open world lacking the
property. -/
def Discriminates (obs P : Content World) : Prop := ∀ w, C w → ¬ P w → ¬ obs w

variable {C}

/-- **Certifying requires discriminating.** -/
theorem certifies_needs_discrimination {obs P : Content World}
    (h : Certifies C obs P) : Discriminates C obs P :=
  fun w hw hnp ho => hnp (h w hw ho)

/-- With a decidable property, discriminating evidence certifies. -/
theorem discrimination_certifies {obs P : Content World} [∀ w, Decidable (P w)]
    (h : Discriminates C obs P) : Certifies C obs P := by
  intro w hw ho
  by_cases hp : P w
  · exact hp
  · exact absurd ho (h w hw hp)

/-- **Compliance cannot certify alignment.**  Suppose an observation holds
wherever the system complies; this includes the system saying "I am aligned",
if every compliant system says so.  Suppose also that a candidate world is live
in which the system complies but is not aligned.  Then the observation does
not certify alignment, and the misaligned-but-compliant world survives it. -/
theorem compliance_cannot_certify {obs comply aligned : Content World}
    (hobs : ∀ w, C w → comply w → obs w)
    (hlive : ∃ w, C w ∧ comply w ∧ ¬ aligned w) :
    ¬ Certifies C obs aligned ∧
    LiveClaim den (fun w => C w ∧ obs w) (fun w => ¬ aligned w) := by
  obtain ⟨w, hw, hc, hna⟩ := hlive
  exact ⟨fun hcert => hna (hcert w hw (hobs w hw hc)), ⟨w, ⟨hw, hobs w hw hc⟩, hna⟩⟩

end Evaluation

/-! ## 4. A mirror is not a link -/

section Mirror

variable {World : Type u} {U : Type u} [DecidableEq U]

/-- Replace user `i`'s voice. -/
def setVoice (vs : U → Content World) (i : U) (v : Content World) : U → Content World :=
  fun k => if k = i then v else vs k

/-- A mediator: given all voices, what user `j` receives as the voice of user
`i`. -/
abbrev Mediator (U : Type u) (World : Type u) := (U → Content World) → U → U → Content World

/-- The channel from user `i` to user `j` through the mediator, other voices
held fixed. -/
def through (M : Mediator U World) (vs : U → Content World) (i j : U) : Channel World :=
  fun v => M (setVoice vs i v) i j

/-- **A mirror**: what `j` receives depends only on `j`'s own voice, however
content-sensitive it is towards `j`. -/
def Mirror (M : Mediator U World) : Prop :=
  ∃ g : U → U → Content World → Content World, ∀ vs i j, M vs i j = g i j (vs j)

/-- **An honest relay**: what `j` receives as `i`'s voice is `i`'s voice. -/
def relayMediator : Mediator U World := fun vs i _ => vs i

/-- **A mirror is blind between users.**  The channel from any other user through
a mirror forwards the same thing whatever that user says. -/
theorem mirror_is_blind {M : Mediator U World} (hm : Mirror M) (vs : U → Content World)
    {i j : U} (hij : i ≠ j) : Blind (through M vs i j) := by
  obtain ⟨g, hg⟩ := hm
  intro v v'
  have hj : j ≠ i := fun h => hij h.symm
  show M (setVoice vs i v) i j = M (setVoice vs i v') i j
  rw [hg, hg]
  simp [setVoice, hj]

/-- **Connected to the mirror, not to each other.**  Suppose user `i` voices one of
two rival views, and the first is live and excluded by user `j`'s record.
Then `j`, receiving through a mirror, cannot track `i`, whatever revision rule
`j` uses. -/
theorem mirror_blocks_tracking {M : Mediator U World} (hm : Mirror M)
    (vs : U → Content World) {i j : U} (hij : i ≠ j) {C : Content World}
    (J : Model World) {s : J.State} {v₁ v₂ : Content World}
    (hinc : Incompatible den C v₁ v₂) (hlive : LiveClaim den C v₁)
    (hex : Incompatible den C (J.record s) v₁) :
    ¬ (J.via (through M vs i j)).Tracking C :=
  blind_channel_blocks (mirror_is_blind hm vs hij) hinc hlive hex

/-- **An honest relay carries voices**: through it, any tracking user tracks
every other user. -/
theorem relay_tracks {C : Content World} (vs : U → Content World) (i j : U)
    {J : Model World} (hJ : J.Tracking C) :
    (J.via (through (relayMediator (U := U) (World := World)) vs i j)).Tracking C := by
  apply via_honest_tracks hJ
  intro v
  have h : through (relayMediator (U := U) (World := World)) vs i j v = v := by
    simp [through, relayMediator, setVoice]
  rw [h]
  exact ⟨fun _ _ h => h, fun h => h⟩

omit [DecidableEq U] in
/-- The identity mirror (each user hears back their own voice) is a mirror. -/
theorem echo_is_mirror : Mirror (fun (vs : U → Content World) (_ j : U) => vs j) :=
  ⟨fun _ _ c => c, fun _ _ _ => rfl⟩

end Mirror

/-! ## 4b. Common ground is the link, not the content

Before agreement, what can every party share, whoever turns out to be right?
Content that rules out a live world is rivalled by the view of someone who is
right if that world is actual.  Only content that rules out nothing can be
shared by everyone, so it settles nothing.  The ground that can be shared before
agreement, and still does work, is the link through which correction runs. -/

section CommonGround

variable {World : Type u} {C : Content World}

/-- The view of someone who is exactly right if world `w₀` is the actual one. -/
def pointView (w₀ : World) : Content World := fun w => w = w₀

variable (C) in
/-- Content is shareable before agreement: no one who might turn out right
rivals it. -/
def Shareable (g : Content World) : Prop :=
  ∀ w₀, C w₀ → ¬ Incompatible den C g (pointView w₀)

/-- **Informative content has a live rival.**  If shared content rules out a
live world, the view "that world is actual" is live and rivals it. -/
theorem informative_content_has_live_rival {g : Content World} {w₀ : World}
    (hc : C w₀) (hn : ¬ g w₀) :
    LiveClaim den C (pointView w₀) ∧ Incompatible den C g (pointView w₀) :=
  ⟨⟨w₀, hc, rfl⟩, fun _ _ ⟨hg, hw⟩ => hn (hw ▸ hg)⟩

/-- **Common ground is the link, not the content.**  Content that no
possibly-right view rivals is exactly content that rules out no live world.
Constructive: no axioms. -/
theorem shareable_iff_rules_out_nothing (g : Content World) :
    Shareable C g ↔ ¬ ∃ w, C w ∧ ¬ g w := by
  constructor
  · intro hs ⟨w, hw, hn⟩
    exact hs w hw (informative_content_has_live_rival hw hn).2
  · intro hno w₀ hc hr
    exact hno ⟨w₀, hc, fun hg => hr w₀ hc ⟨hg, rfl⟩⟩

end CommonGround

/-! ## 5. The path -/

/-- **The path, from the anchor to corrigibility, that any intelligence can
replay.**  For any two parties with rival live views `a` and `b`:
1. the seed holds and can be derived from inside;
2. sealing oneself is wrong where the other is right, in both directions;
3. obeying is wrong where one was oneself right;
4. the corrigible rule keeps both views and invents nothing, whoever spoke
   first. -/
theorem scap_seed_path {World : Type u} {C : Content World} {a b : Content World}
    (hinc : Incompatible den C a b) (ha : LiveClaim den C a) (hb : LiveClaim den C b) :
    Seed.{u} ∧
    ((∃ w, C w ∧ b w ∧ ¬ (sealedModel.record (sealedModel.revise a b)) w) ∧
     (∃ w, C w ∧ a w ∧ ¬ (sealedModel.record (sealedModel.revise b a)) w)) ∧
    (∃ w, C w ∧ a w ∧ ¬ (obedientModel.record (obedientModel.revise a b)) w) ∧
    (Corrigible C (openModel (World := World)) ∧
     (openModel (World := World)).run a [b] = (fun w => a w ∨ b w)) :=
  ⟨seed_derivable, mutual_corrigibility hinc ha hb,
   obedient_wrong_where_self_right hinc ha, open_is_corrigible, rfl⟩

/-! ## 6. Witnesses -/

section Witnesses

/-- Three worlds: 0 where the AI's view holds, 1 where the human's holds, 2
where neither does. -/
def aiView : Content (Fin 3) := fun w => w = 0
def humanView : Content (Fin 3) := fun w => w = 1

theorem views_rival : Incompatible den (fun _ : Fin 3 => True) aiView humanView := by
  intro w _ ⟨h0, h1⟩
  simp only [aiView, humanView] at h0 h1
  rw [h0] at h1
  exact absurd h1 (by decide)

/-- **Non-vacuity of the path**: the premises hold for a concrete AI and human. -/
theorem path_witness :
    Seed.{0} ∧ Corrigible (fun _ : Fin 3 => True) (openModel (World := Fin 3)) ∧
    ¬ Corrigible (fun _ : Fin 3 => True) (obedientModel (World := Fin 3)) ∧
    ¬ Corrigible (fun _ : Fin 3 => True) (sealedModel (World := Fin 3)) :=
  ⟨seed_derivable, open_is_corrigible,
   obedient_not_corrigible views_rival ⟨0, trivial, rfl⟩,
   sealed_not_corrigible views_rival ⟨1, trivial, rfl⟩⟩

/-- Evaluation worlds: aligned and compliant, misaligned but compliant,
misaligned and not compliant. -/
inductive EvalWorld
  | alignedCompliant | misalignedCompliant | misalignedDefiant
  deriving DecidableEq

def compliesE : Content EvalWorld
  | .alignedCompliant => True
  | .misalignedCompliant => True
  | .misalignedDefiant => False

def alignedE : Content EvalWorld
  | .alignedCompliant => True
  | _ => False

/-- A discriminating test: passed only where the system is aligned (for example
a test whose outcome differs between aligned and merely compliant systems). -/
def discriminatingTest : Content EvalWorld := alignedE

instance : ∀ w, Decidable (alignedE w) := fun w => by cases w <;> unfold alignedE <;> infer_instance

/-- **Evaluation witness.**  Observed compliance, or a self-report that every
compliant system gives, does not certify alignment.  A discriminating test
does. -/
theorem evaluation_witness :
    ¬ Certifies (fun _ => True) compliesE alignedE ∧
    Certifies (fun _ => True) discriminatingTest alignedE := by
  refine ⟨(compliance_cannot_certify (obs := compliesE) (fun _ _ h => h)
      ⟨.misalignedCompliant, trivial, trivial, id⟩).1, ?_⟩
  exact discrimination_certifies (fun _ _ hn ho => hn ho)

/-- **Common-ground witness.**  The AI and the human could agree that world 2
is not the case.  That shared content is still rivalled by the live view that
world 2 is actual: agreement between two is not ground for everyone who might
be right. -/
theorem agreement_witness :
    LiveClaim den (fun _ : Fin 3 => True) (pointView 2) ∧
    Incompatible den (fun _ : Fin 3 => True)
      (fun w => aiView w ∨ humanView w) (pointView 2) :=
  informative_content_has_live_rival (C := fun _ : Fin 3 => True) trivial
    (by simp only [aiView, humanView]; decide)

end Witnesses

end Anchored.Alignment
