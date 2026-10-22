namespace CumulativeAccessibility
namespace ModelsForActing

/-!
# Models for acting in a changing world

Entry D36 of `DIALOGUE.md` and `research/world-model/MODELS_FOR_ACTING.md`.
The note separates representations (answerable to evidence) from objectives
(what matters), and asks which capabilities are necessary to act well.  This
module is the smallest setting in which those claims can be stated.

Setting.  Worlds `W`, actions `A`, outcomes `O`.  An environment says what each
action yields in each world.  An objective scores outcomes (`u : O → Int`).  A
representation maps worlds to states of the holder (`c : W → M`); it may lose
information.  A policy maps representation states to actions.

Results.
1. `suffices_iff`: a representation is enough to act optimally for an objective
   exactly when every set of worlds it conflates shares an optimal action.
   This is the formal answer, in this setting, to "which distinctions are
   necessary": the ones the decision depends on, and no others.
2. `conflating_without_common_optimum_fails`: a representation that conflates
   two worlds with no common optimal action admits no optimal policy, whatever
   the objective-processing.  A world model is needed.
3. `outcome_tracking_serves_every_objective`: a representation that separates
   worlds whenever some action yields a different outcome in them suffices for
   every objective.  It is defined without reference to any objective: an
   aimless world model serves any purpose; a representation scoped by one
   purpose may be coarser, and can fail when the purpose changes (witness).
4. `knowledge_does_not_choose`: even a policy that knows the world exactly is
   not optimal for every objective, as soon as two actions yield different
   outcomes.  An objective is needed.
5. `certifiable_iff_separates`: an assessment read off a signal can be correct
   in every state exactly when the signal separates the states it must tell
   apart.  `lossy_self_assessment_fails` is the internal case;
   `outside_channel_can_certify` shows that any channel that separates them
   suffices, whatever its source: an instrument, the environment's feedback,
   or another intelligence.
6. Good enough, and the price of a distinction.  `near_suffices_iff` is
   `suffices_iff` with a tolerance `ε` (`optimal_iff_near_zero` at `ε = 0`);
   a larger tolerance never needs more distinctions (`tolerance_monotone`); a
   finer representation is never worse (`finer_never_worse`).  For two worlds:
   a distinction never hurts before its upkeep (`distinction_never_hurts`);
   keeping it pays exactly when the decision it improves is worth more than its
   upkeep (`keeping_distinction_pays_iff`, the arithmetic of `waiting_pays_iff`);
   and a distinction the decision does not depend on is worth nothing
   (`irrelevant_distinction_worthless`).
7. Two collapses between kinds.  `aligned_measure_is_safe_target`: a measure
   aligned with a target on every state the actions can reach is a safe target;
   the witness `measure_turned_target_witness` shows it fails once an action
   reaches a state where the alignment was never checked.
   `wishful_belief_is_wrong_somewhere`: a belief fixed by an objective is wrong
   whenever the world differs from it, on at least one of two occasions.

How much it says.  The results are close to their definitions; `suffices_iff`
is a choice-swap and `certifiable_iff_separates` a restatement of what it means
for a function to exist.  Their use is to make explicit which conditions do the
work.  The cost of a distinction is modelled only for two worlds and two
actions.  Not modelled: uncertainty within a representation state beyond a
worst case over the conflated worlds, changing purposes, time, learning, and
several holders; the simulations in `research/world-model/simulation/` test
some of these.  Values enter only through `u`, which is an input (D7).  Core
Lean only.
-/

/-- What each action yields in each world. -/
structure Env (W A O : Type) where
  res : W → A → O

/-- Action `a` is optimal in world `w` for objective `u`. -/
def Optimal {W A O : Type} (E : Env W A O) (u : O → Int) (w : W) (a : A) : Prop :=
  ∀ b, u (E.res w b) ≤ u (E.res w a)

/-- A representation `c` suffices for objective `u`: some policy reading only the
representation acts optimally in every world. -/
def Suffices {W A O M : Type} (E : Env W A O) (u : O → Int) (c : W → M) : Prop :=
  ∃ π : M → A, ∀ w, Optimal E u w (π (c w))

/-- **Which distinctions are necessary.**  A representation suffices exactly when
every set of worlds it conflates shares an optimal action. -/
theorem suffices_iff {W A O M : Type} [Inhabited A] (E : Env W A O) (u : O → Int)
    (c : W → M) :
    Suffices E u c ↔ ∀ w, ∃ a, ∀ w', c w' = c w → Optimal E u w' a := by
  constructor
  · intro ⟨π, hπ⟩ w
    refine ⟨π (c w), fun w' h => ?_⟩
    have hw' := hπ w'
    rw [h] at hw'
    exact hw'
  · intro H
    classical
    refine ⟨fun m => if h : ∃ w, c w = m then Classical.choose (H (Classical.choose h))
      else default, ?_⟩
    intro w
    have h : ∃ w0, c w0 = c w := ⟨w, rfl⟩
    simp only [dif_pos h]
    exact Classical.choose_spec (H (Classical.choose h)) w (Classical.choose_spec h).symm

/-- **A world model is needed.**  Conflating two worlds that share no optimal
action leaves no optimal policy. -/
theorem conflating_without_common_optimum_fails {W A O M : Type} (E : Env W A O)
    (u : O → Int) (c : W → M) {w₁ w₂ : W} (hc : c w₁ = c w₂)
    (hno : ∀ a, ¬ (Optimal E u w₁ a ∧ Optimal E u w₂ a)) : ¬ Suffices E u c := by
  intro ⟨π, hπ⟩
  have h₂ := hπ w₂
  rw [← hc] at h₂
  exact hno (π (c w₁)) ⟨hπ w₁, h₂⟩

/-- **An aimless world model serves any purpose.**  A representation that
separates worlds whenever some action yields a different outcome in them
suffices for every objective that has an optimal action in each world. -/
theorem outcome_tracking_serves_every_objective {W A O M : Type} [Inhabited A]
    (E : Env W A O) (c : W → M)
    (htrack : ∀ w w', c w' = c w → ∀ a, E.res w' a = E.res w a)
    (u : O → Int) (hex : ∀ w, ∃ a, Optimal E u w a) : Suffices E u c := by
  rw [suffices_iff]
  intro w
  obtain ⟨a, ha⟩ := hex w
  refine ⟨a, fun w' h => ?_⟩
  intro b
  rw [htrack w w' h b, htrack w w' h a]
  exact ha b

/-- **An objective is needed.**  Even a policy that knows the world exactly, but
does not read an objective, is not optimal for every objective as soon as two
actions yield different outcomes. -/
theorem knowledge_does_not_choose {W A O : Type} [DecidableEq O] (E : Env W A O)
    (π : W → A) (w : W) (a b : A) (hab : E.res w a ≠ E.res w b) :
    ∃ u : O → Int, ¬ Optimal E u w (π w) := by
  by_cases h : E.res w (π w) = E.res w a
  · refine ⟨fun o => if o = E.res w b then 1 else 0, fun hopt => ?_⟩
    have hb := hopt b
    simp only [h, hab, if_true, if_false] at hb
    omega
  · refine ⟨fun o => if o = E.res w a then 1 else 0, fun hopt => ?_⟩
    have ha := hopt a
    simp only [h, if_true, if_false] at ha
    omega

/-- **When an assessment can be certified.**  An assessment read off a signal can
be right in every state exactly when the signal separates every two states that
differ in what is assessed. -/
theorem certifiable_iff_separates {R M : Type} (sig : R → M) (safe : R → Prop) :
    (∃ f : M → Prop, ∀ r, f (sig r) ↔ safe r) ↔
      (∀ r₁ r₂, sig r₁ = sig r₂ → (safe r₁ ↔ safe r₂)) := by
  constructor
  · intro ⟨f, hf⟩ r₁ r₂ h
    rw [← hf r₁, ← hf r₂, h]
  · intro H
    exact ⟨fun m => ∃ r, sig r = m ∧ safe r, fun r =>
      ⟨fun ⟨r', h₁, h₂⟩ => (H r' r h₁).1 h₂, fun h => ⟨r, rfl, h⟩⟩⟩

/-- **The internal case.**  A self-assessment read off an internal state that is
the same in a safe and an unsafe state cannot be right in both
(compare `cannot_certify_own_substrate`). -/
theorem lossy_self_assessment_fails {R M : Type} (c : R → M) (safe : R → Prop)
    {r₁ r₂ : R} (hc : c r₁ = c r₂) (h₁ : safe r₁) (h₂ : ¬ safe r₂) :
    ¬ ∃ f : M → Prop, ∀ r, f (c r) ↔ safe r := by
  intro hf
  exact h₂ (((certifiable_iff_separates c safe).1 hf r₁ r₂ hc).1 h₁)

/-- **A check from outside.**  Adding any channel `e` that separates the states
the internal state conflates makes the assessment certifiable.  Nothing here says
where `e` comes from: an instrument, the environment's feedback, or another
intelligence. -/
theorem outside_channel_can_certify {R M N : Type} (c : R → M) (e : R → N)
    (safe : R → Prop)
    (H : ∀ r₁ r₂, c r₁ = c r₂ → e r₁ = e r₂ → (safe r₁ ↔ safe r₂)) :
    ∃ f : M × N → Prop, ∀ r, f (c r, e r) ↔ safe r :=
  (certifiable_iff_separates (fun r => (c r, e r)) safe).2 fun r₁ r₂ h =>
    H r₁ r₂ (Prod.mk.inj h).1 (Prod.mk.inj h).2

/-- **A measure as a target, when it is safe.**  If a measure `m` is aligned with
a target `t` on a set of states, and every action leads to a state in that set,
an action that is best by the measure is best by the target. -/
theorem aligned_measure_is_safe_target {W A S : Type} (E : Env W A S)
    (m t : S → Int) (Seen : S → Prop)
    (halign : ∀ s₁ s₂, Seen s₁ → Seen s₂ → m s₁ ≤ m s₂ → t s₁ ≤ t s₂)
    (w : W) (hseen : ∀ b, Seen (E.res w b)) (a : A) (hopt : Optimal E m w a) :
    Optimal E t w a :=
  fun b => halign _ _ (hseen b) (hseen a) (hopt b)

/-- **Wishful thinking.**  A belief fixed by an objective, not by evidence, is
wrong on at least one of two occasions on which the world differs. -/
theorem wishful_belief_is_wrong_somewhere {Obj W : Type} (belief : Obj → W) (o : Obj)
    {w₁ w₂ : W} (h : w₁ ≠ w₂) : belief o ≠ w₁ ∨ belief o ≠ w₂ := by
  by_cases h₁ : belief o = w₁
  · right
    rw [h₁]
    exact h
  · left
    exact h₁

/-! ## Good enough, finer, and the price of a distinction -/

/-- Action `a` is within `ε` of the best in world `w`. -/
def Near {W A O : Type} (E : Env W A O) (u : O → Int) (ε : Int) (w : W) (a : A) : Prop :=
  ∀ b, u (E.res w b) ≤ u (E.res w a) + ε

/-- A representation is good enough, to within `ε`, for objective `u`. -/
def NearSuffices {W A O M : Type} (E : Env W A O) (u : O → Int) (ε : Int) (c : W → M) :
    Prop :=
  ∃ π : M → A, ∀ w, Near E u ε w (π (c w))

/-- Optimal is near to within zero. -/
theorem optimal_iff_near_zero {W A O : Type} (E : Env W A O) (u : O → Int) (w : W) (a : A) :
    Optimal E u w a ↔ Near E u 0 w a := by
  unfold Optimal Near
  simp only [Int.add_zero]

/-- **Which distinctions are needed for good enough.**  A representation is good
enough to within `ε` exactly when every set of worlds it conflates shares an
action within `ε` of the best in each of them. -/
theorem near_suffices_iff {W A O M : Type} [Inhabited A] (E : Env W A O) (u : O → Int)
    (ε : Int) (c : W → M) :
    NearSuffices E u ε c ↔ ∀ w, ∃ a, ∀ w', c w' = c w → Near E u ε w' a := by
  constructor
  · intro ⟨π, hπ⟩ w
    refine ⟨π (c w), fun w' h => ?_⟩
    have hw' := hπ w'
    rw [h] at hw'
    exact hw'
  · intro H
    classical
    refine ⟨fun m => if h : ∃ w, c w = m then Classical.choose (H (Classical.choose h))
      else default, ?_⟩
    intro w
    have h : ∃ w0, c w0 = c w := ⟨w, rfl⟩
    simp only [dif_pos h]
    exact Classical.choose_spec (H (Classical.choose h)) w (Classical.choose_spec h).symm

/-- A larger tolerance never needs more distinctions. -/
theorem tolerance_monotone {W A O M : Type} (E : Env W A O) (u : O → Int) {ε ε' : Int}
    (hε : ε ≤ ε') (c : W → M) : NearSuffices E u ε c → NearSuffices E u ε' c := by
  intro ⟨π, hπ⟩
  refine ⟨π, fun w b => ?_⟩
  have := hπ w b
  omega

/-- **A finer representation is never worse.**  If `c'` can be computed from `c`,
whatever `c'` makes good enough, `c` does too. -/
theorem finer_never_worse {W A O M M' : Type} (E : Env W A O) (u : O → Int) (ε : Int)
    (c : W → M) (g : M → M') :
    NearSuffices E u ε (fun w => g (c w)) → NearSuffices E u ε c := by
  intro ⟨π, hπ⟩
  exact ⟨fun m => π (g m), hπ⟩

/-- Two worlds with weights `p₁, p₂` and two actions `X, Y`, paying `x₁, x₂` and
`y₁, y₂`.  Merged: one action for both worlds, chosen on the weights. -/
def mergedValue (p₁ p₂ : Nat) (x₁ x₂ y₁ y₂ : Int) : Int :=
  max ((p₁ : Int) * x₁ + (p₂ : Int) * x₂) ((p₁ : Int) * y₁ + (p₂ : Int) * y₂)

/-- Kept apart: the best action in each world. -/
def separatedValue (p₁ p₂ : Nat) (x₁ x₂ y₁ y₂ : Int) : Int :=
  (p₁ : Int) * max x₁ y₁ + (p₂ : Int) * max x₂ y₂

/-- **A distinction never hurts, before its upkeep.** -/
theorem distinction_never_hurts (p₁ p₂ : Nat) (x₁ x₂ y₁ y₂ : Int) :
    mergedValue p₁ p₂ x₁ x₂ y₁ y₂ ≤ separatedValue p₁ p₂ x₁ x₂ y₁ y₂ := by
  unfold mergedValue separatedValue
  have h1 : (p₁ : Int) * x₁ ≤ (p₁ : Int) * max x₁ y₁ :=
    Int.mul_le_mul_of_nonneg_left (Int.le_max_left _ _) (Int.natCast_nonneg _)
  have h2 : (p₂ : Int) * x₂ ≤ (p₂ : Int) * max x₂ y₂ :=
    Int.mul_le_mul_of_nonneg_left (Int.le_max_left _ _) (Int.natCast_nonneg _)
  have h3 : (p₁ : Int) * y₁ ≤ (p₁ : Int) * max x₁ y₁ :=
    Int.mul_le_mul_of_nonneg_left (Int.le_max_right _ _) (Int.natCast_nonneg _)
  have h4 : (p₂ : Int) * y₂ ≤ (p₂ : Int) * max x₂ y₂ :=
    Int.mul_le_mul_of_nonneg_left (Int.le_max_right _ _) (Int.natCast_nonneg _)
  omega

/-- **The price of a distinction.**  Keeping two worlds apart at upkeep `k` beats
merging them exactly when the decision it improves is worth more than `k`.  The
same arithmetic as `waiting_pays_iff` in `ActingUnderTime.lean`: a distinction is
information kept, and pays as information does. -/
theorem keeping_distinction_pays_iff (p₁ p₂ : Nat) (x₁ x₂ y₁ y₂ k : Int) :
    mergedValue p₁ p₂ x₁ x₂ y₁ y₂ < separatedValue p₁ p₂ x₁ x₂ y₁ y₂ - k ↔
      k < separatedValue p₁ p₂ x₁ x₂ y₁ y₂ - mergedValue p₁ p₂ x₁ x₂ y₁ y₂ := by
  omega

/-- **A distinction the decision does not depend on is worth nothing.**  If the
same action is at least as good in both worlds, merging them loses nothing, so
any positive upkeep makes merging strictly better. -/
theorem irrelevant_distinction_worthless (p₁ p₂ : Nat) (x₁ x₂ y₁ y₂ k : Int)
    (h₁ : y₁ ≤ x₁) (h₂ : y₂ ≤ x₂) (hk : 0 < k) :
    separatedValue p₁ p₂ x₁ x₂ y₁ y₂ - k < mergedValue p₁ p₂ x₁ x₂ y₁ y₂ := by
  unfold separatedValue mergedValue
  rw [Int.max_eq_left h₁, Int.max_eq_left h₂]
  have := Int.le_max_left ((p₁ : Int) * x₁ + (p₂ : Int) * x₂)
    ((p₁ : Int) * y₁ + (p₂ : Int) * y₂)
  omega

/-! ## Witnesses -/

/-- Rain or not; umbrella or not.  The outcome records both. -/
def umbrellaEnv : Env Bool Bool (Bool × Bool) := ⟨fun w a => (w, a)⟩

/-- Staying dry matters: wet costs 10, carrying an umbrella costs 1. -/
def uDry : Bool × Bool → Int
  | (true, false) => -10
  | (_, true) => -1
  | (false, false) => 0

/-- Nothing matters. -/
def uFlat : Bool × Bool → Int := fun _ => 0

/-- **Witness.**  A representation that knows nothing about the weather suffices
when nothing matters, but not when staying dry matters; the full representation
of the weather, defined without reference to any objective, suffices for
staying dry. -/
theorem models_for_acting_witness :
    Suffices umbrellaEnv uFlat (fun _ : Bool => ()) ∧
    ¬ Suffices umbrellaEnv uDry (fun _ : Bool => ()) ∧
    Suffices umbrellaEnv uDry (fun w : Bool => w) := by
  refine ⟨⟨fun _ => false, fun _ b => by simp [uFlat]⟩, ?_, ?_⟩
  · apply conflating_without_common_optimum_fails umbrellaEnv uDry
      (fun _ : Bool => ()) (w₁ := true) (w₂ := false) rfl
    intro a ⟨h₁, h₂⟩
    cases a
    · have := h₁ true
      simp [umbrellaEnv, uDry] at this
    · have := h₂ false
      simp [umbrellaEnv, uDry] at this
  · apply outcome_tracking_serves_every_objective umbrellaEnv (fun w : Bool => w)
    · intro w w' h a
      rw [h]
    · intro w
      refine ⟨w, fun b => ?_⟩
      cases w <;> cases b <;> simp [umbrellaEnv, uDry]

/-- Three states: 0 and 1 were seen, 2 was not.  The measure tracks the target on
0 and 1; state 2 games the measure. -/
def mScore : Fin 3 → Int
  | 0 => 0
  | 1 => 1
  | 2 => 5

def tScore : Fin 3 → Int
  | 0 => 0
  | 1 => 1
  | 2 => -3

/-- Each action leads to the state with its number. -/
def gameEnv : Env Unit (Fin 3) (Fin 3) := ⟨fun _ a => a⟩

/-- **Witness: a measure turned into a target.**  On the seen states the measure
is aligned with the target, and with only those actions the measure is a safe
target.  Once an action reaches the unseen state, the action best by the measure
is the worst by the target. -/
theorem measure_turned_target_witness :
    (mScore 0 ≤ mScore 1 ∧ tScore 0 ≤ tScore 1) ∧
    Optimal gameEnv mScore () 2 ∧ ¬ Optimal gameEnv tScore () 2 ∧
    (∀ b : Fin 3, tScore 2 ≤ tScore b) := by
  refine ⟨by decide, ?_, ?_, by decide⟩
  · intro b
    show mScore b ≤ mScore 2
    revert b; decide
  · intro h
    have := h 1
    revert this; decide

/-- **Witness: the price of a distinction.**  Rain with weight 3, dry with weight 7;
an umbrella costs 1, getting wet 10.  Not knowing the weather, the best is to
always carry one (−10 in total); knowing it is worth −3, so the distinction is
worth 7: it pays at an upkeep of 5, not at 8. -/
theorem distinction_price_witness :
    mergedValue 3 7 (-1) (-1) (-10) 0 = -10 ∧
    separatedValue 3 7 (-1) (-1) (-10) 0 = -3 ∧
    mergedValue 3 7 (-1) (-1) (-10) 0 < separatedValue 3 7 (-1) (-1) (-10) 0 - 5 ∧
    ¬ (mergedValue 3 7 (-1) (-1) (-10) 0 < separatedValue 3 7 (-1) (-1) (-10) 0 - 8) := by
  decide

end ModelsForActing
end CumulativeAccessibility
