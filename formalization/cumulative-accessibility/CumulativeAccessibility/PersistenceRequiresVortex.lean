import CumulativeAccessibility.EndogenousBudgetBridge

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Persistence requires the vortex, but does not produce it

**Scope note.** The premise `ReadyFor` asks for readiness for every possible
kind of situation at once. The core does not assume this: finite budgets force
forgetting, and what persistence requires in a changing world is
reconfiguration from reliable feedback (`AdaptivePersistence`), not ever-growing
holdings. This file shows what that strong premise would demand. "Capture"
below means uptake from the gradient, not capture of a commons.

`DynamicVortex.lean` assumes that vortex turns keep recurring. This file asks
the converse question: what does persistence itself demand?

Setting:

* `Poss t` is the finite set of kinds of situation that may occur at time `t`.
  The world is **open-ended** when the number of kinds that may occur grows
  without bound (`OpenEndedPossibilities`).
* `R t` is the agent's retained repertoire: the kinds it can recognize and
  answer. Persisting in a world that can present any possible kind, without
  time to acquire a missing kind on the spot, requires being **ready** for every
  kind that may occur (`ReadyFor`). This readiness is the persistence premise
  of this file.
* Each retained kind costs at least `μ > 0` upkeep, paid from the vortex
  ledger's maintenance (`RepertoireUpkeepCovered`), and the agent stays
  internally viable: capture covers maintenance (`InternallyViableAt`).

Results:

* `open_world_forces_unbounded_repertoire`: in an open-ended world, readiness
  forces the repertoire to grow without bound. Persistence requires cumulative
  change; replacing old distinctions with new ones cannot keep up.
* `persistence_in_open_world_requires_unbounded_capture`: with positive upkeep
  per retained kind and viability at every time, capture from the gradient must
  exceed every bound. Either the organization keeps improving its capture or
  the gradient keeps growing: the vortex has to keep turning.
* `persistence_requires_vortex_witness`: all premises can hold at once.

What this file does **not** show: that the vortex will in fact keep turning.
The existing countermodels remain in force: one-shot innovation followed by
stasis, turnover without accumulation, saturation in a fixed finite space,
collapse below critical mass, and a non-viable whole that cannot afford any
response. Persistence requires the vortex; it does not produce it. What persists
in an open-ended world is what kept its vortex turning.
-/

section OpenWorld

variable {κ σ : Type*}

/-- The world is open-ended: the number of kinds of situation that may occur
grows without bound. -/
def OpenEndedPossibilities (Poss : ℕ → Finset κ) : Prop :=
  ∀ N : ℕ, ∃ t, N < (Poss t).card

/-- Readiness: at every time the retained repertoire covers every kind that may
occur. -/
def ReadyFor (Poss R : ℕ → Finset κ) : Prop :=
  ∀ t, Poss t ⊆ R t

/-- Each retained kind costs at least `μ` upkeep, and that upkeep is part of the
organization's maintenance demand. -/
def RepertoireUpkeepCovered (state : ℕ → σ) (maintenance : MaintenanceDemand σ)
    (R : ℕ → Finset κ) (μ : ℝ) : Prop :=
  ∀ t, μ * ((R t).card : ℝ) ≤ maintenance (state t)

/-- **An open-ended world forces an unbounded repertoire.** -/
theorem open_world_forces_unbounded_repertoire {Poss R : ℕ → Finset κ}
    (hOpen : OpenEndedPossibilities Poss) (hReady : ReadyFor Poss R) :
    ∀ N : ℕ, ∃ t, N < (R t).card := by
  intro N
  obtain ⟨t, ht⟩ := hOpen N
  exact ⟨t, lt_of_lt_of_le ht (Finset.card_le_card (hReady t))⟩

/-- **Persistence in an open-ended world requires unbounded capture.** If every
retained kind costs at least `μ > 0` and the organization stays viable at every
time, capture from the gradient exceeds every bound. -/
theorem persistence_in_open_world_requires_unbounded_capture
    {Poss R : ℕ → Finset κ} {state : ℕ → σ} {gradient : GradientStream}
    {uptake : UptakeFunction σ} {maintenance : MaintenanceDemand σ} {μ : ℝ}
    (hOpen : OpenEndedPossibilities Poss) (hReady : ReadyFor Poss R)
    (hμ : 0 < μ)
    (hUpkeep : RepertoireUpkeepCovered state maintenance R μ)
    (hViable : ∀ t, InternallyViableAt state gradient uptake maintenance t) :
    ∀ M : ℝ, ∃ t, M < uptake (state t) (gradient t) := by
  intro M
  obtain ⟨N, hN⟩ := Archimedean.arch M hμ
  rw [nsmul_eq_mul] at hN
  obtain ⟨t, ht⟩ := open_world_forces_unbounded_repertoire hOpen hReady N
  refine ⟨t, ?_⟩
  have hcard : (N : ℝ) < ((R t).card : ℝ) := by exact_mod_cast ht
  have hN' : M ≤ μ * (N : ℝ) := by
    rw [mul_comm]
    exact hN
  have hlt : μ * (N : ℝ) < μ * ((R t).card : ℝ) := mul_lt_mul_of_pos_left hcard hμ
  have hup := hUpkeep t
  have hvi := hViable t
  unfold InternallyViableAt at hvi
  linarith

end OpenWorld

/-- **Non-vacuity.** Kinds are natural numbers and `n + 1` kinds are possible at
time `n`. The agent retains exactly those, each costs one unit, maintenance is
`n + 1`, and capture keeps pace at `n + 1`. All premises hold, and capture
grows without bound. -/
theorem persistence_requires_vortex_witness :
    OpenEndedPossibilities (fun t : ℕ => Finset.range (t + 1)) ∧
      ReadyFor (fun t : ℕ => Finset.range (t + 1)) (fun t : ℕ => Finset.range (t + 1)) ∧
      RepertoireUpkeepCovered (fun t : ℕ => t) (fun s : ℕ => (s : ℝ) + 1)
        (fun t : ℕ => Finset.range (t + 1)) 1 ∧
      (∀ t, InternallyViableAt (fun t : ℕ => t) (fun _ => 0)
        (fun s _ => (s : ℝ) + 1) (fun s : ℕ => (s : ℝ) + 1) t) := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · intro N
    exact ⟨N, by simp [Finset.card_range]⟩
  · intro t
    exact Finset.Subset.refl _
  · intro t
    simp [Finset.card_range]
  · intro t
    unfold InternallyViableAt
    exact le_refl _

#print axioms open_world_forces_unbounded_repertoire
#print axioms persistence_in_open_world_requires_unbounded_capture
#print axioms persistence_requires_vortex_witness

end RecursiveAccessibility
end CumulativeAccessibility
