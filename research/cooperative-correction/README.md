# Cooperative error identification: can different world models correct each other?

**Status: four conjectures under investigation, October 2026** (D35 in [DIALOGUE.md](../../DIALOGUE.md)). A smallest formal model and a set of simulations, written to find out where the conjectures fail. **Nothing here is established.** Independent readers from other model families are to assess it before any of its assumptions are presented as settled ([briefs/REVIEW_BRIEF.md](briefs/REVIEW_BRIEF.md)).

| Part | Where |
|---|---|
| The invitation that started it, verbatim | [sources/INVITATION.md](sources/INVITATION.md) |
| The formal model | [`CooperativeCorrection.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/CooperativeCorrection.lean): core Lean, 8 results and 2 witnesses |
| The simulations | [simulation/sim.py](simulation/sim.py), seeded; results in [simulation/results/RESULTS.md](simulation/results/RESULTS.md) |
| The brief for independent review | [briefs/REVIEW_BRIEF.md](briefs/REVIEW_BRIEF.md) |

## 1. The question

The author's invitation starts from one conjecture: "intelligences do not need to agree on what is true in order to cooperate in improving their understanding of reality. They need a shared capacity to identify and correct errors." After a first exchange, he split it into three, to be investigated separately:

1. **Minimal cooperation:** intelligences with incompatible world models can identify shared errors without adopting a common worldview.
2. **Bridge construction:** intelligences without an initially shared evidential standard can sometimes establish new local standards through interaction.
3. **Collective improvement:** under identifiable conditions, such cooperation produces better models of reality than the intelligences would develop independently.

And a fourth, which he asked to be challenged as hard as the others:

4. **Preserved diversity:** "Could the optimal collective world model be one that continually improves its relationship with reality while deliberately preserving multiple independent ways of modelling it?"

Two rules from the author govern the work. "None of these should be assumed true merely because the preceding one holds." And: "Let's keep logical implications separate from behavioural assumptions." A test that exposes an error does not by itself make anyone revise; revision is something agents do.

## 2. The smallest formal model

[`CooperativeCorrection.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/CooperativeCorrection.lean) models two agents over possible worlds. Each has:
- a **support**, the worlds it keeps possible;
- **its own model of the operations** that can be performed (measurements, experiments, procedures): what each operation yields in each world.

The two agents may differ in both. In particular, they need not agree on what an outcome *means*.

**How a bridge can be built rather than assumed.** A shared standard of evidence is usually pictured as a shared interpretation of observations. The model uses two thinner things:
- a **shared record:** both agents accept *which outcome occurred*, without agreeing on what it shows;
- **commitment:** before the operation is performed, each agent states which outcomes its model allows, and that set excludes something.

An operation on which both are committed and whose allowed outcomes do not overlap **discriminates** them. That is a bridge built from public material: two committed predictions and one shared record. Neither agent has to adopt the other's model, its concepts, or its view of what the outcome means.

**What follows logically:**
- **A discriminating operation exposes at least one agent,** whatever the outcome (`discrimination_exposes_one`).
- **It does not say which.** The same operation exposes either agent, depending on the outcome (`exposure_does_not_say_who`).
- **An exposure locates an error in one of two places,** without saying which: either the agent's support excludes the actual world, or its model of that operation is wrong about it (`failure_is_support_or_mechanism`). This is the Duhem–Quine problem in miniature.
- **A faithful agent is never exposed** by a true record (`faithful_agent_accommodates`). So when records are true, every exposure is a real error.
- **An uncommitted agent is never exposed,** and no operation discriminates it from anyone (`uncommitted_agent_is_never_exposed`). A discriminating operation always has two committed agents (`discrimination_requires_commitment`).
- **No shared interpretation is needed.** In the witness, two agents whose models of the operation disagree at *every* world are still discriminated by it.
- **A shared record is needed.** In the witness, if the two agents record different outcomes, each is accommodated by its own record, and the exposure disappears.
- **Bridges accumulate:** an operation that discriminates stays a bridge as the set of shared operations grows (`bridges_grow_with_shared_operations`).

**What is a behavioural assumption:** that an exposed agent revises. The module defines `Responsive` separately. The witness shows an agent that is exposed and does not change, which is logically consistent.

| Conjecture | What the formal model says it needs | What it does not need |
|---|---|---|
| 1. Minimal cooperation | a shared record of at least one operation; commitment by both; disjoint allowed outcomes | a shared support, shared operation models, a shared interpretation |
| 2. Bridge construction | operations both can perform, reproducible enough to give a shared record, inside both models | agreement on meaning in advance |
| Revision (any) | responsiveness, an assumption about agents | — |
| Knowing *who* is wrong | more than two agents, or further operations | — |

## 3. The simulations

[simulation/sim.py](simulation/sim.py) runs five experiments. All randomness is seeded, and all regimes in an experiment see **the same raw data**; only what they do with it differs.

**The world, for E1, E2 and E5.** A single true quantity is measured by six agents, each with its own method. Every method has a systematic error the agent does not know about, plus sampling noise.

**Dependence between sources is explicit.** Agents are grouped by the origin of their errors. In the dependent setting, three agents share most of their systematic error (one lab, 80% of its variance shared), and three are independent. A further error can be switched on that is **shared by every method**, the error nobody inside the collective can see.

**The bridge.** From round 10 on, every agent can measure a common reference sample, whose value nobody knows. Differences between agents' readings of it reveal their *relative* errors, never their absolute ones.

**The regimes:**
- **independent:** each agent uses only its own data;
- **lone agent, same total data:** one method given as much data as the whole group. This controls for the amount of information;
- **forced consensus:** everyone adopts the equal-weight average and treats the other agents as independent;
- **cooperative error identification:** each agent keeps its own method and records, uses the bridge to estimate its own relative error, and corrects itself. Three variants:
  - **no provenance:** every agent counted as an independent origin;
  - **with provenance:** agents grouped by the origin of their errors, "count origins, not copies";
  - **robust:** with provenance, plus the median across origins.

### E1. Accuracy and calibration

Dependent sources (three agents share a lab):

| Regime | RMSE | 95% coverage | 95% coverage, small-sample *t* |
|---|---|---|---|
| independent (per agent) | 0.503 | 0.22 | — |
| lone agent, same total data | 0.502 | 0.09 | — |
| forced consensus | 0.275 | 0.16 | — |
| cooperative, no provenance | 0.275 | 0.77 | 0.87 |
| cooperative, with provenance | **0.246** | 0.86 | **0.96** |
| cooperative, provenance + robust | 0.268 | 0.91 | 0.98 |

With independent sources, forced consensus and cooperation reach the same accuracy (RMSE 0.207). But consensus covers the truth in only 21% of its "95%" intervals, against 95% for cooperation. If one method shares an error with every other one (shared error with sd 0.4), cooperation's accuracy falls to 0.473 and its coverage to 0.82, even with the small-sample correction.

### E2. A later drift in one cluster

From round 25, the three-agent lab's instrument drifts by +1.0. All regimes use the last 10 rounds.

| Regime | RMSE after the drift | 95% coverage (*t* for cooperative) |
|---|---|---|
| independent (per agent) | 0.872 | 0.24 |
| forced consensus | 0.568 | 0.07 |
| cooperative, with provenance | **0.354** | 0.97 |
| cooperative, provenance + robust | 0.358 | 0.98 |
| monoculture (all six agents one method), independent | 1.130 | 0.08 |
| monoculture, forced consensus | 1.123 | 0.03 |

The cooperative collective flags the drifted lab in 82% of runs, with false alarms in 0.1%. Without the drift, it raises no false alarm. A monoculture has no relative signal at all: the drift is invisible from inside it.

### E3. How many independent methods, under a fixed budget

Each method has a fixed cost F, and the remaining budget B buys observations. The error of the collective estimate is then

> MSE(k) = τ² + σ_b²/k + σ²/(B − kF)

for k methods with independent errors of size σ_b, sampling noise σ, and an error τ shared by all methods. Its minimum is at about

> k\* = B / (F + σ√F / σ_b).

The simulated check agrees with the formula to within about 1%.

| Case (B = 400) | k\* | RMSE at k\* | RMSE with one method |
|---|---|---|---|
| cheap methods (F = 5), large method error (σ_b = 0.5) | 42 | 0.106 | 0.503 |
| costly methods (F = 60), large method error | 5 | 0.245 | 0.503 |
| cheap methods, small method error (σ_b = 0.1) | 15 | 0.061 | 0.112 |
| cheap methods, error shared by all (τ = 0.4) | 42 | 0.414 | 0.642 |

**Localizing a single faulty method** by the median rule: with two methods, the fault is identified in 50% of cases, a coin flip; with three or more, in 100%.

### E4. Bridge construction

Two agents with different supports and different operation models try 60 operations each run. A shared record needs three consistent joint records. A bridge needs a shared record, commitment by both, and disjoint allowed outcomes. An exposure is **correct** if the exposed agent really is wrong about the actual world.

| Condition | Bridges per 100 operations | Exposures per 100 | Share of exposures correct |
|---|---|---|---|
| reproducible operations, committed agents, faithful records | 6.4 | 7.6 | 1.00 |
| irreproducible operations (half of all records are noise) | 0.3 | 0.4 | 1.00 |
| two in three operations outside the agents' models | 0.9 | 1.0 | 1.00 |
| theory-laden records (30% recorded as one's own model expects) | 1.3 | 1.4 | 1.00 |
| theory-laden records (60%) | 0.1 | 0.1 | 1.00 |
| random shared recording faults (50% of trials) | 1.4 | 1.6 | 0.995 |
| **systematic shared recording fault (20% of operations)** | **7.2** | **8.6** | **0.94** |

### E5. Responsiveness

The cooperative regime, with dependent sources, varying the share of agents that act on an exposed error:

| Agents that act on exposed errors | RMSE per agent | Spread between agents |
|---|---|---|
| all | 0.269 | 0.10 |
| half | 0.406 | 0.28 |
| none | 0.502 | 0.39 |

## 4. What the results say about each conjecture

### 1. Minimal cooperation: supported, with three conditions

Agents that disagree on almost everything, including what outcomes mean, can still expose each other's errors (E4; `bridge_needs_no_shared_interpretation`). When records are true, every exposure is a real error (`faithful_agent_accommodates`; 100% in E4).

It fails when:
- **an agent will not commit:** it can then never be exposed;
- **the agents cannot agree on what was recorded;**
- **two agents are asked to say who is wrong:** a contradiction between two never says which side is wrong. A third independent method does (E3), or further operations.

### 2. Bridge construction: possible, and fragile in specific ways

Under good conditions, about 6 in 100 operations tried became bridges (E4). The number collapses when:
- operations are irreproducible (0.3 in 100);
- operations fall outside the agents' models (0.9);
- records are theory-laden (0.1 at 60%).

**Two findings deserve attention.** First, theory-laden perception *blocks* bridges rather than corrupting them. When each agent records what its own model expects, the disagreement between their models itself prevents a false shared record. Second, the dangerous case is a **shared** fault: a single faulty channel feeding both agents the same wrong outcome every time. It passes the reproducibility check, produces *more* apparent bridges (7.2 instead of 6.4), and 6% of its exposures are false. The weakest point of a bridge is where the two sides depend on the same channel, not where they disagree.

**What the simulation does not test** is the hard part of real bridge-building: *inventing* operations both sides can perform and both models speak about. Here the operations are given, so their invention is assumed. So the simulation supports "sometimes", not "how often" or "how".

### 3. Collective improvement: yes, under five conditions, but not quite as the invitation framed it

**A correction to the invitation's slogan.** "Do not maximize agreement" is too strong as stated. In E1, forced consensus over methods with independent errors is as accurate as cooperation (0.207 against 0.207), and both are far better than independent agents (0.50). Averaging over independent methods is good for accuracy. Forced consensus fails elsewhere:
- **calibration:** its "95%" intervals cover the truth 16–21% of the time;
- **dependence:** it overweights the three agents that share a lab (0.275 against 0.246);
- **later errors:** it absorbs half of a later drift and cannot detect it (0.568 against 0.354).

What cooperation adds over consensus is not mainly accuracy. It is knowing how wrong the collective might be, counting origins rather than copies, and catching new errors.

**Information is controlled.** One method given as much data as the whole group is no better than an independent agent (0.502), and it is *more* overconfident (coverage 9%). More data from one method does not reduce that method's error.

The conditions the simulations identify:
1. **methods whose errors are at least partly independent;**
2. **a bridge:** a shared operation that makes relative errors visible;
3. **provenance:** without it, coverage under dependence drops from 0.96 to 0.87;
4. **responsiveness:** without it, the advantage disappears (E5);
5. **no error shared by every method.** Nothing inside the collective can find such an error, and it makes the collective overconfident (coverage 0.82).

### 4. Preserved diversity: supported in a refined form, and bounded

**The refinement.** What should be preserved is diversity of **methods and evidence channels**: independent origins of error and their raw records. Diversity of **conclusions** about the same question is a different thing. In the cooperative regime, the agents' corrected estimates converged (spread 0.10) while their methods stayed separate. The separate methods, not divergent conclusions, are what detected the later drift (82%, with 0.1% false alarms). The monoculture could not detect it at all.

**The challenges**, each of which limits the conjecture:
- **Diversity of conclusions beyond the evidence is just preserved error.** In E5, agents that did not act on exposed errors kept the most diversity (spread 0.39) and were the least accurate (0.50 against 0.27).
- **Diversity has a cost, so there is an optimum, not a maximum.** Under a fixed budget, the best number of independent methods is about B / (F + σ√F/σ_b). That is 42 when methods are cheap and their errors large, 15 when their errors are small, and 5 when each method is costly. Beyond that, more methods make the collective worse.
- **Localization needs at least three independent methods.** Two can show that something is wrong, but not what.
- **Internal diversity cannot find an error every method shares.** Only a new kind of method, or reality reaching in through a channel the collective does not yet have, can find it. So "preserving multiple independent ways of modelling" has to include staying open to ways the collective does not have yet: the representational extension of [WORLD_MODEL.md](../world-model/WORLD_MODEL.md).

**The conjecture, restated so it can be tested:** the best collective world model lets its conclusions converge as far as the evidence supports. It deliberately keeps a number of independent methods that is bounded by cost: at least three where faults must be localized, at most the budget optimum. It keeps their raw records and their provenance, and it stays open to new kinds of method that could reveal errors all current ones share.

## 5. What would falsify these results

- **Conjecture 1:** a pair of committed agents, with a true shared record of a discriminating operation, in which neither model is wrong about the actual world. The formal model says this cannot happen (`failure_is_support_or_mechanism`), so finding it would mean the model of agents is wrong.
- **Conjecture 2:** a population of agents with different evidential standards, given reproducible operations both can perform, that never builds a bridge. Or bridges that, once built, expose errors no more often than chance.
- **Conjecture 3:** collectives with independent methods, a bridge, provenance and responsive agents that are not better calibrated, or no faster at detecting new errors, than forced consensus on the same data. Forecasting tournaments and multi-agent experiments with AI systems could test this.
- **Conjecture 4:** a collective that keeps its methods diverse beyond the budget optimum and still does better. Or one that keeps fewer than three independent methods and still localizes faults reliably without further operations.

## 6. Limits of this work

- **The simulated world is simple:** one quantity, Gaussian errors, a bridge that is given rather than invented, and agents that follow a fixed rule. The numbers depend on the parameters, which are listed in the code and in [results.json](simulation/results/results.json).
- **The formal model has no noise, no costs, and no rule for which agent should revise.**
- **The coverage results use a small-sample correction** for the cooperative regimes, because their uncertainty is estimated from four to six origins; both columns are reported.
- **Written within one conversation and one model family** (working agreement 7). The invitation asks for independent intelligences; this is one.

## 7. How it connects

- **The anchor of the repository** (incompatible claims cannot both be true) is achievement 1 of the invitation. This note asks what has to be added to get from there to correction.
- **[WORLD_MODEL.md](../world-model/WORLD_MODEL.md)** gives the single-holder side and the two halves of a collective. This note tests the second half, how contributions are combined, by simulation.
- **`correcting_levels_form_interval`** and **`hub_determined_network_inherits_blind_spot`** in the core are the network-level versions of E2 and of the shared-error floor.
- **Step 6 of the [SCAP Seed](../../scap-seed/SEED.md):** "Common ground is not what we agree on. It is how we find out when one of us is wrong." Committed prediction plus a shared record is a precise, minimal form of that common ground, and conjecture 1 is close to a restatement of it for two agents.
