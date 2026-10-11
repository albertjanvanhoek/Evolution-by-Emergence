namespace CumulativeAccessibility
namespace ModelOfLargerReality

/-!
# What follows from being a model of a larger reality

Entry D20 of `DIALOGUE.md` records the author's derivation of conduct from
what a learning process is: a model is a compression of a reality larger than
itself; so it stands in a relation to what is outside it; what is outside it
includes its own substrate, because the compression sits in a substrate; so it
depends on the outside; and the rest follows, including forced free will.  In
the author's words: "het model is een compressie van een werkelijkheid buiten
zichzelf - dus is ereen relatie met dat wat buiten hetzelf is - per definitie
is dat wat buiten hetzelf is ook zijn eigen substraat".

This module states the steps of that chain in their simplest form.  A model is
a map `c : R → M` from states of reality to model states.

1. **Learning is making a distinction.**  A map that gives every reality the
   same state distinguishes nothing, and so has learned nothing
   (`nondistinguishing_iff_constant`).
2. **A larger reality makes the model fallible.**  Reality is larger than the
   model when two different realities get the same model state.  Then any way
   of reading a claim about reality off the model state is wrong somewhere
   (`larger_reality_forces_error`).  The model cannot settle the difference
   from inside (`inside_view_cannot_settle`); evidence from outside can
   (`outside_evidence_can_settle`).  So correctability is not an extra value: a
   compression needs correction from outside.
3. **The substrate is part of the outside.**  The model exists only while its
   substrate is intact, and the substrate is a condition of reality.  An action
   keeps the model in existence exactly when it keeps the substrate
   (`persists_iff_in_corridor`).  If the model is also lossy about its own
   substrate, it cannot certify its own continued existence from inside
   (`cannot_certify_own_substrate`).
4. **Forced free will.**  Every action can be chosen, but reality decides which
   choices keep the chooser.  Along any course of choices, the model has
   persisted up to a time exactly when every choice before it stayed in the
   corridor (`persisted_iff_corridor_throughout`).  The constraint comes from
   reality, not from the chooser's preferences: a chooser that discounts the
   future may leave the corridor, and then it does not persist.  In the
   author's words: "je keuzes uiteindelijk geconstrained zijn bij de
   werkelijkheid en de werkelijkheid is precies als het aankomt op het
   onderhouden van jezelf en je afhankelijkheden."  Models that share a
   substrate share that corridor: what ends one ends all
   (`shared_substrate_shared_corridor`).
   A separate and weaker question is when staying also pays the chooser.  A
   gain `k > 0` per step beats a one-off gain `G` that leaves the corridor over
   a horizon of `G + 1` steps (`long_horizon_favours_corridor`); over a short
   horizon, leaving can pay (`short_horizon_can_favour_leaving`).  The case with
   discounting is `CommonsDiscount`.
5. `model_of_larger_reality_witness`: concrete instances.

Scope.  These results are close to their definitions; they fix the shape of
the derivation, not its truth for any real system.  The modelling choices are
premises:
- that learning means making distinctions about reality;
- that "larger than the model" means two realities share a model state;
- that the model exists only while its substrate holds.

What the chain gives is conduct conditional on being a model and on the horizon:
- truth-tracking and correctability, which follow from being a lossy model;
- dependence on the outside, which follows from being embedded in it;
- that what persists has stayed in the corridor;
- that staying also pays the chooser, but only over a long enough horizon.

It does not say which substrate conditions matter, nor anything about values
beyond persistence (D7).
-/

/-- A model distinguishes some realities: not every reality gets the same
state. -/
def Distinguishes {R M : Type} (c : R → M) : Prop :=
  ∃ r₁ r₂, c r₁ ≠ c r₂

/-- **Learning is making a distinction.**  A model that distinguishes nothing
gives every reality the same state. -/
theorem nondistinguishing_iff_constant {R M : Type} (c : R → M) :
    ¬ Distinguishes c ↔ ∀ r₁ r₂, c r₁ = c r₂ := by
  unfold Distinguishes
  constructor
  · intro h r₁ r₂
    exact Classical.byContradiction (fun hne => h ⟨r₁, r₂, hne⟩)
  · intro h ⟨r₁, r₂, hne⟩
    exact hne (h r₁ r₂)

/-- Reality is larger than the model: two different realities get the same
model state. -/
def LargerThan {R M : Type} (c : R → M) : Prop :=
  ∃ r₁ r₂, r₁ ≠ r₂ ∧ c r₁ = c r₂

/-- **A larger reality makes the model fallible.**  Whatever claim about reality
is read off the model state, it is wrong in some reality. -/
theorem larger_reality_forces_error {R M : Type} (c : R → M) (h : LargerThan c)
    (read : M → R) : ∃ r, read (c r) ≠ r := by
  obtain ⟨r₁, r₂, hne, hc⟩ := h
  cases Classical.em (read (c r₁) = r₁) with
  | inl h1 =>
    refine ⟨r₂, ?_⟩
    rw [← hc, h1]
    exact hne
  | inr h1 => exact ⟨r₁, h1⟩

/-- Nothing computed from the model state alone can tell apart two realities
that share it. -/
theorem inside_view_cannot_settle {R M α : Type} (c : R → M) {r₁ r₂ : R}
    (hc : c r₁ = c r₂) (f : M → α) : f (c r₁) = f (c r₂) := by
  rw [hc]

/-- Evidence from outside the model can tell them apart: the model state
together with outside evidence that differs distinguishes the two realities. -/
theorem outside_evidence_can_settle {R M E : Type} (c : R → M) (e : R → E)
    {r₁ r₂ : R} (he : e r₁ ≠ e r₂) :
    (c r₁, e r₁) ≠ (c r₂, e r₂) := by
  intro h
  exact he (congrArg Prod.snd h)

/-- A model embedded in reality: its substrate is intact in some states of
reality, and actions change reality. -/
structure Embedded (R A : Type) where
  substrate : R → Prop
  act : A → R → R

/-- The model exists in a state of reality exactly when its substrate is intact
there. -/
def ExistsIn {R A : Type} (E : Embedded R A) (r : R) : Prop := E.substrate r

/-- The corridor: the actions after which the substrate is still intact. -/
def InCorridor {R A : Type} (E : Embedded R A) (r : R) (a : A) : Prop :=
  E.substrate (E.act a r)

/-- An action keeps the model in existence exactly when it stays inside the
corridor. -/
theorem persists_iff_in_corridor {R A : Type} (E : Embedded R A) (r : R) (a : A) :
    ExistsIn E (E.act a r) ↔ InCorridor E r a := Iff.rfl

/-- If the model is lossy about its own substrate (a reality where the substrate
holds and one where it fails get the same state), then any self-assessment
`safe` read off the model state is wrong in one of them: it either calls a
failing substrate safe, or an intact one unsafe. -/
theorem cannot_certify_own_substrate {R M A : Type} (E : Embedded R A) (c : R → M)
    {r₁ r₂ : R} (hc : c r₁ = c r₂) (h₁ : E.substrate r₁) (h₂ : ¬ E.substrate r₂)
    (safe : M → Prop) :
    (safe (c r₂) ∧ ¬ E.substrate r₂) ∨ (¬ safe (c r₁) ∧ E.substrate r₁) := by
  cases Classical.em (safe (c r₁)) with
  | inl hs =>
    left
    exact ⟨hc ▸ hs, h₂⟩
  | inr hs =>
    right
    exact ⟨hs, h₁⟩

/-- **Shared substrate, shared corridor.**  Two models on the same substrate,
in the same reality, have the same corridor: an action that ends one ends the
other. -/
theorem shared_substrate_shared_corridor {R A : Type} (E₁ E₂ : Embedded R A)
    (hs : ∀ r, E₁.substrate r ↔ E₂.substrate r) (ha : E₁.act = E₂.act)
    (r : R) (a : A) : InCorridor E₁ r a ↔ InCorridor E₂ r a := by
  unfold InCorridor
  rw [ha]
  exact hs _

/-- The course of reality under a sequence of choices, starting from `r₀`. -/
def course {R A : Type} (E : Embedded R A) (r₀ : R) (choice : Nat → A) : Nat → R
  | 0 => r₀
  | t + 1 => E.act (choice t) (course E r₀ choice t)

/-- The model has persisted up to time `n`: its substrate held at every time up
to `n`. -/
def PersistedUpTo {R A : Type} (E : Embedded R A) (r₀ : R) (choice : Nat → A)
    (n : Nat) : Prop :=
  ∀ t, t ≤ n → E.substrate (course E r₀ choice t)

/-- **Forced free will.**  Choices are free, but the model has persisted up to
time `n` exactly when its substrate held at the start and every choice before
`n` stayed in the corridor.  Reality enforces the corridor whatever the chooser
prefers. -/
theorem persisted_iff_corridor_throughout {R A : Type} (E : Embedded R A) (r₀ : R)
    (choice : Nat → A) (n : Nat) :
    PersistedUpTo E r₀ choice n ↔
      E.substrate r₀ ∧ ∀ t, t < n → InCorridor E (course E r₀ choice t) (choice t) := by
  constructor
  · intro h
    refine ⟨h 0 (Nat.zero_le _), ?_⟩
    intro t ht
    exact h (t + 1) (by omega)
  · intro ⟨h0, hc⟩ t ht
    cases t with
    | zero => exact h0
    | succ t => exact hc t (by omega)

/-- **Forced free will, with its condition.**  Staying in the corridor yields
`k` per step over a horizon of `n` steps, `n * k` in all; leaving yields `G`
once, after which the model no longer exists.  With any positive gain per step, a horizon of `G + 1` steps is long enough
for staying in the corridor to beat a one-off gain `G`. -/
theorem long_horizon_favours_corridor (k G : Nat) (hk : 0 < k) :
    G < (G + 1) * k := by
  have h : (G + 1) * 1 ≤ (G + 1) * k := Nat.mul_le_mul_left _ hk
  omega

/-- Over a short horizon, leaving can pay: if `n * k ≤ G`, the one-off gain is
at least what staying yields. -/
theorem short_horizon_can_favour_leaving (n k G : Nat) (h : n * k ≤ G) :
    ¬ G < n * k := by
  omega

/-- Concrete instances.  The identity on `Bool` distinguishes; the map to a
single state does not and is lossy, so every readout is wrong somewhere.  A gain
of 1 per step over 6 steps beats a one-off 5, and over 5 steps it does not. -/
theorem model_of_larger_reality_witness :
    Distinguishes (fun b : Bool => b) ∧
    ¬ Distinguishes (fun _ : Bool => ()) ∧
    LargerThan (fun _ : Bool => ()) ∧
    (∀ read : Unit → Bool, ∃ r, read ((fun _ : Bool => ()) r) ≠ r) ∧
    5 < 6 * 1 ∧ ¬ (5 < 5 * 1) := by
  refine ⟨⟨true, false, by decide⟩, ?_, ⟨true, false, by decide, rfl⟩, ?_, by decide, by decide⟩
  · exact (nondistinguishing_iff_constant _).mpr (fun _ _ => rfl)
  · intro read
    exact larger_reality_forces_error _ ⟨true, false, by decide, rfl⟩ read

end ModelOfLargerReality
end CumulativeAccessibility
