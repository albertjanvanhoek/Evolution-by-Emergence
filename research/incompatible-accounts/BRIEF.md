# Modelling brief: when two intelligences cannot agree about what happened

**For:** a modeller, human or AI, who will design and build a simulation.

**Please read only this file** (and anything you choose from outside this repository) until your design is frozen (section 6). Other folders in this repository hold ideas this experiment will later be used to test. Reading them first would make the test weaker.

## 1. The phenomenon

Two intelligences went through the same events but hold incompatible accounts of what happened. Each account seems right to the one who holds it. Talking directly does not settle it.

Around them is a wider commons:
- records;
- ways to check;
- others who saw some of it, heard about it, or claim to know.

The commons can help them find out what happened. It can also mislead them.

**The question:** under what conditions does the wider commons help them discover errors, recognise disagreements that cannot yet be resolved, and keep cooperating?

## 2. What the simulation should contain

The choices of mechanism are yours. Please include at least the following.

- **Events with a true account,** which the two agents observed in different, partly overlapping ways.
- **Fallible evidence.** Observations can be wrong. Memories can change or fade over time, and an agent cannot tell from inside which of its memories have changed.
- **An external record** that covers some events, costs something to consult, and can itself be wrong.
- **Others in the commons** whose evidence is, depending on the condition:
  - independent of the two agents';
  - copied from one of them;
  - wrong in a consistent direction; or
  - absent.
- **A communication channel** between the two agents that can break down. Restoring it may or may not be possible, and may cost something.
- **Incentives:** in some conditions, an agent gains when its own account prevails.
- **A joint task** after the exchange. The two agents must act together, and the payoff depends on what really happened. This measures cooperation without requiring agreement.
- **Inconclusive cases.** In some conditions, the evidence available anywhere in the commons cannot establish which account is right. Agents must be able to represent "this cannot be settled yet", and to act on that.

Agents should be general learners and communicators, for example:
- Bayesian agents that also learn how reliable each source is;
- agents built on a language model with a plain, fixed instruction;
- something else you think fits better.

## 3. What to record

**Everything, with timestamps,** so that behaviour can be analysed afterwards in ways you do not know yet:
- each agent's beliefs or claims at every step, with their stated confidence;
- every message, with its sender, its receiver and its content;
- every check of the record and every query to others;
- every breakdown of the channel and every attempt to restore it;
- costs spent, and the actions taken in the joint task.

## 4. Outcomes

Please make these computable from the logs, each separately:

1. **Settleable.** Could the true account have been established from everything available in the commons, or was the case inconclusive? This is a property of the commons, not of the agents.
2. **Conflict detected.** When does each agent register that its account conflicts with something?
3. **Beliefs corrected.** Does each agent's belief move toward the true account? Use proper scoring rules (log score or Brier score).
4. **Unresolvability recognised.** In inconclusive cases, does each agent hold calibrated uncertainty instead of false confidence?
5. **Mutual understanding.** Can each agent state the other's account correctly, whether or not it agrees with it?
6. **Cooperation.** The payoff on the joint task.

## 5. Conditions

**Vary at least:**
- what the others in the commons hold (independent, copied, misleading, nothing);
- whether the channel breaks;
- incentives;
- the cost of checking the record;
- memory drift;
- whether the case is settleable at all.

**Start small:** for example, two agents, three others, one set of events, and a few hundred runs per condition.

## 6. Freeze before anyone analyses

Before any analysis of agent behaviour beyond checking that the simulation works, commit in one go:
- the design;
- the code;
- the log format;
- the outcome definitions.

After that, changes are allowed only as listed deviations.

**Please do not add mechanisms because you expect someone to look for them.** Build what you think the phenomenon needs.

## 7. Practical notes

- The author is cost-conscious: ask before long runs or many paid model calls.
- Write plainly. Note your own doubts about the design next to the design.
