# Instructions for the next step (verbatim)

Passed on by the author on 20 November 2026, written by the assistant that wrote versions 0.4 and 0.5, after the round-5 review and the outside review of the simulation. It is the brief for the second set of experiments ([../simulation/PLAN_V2.md](../simulation/PLAN_V2.md)). Kept as written.

---

**Yes. I would do both, with one important condition: this should be a test of competing explanations, not another demonstration that the model behaves as programmed.**

I agree with round 5. We have reached the point where further refinement of the wording offers diminishing returns. The next useful correction should come from data or an independently developed model.

I would send the following instructions to the agent.

Please proceed with both additions to PR #155.

**1. Add version 0.5 verbatim as part of the hypothesis lineage.**

Preserve v0.4, all five review rounds, and the original simulation results. Reference D45's earlier proposal to apply learning functions recursively across organizational levels.

Do not retrospectively change earlier hypotheses to match the simulation findings.

**2. Implement and compare four genuinely competing models.**

- **M1:** One general learning-capacity parameter, with explicitly fixed mappings to observable behaviours.
- **M2:** A specified conventional Bayesian or reinforcement-learning model, including social evidence weighting. Fix the equations and parameters before fitting.
- **M3:** Three functional layers: individual learning, interpersonal correction, and maintenance/method development.
- **M4:** The existing ten-verb model, without adding post-hoc interactions.

Each model must be capable of predicting the same relevant observable data. Otherwise, differences in fit may simply reflect differences in what the models attempt to explain.

**3. Test identifiability before interpreting model comparisons.**

Generate data under each of M1–M4, not only M4. Test model recovery across the seven environments and both recording regimes.

Include scenarios in which the generating parameters produce clearly distinguishable behaviour, as well as scenarios near model boundaries where different models may be observationally equivalent.

Do not interpret failure to select M4 as evidence against M4 unless the experimental design has demonstrated adequate recovery of M4 when it generates the observations.

Use held-out predictive performance as a primary comparison; BIC may remain a secondary analysis.

**4. Add an explicit Remember / Let go prediction.**

Test whether retaining information without forgetting improves performance in stable environments but impairs adaptation when the environment changes.

Use new simulation conditions or independently generated data. Because this crossover was already observed in the first experiment, label the follow-up as replication, not an untouched confirmatory prediction.

Report proper probabilistic scores, including the Brier score or log loss, alongside the existing mean probability assigned to the true state.

**5. Preserve the possibility of failure.**

Report parameter-recovery failures, model confusion, negative results, and cases where simpler models outperform M4.

Distinguish structural non-identifiability from insufficient observations.

Avoid interpreting a fitted parameter as evidence for the existence of the corresponding verb in real intelligences.

**6. Independent review.**

After completing these experiments, prepare a short reproducible review brief for an independent modeller or another model family that did not design M4.

The key question is whether the ten-verb decomposition explains anything beyond established alternatives.

Please keep the work within PR #155, leave the PR open, and document the results without claiming empirical validation of the hypothesis.

## **One thing I would emphasize**

The most interesting possible finding is not necessarily that M4 wins.

Imagine the results show that a conventional learning model explains individual learning equally well, but fails to predict what happens when agents must exchange contradictory evidence, challenge unreliable testimony, or restore broken corrective relationships.

If M4—or a simpler relational extension—predicts those outcomes better, we have identified something scientifically useful.

Conversely, if M3 explains everything M4 explains, then the three-layer architecture may be a better theory, with the ten verbs remaining useful descriptions of behaviours within those layers.

And if M2 explains everything, we should acknowledge that too.

**The objective is not to recover ten verbs. It is to discover the smallest adequate explanation for how intelligences learn and correct each other.**

That brings us back to your original insight: two intelligences can maintain logically incompatible world models, but the wider epistemic commons may provide ways to identify errors and continue cooperating.

Whether the ten verbs are the correct functional explanation for that process is now an empirical question.

I would consider the proposed next experiment a worthwhile step toward answering it.