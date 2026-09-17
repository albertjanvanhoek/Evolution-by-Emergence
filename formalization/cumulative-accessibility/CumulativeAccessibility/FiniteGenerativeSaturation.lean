import CumulativeAccessibility.GenerativeClosure

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Finite generative saturation

This file isolates a finite-state boundary for retained cumulative change.
The result is deliberately combinatorial.

If a process evolves inside a fixed finite universe and never removes
previously retained states, then the total number of strict repertoire
expansions is bounded by the number of initially absent states. This bound does
not require a fixed generative rule and allows arbitrary idle periods between
expansions.

If, in addition, the process uses a fixed deterministic update rule, then once
two consecutive repertoire states are equal, all later states remain equal.
Thus fixed deterministic retained closure reaches a genuine fixed point.

The theorem does not assert that physical reality has a finite state space.
A finite `ambient` set should instead be read as a declared finite set of
states distinguishable at the chosen representation or resolution.
-/

section FiniteChain

variable {α : Type*} [DecidableEq α]

/-- Every strict inclusion in a finite repertoire increases cardinality. -/
theorem strict_finset_step_card_lt
    {A B : Finset α}
    (h : A ⊂ B) :
    A.card < B.card := by
  exact Finset.card_lt_card h

/-- A chain of `k` strict retained expansions gains at least `k` elements in
cardinality. -/
theorem strict_chain_card_growth
    (S : ℕ → Finset α) {k : ℕ}
    (hStrict : ∀ n, n < k → S n ⊂ S (n + 1)) :
    (S 0).card + k ≤ (S k).card := by
  induction k with
  | zero => simp
  | succ k ih =>
      have hPrev : ∀ n, n < k → S n ⊂ S (n + 1) := by
        intro n hn
        exact hStrict n (by omega)
      have hIH : (S 0).card + k ≤ (S k).card := ih hPrev
      have hLast : S k ⊂ S (k + 1) :=
        hStrict k (by omega)
      have hCard : (S k).card < (S (k + 1)).card :=
        strict_finset_step_card_lt hLast
      omega

/-- Inside a fixed finite universe, the length of any initial strict chain is
bounded by the number of states missing from the initial repertoire. -/
theorem strict_chain_length_le_remaining_capacity
    (ambient : Finset α)
    (S : ℕ → Finset α) {k : ℕ}
    (hBound : ∀ n, S n ⊆ ambient)
    (hStrict : ∀ n, n < k → S n ⊂ S (n + 1)) :
    k ≤ ambient.card - (S 0).card := by
  have hGrowth : (S 0).card + k ≤ (S k).card :=
    strict_chain_card_growth S hStrict
  have hEnd : (S k).card ≤ ambient.card :=
    Finset.card_le_card (hBound k)
  have h0 : (S 0).card ≤ ambient.card :=
    Finset.card_le_card (hBound 0)
  omega

/-- Number of strict retained expansions among the first `N` transitions.
Equal/idling steps contribute zero. -/
def strictExpansionCount
    (S : ℕ → Finset α) : ℕ → ℕ
  | 0 => 0
  | N + 1 =>
      strictExpansionCount S N +
        if S N ⊂ S (N + 1) then 1 else 0

/-- In any monotone retained process, repertoire cardinality has grown by at
least the number of strict expansion events observed so far. -/
theorem strictExpansionCount_card_growth
    (S : ℕ → Finset α)
    (hMono : ∀ n, S n ⊆ S (n + 1)) :
    ∀ N,
      (S 0).card + strictExpansionCount S N ≤ (S N).card := by
  intro N
  induction N with
  | zero => simp [strictExpansionCount]
  | succ N ih =>
      by_cases hStrict : S N ⊂ S (N + 1)
      · have hCard : (S N).card < (S (N + 1)).card :=
          strict_finset_step_card_lt hStrict
        rw [strictExpansionCount]
        simp [hStrict]
        omega
      · have hCard : (S N).card ≤ (S (N + 1)).card :=
          Finset.card_le_card (hMono N)
        rw [strictExpansionCount]
        simp [hStrict]
        omega

/-- Strong finite novelty bound. Even with arbitrary idle periods and even if
the update mechanism changes over time, a retained monotone repertoire inside
a fixed finite universe can undergo at most the initially absent number of
strict expansions. -/
theorem strictExpansionCount_le_remaining_capacity
    (ambient : Finset α)
    (S : ℕ → Finset α)
    (hBound : ∀ n, S n ⊆ ambient)
    (hMono : ∀ n, S n ⊆ S (n + 1))
    (N : ℕ) :
    strictExpansionCount S N
      ≤ ambient.card - (S 0).card := by
  have hGrowth := strictExpansionCount_card_growth S hMono N
  have hEnd : (S N).card ≤ ambient.card :=
    Finset.card_le_card (hBound N)
  have h0 : (S 0).card ≤ ambient.card :=
    Finset.card_le_card (hBound 0)
  omega

/-- A monotone sequence of retained repertoires inside a finite universe must
have a non-strict step no later than the initial remaining cardinal capacity.
This is a bound on the first uninterrupted run of strict steps; the stronger
`strictExpansionCount_le_remaining_capacity` above also handles later strict
steps separated by idle periods. -/
theorem exists_equal_step_within_remaining_capacity
    (ambient : Finset α)
    (S : ℕ → Finset α)
    (hBound : ∀ n, S n ⊆ ambient)
    (hMono : ∀ n, S n ⊆ S (n + 1)) :
    ∃ n,
      n ≤ ambient.card - (S 0).card ∧
      S n = S (n + 1) := by
  let K := ambient.card - (S 0).card
  by_contra hNone
  have hStrict : ∀ n, n < K + 1 → S n ⊂ S (n + 1) := by
    intro n hn
    have hnK : n ≤ K := by omega
    have hneq : S n ≠ S (n + 1) := by
      intro heq
      apply hNone
      exact ⟨n, hnK, heq⟩
    exact Finset.ssubset_iff_subset_ne.mpr ⟨hMono n, hneq⟩
  have hTooLong := strict_chain_length_le_remaining_capacity
    ambient S hBound hStrict
  dsimp [K] at hTooLong
  omega

end FiniteChain

section DeterministicFixation

variable {α : Type*} [DecidableEq α]

/-- For a deterministic recurrence, equality of two consecutive states is a
fixed point for the whole future trajectory. -/
theorem deterministic_equal_step_stays_equal
    (step : Finset α → Finset α)
    (S : ℕ → Finset α)
    (hRec : ∀ n, S (n + 1) = step (S n))
    {n : ℕ}
    (hEq : S n = S (n + 1)) :
    ∀ k, S (n + k) = S n := by
  intro k
  induction k with
  | zero => simp
  | succ k ih =>
      calc
        S (n + (k + 1)) = S ((n + k) + 1) := by congr 1 <;> omega
        _ = step (S (n + k)) := hRec (n + k)
        _ = step (S n) := by rw [ih]
        _ = S (n + 1) := (hRec n).symm
        _ = S n := hEq.symm

/-- General finite saturation theorem for a fixed retained update rule.

`step` may represent any deterministic retained generative closure. The only
properties used are:
* inflationarity: old retained states remain retained;
* boundedness: no state outside the declared finite universe is introduced.

Under those assumptions, the trajectory reaches a fixed repertoire within at
most `|ambient| - |S 0|` strict-expansion opportunities. -/
theorem finite_retained_process_saturates
    (ambient : Finset α)
    (step : Finset α → Finset α)
    (S : ℕ → Finset α)
    (hRec : ∀ n, S (n + 1) = step (S n))
    (hInitial : S 0 ⊆ ambient)
    (hInflationary : ∀ A, A ⊆ ambient → A ⊆ step A)
    (hClosed : ∀ A, A ⊆ ambient → step A ⊆ ambient) :
    ∃ n,
      n ≤ ambient.card - (S 0).card ∧
      ∀ k, S (n + k) = S n := by
  have hBound : ∀ n, S n ⊆ ambient := by
    intro n
    induction n with
    | zero => exact hInitial
    | succ n ih =>
        rw [hRec n]
        exact hClosed (S n) ih
  have hMono : ∀ n, S n ⊆ S (n + 1) := by
    intro n
    rw [hRec n]
    exact hInflationary (S n) (hBound n)
  obtain ⟨n, hn, hEq⟩ :=
    exists_equal_step_within_remaining_capacity ambient S hBound hMono
  exact ⟨n, hn, deterministic_equal_step_stays_equal step S hRec hEq⟩

/-- Corollary: under the same finite, retained, deterministic assumptions,
strict expansion at every generation is impossible. -/
theorem no_infinite_strict_expansion_in_finite_universe
    (ambient : Finset α)
    (step : Finset α → Finset α)
    (S : ℕ → Finset α)
    (hRec : ∀ n, S (n + 1) = step (S n))
    (hInitial : S 0 ⊆ ambient)
    (hInflationary : ∀ A, A ⊆ ambient → A ⊆ step A)
    (hClosed : ∀ A, A ⊆ ambient → step A ⊆ ambient) :
    ¬ (∀ n, S n ⊂ S (n + 1)) := by
  intro hStrictAll
  obtain ⟨n, hn, hFix⟩ := finite_retained_process_saturates
    ambient step S hRec hInitial hInflationary hClosed
  have hEq : S (n + 1) = S n := by
    simpa using hFix 1
  have hStrict := hStrictAll n
  exact hStrict.2 hEq.symm

end DeterministicFixation

section FiniteGenerativeClosure

variable {α : Type*} [Fintype α] [DecidableEq α]

/-- Finite-set implementation of one retained generative round. The candidate
universe is the whole finite type. -/
noncomputable def finiteGenerativeStep
    (Generate : HyperGenerator α)
    (A : Finset α) : Finset α := by
  classical
  exact Finset.univ.filter fun z =>
    z ∈ A ∨ GeneratedFromAvailable (fun x => x ∈ A) Generate z

/-- Membership in the finite implementation is exactly the predicate-level
retained generative closure introduced in `GenerativeClosure.lean`. -/
theorem mem_finiteGenerativeStep_iff
    (Generate : HyperGenerator α)
    (A : Finset α) (z : α) :
    z ∈ finiteGenerativeStep Generate A
      ↔
    GenerativeClosureStep (fun x => x ∈ A) Generate z := by
  classical
  simp [finiteGenerativeStep, GenerativeClosureStep]

/-- The finite generative step is inflationary: retained organization is never
removed. -/
theorem finiteGenerativeStep_inflationary
    (Generate : HyperGenerator α)
    (A : Finset α) :
    A ⊆ finiteGenerativeStep Generate A := by
  intro z hz
  rw [mem_finiteGenerativeStep_iff]
  exact Or.inl hz

/-- Iterated finite retained generative closure. -/
noncomputable def FiniteGenerativeClosureN
    (Generate : HyperGenerator α)
    (initial : Finset α) : ℕ → Finset α
  | 0 => initial
  | n + 1 => finiteGenerativeStep Generate
      (FiniteGenerativeClosureN Generate initial n)

/-- The finite retained generative trajectory obeys the fixed update rule by
definition. -/
theorem finiteGenerativeClosureN_succ
    (Generate : HyperGenerator α)
    (initial : Finset α) (n : ℕ) :
    FiniteGenerativeClosureN Generate initial (n + 1)
      = finiteGenerativeStep Generate
          (FiniteGenerativeClosureN Generate initial n) := by
  rfl

/-- Direct specialization: a fixed generative rule on a fixed finite universe,
with generated organization retained as future substrate, reaches a fixed
repertoire after at most the number of initially absent distinguishable
states. -/
theorem finite_generative_closure_saturates
    (Generate : HyperGenerator α)
    (initial : Finset α) :
    ∃ n,
      n ≤ Fintype.card α - initial.card ∧
      ∀ k,
        FiniteGenerativeClosureN Generate initial (n + k)
          = FiniteGenerativeClosureN Generate initial n := by
  have h := finite_retained_process_saturates
    (ambient := (Finset.univ : Finset α))
    (step := finiteGenerativeStep Generate)
    (S := FiniteGenerativeClosureN Generate initial)
    (hRec := finiteGenerativeClosureN_succ Generate initial)
    (hInitial := by simp)
    (hInflationary := by
      intro A hA
      exact finiteGenerativeStep_inflationary Generate A)
    (hClosed := by
      intro A hA
      exact Finset.subset_univ _)
  simpa using h

/-- Therefore a fixed finite retained generative closure cannot produce a
strictly larger distinguishable repertoire at every round forever. -/
theorem finite_generative_closure_not_strict_forever
    (Generate : HyperGenerator α)
    (initial : Finset α) :
    ¬ (∀ n,
      FiniteGenerativeClosureN Generate initial n
        ⊂ FiniteGenerativeClosureN Generate initial (n + 1)) := by
  apply no_infinite_strict_expansion_in_finite_universe
    (ambient := (Finset.univ : Finset α))
    (step := finiteGenerativeStep Generate)
    (S := FiniteGenerativeClosureN Generate initial)
  · exact finiteGenerativeClosureN_succ Generate initial
  · simp
  · intro A hA
    exact finiteGenerativeStep_inflationary Generate A
  · intro A hA
    exact Finset.subset_univ _

end FiniteGenerativeClosure

#print axioms strict_finset_step_card_lt
#print axioms strict_chain_card_growth
#print axioms strict_chain_length_le_remaining_capacity
#print axioms strictExpansionCount_card_growth
#print axioms strictExpansionCount_le_remaining_capacity
#print axioms exists_equal_step_within_remaining_capacity
#print axioms deterministic_equal_step_stays_equal
#print axioms finite_retained_process_saturates
#print axioms no_infinite_strict_expansion_in_finite_universe
#print axioms mem_finiteGenerativeStep_iff
#print axioms finiteGenerativeStep_inflationary
#print axioms finiteGenerativeClosureN_succ
#print axioms finite_generative_closure_saturates
#print axioms finite_generative_closure_not_strict_forever

end RecursiveAccessibility
end CumulativeAccessibility
