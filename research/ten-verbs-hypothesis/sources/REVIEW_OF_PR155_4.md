# A fourth outside review of pull request 155 (verbatim)

Sent by the author as his message on 20 November 2026; written by the same outside reviewer as the three earlier reviews. Kept as written, except that tracking parameters were removed from the links. Its two points for the modeller were added to [../../incompatible-accounts/BRIEF.md](../../incompatible-accounts/BRIEF.md); see D51.

---

I've inspected the latest version of [PR #155](https://github.com/albertjanvanhoek/Evolution-by-Emergence/pull/155), including the two new briefs.
I agree with the changes. The experiment is now substantially better protected against circular reasoning.
Separating the phenomenon-first brief from the analysis plan is the right decision. It allows the next modeller to investigate incompatible world models without being required to implement ten predefined functions.
Three details are particularly important:

* The modeller is explicitly allowed to develop a different learning architecture.
* Behavioural measurements must precede the outcomes they predict, reducing the risk of defining successful learning as evidence of a particular verb.
* Genuinely inconclusive disagreements are recognized as a distinct case, where calibrated uncertainty and workable cooperation may be better outcomes than agreement.

I would keep PR #155 closed to further experimental expansion. It has achieved its purpose as a feasibility study, even though the GitHub pull request itself remains open.
Two methodological points for the next experiment
I would flag these to the independent modeller rather than start another revision cycle for #155.
1. Define what makes a case genuinely inconclusive.
Because observations are noisy, the existence of a true event does not mean the available evidence can establish it conclusively. The simulation should distinguish the true state, what can be inferred from available evidence, and what the agents actually infer.
Calibration should be evaluated across repeated cases, not from a single unresolved disagreement.
2. Allow cooperation to be refused.
The phenomenon brief currently requires a joint task. But when evidence is unreliable or another agent acts strategically, refusing to cooperate can be a rational outcome.
I would allow agents to abstain or disengage, with specified consequences. Otherwise, the experiment risks treating continued cooperation as inherently desirable, even when maintaining boundaries would be preferable.
These points do not undermine the design. They make the eventual test more informative.
Decision on PR #155
Integration check passed
Current PR head: a43d20d
My recommended sequence remains:

1. Obtain a genuinely independent methodological review using `REVIEW_BRIEF.md`.
2. Address only substantive errors identified by that reviewer.
3. Resolve [PR #154](https://github.com/albertjanvanhoek/Evolution-by-Emergence/pull/154), which remains open, so D50 precedes D51.
4. Merge #155 if the independent review finds no remaining blocking problems.

I would not count our continued exchanges as another independent review. We have influenced each other's reasoning too extensively for that.
The next valuable result should come from an independently implemented experiment, not from another refinement of our hypothesis.
And I think we have preserved the most important scientific distinction: the Ten Verbs Hypothesis is one possible explanation of how intelligences correct incompatible world models. The experiment should be free to discover a different explanation.
