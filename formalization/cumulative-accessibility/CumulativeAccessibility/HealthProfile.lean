namespace CumulativeAccessibility
namespace HealthProfile

/-!
# Why a health profile comes before a single score

A profile rates a system on several domains (for the health of intelligence:
grounding, learning and retention, correction, resources, robustness; see
`research/health-of-intelligence/HEALTH_OF_INTELLIGENCE.md`).  The ratings are
ordinal levels: their order means something, their spacing does not.  This
module records, in the simplest form, why the concept note reports the
profile first and treats any single score as a hypothesis to be tested.

Results:
* `stage_product_zero_iff`: a product of stage scores is zero exactly when some
  stage is zero.  This is the bottleneck: where success needs every stage of
  one chain (detect, transmit, revise, retain), any stage at zero stops it, as
  the vortex's speed does in step 5 of `CORE.md`.
* `sum_compensates_failed_stage`: a sum lets a high score elsewhere hide a
  failed stage, so a sum and a product can rank two profiles in opposite
  orders.
* `relabelling_reverses_sum`, `relabelling_reverses_product`: relabelling the
  levels by an order-preserving map (squaring, or shifting the scale by one)
  can reverse the order of two profiles under a sum, and under a product.  So
  neither ranking is a property of ordinal levels; it is a property of the
  numbers chosen for them.
* `dominance_survives_relabelling`: one profile at least as good as another on
  every domain stays so under every order-preserving relabelling.

Not covered: interval or ratio scales, where sums or products can be
meaningful, and which aggregate predicts outcomes best, which is an empirical
question.  These results are close to arithmetic; they fix why the concept note
reports a profile first.
-/

/-- The product of stage scores. -/
def stageProduct : List Nat → Nat
  | [] => 1
  | x :: xs => x * stageProduct xs

/-- The sum of stage scores. -/
def stageSum : List Nat → Nat
  | [] => 0
  | x :: xs => x + stageSum xs

/-- **The bottleneck.**  A product of stage scores is zero exactly when some
stage is zero. -/
theorem stage_product_zero_iff (l : List Nat) : stageProduct l = 0 ↔ 0 ∈ l := by
  induction l with
  | nil => simp [stageProduct]
  | cons x xs ih =>
    simp only [stageProduct, Nat.mul_eq_zero, ih, List.mem_cons]
    constructor
    · rintro (h | h)
      · exact Or.inl h.symm
      · exact Or.inr h
    · rintro (h | h)
      · exact Or.inl h.symm
      · exact Or.inr h

/-- **A sum hides a failed stage.**  A profile with one stage at zero can have
the larger sum and the smaller product. -/
theorem sum_compensates_failed_stage :
    stageSum [3, 3] < stageSum [0, 9] ∧ stageProduct [0, 9] < stageProduct [3, 3] := by
  decide

/-- **Relabelling reverses a sum.**  Squaring the levels keeps their order but
reverses the order of the two sums. -/
theorem relabelling_reverses_sum :
    stageSum [0, 3] < stageSum [2, 2] ∧
      stageSum ([0, 3].map (fun x => x * x)) > stageSum ([2, 2].map (fun x => x * x)) := by
  decide

/-- **Relabelling reverses a product.**  Shifting the levels up by one keeps
their order but reverses the order of the two products. -/
theorem relabelling_reverses_product :
    stageProduct [0, 5] < stageProduct [1, 1] ∧
      stageProduct ([0, 5].map (· + 1)) > stageProduct ([1, 1].map (· + 1)) := by
  decide

/-- **Dominance survives relabelling.**  A profile at least as good on every
domain stays so under any order-preserving relabelling of the levels. -/
theorem dominance_survives_relabelling {k : Nat} {a b : Fin k → Nat} {f : Nat → Nat}
    (hf : ∀ x y, x ≤ y → f x ≤ f y) (hab : ∀ i, a i ≤ b i) :
    ∀ i, f (a i) ≤ f (b i) :=
  fun i => hf _ _ (hab i)

end HealthProfile
end CumulativeAccessibility
