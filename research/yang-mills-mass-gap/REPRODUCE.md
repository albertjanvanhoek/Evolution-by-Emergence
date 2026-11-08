# Reproducing the research snapshot

The commands below are **entry points**, not a single validated end-to-end proof. Run on the exact branch, merged commit or release tag being reviewed. Results can change if scripts or their scientific assumptions change. The first group is suited to a modest independent check; some later simulations are substantially more expensive.

## Environment and what CI actually tests

- **Lean:** `leanprover/lean4:v4.33.0` from [lean-toolchain](lean/lean-toolchain); use `elan` / `lake` and the dependency manifest in [lean/](lean/).
- **Python:** Python 3, with standard-library-only arithmetic scripts where indicated. The numerical spin/simulation scripts use **NumPy and SciPy**. Check each script's imports before running and record package versions in any published replication.
- **Continuous integration:** [Yang–Mills Mass Gap Check](../../.github/workflows/yang-mills-mass-gap-check.yml) runs the Lean build and checks for `sorryAx` in its own audit. It **does not** run every Python pilot or machine-check the mathematical steps in Markdown. Its success is a build result, not a CP-lemma or mass-gap certification.
- **Dataset provenance:** existing `pilot/*.json`, `pilot/*.npz` and `pilot/su2_frustration/out*/` are exploratory pilot outputs. The notes specify their settings; do not treat them as continuum-limit data or independently replicated measurements. Retaining raw data makes the snapshot larger.

Use a fresh checkout of the exact reviewed commit:

```bash
git clone https://github.com/albertjanvanhoek/Evolution-by-Emergence.git
cd Evolution-by-Emergence
git checkout <reviewed-tag-or-commit>
```

## Minimal analytic/combinatorial checks

From the repository root:

```bash
cd research/yang-mills-mass-gap/pilot

# Exact rational gluing checks, including fixed repeated strands and a cycle:
python3 cpn_two_terminal_independent_glue_audit.py

# Exact rational counterexample / normalized derivative certificate
# in the SEVEN-EDGE SQUAREFREE (0-or-1 strand per edge) model:
python3 cpn_multi_gateway_exact_certificate.py

# Integer-polynomial extension to all formal q >= 2 for THE SAME
# squarefree seven-edge graph, not the full exponential CP model:
python3 cpn_multi_gateway_symbolic_q.py
```

These exact arithmetic checks have assert statements. A successful run tests the implemented finite statements; it does **not** imply that the full CP graphical event comparison is proved for arbitrary networks.

For the event-resolved **full exponential** one-gateway calculation, the [gluing proof](CPN_TWO_TERMINAL_GLUING_PROOF.md) records the exact moment identity and the independent spin checks; its supporting code is:

```bash
python3 cpn_gluing_spin_check.py
```

Read that script for its imports and numerical integration assumptions before running. Analytic arguments in Markdown still need mathematical review.

## Lean conditional transfer statements

```bash
cd research/yang-mills-mass-gap/lean
lake update
lake exe cache get
lake build
lake env lean Audit.lean
```

The workflow retries transient download errors for `elan`, the toolchain and Mathlib. In the checked run, the audit reports at least **14** results without `sorryAx` under its configured detection rule. The theorems are **conditional bookkeeping** about covariance and scales; their physical assumptions are not proven by this build.

## Targeted numerical screens — optional, not release gates

These scripts can require noticeably more computation and third-party libraries:

```bash
cd research/yang-mills-mass-gap/pilot

# One outer marked site, several independent gateway hubs.
# Numerical quadrature and adversarial screens; uses numpy/scipy:
python3 cpn_multi_gateway.py

# Two gateways interacting with one another in the full exponential
# spin model; scrambled quasi-Monte Carlo, not an exact certificate:
python3 cpn_two_gateway_full.py
```

The [multi-gateway note](CPN_MULTI_GATEWAY.md) documents graph inputs, cutoff parameters, quadrature/Sobol settings and the limits of those observations. For q, geometry and all coupling values, report the exact configuration rather than merely saying a test “passed”.

Other reproduction starting points:

| Topic | Primary instructions |
|---|---|
| SU(2) frustration and monopole-suppressed pilot | [pilot/su2_frustration/README.md](pilot/su2_frustration/README.md) |
| Nonplanar O(3) twist | [TWIST_NONPLANAR.md](TWIST_NONPLANAR.md) and `pilot/twist_nonplanar_checks.py` |
| O(2)/O(3) coarse-graining and sensitivity | [pilot/RESULTS.md](pilot/RESULTS.md) |
| CP annulus twist and crossings | [CPN_STEP4.md](CPN_STEP4.md), [CPN_TWIST_THEOREM.md](CPN_TWIST_THEOREM.md) |

## Independent review protocol

A useful review report includes: the exact commit SHA; the named claim and equation; definitions of graph, boundaries and crossing event; whether the result is analytic, exact-in-truncation, machine-checked, or numerical; the commands and package versions used; and at least one serious falsification attempt. Record *where* a proof fails if a counterexample is found. See the [handoff](HANDOFF.md) and [human review issue](https://github.com/albertjanvanhoek/Evolution-by-Emergence/issues/145).

Do not interpret a “no negative samples found” screen as a proof of positivity, nor a Lean check of an implication as a verification of its physical hypotheses.
