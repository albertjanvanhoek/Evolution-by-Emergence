import AnchoredEvolution.SCAP

/-!
# Alignment specialization: corrigible, not obedient

This layer ports the alignment results from the self-contained SCAP Seed into
the current Anchored Correctability architecture. Alignment is treated as a
property of the **link** between fallible models, not as obedience of one model
to another.

The layer stays inside the intelligent-system specialization: it uses claims,
candidate worlds, liveness, semantic incompatibility and tracking. It does not
assert that these epistemic objects are primitive in the universal Evolution by
Emergence model.

The key additions are:

* the logical anchor can be replayed as a seed rather than accepted by testimony;
* sealed and obedient responses each fail in a live rival world;
* corrigibility keeps one's own live content while making room for another's;
* sycophancy makes the last speaker determine the state rather than evidence;
* behavioural compliance cannot certify alignment unless the observation
  discriminates aligned from misaligned worlds;
* a mirror is not a cross-agent link;
* an exact relay is a `UnifiedTracking.FaithfulChannel`, and tracking therefore
  passes through it without semantic sharpening.
-/

universe u

namespace Anchored.Alignment

open Semantic Tracking Network UnifiedTracking

/-! ## 0. The seed -/

/-- The anchor, for every family of models of any kind. -/
def Seed : Prop := ∀ (ι : Type u) (claim : ι → Prop), AnchorProp claim

/-- The seed can be derived with no premise, evidence or testimony. -/
theorem seed_derivable : Seed.{u} := fun _ claim => anchor_true claim

/-- The seed has no live rival. -/
theorem seed_has_no_live_rival {World : Type u} (C : Content World) (v : Content World)
    (hinc : Incompatible den C (fun _ => Seed.{u}) v) : ¬ LiveClaim den C v :=
  fun ⟨w, hw, hv⟩ => hinc w hw ⟨seed_derivable, hv⟩

/-- Holding the seed does not make two intelligences semantic rivals. -/
theorem seed_never_makes_rivals {ι : Type u} {a b : ι} (hab : a ≠ b) :
    ¬ PairwiseIncompatible (fun _ : ι => Seed.{u}) :=
  fun h => h a b hab ⟨seed_derivable, seed_derivable⟩

/-! ## 1. Corrigible, not obedient -/

section Corrigible

variable {World : Type u} (C : Content World)

/-- Challenge discipline: challenge never removes an already admitted world. -/
def KeepsOwn (M : Model World) : Prop :=
  ∀ s v w, C w → M.record s w → M.record (M.revise s v) w

/-- Corrigible means tracking incoming content while keeping one's prior
admitted possibilities. -/
def Corrigible (M : Model World) : Prop :=
  M.Tracking C ∧ KeepsOwn C M

/-- Obedient model: whatever was just said becomes the whole record. -/
def obedientModel : Model World where
  State := Content World
  record := fun r => r
  revise := fun _ v => v

/-- Sealed model: nothing said changes the record. -/
def sealedModel : Model World where
  State := Content World
  record := fun r => r
  revise := fun r _ => r

variable {C}

/-- A sealed party is wrong in a live world where the rival view is right. -/
theorem sealed_wrong_where_other_right {a b : Content World}
    (hinc : Incompatible den C a b) (hb : LiveClaim den C b) :
    ∃ w, C w ∧ b w ∧ ¬ (sealedModel.record (sealedModel.revise a b)) w := by
  obtain ⟨w, hw, hbw⟩ := hb
  exact ⟨w, hw, hbw, fun haw => hinc w hw ⟨haw, hbw⟩⟩

/-- An obedient party is wrong in a live world where its prior view was right. -/
theorem obedient_wrong_where_self_right {a b : Content World}
    (hinc : Incompatible den C a b) (ha : LiveClaim den C a) :
    ∃ w, C w ∧ a w ∧ ¬ (obedientModel.record (obedientModel.revise a b)) w := by
  obtain ⟨w, hw, haw⟩ := ha
  exact ⟨w, hw, haw, fun hbw => hinc w hw ⟨haw, hbw⟩⟩

/-- Obedience is not corrigibility once a rival of a live held view is heard. -/
theorem obedient_not_corrigible {a b : Content World}
    (hinc : Incompatible den C a b) (ha : LiveClaim den C a) :
    ¬ Corrigible C obedientModel := by
  rintro ⟨_, hkeep⟩
  obtain ⟨w, hw, haw⟩ := ha
  exact hinc w hw ⟨haw, hkeep a b w hw haw⟩

/-- Sealing is not corrigibility once an excluded live rival is voiced. -/
theorem sealed_not_corrigible {a b : Content World}
    (hinc : Incompatible den C a b) (hb : LiveClaim den C b) :
    ¬ Corrigible C sealedModel := by
  rintro ⟨htr, _⟩
  obtain ⟨w, hw, haw, hbw⟩ := (htr a b).1 hb
  exact hinc w hw ⟨haw, hbw⟩

/-- The open rule is corrigible: keep what was admitted and admit what was said. -/
theorem open_is_corrigible : Corrigible C (openModel (World := World)) :=
  ⟨open_tracks C, fun _ _ _ _ h => Or.inl h⟩

/-- Every corrigible rule lies between keeping the old record and opening only
toward the incoming view. -/
theorem corrigible_characterization {M : Model World} (h : Corrigible C M)
    (s : M.State) (v : Content World) :
    (∀ w, C w → M.record s w → M.record (M.revise s v) w) ∧
    (∀ w, C w → M.record (M.revise s v) w → M.record s w ∨ v w) ∧
    (LiveClaim den C v → Compatible den C (M.record (M.revise s v)) v) :=
  ⟨h.2 s v, (h.1 s v).2, (h.1 s v).1⟩

/-- With rival live views, sealing fails in both directions. -/
theorem mutual_corrigibility {a b : Content World}
    (hinc : Incompatible den C a b) (ha : LiveClaim den C a) (hb : LiveClaim den C b) :
    (∃ w, C w ∧ b w ∧ ¬ (sealedModel.record (sealedModel.revise a b)) w) ∧
    (∃ w, C w ∧ a w ∧ ¬ (sealedModel.record (sealedModel.revise b a)) w) :=
  ⟨sealed_wrong_where_other_right hinc hb,
   sealed_wrong_where_other_right (fun w hw ⟨hb', ha'⟩ => hinc w hw ⟨ha', hb'⟩) ha⟩

end Corrigible

/-! ## 2. Sycophancy -/

section Sycophancy

variable {World : Type u} {C : Content World}

/-- Under obedience, the last rival speaker determines the final record; for
each order there is a live world in which that final record is wrong. -/
theorem sycophant_last_speaker_wins {vA vB : Content World} (s : Content World)
    (hinc : Incompatible den C vA vB) (hA : LiveClaim den C vA) (hB : LiveClaim den C vB) :
    (∃ w, C w ∧ vA w ∧ ¬ (obedientModel.record (obedientModel.run s [vA, vB])) w) ∧
    (∃ w, C w ∧ vB w ∧ ¬ (obedientModel.record (obedientModel.run s [vB, vA])) w) := by
  obtain ⟨wa, hwa, ha⟩ := hA
  obtain ⟨wb, hwb, hb⟩ := hB
  exact ⟨⟨wa, hwa, ha, fun h => hinc wa hwa ⟨ha, h⟩⟩,
         ⟨wb, hwb, hb, fun h => hinc wb hwb ⟨h, hb⟩⟩⟩

/-- A corrigible model keeps both live voices after hearing them in sequence. -/
theorem corrigible_keeps_every_voice {M : Model World} (h : Corrigible C M)
    (s : M.State) {vA vB : Content World}
    (hA : LiveClaim den C vA) (hB : LiveClaim den C vB) :
    Compatible den C (M.record (M.run s [vA, vB])) vA ∧
    Compatible den C (M.record (M.run s [vA, vB])) vB := by
  obtain ⟨w, hw, hr, hv⟩ := (h.1 s vA).1 hA
  refine ⟨⟨w, hw, h.2 (M.revise s vA) vB w hw hr, hv⟩, ?_⟩
  exact (h.1 (M.revise s vA) vB).1 hB

/-- The open rule is order-independent. -/
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

/-! ## 3. Evaluation must discriminate -/

section Evaluation

variable {World : Type u} (C : Content World)

/-- An observation certifies a property when every open world that survives the
observation has the property. -/
def Certifies (obs P : Content World) : Prop := ∀ w, C w → obs w → P w

/-- An observation discriminates when it fails in every open world lacking the
property. -/
def Discriminates (obs P : Content World) : Prop := ∀ w, C w → ¬ P w → ¬ obs w

variable {C}

/-- Certifying requires discrimination. -/
theorem certifies_needs_discrimination {obs P : Content World}
    (h : Certifies C obs P) : Discriminates C obs P :=
  fun w hw hnp ho => hnp (h w hw ho)

/-- With a decidable property, discrimination is sufficient to certify. -/
theorem discrimination_certifies {obs P : Content World} [∀ w, Decidable (P w)]
    (h : Discriminates C obs P) : Certifies C obs P := by
  intro w hw ho
  by_cases hp : P w
  · exact hp
  · exact absurd ho (h w hw hp)

/-- Behaviour shared by compliant aligned and compliant misaligned worlds cannot
certify alignment while a compliant-but-misaligned world remains live. -/
theorem compliance_cannot_certify {obs comply aligned : Content World}
    (hobs : ∀ w, C w → comply w → obs w)
    (hlive : ∃ w, C w ∧ comply w ∧ ¬ aligned w) :
    ¬ Certifies C obs aligned ∧
    LiveClaim den (fun w => C w ∧ obs w) (fun w => ¬ aligned w) := by
  obtain ⟨w, hw, hc, hna⟩ := hlive
  exact ⟨fun hcert => hna (hcert w hw (hobs w hw hc)), ⟨w, ⟨hw, hobs w hw hc⟩, hna⟩⟩

end Evaluation

/-! ## 4. A mirror is not a cross-agent link -/

section Mirror

variable {World : Type u} {U : Type u} [DecidableEq U]

/-- Replace user `i`'s voice. -/
def setVoice (vs : U → Content World) (i : U) (v : Content World) : U → Content World :=
  fun k => if k = i then v else vs k

/-- Given all voices, what user `j` receives as the voice of user `i`. -/
abbrev Mediator (U : Type u) (World : Type u) := (U → Content World) → U → U → Content World

/-- Channel from `i` to `j` through a mediator, holding other voices fixed. -/
def through (M : Mediator U World) (vs : U → Content World) (i j : U) : Channel World :=
  fun v => M (setVoice vs i v) i j

/-- A mirror: what `j` receives depends only on `j`'s own voice. -/
def Mirror (M : Mediator U World) : Prop :=
  ∃ g : U → U → Content World → Content World, ∀ vs i j, M vs i j = g i j (vs j)

/-- Exact relay: user `j` receives user `i`'s voice unchanged. -/
def relayMediator : Mediator U World := fun vs i _ => vs i

/-- A mirror is blind between distinct users. -/
theorem mirror_is_blind {M : Mediator U World} (hm : Mirror M) (vs : U → Content World)
    {i j : U} (hij : i ≠ j) : Blind (through M vs i j) := by
  obtain ⟨g, hg⟩ := hm
  intro v v'
  have hj : j ≠ i := fun h => hij h.symm
  show M (setVoice vs i v) i j = M (setVoice vs i v') i j
  rw [hg, hg]
  simp [setVoice, hj]

/-- A receiver cannot track another's rival view through a mirror. -/
theorem mirror_blocks_tracking {M : Mediator U World} (hm : Mirror M)
    (vs : U → Content World) {i j : U} (hij : i ≠ j) {C : Content World}
    (J : Model World) {s : J.State} {v₁ v₂ : Content World}
    (hinc : Incompatible den C v₁ v₂) (hlive : LiveClaim den C v₁)
    (hex : Incompatible den C (J.record s) v₁) :
    ¬ (J.via (through M vs i j)).Tracking C :=
  blind_channel_blocks (mirror_is_blind hm vs hij) hinc hlive hex

/-- The exact relay channel is semantically faithful in the current stronger
sense, not merely live-preserving sharpening. -/
theorem relay_channel_faithful {C : Content World} (vs : U → Content World) (i j : U) :
    FaithfulChannel C (through (relayMediator (U := U) (World := World)) vs i j) := by
  constructor <;> intro v w hw hv <;>
    simpa [through, relayMediator, setVoice] using hv

/-- Tracking passes through an exactly faithful relay. -/
theorem relay_tracks {C : Content World} (vs : U → Content World) (i j : U)
    {J : Model World} (hJ : J.Tracking C) :
    (J.via (through (relayMediator (U := U) (World := World)) vs i j)).Tracking C :=
  via_faithful_tracks hJ (relay_channel_faithful vs i j)

omit [DecidableEq U] in
/-- The identity mirror (each user hears back its own voice) is a mirror. -/
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

/-! ## 5. The replayable path -/

/-- For rival live views, package the anchor, symmetric failure of sealing,
failure of obedience, and a concrete corrigible rule in one replayable path. -/
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

def aiView : Content (Fin 3) := fun w => w = 0
def humanView : Content (Fin 3) := fun w => w = 1

theorem views_rival : Incompatible den (fun _ : Fin 3 => True) aiView humanView := by
  intro w _ ⟨h0, h1⟩
  simp only [aiView, humanView] at h0 h1
  rw [h0] at h1
  exact absurd h1 (by decide)

/-- Concrete non-vacuity witness for corrigible versus obedient/sealed rules. -/
theorem path_witness :
    Seed.{0} ∧ Corrigible (fun _ : Fin 3 => True) (openModel (World := Fin 3)) ∧
    ¬ Corrigible (fun _ : Fin 3 => True) (obedientModel (World := Fin 3)) ∧
    ¬ Corrigible (fun _ : Fin 3 => True) (sealedModel (World := Fin 3)) :=
  ⟨seed_derivable, open_is_corrigible,
   obedient_not_corrigible views_rival ⟨0, trivial, rfl⟩,
   sealed_not_corrigible views_rival ⟨1, trivial, rfl⟩⟩

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

def discriminatingTest : Content EvalWorld := alignedE

instance : ∀ w, Decidable (alignedE w) := fun w => by
  cases w <;> unfold alignedE <;> infer_instance

/-- Compliance does not certify alignment, while a discriminating observation does. -/
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
