# Exploratory Simulations — status and reproduction plan

> **Important:** the numerical simulation results discussed during theory development have **not yet been reproduced by versioned code in this repository**.  
> Treat the results below as exploratory working notes, not verified or citable findings.

The purpose of preserving them here is to retain the hypotheses, controls, and failure modes that motivated the current theorem program.

The current EbE centre is broader than these simulations:

> **Retained organization becomes causal structure for future change.**

The simulations below test one specialization of that claim: **paid retained organization changes graded later construction/accessibility, and sometimes fails to do so.**

The strongest future simulation endpoint should be the paid transfer criterion:

\[
\exists Y\notin\mathcal H_t:
\mathcal A_T(Y\mid s^+,B-\mu_X)
>
\mathcal A_T(Y\mid s^-,B).
\]

A retained change that only alters an immediate state but does not transfer to an unvisited target should not count as a positive result.

## Reported exploratory findings

The research discussion reported the following qualitative patterns:

1. **Retention is not automatically beneficial.** Maintenance costs can make retained organization reduce rather than expand budgeted accessibility.
2. **Reuse centrality matters.** Modules participating in many downstream constructions were more likely to justify retention.
3. **Path dependence and lock-in can arise.** Finite maintenance resources can make different discovery/retention histories produce different later accessible sets.
4. **Full closure can remain unchanged while budgeted functional accessibility expands.** A Boolean-circuit toy model was used to illustrate this distinction.
5. **Equal-cost independent caching does not automatically generate hierarchy.**
6. **Complexity-aware but independent storage is not enough for robust hierarchy.** Shared representation matters.
7. **Compositional retention can generate nested reusable modules.**
8. **Null control: destroy repeated cross-task substructure and hierarchy largely disappears.**
9. **Increase reference cost and hierarchy weakens.**
10. **Single-use additive scaffolds should fail.** The corrected theorem predicts that (n=1) cannot pay for a pure representational scaffold when reference/upkeep costs are nonnegative.
11. **Repeated/shared use should show a threshold.** A module used (n) times is favored only after \((n-1)c>nr+h\).
12. **Paid transfer can fail.** Retention should be scored after upkeep, with neutral and burden cases retained as legitimate outcomes.

## What must be reproduced

A reproducible implementation should include at least three experiments.

### A. Costed random construction system

- randomly generated typed construction/rewrite universe;
- finite task/construction budget;
- explicit maintenance cost;
- selectable retention;
- measurement of gain/loss sets;
- path-dependence and lock-in controls.

### B. Boolean-circuit functional control

Use a fixed gate vocabulary so that function is derived from circuit truth tables rather than assigned labels.

Required checks:

- full functional closure before/after retention;
- budgeted functional accessibility before/after;
- retained subcircuits as reusable modules;
- stepping-stone examples.

### C. Random typed network/hypergraph system

Remove Boolean semantics.

Compare:

1. independent caching;
2. compositional retention;
3. matched random retained dictionaries.

Controls:

- destroy cross-task shared substructure;
- force single-use (n=1) substructure as a no-hierarchy control;
- vary repetition count through its analytic threshold;
- vary reference cost;
- vary maintenance/upkeep budget;
- compare retained versus ablated counterfactuals on held-out/unvisited targets;
- measure historical hierarchy depth only in time direction.

## Required outputs

For every experiment, save:

- random seed;
- complete parameter configuration;
- generated universe;
- retention decisions over time;
- separate use/reach cost and retention/upkeep cost definitions;
- visited-history set and held-out/unvisited target set;
- retained-versus-ablated transfer measurements;
- raw results;
- summary statistics;
- plots/tables;
- exact code commit.

## Avoid these mistakes

- Do not infer historical hierarchy from final mutual cheapness; this can create false cycles.
- Do not define "useful" modules by the quantity later used to prove that they were useful.
- Do not equate number of retained modules with accessibility.
- Do not use infinite closure as the only possibility-space measure.
- Do not call an exploratory numerical result a theorem.
- Do not treat Boolean truth tables as universal semantics; they are a controlled test bed.
- Do not claim network hierarchy is universal unless chemistry and other non-symbolic systems support the same mechanism.
- Do not call a mere change in the next-state distribution transfer; require a held-out/unvisited target and an explicit ablation counterfactual.
- Do not let maintenance/upkeep disappear from the comparison that is supposed to show retention benefit.
- Do not infer pure scaffold value from a free (H_i) parameter; derive it from repetition/shared structure or another explicit mechanism.

## Current role

These experiments motivated the sharper paid-retention statements:

\[
S_R(X)>\Delta M_R(X),
\]

and, for repeated additive scaffolds,

\[
(n-1)c>nr+h.
\]

The next simulation should directly test **paid transfer to unvisited organization**, with retention ablation as the control.

Finite algebra/check scripts now live in [../scripts/](../scripts/). They are sanity checks, not substitutes for reproducing the exploratory simulations.
