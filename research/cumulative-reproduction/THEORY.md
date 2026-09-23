# Cumulative Reproduction: growth, loss and the affordability of retained organization

**Status:** reviewed research extension to EbE v20, not a replacement of its canonical core. The proposal supplies a count-level dynamical specialization: retained organization contributes to production, incurs upkeep, and is lost. Its empirical mapping and novelty remain open.

**Evidence boundary:** `lean/CumulativeReproduction.lean` proves conditional results for integer discrete-time recurrences. The continuous-time ODE and stochastic CTMC are separate models. Simulations check their implementation and selected analytic predictions; they do not establish a universal empirical law or transfer the Lean proofs to a CTMC. See [REVIEW.md](REVIEW.md) for corrections to the submission and [VALIDATION.md](VALIDATION.md) for execution results.

## 1. Objects and model choices

| Symbol | Meaning |
|---|---|
| N | Count of retained items, with an operationally fixed counting convention |
| P_raw(N) | Candidate production rate after retention fidelity, before affordability admission |
| P(N) | Admitted birth rate in the integer CTMC |
| δN | Loss rate, δ > 0 |
| B₀ | Constant exogenous resource flow in the ledger |
| η, μ | Resource capture and upkeep flows per retained item |
| F(N) = B₀ + (η − μ)N | Resource flow left for search |
| K = B₀/(μ − η) | Continuous affordability ceiling when μ > η; integer ceiling is floor(K) |
| ρ | Retention/fidelity probability |

All ledger quantities use one currency and a common time unit. Admission of a new item requires μ(N+1) ≤ B₀ + η(N+1). This assumes a new item's resource capture is available immediately; construction delays or initial capital requirements require a richer ledger. Currency invariance does not justify aggregating non-substitutable resources into a scalar.

Two alternative production closures are implemented:

- **Mass action:** P_raw(N) = ρ[a₀ + Σ_k α_k C(N,k)], with nonnegative coefficients and a specified finite maximum arity. Combinations act in parallel at fixed rates. The ledger charges upkeep but does not separately charge these production events. Unlimited combination rates therefore remain an idealization even when upkeep is affordable.
- **Effort limited:** P_raw(N) = A max(F(N),0)(1+βN)^γ, where A = ρφ/c₀ > 0, c₀ > 0, β ≥ 0 and γ ≥ 0. Here the free resource flow finances search.

A self-rewiring hypergraph motivates the combinatorial term; neither the code nor the Lean model represents item identities, actual hyperedges, uniqueness of products, or dependency cascades. The model assumes each admitted event contributes one item. Whether this count measures organizational or functional novelty must be established separately.

The CTMC uses birth rate P(N) = P_raw(N) when N+1 is affordable, zero otherwise, and death rate δN. The deterministic continuous-size closure uses dN/dt = P_raw(N) − δN in the affordable interior, with drift projected inward at a hard ceiling. It is not the nonlinear CTMC expectation: in general E[P(N)] ≠ P(E[N]).

## 2. Reproduction balance and local thresholds

For N > 0 define R_c(N) = P(N)/(δN). This is a dimensionless instantaneous production/loss ratio. In the deterministic interior use P_raw instead of the one-item admission rate.

- Deterministic drift is positive, zero or negative as R_c is above, equal to or below one.
- CTMC conditional expected increment per unit time has the same sign; individual paths can move either way.
- A literal lifetime offspring interpretation requires independent per-item production at fixed rates. Joint production and immigration do not provide such parentage automatically. In particular R_c is not generally a next-generation R₀.

At a differentiable ODE equilibrium, a negative derivative of net drift is sufficient for local asymptotic stability; a positive derivative implies instability. A zero derivative requires further analysis. The submitted “stable iff derivative < 0” was too strong.

Lean proves `grows_iff`, `shrinks_iff` and `fixed_iff` for the integer step n ↦ n+G(n)−L(n), with natural-number subtraction truncated at zero. Shrinkage and fixed-point equivalences require n > 0. Lean does not define a real-valued reproduction ratio.

## 3. Critical mass: a conditional Allee threshold

For pure pairwise production with a₀ = 0, α₂ > 0 and no binding ceiling, let a = ρα₂/2. Then

    dN/dt = aN² − (a+δ)N = aN(N−N*),
    N* = 1 + 2δ/(ρα₂).

In the continuous-size model, 0 < N₀ < N* decays toward zero, N₀ = N* is an unstable equilibrium, and N₀ > N* grows. The polynomial continuation is used above N = 1; the code clips negative generalized combination rates below one, preserving decay there. The displayed growth-time formula concerns N₀ > N*.

This threshold is not guaranteed by “leverage present.” For instance, with η = μ, γ = 1 and B₀ > 0,

    R_raw(N) = AB₀/(δN) + AB₀β/δ,

which decreases with N. Immigration, mixtures of arities, interference and budget limits can remove a threshold or introduce multiple crossings. An assumed single upcrossing must be checked from the production law.

Lean's `SupercriticalFrom G L c` assumes at least one net integer gain at every n ≥ c; `SubcriticalBelow G L c` assumes at least one net integer loss for 0 < n < c. With G(0)=0 these yield unbounded growth above c and extinction within n₀ steps below c. The integer c is not the continuous equality point N*: it is the first state assumed strictly supercritical.

## 4. Growth speed and the critical scaling case

For a positive, locally regular drift f(N)=P_raw(N)−δN on the entire route from N₀ to infinity, the ODE reaches infinity in finite time exactly when

    ∫[N₀,∞] dN/f(N) < ∞.

If κ = lim log(P_raw(N))/log(N) exists in fixed units, is greater than one, and the positive-drift route is reachable, the integral is finite: eventually P_raw(N) ≥ N^(1+ε) for some ε > 0. If κ < 1 and δ > 0, loss eventually dominates; an unbounded positive trajectory is excluded under the stated regularity assumptions.

**κ = 1 does not classify speed.** P_raw(N)=bN gives exponential growth only when b>δ (decay when b<δ). By contrast, P_raw(N)=δN+N log N and P_raw(N)=δN+N(log N)² both have κ=1; the first has infinite-time doubly exponential growth and the second finite-time blow-up. Units and the logarithm's reference scale are fixed before taking the limit.

For the effort-limited closure, assuming β>0, B₀>0 and positive prefactors:

- η=μ: κ=γ;
- η>μ: κ=γ+1;
- η<μ: the domain has a finite ceiling and there is no N→∞ scaling regime.

If β=0, the leverage factor is constant: the exponents are respectively 0 and 1, regardless of γ. With η=μ and γ=1, write r=AB₀β−δ. Then N'=AB₀+rN: exponential growth for r>0, linear growth for r=0, and convergence to a finite equilibrium for r<0. E4c illustrates the specially tuned r=0 case.

For pairwise production and N₁>N₀>N*:

    t(N₀→N₁) = ln[(1−N*/N₁)/(1−N*/N₀)]/(a+δ),
    t* = −ln(1−N*/N₀)/(a+δ).

The singularity belongs to the unbounded-rate mathematical model. Simulations stop at finite targets and do not observe an infinity. Physical throughput, construction time, finite resources and resolution can invalidate this extrapolation.

Lean's `linear_excess_exponential` and `quadratic_excess_doubly_exponential` establish lower bounds under explicit integer excess assumptions. They do not prove these ODE formulas. The quadratic bound shows doubly exponential growth when the initial gap is at least two; a gap of zero or one makes that bound uninformative. Discrete integer time has no finite-time singularity.

## 5. Budget balance and finite-horizon survival

Affordability implies

    (μ−η)N ≤ B₀.

When μ>η, every affordable state is bounded by K. This is independent of the production law. When η≥μ, this particular ledger does not bind; it does not guarantee growth or physical feasibility. Lean proves these statements and invariance under positive integer rescaling of the ledger.

The statement “unbounded accumulation requires η≥μ” is conditional on constant finite B₀, linear upkeep/capture and fixed coefficients. An increasing external budget or a bounded total maintenance function changes the conclusion. Merely sublinear but unbounded upkeep, such as M(N)=√N without capture, still imposes a finite ceiling under finite B₀.

In the clipped integer recurrence, if K<c, G(0)=0 and every positive state below c loses at least one net item per step, extinction follows from any start after projection. If c≤n₀≤K and the stated supercritical assumption holds, the recurrence reaches K and stays there. Its clipping rule is not identical to a CTMC that blocks births at K but still permits deaths.

For pure pairwise deterministic production, K<N* gives decay from every affordable start. For N*<n₀≤K the projected ODE grows to K. Equality n₀=N* remains an equilibrium. Effort-limited production has F(K)=0 and, if P_raw(0)>0, at least one interior equilibrium; uniqueness and stability need analysis of the chosen parameters (E4b uses γ=1).

**Stochastic distinction.** With finite integer K, no immigration, δ>0 and finite rates, zero is absorbing and reachable from every positive state. Eventual extinction has probability one, even when K>N*. A long-lived population near the ceiling is metastable. At every finite T there is positive survival probability from a positive start (at least the positive probability of no jump), even when K<N*.

E5 therefore estimates S(T;K,N*)=Pr[N(T)>0 | N(0)=K], not permanent persistence. Its K₅₀ is a finite-horizon survival contour at δT=30 for the specified rates and start. The supplied values are 11,17,23,29,34,39,44,49,54,59 for N*=4,8,…,40. They are not a universal margin or a necessary condition for nonzero finite-time survival. Zero observed survivors in 150 runs is not zero probability; its two-sided 95% Wilson upper bound is about 0.025.

## 6. Budget shocks and path dependence

The simulator explicitly projects the state down when a budget shock makes it unaffordable. Shock depth **and duration** determine the post-shock state and recovery probability.

Without immigration, hitting zero makes loss permanent within the model; restoring the budget cannot create an item. In the pairwise CTMC, reaching N=1 also removes the birth channel. However, a short shock below N* can leave N≥2, from which stochastic recovery is possible after restoration. A deterministic trajectory restored while still above N* can also recover. Thus crossing the ceiling below N* temporarily is not sufficient for permanent destruction.

With a₀>0 (or positive effort production at zero), zero is not absorbing when admission permits a birth. Re-establishment may occur. E6 reports Pr[N(80)≥30] for specified shocks, not a theorem of permanent loss. The generic Lean extinction proof requires G(0)=0 and a persistent subcritical regime, not an arbitrary finite shock.

## 7. Coupled types and nested interpretation

For a linear multitype branching process with λ_ij the production rate of type i per type j, constant δ_j>0 and retention ρ_i, define the next-generation matrix

    K_ij = ρ_i λ_ij / δ_j.

For an irreducible nondegenerate process, positive probability of indefinite survival is equivalent to spectral radius ρ(K)>1. In a reducible process, the initial types must be able to reach a supercritical class. This criterion is not an almost-sure survival guarantee, a finite-time explosion criterion, or a result for arbitrary nonlinear coupled layers.

For two nonnegative types with k₁₁,k₂₂<1, the larger eigenvalue exceeds one iff

    (1−k₁₁)(1−k₂₂) < k₁₂k₂₁.

The characteristic polynomial evaluated at one gives this elementary condition. E7 checks it numerically on 100,000 matrices. In E7's symmetric case the total count itself is a linear birth–death process, so the finite-target probability and the infinite-horizon survival probability can both be calculated directly. The simulator measures reaching 150 before zero. At critical coupling c=0.4, this probability is 1/150, whereas eventual survival is zero.

“Nested layers” is an application hypothesis: cell, organism and cultural units cannot simply be counted as independent branching types without specifying their production and loss mechanisms. This criterion is not in the supplied Lean formalization.

## 8. Scaffolded assembly and evaluable intermediates

Consider a unique target with k parts and q equally likely options per part. Independent, uniform whole-target draws with replacement take q^k expected draws. This follows from a success probability q^(−k), not from emergence alone.

With an **additional part-correctness oracle** and retention:

- exhaustive sequential search requires at most kq part evaluations (Lean's `scaffolded_search_cost`);
- random sequential search with replacement requires kq evaluations in expectation, with no finite worst-case bound;
- parallel redraws of missing parts take E[max of k Geometric(1/q)] rounds, asymptotic to ln(k)/ln(q/(q−1)) for fixed q>1. Total expected part draws remain kq.

Lean proves kq≤q^k for q≥2,k≥1, strictly for k≥3. It compares an exhaustive upper bound with a search-space cardinality. It does not prove a stochastic expectation, construct the oracle, or charge evaluation, memory, or parallel hardware costs.

Strict all-or-nothing target benefit does not itself supply part-wise feedback. The scaffold comparison therefore changes the information available to the searcher. Another function or external mechanism must evaluate and support the intermediates. It remains a meaningful mechanism to investigate, but cannot by itself show that emergence generates its own scaffold.

If each held part costs μ per unit time, holding j parts requires total support ≥jμ, integrated over assembly time. The submitted break-even estimate lacked a common trial-time and evaluation-cost convention. A quantitative support price needs those specified; it is not proved here.

## 9. Evidence and measurement

The reproducible package retains E1–E8, with corrected labels and like-for-like comparisons. Numerical matrix exponentials solve the finite CTMC model without Monte Carlo sampling, but still have floating-point error. “Exact Gillespie” means event-driven simulation without time discretization error, not exact empirical truth.

| Experiment | Quantity actually checked |
|---|---|
| E1 | Reach N=100 before zero, compared with finite birth–death hitting probability; eventual survival shown separately |
| E2 | Reach N=200 before zero under pairwise production; N*=11 marks deterministic drift, not an absolute stochastic barrier |
| E3 | Time to N=2000 conditional on reaching it, compared with an ODE trajectory; no exact equality of stochastic medians and ODE times is implied |
| E4 | Admission ceilings, effort-limited stationary time averages versus ODE equilibria, and example self-financing trajectories |
| E5 | Survival to T=30, CTMC transient probabilities and K₅₀; all finite closed systems eventually go extinct |
| E6 | Recovery at a specified time after a specified finite budget shock, with/without immigration |
| E7 | Finite-target hitting, eventual survival and the two-type spectral condition, kept distinct |
| E8 | Uniform whole-target search, oracle-assisted parallel rounds and an exhaustive sequential bound, with different work units labeled |

For applications, fix what counts as an item and distinguish total count from functional organization. Estimate gains and losses by exposure time and state, with uncertainty; G/L is a local rate-ratio estimate only when losses are sufficiently observed. Estimate the production exponent from log P_raw versus log N in a justified scaling range, **not generally from log(G−L)**: subtracting losses changes the slope near a threshold. Admission censoring and external immigration must be modeled. R_c(N) is a function, N* is a count threshold, and K/N* is not equivalent to η/μ. Four summaries do not uniquely determine a general production law or transient behavior.

Interventions on budget or repertoire can test this closure. A bridge to EbE must additionally show that retained identities/functions causally change later production or accessibility under a matched ablation, rather than only fit a count-dependent birth rate. Dependency graphs, delayed capture, throughput limits, feedback discovery and adaptive parameters remain open extensions.

## 10. Relation to v20 and prior work

This package adds explicit production/loss dynamics to the proposed EbE programme. The ledger exposes conditions for bounding retained count; its combination with a specified production law yields testable regime and timescale questions. The original v20 review itself was not supplied here: [the submitted mapping](provenance/THEORY.submitted.md) is preserved as the author's response, not treated as independently verified evidence that all findings are resolved.

A targeted primary-source check found close prior work:

1. Steel, Hordijk & Kauffman, [Dynamics of a birth-death process based on combinatorial innovation](https://arxiv.org/abs/1904.03290) (2019 preprint): explicitly models combinations of existing items producing new items, item loss and explosive growth. The reproduction framing and combinatorial birth–death mechanism are therefore not new by themselves.
2. Méndez et al., [Demographic stochasticity and extinction in populations with Allee effect](https://doi.org/10.1103/PhysRevE.99.022101) (2019): studies stochastic birth–death Allee models and extinction times. This is a direct comparator for thresholds and metastability.
3. Diekmann, Heesterbeek & Metz, [On the definition and the computation of the basic reproduction ratio R₀ in models for infectious diseases in heterogeneous populations](https://ir.cwi.nl/pub/2026) (1990): supplies the next-generation operator framework.
4. Kolodny, Creanza & Feldman, [Evolution in leaps: The punctuated accumulation and loss of cultural innovations](https://doi.org/10.1073/pnas.1520492112) (2015): a relevant cultural innovation/loss comparator.

This was a targeted check, not a systematic novelty review. Whether the explicit ledger and paid-search combination provides a useful new synthesis remains an open comparison. No priority or universal-law claim is made. A single scalar resource ledger, no matter how internally consistent, does not yet encode the structural content of the full EbE architecture.
