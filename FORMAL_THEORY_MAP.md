# Evolution by Emergence — Formal Theory Map

## Claim-to-Lean traceability for the current theory

This file connects the candidate formal theory in **[THEORY_CORE_V17.md](THEORY_CORE_V17.md)**, and the broader synthesis in **[THEORY.md](THEORY.md)**, to the exact formal objects that support them.

It is not a claim that every sentence in the theory is machine proved.

The repository uses five evidence labels:

- **MC — machine checked:** the stated implication is proved in Lean under the
  displayed model assumptions.
- **CW — concrete witness:** Lean exhibits an explicit model satisfying the
  relevant premise set.
- **EXT — external mathematics:** the repository relies on established results
  but does not re-prove the general theorem.
- **MODEL — modelling interface:** a mapping that must be supplied or justified
  by an application.
- **INT — interpretation/research programme:** conceptual extension, not a
  theorem.

The central rule is:

> **Machine checking establishes implication under assumptions. It does not
> establish universality, empirical adequacy, or novelty.**

---

## MASTER — v17 canonical recursive-organization surface

**Theory statement.** The canonical v17 surface no longer uses a globally finite
`Capacity` type as the master open-ended universe. It exposes two distinct
cumulative endpoints and two optional strengthening layers.

### Operational accumulation

The corrected operational certificate uses finite moving local envelopes:

```text
seed recursive-emergence event
+ monotone active retention
+ local finite-envelope representation
+ event-wise locally certified effective successor reproduction
    -> OpenEndedCumulativeNovelty Active
    -> UnboundedEnvelopeCapacity U.
```

The ambient `Capacity` type need not be finite.

### Promotion-driven strengthening

A stronger sufficient route replaces abstract local criticality with:

```text
operational primitive promotion
+ essential downstream generated-access contribution
+ finite admission
+ promotion-responsive envelope
+ full next-event filtering
    -> actual local successor
    -> local critical reproduction.
```

This is still a sufficient-condition architecture: promotion alone does not
derive continuation.

### Constructive strengthening

`ConstructiveRecursiveEmergenceStepAt` can additionally require the parent set
to construct the **same configuration** that witnesses the child capacity's
compositional emergence and filtered retention. The constructive event projects
to the generic capacity-level recursive event.

### Historical accumulation

The weaker historical endpoint separates current operational availability from
cumulative trace:

```text
Active_t
History_t.
```

Recurring history-new recursive events plus monotone `History` imply
`OpenEndedCumulativeNovelty History` without monotone `Active`. A checked
turnover witness keeps the active repertoire at cardinality one forever while
history expands.

**Formal status:** MC for all displayed implications; CW for operational and
historical non-vacuity witnesses; MODEL for application-specific construction,
admission, validation, resource, and calibration interfaces.

**Canonical Lean source**

- `EvolutionByEmergenceV17Core.lean`

**Supporting Lean sources**

- `LocalEmergenceReproduction.lean`
- `EndogenousEnvelopePromotion.lean`
- `ConstructiveRecursiveEmergence.lean`
- `ActiveHistory.lean`
- `FiniteGenerativeSaturation.lean`
- `OpenEndedCapacity.lean`

**Canonical declarations**

- `EvolutionByEmergenceV17OperationalCertificate`
- `evolutionByEmergenceV17_operational_openEnded`
- `evolutionByEmergenceV17_operational_unboundedEnvelope`
- `PromotionDrivenEvolutionByEmergenceV17Certificate`
- `evolutionByEmergenceV17_promotionDriven_openEnded`
- `evolutionByEmergenceV17_promotionDriven_unboundedEnvelope`
- `evolutionByEmergenceV17_constructiveEvent_projects`
- `HistoricalEvolutionByEmergenceV17Certificate`
- `evolutionByEmergenceV17_historical_openEnded`
- `evolutionByEmergenceV17_historical_turnover_witness`
- `evolutionByEmergenceV17_fixedFiniteOperationalCriticality_impossible`

### Status of the earlier finite master certificate

`EvolutionByEmergenceCore.lean` is retained for compatibility, finite
specialization, calibration/separation results, and historical traceability.
Its `[Fintype Capacity]` `EvolutionByEmergenceCoreCertificate` is **not** the
canonical open-ended v17 certificate. `LocalEmergenceReproduction.lean` proves
`evolutionByEmergenceCoreCertificate_impossible`: under the indefinite seed,
retention, and uniform criticality premises, the globally finite specialization
conflicts with finite retained-repertoire saturation.

That correction is part of the theory's evidence, not something to hide.

---

## T1 — recurrent interactions can maintain organization

**Theory statement.** Individually subcritical processes can jointly sustain a
positive recurrent maintenance structure when closed-loop support covers the
declared deficits.

**Formal status:** MC for finite dyad and three-cycle constructions; EXT for a
general Perron/next-generation-matrix theorem.

**Lean sources**

- \`formalization/collective-alignment/MaintenanceReproduction.lean\`
- \`formalization/collective-alignment/MaintenanceDynamics.lean\`

**Selected declarations**

- \`dyad_canonical_threshold_iff\`
- \`dyad_canonical_witness_positive\`
- \`cycle3_canonical_threshold_iff\`
- \`cycle3_canonical_witness_positive\`
- \`cycle3_strict_threshold_gives_growth_witness\`
- \`deleting_return_edge_makes_source_decline\`
- \`cycle3StateStep_preserves_canonical_lower_bound\`
- \`cycle3Trajectory_stays_above_canonical\`
- \`cycle3Trajectory_supported_by_canonical\`
- \`cycle3Trajectory_has_positive_support_floor\`
- \`cycle3_strict_loop_has_arbitrarily_late_availability\`

**Exact finite-cycle boundary**

\[
k_{AB}k_{BC}k_{CA}
\ge
(1-r_A)(1-r_B)(1-r_C).
\]

**Not proved.** The repository does not machine-check the full arbitrary-network
spectral-radius theorem \(\rho((I-R)^{-1}K)>1\).

---

## T2 — viability is a resource balance

**Theory statement.** Organization-dependent captured throughput minus
maintenance demand defines internally available slack.

**Formal status:** MC inside the declared ledger.

**Lean source**

\`formalization/cumulative-accessibility/CumulativeAccessibility/EndogenousBudgetBridge.lean\`

**Selected declarations**

- \`internallyViableAt_iff_internalSlack_nonneg\`
- \`endogenousResponseBudget_nonneg\`
- \`organization_improvement_increases_internalSlack\`
- \`uptake_improvement_increases_internalSlack\`
- \`maintenance_efficiency_increases_internalSlack\`
- \`organization_improvement_increases_endogenousResponseBudget\`

**Definitions**

\[
L_t=\mathcal U(s_t,G_t)-\mathcal M(s_t),
\]

\[
B_t^{\rm resp}=\beta_tL_t.
\]

**Not proved.** That a given empirical system is correctly represented by the
chosen uptake and maintenance functions.

---

## T3 — increased slack can open a response window

**Theory statement.** A strict increase in usable response budget opens a
nonempty interval of candidate costs that were unaffordable before and
affordable afterward.

**Formal status:** MC + CW.

**Lean sources**

- \`EndogenousBudgetBridge.lean\`
- \`EndogenousBudgetWitness.lean\`

**Selected declarations**

- \`resourceFeasibleAt_mono_budget\`
- \`responseBudget_increase_opens_cost_window\`
- \`resourceFeasibility_switches_across_budget_window\`
- \`gradient_uptake_improvement_opens_response_feasibility\`
- \`gradientRobot_baseline_slack\`
- \`gradientRobot_improved_slack\`

**Concrete witness**

\[
G=10,\quad
\mathcal M=6,\quad
\mathcal U:10\to11,
\]

so

\[
L:4\to5,
\]

and a response cost \(9/2\) crosses the feasibility boundary.

---

## T3A — self-maintenance leverage: slack, buffer, and future access

**Theory statement.** In a declared resource-solvency ledger, higher internal
slack has a double role: with positive reinvestment it raises response budget,
and the same extra margin increases the energetic burden the organization can
absorb while remaining solvent. If future target costs are also non-worsening,
the slack-funded feasible target family cannot shrink; an explicit crossing
witness makes it strictly expand.

**Formal status:** MC + CW.

**Lean source**

- \`SelfMaintenanceLeverage.lean\`

**Selected declarations**

- \`slack_improvement_preserves_energetic_tolerance\`
- \`strict_slack_improvement_opens_energetic_buffer\`
- \`strict_slack_gain_is_budget_and_buffer_gain\`
- \`selfMaintenanceLeverage_preserves_slackFundedAccess\`
- \`selfMaintenanceLeverage_strictly_expands_with_witness\`
- \`slack_and_cost_leverage_open_target\`
- \`lifetimeAdaptiveBudget_mono\`
- \`lifetimeAdaptiveBudget_strict_of_slack_gain\`
- \`leverageToy_strict_access_expansion\`
- \`leverageToy_budget_and_buffer_gain\`

**Logical core**

For state-local slack

\[
L(s)=\mathcal U(s,g)-\mathcal M(s),
\]

positive reinvestment \(\beta>0\), and

\[
L(s_0)<L(s_1),
\]

the checked ledger gives both

\[
\beta L(s_0)<\beta L(s_1)
\]

and a nonempty interval of additional energetic burdens tolerated at \(s_1\)
but not at \(s_0\).

If additionally no declared future target becomes more costly, every target
affordable from old slack remains affordable from new slack.

**Boundary.** This is not a theorem that all forms of robustness increase with
energetic efficiency. The stability result is explicitly restricted to the
same resource-solvency ledger. Generation, validation, and retention remain
separate.

---

## T4 — opportunity and success are distinct

**Theory statement.** Recurring opportunities do not by themselves imply
successful novelty. Successful response can occur after a bounded delay.

**Formal status:** MC + converse-style separation witnesses.

**Lean sources**

- \`MaintenanceOpportunityBridge.lean\`
- \`ResponseDynamics.lean\`
- \`BoundedResponseWitness.lean\`

**Selected declarations**

- \`persistentSupport_and_connection_imply_recurringOpportunity\`
- \`resourceValidatedSuccessAt_implies_validatedSuccessAt\`
- \`recurringValidatedResponseWithin_zero_iff\`
- \`recurringValidatedResponseWithin_mono\`
- \`recurringValidatedResponseWithin_implies_validatedUptake\`
- \`recurringOpportunity_and_resourceResponseWithin_imply_recurringResponseWithin\`
- \`recurringOpportunity_and_resourceResponseWithin_imply_validatedUptake\`
- \`unitDelayedResponse_without_sameTimeCoincidence\`
- \`unitDelayedResponse_without_zeroDelay\`
- \`validatedSuccess_without_declaredResourceFeasibility\`
- \`resourceFeasibility_without_validatedSuccess\`

**Logical direction**

\[
Q+B_\Delta\Rightarrow D_\Delta\Rightarrow G.
\]

The same-time predicate is the \(\Delta=0\) special case.

---

## T5 — retained products become later parent material

**Theory statement.** Retained generated organization can become reusable
substrate for later generation.

**Formal status:** MC + CW.

**Lean source**

\`formalization/cumulative-accessibility/CumulativeAccessibility/GenerativeClosure.lean\`

**Selected declaration**

- \`retained_intermediate_creates_second_round_access\`

The minimal witness has:

\[
a\to b,\qquad b\to c,
\]

while \(c\) is unavailable after one retained generative round and available
after two.

This is the formal retained-history stepping-stone result.

---

## T5A — local recursive-emergence reproduction is sufficient for recurrence

**Theory statement.** Global recurrence need not be assumed directly. One seed
recursive-emergence event plus a local rule guaranteeing that every realized
event has a later successor that reuses its child as parent is sufficient for
arbitrarily late recursive-emergence events. With monotone retention, this
implies open-ended cumulative novelty.

**Formal status:** MC + progressive non-vacuity witness.

**Lean source**

- \`SelfMaintenanceLeverage.lean\`

**Selected declarations**

- \`RecursiveEmergenceSuccessorWithin\`
- \`recursiveEmergenceSuccessorWithin_iterates\`
- \`seed_and_successorWithin_imply_recurringRecursiveEmergence\`
- \`seed_and_successorWithin_imply_openEndedNovelty\`
- \`progressive_has_recursiveEmergenceSuccessorWithin_zero\`
- \`progressive_openEnded_via_local_chainReaction\`

**Logical direction**

\[
\text{seed}
+
\bigl(\text{every recursive event has a later child-reusing successor}\bigr)
\Rightarrow
\text{recurrent recursive emergence}
\Rightarrow
\text{open-ended retained novelty}.
\]

**Boundary.** Slack gain and cheaper future access do not by themselves prove
the successor rule. The rule still contains generation, external validation,
and retention. Closing that empirical/mechanistic seam is the next research
problem.

---

## T5B — emergence reproduction number and criticality

**Theory statement.** In a finite declared capacity universe, the deterministic
effective emergence reproduction number \(R_E\) is the actual number of
distinct immediate recursive-emergence successors of one retained child.

\[
R_E=0
\]

means no immediate effective successor,

\[
R_E\ge 1
\]

is exactly the continuation threshold, and

\[
R_E>1
\]

guarantees at least two distinct immediate successor branches.

**Formal status:** MC for the deterministic finite-capacity specialization;
MODEL/EXT for stochastic and arbitrary-type next-generation interpretations.

**Lean source**

- \`EmergenceReproduction.lean\`

**Selected declarations**

- \`ImmediateRecursiveEmergenceSuccessors\`
- \`EffectiveEmergenceSuccessorCount\`
- \`EffectiveEmergenceReproductionNumber\`
- \`one_le_effectiveEmergenceSuccessorCount_iff_exists\`
- \`one_le_effectiveEmergenceReproductionNumber_iff_exists\`
- \`supercritical_effectiveEmergenceReproduction_has_two_successors\`
- \`UniformCriticalEmergenceReproduction\`
- \`uniformCriticalEmergenceReproduction_implies_successorWithin_zero\`
- \`seed_and_uniformCriticalEmergenceReproduction_imply_openEndedNovelty\`

The mechanism ledger is kept separate:

\[
R_E^{\rm ledger}
=
\tau\lambda p_Gp_Rp_Vp_T,
\]

where \(\tau\) is a declared persistence/search window, \(\lambda\) is
opportunity rate, and the \(p\)'s are conditional generation, resource,
validation, and retention fractions.

The ledger is not identified with the actual successor count. A separate
\`ReproductionLedgerCertifiedLowerBound\` seam is required before
\(R_E^{\rm ledger}\ge1\) can certify an actual deterministic successor.

**Boundary.** In a stochastic branching interpretation, an expected
reproduction number greater than one does not imply deterministic continuation.
The corresponding positive-survival-probability theorem requires explicit
branching/independence or conditional-law assumptions and is not yet
machine-checked here. The general multitype spectral-radius threshold is
classical external next-generation-operator mathematics rather than a new EbE
claim.

---

## T5C — local emergence reproduction closes the recursive theory without a finite global vocabulary

**Theory statement.** The finite-capacity successor count in T5B is a valid
finite specialization, but it cannot be the global state space of an
open-ended retained process. With a fixed finite global capacity type, one
seed, monotone retention, and uniform critical reproduction are jointly
impossible over an unbounded horizon.

The corrected reproduction object counts actual effective successors only
inside the finite next-step candidate envelope \(U_{t+1}\):

\[
R_E^{\mathrm{local}}(t,\phi)
=
\#\{\psi\in U_{t+1}:
\phi\to\psi
\text{ completes a recursive-emergence step}\}.
\]

The underlying capacity type need not be finite. Each local envelope is finite,
while the sequence of envelopes may have unbounded cardinality.

**Formal status:** MC + explicit non-vacuity witness.

**Lean source**

- `LocalEmergenceReproduction.lean`

**Selected declarations**

- `finiteCapacity_uniformCriticalEmergenceReproduction_impossible`
- `LocalEffectiveEmergenceReproductionNumber`
- `one_le_localEffectiveEmergenceReproductionNumber_iff_exists`
- `UniformLocalCriticalEmergenceReproduction`
- `seed_and_uniformLocalCriticalEmergenceReproduction_imply_openEndedNovelty`
- `seed_and_uniformLocalCriticalEmergenceReproduction_imply_unboundedEnvelope`
- `uniformlyBoundedEnvelope_rules_out_uniformLocalCriticalEmergenceReproduction`
- `evolutionByEmergenceCoreCertificate_impossible`
- `LocalEvolutionByEmergenceCoreCertificate`
- `evolutionByEmergenceLocalCore_openEnded`
- `evolutionByEmergenceLocalCore_unboundedEnvelope`
- `progressiveLocalEvolutionByEmergenceCoreCertificate`

**Logical direction**

\[
\text{seed}
+
\text{uniform local }R_E\ge 1
+
\text{retention}
\Rightarrow
\text{open-ended retained novelty}.
\]

If retained organization is represented inside the moving envelope,

\[
S_t\subseteq U_t,
\]

then

\[
\text{open-ended retained novelty}
\Rightarrow
\sup_t |U_t|=\infty.
\]

Conversely, a uniform finite bound on \(|U_t|\) rules out sustained uniform
local critical reproduction under the same seed, retention, and representation
premises.

**Boundary.** This does not prove that an empirical system has
\(R_E^{\mathrm{local}}\ge1\). The mechanism ledger still requires an
application-specific calibration to actual effective successors. What is
closed here is the logical recursive architecture once that calibration is
supplied.


---

## T5D — primitive promotion can endogenize movement of the local envelope

**Theory statement.** A recursive-emergence child may already be represented in
the current candidate envelope before realization, so realizing the child is
not itself envelope expansion. The causal change is operational: retention
promotes the child from unavailable candidate to reusable parent material.

If the promoted child is essential for a downstream candidate relative to the
next retained repertoire, and that candidate was not generable from the
pre-promotion retained repertoire under the same next-step generator,
and a finite promotion-admission policy selects it for local representation,
then a responsive envelope places that downstream capacity in the next local
envelope. If it also passes emergence, resource, validation, and retention
filtering, it becomes an actual local
\(R_E\) successor.

**Formal status:** MC for the implication architecture and progressive witness;
MODEL for the envelope-response policy and for the empirical frequency of
generatively consequential promotions.

**Lean source**

- \`EndogenousEnvelopePromotion.lean\`

**Selected declarations**

- \`recursiveEmergenceStep_is_operationalPromotion\`
- \`GenerativelyConsequentialPromotionAt\`
- \`PromotionResponsiveEnvelope\`
- \`promotionResponsiveEnvelope_exposes_new_entry\`
- \`promotion_new_entry_strictly_expands_monotone_envelope\`
- \`PromotionDrivenFilteredSuccessorAt\`
- \`promotionDrivenFilteredSuccessor_implies_local_successor\`
- \`UniformPromotionDrivenContinuation\`
- \`uniformPromotionDrivenContinuation_implies_uniformLocalCritical\`
- \`seed_and_uniformPromotionDrivenContinuation_imply_openEndedNovelty\`
- \`seed_and_uniformPromotionDrivenContinuation_imply_unboundedEnvelope\`
- \`oneShot_promotion_has_no_generativelyConsequential_downstream\`
- \`progressive_openEnded_via_endogenousEnvelopePromotion\`

**Causal decomposition**

\[
\boxed{
\begin{aligned}
\text{recursive-emergence event}
&\to \text{operational primitive promotion}\\
&\to \text{new downstream generability}\\
&\to \text{representation in }U_{t+1}\\
&\to \text{filtered retained successor}\\
&\to R_E^{\rm local}\ge 1.
\end{aligned}}
\]

The generativity comparison intentionally holds the next-step generator fixed.
It also checks that the promoted primitive is essential relative to the full
next-step repertoire:

\[
\neg\operatorname{Generated}(S_{t+1}\setminus\{\phi\},H_{t+1},\psi),
\]

while

\[
\operatorname{GeneratedUsingParent}(S_{t+1},H_{t+1},\phi,\psi).
\]

In addition,

\[
\neg\operatorname{Generated}(S_t,H_{t+1},\psi).
\]

Together these conditions isolate the effect of the promoted parent from both
simultaneous generator-rule change and other contemporaneous repertoire
additions.

**Boundary.** Primitive promotion is not sufficient by itself. A checked
one-shot counterexample has a valid retained emergence event but no
generatively consequential downstream candidate because the next-step
generator is empty. A finite envelope is also not required to represent every
possibility opened by a promoted primitive: `PromotionAdmissionPolicy` is an
explicit application-specific compression/attention seam selecting which
possibilities become local candidates. Admitted generated candidates still
need not pass the later feasibility/validation/retention filters.

This layer therefore explains one endogenous source of moving-envelope change
without claiming that every emergence event expands the search horizon.

---

## T5E — generated configuration can be the emergent configuration

**Theory statement.** Capacity-level generation and configuration-level
emergence need not remain merely conjoined. Under the stronger construction
interface, the parent set constructs a specific configuration for a specific
child, and that same configuration is required to witness the child's
compositional emergence and filtered retention.

**Formal status:** MC + CW.

**Lean source**

- `ConstructiveRecursiveEmergence.lean`

**Selected declarations**

- `ConfigurationConstructionRule`
- `ConstructiveRecursiveEmergenceStepAt`
- `constructiveRecursiveEmergenceStep_same_configuration`
- `constructiveRecursiveEmergenceStep_implies_recursiveEmergenceStep`
- `recursiveToy_a_to_b_is_constructiveRecursiveEmergenceStep`
- `recursiveToy_b_to_c_is_constructiveRecursiveEmergenceStep`

**Boundary.** The stronger construction relation is not derived for every
capacity-level generator. Applications that cannot identify the constructed
configuration should use the weaker recursive event rather than assume the
stronger bridge.

---

## T5F — active repertoire and cumulative history are distinct

**Theory statement.** Open-ended historical accumulation does not require
monotone growth of the currently operational repertoire.

With separate `Active_t` and cumulative `History_t`, recurring recursive events
whose children are genuinely new to history imply open-ended cumulative history
when history is monotone. Parent reuse still requires current activity.

**Formal status:** MC + explicit turnover CW/SEP.

**Lean source**

- `ActiveHistory.lean`

**Selected declarations**

- `ActiveHistoryConsistent`
- `HistoricalRecursiveEmergenceStepAt`
- `RecurringHistoricalRecursiveEmergence`
- `recurringHistoricalRecursiveEmergence_implies_openEndedHistory`
- `activeHistoryArchitecture_recursion_implies_openEndedHistory`
- `openEndedHistory_with_bounded_turnover_active`

The concrete witness establishes:

```text
OpenEndedCumulativeNovelty History
AND |Active_t| = 1 for every t
AND Active is not monotone.
```

**Boundary.** Historical trace is not operational availability. A capacity that
is only in history cannot serve as current parent material unless a separate
reactivation/recovery mechanism makes it active again.

---

## T5G — v17 has operational and historical master endpoints

**Theory statement.** The v17 canonical surface deliberately does not force one
notion of cumulative organization onto every domain.

- `evolutionByEmergenceV17_operational_openEnded` is the stronger endpoint for
  monotonically accumulated operational capability;
- `evolutionByEmergenceV17_historical_openEnded` is the weaker endpoint for
  cumulative historical trace under active turnover;
- promotion-driven and constructive certificates are stronger sufficient
  interfaces feeding the operational architecture, not alternative definitions
  of emergence.

**Formal status:** MC.

**Lean source**

- `EvolutionByEmergenceV17Core.lean`

---

## T6 — retained organization can change the future generator

**Theory statement.** Evolvability can change through retained parent material
or through the generative rule itself.

**Formal status:** MC.

**Lean sources**

- \`ModuleGeneratedEvolvability.lean\`
- \`GeneratorRuleEvolution.lean\`
- \`EvolvabilityStructure.lean\`
- \`GenerativeArity.lean\`

**Selected declarations**

- \`module_retention_implies_evolvabilityLe\`
- \`new_parent_set_implies_evolvabilityLt\`
- \`new_parent_set_implies_secondOrderClick\`
- \`retained_module_diversity_expands_generator\`
- \`retained_module_diversity_derives_secondOrderClick\`
- \`new_rule_event_implies_GeneratorRuleLt\`
- \`generatorRuleLt_implies_evolvabilityLt\`
- \`generatorRuleLt_implies_secondOrderClick\`
- \`fixed_repertoire_rule_expansion\`

**Interpretation.** The process can change not only its state but the way future
candidates are produced.

---

## T7 — second-order accessibility

**Theory statement.** A viable organizational transition can strictly expand
the declared future search operator.

**Formal status:** MC + separation witnesses.

**Lean source**

\`RecursiveAccessibility.lean\`

**Core object**

- \`SecondOrderClick\`

**Selected declarations**

- \`secondOrderClick_has_new_candidate\`
- \`secondOrderClick_strictly_expands_candidate_set\`
- \`secondOrderClick_reaches_new_search_state\`
- \`retained_history_secondOrderClick_expands_ancestor\`
- \`retained_history_creates_ancestor_new_candidate\`
- \`retained_history_strictly_expands_ancestor_candidate_set\`
- \`depth_expansion_without_search_operator_expansion\`
- \`search_operator_expansion_without_realized_candidate_step\`

The final two results keep organizational depth and generator expansion
logically separate.

---

## T7A — quantitative accessibility geometry

**Theory statement.** Future organization has a directed, application-declared
transition-cost geometry. Retained change can improve future accessibility by
lowering costs even when the same future state was already possible.

**Formal status:** MC + concrete witness.

**Lean source**

QuantitativeAccessibility.lean

**Core definitions**

- AccessibilityCost
- AccessibleWithin
- BudgetSearch
- NoMoreViscousOn
- StrictlyLessViscousOn
- QuantitativeSecondOrderClick

**Selected declarations**

- noMoreViscousOn_refl
- noMoreViscousOn_trans
- strictlyLessViscousOn_trans_noMoreViscousOn
- noMoreViscousOn_trans_strictlyLessViscousOn
- strictlyLessViscousOn_trans
- noMoreViscousOn_preserves_budget_access
- strictlyLessViscousOn_opens_budget_window
- strictlyLessViscousOn_induces_strictExpansionAtBudget
- quantitativeSecondOrderClick_implies_secondOrderClick_at_some_budget
- quantitativeSecondOrderClick_has_cheaper_future
- viscosityToy_quantitative_click
- viscosityToy_binary_click_at_budget_one

**Key bridge**

A strict quantitative improvement always creates some budget threshold at
which at least one declared future target is newly accessible. Hence the v16
binary SecondOrderClick is recovered as a thresholded special case.

**Modelling boundary.** Lean does not choose the empirical unit of cost or the
target set. Lower cost is not automatically synonymous with greater value.

---

## T7B — functional organization and ratchet velocity

**Theory statement.** Organizational state and functional target are distinct
types. An organization induces a target-indexed functional cost geometry; a
positive retained ratchet step lowers no declared retained target cost and
strictly lowers at least one. Normalizing functional gain by a positive
time/resource interval yields ratchet velocity.

**Formal status:** MC + concrete witness.

**Lean sources**

- FunctionalRatchetVelocity.lean
- RatchetVelocityLedger.lean
- BoundedUpdateRate.lean
- SearchValidationTradeoff.lean
- StateDependentAllocation.lean
- BottleneckAllocation.lean

**Core definitions**

- FunctionalCost
- FunctionAccessibleWithin
- FunctionalRepertoireWithin
- NoMoreFunctionallyViscousOn
- StrictlyLessFunctionallyViscousOn
- FunctionalStepVelocity
- FunctionalStepRate
- PositiveFunctionalRateOn
- FunctionalRateDominatesOn
- StrictlyFasterFunctionalRateOn
- AcceleratingFunctionalRatchetOn
- RetainedSuccessFraction
- MechanisticRatchetVelocity
- VelocityLedgerMatches
- OpportunityGapBound
- ResourceValidatedSuccessEveryWindow
- FunctionalGainEveryWindow
- BoundedMechanismRateFloor
- SearchValidationVelocity
- BaselineValidationFraction
- ValidationBaselineVelocity
- TwoBaselineAllocationScore
- TwoBaselineBalancingAllocation

**Selected declarations**

- noMoreFunctionallyViscous_iff_nonnegativeVelocity
- strictlyLessFunctionallyViscous_iff_positiveVelocity
- noMoreFunctionallyViscous_preserves_budget_access
- strictlyLessFunctionallyViscous_opens_budget_window
- strictlyLessFunctionallyViscous_induces_repertoire_expansion
- positiveFunctionalVelocity_induces_repertoire_expansion
- positiveFunctionalVelocity_implies_positiveRate
- strictlyFasterFunctionalRate_has_target
- acceleratingFunctionalRatchet_has_faster_target
- commons_positive_functional_velocity
- commons_repertoire_expands_at_budget_one
- mechanisticRatchetVelocity_nonneg
- mechanisticRatchetVelocity_mono_opportunity
- mechanisticRatchetVelocity_mono_generation
- mechanisticRatchetVelocity_mono_resource
- mechanisticRatchetVelocity_mono_validation
- mechanisticRatchetVelocity_mono_retention
- mechanisticRatchetVelocity_mono_meanGain
- matchedLedger_zero_retention_implies_zero_measuredRate
- boundedOpportunity_and_response_imply_successEveryWindow
- supportedCycle3Maintenance_and_boundedResponse_imply_successEveryWindow
- boundedMechanism_implies_blockAverageRateFloor
- supportedCycle3Maintenance_implies_blockAverageRateFloor
- shorterResponseLag_strictlyRaises_rateFloor
- shorterOpportunityGap_strictlyRaises_rateFloor
- largerMinimumGain_strictlyRaises_rateFloor
- searchValidationVelocity_le_quarter
- searchValidationVelocity_eq_quarter_iff
- more_search_can_reduce_velocity
- validationBaselineVelocity_le_stateDependentMaximum
- validationBaselineVelocity_at_stateDependentOptimum
- inherited_organization_changes_optimal_allocation
- twoBaselineAllocationScore_le_balancedUpperBound
- twoBaselineAllocationScore_at_balancingAllocation
- balancingAllocation_equalizes_final_capacities
- searchFarAhead_all_to_validation_is_optimal
- validationFarAhead_all_to_search_is_optimal
- inherited_capacity_moves_the_bottleneck

**Key bridge**

A strict target-wise reduction in functional cost implies strict functional
repertoire expansion at some budget. The primitive object remains the
vector-valued functional cost/rate profile; no universal scalar complexity or
amount-of-organization measure is assumed.

**Modelling boundary.** Functional targets, success criteria, resource units,
environmental matching, and scalar aggregation are application-declared. The
mechanism ledger is an optional scalar projection with an explicit
`VelocityLedgerMatches` seam; it is not a universal probabilistic law.

---

## T7C — intelligent learning-maintenance specialization

**Theory statement.** Intelligent networks can be described internally by a
learning-maintenance process state whose substrate-specific dynamics induce an
external accessibility-cost geometry.

**Formal status:** MC interface + MODEL/INT interpretation.

**Lean source**

IntelligentLearningMaintenance.lean

**Core definitions**

- LearningVerb
- ProcessGeometry
- AppliesVerb
- ProcessImprovementOn
- VerbImprovementOn
- SelfImprovementOn
- ImprovementProductivity
- RecursiveSelfImprovementOn
- FunctionalProcessGeometry
- MatchedLearningRateImprovementOn
- RateGroundedRecursiveSelfImprovementOn
- LearningMechanismCertificate
- ProcessRateCertificate
- MechanismGroundedRecursiveSelfImprovementOn

**Selected declarations**

- processImprovement_has_cheaper_future
- verbImprovement_opens_budget_window
- selfImprovement_has_cheaper_future
- recursiveSelfImprovement_implies_selfImprovement
- recursiveSelfImprovement_increases_productivity
- rateGroundedRecursiveSelfImprovement_preserves_retained_functions
- rateGroundedRecursiveSelfImprovement_has_faster_learning_target
- mechanismGroundedRecursiveSelfImprovement_increases_rateFloor
- shorterResponseLag_improves_processRateCertificate
- shorterOpportunityGap_improves_processRateCertificate
- largerMinimumGain_improves_processRateCertificate
- endogenous_shorterResponseLag_implies_mechanismGroundedRecursiveSelfImprovement

**Interpretive boundary.** The verb names are not universal causal axioms.
Claims such as honesty lowering corrective viscosity, repair preserving an
informative edge, or re-engagement improving long-run learning require an
application-specific map from process state to geometry and empirical support.
The rate-grounded recursive definition additionally requires matched starting
organization, held-out functional targets, positive duration/resource windows,
and preservation of declared prior function.

---

## T8 — the dynamic vortex composes the resource and search routes

**Theory statement.** A supportive organizational transition can
simultaneously expand internally affordable response and future search, and the
recurrent version can support open-ended retained novelty with recurring
second-order change.

**Formal status:** MC + CW.

**Lean sources**

- \`DynamicVortex.lean\`
- \`DynamicVortexWitness.lean\`

**Core definitions**

- \`DynamicVortexTurn\`
- \`RecurringSecondOrderUpdate\`
- \`OpportunityConditionedEndogenousVortexResponseWithin\`

**Selected declarations**

- \`dynamicVortexTurn_opens_budget_and_futureSearch\`
- \`endogenousVortexResponseWithin_implies_endogenousResponseWithin\`
- \`recurringOpportunity_and_endogenousVortexResponse_imply_recurringSecondOrderUpdate\`
- \`recurringOpportunity_and_endogenousVortexResponse_imply_fullDynamicConsequences\`
- \`vortex_baseline_to_one_is_dynamicTurn\`
- \`vortex_has_integrated_zeroLag_response\`
- \`vortex_full_dynamic_witness\`

**Integrated consequence**

\[
\boxed{
\begin{aligned}
&\text{OpenEndedCumulativeNovelty}\\
&\land\ \text{UnboundedEnvelopeCapacity}\\
&\land\ \text{RecurringSecondOrderUpdate}.
\end{aligned}
}
\]

**Explicit modelling seam.** The interface requires that the retained validated
response is accompanied by the relevant organizational state update. Lean does
not derive a universal law from "novelty" to "physical improvement".

---

## T9 — retained accessibility can form a budgeted ratchet

**Theory statement.** A retained first step can improve the declared resource
state enough to make a later step feasible.

**Formal status:** MC + exact rational CW.

**Lean source**

\`formalization/cumulative-accessibility/CumulativeAccessibility.lean\`

**Selected declarations**

- \`retainsCostOn_scaled_iff_margin\`
- \`margin_ratio\`
- \`margin_update\`
- \`winds_iff_binding_cost_falls\`
- \`margin_dilute\`
- \`margin_increase_opens_coupling_window\`
- \`coupling_between_margins_switches_retention\`
- \`production_increase_opens_threshold_window\`
- \`exact_two_click_witness\`
- \`exact_second_click_unavailable_at_baseline\`
- \`exact_first_click_winds\`
- \`exact_second_coupling_in_opened_window\`

**Exact witness**

\[
M_0=\frac23,
\qquad
M_1=\frac{97}{99},
\qquad
\kappa_2=\frac9{10}.
\]

Paper-level map:
\`papers/when-does-change-become-cumulative/FORMAL_VERIFICATION.md\`.

---

## T10 — selection among equivalent implementations can release slack

**Theory statement.** Under an explicit cost-fitness law, competition among
functionally equivalent implementations can reduce mean implementation cost.
With fixed functional return, this releases slack; with nonnegative
slack-to-search coupling, search cannot decrease.

**Formal status:** MC for the declared toy models.

**Lean sources**

- \`formalization/persistence-drift/PersistenceDrift.lean\`
- \`formalization/persistence-drift/FunctionalCompetition.lean\`

**Selected declarations**

- \`cheaper_functionally_equivalent_increases_slack\`
- \`cheaper_functionally_equivalent_increases_exploration\`
- \`functional_efficiency_opens_search\`
- \`two_type_competition_mean_cost_nonincreasing\`
- \`two_type_linear_cost_exact\`
- \`two_type_linear_cost_slack_nondecreasing\`
- \`two_type_linear_cost_slack_strict\`
- \`two_type_cost_selection_search_nondecreasing\`
- \`two_type_cost_selection_search_strict\`
- \`continuous_cost_velocity_linear\`
- \`continuous_cost_velocity_nonpos\`
- \`mean_cost_nonincreasing\`
- \`slack_nondecreasing\`

**Boundary.** This is not a theorem that evolution always increases efficiency.

---

## T11 — selection need not imply monotone global progress

**Theory statement.** When the return/fitness map changes with the state, a
negative endogenous return-path contribution can overwhelm the ordinary
positive selection term.

**Formal status:** MC.

**Lean source**

\`formalization/persistence-drift/ReturnPathPrice.lean\`

**Selected declarations**

- \`price_full\`
- \`mean_fitness_with_state_change\`
- \`mean_fitness_nondecreasing_iff_return_bound\`
- \`mean_fitness_decreases_of_return_below_selection\`
- \`total_mean_fitness_velocity_decomposition\`
- \`total_mean_fitness_velocity_nonneg_iff_feedback_bound\`
- \`total_mean_fitness_velocity_negative_of_bad_feedback\`

This is one formal reason the theory rejects a generic
"selection = progress" interpretation.

---

## T12 — persistence metrics do not define function

**Theory statement.** Persistence, maintained abundance, resource exposure,
functional margin, and declared capability can move differently.

**Formal status:** MC for explicit counterexample/specialization models.

**Lean sources**

- \`formalization/persistence-drift/EquilibriumExposure.lean\`
- \`formalization/persistence-drift/FunctionalThresholds.lean\`

**Selected declarations**

- \`r_star_strictly_decreases\`
- \`x_star_strictly_increases\`
- \`hollowing_threshold_iff_cubic\`
- \`hollowB_strictly_decreases_on_physical_branch\`
- \`homogeneous_margin_under_uniform_dilution\`
- \`extraction_margin_eq\`
- \`extraction_viable_iff\`
- \`single_channel_extraction_threshold\`

Paper-level map:
\`papers/persistence-does-not-measure-function/FORMAL_VERIFICATION.md\`.

**Boundary.** Functional thresholds are declared by the model/application; Lean
does not discover the correct empirical function.

---

## T13 — selected control can differ from sufficient control

**Theory statement.** Privately selected regulation/alignment need not meet a
separately declared functional threshold.

**Formal status:** MC in explicit scalar/quadratic models.

**Lean sources**

- \`formalization/persistence-drift/RegulatoryReturn.lean\`
- \`formalization/collective-alignment/CollectiveAlignment.lean\`

**Selected declarations**

- \`boundaryDerivative_nonpos_iff_alignment\`
- \`alignment_iff_netMarginalValue\`
- \`alignmentObjective_gap\`
- \`selectedAlignment_global_max\`
- \`selectedAlignment_reaches_half_iff\`
- \`selectedAlignment_insufficient_if\`

This supports a local/global distinction without proving a universal theory of
capture.

---

## T14 — collective correction is a maintained architecture

**Theory statement.** Collective intelligence depends on interaction protocols
that can preserve information, add redundancy, repair damaged edges, and
reproduce themselves across turnover.

**Formal status:** MC in narrow toy models; INT for the broad collective-
intelligence interpretation.

**Lean source**

\`formalization/collective-alignment/CollectiveAlignment.lean\`

**Selected declarations**

- \`garbled_policy_lifts_exactly\`
- \`ungarbled_can_match_any_garbled_policy\`
- \`majority3_monotone\`
- \`majority3_half_threshold\`
- \`majority3_redundancy_gain\`
- \`protocolR_supercritical_iff\`
- \`expectedCarriers_step\`
- \`supercritical_expected_growth\`
- \`subcritical_expected_decline\`
- \`repair_weakly_better_iff\`
- \`repair_strictly_better_iff\`
- \`terminate_strictly_better_if_repair_too_costly\`

Paper-level map:
\`papers/sufficient-alignment/FORMAL_VERIFICATION.md\`.

---

## T15 — finite retained capacity saturates

**Theory statement.** A fixed finite distinguishability universe cannot sustain
indefinitely many strict retained expansions.

**Formal status:** MC.

**Lean source**

\`FiniteGenerativeSaturation.lean\`

**Selected declarations**

- \`strictExpansionCount_le_remaining_capacity\`
- \`finite_retained_process_saturates\`

This is a finite combinatorial boundary independent of the physical no-go
result below.

---

## T16 — open-ended retained novelty requires open-ended effective capacity

**Theory statement.**

\[
\text{open-ended cumulative retained novelty}
\Rightarrow
\text{unbounded effective distinguishability capacity}.
\]

**Formal status:** MC; converse explicitly separated.

**Lean source**

\`OpenEndedCapacity.lean\`

**Selected declarations**

- \`openEndedNovelty_implies_unboundedEnvelopeCapacity\`
- \`unboundedCapacity_without_openEndedNovelty\`

Capacity is necessary in the stated representation model, not sufficient for
realized novelty.

---

## T17 — finite-time fixed-resolution organizational depth is physically bounded

**Theory statement.** Under explicit finite-action/speed-limit assumptions,
bounded time and resources bound the number of retained transitions separated
by a fixed positive operational resolution.

**Formal status:** MC conditional on the physical speed-law hypotheses.

**Lean sources**

- \`verification/organizational-depth/OrganizationalDepth.lean\`
- \`verification/organizational-depth/OperationalBridge.lean\`
- \`verification/organizational-depth/PackingDepth.lean\`

**Selected declarations**

- \`OrgDepth.stochastic_route_closed\`
- \`OrgDepth.weighted_finite_action\`
- \`OrgDepth.packing_depth_thermo\`
- \`OrgDepth.packing_depth_two_factor\`
- \`OrgDepth.depth_le_of_budget_ceiling\`
- \`OrgBridge.dTV_push_le\`
- \`OrgBridge.speed_limit_operational\`
- \`OrgBridge.operational_fixed_resolution\`
- \`OrgBridge.pairwise_depth_resource_bound\`

**Boundary.** The physical speed-limit law itself is a premise in the relevant
formalization. The operational bridge is proved for the declared finite-state
Markov/channel model.

---

## T18 — maintenance debt can change stability without moving the equilibrium

**Theory statement.** In one explicit debt-aware maintenance model, hidden
maintenance state can alter local spectral stability even when the equilibrium
location is unchanged.

**Formal status:** MC for the model-to-spectrum route.

**Lean sources and declarations**

\`verification/organizational-depth/MaintenanceDynamics.lean\`:

- \`criticalY_nonneg\`
- \`criticalY_root\`
- \`stable_above_criticalGamma\`
- \`debt_stability_lhs_monotone\`
- \`debt_stability_upward_closed\`

\`verification/organizational-depth/MaintenanceDynamicsEndToEnd.lean\`:

- \`maintenance_equilibrium_balances\`
- \`maintenance_equilibrium_flow_zero\`
- \`maintenance_equilibrium_has_jacobian\`
- \`debtCharMatrix_det\`
- \`critical_gain_implies_jacobian_hurwitz\`
- \`maintenance_end_to_end_spectral\`

Paper-level map:
\`papers/when-does-maintenance-debt-stabilize/FORMAL_VERIFICATION.md\`.

**Boundary.** The generic theorem "Hurwitz Jacobian implies local asymptotic
stability under standard smoothness conditions" is external to this Lean
development.

---

# The full proof-supported chain

The strongest current machine-supported composition is:

\`\`\`text
recurrent maintenance support
        +
declared support -> opportunity interface
        ↓
recurring opportunity

external gradient
        +
organization-dependent uptake
        -
maintenance
        ↓
internal slack
        ↓
endogenous response budget

recurring opportunity
        +
resource-feasible validated response
        ↓
validated generative uptake
        +
retention
        ↓
open-ended cumulative retained novelty

retained organizational update
        ↓
reusable parent material and/or changed generator
        ↓
second-order accessibility
        ↓
changed future search

representation inside moving envelope
        ↓
unbounded effective distinguishability capacity
\`\`\`

\`DynamicVortex.lean\` and \`DynamicVortexWitness.lean\` explicitly compose the
resource-funded response route with recurring second-order organizational
updates.

---

# Interfaces that remain assumptions

The current theory deliberately does not hide the following bridges.

## I1 — support to opportunity

A quantitatively supported maintenance state does not determine which scientific
"opportunity" predicate should be used.

Status: **MODEL**.

## I2 — retained response to physical organizational update

A validated retained candidate does not automatically imply a specific physical
state transition, higher uptake, lower maintenance, or expanded search.

Status: **MODEL**.

## I3 — external validation

The predicate \(E_t\) is declared. It is not automatically objective truth,
fitness, morality, or utility.

Status: **MODEL**.

## I4 — empirical state and distance

The mapping from a real system to \(s_t,M_t,H_t,U_t\), response cost, and
operational distance is application-specific.

Status: **MODEL**.

## I5 — universality

That the architecture is useful across chemistry, biology, cognition,
institutions, and technology is a research programme to be tested, not a Lean
theorem.

Status: **INT**.

---

# Interpretive extensions not claimed as formal consequences

The repository also develops:

- commons;
- capture;
- corrigibility;
- autonomous interdependence;
- collective learning;
- governance/SCAP;
- rights and normative implications.

These can be motivated by the formal architecture, but they are not automatic
deductions from it.

Where a normative claim appears, the value premise must be stated separately.

---

# Novelty status

The repository's literature audit currently supports the following framing:

\[
\boxed{
\text{primarily synthesis/architecture}
+
\text{some exact model-specific results}.
}
\]

The 15 September 2026 audit classified:

- 7 of 12 audited results as rediscoveries or elementary corollaries;
- 5 of 12 as sharpenings;
- 0 of 12 as high-confidence new general theorems.

The strongest review target is therefore the **integrated architecture and its
interfaces**, not an assertion that each component mechanism is new.

See:

- \`verification/audits/2026-09-15-literature/P1_LITERATURE_AUDIT.md\`
- \`verification/audits/2026-09-15-literature/FROM_SYNTHESIS_TO_PARADIGM.md\`

---

# Verification surfaces

The theory currently spans several Lean packages.

See **[formalization/README.md](formalization/README.md)** for exact commands.

The repository also runs **Full Theory Proof Check**, which builds the major
supporting Lean packages together and rejects \`sorryAx\` from the selected
theory-surface files.

The most important integrated cumulative-accessibility surface is additionally
audited by:

- \`CumulativeAccessibility.AuditAll\`
- \`CumulativeAccessibility.VerificationSurface\`
- \`CumulativeAccessibility.DynamicVortexWitness\`

---

# Peer-review questions

A reviewer should attack at least these points:

1. Are the theory's interfaces genuinely independent, or have conclusions been
   smuggled into assumptions?
2. Does the retained-response -> state-update interface make the dynamic vortex
   tautological in any application?
3. Is the distinction between physical slack and normalized accessibility
   margin maintained consistently?
4. Can open-ended novelty occur under a weaker capacity condition?
5. Do turnover and loss invalidate monotone retained-set abstractions?
6. Does the operational-distance mapping survive realistic coarse-graining?
7. Can generator-rule evolution be derived mechanistically rather than declared?
8. Does a known literature already provide the same integrated architecture?
9. Which cross-domain applications give genuinely new predictions rather than
   redescriptions?
10. Which claimed "commons" or "capture" effects can be operationalized without
    importing a normative target into a descriptive model?

A counterexample, prior-art identification, or failed interface is a successful
review result.
