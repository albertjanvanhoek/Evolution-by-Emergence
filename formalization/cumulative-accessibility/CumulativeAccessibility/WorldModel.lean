namespace CumulativeAccessibility
namespace WorldModel

/-!
# Evidential fit: a narrow formal core for functional world models

Entry D34 of `DIALOGUE.md` and `research/world-model/WORLD_MODEL.md` distinguish a
**world model** (any representation that supports inference about what is not
observed), the practice of **world modelling**, and a **functional world model**
(one maintained so that it stays useful and correctable).  This module does not
formalize any of those in full.  It formalizes one narrow ideal they share,
**evidential fit** at the level of possibilities, and checks what follows from
it, what does not, and how much depends on the update rule and on how a
collective pools what its members pass on.  The revision after review 1
(`research/world-model/sources/`) is recorded in that folder's `RESPONSE_1.md`.

Setting.  `W` is a type of possible worlds; a world may be read as a whole history,
so that a changing world is learned about by narrowing hypotheses about its
course.  A model's **support** is the set of worlds it keeps possible,
`K : W → Prop`.  The evidence received so far, together with a background `B`
that says which worlds are admitted before any evidence, leaves a set of live
worlds, `Live B E n`.  One world is the actual one; the holder cannot see which.

Definitions.
* `Covers K L`: the model keeps every live world possible.
* `Within K L`: the model keeps possible only live worlds.
* `EvidentialFit K L`: both; the support equals the live set
  (`fit_iff_matches_evidence`).  This is a set-theoretic analogue of
  evidence-relative sharpness, not a case of probabilistic calibration: it
  involves no probability distribution and no comparison with observed
  frequencies.
* `Consistent K`: the support is not empty.
* `Entails K P`: `P` holds in every world the model keeps possible.

Results.
1. **Fit and soundness.**  Reliable evidence and an adequate background keep the
   actual world live (`reliable_evidence_keeps_actual`); a covering model then
   keeps it too (`covering_model_keeps_actual`), and what it entails holds of the
   actual world (`covering_entailment_is_sound`).  These are conditional: the
   adequacy of `B` and the reliability of `E` are premises, not consequences.
2. **Narrowing.**  A narrower support entails at least as much
   (`narrower_entails_more`); this is weak inclusion, and a narrower support may
   be empty or exclude the actual world.  The universal support covers every live
   set (`universal_model_covers`), lies within one only if nothing has been ruled
   out (`universal_model_within_iff_nothing_ruled_out`), and entails only what
   holds in every world of `W` (`universal_entails_only_the_universal`).  These
   are statements about the extreme `K = W`, not about every partly vague model.
3. **Inconsistency.**  Fit alone is not enough: with an empty live set, a fitting
   model entails everything (`empty_fit_entails_everything`).  An empty live set
   is a signal: either the background or some piece of evidence is false of the
   actual world (`inconsistency_flags_background_or_evidence`).  So a functional
   world model needs consistency handling, not only fit.
4. **Update rules decide recovery.**  `follow` updates a model's own conclusions
   by intersection.  Under that monotone rule an excluded world stays excluded
   (`monotone_update_cannot_recover`), including the actual one
   (`monotone_update_never_recovers_actual`).  This is a property of the rule,
   not of learning: re-deriving the support from the background and the kept
   evidence recovers the actual world that `follow` lost
   (`rederiving_recovers_what_following_cannot`), and revising a background that
   excluded the actual world recovers it (`revising_background_recovers`).
   Re-derivation is not revision: recomputing from a false piece of evidence
   gives the same wrong answer (`rederiving_with_false_evidence_does_not_recover`),
   while retracting that piece and recomputing recovers the actual world
   (`retracting_false_evidence_recovers`).  All of these assume that the holder
   has kept the background and the evidence and can recompute; provenance is not
   an input to any of them.  Adding a world that `W` never contained
   (representational extension, not AGM expansion) is not modelled here.
5. **Upkeep.**  A model that starts in fit and follows the evidence stays in fit
   (`following_evidence_keeps_fit`); reliability is not required for this, so fit
   can be preserved while the actual world is lost.  A support fixed by
   something other than evidence fits two live sets only if they are the same
   (`fixed_support_fits_only_if_nothing_learned`).  Two fitting models of the same
   live set coincide (`same_live_set_same_fit`); the same raw observations need
   not give the same live set, because backgrounds and interpretations differ.
6. **Hard pooling.**  Pooling as intersection treats every contribution as a
   binding constraint.  The pool is weakly narrower than each input
   (`hard_pool_is_narrower`) and entails what either input entails
   (`hard_pool_entails_more`); it keeps the actual world when every input does
   (`hard_pool_keeps_actual`, `hard_pool_many_keeps_actual_iff_each_does`), and
   then what it entails holds of the actual world
   (`hard_pool_sound_when_each_keeps_actual`).  One input that excludes the
   actual world excludes it from the pool
   (`hard_pool_one_excluding_source_excludes_actual`), and the pool then entails
   that the actual world is not the case
   (`hard_pool_one_excluding_contribution_denies_actual`).  An input that imposes
   no constraint leaves a hard pool unchanged
   (`unconstrained_contribution_leaves_hard_pool_unchanged`); its practical
   effects (attention, delay, dilution) are not modelled.
7. **Other pooling rules.**  The fragility of point 6 belongs to hard pooling.
   The two other rules here act on nonnegative whole-number scores, read as
   unnormalized credences; they do not enforce the probability axioms, and a
   product can be zero everywhere, which cannot be normalized.  Under a weighted
   sum, a world that one positively weighted source scores positively keeps a
   positive pooled score whatever another source says
   (`linear_pool_keeps_what_one_source_keeps`; compare `GradedBelief.mix_support`).
   Under a product, one zero is a veto (`product_pool_zero_is_a_veto`).  Which rule is right depends on how sources
   err and depend on each other; this module does not decide it.
8. `world_model_witness`: three admitted worlds, one piece of evidence, a fitting,
   a universal and an actual-excluding support, monotone update against
   re-derivation, a false piece of evidence retracted, and two sources' scores
   under a sum and under a product.

Evidence premises are stated for the evidence received so far
(`∀ i, i < n → E i a`), not for the whole stream.

Scope.  The results are close to their definitions, and several are their
definitions restated.  They make the terms and their limits checkable; they are
not findings about cognition, institutions or persistence.  Not modelled:
probability over the support (see `GradedBelief`), calibration, unreliable
evidence (see `ListeningCost`), action and its consequences, costs, and adding
new possibilities.
-/

/-- The live worlds after `n` pieces of evidence: admitted by the background `B`
and consistent with every piece received so far. -/
def Live {W : Type} (B : W → Prop) (E : Nat → W → Prop) (n : Nat) : W → Prop :=
  fun w => B w ∧ ∀ i, i < n → E i w

/-- The support keeps every live world possible. -/
def Covers {W : Type} (K L : W → Prop) : Prop := ∀ w, L w → K w

/-- The support keeps possible only live worlds. -/
def Within {W : Type} (K L : W → Prop) : Prop := ∀ w, K w → L w

/-- Evidential fit: the support covers the live set and lies within it. -/
def EvidentialFit {W : Type} (K L : W → Prop) : Prop := Covers K L ∧ Within K L

/-- The support is not empty. -/
def Consistent {W : Type} (K : W → Prop) : Prop := ∃ w, K w

/-- The model entails `P`: `P` holds in every world its support keeps possible. -/
def Entails {W : Type} (K P : W → Prop) : Prop := ∀ w, K w → P w

/-- Monotone update of a model's own conclusions: keep a world while every
piece of evidence received holds in it. -/
def follow {W : Type} (K : W → Prop) (E : Nat → W → Prop) (n : Nat) : W → Prop :=
  fun w => K w ∧ ∀ i, i < n → E i w

/-- Re-derivation: recompute the support from the background and the kept
evidence, ignoring earlier conclusions. -/
def rederive {W : Type} (B : W → Prop) (E : Nat → W → Prop) (n : Nat) : W → Prop :=
  Live B E n

/-- The live worlds after `n` pieces of evidence with piece `j` retracted. -/
def LiveExcept {W : Type} (B : W → Prop) (E : Nat → W → Prop) (n j : Nat) : W → Prop :=
  fun w => B w ∧ ∀ i, i < n → i ≠ j → E i w

/-- Hard pooling of two supports: a world stays possible only if both keep it. -/
def hardPool {W : Type} (L₁ L₂ : W → Prop) : W → Prop := fun w => L₁ w ∧ L₂ w

/-- Hard pooling of `m` contributions. -/
def hardPoolMany {W : Type} (C : Nat → W → Prop) (m : Nat) : W → Prop :=
  fun w => ∀ j, j < m → C j w

/-- Linear pooling of two nonnegative scores with weights `α` and `β`: an
unnormalized weighted sum, in whole numbers. -/
def linearPool {W : Type} (α β : Nat) (p q : W → Nat) : W → Nat :=
  fun w => α * p w + β * q w

/-- Product pooling of two nonnegative scores (unnormalized). -/
def productPool {W : Type} (p q : W → Nat) : W → Nat := fun w => p w * q w

/-- **Fit is equality of support and live set.** -/
theorem fit_iff_matches_evidence {W : Type} (K L : W → Prop) :
    EvidentialFit K L ↔ ∀ w, K w ↔ L w := by
  constructor
  · rintro ⟨hc, hw⟩ w
    exact ⟨hw w, hc w⟩
  · intro h
    exact ⟨fun w hw => (h w).2 hw, fun w hw => (h w).1 hw⟩

/-- **Reliable evidence keeps the actual world live**, given a background that
admits it. -/
theorem reliable_evidence_keeps_actual {W : Type} {B : W → Prop} {E : Nat → W → Prop}
    {a : W} {n : Nat} (hB : B a) (hE : ∀ i, i < n → E i a) : Live B E n a :=
  ⟨hB, hE⟩

/-- **A covering model keeps the actual world**, under the same premises. -/
theorem covering_model_keeps_actual {W : Type} {K B : W → Prop} {E : Nat → W → Prop}
    {a : W} {n : Nat} (hC : Covers K (Live B E n)) (hB : B a) (hE : ∀ i, i < n → E i a) :
    K a :=
  hC a (reliable_evidence_keeps_actual hB hE)

/-- **What a covering model entails holds of the actual world**, when the actual
world is live. -/
theorem covering_entailment_is_sound {W : Type} {K L P : W → Prop} {a : W}
    (hC : Covers K L) (ha : L a) (hP : Entails K P) : P a :=
  hP a (hC a ha)

/-- **A narrower support entails at least as much.** -/
theorem narrower_entails_more {W : Type} {K K' P : W → Prop}
    (hsub : ∀ w, K' w → K w) (hP : Entails K P) : Entails K' P :=
  fun w hw => hP w (hsub w hw)

/-- **The universal support covers every live set.** -/
theorem universal_model_covers {W : Type} (L : W → Prop) : Covers (fun _ => True) L :=
  fun _ _ => trivial

/-- **The universal support lies within a live set only if nothing is ruled
out.** -/
theorem universal_model_within_iff_nothing_ruled_out {W : Type} (L : W → Prop) :
    Within (fun _ => True) L ↔ ∀ w, L w :=
  ⟨fun h w => h w trivial, fun h w _ => h w⟩

/-- **The universal support entails only what holds in every world of `W`.** -/
theorem universal_entails_only_the_universal {W : Type} (P : W → Prop) :
    Entails (fun _ => True) P ↔ ∀ w, P w :=
  ⟨fun h w => h w trivial, fun h w _ => h w⟩

/-- **Fit with an empty live set entails everything.**  Fit alone does not make
a model usable; consistency has to be handled separately. -/
theorem empty_fit_entails_everything {W : Type} {K L : W → Prop} (P : W → Prop)
    (hL : ∀ w, ¬ L w) (hf : EvidentialFit K L) : Entails K P :=
  fun w hw => absurd (hf.2 w hw) (hL w)

/-- **An empty live set flags an error.**  If no world is live, either the
background excludes the actual world or some piece of evidence is false of it. -/
theorem inconsistency_flags_background_or_evidence {W : Type} {B : W → Prop}
    {E : Nat → W → Prop} {n : Nat} (a : W) (hempty : ∀ w, ¬ Live B E n w) :
    ¬ B a ∨ ∃ i, i < n ∧ ¬ E i a := by
  apply Classical.byContradiction
  intro h
  apply hempty a
  refine ⟨Classical.byContradiction fun hB => h (Or.inl hB), fun i hi => ?_⟩
  exact Classical.byContradiction fun hne => h (Or.inr ⟨i, hi, hne⟩)

/-- **Under monotone update, an excluded world stays excluded.** -/
theorem monotone_update_cannot_recover {W : Type} {K : W → Prop} {w : W}
    (E : Nat → W → Prop) (h : ¬ K w) (n : Nat) : ¬ follow K E n w :=
  fun hf => h hf.1

/-- **Under monotone update, a support that excludes the actual world never
recovers it.** -/
theorem monotone_update_never_recovers_actual {W : Type} {K : W → Prop} {a : W}
    (E : Nat → W → Prop) (h : ¬ K a) (n : Nat) : ¬ follow K E n a :=
  monotone_update_cannot_recover E h n

/-- **Re-deriving recovers what following cannot.**  If a model's own
conclusions excluded the actual world, monotone update keeps it excluded, while
re-deriving from an adequate background and reliable kept evidence restores
it. -/
theorem rederiving_recovers_what_following_cannot {W : Type} {K B : W → Prop}
    {E : Nat → W → Prop} {a : W} {n : Nat} (hK : ¬ K a) (hB : B a)
    (hE : ∀ i, i < n → E i a) : ¬ follow K E n a ∧ rederive B E n a :=
  ⟨monotone_update_cannot_recover E hK n, reliable_evidence_keeps_actual hB hE⟩

/-- **Re-derivation is not revision.**  Recomputing from a background and
evidence that include a piece false of the actual world gives the same wrong
answer: the actual world stays out. -/
theorem rederiving_with_false_evidence_does_not_recover {W : Type} {B : W → Prop}
    {E : Nat → W → Prop} {a : W} {n j : Nat} (hj : j < n) (hfalse : ¬ E j a) :
    ¬ rederive B E n a :=
  fun h => hfalse (h.2 j hj)

/-- **Retracting false evidence recovers.**  If one piece of evidence is false
of the actual world and the rest is true, the live set excludes the actual
world, and retracting that piece and recomputing brings it back. -/
theorem retracting_false_evidence_recovers {W : Type} {B : W → Prop}
    {E : Nat → W → Prop} {a : W} {n j : Nat} (hj : j < n) (hfalse : ¬ E j a)
    (hB : B a) (hrest : ∀ i, i < n → i ≠ j → E i a) :
    ¬ Live B E n a ∧ LiveExcept B E n j a :=
  ⟨fun h => hfalse (h.2 j hj), ⟨hB, hrest⟩⟩

/-- **Revising the background recovers.**  A background that excluded the actual
world keeps it out of the live set; a revised background that admits it, with
reliable evidence, brings it back. -/
theorem revising_background_recovers {W : Type} {B B' : W → Prop}
    {E : Nat → W → Prop} {a : W} {n : Nat} (hB : ¬ B a) (hB' : B' a)
    (hE : ∀ i, i < n → E i a) : ¬ Live B E n a ∧ Live B' E n a :=
  ⟨fun h => hB h.1, reliable_evidence_keeps_actual hB' hE⟩

/-- **Following the evidence keeps fit.**  A model that starts in fit and
follows the evidence stays in fit at every step.  Reliability is not assumed:
fit can be kept while the actual world is lost. -/
theorem following_evidence_keeps_fit {W : Type} {K B : W → Prop}
    {E : Nat → W → Prop} (h0 : EvidentialFit K (Live B E 0)) (n : Nat) :
    EvidentialFit (follow K E n) (Live B E n) := by
  rcases h0 with ⟨hc, hw⟩
  constructor
  · intro w hw'
    exact ⟨hc w ⟨hw'.1, fun i hi => absurd hi (Nat.not_lt_zero i)⟩, hw'.2⟩
  · intro w hw'
    exact ⟨(hw w hw'.1).1, hw'.2⟩

/-- **A fixed support fits two live sets only if they are the same.** -/
theorem fixed_support_fits_only_if_nothing_learned {W : Type}
    {K L₁ L₂ : W → Prop} (h₁ : EvidentialFit K L₁) (h₂ : EvidentialFit K L₂) :
    ∀ w, L₁ w ↔ L₂ w := by
  intro w
  have e₁ := (fit_iff_matches_evidence K L₁).1 h₁ w
  have e₂ := (fit_iff_matches_evidence K L₂).1 h₂ w
  exact e₁.symm.trans e₂

/-- **Two fitting models of the same live set coincide.** -/
theorem same_live_set_same_fit {W : Type} {K₁ K₂ L : W → Prop}
    (h₁ : EvidentialFit K₁ L) (h₂ : EvidentialFit K₂ L) : ∀ w, K₁ w ↔ K₂ w := by
  intro w
  have e₁ := (fit_iff_matches_evidence K₁ L).1 h₁ w
  have e₂ := (fit_iff_matches_evidence K₂ L).1 h₂ w
  exact e₁.trans e₂.symm

/-- **A hard pool is weakly narrower than each input.** -/
theorem hard_pool_is_narrower {W : Type} (L₁ L₂ : W → Prop) :
    (∀ w, hardPool L₁ L₂ w → L₁ w) ∧ (∀ w, hardPool L₁ L₂ w → L₂ w) :=
  ⟨fun _ h => h.1, fun _ h => h.2⟩

/-- **A hard pool entails what either input entails.** -/
theorem hard_pool_entails_more {W : Type} {L₁ L₂ P : W → Prop}
    (h : Entails L₁ P ∨ Entails L₂ P) : Entails (hardPool L₁ L₂) P := by
  rcases h with h | h
  · exact narrower_entails_more (hard_pool_is_narrower L₁ L₂).1 h
  · exact narrower_entails_more (hard_pool_is_narrower L₁ L₂).2 h

/-- **A hard pool keeps the actual world when both inputs do.** -/
theorem hard_pool_keeps_actual {W : Type} {L₁ L₂ : W → Prop} {a : W}
    (h₁ : L₁ a) (h₂ : L₂ a) : hardPool L₁ L₂ a :=
  ⟨h₁, h₂⟩

/-- **One input that excludes the actual world excludes it from a hard pool.** -/
theorem hard_pool_one_excluding_source_excludes_actual {W : Type} {L₁ L₂ : W → Prop}
    {a : W} (h : ¬ L₂ a) : ¬ hardPool L₁ L₂ a :=
  fun hp => h hp.2

/-- **A hard pool of many keeps the actual world exactly when each contribution
does.**  This is the definition of `hardPoolMany`, restated. -/
theorem hard_pool_many_keeps_actual_iff_each_does {W : Type} (C : Nat → W → Prop)
    (m : Nat) (a : W) : hardPoolMany C m a ↔ ∀ j, j < m → C j a :=
  Iff.rfl

/-- **A covering contribution keeps the actual world.**  A contribution that
keeps possible every world its contributor's own adequate background and
reliable evidence leave live keeps the actual world. -/
theorem covering_contribution_keeps_actual {W : Type} {C B : W → Prop}
    {E : Nat → W → Prop} {a : W} {n : Nat} (hC : Covers C (Live B E n)) (hB : B a)
    (hE : ∀ i, i < n → E i a) : C a :=
  covering_model_keeps_actual hC hB hE

/-- **A hard pool is sound when each contribution keeps the actual world.** -/
theorem hard_pool_sound_when_each_keeps_actual {W : Type} {C : Nat → W → Prop}
    {m : Nat} {a : W} {P : W → Prop} (h : ∀ j, j < m → C j a)
    (hP : Entails (hardPoolMany C m) P) : P a :=
  hP a h

/-- **In a hard pool, one contribution that excludes the actual world makes the
pool deny it.** -/
theorem hard_pool_one_excluding_contribution_denies_actual {W : Type}
    {C : Nat → W → Prop} {m j : Nat} {a : W} (hj : j < m) (h : ¬ C j a) :
    Entails (hardPoolMany C m) (fun w => w ≠ a) := by
  intro w hw heq
  subst heq
  exact h (hw j hj)

/-- **An unconstrained contribution leaves a hard pool unchanged.** -/
theorem unconstrained_contribution_leaves_hard_pool_unchanged {W : Type}
    {C : Nat → W → Prop} {m : Nat} (hv : ∀ w, C m w) :
    ∀ w, hardPoolMany C (m + 1) w ↔ hardPoolMany C m w := by
  intro w
  constructor
  · intro h j hj
    exact h j (Nat.lt_succ_of_lt hj)
  · intro h j hj
    rcases Nat.lt_succ_iff_lt_or_eq.mp hj with hlt | heq
    · exact h j hlt
    · subst heq
      exact hv w

/-- **Under linear pooling, what one source keeps possible stays possible.**  A
world that a positively weighted source scores positively keeps a positive pooled
score, whatever the other source gives it, zero included. -/
theorem linear_pool_keeps_what_one_source_keeps {W : Type} {α β : Nat}
    {p q : W → Nat} {a : W} (hα : 0 < α) (hp : 0 < p a) : 0 < linearPool α β p q a := by
  unfold linearPool
  have := Nat.mul_pos hα hp
  omega

/-- **Under product pooling, one zero is a veto.** -/
theorem product_pool_zero_is_a_veto {W : Type} {p q : W → Nat} {a : W}
    (h : q a = 0) : productPool p q a = 0 := by
  unfold productPool
  rw [h, Nat.mul_zero]

/-- Worlds `0`, `1` and `2` are admitted, and the actual world is `0`.  One
piece of evidence rules out world `1`.
* The support `{0, 2}` fits the live set and entails "not world 1".
* The universal support covers it but does not lie within it, and does not
  entail "not world 1".
* The support `{2}` excludes the actual world; monotone update keeps it out,
  while re-deriving from the background and the evidence brings it back.
* A false second piece of evidence, "world 0 is not the case", excludes the
  actual world from the live set; retracting it brings the actual world back.
* One source scores world `0` with 9, another with 0: their sum keeps it
  possible, their product rules it out. -/
theorem world_model_witness :
    let B : Nat → Prop := fun w => w ≤ 2
    let E : Nat → Nat → Prop := fun _ w => w ≠ 1
    let fit : Nat → Prop := fun w => w ≤ 2 ∧ w ≠ 1
    let universal : Nat → Prop := fun _ => True
    let excluding : Nat → Prop := fun w => w = 2
    let p : Nat → Nat := fun _ => 9
    let q : Nat → Nat := fun w => if w = 0 then 0 else 9
    let E2 : Nat → Nat → Prop := fun i w => if i = 0 then w ≠ 1 else w ≠ 0
    EvidentialFit fit (Live B E 1) ∧
      Entails fit (fun w => w ≠ 1) ∧
      Covers universal (Live B E 1) ∧
      ¬ Within universal (Live B E 1) ∧
      ¬ Entails universal (fun w => w ≠ 1) ∧
      (∀ n, ¬ follow excluding E n 0) ∧
      (∀ n, rederive B E n 0) ∧
      ¬ Live B E2 2 0 ∧
      LiveExcept B E2 2 1 0 ∧
      linearPool 1 1 p q 0 = 9 ∧
      productPool p q 0 = 0 := by
  intro B E fit universal excluding p q E2
  refine ⟨⟨?_, ?_⟩, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩
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
  · intro n hf
    exact absurd hf.1 (by decide)
  · intro n
    exact ⟨by decide, fun _ _ => by decide⟩
  · intro h
    exact (h.2 1 (by decide)) rfl
  · refine ⟨by decide, fun i hi hne => ?_⟩
    have : i = 0 := by omega
    subst this
    decide
  · decide
  · decide

end WorldModel
end CumulativeAccessibility
