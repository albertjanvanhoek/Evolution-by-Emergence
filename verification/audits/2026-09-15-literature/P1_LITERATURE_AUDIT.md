# P1 Literature Audit — What Survives Literature Contact?

## Executive verdict

This audit compares twelve named results in the *Evolution by Emergence / Organizational Accessibility* stack with their nearest identifiable published antecedents. The requested classification is **novel / sharpening of a known result / rediscovery**. I also record a **novelty residue** because the three-way label alone is too coarse: a claim can use an old mechanism but still contribute a useful exact inequality, counterexample, or cross-domain formalization.

The overall result is sobering but not destructive.

- **7 of 12** are best classified as **rediscoveries or elementary corollaries** of established mathematics/physics once stripped of the framework's terminology.
- **5 of 12** are best classified as **sharpenings of known results**: the general phenomenon is established, but the stack gives an exact boundary, a particular constructive witness, or a clean model-specific instantiation.
- **0 of 12** can presently be defended, on this audit alone, as a **high-confidence new general theorem**.

The strongest residues are not new mechanisms. They are: (i) exact model-specific separation of establishment and maintenance thresholds; (ii) exact closed-form alignment boundaries in the regulation model; (iii) an organizational fixed-resolution corollary assembled from physical speed-limit assumptions; and (iv) the explicit budgeted-accessibility formalism, including the two-click witness and declaration-relative retained repertoire.

The stack therefore looks less like a new mathematical field than some drafts imply. It looks more like a **unifying architecture containing several exact toy-model results**. That can still be publishable and useful, but the novelty claims should be narrower.

The original P1 failure criterion — “eight or more rediscoveries means synthesis” — is not robust. The boundary between “rediscovery” and “sharpening” depends on whether one values a new closed-form result in a new toy model. More importantly, one important sharpening can matter more than several trivial rediscoveries. The scientifically useful question is therefore: **what substantive novelty residue remains after the nearest antecedent is stated explicitly?**

---

## Method and classification rule

The audit starts from the twelve claims listed in `outstanding_problems.md`. For each claim I searched the closest parent literatures, prioritizing primary research and established reviews: next-generation matrices and chemostats; autocatalysis and population persistence; backward bifurcation/Allee effects; ecological stability; synthetic-biology burden and retroactivity; evolutionary control; thermodynamic speed limits; cumulative culture and historical contingency; catalysis; stochastic order/truncation; viability theory; and niche construction.

The classifications mean:

- **Novel** — no close antecedent found for the substantive theorem/mechanism, and the result cannot be reduced to a standard identity plus new notation. “No antecedent found” is evidence, not proof of priority.
- **Sharpening** — the phenomenon is already established, but the stack contributes an exact inequality, boundary, witness, or formal specialization not located in the targeted search.
- **Rediscovery** — the substantive result is already standard, or follows immediately from a standard definition/identity; any novelty is primarily vocabulary or application.

Confidence is about the classification, not about mathematical correctness.

---

## Audit matrix

| # | Stack result | Nearest antecedent(s) | Classification | Confidence | Novelty residue that survives | Consequence for framing |
|---|---|---|---|---|---|---|
| 1 | `R_org = Jρ(B)/(ℓd)` and resource-limited replacement model | Next-generation-matrix thresholds; chemostat/resource-limited growth; dynamical autocatalysis | **Rediscovery / specialization** | High | A generic organizational interpretation of an NGM/spectral threshold in one compact replacement model | Do not claim a new reproduction-number theory; cite NGM/autocatalysis explicitly |
| 2 | Interior fold with `J_fold < J_inv` (hysteretic retention) | Backward bifurcation; strong Allee effects; subthreshold endemic equilibria | **Sharpening** | High | Exact closed-form threshold separation for the specified seed-dependent resource model | Claim the exact model result, not the general idea that establishment can be harder than maintenance |
| 3 | Mean fitness/growth pinned at loss rate at every positive equilibrium | Chemostat steady state `μ=D`; equilibrium birth/growth = loss balance | **Rediscovery** | Very high | Useful warning that equilibrium persistence metrics need not measure progress | Present as a standard equilibrium identity used diagnostically |
| 4 | Five non-equivalent organizational coordinates | Multidimensional ecological stability; many non-equivalent ecosystem/network measures | **Sharpening / synthesis** | High | A constructive model in which the chosen coordinates can be shown explicitly to diverge/move oppositely | The broad “no single persistence metric” claim is old; the exact counterexample/profile is the contribution |
| 5 | `κ_crit = M⁰` — extraction tolerance equals pre-extraction margin | Resource competition, burden, retroactivity, fan-out/load limits | **Rediscovery / elementary corollary** | Medium-high | One normalized slack variable recurring across several *same-topology* loads | Avoid “universal constant”; claim common slack for a defined uniform-dilution class |
| 6 | Selected control ≠ sufficient control; master alignment inequality | Evolutionary tradeoff between regulatory effectiveness and economy; robust-control tradeoffs | **Sharpening** | High | Exact closed-form misalignment boundary in the chosen model | Strong paper if sold as an explicit solvable boundary, not as discovery that optimal control can be functionally insufficient |
| 7 | Fixed-resolution no-go and finite-action bound | Thermodynamic length; finite-time dissipation bounds; stochastic/quantum speed limits | **Sharpening / application** | High | A clean organizational-depth corollary and explicit fixed-resolution counting bound under stated physical assumptions | State clearly that the mathematical engine is Cauchy–Schwarz + assumed speed-limit inequality |
| 8 | Retention (`⊆`) vs cost domination (`≤`) as competing ratchet orders | Sublevel-set inclusion and pointwise order are elementary; viability/reachability uses admissible sets | **Rediscovery / elementary formalization** | Very high | The *interpretive* separation is useful, especially when a shared-budget load makes domination impossible while retention survives | Do not claim the order-theoretic implication as new mathematics |
| 9 | Two-click existence witness — earlier retained step finances later one | Historical contingency, potentiation, stepping-stone mutations, cumulative culture | **Sharpening** | High | Exact finite-budget constructive witness in which click 1 raises margin enough to make click 2 feasible | Present as a formal minimal witness for a known phenomenon, not discovery of potentiation |
| 10 | Winding/spending identity `(1+M_{t+1})/(1+M_t)=c*_t/c*_{t+1}` | Algebra of a normalized slack ratio | **Rediscovery / definitional identity** | Very high | Compact bookkeeping variable and terminology that may unify several models | Useful notation, not theorem novelty |
| 11 | Affinity volcano, upkeep and turnover channels | Sabatier principle / volcano plots; generic benefit-cost optima | **Rediscovery** | Very high for turnover; high for upkeep | Distinguishing two causal routes to an optimum can be pedagogically useful | Explicitly position turnover channel as Sabatier; upkeep as generic cost-benefit tradeoff |
| 12 | `P(Y<0 | Y≤w)=p₋/F(w)` and increasing winding fraction as `w↓` | Truncated conditional distributions and stochastic ordering | **Rediscovery / elementary probability** | Very high | Interpretation as state-dependent filtering of candidate composition | Do not call it a new probabilistic theorem; use it as a lemma/interpretive consequence |

---

# Detailed audit

## 1. `R_org = Jρ(B)/(ℓd)` and the resource-limited replacement model

### Stack claim

The base model couples an active nonnegative production network to a supplied resource. At the organization-free equilibrium, the resource is `r0=J/ℓ`; linearizing the active network gives `ẋ=(r0 B-dI)x`; hence the growth threshold is the Perron root of `(r0/d)B`, giving

\[
R_{\rm org}=\frac{J\rho(B)}{\ell d}.
\]

### Literature contact

This is structurally the **next-generation matrix** construction. Van den Driessche and Watmough formalized `R0` as the spectral radius of a next-generation operator and linked `R0<1`/`R0>1` to local stability/instability of the disease-free equilibrium.[1] The manuscript itself already recognizes this mapping.

The autocatalysis literature also uses a Perron/Lyapunov eigenvalue of the diluted network to characterize dynamical autocatalysis. Unterberger and Nghe explicitly relate positive growth of diluted autocatalytic reaction networks to a positive Lyapunov exponent/Perron structure, with degradation competing against amplification.[2]

The resource equation is additionally chemostat-like: finite inflow, washout/loss, growth supported by limiting substrate. The exact notation and interpretation are yours, but the threshold architecture is established.

### Verdict

**Rediscovery / specialization.**

### Novel residue

The residue is architectural: one compact “organizational replacement” model allows the same spectral threshold language to be carried across cells, institutions, or other executing-process networks. That can be useful synthesis. It is not a new spectral threshold theorem.

### Framing consequence

Write: “We specialize standard next-generation/Perron threshold reasoning to a resource-limited replacement network.” Do not write: “We derive a new general reproduction number for organization.”

---

## 2. Interior fold and `J_fold < J_inv`

### Stack claim

In the seed-dependent nonlinear extension, the new component can invade only above an invasion threshold `J_inv`, while the established expanded organization persists down to a lower saddle-node/fold `J_fold`; for an interior fold the manuscript derives a strict positive gap.

### Literature contact

The general phenomenon is classic. Van den Driessche and Watmough explicitly discuss subthreshold endemic equilibria and backward bifurcation.[1] Cushing develops backward bifurcation and strong Allee effects in structured population models, emphasizing that positive populations can persist below the invasion/reproduction threshold if density is sufficiently high.[3]

Thus the scientific content “harder to establish than to maintain,” bistability, history dependence, and survival below an invasion threshold is not new.

I did **not** find the same ODE, the same fold formula, or the exact algebraic inequality from this resource-limited A–B–C model in the targeted search.

### Verdict

**Sharpening of a known result.**

### Novel residue

The exact model-specific theorem: under the stated parameter condition an interior fold exists and the derived formula guarantees `J_fold<J_inv`. That is a legitimate exact result, even though the mechanism is backward bifurcation/Allee hysteresis.

### Framing consequence

The paper should say: “We provide a minimal resource-accounting realization with an analytically separated invasion and persistence threshold,” not “we discover a new ratchet mechanism.”

---

## 3. Mean fitness/growth pinned to the loss rate at positive equilibrium

### Stack claim

At a positive equilibrium the realized average replacement/growth rate is forced to equal the common loss rate, so equilibrium mean fitness cannot by itself measure “progress.”

### Literature contact

This is a standard steady-state balance. In a chemostat, `dX/dt=(μ-D)X`, so a nonzero steady state requires `μ=D`. Reviews state this explicitly: at steady state, the specific growth rate equals the dilution rate.[4]

Analogous equalities appear throughout birth–death, replicator, chemostat, and population-balance models: if a positive stock is constant, realized production equals realized loss.

### Verdict

**Rediscovery.**

### Novel residue

The value is rhetorical/diagnostic: it blocks a tempting but invalid interpretation of equilibrium growth as a monotonic progress measure. That is useful in the synthesis but not theorem novelty.

---

## 4. Five non-equivalent organizational coordinates

### Stack claim

The manuscripts separate quantities such as spectral growth potential, equilibrium resource requirement, maintained mass/abundance, persistence, and independently declared functional performance, and construct examples where they do not rank systems in the same way.

### Literature contact

Ecology has long treated stability as multidimensional. Donohue et al. explicitly argue that variability, resistance, resilience, persistence, and related stability components are non-equivalent and can respond differently to disturbance.[5] Ecological network analysis likewise contains many system-wide measures that capture different structural or functional properties rather than a single canonical ranking.[6]

So the broad statement “persistence/stability/function/size are not one coordinate” is established.

I did not locate the exact five-coordinate package or the same resource-limited constructive examples in the targeted search.

### Verdict

**Sharpening / synthesis.**

### Novel residue

The strongest residue is the *constructive counterexample*: within one transparent model, the stack can show exactly which coordinates stay fixed, improve, or worsen under particular interventions. That is stronger than simply citing “stability is multidimensional.”

### Framing consequence

Position the paper as a formal demonstration that several commonly conflated organizational observables are logically and dynamically non-equivalent in one explicit model, while citing multidimensional-stability literature as antecedent.

---

## 5. `κ_crit=M⁰`

### Stack claim

For uniform dilution/loading, if `c*` is the binding inherited cost under budget `B`, define `M⁰=B/c*−1`. Retention is possible exactly when `κ≤M⁰`. The same normalized margin recurs as a bound on a non-returning parasite/load, regulatory overhead, and a new downstream module when these share the same one-way load topology.

### Literature contact

Synthetic biology has an extensive literature on finite shared cellular resources, expression burden, downstream loading, retroactivity, and fan-out. Qian et al. show that resource competition among genetic circuits generates unintended couplings and qualitative changes in response.[7] Del Vecchio and colleagues developed retroactivity as the loading effect that interconnected modules impose on upstream dynamics.[8] Kim and Sauro formalized fan-out as the maximum number of downstream inputs that an upstream transcription factor can regulate and related it directly to retroactivity.[9]

What I did not find is the exact symbol `M⁰` or the exact equality `κ_crit=M⁰`, but mathematically that equality follows immediately once `M⁰` is **defined** as normalized slack: `(1+κ)c*≤B` iff `κ≤B/c*−1`.

### Verdict

**Rediscovery / elementary corollary.**

### Novel residue

The useful residue is not the inequality. It is the observation that parasite, regulator, and acquisition instantiate the *same load topology* and therefore share one normalized slack variable. That is a possible cross-domain unification, provided the mapping is stated narrowly.

### Framing consequence

The later manuscript's corrected wording is right: `M⁰` is a common slack variable for the **uniform-dilution class**, not a universal budget constant.

---

## 6. Selected control ≠ sufficient control; master alignment inequality

### Stack claim

A regulator chosen by an internal/selection objective can have a gain `k_opt` that maximizes net performance while failing an independently declared functional bound requiring `k≥k_func`. In the current model this yields a closed-form alignment boundary (equivalently a nonnegative optimal margin condition).

### Literature contact

The general conflict is established. Szekely et al. model biological homeostasis as a Pareto tradeoff between regulatory effectiveness and economy/protein burden.[10] Frank develops evolutionary regulatory control explicitly in terms of tradeoffs among tracking performance, robustness, stability, and control costs.[11] Engineering control likewise distinguishes unconstrained performance optimization from regulation/constraint satisfaction.

Therefore “an internally optimal controller need not meet an external functional threshold” is not a new general insight.

I did not find the same one-dimensional model or the same closed-form boundary `η≤A m²/c0` in the targeted search.

### Verdict

**Sharpening of a known result.**

### Novel residue

The exact alignment inequality is a clean analytic result: it tells you where the selected optimum crosses the declared sufficient-control boundary. This can be publishable as a minimal model/counterexample if the framing is modest and the biological/institutional interpretation is not overextended.

### Framing consequence

The central sentence should be “selected control need not equal sufficient control, and in this model the misalignment boundary is exactly …”. The novelty is the solvable boundary, not the qualitative existence of tradeoffs.

---

## 7. Fixed-resolution no-go and finite-action bound

### Stack claim

If each transition satisfies a speed-limit/action inequality of the form

\[
\varepsilon_n\tau_n\ge c_n d_n^2,
\]

with `c_n≥c_*>0`, finite total energy/action and finite total time imply

\[
\sum_n d_n \le \frac{1}{\sqrt{c_*}}\sqrt{ET}.
\]

Hence a fixed operational resolution `d_n≥δ` permits only finitely many distinguishable transitions:

\[
K_\delta\le \delta^{-1}\sqrt{ET/c_*}.
\]

### Literature contact

The physical ingredients are established. Crooks' thermodynamic length is a metric distance that asymptotically bounds dissipation in finite-time transformations.[12] Sivak and Crooks derive a thermodynamic metric controlling dissipation of finite-time protocols.[13] Shiraishi, Funo, and Saito derive speed-limit inequalities linking transformation speed to entropy production and dynamical activity.[14] Quantum speed limits likewise bound distinguishable state changes by energy/time.

Given the assumed per-step inequality, the stack's aggregate bound is essentially Cauchy–Schwarz. The fixed-resolution count then follows immediately by `Kδ≤Σd_n`.

### Verdict

**Sharpening / application.**

### Novel residue

The residue is the organizational statement: finite energy and finite time cannot support infinite **fixed-resolution** organizational depth under a nondegenerate per-step cost, while infinite indexing remains possible if physical or operational resolution shrinks. That is a clean synthesis/corollary across speed-limit ideas.

### Framing consequence

The manuscript should continue to say that it formalizes the mathematical core **conditional on the physical speed-limit premise**; it should not imply that Cauchy–Schwarz itself is a new no-go theorem.

---

## 8. Retention (`⊆`) versus cost domination (`≤`)

### Stack claim

For costs `c_t(x)` and budget `B`, define accessibility `A_t(B)={x:c_t(x)≤B}`. Pointwise cost domination `c_{t+1}(x)≤c_t(x)` implies retained accessibility `A_t(B)⊆A_{t+1}(B)`, but not conversely. Under uniform dilution, every inherited cost may rise while the accessible set is still retained.

### Literature contact

The first implication is elementary sublevel-set order: pointwise lowering of a function expands every sublevel set. The converse is false because a cost can rise without crossing the selected threshold. Sublevel sets are standard objects in optimization.[15]

Viability and reachability theories are also built around admissible/viable sets rather than requiring monotonic improvement of a global cost function.[16]

### Verdict

**Rediscovery / elementary formalization.**

### Novel residue

The useful contribution is conceptual: forcing cumulative change to satisfy pointwise domination is unnecessarily strong; the appropriate retained-property notion may be threshold-set inclusion on a declared inherited repertoire. The shared-budget example makes that distinction concrete.

### Framing consequence

Do not advertise `(D)⇒(R)` as theorem novelty. Advertise the choice of order as a modeling/design decision and show why it changes the verdict.

---

## 9. The two-click existence witness

### Stack claim

An exact rational example shows a first retained change increasing margin enough that a second change becomes retainable; without the first change, the second would evict an inherited capability. This is intended as an existence proof of cumulative, path-dependent accessibility under a shared budget.

### Literature contact

The phenomenon is strongly established in evolutionary biology. Blount, Borland, and Lenski showed that citrate utilization in the LTEE depended on historical potentiation: the innovation became accessible only in a particular evolved background.[17] Genomic reconstruction subsequently separated potentiation, actualization, and refinement.[18] Leon et al. further showed that evolutionary competition can hide or expose a stepping-stone needed for later innovation.[19]

Cumulative-culture theory also explicitly studies accumulation of innovations and their acquisition costs; Mesoudi models cases where accumulated cultural complexity constrains future innovation and where innovations can reduce acquisition/innovation costs.[20]

What appears distinctive in the stack is the **exact finite-budget witness** expressed solely in terms of retained accessible sets and margin financing.

### Verdict

**Sharpening / formal witness of a known phenomenon.**

### Novel residue

A minimal algebraic example proving that one retained step can finance another under an explicit shared budget. This is not the discovery of historical contingency or potentiation; it is a compact formalization.

### Framing consequence

Call it an exact constructive witness for cumulative accessibility, and cite potentiation/cumulative-culture antecedents prominently.

---

## 10. The winding/spending identity

### Stack claim

With binding inherited cost `c*_t` and `1+M_t=B/c*_t`, every step satisfies

\[
\frac{1+M_{t+1}}{1+M_t}=\frac{c^*_t}{c^*_{t+1}}.
\]

Lower binding cost “winds” the ratchet; higher binding cost “spends” margin.

### Literature contact

This is direct algebra from the definition of `M_t`. The same kind of ratio identity appears whenever slack/capacity is normalized by a binding cost or constraint.

### Verdict

**Rediscovery / definitional identity.**

### Novel residue

The notation may be useful: it makes a history of changes composable in one dimension and cleanly distinguishes winding from spending. That is bookkeeping architecture, not theorem novelty.

---

## 11. Affinity volcano — turnover and upkeep channels

### Stack claim

Affinity can have an interior optimum either because weak binding prevents productive engagement while strong binding slows release/turnover, or because stronger affinity increases an ongoing maintenance/upkeep burden.

### Literature contact

The turnover channel is the **Sabatier principle**: catalytic activity is maximized at intermediate binding strength because binding that is too weak gives insufficient reaction/intermediate formation while binding that is too strong impedes later steps/desorption. Volcano plots are the canonical representation.[21]

The upkeep channel is not the classical Sabatier mechanism, but it is a generic benefit–cost optimum: if benefit saturates and cost rises with affinity, an interior optimum is expected. Analogous economy–effectiveness tradeoffs are standard in biological regulation.[10]

### Verdict

**Rediscovery.**

### Novel residue

Separating the two causal routes is worthwhile because similar-shaped volcanoes can have different mechanisms. That is interpretive clarification, not a new volcano law.

### Framing consequence

The manuscript should explicitly state that the turnover channel is a Sabatier-type result and present the upkeep channel as a distinct model-specific cost mechanism.

---

## 12. Filtering proposition `P(Y<0|Y≤w)=p₋/F(w)`

### Stack claim

If the retention filter is `Y≤w` with viable `w≥0`, then every winding candidate `Y<0` automatically passes. Therefore

\[
P(Y<0\mid Y\le w)=\frac{P(Y<0)}{P(Y\le w)}=\frac{p_-}{F(w)},
\]

which increases as `w` falls.

### Literature contact

This is the definition of a truncated conditional distribution plus the set inclusion `{Y<0}⊂{Y≤w}` for `w≥0`. There is a broad literature on stochastic order under conditioning/truncation; Whitt's work on conditional stochastic order is an early example.[22]

No specialized literature is needed to justify the displayed formula itself.

### Verdict

**Rediscovery / elementary probability.**

### Novel residue

The useful point is the interpretation: tightening a viability threshold can alter the **composition of retained variation without changing the generated distribution**. That distinction may belong in a synthesis, but the probability identity is not a new theorem.

---

# P3 as part of P1: does the conjunction survive?

The original P3 proposed a distinctive conjunction:

1. a **declared inherited repertoire**;
2. a **shared finite budget**;
3. a future constraint **generated by the system's own retained history**.

This is the right place to look for a larger contribution, but the parent-literature premises need narrowing.

## Viability theory already has endogenous state and state-dependent admissibility

It is too strong to say viability theory uses only exogenous constraints. Aubin's survey explicitly covers nonlinear control with **state constraints and state-dependent control constraints**.[16] Applied viability models can include an exhaustible resource as a state variable and compute the viability kernel for coupled resource–production systems; Martinet and Doyen do exactly this for a production-consumption system based on an exhaustible resource.[23]

What may still be distinctive is not “the constraint depends on state,” but the more specific claim that the **retained repertoire itself contributes to the maintenance cost that determines the future admissible repertoire**.

## Cumulative-culture theory already couples accumulated repertoire and acquisition cost

Mesoudi's 2011 model is especially close to the conjunction. It assumes that as cultural complexity accumulates, it becomes increasingly costly for the next generation to acquire; complexity can hit an upper bound above which further innovation is impossible; and some innovations can themselves reduce acquisition or innovation costs.[20]

Therefore “cumulative culture has ratchets but no resource accounting” is not a safe premise.

The remaining possible distinction is narrower: a declared set of *functions/capabilities* retained under one shared budget, with an explicit binding-cost margin and formal set-inclusion criterion.

## Niche-construction theory already has history-generated future constraints

Niche construction and ecological inheritance explicitly describe organisms altering environments in ways that modify the selection pressures experienced by descendants.[24,25] Prior activity can therefore generate part of the future constraint landscape. This is close in spirit to “history produces the constraints the system later faces.”

Again, what may be different in the stack is the **budgeted operationalization** of this feedback, not the general feedback idea.

## P3 provisional verdict

The broad conjunction is **not literature-cleared as novel**. Important pieces already co-occur in cumulative culture, viability, resource competition, and niche construction.

The narrower candidate residue worth testing further is:

> **A declared inherited capability set is represented as a budget sublevel set; retained history changes the binding maintenance cost of that same set; this changes the set of future capabilities that remain budget-accessible.**

I did not find an exact antecedent to that full formal package in this audit. That is **not yet a novelty claim**; it is the most promising target for a second, narrower search.

---

# What the audit says about the paper stack

## 1. Organizational Accessibility / From Self-Maintenance to Evolvability

The base `R_org` threshold is not novel mathematics. The backward-bifurcation mechanism is known. Evolvability and facilitated variation have deep literatures. The paper's strongest defensible contribution is therefore the **assembly** of these pieces in one resource-accounting model, plus an exact threshold separation in the nonlinear worked example.

Recommended claim:

> We give a minimal resource-limited process network in which standard spectral establishment, a seed-dependent backward bifurcation, and changes in future variation can be represented within one bookkeeping framework.

Avoid implying that reproduction numbers, hysteresis, or evolvability were newly derived in general.

## 2. Persistence Does Not Measure Function

Its broad thesis has strong antecedents in multidimensional ecological stability and the general distinction between persistence and functional performance. The publishable residue is a **constructive formal counterexample** showing that multiple organizational observables can move independently, plus the explicit declaration firewall for function.

This can still be a strong conceptual/methods note if it is positioned as “a minimal counterexample to scalarizing organizational performance,” not “the discovery that persistence is not function.”

## 3. When Does Regulation Pay?

The broad economy–effectiveness tradeoff is established. The paper should foreground its **closed-form selection–sufficiency gap** and exact phase boundary. That is a useful analytic example of a general issue, especially if the assumptions are transparent and the phase diagram is correct.

## 4. Organizational Depth at Finite Time

This appears suitable as a rigorous note/corollary paper if it is explicit that the physical inequality is an assumption imported from speed-limit/thermodynamic-length ideas. The distinctive part is the translation into **fixed-resolution organizational depth**, the clear no-go statement, and the loophole taxonomy (shrinking resolution, vanishing coefficients, unbounded resources, etc.).

It should not be framed as a new fundamental speed limit.

## 5. When Does Change Become Cumulative?

This may be the strongest **architectural** paper, but it is also where literature contact bites hardest. Historical contingency/potentiation, acquisition-cost constraints, niche construction, and reachability all pre-exist. The possible residue is the declared budget-accessible repertoire and explicit separation between pointwise cost domination and retained threshold accessibility, plus the exact two-click budget witness.

This paper needs the most careful positioning against Mesoudi, LTEE potentiation, viability theory, and niche construction before submission.

## 6. Affinity and filtering branches

These should not be sold as standalone novelty based on the current evidence. The Sabatier correspondence is direct; the filtering proposition is elementary truncation. They can serve as examples or lemmas inside a larger synthesis.

---

# Does the original P1 failure criterion trigger?

Strictly applying the requested three classes gives:

- **Rediscovery:** 1, 3, 5, 8, 10, 11, 12 = **7**
- **Sharpening:** 2, 4, 6, 7, 9 = **5**
- **Novel:** **0** high-confidence

So the literal “8 rediscoveries” rule does **not** trigger by one claim.

But that numerical answer is misleading. If “sharpening” is reserved only for a result with independent scientific content beyond a new worked example, claims 4 and 7 could reasonably move into rediscovery/application, making **9**. Conversely, claim 2 could arguably be called “novel in this model.” The count is therefore classification-sensitive.

The more robust conclusion is:

> **The audit does not support presenting the stack as a collection of twelve new theoretical discoveries. It supports presenting it as a synthesis/architecture with a handful of exact model-specific results.**

That is not a demotion to “nothing.” A good synthesis can be valuable if it makes a previously fragmented set of ideas operationally comparable and yields new cross-domain questions. But the burden for novelty now falls on the **architecture or conjunction**, not on most individual mathematical ingredients.

---

# Priority recommendations after P1

1. **Do not add another model.** P1 confirms that the major risk is rediscovering adjacent mature fields.
2. **Rewrite novelty statements paper by paper.** Separate “new theorem,” “new exact example,” “new synthesis,” and “new interpretation.”
3. **Run a second, narrow literature audit only on the surviving architectural residue**: declared inherited repertoire + shared budget + history-dependent maintenance cost + retained-set accessibility.
4. **Keep the exact model-specific results.** In particular, the fold/invasion gap and regulation alignment boundary are still useful even though their parent phenomena are old.
5. **Treat `M⁰` as an empirical hypothesis, not established universal structure.** Its algebra is simple; its scientific importance depends on whether one independently measurable margin predicts distinct load types out of sample.
6. **Do not claim novelty for the affinity volcano or filtering lemma.** Cite Sabatier/truncation literature and use them as illustrations.
7. **Use the two-click witness as a formal minimal example, explicitly linked to potentiation/historical contingency.** Its value is exactness, not priority over the phenomenon.

---

# Limitations of this audit

This is a serious targeted audit, but not proof of priority. The search spanned the obvious parent fields and followed several close antecedents, but no finite literature search can establish “none exists.” Two areas deserve deeper specialist checking before a strong novelty claim:

- the exact seed-dependent A–B–C hysteresis theorem and its closed-form fold/invasion inequality;
- the narrow P3 conjunction formalism around a declared retained repertoire whose own maintenance cost endogenously changes future budget accessibility.

A result labeled “sharpening” here should therefore be read as: **the mechanism is known; no exact antecedent to the stack's formal statement was located in the targeted search.**

---

# Sources

1. van den Driessche P, Watmough J. **Reproduction numbers and sub-threshold endemic equilibria for compartmental models of disease transmission.** *Mathematical Biosciences*. 2002;180:29–48. https://doi.org/10.1016/S0025-5564(02)00108-6
2. Unterberger J, Nghe P. **Stoechiometric and dynamical autocatalysis for diluted chemical reaction networks.** *Journal of Mathematical Biology*. 2022. https://doi.org/10.1007/s00285-022-01798-0
3. Cushing JM. **Backward bifurcations and strong Allee effects in matrix models for the dynamics of structured populations.** *Journal of Biological Dynamics*. 2014;8(1):57–73. https://doi.org/10.1080/17513758.2014.899638
4. Gresham D, Hong J. **The functional basis of adaptive evolution in chemostats.** *FEMS Microbiology Reviews*. 2015. See also standard chemostat reviews stating that steady-state specific growth equals dilution rate. https://pmc.ncbi.nlm.nih.gov/articles/PMC3940325/
5. Donohue I, Petchey OL, Montoya JM, et al. **On the dimensionality of ecological stability.** *Ecology Letters*. 2013;16:421–429. https://doi.org/10.1111/ele.12086
6. Kazanci C, Ma Q. **System-wide measures in ecological network analysis.** *Developments in Environmental Modelling*. 2015. https://www.sciencedirect.com/science/article/pii/B978044463536500003X
7. Qian Y, Huang H-H, Jiménez JI, Del Vecchio D. **Resource Competition Shapes the Response of Genetic Circuits.** *ACS Synthetic Biology*. 2017;6:1263–1272. https://doi.org/10.1021/acssynbio.6b00361
8. Del Vecchio D, Ninfa AJ, Sontag ED. **Modular cell biology: retroactivity and insulation.** *Molecular Systems Biology*. 2008;4:161. https://doi.org/10.1038/msb4100204
9. Kim KH, Sauro HM. **Fan-out in gene regulatory networks.** *Journal of Biological Engineering*. 2010;4:16. https://doi.org/10.1186/1754-1611-4-16
10. Szekely P, Sheftel H, Mayo A, Alon U. **Evolutionary Tradeoffs between Economy and Effectiveness in Biological Homeostasis Systems.** *PLoS Computational Biology*. 2013;9:e1003163. https://doi.org/10.1371/journal.pcbi.1003163
11. Frank SA. **Evolutionary design of regulatory control. I. A robust control theory analysis of tradeoffs.** *Journal of Theoretical Biology*. 2019;463:121–137. https://doi.org/10.1016/j.jtbi.2018.12.023
12. Crooks GE. **Measuring Thermodynamic Length.** *Physical Review Letters*. 2007;99:100602. https://doi.org/10.1103/PhysRevLett.99.100602
13. Sivak DA, Crooks GE. **Thermodynamic Metrics and Optimal Paths.** *Physical Review Letters*. 2012;108:190602. https://doi.org/10.1103/PhysRevLett.108.190602
14. Shiraishi N, Funo K, Saito K. **Speed Limit for Classical Stochastic Processes.** *Physical Review Letters*. 2018;121:070601. https://doi.org/10.1103/PhysRevLett.121.070601
15. Boyd S, Vandenberghe L. **Convex Optimization.** Cambridge University Press. 2004. https://web.stanford.edu/~boyd/cvxbook/
16. Aubin J-P. **A Survey of Viability Theory.** *SIAM Journal on Control and Optimization*. 1990;28(4):749–788. https://doi.org/10.1137/0328044
17. Blount ZD, Borland CZ, Lenski RE. **Historical contingency and the evolution of a key innovation in an experimental population of Escherichia coli.** *PNAS*. 2008;105:7899–7906. https://doi.org/10.1073/pnas.0803151105
18. Blount ZD, Barrick JE, Davidson CJ, Lenski RE. **Genomic analysis of a key innovation in an experimental Escherichia coli population.** *Nature*. 2012;489:513–518. https://doi.org/10.1038/nature11514
19. Leon D, D'Alton S, Quandt EM, Barrick JE. **Innovation in an E. coli evolution experiment is contingent on maintaining adaptive potential until competition subsides.** *PLoS Genetics*. 2018;14:e1007348. https://doi.org/10.1371/journal.pgen.1007348
20. Mesoudi A. **Variable Cultural Acquisition Costs Constrain Cumulative Cultural Evolution.** *PLoS ONE*. 2011;6:e18239. https://doi.org/10.1371/journal.pone.0018239
21. Sabatier principle / volcano-plot literature; for a modern discussion see Schilter D. **Electrocatalysis: Volcano spews out hot new catalyst.** *Nature Reviews Chemistry*. 2018;2:0116. https://doi.org/10.1038/s41570-018-0116 and Zeradjanin AR. **A Critical Review on Hydrogen Evolution Electrocatalysis: Re-exploring the Volcano-relationship.** *Electroanalysis*. 2016;28:2256–2269. https://doi.org/10.1002/elan.201600270
22. Whitt W. **Uniform Conditional Stochastic Order.** *Journal of Applied Probability*. 1980;17:112–123. https://doi.org/10.1017/S0021900200046854
23. Martinet V, Doyen L. **Sustainability of an economy with an exhaustible resource: A viable control approach.** *Resource and Energy Economics*. 2007;29:17–39. https://doi.org/10.1016/j.reseneeco.2006.03.003
24. Laland KN, Matthews B, Feldman MW. **An introduction to niche construction theory.** *Evolutionary Ecology*. 2016. https://doi.org/10.1007/s10682-016-9821-z
25. Odling-Smee J, Erwin DH, Palkovacs EP, Feldman MW, Laland KN. **Niche Construction Theory: A Practical Guide for Ecologists.** *Quarterly Review of Biology*. 2013;88:3–28. https://doi.org/10.1086/669266
