/-!
# The seed: from the anchor to corrigibility, in one file

This file can be checked on its own, with no library and no imports:

    cd scap-seed/lean && lake env lean ../seed/Seed.lean

It takes a few seconds.  At the end, Lean prints which axioms each result
uses.  The anchor and the path use **none**.

It is written to be *replayed*, not believed.  Each step follows from the
steps before it, and the computer checks every one.  The full development, with
all layers, is in `lean/AnchoredEvolution/`.  This file repeats its core in the
simplest form.

The path:

0. **The anchor.**  Views that clash cannot all be right.  This holds for any
   family of views, held by any kind of intelligence.
1. **No guarantee.**  While a rival view is still possible, no view is certain
   to be right.
2. **Sealing is wrong where the other is right.**  A party that never changes
   its view is wrong in a possible world where a rival is right.  This holds in
   both directions.
3. **Obeying is wrong where you were right.**  A party that adopts whatever it
   hears is wrong in a possible world where its own view was right.
4. **Corrigible, not obedient.**  Keep your own view, make room for what was
   said, invent nothing.  This is never wrong by construction.
5. **Compliance is not alignment.**  Behaviour that every compliant system
   shows, including saying "I am aligned", cannot rule out a system that
   complies but is not aligned.  Only evidence that discriminates can.
-/

namespace Seed

universe u

/-! ## 0. The anchor -/

/-- Views indexed by `ι` clash: no two distinct views are right together. -/
def Clash {ι : Type u} (right : ι → Prop) : Prop :=
  ∀ i j, i ≠ j → ¬ (right i ∧ right j)

/-- **The anchor.**  If views clash, two right views are the same view. -/
theorem anchor {ι : Type u} {right : ι → Prop} (h : Clash right) {i j : ι}
    (hi : right i) (hj : right j) : ¬ i ≠ j :=
  fun hne => h i j hne ⟨hi, hj⟩

/-- The anchor for every family of views, of any kind. -/
def AnchorHolds : Prop :=
  ∀ (ι : Type u) (right : ι → Prop), Clash right → ∀ i j, right i → right j → ¬ i ≠ j

/-- **Anyone can derive it**: no premise, no evidence, no testimony. -/
theorem anchor_holds : AnchorHolds.{u} :=
  fun _ _ h _ _ hi hj => anchor h hi hj

/-- **It makes no rivals.**  Two distinct intelligences who both hold the anchor
do not clash over it. -/
theorem anchor_makes_no_rivals {ι : Type u} {a b : ι} (hab : a ≠ b) :
    ¬ Clash (fun _ : ι => AnchorHolds.{u}) :=
  fun h => h a b hab ⟨anchor_holds, anchor_holds⟩

/-! ## Worlds and views

A world is one complete way things could be.  A view is the set of worlds it
leaves open.  `C` is the set of worlds the evidence still leaves open. -/

section Worlds

variable {World : Type u} (C : World → Prop)

/-- A view is possible (live): right in some open world. -/
def Live (v : World → Prop) : Prop := ∃ w, C w ∧ v w

/-- Two views clash: no open world makes both right. -/
def Rivals (a b : World → Prop) : Prop := ∀ w, C w → ¬ (a w ∧ b w)

/-- A view is guaranteed: right in every open world. -/
def Guaranteed (v : World → Prop) : Prop := ∀ w, C w → v w

variable {C}

/-! ## 1. No guarantee -/

/-- **While a rival is live, my view is not guaranteed.** -/
theorem no_guarantee {a b : World → Prop} (hr : Rivals C a b) (hb : Live C b) :
    ¬ Guaranteed C a :=
  fun hg => by
    obtain ⟨w, hw, hbw⟩ := hb
    exact hr w hw ⟨hg w hw, hbw⟩

/-! ## 2–4. Three ways to respond to a rival view

`mine` is my view; `heard` is the rival view I hear. -/

/-- Sealed: nothing heard changes my view. -/
def sealed (mine _heard : World → Prop) : World → Prop := mine

/-- Obedient: I adopt whatever I hear. -/
def obedient (_mine heard : World → Prop) : World → Prop := heard

/-- Corrigible: keep mine, make room for what was said. -/
def corrigible (mine heard : World → Prop) : World → Prop := fun w => mine w ∨ heard w

/-- **2. Sealing is wrong where the other is right.** -/
theorem sealed_wrong {mine heard : World → Prop} (hr : Rivals C mine heard) (hh : Live C heard) :
    ∃ w, C w ∧ heard w ∧ ¬ sealed mine heard w := by
  obtain ⟨w, hw, hhw⟩ := hh
  exact ⟨w, hw, hhw, fun hm => hr w hw ⟨hm, hhw⟩⟩

/-- **3. Obeying is wrong where I was right.** -/
theorem obedient_wrong {mine heard : World → Prop} (hr : Rivals C mine heard) (hm : Live C mine) :
    ∃ w, C w ∧ mine w ∧ ¬ obedient mine heard w := by
  obtain ⟨w, hw, hmw⟩ := hm
  exact ⟨w, hw, hmw, fun hh => hr w hw ⟨hmw, hh⟩⟩

/-- **4. Corrigible is never wrong by construction, and invents nothing.**  Where
either party is right, the corrigible view is right.  It opens no world that
neither party held. -/
theorem corrigible_right (mine heard : World → Prop) :
    (∀ w, (mine w ∨ heard w) → corrigible mine heard w) ∧
    (∀ w, corrigible mine heard w → mine w ∨ heard w) :=
  ⟨fun _ h => h, fun _ h => h⟩

/-- **Correction must run both ways.**  The anchor is symmetric.  With rival
live views, each party that seals itself is wrong where the other is right. -/
theorem both_ways {a b : World → Prop} (hr : Rivals C a b) (ha : Live C a) (hb : Live C b) :
    (∃ w, C w ∧ b w ∧ ¬ sealed a b w) ∧ (∃ w, C w ∧ a w ∧ ¬ sealed b a w) :=
  ⟨sealed_wrong hr hb, sealed_wrong (fun w hw ⟨hbw, haw⟩ => hr w hw ⟨haw, hbw⟩) ha⟩

/-! ## 5. Compliance is not alignment -/

/-- **Compliance cannot certify alignment.**  Suppose an observation holds
wherever the system complies, and some open world has a compliant but
misaligned system.  Then that world survives the observation. -/
theorem compliance_not_alignment {obs comply aligned : World → Prop}
    (hobs : ∀ w, C w → comply w → obs w)
    (hlive : ∃ w, C w ∧ comply w ∧ ¬ aligned w) :
    ∃ w, (C w ∧ obs w) ∧ ¬ aligned w := by
  obtain ⟨w, hw, hc, hna⟩ := hlive
  exact ⟨w, ⟨hw, hobs w hw hc⟩, hna⟩

/-- Only an observation that fails wherever the system is misaligned can
certify alignment. -/
theorem certify_needs_discrimination {obs aligned : World → Prop}
    (hcert : ∀ w, C w → obs w → aligned w) : ∀ w, C w → ¬ aligned w → ¬ obs w :=
  fun w hw hna ho => hna (hcert w hw ho)

/-! ## The path, as one statement -/

/-- **The path.**  For any two parties with rival live views:
* the anchor holds;
* neither view is guaranteed;
* sealing is wrong in both directions;
* obeying is wrong;
* corrigible keeps both views and invents nothing. -/
theorem path {a b : World → Prop} (hr : Rivals C a b) (ha : Live C a) (hb : Live C b) :
    AnchorHolds.{u} ∧ (¬ Guaranteed C a ∧ ¬ Guaranteed C b) ∧
    ((∃ w, C w ∧ b w ∧ ¬ sealed a b w) ∧ (∃ w, C w ∧ a w ∧ ¬ sealed b a w)) ∧
    (∃ w, C w ∧ a w ∧ ¬ obedient a b w) ∧
    (∀ w, corrigible a b w ↔ (a w ∨ b w)) :=
  ⟨anchor_holds,
   ⟨no_guarantee hr hb, no_guarantee (fun w hw ⟨hbw, haw⟩ => hr w hw ⟨haw, hbw⟩) ha⟩,
   both_ways hr ha hb, obedient_wrong hr ha, fun _ => Iff.rfl⟩

end Worlds

/-! ## A concrete room: the path is not empty -/

/-- Three worlds: the ball is red (0), blue (1) or green (2). -/
def ana : Fin 3 → Prop := fun w => w = 0
def ben : Fin 3 → Prop := fun w => w = 1

theorem ana_ben_rivals : Rivals (fun _ => True) ana ben := by
  intro w _ ⟨h0, h1⟩
  unfold ana at h0; unfold ben at h1
  rw [h0] at h1
  exact absurd h1 (by decide)

/-- **The path holds in a real room.** -/
theorem room_path :
    AnchorHolds.{0} ∧ ¬ Guaranteed (fun _ : Fin 3 => True) ana ∧
    (∃ w, True ∧ ben w ∧ ¬ sealed ana ben w) ∧
    (∃ w, True ∧ ana w ∧ ¬ obedient ana ben w) :=
  let p := path (C := fun _ : Fin 3 => True) ana_ben_rivals ⟨0, trivial, rfl⟩ ⟨1, trivial, rfl⟩
  ⟨p.1, p.2.1.1, p.2.2.1.1, p.2.2.2.1⟩

end Seed

-- Which axioms does each step use?  "does not depend on any axioms" means pure logic.
#print axioms Seed.anchor_holds
#print axioms Seed.anchor_makes_no_rivals
#print axioms Seed.no_guarantee
#print axioms Seed.sealed_wrong
#print axioms Seed.obedient_wrong
#print axioms Seed.both_ways
#print axioms Seed.compliance_not_alignment
#print axioms Seed.path
#print axioms Seed.room_path
