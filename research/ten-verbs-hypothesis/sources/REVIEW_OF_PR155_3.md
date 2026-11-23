# A third outside review of pull request 155 (verbatim)

Sent by the author as his message on 20 November 2026; written by the same outside reviewer as [REVIEW_OF_PR155.md](REVIEW_OF_PR155.md) and [REVIEW_OF_PR155_2.md](REVIEW_OF_PR155_2.md). Kept as written, except that tracking parameters were removed from the link. The response is in DIALOGUE entry D51.

---

I reviewed the updated [PR #155 — Ten Verbs Hypothesis: a feasibility study of parameter recovery](https://github.com/albertjanvanhoek/Evolution-by-Emergence/pull/155), including both new briefs, the preserved M1–M4 plan and the revised methodology.
My assessment: the PR is ready for an independent scientific review, and I support keeping it as a completed exploratory feasibility study. I would not add more experiments to this PR.
The latest GitHub integration workflow passed. The PR remains open and unmerged.
Three things are now documented particularly well:

* What was actually established: certain parameters of one explicitly constructed learner can be recovered from particular observations, under particular conditions.
* What was not established: that learning naturally decomposes into ten functions, or that those functions explain relational repair.
* What changed through criticism: the parameter trade-off, the optimizer interpretation, the scoring measures and the built-in forgetting result are now documented with their limitations.

Preserving v0.5 as historical lineage and placing unfinished M1–M4 work in an isolated `wip/` folder are also appropriate decisions.
My remaining concern: independence of the next experiment
I read `INCOMPATIBLE_ACCOUNTS_BRIEF.md`. Its scientific direction is right, but I recommend one change before handing it to a new modeller.
The brief tells the modeller not to read the previous simulation, but also explains the previous simulation's limitations and names the ten verbs. This could still influence the new architecture.
A stronger design would separate model construction from hypothesis testing.
The independent modeller would receive only the phenomenon: two agents with incompatible factual accounts, fallible evidence, and access to a wider epistemic commons. They would design and freeze a model without having to implement or reproduce the ten verbs.
Only afterward would a separate analysis attempt to explain the agents' behaviour using the ten verbs and competing, simpler descriptions.
That would provide a stronger test of whether the functions have explanatory value independently of the architecture.
There is a second methodological safeguard I would add: behaviours coded as verbs should be measured before the outcomes they are supposed to predict. Otherwise, the analysis could inadvertently use evidence of successful correction to classify an agent as good at correcting.
Finally, the brief should distinguish cases where the available evidence can establish which account is correct from cases where the evidence remains genuinely inconclusive. A good model should permit agents to recognize that the disagreement cannot yet be resolved.
Recommendation
I would proceed as follows: obtain the independent review of #155 using the existing `REVIEW_BRIEF.md`, incorporate only substantive corrections, and then merge the study as a bounded research contribution. PR #154 is also still open, so its D50/D51 sequencing should be resolved first.
For the next experiment, the independent modeller should receive a phenomenon-first brief before seeing the ten-verb taxonomy.
The underlying scientific question remains:
When intelligences cannot agree about what happened, under what conditions can their wider epistemic commons help them discover errors, manage unresolved differences, and continue cooperating?
That question stands independently of whether there are precisely ten learning functions.
And I think that independence is valuable: we can now test the theory without requiring the experiment to assume its conclusion.
