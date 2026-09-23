import AnchoredEvolution.Dynamics
import AnchoredEvolution.CumulativeReproduction

/-!
# Layer 5: the correction network is itself retained organization

Correction routes are retained structure, so they pay upkeep from the same
ledger as everything else in the Cumulative Reproduction Model.

* Every model must maintain at least one outgoing route (Layer 2).  If each
  maintained route costs at least `μ`, the upkeep of keeping `n` models
  mutually correctable is at least `n * μ`.
* The ring attains this bound: one route per model.
* The budget-balance law of the reproduction model therefore applies to
  correctability itself.  With net-cost correction (`η < μ`), at most
  `B0 / (μ - η)` models can remain mutually correctable.  When correction pays
  for itself (`μ ≤ η`), there is no ceiling.
-/

universe u

namespace Anchored

open CumulativeReproduction

theorem length_mul_le_sum {β : Type u} (l : List β) (f : β → Nat) (μ : Nat)
    (h : ∀ a, a ∈ l → μ ≤ f a) : l.length * μ ≤ (l.map f).sum := by
  induction l with
  | nil => simp
  | cons x xs ih =>
      have hx := h x (List.mem_cons_self ..)
      have hxs := ih (fun a ha => h a (List.mem_cons_of_mem x ha))
      simp only [List.length_cons, List.map_cons, List.sum_cons, Nat.succ_mul]
      omega

variable {α : Type u} {Edge : α → α → Prop}

/-- **Lower bound on the upkeep of correctability.**  In a correctable system,
every model with a peer maintains an outgoing route.  If maintaining a route
costs a model at least `μ`, then keeping the listed models mutually correctable
costs at least `length * μ`. -/
theorem correction_upkeep_lower_bound (hsc : StronglyConnected Edge)
    (models : List α) (upkeep : α → Nat) (μ : Nat)
    (hpeer : ∀ a, a ∈ models → ∃ b, b ≠ a)
    (hcost : ∀ a, (∃ c, Edge a c) → μ ≤ upkeep a) :
    models.length * μ ≤ (models.map upkeep).sum := by
  apply length_mul_le_sum
  intro a ha
  obtain ⟨b, hba⟩ := hpeer a ha
  exact hcost a (sc_every_model_sends hsc (Ne.symm hba))

/-- **Correctable population ceiling.**  Suppose `n` models are kept mutually
correctable, route upkeep is paid from the reproduction-model ledger
`(B0, η, μ)`, and each model pays at least `μ`.  Then `n` is affordable in that
ledger.  With `η < μ`, this gives `n ≤ B0 / (μ - η)`. -/
theorem correctable_population_ceiling (hsc : StronglyConnected Edge)
    (models : List α) (upkeep : α → Nat) (ℓ : Ledger)
    (hpeer : ∀ a, a ∈ models → ∃ b, b ≠ a)
    (hcost : ∀ a, (∃ c, Edge a c) → ℓ.mu ≤ upkeep a)
    (hbudget : (models.map upkeep).sum ≤ ℓ.B0 + ℓ.eta * models.length)
    (hnet : ℓ.eta < ℓ.mu) :
    models.length ≤ ℓ.cap := by
  have hlow := correction_upkeep_lower_bound hsc models upkeep ℓ.mu hpeer hcost
  apply le_cap_of_affordable ℓ hnet
  unfold Ledger.Affordable
  rw [Nat.mul_comm]
  omega

/-- **The bound is attained.**  A ring of `n + 1` models, each paying exactly
`μ` for its single route, is affordable exactly when the ledger admits `n + 1`
retained items. -/
theorem ring_affordable_iff (n : Nat) (ℓ : Ledger) :
    (n + 1) * ℓ.mu ≤ ℓ.B0 + ℓ.eta * (n + 1) ↔ ℓ.Affordable (n + 1) := by
  unfold Ledger.Affordable
  rw [Nat.mul_comm (n + 1) ℓ.mu]

/-- **Self-financing correction has no ceiling.**  If correction returns at
least its upkeep (`μ ≤ η`), every community size is affordable. -/
theorem self_financing_correction_unbounded (ℓ : Ledger) (h : ℓ.mu ≤ ℓ.eta) :
    ∀ n, ℓ.Affordable n :=
  self_financing_never_binds ℓ h

end Anchored
