namespace CumulativeAccessibility
namespace CooperativeCorrection

/-!
# Cooperative error identification between different world models

Entry D35 of `DIALOGUE.md` and `research/cooperative-correction/` state three
conjectures, kept separate: (1) intelligences with incompatible world models can
identify errors without adopting a common worldview; (2) intelligences without
an initially shared standard of evidence can sometimes build a local one through
interaction; (3) under identifiable conditions such cooperation produces better
models than the intelligences would develop alone.  This module is the smallest
formal model that separates the first two, and it separates logical
implications from behavioural assumptions.  The third conjecture is studied by
simulation, not here.

Setting.  `W` is a type of possible worlds, `Op` a type of operations that can
be performed (measurements, experiments, procedures), and `O` a type of
outcomes.  An agent has
* a **support** `support : W → Prop`, the worlds it keeps possible, and
* its **own model of the operations** `predict : Op → W → O`: what it expects
  each operation to yield in each world.

Two agents may differ in both.  In particular, they need not agree on what an
outcome *means*: their `predict` maps can disagree at every world.

What is shared is an **operational compatibility assumption**: both agents use
the same types of worlds, operations and outcomes, and identify exactly which
operation was performed.  This is much less than a shared interpretation, but it
is not nothing, and how two agents with different vocabularies would reach it is
not modelled here.

The key move.  A shared standard of evidence is usually pictured as a shared
interpretation of observations.  This module uses something thinner:
* a **shared record**: both agents accept *which outcome occurred* when an
  operation was performed, without agreeing on what it shows;
* **commitment**: each agent states in advance which outcomes its model allows;
  that set is not empty and excludes something (`Committed`).

An operation whose committed outcome sets are disjoint **discriminates** the two
agents (`Discriminates`).  An available shared operation that discriminates is
an `AvailableBridge`.  What the module shows is **bridge discovery among available
operations**: the consequences of having such an operation, judged by public
material, committed predictions and a shared record.  It does not model how a
new operation, or a shared vocabulary for one, is constructed.

Results.  Logical layer:
1. `discrimination_exposes_one`: whatever outcome a discriminating operation
   gives, at least one agent's model does not accommodate it.
2. `exposure_does_not_say_who`: the same discriminating operation can expose
   either agent, depending on the outcome; the logic alone does not say which.
3. `failure_is_support_or_mechanism`: if an agent's model does not accommodate
   the recorded outcome, then either its support excludes the actual world or
   its model of that operation is wrong about the actual world.  Which of the
   two is not determined (a miniature of the Duhem–Quine problem).
4. `faithful_agent_accommodates`: an agent whose support keeps the actual world
   and whose operation model is right about it accommodates the outcome.
5. `uncommitted_agent_is_never_exposed`: an agent that allows every outcome is
   never exposed by any record, and no operation discriminates it from anyone
   who allows some outcome.  At the other extreme, an agent with an empty support
   allows nothing and so discriminates trivially from everyone
   (`empty_support_discriminates_trivially`); it is not committed
   (`empty_support_is_not_committed`), which is why commitment requires a
   nonempty allowed set.
6. `bridge_needs_no_shared_interpretation` (in the witness): two agents whose
   operation models disagree at every world can still be discriminated by an
   operation.
7. `disputed_record_hides_exposure` (in the witness): if the agents record
   different outcomes, a discriminating operation can leave both accommodated,
   each by its own record.  A shared record is needed.
8. `bridges_grow_with_shared_operations`: for fixed agent models, every
   operation that discriminates within a set of shared operations still does
   within a larger set.  After an agent revises, earlier bridges need not remain.

Behavioural layer, separately:
9. `Responsive` says only that an agent *changes* its model after an exposure.
   `responsive_agent_revises` restates it, and the witness gives an agent that is
   exposed and does not change: exposure does not imply revision.
10. `Corrective` is stronger: after an exposure, the new model allows what was
   recorded.  Even that does not mean improvement: an agent can always meet it
   by becoming vague, allowing every outcome
   (`accommodation_can_be_bought_by_vagueness`), and the vague model is then no
   longer committed (`vague_revision_gives_up_commitment`).  A genuinely
   improving revision needs a condition on what is kept as well as on what is
   accommodated, which is not formalized here.

Scope.  The results are close to their definitions.  They show which
ingredients each conjecture needs, not that real agents have them.  Not
modelled: noise in records, partial commitment, the cost of performing
operations, and which agent should revise.
-/

/-- An agent: the worlds it keeps possible, and its own model of what each
operation yields in each world. -/
structure Agent (W Op O : Type) where
  support : W → Prop
  predict : Op → W → O

variable {W Op O : Type}

/-- The agent's model allows outcome `o` of operation `op`. -/
def Allows (A : Agent W Op O) (op : Op) (o : O) : Prop :=
  ∃ w, A.support w ∧ A.predict op w = o

/-- The agent has committed on `op`: its model allows at least one outcome and
rules out at least one. -/
def Committed (A : Agent W Op O) (op : Op) : Prop :=
  (∃ o, Allows A op o) ∧ ∃ o, ¬ Allows A op o

/-- The operation discriminates the two agents: no outcome is allowed by both. -/
def Discriminates (A B : Agent W Op O) (op : Op) : Prop :=
  ∀ o, ¬ (Allows A op o ∧ Allows B op o)

/-- An available bridge: a shared operation that discriminates the two agents.
Being available is not the same as having been performed or recorded. -/
def AvailableBridge (A B : Agent W Op O) (shared : Op → Prop) (op : Op) : Prop :=
  shared op ∧ Discriminates A B op

/-- Behavioural: an agent is responsive on `op` if, whenever its model does not
allow the recorded outcome, its next model differs from its current one. -/
def Responsive (A A' : Agent W Op O) (op : Op) (recorded : O) : Prop :=
  ¬ Allows A op recorded → A' ≠ A

/-- Behavioural, stronger: after an exposure, the next model allows what was
recorded. -/
def Corrective (A A' : Agent W Op O) (op : Op) (recorded : O) : Prop :=
  ¬ Allows A op recorded → Allows A' op recorded

/-- **A discriminating operation exposes at least one agent.**  Whatever the
recorded outcome, at least one of the two models does not allow it. -/
theorem discrimination_exposes_one {A B : Agent W Op O} {op : Op}
    (h : Discriminates A B op) (o : O) : ¬ Allows A op o ∨ ¬ Allows B op o := by
  apply Classical.byContradiction
  intro hn
  apply h o
  exact ⟨Classical.byContradiction fun ha => hn (Or.inl ha),
    Classical.byContradiction fun hb => hn (Or.inr hb)⟩

/-- **Exposure does not say who.**  If each agent allows some outcome, a
discriminating operation exposes `B` when the outcome is one `A` allows, and
`A` when it is one `B` allows. -/
theorem exposure_does_not_say_who {A B : Agent W Op O} {op : Op} {oA oB : O}
    (h : Discriminates A B op) (hA : Allows A op oA) (hB : Allows B op oB) :
    ¬ Allows B op oA ∧ ¬ Allows A op oB :=
  ⟨fun hb => h oA ⟨hA, hb⟩, fun ha => h oB ⟨ha, hB⟩⟩

/-- **A failure is in the support or in the operation model.**  If the model
does not allow the outcome the operation actually gives in the actual world `a`,
then either the support excludes `a` or the model is wrong about the operation
in `a`. -/
theorem failure_is_support_or_mechanism {A : Agent W Op O} {op : Op} {a : W}
    {out : O} (hout : ¬ Allows A op out) :
    ¬ A.support a ∨ A.predict op a ≠ out := by
  apply Classical.byContradiction
  intro hn
  apply hout
  refine ⟨a, Classical.byContradiction fun hs => hn (Or.inl hs), ?_⟩
  exact Classical.byContradiction fun hp => hn (Or.inr hp)

/-- **A faithful agent accommodates the outcome.** -/
theorem faithful_agent_accommodates {A : Agent W Op O} {op : Op} {a : W} {out : O}
    (hs : A.support a) (hp : A.predict op a = out) : Allows A op out :=
  ⟨a, hs, hp⟩

/-- **An uncommitted agent is never exposed.**  If the agent allows every
outcome, no record exposes it, and no operation discriminates it from an agent
that allows some outcome. -/
theorem uncommitted_agent_is_never_exposed {A B : Agent W Op O} {op : Op}
    (hall : ∀ o, Allows A op o) :
    (∀ o, Allows A op o) ∧ ((∃ o, Allows B op o) → ¬ Discriminates A B op) := by
  refine ⟨hall, ?_⟩
  rintro ⟨o, hb⟩ hd
  exact hd o ⟨hall o, hb⟩

/-- **A discriminating operation has two committed agents**, as soon as each
allows some outcome. -/
theorem discrimination_requires_commitment {A B : Agent W Op O} {op : Op} {oA oB : O}
    (h : Discriminates A B op) (hA : Allows A op oA) (hB : Allows B op oB) :
    Committed A op ∧ Committed B op :=
  ⟨⟨⟨oA, hA⟩, oB, (exposure_does_not_say_who h hA hB).2⟩,
    ⟨⟨oB, hB⟩, oA, (exposure_does_not_say_who h hA hB).1⟩⟩

/-- **The degenerate case.**  An agent with an empty support allows no outcome,
so every operation discriminates it from every other agent. -/
theorem empty_support_discriminates_trivially {A B : Agent W Op O} (op : Op)
    (hA : ∀ w, ¬ A.support w) : Discriminates A B op :=
  fun _ h => by
    obtain ⟨w, hw, _⟩ := h.1
    exact hA w hw

/-- **An agent with an empty support is not committed.** -/
theorem empty_support_is_not_committed {A : Agent W Op O} (op : Op)
    (hA : ∀ w, ¬ A.support w) : ¬ Committed A op := by
  rintro ⟨⟨o, w, hw, _⟩, _⟩
  exact hA w hw

/-- **Bridges accumulate.**  A bridge within a set of shared operations is still
a bridge within any larger set. -/
theorem bridges_grow_with_shared_operations {A B : Agent W Op O}
    {shared shared' : Op → Prop} (hsub : ∀ op, shared op → shared' op) (op : Op)
    (h : AvailableBridge A B shared op) : AvailableBridge A B shared' op :=
  ⟨hsub op h.1, h.2⟩

/-- **Behavioural: a responsive agent revises after an exposure.**  This
restates the assumption; it is not derived from the logical layer. -/
theorem responsive_agent_revises {A A' : Agent W Op O} {op : Op} {recorded : O}
    (hr : Responsive A A' op recorded) (hexp : ¬ Allows A op recorded) : A' ≠ A :=
  hr hexp

/-- **Accommodation can be bought by vagueness.**  A next model that allows
every outcome meets the corrective condition, whatever was recorded. -/
theorem accommodation_can_be_bought_by_vagueness {A A' : Agent W Op O} {op : Op}
    (recorded : O) (hall : ∀ o, Allows A' op o) : Corrective A A' op recorded :=
  fun _ => hall recorded

/-- **A vague revision gives up commitment.** -/
theorem vague_revision_gives_up_commitment {A' : Agent W Op O} {op : Op}
    (hall : ∀ o, Allows A' op o) : ¬ Committed A' op :=
  fun ⟨_, o, ho⟩ => ho (hall o)

/-- Two worlds, `false` and `true`; one operation; outcomes are `Nat`.
* Agent `A` keeps only world `false`; its model says the operation yields `0` in
  `false` and `1` in `true`.  Agent `B` keeps only world `true`; its model of
  the operation is different at both worlds: `2` in `false`, `3` in `true`.
  Their models disagree at every world, yet the operation discriminates them
  (`bridge_needs_no_shared_interpretation`).
* If `A` records `0` and `B` records `3`, each is accommodated by its own record:
  a disputed record hides the exposure (`disputed_record_hides_exposure`).
* With the shared record `3`, `A` is exposed and `B` is not.
* Exposure without revision: `A` exposed, and its next model equal to `A`, is
  consistent; responsiveness is an extra assumption. -/
theorem cooperative_correction_witness :
    let A : Agent Bool Unit Nat := ⟨fun w => w = false, fun _ w => if w then 1 else 0⟩
    let B : Agent Bool Unit Nat := ⟨fun w => w = true, fun _ w => if w then 3 else 2⟩
    -- bridge_needs_no_shared_interpretation
    (∀ w, A.predict () w ≠ B.predict () w) ∧ Discriminates A B () ∧
    -- disputed_record_hides_exposure
    (Allows A () 0 ∧ Allows B () 3) ∧
    -- with the shared record 3, A is exposed and B is not
    (¬ Allows A () 3 ∧ Allows B () 3) ∧
    -- exposure does not imply revision
    (¬ Allows A () 3 ∧ A = A) := by
  intro A B
  refine ⟨?_, ?_, ⟨?_, ?_⟩, ⟨?_, ?_⟩, ⟨?_, rfl⟩⟩
  · intro w; cases w <;> decide
  · rintro o ⟨⟨wa, hwa, hpa⟩, ⟨wb, hwb, hpb⟩⟩
    have ha : wa = false := hwa
    have hb : wb = true := hwb
    subst ha; subst hb
    have h0 : o = 0 := hpa.symm
    have h3 : o = 3 := hpb.symm
    rw [h0] at h3
    exact absurd h3 (by decide)
  · exact ⟨false, rfl, rfl⟩
  · exact ⟨true, rfl, rfl⟩
  · rintro ⟨w, hw, hp⟩
    have : w = false := hw
    subst this
    exact absurd hp (by decide)
  · exact ⟨true, rfl, rfl⟩
  · rintro ⟨w, hw, hp⟩
    have : w = false := hw
    subst this
    exact absurd hp (by decide)

/-- An uncommitted agent exists: `C` keeps every natural number possible and
predicts the world itself, so it allows every outcome.  By
`uncommitted_agent_is_never_exposed`, no record exposes it and no operation
discriminates it from an agent over the same worlds that allows some outcome. -/
theorem uncommitted_witness :
    let A : Agent Bool Unit Nat := ⟨fun w => w = false, fun _ w => if w then 1 else 0⟩
    let C : Agent Nat Unit Nat := ⟨fun _ => True, fun _ w => w⟩
    (∀ o, Allows C () o) ∧ Allows A () 0 := by
  intro A C
  exact ⟨fun o => ⟨o, trivial, rfl⟩, ⟨false, rfl, rfl⟩⟩

end CooperativeCorrection
end CumulativeAccessibility
