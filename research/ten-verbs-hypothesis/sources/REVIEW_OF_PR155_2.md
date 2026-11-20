# A second outside review of pull request 155 (verbatim)

Passed on by the author on 20 November 2026, from the same outside reviewer as [REVIEW_OF_PR155.md](REVIEW_OF_PR155.md), after the first corrections. Kept as written, except that tracking parameters were removed from the links. The response is in [../simulation/results/RESULTS.md](../simulation/results/RESULTS.md), "What the outside review changed", and in DIALOGUE entry D51.

---

I checked the updated [PR #155](https://github.com/albertjanvanhoek/Evolution-by-Emergence/pull/155), including the new `tradeoffs.py`, replay tests, scoring code and results. The corrections described by the agent are present, and the latest integration check passed.

**The PR is substantially better. But I found two remaining issues that I would correct before declaring the methodological review complete.**

## **1. The profile-likelihood analysis contains a mistaken inference**

The agent writes that sparse-data fits sometimes fail to find the optimum because fixing *Change* away from its true value improves the likelihood.

But look at what `tradeoffs.py` actually does. It compares the likelihood at:

\\[ \theta\_{\mathrm{Change}}=\theta\_{\mathrm{true}} \\]

with likelihoods at 70%, 85%, 115% and 130% of the true parameter.

**The true generating parameter does not necessarily maximize the likelihood of a finite, noisy dataset.**

Even with a perfect optimizer, a fitted value different from the true parameter can produce a higher likelihood.

Therefore, negative reported likelihood losses do **not**, by themselves, demonstrate optimization failure.

To test optimization properly, the agent should compare every restricted fit with the maximum likelihood from an unrestricted fit, using sufficiently many optimization starts.

This distinction matters because the current report attributes part of poor sparse-data recovery to optimizer failure without having established it.

## **2. The Remember / Let go crossover is partly built into the model**

This is the more interesting conceptual issue.

In `model.py`, the true world state changes in the volatile condition. But the learner has no explicit model of that transition probability.

Instead, its beliefs are repeatedly mixed back toward a uniform distribution:

\\[ b\_{t+1}=(1-\lambda)b'\_t+\lambda u \\]

where \\(\lambda\\) is the *Let go* parameter.

Consequently, in the changing environment, forgetting is effectively the model's main mechanism for escaping accumulated confidence in an obsolete state.

The observed result—that perfect retention helps in stable environments but harms learning when reality changes—is therefore strongly influenced by the chosen architecture.

It remains an informative simulation result. But it should not be described as independent evidence for the Ten Verbs Hypothesis.

A stronger comparison would introduce a competing learner with an explicit estimate of environmental volatility. That learner could adapt to change without forgetting in precisely the same way.

We could then investigate whether *Remember / Let go* explains anything beyond conventional Bayesian state-transition learning.

## **3. What I would ask the agent to do**

Thank you for checking the review and implementing the corrections in PR #155. Please add v0.5 verbatim as historical hypothesis lineage, clearly marking it as written before the simulation results and not as an empirically validated version.

An additional independent review found two methodological issues:

**1. Profile likelihood:** In `tradeoffs.py`, the baseline is the true generating value of Change, not the unrestricted maximum-likelihood estimate. A higher likelihood away from the true value is possible even with perfect optimization. Please correct the interpretation and, if feasible, compare restricted fits with a well-optimized unrestricted fit.

**2. Remember / Let go crossover:** The volatile environment changes the true state, but the learner has no explicit transition model. Forgetting is therefore a built-in mechanism for recovering from outdated certainty. Please document this structural dependency and avoid treating the crossover as independent validation.

I suggest closing out PR #155 as an exploratory feasibility study after these corrections rather than expanding it indefinitely.

For the next experiment, prioritize an independently specified model of two intelligences holding incompatible accounts of shared events, interacting through a wider epistemic commons. The agents should not be built around ten verb parameters.

Use the ten verbs as one candidate explanatory model and compare them with simpler alternatives, with error detection, actual belief correction, and coordination measured separately.

Preserve negative results and all earlier versions. Do not merge the PR yet.

## **4. Why I favour a new experiment rather than more parameter fitting**

The current simulation asks:

*If ten parameters are built into an intelligence, can we estimate those parameters from its behaviour?*

That is a useful measurement question.

But your original hypothesis asks something different:

**If intelligences hold incompatible accounts of reality, what enables them to discover errors and maintain a workable relationship through their epistemic commons?**

I think that should now be the primary scientific question.

The ten verbs could explain the answer. But a scientific experiment must also permit the possibility that only three or four mechanisms are needed—or that an entirely different mechanism explains it better.

This is also why I would keep the two research tracks separate:

- **PR #155:** Can the ten proposed functions be measured and distinguished in a specific agent architecture?
- **Next experiment:** Do the proposed functions explain the correction of incompatible world models between intelligences better than competing theories?

The second addresses the phenomenon that originally motivated the theory.

**My overall assessment:** PR #155 is becoming a useful, transparent record of computational exploration. Its greatest achievement so far is not validating the ten verbs, but exposing exactly how easily a simulation can confuse assumptions built into a model with evidence for the theory.

That is valuable progress.