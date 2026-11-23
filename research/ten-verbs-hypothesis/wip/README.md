# Unfinished work: the M1–M4 comparison (not run, not evidence)

**Status: unfinished and never executed.** Nothing in this folder has been run as an experiment, and nothing in [../simulation/](../simulation/) imports it. The released simulation does not depend on it.

## What is here

- **[m1_m4_engine_changes.patch](m1_m4_engine_changes.patch).** The first part of the code for the four-model comparison in [../simulation/PLAN_V2.md](../simulation/PLAN_V2.md). It is a patch against `simulation/model.py`. It adds:
  - a switch for symmetric weighting of testimony, which M2 needs;
  - a switching rate that can be set per condition, which E7 needs;
  - per-round masks on the likelihood, so the comparison can be scored on held-out rounds;
  - likelihood functions for the four behavioural channels, so M1 and M3 can be fitted jointly.

## What is missing

- the mappings from M1, M2 and M3 to the ten settings;
- the fitting of each model;
- the runner for E5 to E7;
- any results.

## How it was checked

- The patch applies cleanly to `simulation/model.py` as released.
- With the patch applied, the existing replay checks in `test_model.py` still pass.
- No other checks were done.

## Why it stopped

After the plan was committed, a second outside review advised closing the pull request as a feasibility study. The author chose that, and asked that this work be kept, clearly marked as unfinished, as a possible later experiment (D51 in [DIALOGUE.md](../../../DIALOGUE.md)).

## To resume

From the repository root:

```
git apply --directory=research/ten-verbs-hypothesis research/ten-verbs-hypothesis/wip/m1_m4_engine_changes.patch
```

Then write the missing parts listed above, keeping to the plan as it was fixed.
