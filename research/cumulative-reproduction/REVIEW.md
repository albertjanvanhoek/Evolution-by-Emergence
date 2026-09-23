# Review of the submitted Cumulative Reproduction Model

Reviewed against repository base `a870788f13643643f22a1c978f424fc4dcccdbfa` on 2026-09-23. Scope: supplied theory, Lean source, simulator, E1–E8 results and figures; targeted prior-art check. The original v20 adversarial review was not supplied, so the author's finding-by-finding repair claims cannot be independently certified here.

## Assessment

The integer recurrence proofs compile under their pinned Lean version. The budget ceiling follows from the stated ledger; pairwise critical mass and positive-branch ODE time formulas check out. The package is suitable as a **conditional research extension**, after correcting the interpretation of stochastic outcomes, growth classes and scaffold feedback. It does not yet replace EbE's identity-sensitive accessibility architecture.

## Findings and resolutions

| Severity | Submitted claim or implementation | Review and correction |
|---|---|---|
| Major | K<N* implies zero stochastic persistence; K>N* is necessary for survival | Every positive initial state has positive survival probability at a finite time. Every finite-cap, no-immigration model here eventually dies with probability one. E5 now describes a finite-horizon survival contour. |
| Major | E1/E7 simulations measure runaway or permanent survival | They measure hitting 100/150 before zero. At criticality these have probabilities n₀/100 and 1/150, while eventual survival is zero. E1 already stored both values but plotted the wrong comparator; E7 used an unconverged critical fixed-point approximation. Both now compare like endpoints and separately display survival. |
| Major | κ=1 means exponential; leverage always creates increasing R_c | κ=1 permits subexponential, exponential, doubly exponential or finite-time explosive behavior depending on coefficients and slowly varying factors. Balanced γ=1 effort search has decreasing R_c. Theory now states the positive-drift and parameter conditions explicitly. |
| Major | A transient shock below N* permanently destroys the repertoire | Duration, post-shock state and immigration matter. A short shock can leave recovery possible. E6 measures recovery at t=80 for a specific schedule. |
| Major | Strict emergence provides q^k→kq scaffolding | The improvement additionally requires a part-correctness oracle and retention. The sequential Lean result is an exhaustive bound; the simulated result counts parallel rounds. These information and work assumptions are explicit. |
| Major | Lean checks the continuous stochastic laws | Lean proves generic integer inequalities conditional on gains/losses and clipping. It neither instantiates the CTMC nor derives its rates from a hypergraph. The exact scope is mapped below. |
| Moderate | R_c is always lifetime offspring per item | It is a rate ratio in the nonlinear/immigration models. Joint births do not define individual parentage; a branching interpretation requires more assumptions. |
| Moderate | Stability iff derivative is negative; N₀=N* runs away | Negative derivative is sufficient, not necessary; equality is an unstable equilibrium in the pairwise ODE. Corrected. |
| Moderate | Fixed κ, N*, budget ratio and R_c determine all outcomes | These summaries are not sufficient for an arbitrary production law; R_c is a function and K/N* is not equivalent to η/μ. Corrected. |
| Moderate | CTMC schedule can jump past the horizon | Breakpoints beyond t_max were applied before checking the horizon. Now bounded; zero-rate intervals advance to relevant breakpoints, and schedules must declare them. |
| Moderate | Event-limit truncation returned ordinary time completion | It now raises, preventing silent inclusion of incomplete paths as survivors. Non-recording runs return the actual terminal state. |
| Moderate | ODE used integer admission, creating a boundary at K−1 | The continuous-size closure now uses raw drift and a projected upper boundary at K. Solver failures raise. |
| Moderate | E4b time average omitted the burn-in boundary interval | Integrates the right-continuous path over the complete [10,60] interval, including its terminal segment. |
| Moderate | Partial/quick runs could silently inherit stale global metadata | Output directories and mode/schema checks prevent mixing incompatible output sets. Run metadata is stored per experiment. |
| Moderate | Estimate κ from log(G−L) | Estimate production scaling directly where justified; net drift differs near thresholds and under immigration/admission constraints. |
| Prior art | Reproduction of organization through combinations might itself be new | Steel–Hordijk–Kauffman already study combinatorial innovation/loss birth–death dynamics. The ledger/paid-search synthesis needs a fuller comparison before any novelty claim. |

## Formal traceability

The Lean source has **27 named theorems**, **16 explicit axiom audits**, and five decided numerical witnesses. “16 theorems” in the submission refers to the audited subset, not the complete declaration count. The checked proof terms use only `propext`, `Classical.choice` and `Quot.sound`; no `sorryAx`.

| Interpretation | Actual formal premise and conclusion |
|---|---|
| Threshold | `step = n + G n - L n` over naturals; shrink/fixed equivalences require n>0 |
| Runaway | `SupercriticalFrom`: at least one net gain at every integer state above c ⇒ n(t)≥n₀+t |
| Collapse | `SubcriticalBelow` plus G(0)=0 ⇒ at least one net loss each step until zero |
| Critical mass | Combines the above assumptions; does not derive a continuous threshold from α₂,ρ,δ |
| Speed | Explicit linear/quadratic excess lower bounds; no continuous-time limit or explosion theorem |
| Affordability | Natural-number linear ledger; finite cap when μ>η and positive-integer currency rescaling |
| Plateau | Clipped recurrence and positive drift; not the absorbing finite CTMC's stationary distribution |
| Scaffold | Enumerate q options per part using known part correctness; bound evaluations by kq |

The theorem statements and proofs are retained; comments clarify the recurrence/CTMC distinction. They are standalone and do not enlarge v20's advertised proof surface.

## Provenance and remaining work

`provenance/THEORY.submitted.md` and `provenance/results.submitted.json` preserve the supplied text and results. `provenance/SHA256SUMS` identifies the original attachments and archive members. Current `sim/results/` and `sim/figures/` are regenerated from the reviewed implementation.

Remaining scientific work: derive an explicit identity/dependency model and its closure error; connect retained function to production by causal ablation; account for construction delays, throughput, information and scaffold costs; compare the ledger extension with existing innovation and resource-limited population models. This PR claims internal conditional results, not empirical universality or priority.
