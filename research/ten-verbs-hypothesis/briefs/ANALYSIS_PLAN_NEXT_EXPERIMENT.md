# Analysis plan for the incompatible-accounts experiment

**Do not give this file to the modeller.** The modeller gets only the phenomenon brief, [../../incompatible-accounts/BRIEF.md](../../incompatible-accounts/BRIEF.md), which does not mention the ten verbs or this hypothesis. This plan is for the analyst. They open it only after the model, its code, its log format and its outcome definitions are frozen and committed. The analyst should preferably be someone other than the modeller.

**History.** A first version of this file was a single brief that gave the modeller the phenomenon and the ten verbs together. An outside reviewer pointed out that naming the verbs, and the first simulation's failures, could shape the new architecture ([../sources/REVIEW_OF_PR155_3.md](../sources/REVIEW_OF_PR155_3.md)). Building the model and testing the hypothesis are now kept apart. See D51 in [DIALOGUE.md](../../../DIALOGUE.md).

**Sections 6 and 7 were added on 21 November 2026, at the author's request to complete the record. They cover H1's predictions and what this experiment tests of H2. Both were written before any model existed.**

## 1. The question for the analysis

The agents were not built with ten verbs. Do the ten verbs, measured as behaviour in the logs, explain their detection of errors, correction of beliefs, recognition of unresolvable disagreement, mutual understanding and cooperation better than simpler explanations do?

The ten verbs are: Stay open, Try, Notice, Be honest, Change, Remember / let go, Take care, Share, Repair, Find new ways ([../sources/HYPOTHESIS_V0_5.md](../sources/HYPOTHESIS_V0_5.md)).

## 2. Lessons from the first simulation

[../simulation/results/RESULTS.md](../simulation/results/RESULTS.md) has the details.
- **A parameter named after a verb is not the verb.** Code the behaviour the theory means, and state how narrow each code is.
- **A condition defined as the verb's own situation decides the result.** For example: restoring a channel can only matter after it breaks.
- **What is recorded decides what can be told apart.** Check model recovery before reading any comparison.
- **Optimisers miss maxima.** Use many starts and check them.

## 3. Rules, fixed before looking at behaviour

1. **Write the codes first.** Before looking at any agent behaviour, write and commit a code for each verb, computed from the logs. Examples, to be refined against the frozen log format:

   | Verb | Example code |
   |---|---|
   | Share | disclosing private evidence the other did not have |
   | Be honest | whether reports match the agent's own logged record |
   | Repair | steps taken to restore the channel after a breakdown |
   | Find new ways | seeking a kind of check not used before |
   | Stay open | the weight shown to claims that conflict with the agent's own account |
   | Notice | how soon a conflicting observation is registered |
   | Change | how far beliefs move, given the evidence received |
   | Remember / let go | how long claims are kept, and when they are dropped |
   | Take care | how resources are spent over time |
   | Try | how informative the chosen checks were, judged before their results |

2. **Codes come before outcomes.** Each code is computed only from behaviour that happens **before** the outcome it is used to predict, and never from information about whether correction succeeded. For example: codes come from the first part of each run, and outcomes are scored at the end. Otherwise an agent could be scored as good at correcting because it corrected, and the analysis would be circular.
3. **Write the competing explanations first.** At least:
   - (a) what was available and what the incentives were, with no behaviour at all;
   - (b) a conventional learner with source-reliability weighting, fitted to the same early behaviour;
   - (c) three behavioural dimensions: individual learning; exchange and correction; maintenance and method;
   - (d) the ten verb codes.
4. **Treat inconclusive cases separately.** Where the commons could not settle the account, a good outcome is calibrated uncertainty and continued cooperation, not "correction". Analyse settleable and inconclusive cases separately, and state in advance what each explanation predicts for each.
5. **Model recovery comes first.** Generate synthetic behaviour where each explanation is true, and confirm the comparison can pick it. A loss for the ten verbs counts against them only in a design that can recover them.
6. **Use held-out prediction as the main test.** Use held-out runs or held-out conditions; information criteria are secondary.

## 4. What would count against the ten verbs

- **No gain:** the ten codes add nothing to held-out prediction beyond (a) to (c).
- **Fewer dimensions:** the ten codes collapse into fewer dimensions in the data.
- **Codes not separable:** the codes cannot be computed separately from the logs, so they are not ten measurable things.
- **Unpredicted direction:** a code predicts an outcome in a direction the theory did not state in advance.

## 5. What would count in their favour

The ten codes predict held-out outcomes better than (a) to (c), in a design where model recovery has been shown. This would hold especially for exchange between the agents: contradictory evidence, unreliable testimony, a broken channel. Even then, this would show their usefulness as a description of these agents' behaviour, not that real intelligences have ten functions.

## 6. H1: commons-mediated correctability, predictions fixed now

The closing assessment ([../sources/messages/12_closing_assessment.md](../sources/messages/12_closing_assessment.md)) puts two questions at the centre. H1 asks whether intelligences can use the wider commons to correct errors and coordinate when their direct disagreement stays unresolved. H2 asks whether the ten verbs explain correction both within and between intelligences better than simpler models. The two can stand or fall separately.

Worded as "can", H1 is close to trivially true: some run will always show the commons helping. It becomes a test only as directional predictions, written here before the model exists. They were proposed by the reviewing assistant ([../sources/messages/13_reply_two_gaps.md](../sources/messages/13_reply_two_gaps.md)) and use the conditions of the modeller's brief. They are compared with the condition in which the commons holds nothing.

- **H1-a. Independent evidence.** Belief correction (proper scores) and calibration are better when the commons holds independent evidence. This includes runs where the channel between the two agents has broken.
- **H1-b. Copied evidence.** Agents' confidence rises more than their accuracy does, compared with independent evidence of the same amount.
- **H1-c. Misleading evidence.** Accuracy is lower, unless the agents can see where the evidence came from. The size of this protection is not predicted.
- **H1-d. Inconclusive cases.** The commons improves calibration, and the quality of the choice to cooperate or refuse, but not agreement.
- **H1-e. Outcomes come apart.** In some condition, correction improves while cooperation does not, or the reverse. If every outcome always moves together, the five outcomes are not separate.

**What would weaken H1:** H1-a to H1-d failing in a design where the ideal observer shows the evidence was there to be used. Such a failure weakens H1 whatever happens to the verbs.

## 7. What this experiment tests of H2

H2 is about **recurrence**: the same functions at work when an intelligence corrects itself and when intelligences correct each other. Sections 1 to 5 code the verbs mainly from behaviour between the agents. On their own, they test only "ten codes describe interaction".

To test recurrence as well, code each verb **twice** where the logs allow:
- once from an agent's handling of its **own** evidence: observations, memory, checks of the record;
- once from its handling of evidence from **others**: the other agent and the commons.

Recurrence predicts three things:
- **R1.** An agent's code for a verb at one scale predicts its code for the same verb at the other scale, beyond what a single general factor explains.
- **R2.** The codes at the two scales show the same structure: the same number of dimensions, with the same verbs together.
- **R3.** Codes from one scale predict outcomes at the other.

**A caution:** if the agents use one mechanism for all evidence, recurrence is built in. A Bayesian agent that updates the same way on every source is an example, and R1 to R3 would then say nothing. The recurrence test is informative only with agents whose own-evidence and others-evidence handling can differ, such as language-model agents or people. Otherwise, report that this experiment tests H2 only for interaction.
