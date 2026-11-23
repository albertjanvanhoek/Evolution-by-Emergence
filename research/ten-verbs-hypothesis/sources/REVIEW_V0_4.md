# The reviews of versions 0.1 to 0.5

The assistant that wrote this folder reviewed five versions of the hypothesis on 20 November 2026, at the author's request ("please do an adversial review"). The author passed each version on from a conversation with another assistant. This file records the reviews in short form; the full texts are in [messages/](messages/README.md). The literature named in them was named from the reviewer's general knowledge and **has not been checked against primary sources** (working agreement 1). Treat the names as leads.

## Rounds 1 to 3, in one paragraph each

**Version 0.1.** The core claim was close to circular: the verbs were defined as the mechanisms of correction and then predicted to support correction. The hedges ("partly", "increases the risk", "not unique, not necessary") left no result that could count against it. It treated accuracy, the quality of the commons and the persistence of relationships as if they moved together, when cohesion can rest on shared beliefs that are never corrected. Nine mechanisms were named for ten verbs (Stay open had none). No verb for forgetting or for policing.

**Version 0.2 (two routes to correction).** Better: detecting a contradiction was separated from finding the error, and more communication was no longer assumed to help. But the prediction ("additional reliable and independent routes improve correction") was close to true by definition, a third route (checking one's own reasoning) was missing, and errors travel the same routes as corrections.

**Version 0.3 (corrective filtering).** Much better: contamination built in, outcomes separated, a falsification section. But its two main predictions concerned how to combine evidence of different reliability and did not involve the verbs; the verbs carried weight only in a test that was left unspecified ("must be specified for each task"). The definitions of the verbs carried success inside them ("revise *appropriately*").

## Round 4: the review of version 0.4

Version 0.4 makes the decomposition the claim and states a predicted impairment matrix. The review's points:

1. **Half the matrix does not discriminate.** Change, Remember / let go, Take care and Find new ways predict "impaired everywhere", which cannot be told apart from one general learning factor. Stay open and Be honest are nearly the same row; so are Share and Repair. The ± and \* entries are consistent with any result. The verbs seem to come in two kinds: some separate by *route* (Try, Share, Notice), others by *condition* (Remember / let go by volatility, Take care by scarcity, Find new ways by a blind spot, Repair by disruption). The matrix needs both axes.
2. **P1 to P5 are mostly true by how the tasks are built.** Repair is defined as recovery after disruption, so it can only matter after disruption; reducing testing reduces test-based correction. Good manipulation checks, but not risks. The one claim that can fail is "outperforms simpler alternatives", and the alternatives are not named.
3. **The simpler alternatives exist.** Standard learning models already have parameters close to Try (exploration), Notice (precision), Change (learning rate), Remember / let go (volatility, forgetting), Stay open (weight on social information), Take care (cost of sampling) and Find new ways (structure learning). Nothing standard corresponds to Be honest, Share with provenance, or Repair. So the new content may lie in the verbs between learners, and the relational part may be the contribution rather than an extension.
4. **Identifiability first.** With ten parameters, some will trade off (a slow learning rate and a weak noticing can look the same). Before any knockout study: simulate agents with known settings, fit the model back, and see whether the ten come back separately. If they do not, no experiment with that task can separate them, and the claim fails cheaply. This also answers the trap v0.4 names itself (agents built around the ten verbs will show them): recovery tests whether the *task and the measurement* can tell the verbs apart.
5. Smaller points: cross-substrate claims need evidence that a measure means the same in each substrate; Be honest may be observable but not manipulable in people; the three-agent relational experiment is the strongest design in v0.4 but needs many pairs.

The author's response: "Please build the simulation in the EbE repo." The simulation is point 4.

## Round 5: the review of version 0.5

Version 0.5 ([HYPOTHESIS_V0_5.md](HYPOTHESIS_V0_5.md)) adopted most of round 4 and made two corrections to it, both accepted: Be honest, Share and Repair have research literatures of their own (the round-4 point was only that standard *learning models* lack parameters for them), and failed recovery in one design does not by itself disprove the theory. It was written before the simulation results existed. The review set it against them:

1. **§8 could reject a true model.** With sparse choices, model selection never picked the full model when it generated the data (0 of 40). A rejection under §8 should count only in designs where model recovery has shown that M4 is picked when true.
2. **Its illustrative recovery matrix expected the wrong failure** (Notice–Change and Share–Repair confusion). The simulation's main failures were invisibility outside a condition and thin measurement. *(Later corrected in part: an outside review showed the simulation's trade-off check was too weak; with a better check, Stay open and Change do trade off. See [REVIEW_OF_PR155.md](REVIEW_OF_PR155.md).)*
3. **Several §3 contrasts build in the answer** v0.5 warns against building in: Repair (disrupted vs. intact), Take care (scarce vs. plentiful), Find new ways (methods unable vs. able), Share (private vs. already shared), Change ("detected but not yet incorporated"). The risky rows are those where the condition is a cause: Be honest under incentives, Notice under noise, Stay open under a misleader.
4. **Remember / let go needs a crossover**, with opposite signs for the two impairments, not one "greater adverse effect" row; the escape clause about reversed order should go.
5. **M1 must generate behaviour** (all verbs fixed functions of one ability), **M2 must be written down**, and **M4's "context-dependent interactions" must be fixed in advance or dropped.**
6. **Process:** v0.5 had taken up most of round 4, so further rounds between the two assistants converge rather than test.

The author then passed on a set of instructions for the next step, verbatim in [NEXT_STEP_INSTRUCTIONS.md](NEXT_STEP_INSTRUCTIONS.md).
