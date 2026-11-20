# The Ten Verbs Hypothesis: can a task tell the verbs apart?

**Status: a finished feasibility study, November 2026; not merged, merging is the author's call** (D51 in [DIALOGUE.md](../../DIALOGUE.md)). **Nothing here is established.** The hypothesis is version 0.4, written in conversation with the author by another assistant. The simulation was written by the assistant that reviewed it. One outside reader has reviewed the simulation four times without rerunning it; no human reader has assessed any of it.

| Part | Where |
|---|---|
| **The full record, in order:** every version (0.1 to 0.5), every review and reply, and the closing assessment (H1 and H2), verbatim | [sources/messages/README.md](sources/messages/README.md) |
| The hypothesis, version 0.4, verbatim | [sources/HYPOTHESIS_V0_4.md](sources/HYPOTHESIS_V0_4.md) |
| The five rounds of review of the hypothesis | [sources/REVIEW_V0_4.md](sources/REVIEW_V0_4.md) |
| Four outside reviews of the simulation, verbatim | [sources/REVIEW_OF_PR155.md](sources/REVIEW_OF_PR155.md), [_2](sources/REVIEW_OF_PR155_2.md), [_3](sources/REVIEW_OF_PR155_3.md), [_4](sources/REVIEW_OF_PR155_4.md) |
| Version 0.5 and the instructions for a next step, verbatim | [sources/HYPOTHESIS_V0_5.md](sources/HYPOTHESIS_V0_5.md), [sources/NEXT_STEP_INSTRUCTIONS.md](sources/NEXT_STEP_INSTRUCTIONS.md); plan in [simulation/PLAN_V2.md](simulation/PLAN_V2.md) |
| The model, the fitting and the experiments | [simulation/model.py](simulation/model.py), [simulation/fit.py](simulation/fit.py), [simulation/run.py](simulation/run.py) |
| Results, with their limits | [simulation/results/RESULTS.md](simulation/results/RESULTS.md); generated tables in [tables.md](simulation/results/tables.md) |
| Trade-offs between verbs (added after the outside review) | [simulation/tradeoffs.py](simulation/tradeoffs.py); [tradeoffs.md](simulation/results/tradeoffs.md) |
| Checks that the fit replays the full belief vector exactly | [simulation/test_model.py](simulation/test_model.py) |
| A brief for an independent review of this study | [briefs/REVIEW_BRIEF.md](briefs/REVIEW_BRIEF.md) |
| **The next experiment:** a phenomenon-first brief for the modeller (no verbs named), and a separate analysis plan for after the model is frozen | [../incompatible-accounts/BRIEF.md](../incompatible-accounts/BRIEF.md); [briefs/ANALYSIS_PLAN_NEXT_EXPERIMENT.md](briefs/ANALYSIS_PLAN_NEXT_EXPERIMENT.md) |
| Unfinished, not run: the four-model comparison | [wip/](wip/README.md), with the plan in [simulation/PLAN_V2.md](simulation/PLAN_V2.md) |

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
python tradeoffs.py --optimiser-check   # optimiser check, about 7 minutes
```

Needs numpy, scipy and matplotlib.

## 5. Where this ends, and what comes next

This study answers a measurement question: in one agent built with ten verb settings, which settings can be recovered. It has shown how easily such a simulation turns its own assumptions into apparent findings. It does not test the hypothesis itself.

- **Next, and the priority:** an independent model of two intelligences with incompatible accounts of shared events, with a wider commons offering routes to correction, and agents **not** built around the ten verbs. The modeller gets only the phenomenon ([../incompatible-accounts/BRIEF.md](../incompatible-accounts/BRIEF.md)) and freezes the model before anyone looks for the verbs. Only then does a separate analysis ([briefs/ANALYSIS_PLAN_NEXT_EXPERIMENT.md](briefs/ANALYSIS_PLAN_NEXT_EXPERIMENT.md)) code the ten verbs from behaviour that comes before the outcomes, and compare them with simpler explanations. It should be built by another modeller or model family.
- **Kept for later:** the four-model comparison (one general capacity; a conventional learner; three layers; ten verbs), planned in [simulation/PLAN_V2.md](simulation/PLAN_V2.md) and started in [wip/](wip/README.md). Not run.
- **The hypothesis is frozen** for now ([closing assessment](sources/messages/12_closing_assessment.md)). Two questions are at its centre: H1, whether the wider commons helps correction and coordination when direct disagreement stays unresolved; and H2, whether the ten verbs explain correction within and between intelligences better than simpler models. The analysis plan fixes directional predictions for H1, and says what the next experiment can and cannot test of H2.
- **Not touched:** reasoning-mediated checking (the L column), and the relational extension of the hypothesis.
