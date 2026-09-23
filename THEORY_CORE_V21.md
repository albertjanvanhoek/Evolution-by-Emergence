# Evolution by Emergence v21 — Theory Core

**Status:** candidate theory for adversarial peer review  
**Universal scope:** substrate-agnostic cumulative evolution under explicit retention, transition, accessibility, production/loss, emergence, and resource constraints  
**Companion specialization:** intelligent systems are treated separately in `research/anchored-correctability/`; their semantic premises are not universal axioms

## 1. Question

Evolution by Emergence asks:

> **How can organization that exists now become causal material that changes which organization can exist next, while itself being produced, lost and maintained under finite resources?**

v21 keeps the v20 retained-organization/accessibility architecture and adds the reviewed Cumulative Reproduction Model (CRM) as a **distinct count-level dynamical specialization**.

The resulting universal candidate architecture is:

```text
history / interaction
    -> retained organization
    -> transition machinery
    -> future accessibility
    -> generated organization
    -> production / loss / admission
    -> budget-constrained retention
    -> retained organization ...
```

Two questions that were easy to conflate are deliberately kept separate:

1. **Structural consequence:** which retained organization changes later transition machinery or accessibility?
2. **Population/repertoire dynamics:** under a declared production/loss law, how does the amount of retained organization grow, collapse, plateau or fluctuate?

The first is the v20 identity-sensitive accessibility programme. The second is the reviewed CRM extension. Neither replaces the other.

## 2. Universal state and resource accounting

The v20 structural core uses

```text
S_t = (G_t, R_t, Gamma_t, B_t^gross)
B_t^free = B_t^gross - M(R_t)
```

where `G_t` is active organization, `R_t` retained organization, `Gamma_t` context, and `B_t^gross` gross available budget.

Retained history has two simultaneous effects:

1. **causal leverage:** retained organization can alter later transition machinery and future accessibility;
2. **maintenance burden:** retained organization consumes capacity that could otherwise support maintenance, search, response or further change.

The reviewed CRM introduces a count `N` of retained items under an operationally fixed counting convention and a linear ledger specialization

```text
free resource flow F(N) = B0 + (eta - mu) N,
```

with per-item upkeep `mu`, resource capture `eta`, exogenous flow `B0`, production and loss. This is a specialization of resource accounting, not a universal assertion that all retention costs and returns are linear or scalar.

## 3. Retained organization changes future accessibility

`formalization/cumulative-accessibility/` remains the canonical identity-sensitive formalization of the structural universal claim.

`TransitionAccessibility.lean` defines weighted directed transition machinery, actual finite routes, route cost and finite-horizon accessibility under available budget.

### 3.1 Kernel dominance

If a retained transition kernel preserves every transition of an ablated kernel and never raises an old transition cost, then accessibility cannot decrease at equal horizon and free budget.

This gives a monotonicity result about transition machinery; it does not claim that every retained item improves the kernel.

### 3.2 Necessary condition for paid opening

With non-decreasing upkeep, if retaining an item opens a target that is closed in the matched ablated arm after both arms pay their own maintenance burden, the ablated kernel cannot reproduce every retained transition at equal or lower cost.

The theorem is **necessary**, not sufficient.

### 3.3 Sufficient route-saving condition

If the retained arm has a route whose cost saving exceeds the marginal retention burden relative to a lower bound on ablated routes, then there exists a common gross-budget window in which the target is accessible with the retained organization and inaccessible without it.

The theorem is **sufficient**, not necessary.

### 3.4 Paid counterfactual transfer

For a retained item `X`, the core compares matched retain/ablate arms built from the same active organization, context and gross budget. A cumulative paid-transfer claim therefore demands more than state dependence: the retained item must causally alter later access after its maintenance burden is paid.

This remains the principal firewall against the weak claim:

> “the state changed, therefore cumulative evolution occurred.”

## 4. Emergence remains separate from retention

Strict compositional emergence is treated as a relation between a declared whole and proper subconfigurations, not as a synonym for retention, success or novelty.

If a future capacity is strictly emergent, target-specific benefit is unavailable before realization, and a proper intermediate has positive upkeep, then that future capacity cannot finance the positively costly proper intermediate by itself.

If the intermediate remains viable, some positive auxiliary support is required. That support can be another present function, reuse elsewhere, exaptation, subsidy, drift or another explicit mechanism.

The transition-mediated specialization proves the same point when realizing the emergent capacity is what adds a transition. Countermodels show the escape routes: remove strict emergence, change upkeep accounting, or let the intermediate persist through a different transition.

This separation is retained in v21 because emergence answers a different question from cumulative reproduction.

## 5. Finite resources force retention trade-offs

The universal v20 formalization already proves two useful no-go results.

### 5.1 Finite-budget retention no-go

If every candidate retained item costs at least `mu > 0` and the available maintenance budget is below `|C| mu`, retaining all candidates is infeasible.

The theorem does not decide which item is forgotten, compressed, replaced, made cheaper or retained.

### 5.2 Bounded reuse no-go

Under an injective single-unit bounded-reuse encoding,

```text
|A| <= |R| d.
```

With minimum retained-unit maintenance `mu` and budget `B`,

```text
|A| mu <= B d.
```

Uniformly bounded retained cardinality plus uniformly bounded per-unit reuse therefore rules out unbounded accessible cardinality under that declared encoding.

Compositional or synergistic support can escape the single-unit encoding; that is a scientific/modeling distinction, not a contradiction.

## 6. Cumulative reproduction: a reviewed dynamical specialization

`research/cumulative-reproduction/` asks a complementary question: if retained organization is represented by a count `N`, what follows from explicit production, loss and affordability rules?

Its evidence boundary is important:

- Lean proves conditional statements for a discrete natural-number recurrence;
- the continuous ODE is a separate deterministic model;
- the CTMC is a separate stochastic model;
- simulations validate implementations and selected analytic predictions;
- none of these, by itself, establishes a universal empirical law.

### 6.1 Discrete recurrence

For gain `G(N)` and loss `L(N)`, the Lean model uses

```text
N_(t+1) = N_t + G(N_t) - L(N_t)
```

with natural-number subtraction truncated at zero.

Lean proves, under the stated premises:

- growth exactly when gains exceed losses;
- shrinkage exactly when losses exceed gains for nonzero `N`;
- a fixed point exactly when gains equal losses for nonzero `N`;
- unbounded growth above a declared uniformly supercritical region;
- extinction below a declared uniformly subcritical critical mass when gain at zero is zero;
- the corresponding critical-mass dichotomy;
- exponential lower bounds under a linear excess assumption;
- doubly-exponential lower bounds under a quadratic excess assumption.

These are conditional recurrence theorems. They are not a Lean proof of the continuous or stochastic models.

### 6.2 Reproduction balance

For a continuous/stochastic specialization with loss rate `delta N`, the reviewed theory defines

```text
R_c(N) = P(N) / (delta N),    N > 0,
```

as an instantaneous production/loss rate ratio.

The sign of deterministic drift, and of the CTMC conditional expected increment, follows whether `R_c` is above or below one. A literal lifetime-offspring interpretation requires additional parentage assumptions and is not generally valid for joint production or immigration.

### 6.3 Critical mass is conditional on the production law

For pure pairwise production with no immigration and no binding ceiling,

```text
N* = 1 + 2 delta / (rho alpha_2)
```

is an unstable deterministic threshold in the declared ODE.

But leverage or nonlinear production does **not** automatically imply one critical mass. Immigration, mixtures of arities, interference and resource constraints can remove or multiply crossings. A threshold must be derived from the declared production law.

### 6.4 Growth speed

The reviewed CRM keeps the scaling case `kappa = 1` deliberately unresolved by the exponent alone. Linear production can yield decay or exponential growth; slowly varying factors at the same asymptotic exponent can produce much faster classes. The Osgood integral, not the log-log exponent alone, determines finite-time blow-up in a continuous positive-drift model.

Lean's linear- and quadratic-excess results remain discrete lower bounds and are not identified with those ODE formulas.

### 6.5 Affordability ceiling

For the linear ledger with finite constant `B0`, if `mu > eta`, affordability implies

```text
(mu - eta) N <= B0,
```

and hence a finite ceiling.

If `eta >= mu`, this **particular ledger** no longer bounds `N`; it does not guarantee growth, open-endedness or physical feasibility.

Lean proves the ledger ceiling, self-financing non-binding case, and positive-integer currency rescaling invariance under the declared model.

### 6.6 Finite stochastic systems eventually die without immigration

The reviewed stochastic correction is important. In a finite-cap birth-death model with no immigration, positive loss and zero absorbing, eventual extinction occurs with probability one even in a deterministically supercritical regime.

Finite-target hitting, finite-horizon survival, eventual survival and deterministic growth are therefore different quantities.

The E-series experiments preserve these distinctions:

- E1/E2/E7 use finite-target hitting where appropriate;
- E5 is a finite-horizon survival surface, not a permanent-persistence phase diagram;
- E6 reports recovery after a specified finite shock rather than proving irreversible collapse from merely crossing below a threshold.

### 6.7 Scaffolding needs an information mechanism

The discrete scaffold theorem proves an exhaustive sequential upper bound `k q` under an explicit part-wise correctness oracle and retention of found parts, and compares it with the `q^k` whole-target search-space size.

Strict emergence alone does not create the part-wise oracle. The information and work assumptions remain explicit.

## 7. The v21 recursive geometry

The universal synthesis is therefore not one scalar law. It is a coupled architecture:

```text
                   retained identity / structure
                          |           |
                          |           +--> maintenance burden
                          v
                 transition machinery
                          |
                          v
                  future accessibility
                          |
                          v
               generated organization
                          |
               validation / admission
                          |
                          v
                 retained repertoire
                    /           \
           production             loss
                    \           /
                     resources
                          |
                          +----> next retained state
```

The v20 side asks whether specific retained organization changes what is later reachable.

The CRM side asks what a declared repertoire-level production/loss process does over time.

A complete empirical application may need both: item identities/functions to establish causal accessibility effects, and count/rate dynamics to describe how the repertoire changes.

## 8. Nested scales

The same abstract structural geometry may be tested at nested organizational layers: cellular regulation, immune memory, neural learning, individual skill, cumulative culture, institutions, science and technology.

This is a **candidate cross-domain interpretation**, not a theorem that all domains instantiate one empirical mechanism.

The CRM multitype branching specialization gives a separate conditional result: for a declared linear multitype branching process, a next-generation matrix can characterize supercriticality under the standard assumptions. That mathematical specialization must not be silently transferred to arbitrary nonlinear nested systems.

## 9. Intelligent systems are a specialization, not the universal core

v21 now keeps a deep intelligent-system formalization in

```text
research/anchored-correctability/
```

and a smaller self-contained seed in

```text
scap-seed/
```

Those packages add epistemic primitives:

- candidate worlds;
- semantic claims;
- liveness and evidence;
- challenges and answerability;
- content-sensitive tracking;
- communication channels;
- correction, sealing and repair;
- shared evidence-defined realities.

The universal EbE model does **not** assume those primitives.

The proposed specialization map is documented in `UNIVERSAL_TO_INTELLIGENCE.md`. It is useful because retained records/rules can alter later model transitions and correction accessibility, and correction structures themselves require maintenance. But a theorem proving that Anchored Correctability is a complete instantiation of the universal EbE core has not yet been established.

## 10. The current intelligent-system endpoint

Within its own explicit semantic premises, `research/anchored-correctability/` develops:

```text
anchor
 -> live candidate worlds
 -> executable challenge/revision
 -> semantic answerability
 -> content-sensitive tracking
 -> individuals / groups / recursive networks
 -> one relation-level tracking law
 -> dynamic evidence
 -> operational realization
 -> changing world + temporal link failure/repair
 -> SCAP persistence conditions
 -> alignment specialization
```

Its top-level theorem-level SCAP object separates five conditions:

```text
Connected ∧ Faithful ∧ Evidence-open ∧ Repairable ∧ Affordable.
```

This is a theorem-level intelligent-system design/analysis object, not a new universal axiom of EbE.

The associated F-series fragmentation experiments are numerical specializations, not Lean proofs of stochastic thresholds or social universality.

## 11. SCAP Seed

`scap-seed/` is deliberately smaller. It is a self-contained portable review/replay object with its own Lean toolchain, claims ledger, contribution rules and simulation smoke tests.

Its role is pedagogical and reproducibility-oriented:

- replay the anchor-to-corrigibility path;
- inspect assumptions without loading the full research package;
- test challenge and falsifier workflows;
- preserve a stable intelligent-system seed while the deeper package continues to evolve.

What is proved in the seed does not certify the universal model or the deeper package, and the rest of the repository does not weaken the seed's local theorems.

## 12. What v21 claims

The universal v21 theory claims that the repository supplies machine-checked conditional constraints connecting:

- retained organization and matched retain/ablate comparisons;
- maintenance burden and free resources;
- transition machinery and finite-horizon accessibility;
- necessary and sufficient conditions for certain paid openings;
- strict compositional emergence and auxiliary-support requirements;
- finite-resource retention/reuse bounds;
- conditional repertoire-level production/loss, critical-mass and affordability results.

The scientific proposal is that these pieces can be used together to study **resource-constrained cumulative evolution in which retained organization both changes later possibilities and participates in further production/loss dynamics**.

The intelligent-system programme is a separately declared specialization in which some retained organization consists of models, records, correction routes and rules for revising under evidence and challenge.

## 13. What v21 does not claim

The formalization does not establish:

- empirical universality;
- that all state dependence is cumulative evolution;
- that every retained item is functionally useful;
- that retention is always beneficial;
- that novelty is improvement;
- that persistence is function;
- that validation is truth;
- that selection is progress;
- that a count `N` is sufficient to describe organization;
- that every nonlinear process has one critical mass;
- that `R_c` is always a literal branching reproduction number;
- that finite-cap stochastic persistence is permanent;
- that a mathematical blow-up is physically realizable;
- that every substrate literally learns;
- that universal EbE requires semantic beliefs, candidate worlds or challenges;
- that the intelligent-system specialization is morally, legally or politically obligatory;
- that machine checking establishes empirical truth;
- strong creation of previously unstatable ontologies in the current fixed ambient Lean types.

## 14. Canonical v21 review route

### Universal structural core

Start with:

```text
THEORY_CORE_V21.md
formalization/cumulative-accessibility/README.md
formalization/cumulative-accessibility/CumulativeAccessibility/RetainedOrganizationCore.lean
formalization/cumulative-accessibility/CumulativeAccessibility/TransitionAccessibility.lean
formalization/cumulative-accessibility/CumulativeAccessibility/EmergentAssemblyBarrier.lean
formalization/cumulative-accessibility/CumulativeAccessibility/TransitionMediatedEmergence.lean
formalization/cumulative-accessibility/CumulativeAccessibility/GenerativeLeverage.lean
formalization/cumulative-accessibility/CumulativeAccessibility/VerificationSurface.lean
```

### Universal dynamical extension

Then:

```text
research/cumulative-reproduction/THEORY.md
research/cumulative-reproduction/REVIEW.md
research/cumulative-reproduction/VALIDATION.md
research/cumulative-reproduction/lean/CumulativeReproduction.lean
research/cumulative-reproduction/sim/
```

### Intelligent-system specialization

Only when that specialization is relevant:

```text
UNIVERSAL_TO_INTELLIGENCE.md
research/anchored-correctability/README.md
research/anchored-correctability/ANCHORED_CORRECTABILITY.md
research/anchored-correctability/METAMODEL.md
research/anchored-correctability/lean/AnchoredEvolution/SCAP.lean
research/anchored-correctability/lean/AnchoredEvolution/Alignment.lean
research/anchored-correctability/lean/AnchoredEvolution/Audit.lean
scap-seed/README.md
scap-seed/SEED.md
```

## 15. Verification

Each package keeps its own verification boundary.

- `formalization/cumulative-accessibility/` verifies the v20/v21 structural universal surface.
- `research/cumulative-reproduction/` verifies the reviewed count-level CRM and its numerical regressions.
- `research/anchored-correctability/` verifies the deep intelligent-system specialization.
- `scap-seed/` verifies the portable seed.

The v21 integration workflow runs these as an **integration matrix**. Passing all jobs means that each declared surface passes its own check on the same repository commit; it does not mean one package proves the others.

## 16. How to challenge v21

A useful review should try to break at least one link:

1. **formal validity** — a conclusion fails under its exact premises;
2. **semantic adequacy** — a predicate does not mean what the prose says;
3. **model separation** — the structural accessibility and count-level dynamics have been conflated;
4. **hidden assumptions** — item identity, counting convention, scalar resources, parentage, oracle or admission assumptions are doing unacknowledged work;
5. **prior art** — an existing theory already supplies an equal or stronger architecture;
6. **cross-domain mapping** — a real cumulative system cannot instantiate the interfaces without arbitrary relabeling;
7. **universality counterexample** — genuine cumulative evolution occurs without any defensible retained-history effect on later accessibility;
8. **specialization failure** — the intelligent-system map adds semantics that are not justified by the universal model, or fails to instantiate the universal interfaces it claims to specialize.

A successful falsification, narrowing or prior-art correction is a positive scientific result.

## 17. Version relation

- **v20** remains an immutable historical review object for retained organization and transition-induced accessibility.
- **v21** adds the reviewed Cumulative Reproduction Model and explicitly separates the universal theory from the newer Anchored Correctability / SCAP intelligent-system specialization.
- **SCAP Seed** has its own `seed-` version lineage as a portable review object.

The named v20 files remain in the repository unchanged for reproducible historical review.

---

**Peer-review rule:** read every implication in its stated direction. Lean establishes conditional mathematics under explicit premises. Scientific universality, empirical mapping and the intelligent-system specialization remain open to challenge.