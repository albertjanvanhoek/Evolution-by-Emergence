# Independent validation — 2026-09-23

Base repository commit: `a870788f13643643f22a1c978f424fc4dcccdbfa`.

## Executed checks

- Lean v4.33.0 compiled the submitted core and the version with scope-comment clarifications. All 16 axiom audits emitted only `propext`, `Classical.choice`, `Quot.sound`; no `sorryAx`. There are 27 named theorems plus five decided witnesses. No theorem statements or proofs were altered.
- 17 Python regression/counterexample tests passed. They cover finite-target versus survival endpoints, the pairwise ODE formula, budget admission/projection, horizon and schedule edge cases, event-limit failure, probability conservation, positive finite survival below N*, eventual absorption above N*, leverage without an upcrossing, the critical linear-mean case, the ODE boundary and possible recovery after a short shock.
- All eight experiments completed with full run counts and seed `20260922`; no event-limit or solver failures. Runtime was about 149 seconds on this host.
- Environment: Python 3.12.14, NumPy 2.3.5, SciPy 1.17.0, Matplotlib 3.10.8.
- Regenerated E4/E5 figures inspected for labels, limits and layout. Original figure checksums and original results are retained under `provenance/`.

## Results

| Experiment | Reviewed full run |
|---|---|
| E1 | 2000 runs per point; maximum finite-target probability discrepancy 0.012; reference inside pointwise 95% Wilson intervals in 22/22 cases |
| E2 | 1500 runs per point; maximum discrepancy 0.017; reference inside intervals in 14/15 cases |
| E3 | 1000 runs per start; conditional hitting times compared with deterministic values, not asserted equal in law |
| E4 | Hard admission ceilings respected in examples; effort time averages below deterministic equilibria; balanced case tuned to linear mean |
| E5 | 150 runs per cell; maximum transient discrepancy 0.058; zero observed survivors in sampled K<N* cells, not zero exact probability |
| E6 | 2000 runs per shock; numerical transient solver compared with recovery at t=80 |
| E7 | 2000 runs per point; finite-target reference inside intervals in 9/9 cases; zero spectral-criterion mismatches in 100,000 sampled matrices |
| E8 | Analytic geometric-maximum comparison for parallel rounds; exhaustive sequential kq bound labeled separately |

Pointwise interval coverage is descriptive, not a simultaneous guarantee or a scientific validation criterion. E3/E4 compare stochastic and deterministic descriptions, so residual differences are expected and should not be hidden by “all experiments match.”

### E3: conditional median time to 2000

| Initial count | Simulated median | Deterministic hitting time | Failures to reach target |
|---|---|---|---|
| 13 | 1.4168 | 1.6966 | 312/1000 |
| 15 | 1.1704 | 1.1966 | 136/1000 |
| 20 | 0.7177 | 0.7209 | 4/1000 |
| 30 | 0.4098 | 0.4102 | 0/1000 |
| 50 | 0.2238 | 0.2209 | 0/1000 |
| 100 | 0.1018 | 0.1009 | 0/1000 |

### E6: recovery probability Pr[N(80)≥30]

| Shock ceiling | Immigration a₀ | Simulation | Numerical CTMC |
|---|---|---|---|
| 24 | 0.0 | 0.9560 | 0.9523 |
| 16 | 0.0 | 0.0560 | 0.0553 |
| 8 | 0.0 | 0.0000 | 0.0000 |
| 8 | 1.5 | 0.3095 | 0.3122 |

### Endpoint corrections visible in the results

At R_c=1, E1's finite-target probabilities from one and three items are 0.01 and 0.03; permanent survival is zero. The supplied data already recorded observed values 0.0105 and 0.0295, contradicting the submitted prose's “zero runaway” description of that experiment.

At c=0.4, E7's corrected finite-target reference is 0.00666667=1/150, simulation is 0.0055, and eventual survival is 0.0. The submitted fixed-point iteration gave an unconverged residual near 0.0001 and compared the wrong endpoint.

E5's K₅₀ values at T=30 remain `[11, 17, 23, 29, 34, 39, 44, 49, 54, 59]` for N*=`[4, 8, 12, 16, 20, 24, 28, 32, 36, 40]`. They describe this horizon, initial state and rate family.

## Limits

No full v20 Mathlib build was run: this additive package changes no v20 formal source. The new path-scoped workflow checks the standalone Lean package, the regressions and a reduced-run E1–E8 smoke test. A targeted prior-art check was performed; no systematic novelty review or empirical dataset validation was performed.
