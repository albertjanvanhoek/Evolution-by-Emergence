# The Ten Verbs Hypothesis: can a task tell the verbs apart?

**Status: a first simulation check, November 2026** (D51 in [DIALOGUE.md](../../DIALOGUE.md)). **Nothing here is established.** The hypothesis is version 0.4, written in conversation with the author by another assistant. The simulation was written by the assistant that reviewed it. One outside reader has reviewed the simulation twice without rerunning it; no human reader has assessed any of it.

| Part | Where |
|---|---|
| The hypothesis, version 0.4, verbatim | [sources/HYPOTHESIS_V0_4.md](sources/HYPOTHESIS_V0_4.md) |
| The five rounds of review of the hypothesis | [sources/REVIEW_V0_4.md](sources/REVIEW_V0_4.md) |
| Two outside reviews of the simulation, verbatim | [sources/REVIEW_OF_PR155.md](sources/REVIEW_OF_PR155.md), [sources/REVIEW_OF_PR155_2.md](sources/REVIEW_OF_PR155_2.md) |
| Version 0.5 and the instructions for a next step, verbatim | [sources/HYPOTHESIS_V0_5.md](sources/HYPOTHESIS_V0_5.md), [sources/NEXT_STEP_INSTRUCTIONS.md](sources/NEXT_STEP_INSTRUCTIONS.md); plan in [simulation/PLAN_V2.md](simulation/PLAN_V2.md) |
| The model, the fitting and the experiments | [simulation/model.py](simulation/model.py), [simulation/fit.py](simulation/fit.py), [simulation/run.py](simulation/run.py) |
| Results, with their limits | [simulation/results/RESULTS.md](simulation/results/RESULTS.md); generated tables in [tables.md](simulation/results/tables.md) |
| Trade-offs between verbs (added after the outside review) | [simulation/tradeoffs.py](simulation/tradeoffs.py); [tradeoffs.md](simulation/results/tradeoffs.md) |
| Checks that the fit replays the full belief vector exactly | [simulation/test_model.py](simulation/test_model.py) |

## 1. The question

Version 0.4 makes one claim that can fail: the ten verbs (Stay open, Try, Notice, Be honest, Change, Remember / let go, Take care, Share, Repair, Find new ways) are separate functions, and impairing each one gives a pattern of failure that a ten-part model explains better than simpler ones.

The review of v0.4 asked a prior question. **Can any experiment tell the ten apart?** Simulate learners whose verb settings are known, record what an experimenter could record, fit the settings back, and see which come out. If a verb cannot be recovered even from a model that is known exactly, no experiment with that task and that measurement will find it. The author's instruction: "Please build the simulation in the EbE repo."

## 2. What was found

In one model of the verbs, written by the assistant:

1. **With rich belief reports, most verbs come back well**: correlations of 0.81 or more for Stay open, Notice, Change, Remember / let go and Share in every condition; Try 0.68 to 0.81.
2. **Two verbs are invisible outside their condition.** Take care shows only when resources are scarce, Repair only when links break. Elsewhere the data hold nothing about them. The review's point stands: the matrix needs a condition axis as well as a route axis.
3. **Two verbs are weakly recovered by this design:** Be honest (0.32 to 0.73) and Find new ways (0.12 to 0.50). The cause is measurement, and a task can fix it.
4. **With only choices recorded, the belief verbs blur** (Stay open 0.37, Notice 0.37 in the base condition). And BIC never picked the full model when it was true (0 of 40). **So v0.4's main test could fail for reasons of measurement alone.** With this task, rich belief reports were the remedy; longer tasks or other measurements were not tried.
5. **Some verbs trade off.** Errors in recovering Stay open and Change move together (−0.41 with rich reports), because in this model the two multiply for disagreeing testimony. The first version of this note said there were no trade-offs; an outside review showed the check could not support that.
6. **The knockout matrix of this model** matches v0.4 on the route-specific and condition-specific verbs. **That match was built in and is not evidence.** Remembering everything helps in stable worlds and makes beliefs confidently wrong in changing ones, but that crossover is largely built in: the learner has no estimate of how often the world changes, so forgetting is its only way out (pointed out by a second outside review). Closing off disagreeing testimony did not protect against one misleader among five honest learners. How costly letting go too fast is depends on the score used.
7. **The verbs are modelled narrowly.** Repair is restoring a message link, not restoring trust; Be honest is passing on the observed outcome rather than the expected one. A parameter called Repair can be recovered without relational repair having been modelled.

## 3. How much this says

It says what **this task and these measurements** can separate **for learners built like this model**. Each result's limits are stated next to it in [RESULTS.md](simulation/results/RESULTS.md). The largest limit: the model is one assistant's way of writing the verbs, and a different model could recover them differently. Working agreement 7 applies: this needs a third view before it is leaned on.

## 4. Reproduce

```
cd research/ten-verbs-hypothesis/simulation
python test_model.py          # replay checks, seconds
python run.py                 # all experiments, about 30 minutes on 2 cores
python run.py --figures-only  # redraw figures from results/results.json
python run.py --e4-only       # rerun only the knockouts, seconds
python tradeoffs.py           # error correlations and profile likelihood, minutes
```

Needs numpy, scipy and matplotlib.

## 5. Open

- The three simpler models the review proposed (one general factor; a standard learner with a weight on social information; three tiers) are not yet fitted.
- Reasoning-mediated checking (v0.4's L column) is not modelled.
- An independent model built around the phenomenon (incompatible accounts of events, claims with provenance, fallible memory, an external record), with agents not built around ten verbs, as the outside review proposes. Ideally designed by someone other than this assistant.
- The relational extension (H2 of v0.4) is not touched here.
