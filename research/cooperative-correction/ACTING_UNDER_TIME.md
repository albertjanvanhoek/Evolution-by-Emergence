# Acting under time

**Status: conjecture 5 of this investigation, under investigation, October 2026** (D35 in [DIALOGUE.md](../../DIALOGUE.md)). Part of [the investigation of cooperative error identification](README.md), at the author's request: "this should be included in the thougth process on this problem". It has a formal model, [`ActingUnderTime.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/ActingUnderTime.lean) (11 results and a witness), and simulations E8 and E9 ([sim_time.py](simulation/sim_time.py), results in [RESULTS_TIME.md](simulation/results/RESULTS_TIME.md)). **Nothing here is established.** The definition of a world model in the core is not changed. A world model only models reality and its possible futures; acting belongs to a second model (section 2).

## 1. The missing piece

In the author's words:

> "There is still a component I miss from the world models and this is about the future - it is about preventing mistake in real life - and actions towards the future - and that these actions change the future. You cannot escape the future, you need to act - and inaction is also action - hence there is a time element to this - it has to be done. And perhaps this is your answer on the outstanding question - the regression has an end - when the next decision has to be made."

The outstanding question was the regress at the end of review B: a shared bridge is itself a model that has to be tested, and so is the test of the test. A further response the author shared ([sources/INPUT_ACTING_UNDER_TIME.md](sources/INPUT_ACTING_UNDER_TIME.md)) put the point as: "Reality does not wait for an intelligence to finish understanding it."

What was missing from the investigation so far is acting. A holder does not only compare and correct world models. It also has to **act**, under a clock, and the action changes the world being modelled.

## 2. Two models: the world model and the action model

The author, on a first version of this note that said a functional world model should help prevent harm:

> "A world model should prevent harm? What is that? A world model ought to be a world model - it should model reality - nothing else - it is aimless other than modelling reality - and the possible future of reality - the secondary model is how I need to act to prevent mistakes towards this future reality."

So there are two models, and they should not be merged:
- **The world model** models reality and its possible futures. It has no aim of its own beyond modelling. Because the holder is part of reality, its possible futures include those that depend on what the holder does: "what happens if I intervene, and what if I don't" is still a question about reality. The [definition](../world-model/WORLD_MODEL.md) already says this: a world model supports inference about "what may happen, and what would happen under different actions", and plans and values are separate models.
- **The action model** is the second model. It decides what to do. It takes the world model's possible futures, adds what is valued and the clock, and chooses, waiting included. Preventing mistakes is its aim, not the world model's.

The input named three tasks: understanding (what is happening, and why?), prediction (what will happen if nothing changes?) and intervention (what will happen if I act, and what should I do?). The first two, and the first half of the third, belong to the world model. Only "what should I do?" belongs to the action model. The distinction is close to Pearl's distinction between observing, intervening and imagining counterfactuals, which is prior art to be checked (section 8).

**Where the regress ends.** In the action model, not in the world model. The world model stays open to revision. It never reaches a final check, and it does not need to. The action model closes one round of deliberation at each decision, because further checking is worth less than the cost of delay. After the decision, the world model takes in what the action made observable, or failed to.

The other models an intelligence keeps, and how they fit around this loop, are listed in [Models for acting in a changing world](../world-model/MODELS_FOR_ACTING.md) (D36).

**Where the separation leaks.** The world model is aimless in what it claims, but not in what it covers. Purpose chooses which questions it asks, at what detail, and where to look ([WORLD_MODEL.md](../world-model/WORLD_MODEL.md) says the same). And the action model shapes the world model's evidence: a successful prevention removes the observations that would have shown it was needed (sections 4 and 5). That is a fact about reality, so modelling it belongs to the world model.

## 3. Conjecture 5, with its parts labelled

The input proposed a principle, "the temporal necessity of action". Stated with the labels of the [creed](../discovarianism/CREED.md), and with the input's claim that a functional world model must support preventing errors through action replaced, at the author's correction, by the separation in section 2:

1. **At every moment some option is taken, waiting included.** *Follows,* once time passes and waiting is counted among the options: there is no way not to choose.
2. **The regress of checking ends locally, at the decision boundary, in the action model.** It ends not by reaching a foundation, but because further checking is worth less than the cost of delay. *Follows* under two conditions: each further level of checking is worth less than the one before, and checking costs something (`regress_has_finite_depth`).
3. **A world model models reality and its possible futures, including those that depend on the holder's own actions, and has no aim beyond that; how to act on it is a second model.** A definition, the author's, consistent with [WORLD_MODEL.md](../world-model/WORLD_MODEL.md). That the action model aims to prevent mistakes is an aim, stated, not derived (D7).
4. **The consequences of action become part of the reality modelled next.** Learning and acting form a loop. *Follows* from the holder being in the world it models (step 8 of [CORE.md](../../CORE.md)).
5. **Which action is right, and which values to weigh, does not follow.** *Proposed,* and only separately (D7). In the input's words: "we should not smuggle normative conclusions into a theorem about time."

As the input puts it: "The regress ends locally when we must act. But the responsibility to learn does not end there. It continues into the future our actions have helped create."

## 4. The smallest formal model

[`ActingUnderTime.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/ActingUnderTime.lean) has:
- **two states:** the situation is bad or good, with prior weights;
- **two actions:** intervene, or not, each with a payoff in each state;
- **a delay cost** for waiting until the state is known;
- **a reversal cost** for undoing an intervention.

It proves:
- **Information never hurts** (`information_never_hurts`).
- **The decision boundary:** waiting beats acting now exactly when the value of the information exceeds the cost of the delay (`waiting_pays_iff`).
- **No dependence, no value:** if one action is at least as good in both states, the information is worth nothing, and any positive delay cost makes acting now strictly better (`no_dependence_no_value`). When the decision does not depend on the unknown, the regress ends at once.
- **Reversibility:**
  - if an intervention can be undone at no cost, intervening now and correcting later is worth as much as knowing the state in advance, without the delay (`free_reversal_recovers_information`);
  - a reversible intervention is never worse than the same intervention made irreversible (`reversal_never_hurts`).

  So reversibility lowers the value of waiting. This is the irreversibility effect of environmental economics: waiting has an option value when an action cannot be undone and information will arrive.
- **Prevention hides the counterfactual:** if the outcome after intervening is the same whatever the state, observing it cannot tell the states apart (`prevention_hides_the_counterfactual`).
- **Cheaper delay favours waiting:** lowering the cost of delay never makes waiting less attractive (`cheaper_delay_favours_waiting`). A collective that pools evidence learns sooner, and so shifts the boundary toward investigating.
- **The regress has finite depth,** under the conditions in section 3 (`regress_has_finite_depth`).
- **The witness, an outbreak-shaped example:**
  - acting now is worth −20, and knowing the state −6, so the information is worth 14;
  - waiting pays at a delay cost of 1 (−16) but not at 2 (−26);
  - intervening now and lifting the measure at a cost of 1 where it proves unneeded is worth −13, better than both.

The results are close to arithmetic. The payoffs are inputs. The model says when to stop investigating given what is valued, not what should be valued.

## 5. The simulations (E8, E9)

[sim_time.py](simulation/sim_time.py) is seeded.

**The setup:**
- **The threat:** it grows or not, with prior 0.3. If it grows and nothing is done, the damage multiplies by 1.35 each period, over 16 periods.
- **The evidence:** six agents receive noisy signals, and three of them share most of their noise, as one lab.
- **The decision:** each period the collective intervenes or waits.
- **The policies:** each threshold is tuned on one set of runs and evaluated on another, so no policy is favoured by tuning.

### E8. Cooperation and reversibility move the boundary

| Evidence | Irreversible: best threshold | Loss | Wrong interventions | Reversible, same cost: best threshold to start | Loss |
|---|---|---|---|---|---|
| one agent | act at once on the prior | 6.00 | 100% | 0.10 | 5.57 |
| all agents, the lab counted once | 0.55 | **3.23** | 15.5% | 0.35 | **2.54** |
| all agents, the lab counted three times | 0.65 | 3.62 | 20.5% | 0.35 | 2.94 |
| never act | — | 51.67 | 0% | — | — |

In the reversible columns, the running cost is set so that never lifting the measure costs as much as the irreversible one. With the running cost doubled, the losses are 8.89, 4.41 and 4.87, with thresholds 0.35, 0.55 and 0.65.

- **Cooperation changes when acting is right.** One agent's evidence is too weak to be worth waiting for; its best policy is to act at once on the prior. Pooled evidence makes waiting worth it, and the loss nearly halves. This is `cheaper_delay_favours_waiting` in practice: a collective that learns faster can afford to look before it acts.
- **Dependence ignored makes the collective act on overconfident evidence:** more wrong interventions and a higher loss.
- **Reversibility makes earlier action right.** With the same evidence, the best threshold to start drops from 0.55 to 0.35, and the loss falls.

### E9. Prevention hides the evidence

While a reversible measure is on and works, a growing threat produces the same signals as a harmless one.

| Agents | Best threshold to start | Loss | Switches |
|---|---|---|---|
| signals not masked (for comparison) | 0.35 | 2.52 | 0.73 |
| masked, read as if they were not | 0.95 | **26.34** | 0.59 |
| masked, and the agents know it: they stop updating while the measure is on | 0.60 | 2.86 | 0.39 |
| masked, known, plus a noisy sentinel channel the measure does not mask | 0.60 | 2.89 | 0.40 |

- **Reading suppressed signals as "all clear" is disastrous.** The measure is lifted, the damage returns, and the loss is ten times higher. This is the preparedness paradox as a decision error.
- **Knowing about the masking avoids that, at a price:** learning stops while the measure is on.
- **After an irreversible intervention, no decision can be checked afterwards** without a channel that the intervention does not mask: none of 8,461 interventions. With a noisy sentinel channel, 23% can be checked at 95% confidence. In this setup the sentinel did not lower the loss. Its value was in being able to tell afterwards whether the intervention was needed.

## 6. What this changes for the other conjectures

- **The collective's aim in acting becomes more demanding.** It is an aim of the action model, not of the world model. In the input's words: "Cooperate to identify and correct errors in our understanding early enough to prevent avoidable harm, while improving our ability to act in the future."
- **Disagreement gets a deadline.** Two agents can disagree about an outcome, agree that an irreversible decision is approaching, and work together on the most informative observation they can get before it. They need not resolve every disagreement; they need enough to choose the next action responsibly.
- **Action as a bridge, with a catch (conjecture 2).** Once agents act, the world answers whether or not they agree on what counts as evidence. The consequence is a shared record neither can dispute for ever. But a *successful* prevention is exactly the action whose consequence says least (E9).
- **Diversity of channels, in time (conjecture 4).** An independent channel that the action does not touch is what keeps learning possible after acting. It is the same lesson as the shared-error floor, now about the future: keep a way of seeing that your own interventions cannot blind.
- **The regress, answered locally.** The regress of review B (the bridge is a model, and so is its test) ends at each decision, by value of information and cost of delay, not by certainty. It reopens after the decision, with the new evidence the action produced, or failed to produce.

## 7. Where it fails, or could be misused

- **A deadline does not make a decision good,** only necessary.
- **Deadlines can be manufactured.** Urgency is a way to cut correction short. "Is the deadline real?" is itself a question in the regress. Time answers it, but sometimes too late. A functional collective needs a way to check claimed urgency.
- **The value of information assumes the payoffs are known and agreed.** Often they are contested, and that disagreement is not settled by evidence (D7).
- **Acting changes the evidence.** Interventions remove the counterfactual. To keep modelling reality, the world model therefore needs records of what was done, and some way of estimating what would have happened: a channel the action does not mask, a comparison group where that is ethical, or a model of the counterfactual that can itself be tested.
- **The simulations are simple:** two states, one threat, known costs, and one fixed form of masking.

## 8. Prior art, as leads not yet checked in their sources

- **Value of information:** Howard (1966).
- **The value of further computation for action** (rational metareasoning): Russell and Wefald (1991), cited by the input.
- **Irreversibility and option value:** Arrow and Fisher (1974); Henry (1974).
- **Acting under partial observability:** partially observable Markov decision processes.
- **Seeing, doing and imagining:** Pearl's distinction.
- **Rebuilding the ship at sea:** Neurath's image of revising a theory while relying on it.

None is quoted here; each is to be checked before any claim rests on it (working agreement 1).

## 9. What would count against it

- **Against the decision boundary:** a well-specified decision in which further investigation keeps paying beyond the point where its value falls below the cost of delay. That would mean the costs or values are mis-specified, not that the arithmetic fails.
- **Against "cooperation moves the boundary":** pooled evidence that does not shorten the time to a good decision, or leads to more harmful decisions, compared with the same agents acting alone. Outbreak response records with documented decision times could test this.
- **Against "prevention hides the evidence":** a successful prevention whose need can be established afterwards from the masked channel alone.
