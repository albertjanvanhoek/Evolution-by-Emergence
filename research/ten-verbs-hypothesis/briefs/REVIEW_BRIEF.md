# Review brief: the ten-verb feasibility study

**For:** an independent modeller, or an assistant of another model family, who did not design this model.

## What this study is

A feasibility study. It asks one measurement question.

> If ten verb settings are built into a simple learning agent, which of them can an experimenter recover from that agent's behaviour, under which conditions and with which measurements?

It does **not** test whether real intelligences have ten functions. Nor does it test whether the ten-verb model beats simpler models; that comparison was planned but not run ([../wip/](../wip/README.md)). Two outside reviews have already been processed; see [../sources/](../sources/).

## Reproduce

```
cd research/ten-verbs-hypothesis/simulation
python test_model.py                    # replay checks: seconds
python run.py                           # E1–E4: about 30 minutes on 2 cores
python tradeoffs.py                     # E2b–E2c: a few minutes
python tradeoffs.py --optimiser-check   # E2d: about 7 minutes
```

Seeded. Needs numpy, scipy and matplotlib. Outputs go to `results/` and `figures/`. The numbers in [RESULTS.md](../simulation/results/RESULTS.md) should match the generated `tables.md` and `tradeoffs.md`.

## Questions we would most like answered

1. **Construct validity.** Does any result in RESULTS.md say more than the narrow mechanisms support? The table "What the parameters are, and are not" lists what each verb means in the model.
2. **Built-in results.** Which other findings follow from how the model was written, rather than from the task? Two such cases are already known: the route-specific knockouts, and the Remember / let go crossover.
3. **Fitting.** Is the likelihood correct? Are three random starts adequate? (E2d says not always.) Is BIC with this count of observations a sensible secondary criterion?
4. **Recovery claims.** Are the correlations reported fairly, given that the optimiser sometimes misses the maximum?
5. **What should a better model of the verbs do differently,** if anyone builds one again?

## Please write

Your verdict and your points, in your own words, with file and line references where you can. The author will pass them on. They will be kept verbatim in `sources/`, as the earlier reviews were.
