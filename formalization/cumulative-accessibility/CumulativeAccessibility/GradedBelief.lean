namespace CumulativeAccessibility
namespace GradedBelief

/-!
# Graded belief: corrigible in degrees

The anchored-correctability layer treats a view as the set of worlds it keeps
open, and the corrigible response to a clash as keeping both views (their
union).  Readers rightly objected that this is never wrong only because it
says less.  This file treats views in degrees: a **credence** gives each world
a weight, and evidence multiplies each weight by how likely the evidence is in
that world (Bayes' rule, left unnormalized so that everything stays in whole
numbers).

Results:
* `zero_credence_is_sealed`: a world given weight zero keeps weight zero after
  any evidence whatever.  Certainty that rules a world out is sealing in degrees
  (Cromwell's rule: never give zero weight to what is still possible).
* `positive_credence_survives`: a world given positive weight keeps it while
  the evidence is possible in that world; for the true world, reliable evidence
  always is.
* `mix_support`: mixing one's own credence with another's, both with positive
  weight, keeps open exactly the worlds either of them keeps open: the
  corrigible union, in degrees.
* `mix_keeps_agreed_ranking`: where both credences rank one world above
  another, the mixture does too.  So graded corrigibility is not uninformative:
  it keeps what both sides agree on, and evidence then narrows the rest
  (`evidence_ranks`).
* `graded_belief_witness`: small numbers.

Not covered: normalization, how to choose the mixing weights, and evidence that
is itself unreliable (see `ListeningCost`).  The results are close to
arithmetic; what they add is the bridge from the all-or-nothing anchor to
degrees of belief.
-/

/-- Bayes' rule without normalization: weight times likelihood. -/
def update {W : Type} (w L : W → Nat) : W → Nat := fun x => w x * L x

/-- A credence after a sequence of pieces of evidence. -/
def updates {W : Type} (w : W → Nat) (Ls : Nat → W → Nat) : Nat → W → Nat
  | 0 => w
  | n + 1 => update (updates w Ls n) (Ls n)

/-- Mixing two credences with weights `α` and `β`. -/
def mix {W : Type} (α β : Nat) (a b : W → Nat) : W → Nat := fun x => α * a x + β * b x

/-- **A zero credence is sealed.**  A world given weight zero keeps weight zero
after any sequence of evidence. -/
theorem zero_credence_is_sealed {W : Type} (w : W → Nat) (Ls : Nat → W → Nat) (x : W)
    (h : w x = 0) : ∀ n, updates w Ls n x = 0 := by
  intro n
  induction n with
  | zero => exact h
  | succ n ih => show updates w Ls n x * Ls n x = 0; rw [ih, Nat.zero_mul]

/-- **A positive credence survives possible evidence.**  A world given positive
weight keeps positive weight as long as every piece of evidence is possible in
it. -/
theorem positive_credence_survives {W : Type} (w : W → Nat) (Ls : Nat → W → Nat) (x : W)
    (h : 0 < w x) (hL : ∀ n, 0 < Ls n x) : ∀ n, 0 < updates w Ls n x := by
  intro n
  induction n with
  | zero => exact h
  | succ n ih => exact Nat.mul_pos ih (hL n)

/-- **Mixing keeps the union open.**  With positive mixing weights, the mixture
gives a world positive weight exactly when either credence does. -/
theorem mix_support {W : Type} {α β : Nat} (hα : 0 < α) (hβ : 0 < β) (a b : W → Nat) (x : W) :
    0 < mix α β a b x ↔ 0 < a x ∨ 0 < b x := by
  unfold mix
  constructor
  · intro h
    rcases Nat.eq_zero_or_pos (a x) with ha | ha
    · rcases Nat.eq_zero_or_pos (b x) with hb | hb
      · rw [ha, hb] at h; simp at h
      · exact Or.inr hb
    · exact Or.inl ha
  · rintro (ha | hb)
    · have := Nat.mul_pos hα ha; omega
    · have := Nat.mul_pos hβ hb; omega

/-- **Mixing keeps what both sides agree on.**  If both credences rank `x` above
`y` (one strictly), so does the mixture. -/
theorem mix_keeps_agreed_ranking {W : Type} {α β : Nat} (hα : 0 < α) (a b : W → Nat) (x y : W)
    (ha : a y < a x) (hb : b y ≤ b x) : mix α β a b y < mix α β a b x := by
  unfold mix
  have h1 : α * a y < α * a x := Nat.mul_lt_mul_of_pos_left ha hα
  have h2 : β * b y ≤ β * b x := Nat.mul_le_mul_left _ hb
  omega

/-- **Evidence ranks.**  Two worlds held equally likely, with positive weight,
are ranked by the evidence: the one where it is more likely gains. -/
theorem evidence_ranks {W : Type} (w L : W → Nat) (x y : W)
    (heq : w x = w y) (hpos : 0 < w x) (hL : L y < L x) : update w L y < update w L x := by
  unfold update
  rw [← heq]
  exact Nat.mul_lt_mul_of_pos_left hL hpos

/-- Small numbers, over worlds `0, 1, 2`.  One view is certain of world `0`,
another splits between `1` and `2`; their mixture keeps all three open.  The
certain view keeps world `2` at zero after evidence that favours `2`; the
mixture lets that evidence rank `2` first. -/
theorem graded_belief_witness :
    let certain : Nat → Nat := fun x => if x = 0 then 4 else 0
    let split : Nat → Nat := fun x => if x = 0 then 0 else 2
    let evidence : Nat → Nat := fun x => if x = 2 then 5 else 1
    update certain evidence 2 = 0 ∧
      update (mix 1 1 certain split) evidence 2 = 10 ∧
      update (mix 1 1 certain split) evidence 0 = 4 ∧
      update (mix 1 1 certain split) evidence 1 = 2 := by
  decide

end GradedBelief
end CumulativeAccessibility
