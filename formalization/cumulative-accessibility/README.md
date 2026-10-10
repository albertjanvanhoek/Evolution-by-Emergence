# Cumulative Accessibility

> **v20 peer-review surface:** this package contains the canonical machine-checked
> retained-organization, transition-accessibility, emergence-barrier, resource,
> and generative-leverage results offered for independent review.

## Retained-organization verification spine

The current substrate-agnostic centre is expressed as

[
S_t=(G_t,R_t,Gamma_t,B_t^{\mathrm{gross}}),
qquad
B_t^{\mathrm{free}}=B_t^{\mathrm{gross}}-M(R_t),
]

with abstract transition machinery (mathcal K), graded finite-horizon
accessibility (mathcal A_T), explicit retain/ablate counterfactuals for one
retained item (X), paid maintenance, later ablation-based reuse, and transfer
to an unvisited target.

### Resource-constrained recursive loop

The retained-organization core should be read as a recursive loop rather than
only as the one-way relation `R -> K -> A`. Retained history has two
simultaneous effects:

1. **causal leverage:** retained organization can change transition machinery
   and therefore future accessibility;
2. **maintenance burden:** retained organization consumes part of the resource
   budget needed for later maintenance, response, search, and change.

A compact schematic is:

```text
generated organization
        ↓
budget-constrained retention
        ↓
R_t ─────────────→ K_t ─────────────→ A_t
 │                                      │
 └─ maintenance M(R_t)                  │
        ↓                               │
B_free = B_gross - M(R_t) ─────────────┘
        ↑
        └──────── next retained organization ────────
```

The finite-budget theorem in `GenerativeLeverage.lean` makes one implication
explicit. If every member of a candidate retained set costs at least
`mu > 0` to maintain and

[
B < |C| mu,
]

then the whole candidate set cannot satisfy the maintenance budget. Finite
resources therefore force a **retention trade-off**. The theorem deliberately
does not specify which structure is forgotten, replaced, compressed, made
cheaper, or retained; those mechanisms remain application-specific.

This recursive architecture motivates a scale-free **learning-like** reading.
At different nested levels, prior interaction can leave retained organization
that alters subsequent transition possibilities while finite resources prevent
indiscriminate retention. Neural learning is one instance, but the universal
claim under investigation is not that cells, organisms, people, and societies
all literally learn in the same psychological sense. It is that they may
instantiate the same abstract history-retention-accessibility dynamic. Whether
that mapping is non-arbitrary is an empirical challenge for each domain.

The current Lean files include:

- `RetainedOrganizationCore.lean` — item-specific retained/ablated arms,
  positive marginal upkeep, monotone budget semantics, causal reuse, paid
  transfer to unvisited targets, and regression guards against two false
  certificates found during adversarial review;
- `PaidRetentionTransfer.lean` — lower-is-better cost specialization and
  single-entry upkeep bookkeeping;
- `PaidReuseHierarchy.lean` — one-level repetition threshold and single-use
  no-go;
- `RepetitionDepth.lean` — nonseparable arbitrary-objective RD0–RD2 theorem:
  if actual marginal objective changes obey the declared repeated-use formula
  and worst-case structural bounds, any global minimizer retains every level;
- `EmergentPaidTransfer.lean` — optional Law-D feedback in which the same
  retained item is also the configuration tested for compositional emergence;
- `TransitionAccessibility.lean` — canonical publication-facing transition semantics: kernel-induced accessibility, necessary kernel advantage for paid opening, quantitative route-saving sufficiency, and the bridge back into the abstract core accessibility interface;
- `EmergentAssemblyBarrier.lean` — abstract emergence barrier and auxiliary-support theorem;
- `TransitionMediatedEmergence.lean` — mechanistic specialization deriving the emergence barrier through transition machinery, with non-vacuity and drop-one-premise countermodels;
- `GenerativeLeverage.lean` — bounded-reuse and resource-normalized leverage constraints, including a finite-budget no-go for retaining an overfull positive-cost candidate set;
- `V17Compatibility.lean` — reuses compatible v17 lemmas without making v17
  recurrence/successor premises the new core;
- `LearningConstitutionSpecialization.lean` — downstream intelligent-network
  specialization only.

### Compression / reuse test

A retained representational scaffold is not explanatory merely because a free
"saving" parameter is assigned to it. A mechanism must produce a paid
advantage. Repetition/shared use supplies one checked mechanism:

[
(n-1)c>nr+h.
]

For the deeper theorem, the global objective is no longer assumed separable:
the actual marginal effect of adding an omitted module may depend on the rest of
the retained dictionary. The theorem still requires an application to justify
the structural lower bounds on exposed occurrence count and inline cost.

### Pre-statability boundary

The current formalization uses fixed ambient Lean types for states,
organizations, candidates, and targets. It can represent an expanding set of
visited/accessible values inside those types. It does **not** prove strong
creation of previously unstatable observables, type systems, or ontologies in
the Kauffman/Longo sense.

Claims about vocabulary emergence or changing phase spaces must therefore be
phrased as representational/model extensions unless a stronger formal layer is
introduced.

Lean Verification

Machine-checked formalization for the cumulative-accessibility and formal-core results in **Evolution by Emergence**.

The package separates five questions that are easy to collapse informally:

1. **Can an organization persist?**
2. **Can it generate an internally usable response budget from an external gradient?**
3. **Can new organization continue to be realized, validated, and retained?**
4. **Can retained organizational change alter what becomes accessible next?**
5. **What capacity conditions are necessary for that recursive process to remain open-ended?**

For the candidate v17 recursive-organization theory, start with [`../../THEORY_CORE_V17.md`](../../THEORY_CORE_V17.md) and [`../../FORMAL_THEORY_MAP.md`](../../FORMAL_THEORY_MAP.md). [`../../DYNAMIC_OVERVIEW.md`](../../DYNAMIC_OVERVIEW.md) documents the complementary v16 maintenance/resource-response integration.

The candidate v17 recursive spine is:

```text
generated / constructed candidate
    -> compositional emergence
    -> resource + validation + retention filters
    -> operational primitive
    -> later parent reuse / changed generability
    -> finite admission to local search
    -> full recursive successor
    -> operational or historical cumulative novelty
```

The package also retains the v16 maintenance/resource-response route as a complementary supporting layer. That route keeps maintenance support, opportunity, internally generated resource slack, response delay, retention, and representation separate:

```text
external gradient G_t
        +
organization-dependent uptake U(s_t,G_t)
        -
maintenance demand M(s_t)
                ↓
internal slack L_t
                ↓  reinvestment beta_t
endogenous response budget B_t^resp

nonnegative three-cycle dynamics + positive canonical support vector
+ non-strict closed-loop replacement threshold
                ↓
persistent quantitative support
                +
declared support → opportunity connection
                ↓
recurring opportunity Q

Q + internally financed validated response within lag Δ
                ↓
recurrent validated response within lag Δ
                ↓
validated generative uptake G

retention R + G
                ↓
open-ended cumulative retained novelty N

representation P + retention R + N
                ↓
unbounded effective distinguishability capacity C
```

The external gradient remains a boundary condition; the **usable response budget is endogenous to organization**. At fixed gradient, increasing uptake and/or reducing maintenance demand cannot reduce internal slack, and a nonnegative reinvestment coupling therefore cannot reduce response budget.

The earlier same-time predicate `W` remains exactly the `Δ = 0` special case. The exact shared-budget cumulative-accessibility margin `M=B/c*-1` is also connected to the response interface as a separate mechanism-level specialization; it is not identified with physical free-energy slack.

This supporting resource chain is conditional mathematics. It is **not** the v17 recursive-emergence master theorem, and it does not claim that persistence or resource slack automatically creates a validated recursive successor.


## Candidate universal theorem layer

See [UNIVERSAL_LAW_CANDIDATE.md](UNIVERSAL_LAW_CANDIDATE.md) for the current
scientific interpretation, prior-art guardrails, failure modes, and criteria
for eventually using the word "universal".


The post-v19 branch now separates the paid-transfer instrument from three
candidate substrate-agnostic consequences.

### 1. Transition machinery induces accessibility

`TransitionAccessibility.lean` defines a weighted transition kernel and derives
finite-horizon budget accessibility from actual kernel-generated routes.

The central theorem is:

[
mathcal K^+ preceq mathcal K^-
quadLongrightarrowquad
mathcal A_T^{mathcal K^-}(B)
subseteq
mathcal A_T^{mathcal K^+}(B),
]

where dominance means every old transition remains available and no old
transition becomes more costly.

Maintenance is then subtracted from the same gross budget. A regression theorem
proves that if retained and ablated organization induce the same kernel while
retention costs at least as much, retention cannot create a paid opening.

A fully constructive retained-kernel witness is included as well: without the
retained item the toy kernel has no route to the target; retaining the item adds
a one-step route of cost one, itself costs one unit to maintain, and at gross
budget two Lean derives a positive item-specific paid opening.

### 2. Emergent assembly barrier

`EmergentAssemblyBarrier.lean` gives strict compositional emergence an actual
role. If whole (X) realizes target function (phi), no proper
subconfiguration does, target-specific benefit is zero before (phi) is
realized, and retention has positive upkeep, then every proper intermediate has
negative target-financed net value.

Hence a gradual retained path cannot be financed by the future emergent
function alone. If such an intermediate remains viable, Lean proves that some
strictly positive auxiliary support is required. This can represent another
function, reuse/exaptation, subsidy/drift, or another application-specific
source.

### 2b. Transition-mediated emergence specialization

`TransitionMediatedEmergence.lean` connects strict compositional emergence to
the same transition-induced accessibility semantics. If the emergent function
is what opens a transition, a proper subconfiguration does not receive that
function-mediated transition. With non-decreasing upkeep relative to the
ablated arm, it therefore cannot show positive paid opening through that
mechanism.

The module includes permanent QC witnesses: a whole emergent configuration that
does transfer, a non-emergent single-part countermodel, a negative-upkeep
countermodel, and a stepping-stone model in which a proper part pays for itself
through a different transition.

### 3. Bounded-memory generative leverage

`GenerativeLeverage.lean` operationalizes bounded reuse using an injective
encoding of accessible targets by one retained unit and one of at most (d)
support slots.

It proves

[
|mathcal A| le |R|d.
]

Therefore a uniform retained-cardinality bound (N) and a uniform per-unit
reuse bound (d) rule out unbounded accessible repertoire. If accessibility
exceeds (Nd), then at least one of those restrictions fails: retained
repertoire grows, per-unit leverage grows, or accessibility depends on
compositional support that cannot be reduced to one retained unit/slot pair.

The same resource accounting now also gives a direct retention constraint. If
every member of a candidate retained set C costs at least mu > 0 and

[
B < |C| mu,
]

then Lean proves that retaining all of C is budget-infeasible. This is the
minimal formal sense in which finite resources make retention selective: the
constraint forces a trade-off, but it does not impose a universal optimization
rule or identify which candidate should persist.

These are candidate general constraints. They do not yet establish empirical
universality across biological, neural, linguistic, and technological systems.

## Main modules

### Canonical v17 recursive-emergence surface

- `EvolutionByEmergenceV17Core.lean` — canonical v17 operational and historical theorem surface; moving-envelope operational certificate, promotion-driven strengthening, constructive projection, turnover-history endpoint, and fixed-finite boundary.
- `EmergentCapacity.lean` — relative compositional emergence, distinct from historical novelty and surprise.
- `VocabularyEmergence.lean` — operational versus representational vocabulary expansion.
- `EmergencePersistenceBridge.lean` — emergence kept separate from resource feasibility, external validation, and actual retention.
- `RecursiveEmergence.lean` — explicit retained-parent reuse in later generation.
- `ConstructiveRecursiveEmergence.lean` — stronger optional bridge requiring parents to construct the same configuration that witnesses the child's emergent realization.
- `ActiveHistory.lean` — separates current operational repertoire from cumulative historical trace and proves open-ended history under complete active turnover.
- `RecursiveEmergenceOpenEnded.lean` — recurrent recursive events to cumulative retained novelty.
- `EmergenceReproduction.lean` — finite deterministic successor-count specialization and mechanism-ledger calibration seam.
- `LocalEmergenceReproduction.lean` — fixed-global no-go, finite moving local envelopes, corrected locally certified certificate, and non-vacuity witness.
- `EndogenousEnvelopePromotion.lean` — operational promotion, essential-parent generated-access expansion, finite admission, and promotion-driven local successors.

The older `EvolutionByEmergenceCore.lean` remains imported for finite-specialization, calibration, and separation results. Its globally finite master certificate is explicitly proved unsuitable as the canonical indefinitely open-ended universe; use `EvolutionByEmergenceV17Core.lean` for v17 review.

### Accessibility and retained search
- `CumulativeAccessibility.lean` — basic accessibility, preservation, strict expansion, costs, margins, and route-level results.
- `RecursiveAccessibility.lean` — finite search opportunity, retained stepping stones, second-order clicks, and separation of reachable depth from search-operator expansion.
- `QuantitativeAccessibility.lean` — directed accessibility-cost geometry, plasticity/viscosity order, and recovery of a binary second-order click from strict quantitative improvement at a suitable budget.
- `FunctionalRatchetVelocity.lean` — separates organizational states from functional targets, defines functional repertoire, target-wise functional gain and duration/resource-normalized ratchet rates, and connects strict functional cost improvement to thresholded repertoire expansion.
- `RatchetVelocityLedger.lean` — optional mechanism ledger separating opportunity rate, generation, resource feasibility, validation, retention, and mean retained gain; its match to an empirical rate remains an explicit modelling assumption.
- `BoundedUpdateRate.lean` — first derived speed bridge: bounded opportunity gaps plus bounded validated-response lag imply bounded successful-update gaps; maintained three-cycle support yields the zero-opportunity-gap specialization and, with a minimum-gain seam, a functional-gain guarantee in every finite response window.
- `SearchValidationTradeoff.lean` — exact unit-budget search/validation trade-off showing an interior optimum rather than monotonic benefit from more search.
- `StateDependentAllocation.lean` — retained validation infrastructure changes the velocity-maximizing allocation of the next resource unit.
- `BottleneckAllocation.lean` — symmetric inherited search/validation capacities, interior bottleneck equalization, and boundary all-to-bottleneck allocation regimes.
- `IntelligentLearningMaintenance.lean` — separate inside specialization mapping intelligent learning-maintenance process states into the outside geometry, including a matched held-out rate-grounded definition of recursive self-improvement.
- `EvolvabilityStructure.lean` — candidate-set ordering, functional projection, and recombination.
- `GenerativeArity.lean` — finite-parent generators and unary versus multi-parent generation.
- `ModuleGeneratedEvolvability.lean` — search expansion from retained parent material.
- `GeneratorRuleEvolution.lean` — search expansion from changes in the generative rule.
- `GenerativeClosure.lean` — generated intermediates can be retained and reused as future parent material.

A minimal checked example is:

```text
a → b → c
```

where c is unavailable after one retained generative round but becomes available after two once b has been generated and retained.

### Quantitative accessibility and viscosity

QuantitativeAccessibility.lean lifts binary accessibility to a declared
directed cost geometry:

    AccessibilityCost x z = cost of future transition x -> z
    AccessibleWithin Cost B x z := Cost x z <= B

A new condition is **no more viscous** than an old one on a target set when all
declared future costs weakly decrease. It is **strictly less viscous** when at
least one declared target becomes strictly cheaper.

Lean checks:

    strict quantitative cost improvement
            ↓
    some target becomes affordable at a budget where it was previously unaffordable
            ↓
    strict expansion of the budget-thresholded search family

For a single state-dependent cost geometry this yields:

    QuantitativeSecondOrderClick
            ↓
    exists B, SecondOrderClick at budget B

Thus the weighted geometry strictly generalizes the existing binary
second-order-accessibility interface.

FunctionalRatchetVelocity.lean then separates the organizational-state type
from the functional-target type:

    FunctionalCost sigma phi := sigma -> phi -> Real

This allows a network state to be distinguished from what the network can do.
The primitive outside object is a target-indexed functional cost profile rather
than a universal scalar complexity measure. Lean checks:

    strict retained functional cost improvement
            ↓
    positive target-wise functional gain
            ↓
    strict functional-repertoire expansion at some budget

For positive declared duration/resource interval Δ, the gain is normalized into
a functional rate. Matched episodes can therefore be compared even when their
durations differ.

The allocation modules then make one source of non-monotonicity and
state-dependence explicit. Under a shared unit resource, search and validation
cannot both be increased independently. The symmetric reduced model has
`v(x)=x(1-x)`; inherited stage capacities shift the optimizer, and the
two-baseline model proves a classical bottleneck-equalization rule. These are
toy mechanism models, not universal optimization laws.

RatchetVelocityLedger.lean adds the conditional specialization

    v_ledger = opportunityRate
               * pGenerate
               * pResource
               * pValidate
               * pRetain
               * meanGain

with an explicit `VelocityLedgerMatches` predicate separating the measured rate
from the ledger. Lean checks zero-bottleneck and ceteris-paribus monotonicity
results; it does not infer that this product is the correct empirical model in
every domain.

IntelligentLearningMaintenance.lean is deliberately separate. It introduces an
internal process state P, a map from process state to accessibility geometry,
labelled learning verbs, endogenous self-improvement, and recursive
self-improvement. The labels do not carry universal monotonic effects: an
application must justify how its process state changes the external cost
geometry.

The stronger rate-grounded recursive interface starts old and self-modified
learning episodes from the same organization, preserves declared prior
functions, and requires the new process's normalized held-out functional-rate
profile to weakly dominate the old one with at least one strict improvement.

### Finite saturation

`FiniteGenerativeSaturation.lean` proves that a monotonically retained repertoire inside a fixed finite declared distinguishability set cannot strictly expand forever.

For every horizon `N`,

```text
|S_0| + strictExpansionCount(S,N) ≤ |S_N|
```

and therefore, if `S_n ⊆ U` for fixed finite `U`,

```text
strictExpansionCount(S,N) ≤ |U| - |S_0|.
```

Idle periods and changing update rules do not evade this counting bound while the effective distinguishable set remains fixed and finite.

For a fixed deterministic inflationary update closed inside `U`, the retained trajectory reaches a genuine fixed point.

### Open-ended capacity

`OpenEndedCapacity.lean` replaces the fixed finite set by a moving finite envelope `U_t` and defines:

- `OpenEndedCumulativeNovelty`;
- `UnboundedEnvelopeCapacity`.

For retained organization `M_t` represented inside `U_t`, Lean proves:

```text
|M_0| + strictExpansionCount(M,N) ≤ |U_N|.
```

Hence:

```text
open-ended cumulative retained novelty
                ↓
unbounded effective distinguishability capacity
```

The converse is false. The package includes a checked counterexample with an indefinitely growing envelope and a static retained repertoire.

So:

```text
capacity for novelty ≠ realized novelty
```

### Uptake and validation

- `CapacityUptake.lean` — explicit coupling from available capacity and the current generator to retained novelty.
- `CapacitySlack.lean` — a sufficient decomposition using recurring unused capacity plus local generative realization.
- `ValidatedUptake.lean` — adds a declared external acceptance predicate `E_t`.
- `ResponseDynamics.lean` — adds explicit response cost/budget, bounded response delay, and the theorem that recurrent opportunity plus bounded resource-feasible response implies validated uptake.
- `BoundedResponseWitness.lean` — lag-1 even/odd witness and resource-independence counterexamples.
- `EndogenousBudgetBridge.lean` — maps organization-dependent gradient uptake minus maintenance into internally generated response budget; separately maps cumulative-accessibility margin into the same interface within its own units.
- `EndogenousBudgetWitness.lean` — fixed-gradient uptake-improvement witness and exact `2/3 → 97/99` margin-funded response witness.
- `DynamicVortex.lean` — explicit composition interface joining internally funded validated response to second-order organizational/search updates.
- `DynamicVortexWitness.lean` — concrete full-dynamic construction with open-ended retained novelty, unbounded envelope capacity, and recurring second-order updates.
- `NetworkVortexLedger.lean` — splits the vortex slack ledger over the parts of a network and separates creation (more uptake or less maintenance) from transfer (internal flows that sum to zero): transfers cancel in the whole's slack and response budget, decide which parts can cover their maintenance but not the size of the vortex, creation in any part raises the response budget, and a non-viable vortex cannot afford any positive-cost response.
- `PersistenceRequiresVortex.lean` — persistence requires the vortex but does not produce it: in an open-ended world, being ready for every possible kind of situation forces an unbounded retained repertoire, and with positive upkeep per kind and viability at every time, uptake from the gradient must exceed every bound. The existing countermodels show the vortex can still stop. Scope: readiness for every possibility at once is a strong premise that the core does not assume; see `AdaptivePersistence.lean` for what persistence requires in a changing world.
- `CommonsVortex.lean` — the commons as the vortex of the whole. A node creates `c` for the commons, takes back `a` through a return path and spends `m` on upkeep. It lasts and grows while the commons does not lose exactly inside the window `m < a ≤ c` (`grows_with_commons_iff`), which exists exactly when `m < c`; below it a creator starves although the whole gains, above it the node captures. Inside the window a reinvesting node at least doubles each step and the commons gains at least as fast (`positive_loop`); if the return per unit falls with size, growth stops at the capacity where it meets upkeep (`saturation_bounds_growth`). A commons whose regeneration rises with its stock never shrinks while nodes take back no more than they create (`commons_grows_in_window`); if a node takes back more than it creates plus what the commons regenerates, and an empty commons regenerates nothing, the commons is gone by step `s0` for good and the capturer is left with its own creation (`capture_collapses_commons`, `capture_pays_then_fails`). Core Lean only, in whole units, with a witness.
- `Reciprocity.lean` — reciprocal dependence. Two nodes that keep each other going exchange what costs the giver less than it is worth to the receiver. If exchange covers both, both last forever (`exchange_lasts`). If one defects, it is better off in the first step by exactly what it no longer gives (`defection_pays_at_first`), its partner dies if it cannot live alone (`partner_falls`), while its partner still gives, a defector whose receipts cover its shortfall holds its reserve (`defector_holds_while_partner_lives`); and if the defector cannot live alone either, it dies too, within its own reserve after its partner's deadline (`defector_falls_after_partner`). Not covered: partial defection, more than two nodes. Core Lean only, with a witness.
- `ListeningCost.lean` — the cost of listening. `AdaptivePersistence` assumes reliable, costless feedback. Here a listener pays `ℓ` per step and misfits where its feedback misleads; a sealed configuration misfits where the world is outside its fit. Listening does better exactly when the misfits it avoids are worth more than it costs (`listening_pays_iff`); feedback that misleads as often as the world moves never pays (`misleading_feedback_does_not_pay`); a stable world favours sealing (`stable_world_favours_sealing`); listening that costs more than fit gains exhausts any reserve (`unaffordable_listening_fails`). Core Lean only, with a witness.
- `GradedBelief.lean` — corrigible in degrees. A credence weights each world, and evidence multiplies each weight by its likelihood. A zero credence stays zero after any evidence (`zero_credence_is_sealed`, Cromwell's rule); a positive one survives evidence that is possible in its world (`positive_credence_survives`); mixing two credences keeps open what either keeps open (`mix_support`) and keeps the ranking both agree on (`mix_keeps_agreed_ranking`); evidence ranks worlds held equally likely (`evidence_ranks`). Core Lean only, with a witness.
- `ConnectionIndependence.lean` — connection against independence. Correcting a shared blind spot needs a node that is independent and reaches the rest; links spread corrections but pull nodes into line. Neither isolation (`isolation_cannot_correct`) nor conformity (`full_conformity_cannot_correct`) corrects, and the levels of connection that do form an interval (`correcting_levels_form_interval`). Core Lean only, with a witness.
- `PartnerSwitching.lean` — partner switching. A serial defector stops giving, receives until it is found out after `L` steps, then pays `S` and waits `τ` steps to find a new partner. Over any number of cycles, it does better than a cooperator exactly when `S + τ * e < L * g` (`switching_defection_pays_iff`), and never otherwise (`switching_defection_does_not_pay`); if each known defection makes the next search longer, serial defection does worse from an explicit number of cycles on (`reputation_ends_serial_defection`). Core Lean only, with a witness.
- `CareTransfer.lean` — care as a transfer. A cared-for that cannot cover its upkeep alone is kept going by a carer with slack `s` who gives care `c` and receives respite `r` from the commons. Care moves slack between the two and leaves their sum unchanged (`care_covers_need`); from any reserve it can be kept up at every step exactly when `c ≤ s + r` (`care_lasts_iff`); beyond that the carer is exhausted by step `R + 1` (`carer_burns_out`); respite that covers the gap keeps the carer's reserve from falling (`respite_sustains_care`); the cared-for holds while care lasts and falls within its own reserve once it stops (`cared_for_holds_while_cared_for`, `cared_for_falls_after_carer`). A carer's reserve has several dimensions (time, sleep, money, health): care lasts exactly when it fits on every one of them (`care_lasts_iff_every_dimension`), and a positive total margin does not keep care going when one dimension runs out (`surplus_does_not_cover_deficit`), so the ledger is a vector, not a sum. Whether care lasts is decided by the carer's margin and what the commons returns to the carer. The formal side of [`HEALTH_OF_THE_COMMONS.md`](../../research/health-of-intelligence/HEALTH_OF_THE_COMMONS.md). Core Lean only, with a witness.
- `PowerDistribution.lean` — power and distribution. An arrangement lasts exactly when every part's slack is nonnegative, whatever the total (`arrangement_lasts_iff_every_part_holds`), and two arrangements with the same total can last or drain a part to failure (`aggregate_does_not_decide_persistence`): the total decides whether a fair arrangement exists, the sharing whether it lasts. Whoever chooses the transfer chooses who fails (`chooser_decides_who_fails`); counting only the parts that hold always gives a nonnegative total (`excluding_failing_parts_looks_viable`), so the accounting boundary must be fixed in advance; a uniform sanction deters every taker exactly when it deters the least-detected one (`deters_all_iff_deters_least_detected`), and a taker never detected is deterred by no sanction (`exempt_taker_not_deterred`). About persistence, not about what is owed: a part the whole does not depend on gets no protection here. Core Lean only, importing `CareTransfer`, with a witness.
- `HealthProfile.lean` — why a health profile comes before a single score. A product of stage scores is zero exactly when some stage is zero (`stage_product_zero_iff`); a sum lets a high score hide a failed stage (`sum_compensates_failed_stage`); an order-preserving relabelling of ordinal levels can reverse the ranking of two profiles under a sum (`relabelling_reverses_sum`) and under a product (`relabelling_reverses_product`); dominance on every domain survives any such relabelling (`dominance_survives_relabelling`). Supports [`HEALTH_OF_INTELLIGENCE.md`](../../research/health-of-intelligence/HEALTH_OF_INTELLIGENCE.md). Core Lean only; close to arithmetic.
- `CuriosityValue.lean` — when exploring pays, in the slack ledger. An exploration that costs `K` once and, through a retained model improvement, saves `s` per period raises the reserve after `n` periods exactly when `n·s > K` (`exploration_raises_reserve_iff`); against the same exploration without model improvement, the whole difference is `n·s` (`gain_attributable_to_learning`); with no retained saving, as for mastered material or irreducible noise, a costly exploration lowers the reserve (`no_model_gain_lowers_reserve`); any positive saving pays over a long enough horizon (`long_enough_horizon_pays`) and not over a short one (`short_horizon_does_not_pay`); an exploration can pay and still be unaffordable now (`pays_but_unaffordable`). That a better model saves upkeep is a premise, not a result. Supports [`research/curiosity/`](../../research/curiosity/README.md). Core Lean only; close to arithmetic.
- `ExitOption.lean` — agency that works through its possibility. A partner who needs an agent to stay offers the least that keeps it, its floor (`best_offer_is_floor`); at that offer the agent stays, so the exit is never used (`exit_unused_at_best_offer`); yet a credible exit raises the floor by `o - m` (`exit_raises_floor`), and a worthless one changes nothing (`worthless_exit_adds_nothing`). Reconsidering pays exactly when the misfit it removes over the horizon exceeds its cost (`deliberation_pays_iff`); with no shift in the world the predictable habit is optimal (`habit_optimal_without_shift`). Supports entry D15 of [`DIALOGUE.md`](../../DIALOGUE.md). Core Lean only; close to arithmetic.
- `ProcessIdentity.lean` — continuity without sameness: identity as a process (D17). A process holds `k` numbered parts at a time and each step drops the oldest and takes in one new part, so each step keeps all but one (`step_keeps_all_but_one`, `step_adds_one`), yet after `k` steps no part is left from the start (`ends_share_nothing`). Overlap is not transitive (`overlap_not_transitive`), so "the same process" has to mean a chain of steps, not shared parts. A commitment that each step renews holds throughout (`renewed_commitment_holds`); if one step does not renew it, it can change (`lapsed_commitment_can_change`). Close to its definitions; branching into copies and how an agent chooses what to renew are not covered.
- `LinkedRevision.lean` — revision against replacement: the capacity to link (D18). A course of states is linked when each new state is computed from the old state and the evidence. Two linked courses with the same start and evidence agree throughout, so a partner can follow (`linked_courses_agree`); without linking the start and evidence do not determine the state (`unlinked_not_determined`); a stated link gives a partner something to check (`mismatch_reveals_unlinked_step`). Under multiplicative updating a weight of zero stays zero (`zero_weight_stays_zero`), so a move from full certainty in one view to belief in another is a replacement, not a revision (`certainty_change_is_replacement`). Close to its definitions; the clinical reading in D18 is an analogy.
- `ExistenceLemmas.lean` — two first steps toward the existence conjecture (D16). The deficit window: if the net flow is at most `-μ` per step before a response lag `d`, the buffer after `d` steps is at most `R - d·μ` (`buffer_drop_before_response`); if `d·μ > R` it is below zero at the lag, whatever happens afterwards (`late_response_cannot_save`), and flows that agree before the lag give the same buffer up to it (`after_lag_irrelevant`). Indistinguishability: courses that look the same up to `t` get the same action from an observation-based policy (`same_observations_same_action`), so if they need disjoint actions no such policy is safe on both (`no_policy_safe_for_both`). Close to arithmetic; one resource, deterministic flows.
- `PowerLayers.lean` — power in two speeds (D19). With at least one removal route a ruler keeps power exactly while his extraction is tolerated (`removal_caps_extraction`); with none he keeps it at any extraction (`sealed_ruler_unbounded`). A ruler who can amend the rules alone can reach rules with no removal route (`controls_amendment_can_seal`, `capture_by_amendment`); if amendment needs more parties than he controls, he can reach only the present rules (`entrenched_rules_hold`), so his extraction stays capped (`entrenched_routes_cap_extraction`). Rules that never change fall behind a changing requirement (`frozen_rules_fall_behind`). Close to its definitions; which interests count is a value (D7).
- `CommonsInterest.lean` — what not cheating gains. A node's interest is its own creation plus what the commons regenerates. Taking up to the interest keeps the commons level and the take lasts forever, so a node can take more than it creates and still last (`living_off_interest`, `take_more_than_create_and_last`); taking more eats the principal. A capturer's windfall beyond its own creation is bounded by the stock and what it regenerated on the way down (`capture_windfall_bounded`); capture pays at first (`capture_pays_at_first`), but past a horizon set by the stock and the regeneration, living off the interest has yielded at least as much in total (`not_cheating_wins_over_time`). Specialists, who cost more than they create alone, can all be covered forever on the interest (`specialists_last_on_interest`), and at least one fails at every step after a collapse, however the take is shared (`specialists_fail_after_collapse`). A sanction at least as large as the largest windfall makes capture yield no more than the interest at every horizon (`sanction_makes_capture_unprofitable`). Core Lean only, importing `CommonsVortex`, with a witness.
- `CommonsDiscount.lean` — discounting. The undiscounted comparison in `CommonsInterest` says nothing about a taker that values the present more than the future. With a discount factor `p/(p+d)`, a windfall `W` now against a regeneration `r` every step: if the commons regenerates more slowly than the taker discounts (`r * (p + d) < W * d`), capture is worth more at every horizon (`capture_wins_under_steep_discount`); if it regenerates faster (`W * d < r * (p + d)`), living off the interest is worth more from an explicit horizon on (`not_cheating_wins_under_mild_discount`), and `d = 0` gives the undiscounted case. This is the classical result of renewable-resource economics (Gordon, Schaefer, Clark). Core Lean only, with a witness.
- `CommonsTakers.lean` — several takers. `n` takers each live off a share `i` of the interest; one defector eats the principal and takes the windfall `W` alone, after which every share is gone. The defector weighs `W` against its own share, the whole against all `n` shares, so defecting can pay the defector at every horizon while the whole loses from an explicit horizon on (`tragedy_of_the_commons`); for a fixed interest, once there are more than `I * (p + d)` takers, defecting pays each of them under any discount (`enough_takers_make_defection_pay`). A sanction at least as large as the windfall deters any number of takers (`sanction_deters_any_number_of_takers`); one detected `k` times out of `m` must be `m / k` times as large (`detected_sanction_deters`). Not covered: several defectors at once, partial over-taking, takers who respond to one another, captured rules. Core Lean only, importing `CommonsDiscount`, with a witness.
- `CommonsCapture.lean` — the fixed-regeneration case; capture undermines its own ground: a node that draws its uptake from a commons regenerating `r` per step and takes `e > r` gains while the stock lasts, exhausts the stock by step `s0`, and is then left with `r`; if its upkeep exceeds `r`, it fails, and no rate of taking lasts (`capture_undermines_own_ground`, `no_take_lasts_above_regeneration`). A node lasts exactly when its upkeep fits within both its take and the regeneration (`lasts_iff`), so taking more than the commons regenerates never changes whether it lasts (`capture_buys_no_lasting`). Core Lean only, in whole units; a commons whose regeneration depends on its stock, and moving on to another commons, are not covered.
- `AdaptivePersistence.lean` — the bridge from fit to the ledger, in domain-free terms and without a reciprocity premise: under open change with dwell, a sealed configuration (its fit fixed in advance and ruling something out) exhausts its reserve in some possible future when misfit is costly, while a configuration that follows reliable feedback keeps a nonnegative reserve when fit pays. Both are also stated on the vortex ledger's internal slack, with a witness.

The external predicate is intentionally uninterpreted. It is **not** defined to mean objective truth, fitness, utility, morality, or correctness.

With retention, repeated validated generative uptake implies open-ended cumulative retained novelty. With representation inside the moving envelope, it also implies unbounded envelope capacity.

### Maintenance bridge

`MaintenanceDynamics.lean` now preserves the quantitative information that the earlier Boolean interface discarded. It defines a state `x` as supported by a lower-bound vector `b` only when `b` is itself strictly positive and `x ≥ b` componentwise.

For the canonical three-cycle witness, Lean proves under nonnegative coefficients, positivity of the canonical witness, and the **non-strict** product threshold:

```text
∀ n, Supported(canonicalVector, trajectory n).
```

The scalar

```text
ε = min(canonicalVector.a, canonicalVector.b, canonicalVector.c)
```

is therefore positive and lower-bounds every trajectory component at every time. The vector remains the primary object; the scalar floor is only a summary. This is a mathematical reference level inside the construction, not by itself an empirically calibrated operational threshold.

`MaintenanceOpportunityBridge.lean` then requires an explicit declared connection

```text
SupportImpliesOpportunity Support Opportunity
```

before persistent support can imply recurring opportunity. Persistent support cannot establish recurrence of an arbitrary external opportunity predicate.

The response layer now distinguishes:

```text
Q      = recurring opportunity
W      = recurring same-time opportunity + successful validated uptake
D_Δ    = recurring opportunity answered by validated success within lag Δ
B_Δ    = every opportunity receives a resource-feasible validated response within lag Δ
G      = recurring successful validated uptake
```

Response resource feasibility is quantitative:

```text
ResourceFeasibleAt(Cost, Budget, t, z)
    := Cost(t,z) ≤ Budget(t)
```

and a resource-validated success additionally requires the same envelope, novelty, generation, external-validation, and next-step-retention conditions used by ordinary validated uptake.

Lean checks:

```text
W ↔ D_0
Q ∧ B_Δ → D_Δ
D_Δ → G
R ∧ G → N
P ∧ R ∧ N → C
```

The existing same-time results remain available, including `Q ∧ V → W`, `W → Q`, and `W → G`.

The new regression witnesses establish:

```text
D_1 ∧ ¬W
validated success ∧ ¬resource-feasible validated success
resource feasibility ∧ ¬validated success
```

The first uses opportunities at even times and successful uptake at odd times, so every opportunity is answered exactly one step later. The other two show that the resource inequality is an independent constraint: abstract validated success does not determine an arbitrary cost/budget model, and sufficient budget alone does not create generation or success.

### Endogenous budget bridge

`EndogenousBudgetBridge.lean` closes the resource seam left by the bounded-response layer.

For organizational state `s_t`, external gradient `G_t`, uptake function `U`, maintenance demand `M`, and reinvestment fraction `beta_t`, it defines

```text
InternalSlackAt(t) = U(s_t,G_t) - M(s_t)

EndogenousResponseBudget(t)
    = beta_t * InternalSlackAt(t).
```

Lean checks that viability is equivalent to nonnegative internal slack, and that at fixed external gradient

```text
higher uptake + no larger maintenance
        → no lower internal slack
        → no lower response budget        (beta >= 0).
```

A strict response-budget increase opens a nonempty interval of response costs that were unaffordable before and affordable afterward.

The concrete fixed-gradient witness keeps `G=10` and maintenance `=6`, changes organizational uptake from `10` to `11`, and therefore raises slack/budget from `4` to `5`. A response cost `9/2` crosses that window and finances the existing lag-1 even/odd response architecture. With recurrent opportunity this yields `G`; with retention it yields `N`.

The same interface is also instantiated by the existing cumulative-accessibility margin without equating it to physical energy:

```text
M_0 = 2/3
M_1 = 97/99
response/load cost = 9/10
```

so the exact first retained click makes the same `9/10` second-click load infeasible before and feasible afterward.


### Two complementary witnesses

`FormalCoreWitness.lean` is the original **logical non-vacuity witness**. It shows that the premise set of the cross-stack theorem can be inhabited simultaneously. Its progressive architecture is deliberately stronger than necessary and realizes novelty at every time step; therefore it does not make maintenance opportunity load-bearing in that particular construction.

`MaintenanceGatedWitness.lean` is a stronger **within-model dependency / ablation witness**. It defines one architecture family parameterized by an opportunity stream:

```text
opportunity present
    → generator enabled
    → repertoire expands

opportunity absent
    → generator disabled
    → repertoire unchanged
```

For the concrete recurrent maintenance opportunity stream, the gated architecture has open-ended cumulative retained novelty. Replacing the opportunity stream by `False` leaves the same architecture family static and not open-ended.

This demonstrates a genuine dependency inside the formal model. It does **not** establish empirical causality in biological, social, cognitive, or technological systems.

## Verification contract

Compilation coverage and proof-dependency auditing are now separate explicit checks.

`CumulativeAccessibility.AuditAll` imports every module advertised in this README. CI builds that aggregate target so an auxiliary advertised module cannot remain outside the verification surface merely because the central witness import graph does not reach it.

`CumulativeAccessibility.VerificationSurface` contains an explicit reviewed list of advertised declarations and prints their axiom dependencies. CI fails if any printed dependency contains:

```text
sorryAx
```

CI explicitly builds the aggregate, axiom-audit, and witness targets:

```text
CumulativeAccessibility.AuditAll
CumulativeAccessibility.VerificationSurface
CumulativeAccessibility.FormalCoreWitness
CumulativeAccessibility.MaintenanceGatedWitness
CumulativeAccessibility.BoundedResponseWitness
CumulativeAccessibility.EndogenousBudgetWitness
CumulativeAccessibility.DynamicVortexWitness
```

Changes under `formalization/collective-alignment/**` now trigger the downstream cumulative-accessibility workflow because that package is a local dependency.

The checked theorems may use standard Lean/Mathlib axioms such as `propext`, `Classical.choice`, and `Quot.sound`; the verification criterion is that no selected advertised result depends on an unproved `sorry` placeholder. Adding a result to the advertised verification surface therefore requires both importing its module through `AuditAll` and adding its declaration to the explicit axiom-audit list.

## Reproduce locally

From the repository root:

```bash
cd formalization/cumulative-accessibility
lake update
lake exe cache get
lake build
lake build \
  CumulativeAccessibility.AuditAll \
  CumulativeAccessibility.VerificationSurface \
  CumulativeAccessibility.FormalCoreWitness \
  CumulativeAccessibility.MaintenanceGatedWitness \
  CumulativeAccessibility.BoundedResponseWitness \
  CumulativeAccessibility.EndogenousBudgetWitness \
  CumulativeAccessibility.DynamicVortexWitness \
  CumulativeAccessibility.QuantitativeAccessibility \
  CumulativeAccessibility.IntelligentLearningMaintenance
```

To inspect the printed axioms directly:

```bash
lake env lean CumulativeAccessibility/VerificationSurface.lean
lake env lean CumulativeAccessibility/EvolutionByEmergenceV17Core.lean
lake env lean CumulativeAccessibility/ConstructiveRecursiveEmergence.lean
lake env lean CumulativeAccessibility/ActiveHistory.lean
lake env lean CumulativeAccessibility/FormalCoreWitness.lean
lake env lean CumulativeAccessibility/MaintenanceGatedWitness.lean
lake env lean CumulativeAccessibility/BoundedResponseWitness.lean
lake env lean CumulativeAccessibility/EndogenousBudgetWitness.lean
lake env lean CumulativeAccessibility/DynamicVortex.lean
lake env lean CumulativeAccessibility/DynamicVortexWitness.lean
lake env lean CumulativeAccessibility/QuantitativeAccessibility.lean
lake env lean CumulativeAccessibility/IntelligentLearningMaintenance.lean
```

A formal-core verification should fail review if any audited output contains `sorryAx`.

Pinned toolchain:

```text
Lean 4.33.0
```

Mathlib is pinned in `lakefile.toml`.


Additional v17 boundaries:

- **Operational accumulation and historical accumulation are distinct.** Open-ended history does not imply a growing active repertoire.
- **Constructive generation is optional and stronger.** Capacity-level generation does not automatically identify the configuration that realizes the emergent capacity.
- **Essential-parent use is not sole causation.** Other simultaneous additions can also be necessary.
- **Finite admission is an application interface.** The theory does not universally derive which newly generable possibilities receive search effort.
- **Moving envelopes do not prove strong ontology creation.** The corrected recursive theorem still uses one ambient `Capacity` type.
- **Deterministic local `R_E` is not a stochastic branching theorem.**
## Scope boundaries

Machine checking establishes that the stated conclusions follow from the stated formal assumptions. It does not establish that:

- persistence is fitness or function;
- maintenance is learning;
- novelty is improvement;
- every recurrent maintenance network learns;
- unbounded capacity guarantees realized novelty;
- the external acceptance predicate is objectively correct;
- the strict three-cycle result already generalizes to arbitrary networks;
- physical reality has a fixed finite state space;
- or empirical systems satisfy the model assumptions.

The response budget is endogenous to a declared organization/gradient ledger, and the package contains recursive structural results in which retained products become later parent material and organizational changes expand future search. `DynamicVortex.lean` now packages those routes into a typed composition theorem, while `DynamicVortexWitness.lean` supplies a concrete non-vacuity witness.

The key remaining modelling seam is narrower: an application must justify why a particular retained validated response produces a particular physical organizational state update, and whether that update changes measured uptake, maintenance, or future search. The generic theorem keeps that integration premise explicit. External-gradient dynamics, stochastic generation/validation, turnover/memory, and empirical identification remain separate modelling questions.

Those are separate modelling, empirical, and interpretive questions.
