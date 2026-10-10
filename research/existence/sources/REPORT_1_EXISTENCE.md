# An existence conjecture for Evolution by Emergence

**Research assessment prepared for Albert Jan van Hoek · 9 October 2026**

**Assessment:** EbE is ready for a narrow, testable conjecture connecting its models to independently measured persistence. It is not ready for a universal law that every finite thing must learn, improve, reciprocate, maintain a vortex, or exercise agency to exist. The most defensible common statement is a resource-constrained, causal viability requirement. Most of that mathematical structure is established territory; the unresolved contribution is whether EbE supplies useful, independently calibrated descriptions of actual systems.

This report proposes one conjecture, makes its empirical bridge explicit, and distinguishes its accounting backbone from mechanisms that sometimes help satisfy it. It does **not** pretend that every result in the repository is a logical special case of one existence law.

**Source boundary.** The main repository was assessed at commit `30ae50cfbf8def6c1afbaa276c5647bc879010de`. The requested `ExitOption.lean` and D15 were absent there. They were read separately at the head of open PR #102, commit `ad4cf01c415b75d0fb2f76359f18a3ed86d5eb6c`, and are labelled supplementary below. The requested reading sequence was followed. The `experiments/` folder was not opened. Repository statements, examples and reported trials were treated as claims to assess, not independent evidence. [R1–R6]

## Part 1 — The conjecture

### 1.1 Short version: the maintenance–response conjecture

> A finite, maintenance-dependent network can keep a specified organization functioning throughout a declared range of disturbances only if its available, causally deployable responses can keep every indispensable resource above its failure floor throughout the declared horizon. When a disturbance creates a continuing deficit, any response needed to remove it must be available and affordable before the relevant buffer is exhausted. This is a claim about models and measurements fixed before testing; learning, reciprocity, growth and exit are possible ways to satisfy it, not requirements of all existence.

The substantive claim is that an independently calibrated EbE description gives **necessary constraints on observed functioning**. The arithmetic of a ledger is not itself that empirical claim.

### 1.2 Scope and registration

The proposed domain is **finite, maintenance-dependent organizations over finite horizons**, represented by a finite set of indispensable resource coordinates and a finite observation/action alphabet at the resolution of the test. The underlying physics need not have a finite state space. The model is a finite description, not an assertion that nature is a finite automaton.

Eligible systems include maintained physical devices, living systems, institutions and artificial systems **when** their operational identity, resource measurements and interventions can be specified independently. A battery-powered pump is an immediate candidate. A social institution requires much more work: survival of its legal name, delivery of its services and preservation of its members are different outcomes. Money is not automatically a valid substitute for labour, trust, time, energy or legal permission.

Equilibrium objects merely retaining shape are outside this maintenance-dependent claim. A crystal already defeats a proposed universal requirement for ongoing organizational learning; a maintained fixed controller defeats a proposed universal requirement for continual improvement. Dormancy and stockpiling must be modelled as low demand or stored capacity, not declared exceptions after an outcome. An externally supported unit may persist without financing its own support. Its incoming support must be measured, and any claim about the larger supporting network must use that larger boundary.

Each test fixes the following **before** evaluation:

1. The focal organization, permitted replacement of components, indispensable roles, independent operational criterion, measurement resolution and failure tolerance.
2. A horizon of (T\geq1) discrete intervals, their physical duration, and a nonempty class \(\mathcal E\) of admissible environmental courses. This class may contain an actual course alone; robustness requires a larger class.
3. Initial resource stocks, storage capacities, resource floors, uptake, upkeep, transfers, response costs, observation channels and physically available actions, calibrated on separate data or interventions.
4. The implemented controller and its accessible information. External carers, common resources, replacement suppliers and controllers are included where their support is being claimed. Common resources counted inside the boundary receive their own stock coordinates.
5. Error bounds and the decision rule for rejecting the prediction. Scope eligibility cannot be defined as “the ledger successfully predicts the result.”

The deterministic formulation below is deliberately narrower than a probabilistic theory. A stochastic extension must specify a distribution or a set of disturbances, a failure probability and confidence procedure. “It lasts with high probability” without these choices is not a replacement for the statement.

### 1.3 Exact formulation

Let \(J\) be a finite, nonempty set of resource coordinates. A coordinate is a resource **at a specified indispensable role or shared stock**, not necessarily at an immutable physical component. Its zero is the preregistered failure floor. Coordinates have separate units; they are never summed across incompatible units.

For a fixed experiment \(D\), let:

- \(W,O,A\) be finite, nonempty sets of disturbance symbols, observations and actions.
- \(e:\mathbb N\to W\) be an environmental course, with \(e\in\mathcal E_D\). Only its first \(T\) inputs matter to the ledger.
- \(h_t\) be the history of disturbance/action pairs before step \(t\). This is the model's history, not information automatically available to the controller.
- \(o_t=\operatorname{obs}(h_t,e_t)\) be the accessible observation, including any declared sensor error or delay.
- \(\pi:O^*\to A\) be a deterministic causal policy. Its step-\(t\) action is \(a_t=\pi(o_0,\ldots,o_t)\). It cannot inspect future disturbances. Fixed policies are allowed; a policy over histories may also implement learning or construction of new options.
- \(b_j(0)\geq0\) and \(C_j\geq b_j(0)\) be initial buffer and capacity.
- \(u_j(h_t,e_t,a_t)\geq0\), \(m_j(h_t,e_t,a_t)\geq0\), \(f_j(h_t,e_t,a_t)\in\mathbb R\), and \(c_j(h_t,e_t,a_t)\geq0\) be captured inflow, upkeep, net relational transfer and response expenditure during the interval. The Lean sketch uses integer units; the mathematical statement can use real units.

The registered ledger predicts

\[
s_j(t)=u_j(t)+f_j(t)-m_j(t)-c_j(t),\qquad
b_j(t+1)=\min\{C_j,b_j(t)+s_j(t)\}.
\]

A negative predicted buffer is an accounting violation, not physical negative fuel. The model is permitted to continue arithmetically after that predicted violation so that the forecast is unambiguous. Uptake and demand are interval quantities; a rate must be multiplied by interval duration. If failure can occur within an interval, the time resolution or a within-interval constraint must capture it.

Let \(\operatorname{Allowed}_D(h_t,e_t,a_t)\) express the registered **physical** restrictions on that action: available components, route capacities, delivery delays, conversion losses and response latency. It must not encode moral approval or be defined as “the system subsequently survives.” For a conserved resource, internal transfers cancel over the relevant nodes, with losses charged explicitly; exchanges that produce additional usable output require an explicit production or conversion term. A common stock has its own replenishment and extraction equation.

Define

\[
\operatorname{LedgerSafe}_D(\pi,e,T)
\iff
\bigl[\forall t\leq T\;\forall j\in J,\ b_j^{\pi,e}(t)\geq0\bigr]
\land
\bigl[\forall t<T,\operatorname{Allowed}_D(h_t,e_t,a_t)\bigr].
\]

Separately, let \(\operatorname{Operational}_D(\pi,e,t)\) mean that the **physical implementation** of \(\pi\) passes the registered organizational or service test at time \(t\). This is an observation about functioning. It is **not defined** by nonnegative slack, a reserve equation, a successful search, or a favourable health score. The match between the physical observation interface and the model interface is part of what must be checked.

**Conjecture, for the declared class of independently calibrated experiments \(D\):**

\[
\boxed{
\forall\pi,\quad
\left[\forall e\in\mathcal E_D\;\forall t\leq T,
\operatorname{Operational}_D(\pi,e,t)\right]
\Longrightarrow
\left[\forall e\in\mathcal E_D,
\operatorname{LedgerSafe}_D(\pi,e,T)\right].
}
\]

This uses the **same policy** on both sides. Consequently, existence of an operationally robust implementation implies existence of a causally feasible ledger policy. It is stronger and more informative than allowing a different, retrospectively invented controller for each future. The important quantifier order is \(\exists\pi\,\forall e\), not \(\forall e\,\exists\pi_e\).

This is not asserted for arbitrary choices of ledger functions. A deliberately wrong upkeep estimate gives an immediate counterexample. The proposal is a family of preregistered empirical claims about a stated calibration method and domain; the repository has not yet supplied that method across substrates. Without this restriction and prospective testing, the displayed formula is only a template for a conjecture, not a completed universal scientific law.

### 1.4 The deadline consequence

Suppose one coordinate starts a challenge with buffer \(B\), and every available response leaves it losing at least \(\delta>0\) per interval for \(L\) consecutive intervals. The ledger then gives

\[
b(t+L)\leq B-L\delta.
\]

If \(L\delta>B\), no ledger-safe response exists across that window. For the conjecture, observed uninterrupted functioning across that window would contradict the registered prediction. With integer steps and no effective response, the first forced negative prefix occurs no later than \(\lfloor B/\delta\rfloor+1\) intervals. An immediate response cost \(K\) replaces \(B\) with \(B-K\). Costs and gains at other times require the full prefix calculation; a favourable terminal balance does not suffice.

“Response” includes passive buffering, a pre-existing regulator, a switch of supplier, repair, care, exit and an inherited fixed repertoire. Learning becomes relevant only where existing responses cannot satisfy the constraints. Unbounded expansion becomes relevant only to unbounded distinct novelty, not ordinary persistence.

### 1.5 Definition crosswalk

| Proposed term | Existing definition generalized | What changes |
|---|---|---|
| Resource inflow \(u\), demand \(m\), slack \(s\) | `GradientStream`, `UptakeFunction`, `MaintenanceDemand`, `InternalSlackAt` in `EndogenousBudgetBridge` | Vector resources, explicit transfers and response expenditure; no universal common currency. |
| Buffer and capacity | `reserve` in `AdaptivePersistence` | Same capped recurrence, coordinate by coordinate, over a declared finite horizon. |
| Indispensable resource coordinate | `carerReserve` and `care_lasts_iff_every_dimension`; `partReserve` in `PowerDistribution` | Roles and resource floors are independently specified; replacement can preserve a role. |
| Relational support | `PartSlackAt`, `PureTransfer`, `AggregatesParts` in `NetworkVortexLedger`; `Reciprocity` | Actual feasible routes and times replace an unrestricted existential redistribution. |
| Shared resource stock | `CommonsVortex` stock trajectory; `CommonsCapture` stock accounting | A coordinate with extraction and regeneration, coupled to node use. |
| Available, affordable response | `ResourceFeasibleAt`, `ResourceValidatedSuccessAt` in `ResponseDynamics`; `EndogenousResponseBudget` | Entire observed history, prefix affordability, delivery and learning costs. The existing `beta * slack` budget is one specialization, not the definition of all spending. |
| Response time | `ResponseWithin` family and bounded lag in `BoundedUpdateRate` / `DynamicVortex` | Lag is compared to a measured resource-exhaustion deadline. |
| Changing environment | `OpenWithDwell` and fit predicates in `AdaptivePersistence` | A declared finite-horizon disturbance class; no assumption that every world can persist arbitrarily long unless expressly included. |
| Causal policy | Feedback-following fit in `AdaptivePersistence`; feedback constraints in `ListeningCost` | Explicit information histories rule out choosing an action using an inaccessible future. |
| Observed persistence | **No corresponding independent observational predicate in the ledger results** | This is the unproved bridge. `InternallyViableAt` is an accounting definition and cannot supply it. |

Sources: [R1–R3].

### 1.6 Necessity, not sufficiency

The conjecture asserts **necessity** within the registered domain. It does not say that sufficient money, energy or response options guarantee functioning. An implementation can be destroyed, miscontrolled or lose its organizational identity while resources remain. To establish sufficiency, one would need a complete enough transition model and an invariant functional safe set, including hazards beyond the resource coordinates.

Nor does it require nonnegative **instantaneous** slack. A system with reserves can function through a deficit. Replacing prefix resource feasibility with “upkeep is paid at every instant from current inflow” would incorrectly exclude ordinary buffering. On an infinite horizon, a fixed strictly negative net rate eventually exhausts any finite reserve; that conditional arithmetic is already present in the repository.

## Part 2 — Map to the proofs and the gaps

### 2.1 What “special case” can honestly mean

There are three different relationships:

- **Ledger instances:** a published simple model is obtained by restricting resources, policies, flows or environments. Its arithmetic can become a lemma in a combined model.
- **Conditional mechanisms:** a result shows how a particular mechanism improves a budget, selects a lower cost, creates an option or prevents a specific failure. The mechanism is not thereby necessary for persistence.
- **Boundary results:** a counterexample or measurement result limits an inference. It is not a persistence mechanism at all.

No current theorem proves the bridge from independently observed operation to ledger safety. The statement “all proved results are instances of one existence theorem” would therefore overstate the mathematics. `EbECore.lean` is an import/check/axiom-reporting entry point; it is not a theorem composing all the modules into one dynamical system. [R2]

### 2.2 Proof map

The names below are repository theorem names. Assumptions are summarized at the level needed to judge their relevance; the exact statements remain the controlling source. Main-revision paths are indexed by CORE and the core aggregation file. [R1–R3]

| Component | Proved results | Essential premises and actual conclusion | Relationship to the conjecture |
|---|---|---|---|
| One-step maintenance | `internallyViableAt_iff_internalSlack_nonneg` | Viability is defined as demand ≤ uptake; subtraction is nonnegative exactly then. | Accounting identity. No evidence that a real organization fails at this boundary. |
| Finite maintenance capacity | `self_financing_never_binds`, `no_runaway_when_upkeep_exceeds_capture`, `critical_mass_dichotomy`, `unaffordable_critical_mass_extinct`; `candidate_set_exceeding_budget_cannot_all_be_retained` | Specified capture/upkeep coefficients and population recurrence; subcritical and supercritical regimes assumed around the threshold; retention charged to a finite budget. | Ledger/capacity instances. They do not derive the empirical coefficients or a general threshold. |
| Return paths | `cycle3Trajectory_has_positive_support_floor`, `deleting_return_edge_makes_source_decline` | A particular positive three-node linear system, parameter inequalities and initial conditions; deletion removes a return supporting a source that decays without it. | A support mechanism. No theorem that every persistent network needs a nontrivial support cycle. |
| Two-party reciprocity | `exchange_lasts`, `defection_pays_at_first`, `defector_holds_while_partner_lives`, `defector_falls_after_partner` | Integer reserves; prescribed giving/receiving; both parties depend on exchange; no alternative provider in the fixed-pair model. | Ledger instance. Persistent unilateral support or a replacement partner falls outside the failure premises. |
| Partner replacement | `switching_defection_pays_iff`, `reputation_ends_serial_defection` | Saved giving during a partner's remaining life compared with switching/search expenditure; search cost increases with accumulated reputation under the stated rule. | Conditional mechanism and limit. It explicitly blocks a universal “defection always loses” reading. |
| Cost selection | `mean_cost_nonincreasing`; `two_type_linear_cost_slack_strict`, `two_type_cost_selection_search_strict` | Fitness decreases linearly with cost; normalized nonnegative frequencies and positive mean fitness; strict versions require unequal costs, an interior two-type mixture and positive selection/reinvestment factors. | Conditional mechanism. Selection need not generally reward maintenance efficiency, and increasing mean slack is not proved lifetime extension. |
| Changing worlds | `sealed_configuration_does_not_persist`, `sealed_configuration_fails_on_vortex_ledger` | An excluded world state, arbitrarily long admissible dwell there, a uniform strictly negative misfit slack, bounded reserve and restricted fit. | Closest necessity instance: **some** admissible future forces ledger failure. Not a claim that the actual future does. |
| Reliable feedback | `listening_configuration_persists`, `listening_persists_on_vortex_ledger` | Feedback is reliable, the configuration follows it, fit has nonnegative slack, initial reserve/capacity are nonnegative. | Model sufficiency only. Reliability and affordable causal realization need separate justification. |
| Costly or misleading feedback | `listening_pays_iff`, `misleading_feedback_does_not_pay`, `unaffordable_listening_fails`; also `stable_world_favours_sealing` | Fixed fit gain, misfit loss, per-step listening cost and given fit/error sequences. Avoided loss must exceed listening expense. | Mechanism and boundary. Comparing totals does not establish safety of every prefix. |
| Scaffolded exploration | `scaffolded_search_cost`, `scaffold_strict` | A separable task with feedback and retained intermediate successes; the specified search enumeration changes from \(q^k\) to \(kq\), with strictness only under its parameter conditions. | A conditional search advantage, not a universal complexity reduction. |
| Budget expansion | `organization_improvement_increases_endogenousResponseBudget` | Same external gradient; uptake weakly increases, maintenance weakly decreases, reinvestment coefficient nonnegative. | Accounting mechanism. The improvement is a premise, not a predicted discovery. |
| Accessible transitions | `kernelDominance_preserves_accessibility`, `positivePaidOpening_requires_kernel_advantage`, `route_saving_exceeds_marginal_upkeep_opens_paid_window`, `no_paidOpening_without_kernel_change` | Specified transition costs, routing/maintenance changes and affordability comparisons. | Shows what can open a paid transition window within that model. Not a universal requirement to change a kernel. |
| Retained new options | `retained_intermediate_creates_second_round_access`, `new_parent_set_implies_secondOrderClick` | The retained intermediate is available to a generator; the parent/candidate conditions establish an option unavailable previously. | A repertoire-expansion mechanism. Persistence without new options is untouched. |
| Vortex composition | `dynamicVortexTurn_opens_budget_and_futureSearch`, `recurringOpportunity_and_endogenousVortexResponse_imply_fullDynamicConsequences`, `vortex_full_dynamic_witness` | A turn includes strict slack improvement and a second-order search opening; recurring opportunities and timely financed/validated responses are assumed. A witness instantiates those premises. | Conditional composition, not emergence of the response mechanism from survival alone. The central recurrence premise carries much of the causal burden. |
| Retention and response rates | `mechanisticRatchetVelocity_zero_no_retention`, `mechanisticRatchetVelocity_mono_retention`, `boundedMechanism_implies_blockAverageRateFloor`, `shorterResponseLag_strictlyRaises_rateFloor`; `more_search_can_reduce_velocity` | The specified velocity product and bounded response assumptions; positive-factor/lag conditions for strict comparisons; search competes with validation in the counterexample. | Mechanism and boundary. Zero progress is not necessarily death. More exploration is not always better. |
| Whole versus parts | `internalSlack_eq_sum_partSlack`, `internallyViable_iff_exists_viable_transfer`, `transfer_breaks_part_with_whole_unchanged`, `nonviable_vortex_zero_velocity` | Additive scalar accounting and zero-sum internal flows. The existence equivalence allows unrestricted scalar redistribution over nonempty finite parts. | Ledger instances. Existence of a transfer is not its delivery. Route limits, losses, delay and non-substitutable resources matter. Future productivity may change even when a present transfer leaves the present total unchanged. |
| Extraction and collective alignment | `extraction_viable_iff`, `mean_fitness_decreases_of_return_below_selection`, `selectedAlignment_insufficient_if` | Stated extraction/return thresholds, selection terms and aggregate parameters. | Conditional distribution mechanisms. Individual selection alone does not establish collective viability. |
| Commons maintenance | `grows_with_commons_iff`, `positive_loop`, `saturation_bounds_growth`, `commons_grows_in_window`, `capture_collapses_commons`, `capture_pays_then_fails`; `capture_undermines_own_ground`, `lasts_iff` | Specific stock recurrences and creation/regeneration/take conditions; collapse arguments require the stated dependence and overdraw assumptions. Fixed-regeneration results use that fixed rate. | Ledger instances and sufficient mechanisms. They do not derive regeneration laws, institutions or corrective action. |
| Incentives around commons | `take_more_than_create_and_last`, `not_cheating_wins_over_time`, `specialists_fail_after_collapse`, `sanction_makes_capture_unprofitable`; `capture_wins_under_steep_discount`, `not_cheating_wins_under_mild_discount`; `tragedy_of_the_commons`, `enough_takers_make_defection_pay`, `detected_sanction_deters` | Fixed payoff, dependence, time, discount, taker-count and detection/sanction assumptions. Some regimes make capture advantageous. | Mechanisms and counterexamples to a universal alignment of self-interest with preservation of the whole. |
| Care | `care_lasts_iff`, `cared_for_falls_after_carer`, `care_lasts_iff_every_dimension` | Constant integer surplus, return and care demand; nonnegative initial reserves; positive dependence after care stops. Every non-substitutable dimension must meet its own long-run inequality. | Direct vector-ledger instances. “Burnout” here is a reserve model, not a clinical or sociological finding. |
| Power and distribution | `aggregate_does_not_decide_persistence`, `chooser_decides_who_fails`, `excluding_failing_parts_looks_viable`, `deters_all_iff_deters_least_detected` | Explicit part-reserve trajectories; unrestricted scalar transfer choice; exclusion changes the accounting list; enforcement is governed by the least-detected case under the stated inequalities. | Distribution instances and boundary warnings. No theorem grants moral legitimacy to the chosen boundary or proves how power evolves. |
| Emergent assembly | `viable_emergent_intermediate_requires_auxiliary_support` | An intermediate has a maintenance deficit under the assembly assumptions; viability therefore needs additional support. | Ledger necessity for that intermediate. Does not establish a universal emergence pathway. |
| Cumulative novelty | `uniformCritical_and_retention_without_seed_not_enough`, `seed_and_retention_without_criticality_not_enough`, `recurringRecursiveEmergence_without_retention_not_cumulative` | Countermodels isolate missing seed, successor/criticality or retention conditions in the defined cumulative process. | Requirements for that cumulative process, not for all continued existence. |
| Finite versus open-ended novelty | `finite_generative_closure_saturates`, `openEndedNovelty_implies_unboundedEnvelopeCapacity` | A finite effective closure has finitely many distinct candidates; indefinitely distinct novelty requires an unbounded effective envelope. | Capacity boundary. A fixed finite system cannot exhibit unlimited distinct novelty without expanding its effective envelope. |
| Intelligence specialization | `anchor_not_two`, `live_and_aim_force_strong_connectivity`, `room_in_one_head`, `certainty_is_not_a_certificate`; `sealed_constraint_fails`, `learner_in_step`, `shared_reality_when_connected`, `self_fulfilment_is_not_verification` | Declared aim/anchor, reachability, validation, fit and world-course structures; connectivity/reliable constraint-following assumptions where used. | Epistemic and network specializations. No proof that all persistent substrates possess intelligence or reflective self-models. |
| Correction architecture | `built_correctable`, `last_route_removal_seals`, `hub_determined_network_inherits_blind_spot`, `correctable_population_ceiling`; `zero_credence_is_sealed`, `mix_keeps_agreed_ranking`, `correcting_levels_form_interval` | The specified composition, correction routes, shared hub, resource ceiling, update rule and connection/independence thresholds. | Conditional mechanisms and limitations in an intelligence model. A working correction route is different from an intrinsic aim or a felt commitment. |
| Curiosity / exploration | `exploration_raises_reserve_iff`, `gain_attributable_to_learning`, `long_enough_horizon_pays`, `pays_but_unaffordable` | Up-front cost \(K\), assumed retained per-step saving \(s\), horizon \(n\); payoff requires \(K<ns\), while an initial budget can still be insufficient. | An investment mechanism. The gain from discovery is assumed, and a subjective experience of curiosity is not modelled. |
| Exit and unused agency — **PR #102** | `best_offer_is_floor`, `exit_unused_at_best_offer`, `exit_raises_floor`, `worthless_exit_adds_nothing`; `deliberation_pays_iff`, `habit_optimal_without_shift` | Outside option changes the reservation floor; a partner's payoff falls with the offer and staying occurs at the threshold. Real feasibility additionally needs enough surplus to make that offer. Deliberation pays only where its specified accumulated benefit exceeds cost. | An option can alter another party's action without being exercised. This does not prove that every real outside option is credible or explain experienced agency. |
| Health measurement | `stage_product_zero_iff`, `sum_compensates_failed_stage`, `relabelling_reverses_sum`, `relabelling_reverses_product`, `dominance_survives_relabelling` | Product/sum definitions and ordinal relabellings; componentwise dominance is order-preserving. | Measurement boundaries. Serial-stage multiplication and numerical health scales need independent justification; none is an observed survival law. |

### 2.3 Gaps that remain

CORE's “Not yet formal” list should constrain any synthesis. The proposed conjecture does not quietly close these gaps. [R1, §“What this page does and does not claim”]

| Gap named by CORE | Consequence for this conjecture |
|---|---|
| Efficiency buys duration | Improved slack is not yet a lifetime theorem with hazards, changing uptake and timing. This is an early target for the combined model. |
| Errors depending on the world's course; choosing how much to listen | Need a causal sensing policy, error model and sensing costs jointly coupled to the resource trajectory. |
| Partial defection and forged reputation | Current exchange/search inequalities do not establish robustness to graded or deceptive strategies. |
| Capture spread over time; changing discount; changing return paths; multiple defectors; partial overtake; responsive takers; a mobile capturer; failed detection | The fixed incentive and collapse results do not supply a general dynamic strategic model. |
| Rule formation, arrival of correction, and capture becoming a higher-level unit | Existence of a viable rule or a response is not a mechanism that selects and executes it. |
| Network origin of feedback outside intelligence | Generalizing feedback from an epistemic model to all substrates remains an argument, not a theorem. |
| Multiple carers and time-varying or uncertain care costs | Need vector stocks, changing support routes and uncertainty over the full horizon. |
| Power over evidence and rules; multiple powerful parties; acquisition/loss of power | The measurement boundary and effective action set can be strategic objects. Current transfer-choice results do not settle them. |
| Claims of parts that cannot be traded for the whole's gain | A normative choice, not a missing mathematical derivation. Persistence cannot decide which people may be sacrificed. |
| Explicit horizons; combination of node capacity, relational inflow and commons state | Several modules already contain time indices, finite totals or lag. What is missing is their integrated, empirically timed resource-and-response system. |
| View from inside; health measures remain concept notes | Neither felt ownership of commitment nor validated multidimensional health instruments is supplied. Ordinal arithmetic does not validate an instrument. |

Further gaps exposed by the synthesis are the independent operational predicate, calibrated resource floors, causal information constraints, action realizability, component replacement and model error. They are essential to the conjecture's empirical content.

## Part 3 — Refutation and limits

### 3.1 Concrete refuting cases

The conjecture makes no sufficiency claim, so a well-funded system that fails does not refute it. A registered experiment that sustains its specified operation while violating the predicted necessary constraints does.

| Test | Prediction fixed before evaluation | Observation that rejects the registered conjecture |
|---|---|---|
| Buffer versus response delay | An independently characterized device has ten usable resource units, loses at least three per interval during the challenge, receives no replacement input, and cannot implement an effective response during the first four intervals. Its predicted buffer after interval four is at most −2. | It delivers the preregistered service continuously through interval four, with measurement uncertainty too small to account for the difference and the declared challenge conditions met. |
| Non-substitutable resource | A coupled system has ample aggregate surplus, but one indispensable resource at an indispensable role is predicted to cross its fixed failure floor before the horizon; the protocol rules out transfer/conversion/replacement during that window. | The same organizational/service criterion remains satisfied despite that coordinate's predicted violation. The claimed indispensability or resource-to-function bridge was wrong. |
| Information deadline | Two admissible challenges give identical accessible observation histories until the last safe decision. Under the calibrated transition model, surviving them requires disjoint actions, and buffering or delayed choice cannot bridge the deadline. The same deterministic controller must be used. | The implementation reproducibly handles both challenges under the declared interface and identical initialization. This rejects the model of information, available responses or the deadline. A covert cue is a model failure, not grounds to claim foresight. |
| Commons dependence | A maintained role is calibrated to require a particular common stock after its private buffer is exhausted; no substitute is in the registered boundary. | The role continues functioning after the predicted common-stock and private-buffer limits. The specified dependence model fails. |

These are **prospective model tests**. If hidden storage, an unmeasured carer or a faster response is discovered, it explains the failed forecast and can motivate a new version. It does not retrospectively make the old prediction correct. However, such a discovery alone does not refute conservation of energy or every possible EbE model. That distinction is a limitation of the proposed broad framework and must be reported honestly.

For a nonempty finite challenge suite, robustness can be tested across the full suite. For an unbounded class, a finite set of successes cannot demonstrate the antecedent “works on every course.” A single observed course can instead be tested by declaring a singleton class in advance. To reject a robust claim using the two-challenge information test, both challenges and the shared-controller condition must actually be checked.

There is no universal stochastic sample size here: it depends on the noise distribution and the size of the predicted violation. Register these before choosing a rejection threshold. Prefer violations substantially larger than measurement and model-error margins.

### 3.2 What would refute a grander version immediately?

Several stronger readings should be rejected without waiting for a new experiment:

- **Every persistent configuration must continually improve:** a fixed, resource-supplied controller in a bounded stable environment is a countermodel.
- **Every persistent configuration must finance itself internally:** an externally supported dependent unit is a countermodel unless the focal boundary is explicitly enlarged.
- **Every part must survive for the whole to persist:** replaceable parts refute this unless identity has been defined to require their continued individual existence.
- **Positive final payoff is sufficient for persistence:** a run that exhausts its reserve before later gains arrive refutes it.
- **Successful feedback requires subjective agency or a self-model:** none of the ledger recurrences requires either.

If “support,” “resource,” “learning” or “network” can always be redefined after the fact to exclude these cases, the broader statement has no declared counterexample. That version is not yet a scientific conjecture.

### 3.3 What the conjecture must not claim

**Persistence is not goodness.** An exploitative institution can persist by transferring costs to others or choosing a narrow boundary. A beneficial institution can disappear. The power, discount and commons modules themselves prevent a simple theorem that persistence selects justice. A requirement that every person's interests count is an additional value commitment.

**No aims or values are supplied.** D7 separates claims about dependence and distribution from rights and what is owed. D11 explicitly distinguishes self-knowledge from alignment: facts about dependence do not settle an aim. Transmission of a self-model is not transmission of an objectively compulsory goal. In this report, choosing which organization, service or persons must continue is an explicit input. It is not inferred from their capacity to persist. [R4]

**No explanation of felt ownership is supplied.** The supplementary D15 distinguishes the causal force of a possible action from why a commitment is experienced as one's own. An unused exit can affect an offer under a response rule; this gives no account of phenomenal ownership, consciousness or responsibility. [R5]

**No definitional finding is promoted to empirical evidence.** The equivalence between nonnegative slack and `InternallyViableAt` is true by its definitions. “The successful response was validated” is equally uninformative if validation means eventual success. The operational test, response criteria, resource measurements and error tolerance must be specified independently.

**No maximization principle is implied.** The conjecture requires enough response capacity in time. It does not require maximum learning, maximum slack, maximum exploration, minimum entropy production, a rising frontier, or an ever-growing commons.

## Part 4 — Primary literature and the Existence First lineage

Each quotation below is short and located. The comparisons concern what the original sources actually state; they do not count the repository's related-work list as confirmation.

### 4.1 Aubin: viability theory

Aubin's survey describes viability in terms of “solutions satisfying at each instant given state constraints” (1990, abstract). The framework studies constrained evolution and controlled invariance. [1]

This is the nearest mathematical neighbour. Once EbE's resources, environment, allowed controls and safe set are fixed, asking whether some control can keep the system within them is a viability problem. The distinction between actual survival, an available viable trajectory, and one causal policy robust to disturbances must be made within that problem.

EbE adds a proposed interpretation of resources, relational support, retained construction and reinvested slack. It has not yet shown that this interpretation yields a new general viability theorem. “Persistence requires staying viable” is a restatement if viability is defined as persistence. The empirical content must instead lie in a measured model predicting independent operational outcomes. The accessible publisher abstract was checked; this report does not claim a proof audit of Aubin's full survey or books.

### 4.2 Maturana and Varela: autopoiesis

Varela, Maturana and Uribe write that “reproduction and evolution are not constitutive features of the living organization” (1974, p. 187). Their definition concerns a network of component-producing processes that continuously realizes its organization as a unity (§3, p. 188). [2]

This anticipates the distinction between organizational persistence and evolutionary change. EbE's maintenance and relational support have substantial overlap with this organization-centred approach. EbE is broader in allowing nonliving systems, externally supported parts and an explicit resource/search budget. Those are modelling extensions, not evidence that all persistence is autopoietic or requires an improving vortex.

A supported role need not produce all the components that maintain it. Therefore, autopoiesis should not be inserted as a hidden necessary premise of the proposed conjecture. Conversely, the existence of an accounting surplus alone does not establish autopoietic organization.

### 4.3 Prigogine: dissipative structures

Prigogine describes a sustained convective pattern as “a giant fluctuation stabilized by exchanges of energy with the outside world” (1977 Nobel lecture, p. 267). His introduction distinguishes equilibrium structures such as crystals from the non-equilibrium order under discussion (p. 263). [3]

The dependence of some organized patterns on maintained boundary conditions and throughput is therefore not new to EbE. Neither is it a law that every object needs an ongoing maintenance gradient. A dissipative structure can be maintained without an expanding learned repertoire.

EbE's ledger is much less physically specific than thermodynamics: resource units, upkeep and retained search capacity are not automatically entropy production, exergy or thermodynamic free energy. A physical application must supply those mappings and conversion efficiencies. The positive-feedback and search arguments are additional model claims; they do not follow merely from the second law.

### 4.4 Ashby: requisite variety

Ashby's formulation is “only variety in R can force down the variety due to D” (1956, §11/7, p. 207). The accompanying argument bounds outcome variety in terms of disturbance and regulator variety under the specified regulation setup. [4]

EbE's need for a sufficient response repertoire under a changing world is closely related. A fixed controller can already have enough variety for its disturbance class; learning is required only if the available repertoire is insufficient and can be expanded usefully. Buffers and disturbance attenuation can also change the regulation problem.

EbE's promising extension is explicit affordability, retention and response latency: a theoretically suitable action is ineffective if it cannot be paid for or arrives after a failure deadline. This report does not establish that the combination is novel across control theory. An originality claim requires comparison with the wider literature on constrained and resource-limited control.

### 4.5 Conant and Ashby: the good-regulator theorem

The theorem begins with “The simplest optimal regulator R of a reguland S” (1970, §4, theorem; PDF p. 8). Optimality there minimizes outcome entropy in a defined probabilistic regulatory setup, and a mapping relates regulator events to reguland events. [5]

That is more qualified than saying every persistent system must contain an explicit internal world model. The paper's assumptions and notion of a model do not establish reflective self-description, semantic understanding or consciousness. The restriction to simplest optimal regulators also matters.

EbE's intelligence specializations can be compared with this result, but its resource ledger does not independently prove a universal modelling requirement. D11's transmission of a self-model is a further issue. Adding paid observation, storage and correction would be a useful resource-sensitive specialization; it would not by itself convert a regulator theorem into an existence law.

### 4.6 Friston: the free-energy principle

Friston calls variational free energy “an information theoretic quantity (like surprise), as opposed to a thermodynamic quantity” (2010, PDF p. 2, §“The free-energy principle”). [6]

The paper links maintaining characteristic states to action, perception and probabilistic models. This overlaps with EbE's interest in continued organization and feedback. The formal objects differ: a variational bound on surprise is not a resource stock or captured-throughput-minus-upkeep ledger.

The proposed conjecture does not require every persistent unit to minimize a stated variational objective or perform Bayesian inference. EbE would need explicit probabilistic assumptions and a mapping between costs, state distributions and inference to claim equivalence. Without that work, calling the frameworks the same is unsupported; calling EbE a replacement is equally unsupported. The present comparison is to this 2010 primary formulation, not an exhaustive assessment of later versions of the principle.

### 4.7 Kauffman: the adjacent possible

In his own account, Kauffman writes: “By doing so they increase the diversity of what can happen next” (2003, concluding paragraph on expansion into the adjacent possible). [7]

The closeness to retained intermediates opening new possibilities is direct. EbE's `GenerativeClosure` and second-order accessibility results offer precise finite-model versions of that idea. Its finite-closure saturation and envelope-capacity results also clarify a limit on indefinitely distinct novelty.

The potentially useful addition is a machine-checkable distinction between finding another target in an existing possibility set and changing what can subsequently be generated, together with paid retention. These results do not establish a universal tendency to maximize exploration, and they do not make growing the adjacent possible necessary for ordinary persistence. Kauffman's original framing should be acknowledged rather than presented as an EbE discovery. The source checked here is his authorial account, not a complete verification of the 2000 book.

### 4.8 Ostrom: commons design principles

Ostrom describes “factors that affect the probability of long term survival” (2010, §IV.E, p. 653). Her discussion covers boundaries, local fit, collective choice, accountable monitoring, graduated sanctions, conflict resolution, recognition of organizing rights and nested governance. [8]

This is a contextual, empirically informed account of robust institutions, not a universal theorem that one governance checklist is necessary and sufficient. EbE's simple sanction, detection, capture and distribution inequalities illuminate selected incentive mechanisms. They do not reproduce the empirical breadth or institutional detail of Ostrom's work.

EbE's useful mathematical contribution here is explicit accounting for when a purported self-interest argument fails: discounting, taker numbers and weak detection can favour capture. A theorem assuming a sanction cannot explain how legitimate rules and enforcement arise. Calling the commons “the vortex of the whole” adds a proposed organizing description; it does not establish those institutional mechanisms.

### 4.9 The repository's Existence First lineage

Appendix26 makes the maintained conditions of intelligence and learning central, while explicitly selecting an aim and constraints. Appendices30 and31 develop rising safe sets, barrier checks, viability kernels, distributed monitoring, capture resistance and a self-aware commitment to maintaining the learning loop. These are antecedents of the present proposal, not independent corroboration. [R6]

Their broad necessity claims and ethical conclusions should not be imported into the current Lean results. The phrase “distributed, heterogeneous monitoring is structurally necessary” in Appendix31 (§“Foundational Derivation,” C2) goes beyond a conditional sufficiency argument about a chosen architecture. Even a correct sufficiency theorem cannot establish that all other architectures fail.

More seriously, several mathematical statements in these appendices do not hold as written. The following are counterexamples to stated claims or gaps in stated inferences, **not** counterexamples to the current Lean modules:

| Location and claim | Concrete problem | Required repair |
|---|---|---|
| Appendix31, Definition `def:kcover`: \(L\leq k_{\min}\) | With two substrates and one monitor \(O(x_1,x_2)=x_1+x_2\), both partial derivatives are nonzero. The stated sensitivity definition gives a one-monitor cover: \(k_{\min}=1<L=2\). Sensitivity also does not imply the ability to certify each substrate separately. | Define coverage as valid certification of the relevant predicates; do not assume at least one distinct monitor per substrate unless that is an additional restriction. |
| Appendix31, inequality in Definition `def:barrier_monitor` | For \(x=(0,1)\), \(O(x)=x_1\), \(h(x)=x_2\), zero observation error, and state space \([0,1]\times[-1,1]\), the infimum over observation-compatible states is −1 while \(h(x)=1\). A state-space Lipschitz constant does not bound variation along an unobserved fibre by observation error. | Add a justified bound on the barrier variation within each observation fibre. The weaker soundness fact—nonnegative infimum implies the true compatible state is safe—can remain valid. |
| Appendix30, Theorem `thm:forward_inv`, proof step from existence to execution; Appendix31, execution rule H1 | Current-state approval is not an action safety certificate. At safe state \(x=1\), a safe action \(a=0\) may exist, yet executing \(a=-2\) in \(x'=x+a\) gives \(x'=-1\). The approval of the current state does not prevent this. | Require the **actual executed action** to satisfy a robust next-state certificate; specify the safe fallback when approval is absent. |
| Appendices30/31, constructive feasibility from control Lipschitz constants | A bound \(\lvert\Delta h\rvert\leq L^{(a)}\lvert\Delta a\rvert\) is an upper bound on effect, not a guarantee of a beneficial effect. Several barriers may require incompatible actions. | Establish a reachable beneficial change and one common feasible action satisfying all barriers against the declared disturbances. |
| Appendices30/31, kernel ratchet | A nonempty smaller kernel need not contain the present state. With \(x'=x\), old kernel \([0,2]\), new kernel \([1,2]\), and actual state 0, shrinking to the new kernel is infeasible despite nonemptiness. | Certify present-state membership or a feasible transition into the new kernel before raising the floor. |
| Appendix31, Theorem `thm:capture`; Appendix30, emergence theorem part B | Two monitors each cover one substrate; \(k_{\min}=2\); false approval costs one per monitor. If only the first substrate fails, the second monitor honestly approves. Capturing only the first costs one, below the asserted lower bound two. | Count required false approvals for the particular violated constraints. Total cover size is not the number of monitors that must be bribed. |

Appendix30's proposed multiplicative viability index also does not become zero merely when one positive substrate falls below a positive floor: a ratio of \(0.5/1\) is still positive. Appendix31's more cautious treatment of the index as a heuristic does not repair every earlier theorem. The later `HealthProfile` results support reporting a profile and testing any aggregation rule.

I did not verify the appendices' concentration bounds or claimed evolutionary global-attractor result. In particular, the stated pairwise-correlation condition needs a proper derivation of the claimed probability bound, and a selection argument needs explicit support/variation assumptions. They should not be used as established premises here.

The constructive part of the lineage is the insistence on non-substitutable maintained conditions, feasible correction and explicit support for the learning process. The required revision is to separate those conditional engineering ideas from universal necessity and from the selection of an ethic.

### 4.10 What, if anything, is new?

The ledger alone, viability under constraints, dependence on maintained flows, requisite response variety, and resource-sensitive cooperation are not new general principles. The current repository's distinctive contribution is its **particular formal decomposition**: maintenance finances responses; retained construction can alter future generability; relations and commons can finance or destroy that process; distribution and option value complicate aggregate assessments.

That decomposition may prove useful. This review did not find a demonstrated new cross-substrate law of persistence, and it did not conduct the exhaustive literature search needed to establish priority for the combined architecture. The most credible next contribution would be a compositional theorem with realistic constraints plus a prospective prediction that improves on a simpler viability or reliability model.

## Part 5 — Lean sketch and the first provable step

### 5.1 What the supplied file says

The companion `ExistenceConjecture.lean` is a standalone core-Lean sketch with no imports, no additional axioms and no admitted proof. It defines finite observation/action/resource types, a causal observation-history policy, a capped vector ledger, physical action restrictions and an independent operational predicate.

The central statement is a **definition of a proposition**, not a theorem:

```lean
def ExistenceConjecture {W O A K : Nat} (m : Ledger W O A K)
    (admissible : Course W → Prop)
    (observed : Policy O A → Course W → Nat → Prop)
    (T : Nat) : Prop :=
  ∀ p, RobustOperational admissible observed p T →
    RobustFeasible m admissible p T
```

Here `Policy O A = List (Fin O) → Fin A`, `Course W = Nat → Fin W`, and `RobustFeasible` quantifies `LedgerSafe` over every admissible course. `LedgerSafe` checks each resource at every prefix and the allowed-action relation at each transition. `RobustOperational` checks `observed` at every prefix for the same policy and courses.

The registration requires `WellFormed m`, a nonempty admissible class, a nonzero horizon, independently calibrated functions and an independent `observed` predicate. `WellFormed` checks only elementary signs and initial bounds. It does **not** certify calibration, causal adequacy, transfer conservation or the completeness of the boundary. Those must not be hidden as fields that assume the conjecture itself.

The code is polymorphic over the finite alphabet sizes; it does not assert the proposition for every arbitrary ledger. A mathematical proof cannot establish its empirical interpretation without independently justified linking assumptions. Defining `observed` as `LedgerSafe` would turn the proposition into a tautology and remove its intended content.

**Verification status:** the sketch was inspected but not elaborated by Lean. The downloaded repository-matching Lean 4.33.0 executable could not start because its process executable-path lookup was denied in this environment. The report therefore makes no compilation claim. The core repository also depends on Mathlib and was not rebuilt here.

### 5.2 Which existing results would connect?

The closest formal adapters are:

1. `AdaptivePersistence.reserve`: the one-coordinate version of the capped trajectory. Its deficit-window bound is the immediate basis for a response deadline.
2. `CareTransfer.carerReserve`: uncapped constant net rate \(s+r-c\). For a finite horizon, choose a cap high enough never to bind. Its dimensionwise theorem supplies the resource-vector interpretation.
3. `NetworkVortexLedger.internalSlack_eq_sum_partSlack`: conservation for a single fungible resource, before adding route constraints and costs. Its existential transfer theorem is the fully connected, unrestricted, instantaneous special case.
4. `ListeningCost.total`: the sum of specified fit/misfit gains minus the per-step observation expense. To obtain persistence, all prefix sums must be checked, not just the terminal comparison.
5. `CuriosityValue.reserveWith`: one up-front exploration cost and a retained constant saving. These can become entries in `responseCost` and `upkeep` along the history.
6. `ResponseDynamics` and `DynamicVortex`: an action can be a candidate construction; the allowed-action relation can require available parents and validation; later uptake/costs can change after retention. An adapter would have to show that the retained object really changes those functions.

These are proposed reductions, not already-written Lean equivalences. None turns the empirical conjecture into a corollary. `ExitOption` changes the response or transfer rule through another agent's incentives; it requires an additional interaction model. `HealthProfile` constrains measurement choices rather than supplying a dynamics adapter.

### 5.3 First provable step

Prove a **vector, finite-horizon deficit-window lemma** for the combined ledger:

\[
\begin{aligned}
&b_j(t_0)\leq B,\qquad
\forall k<L,\;s_j(t_0+k)\leq-\delta\\
&\hspace{1cm}\Longrightarrow\quad
b_j(t_0+L)\leq B-L\delta.
\end{aligned}
\]

The proof is induction on \(L\). Each capped update is at most the uncapped value; add the next deficit inequality. If \(L\delta>B\), nonnegative reserves at all prefixes are impossible. This generalizes the existing scalar argument rather than claiming a new mathematical discovery.

Next, prove the causal obstruction: if two admissible courses give identical observation histories until a decision deadline, the deterministic policy chooses the same action there. If the ledger-safe action sets are disjoint and no later recovery can meet the deadline, no single policy is robustly feasible for both. This closes a meaningful gap between a list of successful world-indexed responses and a controller that can actually choose one.

Only after these steps should the network/commons/care adapters be composed. The first empirical task is then to test whether the calculated deadline predicts independent functional failure. That is where the existence conjecture gains or loses support.

## Part 6 — Assessment and the narrower claim to defend

**The theory is ready to state a research conjecture, but not to announce the requested all-substrate existence law.** The repository contains useful conditional mathematics, several explicit limitations and counterexamples to simplistic self-interest stories. Its present results do not make learning, intelligence, distributed monitoring or continual emergence necessary for all persistence.

The narrower claim I would defend is the **prospective maintenance–response deadline claim** within one well-measured class of maintained systems: given independently measured usable buffers, deficit rates, transfer limits and response delays, continuing operation requires a causally available response before a predicted indispensable-resource deficit exceeds its buffer. This is the displayed conjecture instantiated with a small, testable challenge class. Its scientific risk is a successful run on the forbidden side of the preregistered boundary.

The most useful sequence of work is:

1. Repair or withdraw the specific appendix claims identified above, and distinguish historical prose theorems from the current checked development.
2. Combine vector reserves, realistic transfers, commons stocks and response costs in one finite-horizon model. Preserve the distinction between observed organization and accounting viability.
3. Make the information structure explicit. Require feasible actions selected from available observations, not a separate fortunate response for each world.
4. Prove the deadline and indistinguishability lemmas, then adapt the care, listening and retained-saving examples. Do not make every model feature obligatory.
5. Run a prospective challenge experiment with fixed boundary, independent outcome measurements and a simpler baseline. Test whether added network or retained-option structure improves forecasts beyond an ordinary resource/reliability model.

A convenient starting system would have instrumentable storage, controlled disturbances and adjustable response delay. The experiment should cross the predicted buffer/deficit boundary in both directions. Success on the feasible side is encouraging but does not establish sufficiency; systematic success on the predicted impossible side rejects the registered necessity model.

The outcome could still be scientifically useful if EbE proves to be a unifying modelling vocabulary rather than a new law. The distinction must remain visible. Renaming viability, adaptation or investment as “existence by emergence” is not itself an explanatory advance.

## Part 7 — What could not be verified

- **A real-world persistence law:** no independent dataset or prospective intervention was assessed. Repository examples and reported trials were not treated as validation. The excluded `experiments/` material was not accessed.
- **A complete rebuild of the formalization:** source statements, definitions and relevant proof bodies were read. The repository's machine-checking claims and axiom-reporting entry point were inspected, but the whole project was not compiled and CI was not independently reproduced. The new Lean sketch is also uncompiled for the runtime reason stated in Part 5.
- **Merged status of the requested exit material:** it was absent from the pinned main revision and assessed at PR #102's separate pinned head. This report does not imply that PR was merged or checked together with the pinned core.
- **Every imported theorem at proof-audit depth:** the proof map summarizes the named results and their material premises. It is not a line-by-line independent audit of every imported dependency or the Lean kernel.
- **An existing unified model:** no current theorem was found connecting the full node/relations/commons/vector-resource/causal-controller system to independent observed persistence.
- **Appendix empirical reports and remaining mathematical claims:** the stated ablations, probability concentration bounds, evolutionary-attractor argument and capture-amplification conjecture were not independently reproduced or established. Specific counterexamples above suffice to prevent treating the appendices as a proved foundation.
- **All original books in full:** Aubin's publisher abstract, the 1974 autopoiesis article, Prigogine's Nobel lecture, Ashby's relevant chapter, Conant and Ashby's article, Friston's 2010 article, Kauffman's own 2003 account and Ostrom's 2010 article were checked. This is not a full reading of Aubin's books, Maturana and Varela's later books, Kauffman's *Investigations*, or Ostrom's complete corpus.
- **Priority of the synthesis:** the named neighbours were assessed, not the entire literature on robust control, model predictive control, network flow, reliability, adaptive control or evolutionary theory. A claim of unique novelty remains unverified.
- **Normative and phenomenological conclusions:** the evidence assessed cannot determine what ought to persist, whose interests count, the aims an agent should adopt, or why a commitment feels like its own.

## Sources and locations

### Primary literature

**[1]** Jean-Pierre Aubin (1990), “A Survey of Viability Theory,” *SIAM Journal on Control and Optimization* 28(4), 749–788. DOI: [10.1137/0328044](https://doi.org/10.1137/0328044). [Publisher abstract](https://epubs.siam.org/doi/10.1137/0328044). Quotation and limited source verification: abstract.

**[2]** Francisco G. Varela, Humberto R. Maturana and R. Uribe (1974), “Autopoiesis: The Organization of Living Systems, Its Characterization and a Model,” *BioSystems* 5, 187–196. DOI: [10.1016/0303-2647(74)90031-8](https://doi.org/10.1016/0303-2647(74)90031-8). [Article scan](https://users.sussex.ac.uk/~inmanh/adsys10/Readings/Varela_etal_-_1974_-_Autopoiesis_the_organization_of_the_living_characterization_n_model_-_Biosystems.pdf). Locations: pp. 187–188, introduction and §3.

**[3]** Ilya Prigogine (1977), “Time, Structure and Fluctuations,” Nobel Lecture, 8 December 1977. [Lecture PDF, University of Texas physics-history archive](https://utphysicshistory.net/Images/Ilya_Prigogine_files/prigogine-lecture.pdf). Locations: pp. 263, 265–267; PDF pp. 1, 3–5. The quotation is on printed p. 267.

**[4]** W. Ross Ashby (1956), *An Introduction to Cybernetics*, Chapman & Hall. [Primary text PDF](https://ashby.info/Ashby-Introduction-to-Cybernetics.pdf). Location: §11/7, printed p. 207; PDF p. 110 in the two-page-per-sheet scan.

**[5]** Roger C. Conant and W. Ross Ashby (1970), “Every Good Regulator of a System Must Be a Model of That System,” *International Journal of Systems Science* 1(2), 89–97. DOI: [10.1080/00207727008920220](https://doi.org/10.1080/00207727008920220). [Full-text transcription](https://pespmc1.vub.ac.be/books/Conant_Ashby.pdf). Location: §4, theorem and interpretation, PDF p. 8; preceding regulatory setup and proof assumptions.

**[6]** Karl Friston (2010), “The Free-Energy Principle: A Unified Brain Theory?”, *Nature Reviews Neuroscience* 11, 127–138. DOI: [10.1038/nrn2787](https://doi.org/10.1038/nrn2787). [Author-hosted article PDF](https://www.fil.ion.ucl.ac.uk/~karl/NRN.pdf). Location: PDF pp. 1–2, especially §“The free-energy principle,” p. 2. Line-break hyphenation in the short quotation has been normalized.

**[7]** Stuart A. Kauffman (2003), “The Adjacent Possible,” *Edge*, 9 November 2003. [Author's account](https://www.edge.org/conversation/stuart_a_kauffman-the-adjacent-possible). Location: concluding paragraph discussing expansion into the adjacent possible. This is a primary authorial exposition, not a peer-reviewed confirmation of the proposed law.

**[8]** Elinor Ostrom (2010), “Beyond Markets and States: Polycentric Governance of Complex Economic Systems,” *American Economic Review* 100(3), 641–672. DOI: [10.1257/aer.100.3.641](https://doi.org/10.1257/aer.100.3.641). [Article PDF](https://web.pdx.edu/~nwallace/EHP/OstromPolyGov.pdf). Location: §IV.E, pp. 652–653, especially the paragraph following the design principles on p. 653.

### Repository sources assessed, not evidence of empirical validity

**[R1]** [CORE.md at the assessed main commit](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/30ae50cfbf8def6c1afbaa276c5647bc879010de/CORE.md), especially “The story in eight steps,” “Where each step is proved,” “What this page does and does not claim,” and “Related work.” The proof table links the exact modules named in Part 2.

**[R2]** [EbECore.lean](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/30ae50cfbf8def6c1afbaa276c5647bc879010de/formalization/ebe-core/EbECore.lean): imports, theorem checks and axiom reports. [Toolchain](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/30ae50cfbf8def6c1afbaa276c5647bc879010de/formalization/ebe-core/lean-toolchain) and [Lake configuration](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/30ae50cfbf8def6c1afbaa276c5647bc879010de/formalization/ebe-core/lakefile.toml).

**[R3]** [CumulativeAccessibility modules](https://github.com/albertjanvanhoek/Evolution-by-Emergence/tree/30ae50cfbf8def6c1afbaa276c5647bc879010de/formalization/cumulative-accessibility/CumulativeAccessibility), including [CareTransfer](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/30ae50cfbf8def6c1afbaa276c5647bc879010de/formalization/cumulative-accessibility/CumulativeAccessibility/CareTransfer.lean), [PowerDistribution](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/30ae50cfbf8def6c1afbaa276c5647bc879010de/formalization/cumulative-accessibility/CumulativeAccessibility/PowerDistribution.lean), [CuriosityValue](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/30ae50cfbf8def6c1afbaa276c5647bc879010de/formalization/cumulative-accessibility/CumulativeAccessibility/CuriosityValue.lean), and [HealthProfile](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/30ae50cfbf8def6c1afbaa276c5647bc879010de/formalization/cumulative-accessibility/CumulativeAccessibility/HealthProfile.lean).

**[R4]** [PREDICTIONS.md](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/30ae50cfbf8def6c1afbaa276c5647bc879010de/PREDICTIONS.md) and [DIALOGUE.md](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/30ae50cfbf8def6c1afbaa276c5647bc879010de/DIALOGUE.md), especially D7, D11, D12 and D14. PREDICTIONS' methodological cautions about prospective specification and survivorship are relevant to the testing proposed here.

**[R5]** Supplementary [PR #102](https://github.com/albertjanvanhoek/Evolution-by-Emergence/pull/102), assessed at commit `ad4cf01c415b75d0fb2f76359f18a3ed86d5eb6c`: [ExitOption.lean](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/ad4cf01c415b75d0fb2f76359f18a3ed86d5eb6c/formalization/cumulative-accessibility/CumulativeAccessibility/ExitOption.lean) and [DIALOGUE.md, D15](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/ad4cf01c415b75d0fb2f76359f18a3ed86d5eb6c/DIALOGUE.md).

**[R6]** [Appendix26.tex](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/30ae50cfbf8def6c1afbaa276c5647bc879010de/Backmatter/Appendix26.tex), [Appendix30.tex](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/30ae50cfbf8def6c1afbaa276c5647bc879010de/Backmatter/Appendix30.tex), and [Appendix31.tex](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/30ae50cfbf8def6c1afbaa276c5647bc879010de/Backmatter/Appendix31.tex). TeX labels in Part 4 identify the claims under assessment; section names and nearby text distinguish similarly named claims across the two later appendices.
