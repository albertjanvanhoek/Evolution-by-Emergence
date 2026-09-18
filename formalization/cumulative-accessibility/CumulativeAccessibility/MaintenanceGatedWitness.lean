import CumulativeAccessibility.MaintenanceOpportunityBridge

namespace CumulativeAccessibility
namespace RecursiveAccessibility

/-!
# Opportunity-gated witness and ablation stress test

`FormalCoreWitness.lean` proves that the premises of the v14 cross-stack theorem
are jointly satisfiable.  Its deliberately strong progressive witness realizes
novelty at every time step, so the opportunity hypothesis is not needed by that
particular witness.

This file tests the stronger causal reading suggested during adversarial review.
It defines one architecture family parameterized by an opportunity stream `O`:

* at time `n`, the generator can produce candidate `n+1` only if `O n` holds;
* the retained repertoire adds `n+1` only if `O n` holds;
* if `O n` does not hold, the repertoire is unchanged and the generator is
  disabled at that time.

Thus the response is not merely compatible with an opportunity stream: its
state transition is actually gated by that stream.  We then prove both sides of
the stress test:

1. the concrete strict three-cycle maintenance stream is recurrent, hence the
   gated architecture has open-ended cumulative retained novelty;
2. replacing the opportunity stream by `False` makes the same architecture
   family static, hence it is not open-ended.

This is a constructive dependency/ablation witness.  It is still a toy model:
it does not claim that maintenance physically causes innovation in empirical
systems.  It shows only that the formal interface can be inhabited by a model
in which novelty genuinely depends on the declared opportunity stream.
-/

/-- Retained repertoire with opportunity-gated updates.  State `0` is retained
initially. At transition `n -> n+1`, candidate `n+1` is added exactly when the
opportunity predicate holds at `n`; otherwise the repertoire is unchanged. -/
def opportunityGatedRepertoire
    (Opportunity : ℕ → Prop) [DecidablePred Opportunity] : ℕ → Finset ℕ
  | 0 => {0}
  | n + 1 =>
      if Opportunity n then
        insert (n + 1) (opportunityGatedRepertoire Opportunity n)
      else
        opportunityGatedRepertoire Opportunity n

/-- The corresponding generator is disabled when no opportunity is present.
When enabled at time `n`, retained seed state `0` generates candidate `n+1`. -/
def opportunityGatedGenerator
    (Opportunity : ℕ → Prop) (n : ℕ) : HyperGenerator ℕ :=
  fun parents z => Opportunity n ∧ parents = {0} ∧ z = n + 1

/-- The seed state is retained at every time. -/
theorem opportunityGatedRepertoire_zero_mem
    (Opportunity : ℕ → Prop) [DecidablePred Opportunity] :
    ∀ n, 0 ∈ opportunityGatedRepertoire Opportunity n := by
  intro n
  induction n with
  | zero =>
      simp [opportunityGatedRepertoire]
  | succ n ih =>
      by_cases h : Opportunity n
      · simp [opportunityGatedRepertoire, h, ih]
      · simp [opportunityGatedRepertoire, h, ih]

/-- Every item retained by time `n` is at most `n`; in particular, the next
candidate `n+1` has not already been retained. -/
theorem opportunityGatedRepertoire_mem_lt_succ
    (Opportunity : ℕ → Prop) [DecidablePred Opportunity] :
    ∀ n x, x ∈ opportunityGatedRepertoire Opportunity n → x < n + 1 := by
  intro n
  induction n with
  | zero =>
      intro x hx
      simp [opportunityGatedRepertoire] at hx
      omega
  | succ n ih =>
      intro x hx
      by_cases h : Opportunity n
      · simp [opportunityGatedRepertoire, h] at hx
        rcases hx with hx | hx
        · omega
        · have hlt := ih x hx
          omega
      · have hOld : x ∈ opportunityGatedRepertoire Opportunity n := by
          simpa [opportunityGatedRepertoire, h] using hx
        have hlt := ih x hOld
        omega

/-- Opportunity-gated retention is monotone. -/
theorem opportunityGatedRepertoire_retained
    (Opportunity : ℕ → Prop) [DecidablePred Opportunity] :
    ∀ n, opportunityGatedRepertoire Opportunity n ⊆
      opportunityGatedRepertoire Opportunity (n + 1) := by
  intro n x hx
  by_cases h : Opportunity n
  · simp [opportunityGatedRepertoire, h, hx]
  · simpa [opportunityGatedRepertoire, h] using hx

/-- The gated repertoire is represented inside the same moving envelope used by
the progressive witness. -/
theorem opportunityGatedRepertoire_represented
    (Opportunity : ℕ → Prop) [DecidablePred Opportunity] :
    ∀ n, opportunityGatedRepertoire Opportunity n ⊆ progressiveEnvelope n := by
  intro n x hx
  have hlt := opportunityGatedRepertoire_mem_lt_succ Opportunity n x hx
  simp [progressiveEnvelope]
  omega

/-- The next candidate is genuinely new before transition `n -> n+1`. -/
theorem opportunityGatedRepertoire_next_not_mem
    (Opportunity : ℕ → Prop) [DecidablePred Opportunity]
    (n : ℕ) :
    n + 1 ∉ opportunityGatedRepertoire Opportunity n := by
  intro hx
  have hlt := opportunityGatedRepertoire_mem_lt_succ Opportunity n (n + 1) hx
  omega

/-- If an opportunity occurs, the next candidate is inserted. -/
theorem opportunityGatedRepertoire_step_of_opportunity
    (Opportunity : ℕ → Prop) [DecidablePred Opportunity]
    (n : ℕ) (hOpportunity : Opportunity n) :
    opportunityGatedRepertoire Opportunity (n + 1) =
      insert (n + 1) (opportunityGatedRepertoire Opportunity n) := by
  simp [opportunityGatedRepertoire, hOpportunity]

/-- If no opportunity occurs, the retained repertoire does not change. -/
theorem opportunityGatedRepertoire_no_step_without_opportunity
    (Opportunity : ℕ → Prop) [DecidablePred Opportunity]
    (n : ℕ) (hOpportunity : ¬ Opportunity n) :
    opportunityGatedRepertoire Opportunity (n + 1) =
      opportunityGatedRepertoire Opportunity n := by
  simp [opportunityGatedRepertoire, hOpportunity]

/-- If no opportunity occurs, the generator is disabled. -/
theorem opportunityGatedGenerator_disabled_without_opportunity
    (Opportunity : ℕ → Prop)
    (n : ℕ) (hOpportunity : ¬ Opportunity n) :
    ∀ parents z, ¬ opportunityGatedGenerator Opportunity n parents z := by
  intro parents z hGen
  exact hOpportunity hGen.1

/-- Whenever an opportunity occurs, the gated architecture realizes a genuinely
new, generable, accepted and retained candidate. Unlike the original strong
progressive witness, the proof uses the opportunity hypothesis both to enable
the generator and to update the repertoire. -/
theorem opportunityGatedArchitecture_realizesValidatedAtOpportunity
    (Opportunity : ℕ → Prop) [DecidablePred Opportunity] :
    OpportunityConditionedValidatedRealization
      Opportunity
      progressiveEnvelope (opportunityGatedGenerator Opportunity)
      acceptAllCriterion (opportunityGatedRepertoire Opportunity) := by
  intro m hOpportunity
  refine ⟨m + 1, ?_, ?_, ?_, ?_, ?_⟩
  · simp [progressiveEnvelope]
  · exact opportunityGatedRepertoire_next_not_mem Opportunity m
  · refine ⟨{0}, ?_, ?_⟩
    · intro x hx
      have hx0 : x = 0 := by simpa using hx
      subst x
      exact opportunityGatedRepertoire_zero_mem Opportunity m
    · exact ⟨hOpportunity, rfl, rfl⟩
  · simp [acceptAllCriterion]
  · simp [opportunityGatedRepertoire, hOpportunity]

/-- Any recurrent opportunity stream drives open-ended cumulative novelty in the
opportunity-gated architecture. -/
theorem recurringOpportunity_drives_opportunityGatedNovelty
    (Opportunity : ℕ → Prop) [DecidablePred Opportunity]
    (hOpportunity : RecurringOpportunity Opportunity) :
    OpenEndedCumulativeNovelty (opportunityGatedRepertoire Opportunity) := by
  apply recurringOpportunity_and_validatedRealization_imply_openEndedNovelty
    Opportunity progressiveEnvelope (opportunityGatedGenerator Opportunity)
    acceptAllCriterion (opportunityGatedRepertoire Opportunity)
  · exact opportunityGatedRepertoire_retained Opportunity
  · exact hOpportunity
  · exact opportunityGatedArchitecture_realizesValidatedAtOpportunity Opportunity

section ResponseSeparations

/-- Even indexed times, used to separate recurrence from coincidence. -/
def evenOpportunity (n : ℕ) : Prop :=
  ∃ k : ℕ, n = 2 * k

/-- Odd indexed times, used to separate recurrence from coincidence. -/
def oddOpportunity (n : ℕ) : Prop :=
  ∃ k : ℕ, n = 2 * k + 1

noncomputable instance evenOpportunity_decidable : DecidablePred evenOpportunity := by
  classical
  exact inferInstance

noncomputable instance oddOpportunity_decidable : DecidablePred oddOpportunity := by
  classical
  exact inferInstance

/-- Even opportunities recur arbitrarily late. -/
theorem evenOpportunity_recurring : RecurringOpportunity evenOpportunity := by
  intro n
  refine ⟨2 * n, ?_, ?_⟩
  · omega
  · exact ⟨n, rfl⟩

/-- Odd opportunities recur arbitrarily late. -/
theorem oddOpportunity_recurring : RecurringOpportunity oddOpportunity := by
  intro n
  refine ⟨2 * n + 1, ?_, ?_⟩
  · omega
  · exact ⟨n, rfl⟩

/-- No time is both even and odd. -/
theorem evenOpportunity_disjoint_odd
    {n : ℕ}
    (hEven : evenOpportunity n)
    (hOdd : oddOpportunity n) :
    False := by
  rcases hEven with ⟨j, hj⟩
  rcases hOdd with ⟨k, hk⟩
  omega

/-- W does not imply V.  Take opportunity to be present at every time, while
the architecture itself is gated only at even times.  Successful opportunity
events recur arbitrarily late, but an odd opportunity need not succeed. -/
theorem recurringValidatedResponse_without_successAtEveryOpportunity :
    RecurringValidatedResponse
        alwaysOpportunity
        progressiveEnvelope
        (opportunityGatedGenerator evenOpportunity)
        acceptAllCriterion
        (opportunityGatedRepertoire evenOpportunity)
      ∧
    ¬ OpportunityConditionedValidatedRealization
        alwaysOpportunity
        progressiveEnvelope
        (opportunityGatedGenerator evenOpportunity)
        acceptAllCriterion
        (opportunityGatedRepertoire evenOpportunity) := by
  constructor
  · intro n
    obtain ⟨m, hnm, hEven⟩ := evenOpportunity_recurring n
    refine ⟨m, hnm, ?_, ?_⟩
    · simp [alwaysOpportunity]
    · exact
        opportunityGatedArchitecture_realizesValidatedAtOpportunity
          evenOpportunity m hEven
  · intro hEvery
    have hAlways : alwaysOpportunity 1 := by simp [alwaysOpportunity]
    have hSuccess := hEvery 1 hAlways
    obtain ⟨z, hzU, hzNot, hGenerated, hEval, hzNext⟩ := hSuccess
    obtain ⟨parents, hParents, hGen⟩ := hGenerated
    have hNotEven : ¬ evenOpportunity 1 := by
      intro hEven
      rcases hEven with ⟨k, hk⟩
      omega
    exact hNotEven hGen.1

/-- Q and G do not imply W.  Opportunities recur at even times, while the
architecture realizes validated uptake only at odd times.  Each stream recurs
arbitrarily late, but opportunity and success never coincide. -/
theorem recurringOpportunity_and_uptake_without_recurringCoincidence :
    RecurringOpportunity evenOpportunity
      ∧
    ValidatedGenerativeCapacityUptake
      progressiveEnvelope
      (opportunityGatedGenerator oddOpportunity)
      acceptAllCriterion
      (opportunityGatedRepertoire oddOpportunity)
      ∧
    ¬ RecurringValidatedResponse
      evenOpportunity
      progressiveEnvelope
      (opportunityGatedGenerator oddOpportunity)
      acceptAllCriterion
      (opportunityGatedRepertoire oddOpportunity) := by
  have hOddResponse :
      RecurringValidatedResponse
        oddOpportunity
        progressiveEnvelope
        (opportunityGatedGenerator oddOpportunity)
        acceptAllCriterion
        (opportunityGatedRepertoire oddOpportunity) :=
    recurringOpportunity_and_validatedRealization_imply_recurringValidatedResponse
      oddOpportunity
      progressiveEnvelope
      (opportunityGatedGenerator oddOpportunity)
      acceptAllCriterion
      (opportunityGatedRepertoire oddOpportunity)
      oddOpportunity_recurring
      (opportunityGatedArchitecture_realizesValidatedAtOpportunity oddOpportunity)
  refine ⟨evenOpportunity_recurring, ?_, ?_⟩
  · exact recurringValidatedResponse_implies_validatedUptake
      oddOpportunity
      progressiveEnvelope
      (opportunityGatedGenerator oddOpportunity)
      acceptAllCriterion
      (opportunityGatedRepertoire oddOpportunity)
      hOddResponse
  · intro hCoincide
    obtain ⟨m, hnm, hEven, hSuccess⟩ := hCoincide 0
    obtain ⟨z, hzU, hzNot, hGenerated, hEval, hzNext⟩ := hSuccess
    obtain ⟨parents, hParents, hGen⟩ := hGenerated
    exact evenOpportunity_disjoint_odd hEven hGen.1

end ResponseSeparations

/-- Concrete strict three-cycle maintenance opportunity stream used in the
causal witness. -/
def concreteStrictMaintenanceOpportunity : ℕ → Prop :=
  cycle3MaintenanceOpportunity
    (1 / 2 : ℝ) (1 / 2 : ℝ) (1 / 2 : ℝ) 1 1 1

/-- The concrete maintenance predicate is classically decidable.  This instance
is used only to define the finite gated repertoire; it adds no mathematical
assumption to the maintenance theorem. -/
noncomputable instance concreteStrictMaintenanceOpportunity_decidable :
    DecidablePred concreteStrictMaintenanceOpportunity := by
  classical
  exact inferInstance

/-- The concrete strict three-cycle supplies recurrent opportunities. -/
theorem concreteStrictMaintenanceOpportunity_recurring :
    RecurringOpportunity concreteStrictMaintenanceOpportunity := by
  unfold concreteStrictMaintenanceOpportunity
  apply strictCycle3Maintenance_supplies_recurringOpportunity
  · norm_num
  · norm_num
  · norm_num
  · norm_num [CollectiveAlignment.maintenanceDeficit]
  · norm_num [CollectiveAlignment.maintenanceDeficit]
  · norm_num [CollectiveAlignment.maintenanceDeficit]
  · norm_num
  · norm_num
  · norm_num
  · norm_num [CollectiveAlignment.maintenanceDeficit]

/-- Stronger end-to-end witness: novelty is produced by the same generic
architecture whose updates are actually gated by the concrete maintenance
opportunity stream. -/
theorem concreteMaintenanceGatedNoveltyWitness :
    OpenEndedCumulativeNovelty
      (opportunityGatedRepertoire concreteStrictMaintenanceOpportunity) := by
  exact recurringOpportunity_drives_opportunityGatedNovelty
    concreteStrictMaintenanceOpportunity
    concreteStrictMaintenanceOpportunity_recurring

/-- No-opportunity ablation used as the counterfactual control. -/
def noOpportunity (_n : ℕ) : Prop := False

/-- The no-opportunity predicate has a direct constructive decidability
instance. -/
instance noOpportunity_decidable : DecidablePred noOpportunity :=
  fun _ => isFalse (by simp [noOpportunity])

/-- With the opportunity stream removed, the same architecture family stays at
its initial repertoire forever. -/
theorem noOpportunity_gatedRepertoire_static :
    ∀ n, opportunityGatedRepertoire noOpportunity n = {0} := by
  intro n
  induction n with
  | zero =>
      simp [opportunityGatedRepertoire]
  | succ n ih =>
      simp [opportunityGatedRepertoire, noOpportunity, ih]

/-- Opportunity ablation extinguishes cumulative novelty in the same gated
architecture family. -/
theorem noOpportunity_gatedArchitecture_not_openEnded :
    ¬ OpenEndedCumulativeNovelty
      (opportunityGatedRepertoire noOpportunity) := by
  have hEq : opportunityGatedRepertoire noOpportunity = staticRepertoire := by
    funext n
    simpa [staticRepertoire] using noOpportunity_gatedRepertoire_static n
  rw [hEq]
  exact unboundedCapacity_without_openEndedNovelty.2

/-- Local ablation statement: without an opportunity at a time step, neither
the state transition nor the generator can create the next novelty event. -/
theorem noOpportunity_disables_response :
    (∀ n, opportunityGatedRepertoire noOpportunity (n + 1) =
      opportunityGatedRepertoire noOpportunity n) ∧
    (∀ n parents z, ¬ opportunityGatedGenerator noOpportunity n parents z) := by
  constructor
  · intro n
    exact opportunityGatedRepertoire_no_step_without_opportunity
      noOpportunity n (by simp [noOpportunity])
  · intro n parents z
    exact opportunityGatedGenerator_disabled_without_opportunity
      noOpportunity n (by simp [noOpportunity]) parents z

#print axioms opportunityGatedArchitecture_realizesValidatedAtOpportunity
#print axioms evenOpportunity_recurring
#print axioms oddOpportunity_recurring
#print axioms recurringValidatedResponse_without_successAtEveryOpportunity
#print axioms recurringOpportunity_and_uptake_without_recurringCoincidence
#print axioms recurringOpportunity_drives_opportunityGatedNovelty
#print axioms concreteStrictMaintenanceOpportunity_recurring
#print axioms concreteMaintenanceGatedNoveltyWitness
#print axioms noOpportunity_gatedArchitecture_not_openEnded
#print axioms noOpportunity_disables_response

end RecursiveAccessibility
end CumulativeAccessibility
