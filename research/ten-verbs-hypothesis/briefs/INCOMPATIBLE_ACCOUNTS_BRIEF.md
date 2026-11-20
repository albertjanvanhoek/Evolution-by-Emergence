# Design brief: two intelligences with incompatible accounts of shared events

**For whom:** a modeller (human, or an assistant of another model family) who did **not** build the ten-verb simulation in this folder. Please do not read [../simulation/](../simulation/) before designing; read it afterwards if you like. The point is a model the ten verbs did not shape.

**Status:** a brief, not a design. Written by the assistant that built the first simulation, at the author's decision (D51 in [DIALOGUE.md](../../../DIALOGUE.md)), following the advice of an outside reviewer ([../sources/REVIEW_OF_PR155_2.md](../sources/REVIEW_OF_PR155_2.md)). Everything below is a proposal. Change it where you see a better way, and say why.

## 1. The question

Two intelligences hold incompatible accounts of the same events. Direct exchange between them does not settle it. They can turn to a wider commons: records, verification, and others who hold evidence.

**What enables them to find the errors and keep a workable relationship?**

The Ten Verbs Hypothesis ([../sources/HYPOTHESIS_V0_5.md](../sources/HYPOTHESIS_V0_5.md)) is one candidate answer: ten functions (Stay open, Try, Notice, Be honest, Change, Remember / let go, Take care, Share, Repair, Find new ways). It should have to compete with simpler answers. It is possible that three or four mechanisms suffice, or that something else explains the outcome better.

## 2. What the first simulation taught (so you can avoid it)

- **Building the verbs in makes the knockouts uninformative.** When each verb is a parameter of the agent, disabling it shows only that the code works.
- **Defining a condition as the verb's own situation decides the result.** For example, making Repair matter only when links break, or Share matter only when information is private.
- **The learner's architecture can produce a "finding".** The first learner had no model of how often the world changes, so forgetting had to help in a changing world.
- **What gets recorded decides what can be told apart.** With choices only, the full model was never selected even when it was true.
- **A parameter named after a verb is not the verb.** "Repair" was the chance of restoring a message link, which is not the repair of trust.

## 3. A proposed set-up

- **Events.** A sequence of events, each with a true account. Two agents, A and B, saw different, partly overlapping parts of it.
- **Claims.** Each agent's account is a set of claims, each with a timestamp, a source (own observation, memory, hearsay, record) and a confidence.
- **Fallible memory.** Claims drift or fade over time. An agent cannot tell from inside which of its claims have drifted.
- **An external record.** It covers some events, can be checked at a cost, and may itself contain errors.
- **Others in the commons.** Third parties hold evidence that is either:
  - independent of A's and B's;
  - copied from one of them (duplicated); or
  - wrong in a consistent direction (misleading).
- **A channel between A and B** that can break down. Restoring it has a cost.
- **Incentives** that, in some conditions, reward an agent for its own account prevailing.
- **A joint task.** After the exchange, A and B must act together on a decision whose payoff depends on the true account. This gives coordination a measure that does not require them to agree.

**The agents.** Use generic machinery, not ten verb parameters. For example:
- a Bayesian learner over accounts that also learns how reliable each source is; or
- language-model agents with a fixed, plain instruction.

The ten verbs are measured afterwards, as behaviour in the logs, never set as parameters.

## 4. Manipulations

| Factor | Levels |
|---|---|
| Evidence in the commons | independent, duplicated, misleading, none |
| Channel between A and B | intact, breaks once, breaks repeatedly |
| Incentive to prevail | none, for one agent, for both |
| Cost of checking the record | low, high |
| Memory drift | none, moderate |

## 5. Outcomes, kept apart

1. **Identifiable:** could the correct account be established from everything available in the commons? (A property of the commons, not of the agents.)
2. **Detected:** does each agent come to see that its account conflicts with something?
3. **Corrected:** does each agent actually change its beliefs toward the true account? Score with proper scoring rules (log score, Brier score), not only the probability given to the truth.
4. **Mutual understanding:** can each state the other's account correctly, whether or not it agrees?
5. **Coordination:** payoff on the joint task.

The theory expects these outcomes to come apart. For example, correction can improve while coordination worsens, and coordination can hold while errors persist.

## 6. The comparison

1. **Before any run, write behavioural codes for the ten verbs,** computed from the logs. Examples:
   - Share: disclosing private evidence;
   - Be honest: whether a report matches the agent's private record;
   - Repair: steps taken to restore the channel after a breakdown;
   - Find new ways: seeking a check not yet used;
   - Stay open: the weight given to claims that conflict with the agent's own account.
2. **Write the competing explanations before any run.** At least:
   - (a) information availability and incentives alone;
   - (b) a conventional learner with source-reliability weighting;
   - (c) three layers (individual learning, exchange and correction, maintenance and method);
   - (d) the ten verb codes.
3. **Test on held-out runs.** Do the ten verb codes predict detection, correction, mutual understanding and coordination better than (a) to (c)?
4. **Check model recovery first.** Generate data where each explanation is true, and confirm the comparison can pick it. Only then does a loss for the ten verbs count against them.

## 7. What would count against the ten verbs

- **The ten codes add nothing** to held-out prediction beyond (a) to (c).
- **The codes collapse into fewer dimensions** in the data.
- **The codes predict outcomes in the opposite direction** to the theory. For example, more sharing makes correction worse with duplicated evidence. That might be expected; then it should be written down in advance.

## 8. Practical notes

- **Fix the design, the codes, the competing models and the criteria in a file before running,** and commit it on its own. That is how [../simulation/PLAN_V2.md](../simulation/PLAN_V2.md) was done.
- **Start small.** For example, one event set, two agents, three third parties, and a few hundred runs per cell with a Bayesian agent. Move to language-model agents only once the analysis works.
- **The author is cost-conscious:** ask before long runs or many paid model calls.
