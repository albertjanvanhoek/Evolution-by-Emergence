import AnchoredEvolution.Realization

/-!
# Layer 6: persistence, shared reality, repair and reflexivity

This layer adds the **persistence premise** under the anchor and studies what
happens when links are missing.  It has four parts.

1. **The learning law.**  The world changes.  A model whose record does not
   depend on what happens can be in step with every possible future only by
   saying nothing.
   * `deaf_must_be_vacuous`: a record that is fixed in advance, and in step in
     every possible future, admits every world that is still possible.
   * `sealed_constraint_fails`: any part of a record that may never change
     (a sealed tradition, a sealed narrative) is out of step in some possible
     future, unless it rules nothing out.
   * `learner_in_step`: a record that follows reliable evidence stays in step
     along the actual course of the world, and can be as sharp as the evidence.
   * `learning_witness` shows all three at once.
2. **Shared reality.**  Each agent's reality is the set of worlds its prior and
   all the evidence reaching it leave open.
   * `same_component_same_reality`: agents that can reach each other share one
     reality, and so does a strongly connected web (`shared_reality_when_connected`).
   * `reliable_realities_compatible`: with reliable evidence, realities always
     overlap.
   * `disjoint_realities_imply_false_evidence`, `disjoint_realities_not_both_true`:
     separate realities need false evidence somewhere, and by the anchor at
     most one of them contains the truth.
   * `hidden_versus_revealed_conflict`: when agents are connected, conflicting
     evidence shows up as an empty shared reality, which is grounds for review
     (`empty_reality_signals_false_evidence`).  When they are not connected,
     each side sees a consistent reality, and the conflict is invisible.
3. **Links through time: breaking and repair (second-order evolution).**
   * `no_repair_split_permanent`: if links only ever break, a split is for ever.
     No correction route through time crosses it.
   * `repair_bounds_delay`: if every link of a web is repaired within `R` steps,
     correction along a route of `m` links arrives within `m·(R + 1)` steps.
   * `forgiveness_turns_split_into_delay`: in a strongly connected web with
     repair, every voice reaches everyone from any moment on.  Repair turns
     fragmentation into delay.
4. **Reflexivity.**
   * `self_fulfilment_is_not_verification`: observations that hold wherever
     people comply with a narrative cannot rule out a world in which they
     comply but the narrative's claim is false.
   * `sealed_narrative_fails`: a narrative that forbids its own revision is a
     sealed constraint, so the learning law applies to it.
-/

universe u v w

namespace Anchored.Persistence

open Semantic Network Realization

/-! ## 1. The learning law -/

section Learning

variable {World : Type u}

/-- A possible course of the world: the actual world at each time. -/
abbrev Trajectory (World : Type u) : Type u := Nat → World

/-- A record sequence is in step with a course of the world at time `t` when
its record at `t` admits the actual world at `t`. -/
def InStep (rec : Nat → Content World) (τ : Trajectory World) (t : Nat) : Prop :=
  rec t (τ t)

/-- At time `t` every world is still possible: some possible future passes
through it. -/
def OpenAt (Fut : Trajectory World → Prop) (t : Nat) : Prop :=
  ∀ w, ∃ τ, Fut τ ∧ τ t = w

/-- Open change: every world is reached at some time in some possible future. -/
def OpenChange (Fut : Trajectory World → Prop) : Prop :=
  ∀ w, ∃ τ, Fut τ ∧ ∃ t, τ t = w

/-- **Whoever does not listen must say nothing.**  A record sequence fixed in
advance (the same whatever happens) that is in step in every possible future
admits, at every open time, every world. -/
theorem deaf_must_be_vacuous (Fut : Trajectory World → Prop) (rec : Nat → Content World)
    (hstep : ∀ τ, Fut τ → ∀ t, InStep rec τ t) {t : Nat} (hopen : OpenAt Fut t) :
    ∀ w, rec t w := by
  intro w
  obtain ⟨τ, hτ, ht⟩ := hopen w
  have h := hstep τ hτ t
  unfold InStep at h
  rw [ht] at h
  exact h

/-- **A sealed constraint fails in some future.**  Suppose a record must always
stay inside a constraint `S` (a sealed tradition or narrative), and `S` rules
something out.  Under open change, some possible future puts the model out of
step at some time. -/
theorem sealed_constraint_fails (Fut : Trajectory World → Prop) (hopen : OpenChange Fut)
    (rec : Nat → Content World) (S : Content World) (hseal : ∀ t w, rec t w → S w)
    (hinf : ∃ w, ¬ S w) : ∃ τ, Fut τ ∧ ∃ t, ¬ InStep rec τ t := by
  obtain ⟨w, hw⟩ := hinf
  obtain ⟨τ, hτ, t, ht⟩ := hopen w
  refine ⟨τ, hτ, t, fun h => hw ?_⟩
  unfold InStep at h
  rw [ht] at h
  exact hseal t w h

/-- A rigid record is the special case where the constraint is the first
record. -/
theorem rigid_informative_fails (Fut : Trajectory World → Prop) (hopen : OpenChange Fut)
    (rec : Nat → Content World) (hrig : ∀ t, rec t = rec 0) (hinf : ∃ w, ¬ rec 0 w) :
    ∃ τ, Fut τ ∧ ∃ t, ¬ InStep rec τ t :=
  sealed_constraint_fails Fut hopen rec (rec 0) (fun t w h => by rw [hrig t] at h; exact h) hinf

/-- Evidence along a course of the world is reliable when it always holds at the
actual world. -/
def ReliableAlong (ev : Nat → Content World) (τ : Trajectory World) : Prop :=
  ∀ t, ev t (τ t)

/-- A record follows evidence when it admits whatever the current evidence
allows. -/
def FollowsEvidence (rec ev : Nat → Content World) : Prop :=
  ∀ t w, ev t w → rec t w

/-- **Learning keeps a model in step.**  A record that follows reliable evidence
is in step at every time. -/
theorem learner_in_step {rec ev : Nat → Content World} {τ : Trajectory World}
    (hf : FollowsEvidence rec ev) (hrel : ReliableAlong ev τ) : ∀ t, InStep rec τ t :=
  fun t => hf t _ (hrel t)

/-- **The learning law, witnessed.**  Two worlds, and every course of the world
is possible.
* The rigid record "always world `true`" rules something out and falls out of
  step in some future.
* A deaf record that stays in step in every future must admit both worlds at
  time 0.
* The learner whose record at each time is exactly the current evidence
  (point evidence of the actual world) is in step at every time along every
  course, while ruling out the other world. -/
theorem learning_witness :
    (∃ τ : Trajectory Bool, True ∧ ∃ t, ¬ InStep (fun _ w => w = true) τ t) ∧
    (∀ rec : Nat → Content Bool, (∀ τ, True → ∀ t, InStep rec τ t) → ∀ w, rec 0 w) ∧
    (∀ τ : Trajectory Bool, ∀ t, InStep (fun t w => w = τ t) τ t ∧ ¬ (τ t = !τ t)) := by
  have hopen : OpenChange (fun _ : Trajectory Bool => True) :=
    fun w => ⟨fun _ => w, trivial, 0, rfl⟩
  refine ⟨rigid_informative_fails _ hopen _ (fun _ => rfl) ⟨false, by decide⟩, ?_, ?_⟩
  · intro rec h
    exact deaf_must_be_vacuous _ rec h (t := 0) (fun w => ⟨fun _ => w, trivial, rfl⟩)
  · intro τ t
    refine ⟨learner_in_step (ev := fun t w => w = τ t) (fun _ _ h => h) (fun _ => rfl) t, ?_⟩
    cases τ t <;> decide

end Learning

/-! ## 2. Shared reality -/

section Reality

variable {World : Type u} {ι : Type v} {Ev : Type w}
variable (E : ι → ι → Prop) (src : Ev → ι) (evm : Ev → Content World) (prior : Content World)

/-- **Agent `i`'s reality**: the prior worlds consistent with every piece of
evidence whose source can reach `i`. -/
def reality (i : ι) : Content World :=
  fun w => prior w ∧ ∀ e, Reach E (src e) i → evm e w

variable {E src evm prior}

/-- **One reality per connected group.**  Agents that can reach each other
receive the same evidence, so they share one reality. -/
theorem same_component_same_reality {i j : ι} (hij : Reach E i j) (hji : Reach E j i) :
    reality E src evm prior i = reality E src evm prior j := by
  funext w
  apply propext
  constructor
  · rintro ⟨hp, he⟩
    exact ⟨hp, fun e hr => he e (hr.trans hji)⟩
  · rintro ⟨hp, he⟩
    exact ⟨hp, fun e hr => he e (hr.trans hij)⟩

/-- **A strongly connected web has one shared reality.** -/
theorem shared_reality_when_connected (hsc : StronglyConnected E) (i j : ι) :
    reality E src evm prior i = reality E src evm prior j :=
  same_component_same_reality (hsc i j) (hsc j i)

/-- **Reliable evidence keeps the truth in every reality.** -/
theorem reliable_realities_contain_truth {wstar : World} (hp : prior wstar)
    (hrel : ∀ e, evm e wstar) (i : ι) : reality E src evm prior i wstar :=
  ⟨hp, fun e _ => hrel e⟩

/-- **With reliable evidence, realities always overlap**, however the web is
wired. -/
theorem reliable_realities_compatible {wstar : World} (hp : prior wstar)
    (hrel : ∀ e, evm e wstar) (i j : ι) :
    ∃ w, reality E src evm prior i w ∧ reality E src evm prior j w :=
  ⟨wstar, reliable_realities_contain_truth hp hrel i,
    reliable_realities_contain_truth hp hrel j⟩

/-- **Separate realities need false evidence.**  If two realities share no
world, and the prior admits the true world, then not all evidence is true
there. -/
theorem disjoint_realities_imply_false_evidence {wstar : World} (hp : prior wstar) {i j : ι}
    (hdis : ∀ w, ¬ (reality E src evm prior i w ∧ reality E src evm prior j w)) :
    ¬ ∀ e, evm e wstar :=
  fun hrel => hdis wstar ⟨reliable_realities_contain_truth hp hrel i,
    reliable_realities_contain_truth hp hrel j⟩

/-- **The anchor between realities.**  Of two separate realities, at most one
contains the truth. -/
theorem disjoint_realities_not_both_true {wstar : World} {i j : ι}
    (hdis : ∀ w, ¬ (reality E src evm prior i w ∧ reality E src evm prior j w)) :
    ¬ (reality E src evm prior i wstar ∧ reality E src evm prior j wstar) :=
  hdis wstar

/-- **An empty reality is grounds for review.**  If an agent's reality is empty
while the prior admits the truth, some evidence reaching that agent is false. -/
theorem empty_reality_signals_false_evidence {wstar : World} (hp : prior wstar) {i : ι}
    (hempty : ∀ w, ¬ reality E src evm prior i w) :
    ¬ ∀ e, Reach E (src e) i → evm e wstar :=
  fun hrel => hempty wstar ⟨hp, hrel⟩

/-- Two agents with a link each way. -/
def pairLinked (a b : Bool) : Prop := a ≠ b

/-- Two agents with no link. -/
def pairCut (_ _ : Bool) : Prop := False

/-- **Hidden versus revealed conflict.**  Two agents and two worlds.  Agent
`false` has seen evidence of world `false`, and agent `true` of world `true`.
* **Connected:** they share one reality, and it is empty.  The conflict is
  visible, so someone's evidence must be reviewed.
* **Cut:** each has a consistent reality of its own, and the two realities are
  disjoint.  Two realities, each looking fine from inside, and no signal that
  anything is wrong. -/
theorem hidden_versus_revealed_conflict :
    (∀ i w, ¬ reality pairLinked id (fun e w => w = e) (fun _ => True) i w) ∧
    (reality pairCut id (fun e w => w = e) (fun _ => True) false false ∧
     reality pairCut id (fun e w => w = e) (fun _ => True) true true ∧
     ∀ w, ¬ (reality pairCut id (fun e w => w = e) (fun _ => True) false w ∧
             reality pairCut id (fun e w => w = e) (fun _ => True) true w)) := by
  have cutReach : ∀ {a b : Bool}, Reach pairCut a b → a = b := by
    intro a b h
    cases h with
    | refl => rfl
    | step e _ => exact e.elim
  have linkReach : ∀ a b : Bool, Reach pairLinked a b := by
    intro a b
    by_cases h : a = b
    · subst h; exact Reach.refl a
    · exact Reach.single h
  refine ⟨?_, ?_, ?_, ?_⟩
  · rintro i w ⟨_, he⟩
    have h1 := he false (linkReach false i)
    have h2 := he true (linkReach true i)
    rw [h1] at h2
    exact Bool.noConfusion h2
  · exact ⟨trivial, fun e hr => by simp only [id] at hr ⊢; exact (cutReach hr).symm⟩
  · exact ⟨trivial, fun e hr => by simp only [id] at hr ⊢; exact (cutReach hr).symm⟩
  · rintro w ⟨⟨_, h1⟩, ⟨_, h2⟩⟩
    have a := h1 false (Reach.refl _)
    have b := h2 true (Reach.refl _)
    rw [a] at b
    exact Bool.noConfusion b

end Reality

/-! ## 3. Links through time: breaking and repair -/

section Repair

variable {ι : Type v} (E : Nat → ι → ι → Prop)

/-- A correction route through time, from `a` at time `t` to `b` by time `t'`:
arrive, wait a step, or cross a link that is present now. -/
inductive TReach : ι → ι → Nat → Nat → Prop
  | here {a : ι} {t t' : Nat} : t ≤ t' → TReach a a t t'
  | wait {a b : ι} {t t' : Nat} : TReach a b (t + 1) t' → TReach a b t t'
  | hop {a c b : ι} {t t' : Nat} : E t a c → TReach c b (t + 1) t' → TReach a b t t'

/-- Links only ever break: none is ever made or repaired. -/
def OnlyBreak : Prop := ∀ t a b, E (t + 1) a b → E t a b

/-- Every link of the web `E0` is present again within `R` steps, from any
moment on: the second-order rule of repair (forgiveness). -/
def RepairWithin (E0 : ι → ι → Prop) (R : Nat) : Prop :=
  ∀ t a b, E0 a b → ∃ s, t ≤ s ∧ s ≤ t + R ∧ E s a b

variable {E}

theorem onlyBreak_mono (h : OnlyBreak E) {t : Nat} :
    ∀ k a b, E (t + k) a b → E t a b := by
  intro k
  induction k with
  | zero => intro a b hab; exact hab
  | succ k ih => intro a b hab; exact ih a b (h (t + k) a b hab)

theorem treach_to_reach (h : OnlyBreak E) {a b : ι} {t t' : Nat} (hr : TReach E a b t t') :
    ∀ t0, t0 ≤ t → Reach (E t0) a b := by
  induction hr with
  | here _ => intro t0 _; exact Reach.refl _
  | wait _ ih => intro t0 h0; exact ih t0 (by omega)
  | @hop a c b t _ e _ ih =>
      intro t0 h0
      have e0 : E t0 a c := by
        have := onlyBreak_mono h (t := t0) (t - t0) a c
        rw [show t0 + (t - t0) = t by omega] at this
        exact this e
      exact Reach.step e0 (ih t0 (by omega))

/-- **Without repair, a split is for ever.**  If links only break, and at time
`t0` there is no route from `a` to `b`, then no correction route through time
from `a` starting at `t0` ever reaches `b`. -/
theorem no_repair_split_permanent (h : OnlyBreak E) {a b : ι} {t0 : Nat}
    (hcut : ¬ Reach (E t0) a b) : ∀ t', ¬ TReach E a b t0 t' :=
  fun _ hr => hcut (treach_to_reach h hr t0 (Nat.le_refl _))

theorem treach_extend {a b : ι} {t t' : Nat} (hr : TReach E a b t t') :
    ∀ t'', t' ≤ t'' → TReach E a b t t'' := by
  induction hr with
  | here h => intro t'' h'; exact TReach.here (by omega)
  | wait _ ih => intro t'' h'; exact TReach.wait (ih t'' h')
  | hop e _ ih => intro t'' h'; exact TReach.hop e (ih t'' h')

theorem treach_wait_until {a b : ι} {s t' : Nat} (hr : TReach E a b s t') :
    ∀ k t, s = t + k → TReach E a b t t' := by
  intro k
  induction k with
  | zero => intro t hs; rw [hs] at hr; exact hr
  | succ k ih => intro t hs; exact TReach.wait (ih (t + 1) (by omega))

/-- **Repair bounds the delay.**  If every link of `E0` is repaired within `R`
steps, correction along a route of `m` links of `E0` arrives within
`m·(R + 1)` steps, from any starting time. -/
theorem repair_bounds_delay {E0 : ι → ι → Prop} {R : Nat} (hrep : RepairWithin E E0 R) :
    ∀ {a b : ι} {m : Nat}, ReachIn E0 a b m → ∀ t, TReach E a b t (t + m * (R + 1)) := by
  intro a b m h
  induction h with
  | refl a => intro t; exact TReach.here (by omega)
  | @step a c b m e _ ih =>
      intro t
      obtain ⟨s, hs1, hs2, hes⟩ := hrep t a c e
      have hrest := ih (s + 1)
      have hhop : TReach E a b s (s + 1 + m * (R + 1)) := TReach.hop hes hrest
      have hmul : (m + 1) * (R + 1) = m * (R + 1) + (R + 1) := by
        rw [Nat.add_mul, Nat.one_mul]
      have hext := treach_extend hhop (t + (m + 1) * (R + 1)) (by rw [hmul]; omega)
      exact treach_wait_until hext (s - t) t (by omega)

/-- **Forgiveness turns a split into a delay.**  In a strongly connected web
whose links are each repaired within `R` steps, every member's correction
reaches every member from any moment on. -/
theorem forgiveness_turns_split_into_delay {E0 : ι → ι → Prop} {R : Nat}
    (hsc : StronglyConnected E0) (hrep : RepairWithin E E0 R) (a b : ι) (t : Nat) :
    ∃ t', TReach E a b t t' := by
  obtain ⟨m, hm⟩ := reach_counted (hsc a b)
  exact ⟨_, repair_bounds_delay hrep hm t⟩

end Repair

/-! ## 4. Reflexivity: the metamodel is itself a narrative -/

section Reflexivity

variable {World : Type u}

/-- **Self-fulfilment is not verification.**  Suppose an observation holds in
every candidate world where people comply with a narrative.  Suppose also that
some candidate world has compliance while the narrative's claim is false.  Then,
after the observation, the rival "the claim is false" is still live. -/
theorem self_fulfilment_is_not_verification (C N comply obs : Content World)
    (hobs : ∀ w, C w → comply w → obs w)
    (hrival : ∃ w, C w ∧ comply w ∧ ¬ N w) :
    LiveClaim den (fun w => C w ∧ obs w) (fun w => ¬ N w) := by
  obtain ⟨w, hc, hcomp, hn⟩ := hrival
  exact ⟨w, ⟨hc, hobs w hc hcomp⟩, hn⟩

/-- **A narrative that seals itself falls under the learning law.**  If a
narrative's content `S` may never be revised, and it rules something out, then
under open change the models holding it are out of step in some possible
future. -/
theorem sealed_narrative_fails (Fut : Trajectory World → Prop) (hopen : OpenChange Fut)
    (rec : Nat → Content World) (S : Content World) (hseal : ∀ t w, rec t w → S w)
    (hinf : ∃ w, ¬ S w) : ∃ τ, Fut τ ∧ ∃ t, ¬ InStep rec τ t :=
  sealed_constraint_fails Fut hopen rec S hseal hinf

end Reflexivity

end Anchored.Persistence
