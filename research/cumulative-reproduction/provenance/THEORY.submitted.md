# Cumulative Reproduction: when, and how fast, retained organization runs away

**Status:** a candidate successor to the EbE v20 core, written in response to the v20 adversarial review.
**Formal status:** the discrete-time core is machine-checked in Lean 4 (`lean/CumulativeReproduction.lean`, core library only, no `sorry`). The continuous-time and stochastic results are derived analytically below and checked against exact stochastic simulation (`sim/`). Every number quoted here comes from `sim/results/results.json` (seed 20260922).

---

## 0. The idea in one paragraph

v20 describes *conditions* under which retained organization can open new transitions. It has no law saying whether the resulting process dies out, levels off, or runs away, or how fast it does so.

This document supplies that law by treating cumulative evolution as a **reproduction process of organization**:

- Each retained item helps produce new retained items while it lasts.
- Each item costs upkeep and is eventually lost.

The fate of the process is then set by four dimensionless quantities:

1. the **cumulative reproduction number** R_c (retained offspring per retained item per lifetime);
2. the **critical mass** N* (where R_c first reaches 1);
3. the **budget balance** η/μ (resource capture per item versus upkeep per item), which decides whether a finite ceiling K exists;
4. the **effective arity** κ (how production scales with the repertoire), which sets the speed class.

This is the same logic as R₀ in epidemiology, applied to organization instead of infections.

---

## 1. Objects

| Symbol | Meaning | v20 counterpart |
|---|---|---|
| N | size of the retained repertoire | retained organization R |
| P(N) | rate at which new items are produced **and retained** | kernel-induced accessibility × retention |
| L(N) = δN | loss rate: forgetting, decay, displacement (δ = 1/mean lifetime) | not modelled in v20 |
| B₀ | exogenous gross budget | gross budget |
| η | resource **capture** per retained item | endogenous budget (Dynamic Vortex) |
| μ | **upkeep** per retained item | maintenance M(R) |
| F(N) = B₀ + (η − μ)N | free budget | B_free = B_gross − M(R) |
| K = B₀/(μ − η) | budget ceiling, finite only when μ > η | finite-budget no-go |
| ρ | probability a produced item is retained (fidelity/validation) | retention / admission |

**Admission.** A new item is retained only if the enlarged repertoire is affordable: μ(N+1) ≤ B₀ + η(N+1). All budget quantities are in **one currency**, so the exchange-rate problem of the v20 review (S2) cannot arise.

**Micro-foundation: a self-rewiring hypergraph.** Retained items are nodes. A hyperedge S → y says that the set S of retained items jointly enables producing y; its arity is |S|. Producing y and retaining it adds a node, which creates new hyperedges. Two search regimes give two production laws:

- **Mass-action (free, parallel search):** every enabled combination "fires" at its own rate, as in chemistry or encounter-driven recombination.
  P(N) = ρ [a₀ + Σ_k α_k C(N, k)].
  Here a₀ is from-scratch innovation and α_k the productive rate per k-combination.
- **Effort-limited (search paid from the free budget):** as with agents, R&D, or learning.
  P(N) = (ρφ/c₀) · F(N) · (1 + βN)^γ.
  Here β is **leverage**: retained items make each unit of search more productive, which is v20's kernel advantage. γ is the leverage exponent.

The items are treated as exchangeable (mean field). Items with explicit identities and dependency cascades are listed as an open extension in §8.

---

## 2. The cumulative reproduction number

> **R_c(N) = P(N) / (δN)**: the expected number of new retained items produced per retained item over that item's expected lifetime 1/δ.

The **effective arity** κ = lim_{N→∞} ln P(N) / ln N is 1 for single-unit reuse, k for k-ary composition, and for effort-limited search:

> **κ_eff = γ + [η > μ]**, and there is a ceiling instead when η < μ.

Leverage contributes γ. Self-financing retention contributes one more power of N, because every retained item enlarges the budget that pays for further search.

---

## 3. The laws

### Law 1 — Threshold (whether, locally)

The repertoire grows exactly when R_c(N) > 1, shrinks exactly when R_c(N) < 1, and is at equilibrium exactly when R_c(N) = 1. An equilibrium is stable iff d(P − δN)/dN < 0 there.
*Lean:* `grows_iff`, `shrinks_iff`, `fixed_iff`.

### Law 2 — Runaway and critical mass (whether, globally)

- If R_c > 1 at every N ≥ N₀, the repertoire is unbounded. *Lean:* `runaway`, `runaway_unbounded`.
- If composition has arity ≥ 2, or leverage is present, R_c(N) *increases* with N. There is then a **critical mass** N*, the first upcrossing of R_c = 1:
  - below N* the repertoire collapses, within n₀ steps in the discrete model;
  - above N* it runs away.
  - *Lean:* `collapse`, `extinct_within_own_size`, `critical_mass_dichotomy`.
- Pure pairwise composition, a₀ = 0: with a = ρα₂/2, dN/dt = aN² − (a + δ)N, so
  **N\* = 1 + 2δ/(ρα₂)**.

This is an **Allee effect for organization**. It explains why small or fragmented repertoires lose cumulative culture even when each item is individually useful (Henrich's Tasmania argument): the repertoire is below its compositional critical mass.

### Law 3 — Speed classes (how fast)

- **κ < 1:** growth is bounded, or at most polynomial.
- **κ = 1 (single-unit reuse):** exponential, with N(t) = N₀ e^{δ(R_c − 1)t}.
- **κ > 1 (composition, or self-financing leverage):** finite-time singularity. The Osgood criterion gives the blow-up time
  t* = ∫_{N₀}^∞ dN / (P(N) − δN) < ∞.
- **Arity 2, closed form.** With γ₂ = a + δ:
  - time from n₀ to N₁ = ln[(1 − N*/N₁) / (1 − N*/n₀)] / γ₂;
  - blow-up time t* = −ln(1 − N*/n₀) / γ₂.

  Just above critical mass, runaway is slow (t* diverges logarithmically as n₀ → N*). Far above it, runaway takes about 1/(a·n₀).
- *Lean (discrete analogues):*
  - `linear_excess_exponential`: a gap above c that grows at least like (r+1)^t;
  - `quadratic_excess_doubly_exponential`: a gap of at least gap₀^(2^t), the discrete counterpart of finite-time blow-up.

In the real world a mathematical singularity is always cut off by some other constraint. The law says *which* constraint must intervene: the budget ceiling (Law 4), interference (§8), or saturation of the adjacent possible.

### Law 4 — Budget balance (whether the ledger permits runaway)

- **η < μ (every retained item is a net cost):** every affordable repertoire satisfies N ≤ K = B₀/(μ − η), whatever the leverage, arity or production law. Combinatorial runaway is converted into a plateau. *Lean:* `ceiling_mul`, `le_cap_of_affordable`, `no_runaway_when_upkeep_exceeds_capture`.
  - In effort-limited search the plateau N̂ lies strictly inside the ceiling, because search effort vanishes as F(N) → 0. N̂ is the root of P(N̂) = δN̂.
- **η ≥ μ (retention is self-financing at the margin):** the budget never binds. *Lean:* `self_financing_never_binds`.
  - At η = μ the growth class is set by the leverage, through R_∞ = ρφB₀β/(c₀δ) (for γ = 1).
  - At η > μ the effective arity rises by one.
- **Currency invariance:** rescaling B₀, η and μ by the same factor changes nothing. *Lean:* `affordable_scale_invariant`.

Put differently, **open-ended cumulative runaway requires that retained organization pay its own upkeep at the margin**. It can do this by capturing resources (η), by lowering upkeep (μ), or by compression (sub-linear M(N)). Retention that is a pure cost can accumulate only up to a ceiling. This is the item-level form of a self-maintenance ratio: runaway requires marginal self-maintenance ≥ 1.

### Law 5 — Unaffordable critical mass

If K < N*, the repertoire goes extinct from **any** initial state, however large. The ledger never lets it hold enough items to cross its own critical mass. If N* ≤ n₀ ≤ K, it fills to the ceiling and stays there.
*Lean:* `unaffordable_critical_mass_collapse`, `unaffordable_critical_mass_extinct`, `cap_lt_of_unaffordable`, `affordable_critical_mass_plateau`, `budget_balance_dichotomy`.

*Stochastic margin.* With demographic noise, K > N* is necessary but not sufficient. For persistence of 50% to T = 30 (exact CTMC), the ceiling K₅₀ needed is:

| N* | 4 | 8 | 12 | 16 | 20 | 24 | 28 | 32 | 36 | 40 |
|---|---|---|---|---|---|---|---|---|---|---|
| K₅₀ | 11 | 17 | 23 | 29 | 34 | 39 | 44 | 49 | 54 | 59 |

This is the cumulative-evolution analogue of Bartlett's critical community size. The deterministic threshold is necessary; persistence needs a margin that grows with N*.

### Law 6 — Hysteresis

A *transient* budget shock that pushes the ceiling below N* destroys the repertoire, and restoring the budget does **not** restore it. Recovery then requires from-scratch innovation (a₀ > 0) to climb back over N* against negative drift. That is a slow, escape-type event whose probability can be computed exactly. Loss of cumulative culture is therefore path-dependent, not merely a function of current conditions.

### Law 7 — Nested layers (cross-scale ratchet)

For several interacting layers or types (for example cell, organism, culture), let λ_ij be the rate at which a type-j item produces a type-i item. The **next-generation matrix** is K_ij = ρ_i λ_ij / δ_j, and the system runs away iff **ρ(K) > 1** (spectral radius), exactly as for multi-host infections.

For two layers that are each subcritical alone (k₁₁, k₂₂ < 1), the pair is jointly supercritical iff

> **(1 − k₁₁)(1 − k₂₂) < k₁₂ k₂₁.**

*Proof sketch:* the characteristic polynomial is an upward parabola with vertex (k₁₁+k₂₂)/2 < 1, so its larger root exceeds 1 iff p(1) < 0.

So layers that cannot sustain cumulative change on their own can do so jointly through cross-scale coupling. This is the formal core of the nested "learning-like" claim, and it is testable.

### Law 8 — Scaffold law (emergence becomes load-bearing)

Take an all-or-nothing target of arity k with q options per part. Strict emergence means the target gives no part-wise feedback.

- **No retained, evaluable intermediates:** q^k expected trials.
- **Part-wise feedback with found parts retained:**
  - sequential search: ≤ k·q trials (*Lean:* `scaffolded_search_cost`);
  - parallel re-drawing of the missing parts: E[max of k Geometric(1/q)] ≈ ln k / ln(q/(q−1)).
- k·q ≤ q^k for q ≥ 2, strictly for k ≥ 3. *Lean:* `scaffold_never_worse`, `scaffold_strict`.

The v20 barrier still holds: held intermediates earn no target benefit. The scaffold must therefore be financed by **auxiliary support at a rate of at least μ per held part**. Scaffolding pays when c·(q^k − kq) exceeds roughly μ·k²·q.

In v20 the emergence premise did no work (review F1). Here the **arity k enters exponentially**, and the price of the barrier, and hence of the auxiliary support it demands, is a computable quantity. The law is also exactly Dawkins' *cumulative selection*: the "weasel" is scaffolded search with retention, which fits naturally here although it did not fit v20's kernel-only notion of cumulative change (review §6).

---

## 4. Evidence: exact stochastic simulation against theory

All experiments use exact Gillespie simulation of the continuous-time Markov chain (CTMC). Figures are in `sim/figures/`.

| Exp. | Claim tested | Result |
|---|---|---|
| **E1** | Runaway probability = 1 − R_c^(−n₀), arity 1 | 2,000 runs × 11 values of R_c × n₀ ∈ {1, 3}. Max \|sim − exact\| = 0.012. Exact value inside the 95% CI in 22/22 cases. Zero runaway for R_c ≤ 1. |
| **E2** | Critical mass N* = 11 (α₂ = 0.2) | 1,500 runs per n₀. Max \|sim − exact birth–death\| = 0.017 (14/15 inside the CI). Runaway probability 0.13 at n₀ = 8, 0.58 at 12, 0.99 at 20. |
| **E3** | Arity-2 time to N = 2000 | Median simulated time vs closed form: n₀ = 20 gives 0.718 vs 0.721; n₀ = 30 gives 0.410 vs 0.410; n₀ = 50 gives 0.224 vs 0.221; n₀ = 100 gives 0.102 vs 0.101. Near N* (n₀ = 13), noise dominates and 31% of runs die. |
| **E4a** | Budget ceiling under arity-2 runaway | Ceilings 60 and 30 hold exactly. Ceiling 8 < N* gives extinction by t ≈ 2.5. With η = μ, runaway to 5,000 by t ≈ 1.7. |
| **E4b** | Effort-limited plateau P(N̂) = δN̂ | For μ = 0.2 … 4, deterministic N̂ = 47.6, 29.2, 20.0, 15.9, 13.5, 10.7, 9.0. Simulated time averages are 45.2, 27.8, 19.3, 15.4, 12.7, 10.2, 8.5: within 3–6% and slightly below, as expected for a stochastic process. |
| **E4c** | κ_eff = γ + [η > μ] | η = μ (R_∞ = 1): linear growth (≈ 330 items by t = 40). η > μ: finite-time runaway (3,000 items by t ≈ 8). |
| **E5** | Unaffordable critical mass ⇒ extinction | Across 100 (K, N*) cells × 150 runs: persistence is **exactly 0 in every cell with K < N***. Max \|sim − exact CTMC\| = 0.058. Stochastic margin as in the Law 5 table. |
| **E6** | Hysteresis after a budget shock | Recovery by t = 80, sim vs exact: ceiling 24 gives 0.956 vs 0.952; ceiling 16 (> N*, inside the margin) gives 0.056 vs 0.055; ceiling 8 < N* gives 0.000 vs 0.000; ceiling 8 with a₀ = 1.5 gives 0.309 vs 0.312. |
| **E7** | Nested layers | k₁₁ = k₂₂ = 0.6. Runaway appears exactly past c* = 0.40. Sim vs exact multitype branching at c = 0.5 / 0.6 / 0.7 / 0.8: 0.093/0.091, 0.163/0.167, 0.234/0.231, 0.285/0.286. The 2×2 criterion had 0 mismatches in 100,000 random matrices. |
| **E8** | Scaffold law, q = 4 | Unscaffolded trials match 4^k (simulated for k ≤ 6). Scaffolded trials rise only from 4.0 to 10.7 as k goes from 1 to 10, matching the E[max-geometric] formula to within 0.1. |

---

## 5. What this adds to a theory of evolution

**Claim.** Cumulative evolution, in any substrate, can be analysed as a reproduction process of retained organization on a self-rewiring hypergraph. Its qualitative fate and its speed are fixed by four dimensionless groups: R_c, N*, K/N* (equivalently η/μ), and κ.

This yields **predictions that the v20 conditions and the utility-problem literature do not state**:

1. **Critical mass (Allee threshold).** Removing a fraction f of a repertoire is predicted to cause collapse iff N(1 − f) < N*. The dose–response is sigmoidal rather than proportional.
2. **Ceiling scaling.** Where retention is a net cost, plateau size scales as B₀/(μ − η) (mass-action), or lies strictly inside that bound (effort-limited). Doubling upkeep roughly halves the plateau.
3. **Self-financing transition.** Accelerating (super-exponential) cumulative growth should appear only where retained items raise the budget or lower upkeep at the margin (η ≥ μ). Examples: tools that capture energy, institutions that lower transaction costs, compression.
4. **Speed class from arity.** The log-log slope of the net gain rate against N estimates κ. Compositional systems (κ > 1) show finite-time-like bursts cut off by a ceiling; single-unit systems grow exponentially.
5. **Hysteresis.** A transient budget or population shock that lowers the ceiling below N* causes a loss that is not reversed when conditions recover, except by slow re-ignition.
6. **Cross-scale supercriticality.** Coupled layers can sustain cumulative change that neither layer sustains alone, iff ρ(K) > 1.
7. **Scaffold price.** For an emergent function of arity k, the auxiliary support needed during assembly grows with k·μ. Without evaluable intermediates, assembly time grows as q^k.

**Relation to existing work, stated conservatively.**

- R₀ and next-generation matrices (Diekmann, Heesterbeek & Metz 1990), Allee effects, and critical community size (Bartlett 1957) supply the mathematics.
- The TAP equation (Steel, Hordijk, Kauffman) and autocatalytic RAF sets supply combinatorial runaway.
- Henrich (2004) and Kolodny, Creanza & Feldman (2015) supply population-size and loss effects in culture.
- Simon (1962) and the explanation-based-learning utility problem supply scaffolding and paid retention.

What I have not found stated together is the **combination**: an upkeep ledger that turns combinatorial runaway into a ceiling unless η ≥ μ; the resulting *unaffordable-critical-mass* extinction; the rule κ_eff = γ + [η > μ]; and nested supercriticality applied to organization. This should be checked against the literature before any priority is claimed.

---

## 6. How this repairs the v20 review findings

| v20 finding | Repair here |
|---|---|
| F1: emergence premise idle | Law 8: arity k enters the assembly cost exponentially; auxiliary support has a computable price. |
| F2 / S1: cost-reducing retained items excluded; negative marginal upkeep treated as an artifact | η and μ are *the* runaway variables. Upkeep-lowering or resource-capturing items are what make open-ended growth possible (Law 4). |
| S2: exchange rate between currencies | A single ledger; R_c is dimensionless; affordability is currency-invariant (Lean). |
| S3: 0/1 accessibility | Stochastic CTMC: runaway *probabilities*, exact persistence, hysteresis. |
| F5: the loop is not formalized | Dynamics are now the object itself: retain → produce → retain, with loss and budget, iterated. |
| F6: inconsistent ledgers; DynamicVortex retains items for free | One ledger throughout. Monotone retention without upkeep is the η ≥ μ case and is labelled as such. |
| F4 / S7: bounded leverage misses generative rules | κ classifies single-unit, compositional and generative growth. The v20 N·d bound is the κ ≤ 1, bounded-N special case. |
| Probe 7: cumulative selection does not fit | Cumulative selection is Law 8 (scaffolded search). |
| Universality stated as analogy | Universality becomes testable: estimate R_c(N), N*, K, κ and ρ(K) per substrate and check the predicted regime. |

---

## 7. How to measure it in a real system

1. From a time series of a repertoire (tool types, lexicon, patents, program library, immune clonotypes, Avida functions), count per period the gains G_t and losses L_t, binned by N.
2. Estimate R̂_c(N) = G/L. Its crossings of 1 give N* (upward crossing) and N̂ (downward crossing).
3. The slope of log(G − L) against log N estimates κ.
4. Estimate μ and η from resource accounting: energy, time, compute or money per retained item.
5. Validate by intervention: ablate a fraction of the repertoire (Law 5 predicts collapse iff below N*), or change the budget (Laws 4 and 6).

Good first testbeds, because the currency is natural:

- program-library learning (DreamCoder-style, where compute is the budget);
- Avida, where instruction upkeep can be charged;
- transmission-chain experiments with an imposed memory load.

---

## 8. Limitations and open extensions

- **Mean field.** Items are exchangeable. An explicit hypergraph with identities would add dependency cascades (losing a hub item disables many hyperedges) and rediscovery of lost items. These are likely to modify N* and the stochastic margin, and are the next simulation to build.
- **Signed effects.** Interference or entrenchment, i.e. retained items that close routes (catastrophic interference, immune imprinting), enters as a negative term −εN² in P. It produces a ceiling even when η ≥ μ. Derived here but not yet simulated.
- **Constant parameters.** δ, ρ, η and μ are held fixed. Letting them depend on N (for example, compression lowering μ as the repertoire grows) is where coupling to the Dynamic Vortex belongs.
- **Formal scope.** Lean proves the discrete-time integer model: threshold, runaway, collapse, critical mass, both growth classes, the ceiling, unaffordable critical mass, the plateau, currency invariance and the scaffold bounds. The continuous-time blow-up times, the stochastic formulas and the 2×2 nested criterion are derived analytically and checked numerically, not machine-checked. Mathlib was unavailable in the build environment.
- **Stochastic margin.** K₅₀ is computed exactly (CTMC) but has no closed form yet.
