# Cooperative error identification: can different world models correct each other?

**Status: four conjectures under investigation, second version, October 2026** (D35 in [DIALOGUE.md](../../DIALOGUE.md)). A smallest formal model and a set of simulations, written to find out where the conjectures fail. **Nothing here is established.** The first version was assessed by an independent reader ([review A](sources/REVIEW_A.md)), who found a decisive error in how it read its own simulations; this version answers it ([response](sources/RESPONSE_A.md)). Further independent readers are invited with [briefs/REVIEW_BRIEF.md](briefs/REVIEW_BRIEF.md).

| Part | Where |
|---|---|
| The invitation that started it, verbatim | [sources/INVITATION.md](sources/INVITATION.md) |
| The formal model | [`CooperativeCorrection.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/CooperativeCorrection.lean): core Lean, 12 results and 2 witnesses |
| The simulations, version 2 | [simulation/sim.py](simulation/sim.py), seeded; results in [simulation/results/RESULTS.md](simulation/results/RESULTS.md) |
| Version 1, as reviewed | [simulation/sim_v1.py](simulation/sim_v1.py), [simulation/results_v1/](simulation/results_v1/RESULTS.md) |
| Review A, its blind start, and the response | [sources/](sources/) |
| The brief for further readers | [briefs/REVIEW_BRIEF.md](briefs/REVIEW_BRIEF.md) |

## 1. The question

The author's invitation starts from one conjecture: "intelligences do not need to agree on what is true in order to cooperate in improving their understanding of reality. They need a shared capacity to identify and correct errors." After a first exchange, he split it into three, to be investigated separately:

1. **Minimal cooperation:** intelligences with incompatible world models can identify shared errors without adopting a common worldview.
2. **Bridge construction:** intelligences without an initially shared evidential standard can sometimes establish new local standards through interaction.
3. **Collective improvement:** under identifiable conditions, such cooperation produces better models of reality than the intelligences would develop independently.

And a fourth, to be challenged as hard as the others:

4. **Preserved diversity:** "Could the optimal collective world model be one that continually improves its relationship with reality while deliberately preserving multiple independent ways of modelling it?"

Two rules govern the work. "None of these should be assumed true merely because the preceding one holds." And: "Let's keep logical implications separate from behavioural assumptions."

## 2. What review A changed

The first version claimed that cooperation through a shared reference operation, the "bridge", improved the collective estimate (RMSE 0.246 against 0.275 for forced consensus). Review A showed that this was wrong. Each agent corrects its estimate by its relative reading on the reference, and when the corrected estimates are averaged, the corrections cancel exactly:

> mean of (mᵢ − gᵢ + ḡ) = mean of mᵢ.

The assistant checked this. The two estimates differ by at most 7 × 10⁻¹⁶, and replacing the reference readings with random numbers changes nothing. The gain came from **provenance**: weighting error origins instead of agents. The calibration advantage was also unfair: the consensus comparator stated only sampling noise, while the cooperative one estimated the spread of method errors and used a small-sample correction. A provenance-aware estimator without any bridge, with a matched interval, covers 95.2%.

The deeper reason is that in the first version every agent measured **the same quantity**. The ordinary measurements were then already a bridge, and a reference operation could add nothing. So version 2:
- separates four outcomes: the collective estimate, the correction of individual agents, calibration, and detection of new errors;
- gives each a matched comparator;
- adds the case the bridge exists for, where agents measure **different** quantities (E6).

## 3. The smallest formal model

[`CooperativeCorrection.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/CooperativeCorrection.lean) models two agents over possible worlds. Each has:
- a **support**, the worlds it keeps possible;
- **its own model of the operations** that can be performed: what each operation yields in each world.

**What is shared, and what is not.** The two agents may differ in both their supports and their operation models; their models of an operation may disagree at every world. What they share is an **operational compatibility assumption**: the same types of worlds, operations and outcomes, and exact identification of which operation was performed. That is much less than a shared interpretation. But it is not nothing, and how two agents with different vocabularies would reach it is not modelled.

**Discovering a bridge among available operations.** Two things are needed:
- a **shared record:** both agents accept *which outcome occurred*;
- **commitment:** before the operation, each states which outcomes its model allows, a set that is neither empty nor everything.

An operation whose allowed outcomes do not overlap **discriminates** the two agents. The model shows the consequences of having such an operation available. It does not show how a new operation, or a shared vocabulary for one, is built.

**Logical results:**
- **A discriminating operation exposes at least one agent,** whatever the outcome (`discrimination_exposes_one`).
- **It does not say which** (`exposure_does_not_say_who`).
- **An exposure locates an error in the support or in the operation model,** without saying which (`failure_is_support_or_mechanism`): the Duhem–Quine problem in miniature.
- **A faithful agent is never exposed by a true record** (`faithful_agent_accommodates`).
- **Commitment is needed at both ends.** An uncommitted agent is never exposed (`uncommitted_agent_is_never_exposed`). An agent with an empty support discriminates trivially from everyone, so it is excluded by requiring a nonempty allowed set (`empty_support_discriminates_trivially`, `empty_support_is_not_committed`).
- **For fixed models, bridges accumulate** as shared operations grow (`bridges_grow_with_shared_operations`). After a revision, earlier bridges need not remain.
- **The witnesses:** a bridge with no shared interpretation, and a disputed record that hides an exposure.

**Behavioural assumptions, kept separate:**
- `Responsive`: the agent *changes* after an exposure. The witness shows exposure without change.
- `Corrective`, stronger: the next model allows what was recorded. Even that is not improvement. Any agent can meet it by becoming vague and allowing everything (`accommodation_can_be_bought_by_vagueness`), and the vague model is no longer committed (`vague_revision_gives_up_commitment`). An improving revision needs a condition on what is kept as well as on what is accommodated; that is not formalized.

## 4. The simulations, version 2

[simulation/sim.py](simulation/sim.py) is seeded, and every regime in an experiment sees the same raw data.

**The setup:**
- **Six agents,** each with its own method, which carries a systematic error the agent does not know about, plus sampling noise.
- **Dependence is explicit:** in the dependent setting, three agents share most of their method error (one lab), and an error shared by *every* method can be switched on.
- **The reference sample:** from round 10, every agent can also measure a common reference sample of unknown value. Its readings reveal relative method errors, never absolute ones.

**Comparators,** each with the interval method that fits how it estimates its uncertainty:
- consensus stating only sampling noise (version 1's comparator);
- consensus with its uncertainty taken from the spread of the agents;
- provenance-aware aggregation without the bridge, with the mean or the median across origins;
- bridge-corrected agents, averaged;
- one method given the whole group's data, to control for the amount of information.

### E1. A common target: the bridge adds nothing

Dependent origins:

| Estimator | RMSE | 95% coverage |
|---|---|---|
| consensus, sampling-noise uncertainty | 0.275 | 0.16 |
| consensus, uncertainty from the agents' spread | 0.275 | 0.86 |
| **provenance, no bridge** | **0.246** | **0.95** |
| provenance + median, no bridge | 0.267 | 0.97 |
| bridge-corrected agents, averaged | 0.246 (identical) | 0.96 |
| one method, the whole group's data | 0.502 | 0.09 |

With independent origins, consensus with an honest interval and provenance coincide (0.207, coverage 0.95).

**Individual agents** start at an RMSE of 0.503 on their own. They reach 0.268 by correcting themselves through the bridge, and 0.246 by simply adopting the provenance estimate. With a common target, adopting the collective estimate is better than the bridge correction, because the bridge adds the reference's own noise.

**An error shared by all methods** (sd 0.4) defeats every estimator: RMSE about 0.47–0.49, with coverage between 0.09 and 0.87.

### E2. A common target with a later drift: detection is no better with the bridge

From round 25, the three-agent lab's instrument drifts by +1.0.
- **Collective estimate:** consensus is pulled to an RMSE of 0.568; provenance without a bridge holds at 0.354, with coverage 0.96.
- **Detection,** with both detectors' thresholds set so that each falsely flags 0.5% of origins when nothing changes:

| Detector | Drifted origin flagged | Other origins flagged |
|---|---|---|
| reference readings (the bridge) | 0.987 | 0.037 |
| ordinary measurements | 0.997 | 0.070 |

The ordinary measurements detect the drift as well as the reference, with somewhat more spill-over onto other origins. The spill-over comes from the drifted origin moving the median that every origin is compared with. A monoculture (one method, six agents) cannot detect the drift at all; its consensus RMSE is 1.12.

### E6. Distinct targets: where the bridge earns its place

Now each agent measures **its own quantity**: think of prevalence in six regions. Method errors can then not be told apart from real differences by comparing the ordinary measurements.

| Estimate | Error in each region's level (RMSE) | Error in comparisons between regions (RMSE) |
|---|---|---|
| own measurement only | 0.501 | 0.653 |
| corrected through the bridge | **0.268** | **0.162** |

The bridge removes relative method errors, so comparisons improve fourfold. The absolute level keeps the average method error, which only an anchor, such as a reference of known value, could remove.

**Detection, when real changes also happen.** From round 25, the lab's instrument drifts by +1.0, and one region's true quantity *really* changes by +1.0. Both detectors are again set to flag 0.5% of origins when nothing changes:

| Detector | Drift flagged | Real change flagged (wrongly) | Other origins flagged |
|---|---|---|---|
| reference readings (the bridge) | **0.991** | **0.045** | 0.050 |
| ordinary measurements | 0.771 | 0.378 | 0.454 |

The bridge tells an instrument drift apart from a real change in the world. The ordinary measurements cannot: they miss the drift a quarter of the time and treat a real change as an error four times in ten.

### E3. Diversity under a budget, and localization

**The budget.** Assume k methods with independent, exchangeable errors of size σ_b, an identical fixed cost F per method, sampling noise σ, an error τ shared by all, a budget B, and mean squared error as the loss. Then

> MSE(k) = τ² + σ_b²/k + σ²/(B − kF), minimized near k\* = B / (F + σ√F / σ_b).

The simulated check agrees to within about 1%. With B = 400: k\* is 42 for cheap methods with large errors, 15 when method errors are small, and 5 when each method costs 60. This optimum holds only under the stated assumptions; methods with different costs, correlated errors or another loss function give other answers.

**Localization** of faulty methods, by taking the methods farthest from the median, with noise of size 1:

| Methods | Faulty | Fault = 1 × noise | 2 × | 3 × | 5 × |
|---|---|---|---|---|---|
| 3 | 1 | 0.42 | 0.61 | 0.79 | 0.96 |
| 5 | 1 | 0.32 | 0.58 | 0.81 | 0.98 |
| 5 | 2 | 0.14 | 0.28 | 0.51 | 0.87 |
| 7 | 2 | 0.10 | 0.29 | 0.58 | 0.94 |

Two methods can never localize a fault, because a disagreement between two is symmetric. Three or more *can*, only if the sound methods form a majority and the fault is large compared with the noise. Version 1's "three methods localize a fault" came from a fault ten times the noise; it does not hold in general.

### E4. Bridge discovery among available operations

Two agents with different supports and operation models try 60 operations each run. A shared record needs three consistent joint records. A bridge also needs commitment by both and disjoint allowed outcomes. An exposure is **correct** if the exposed agent's model really is wrong about the actual world.

| Condition | Bridges per 100 operations | Exposures per 100 | Exposures correct |
|---|---|---|---|
| reproducible operations, committed agents, faithful records | 6.5 | 7.6 | 1.00 |
| irreproducible operations (half of all records noise) | 0.3 | 0.4 | 1.00 |
| two in three operations outside the agents' models | 0.9 | 1.0 | 1.00 |
| records shaped by each agent's **own** theory (30%) | 1.3 | 1.4 | 1.00 |
| records shaped by each agent's **own** theory (60%) | 0.1 | 0.1 | 1.00 |
| records shaped by a **shared** theory (20% of operations) | 7.2 | 8.5 | 0.95 |
| records shaped by a **shared** theory (50% of operations) | 8.0 | 9.8 | 0.89 |

When records are shaped by *different* theories, disagreement prevents a false shared record, so bridges become rarer but stay sound. When records are shaped by a *shared* theory, the false record passes every reproducibility check: there are *more* apparent bridges, and up to 11% of exposures are wrong. Version 1 said that theory-laden perception blocks bridges rather than corrupting them. That holds only when the theories differ.

### E5. Responsiveness

With the agents who act on exposed errors now chosen at random in each run, not from one lab:

| Agents that act | RMSE per agent | Spread between agents |
|---|---|---|
| all | 0.269 | 0.10 |
| half | 0.402 | 0.27 |
| none | 0.502 | 0.39 |

The correction rule is supplied by the model, not learned by the agents. And with a common target, adopting the provenance estimate does better still (E1).

## 5. What the results say about each conjecture

| Conjecture | Verdict now | Main reason |
|---|---|---|
| 1. Minimal cooperation | **Supported, narrowly** | Exposure follows from a shared record and incompatible commitments; it does not localize the error or produce a correction |
| 2. Bridge construction | **Partly supported** | Discovery of discriminating operations among available ones is shown; construction of a new interface is not |
| 3. Collective improvement | **Partly supported** | With a common target, gains come from pooling independent methods and provenance, not from the bridge; with distinct targets, the bridge adds a great deal |
| 4. Preserved diversity | **Partly supported** | Independent methods make errors visible that a monoculture cannot see; the optimum number depends on assumptions, and diversity of conclusions has a role too |

### 1. Minimal cooperation

The logical result holds. Two agents can establish that an outcome is incompatible with at least one of their models without sharing the rest of their models. The result is narrower than its name suggests, though: it is error *exposure*, not error localization and not correction.

It fails when:
- an agent will not commit;
- the agents disagree about what was recorded;
- the shared outcome symbols mean different things to the two agents. That last case is assumed away by the operational compatibility assumption.

A further failure condition, not modelled: commitments changed after the fact. Commitment is only meaningful with a verifiable history of what was committed when.

### 2. Bridge construction

What is shown is **bridge discovery among available operations**: given shared operations both models speak about, committed predictions and reproducible joint records expose incompatibilities. What is not shown is the hard part: **constructing** an operation, or a shared vocabulary, that makes previously incomparable models comparable. That remains conjectural.

In history, it has happened in practice: Galison's trading zones describe communities with different languages building local ways to collaborate. Its failure conditions here:
- irreproducible operations;
- operations outside the models;
- shared faults, including a shared theory, which pass reproducibility checks and corrupt the bridge.

### 3. Collective improvement

**With a common target,** the gains over independent agents come from pooling independent methods (RMSE 0.50 to 0.21–0.25) and from **provenance**, counting origins rather than copies (0.275 to 0.246, coverage 0.86 to 0.95). The bridge adds nothing to the estimate, the calibration, the individual correction or the detection of a new drift.

**With distinct targets,** which is the situation of models that do not measure the same things, the bridge does what nothing else can:
- comparisons between targets become four times more accurate;
- instrument errors are told apart from real changes in the world.

So the improvement attributable to cooperative error identification, as distinct from good aggregation, appears exactly where the agents' ordinary observations are not directly comparable. The invitation's original situation is one of those.

Version 1's slogan correction stands, now on firmer ground: "do not maximize agreement" is too strong. Agreement reached by provenance-aware pooling of independent methods is accurate and well calibrated. What fails is agreement that ignores dependence or overstates certainty.

Failure conditions:
- dependent sources treated as independent;
- an error shared by every method;
- agents that do not act on exposed errors;
- bridges that cost more to build and maintain than they return, which the simulations do not price.

### 4. Preserved diversity

**What holds:** independent methods make errors visible that a monoculture cannot see. With one method shared by six agents, a drift is undetectable from inside (E2).

**What had to be corrected:**
- **The optimum number of methods is conditional.** It holds under exchangeable independent errors, equal costs and squared error.
- **Localization is conditional.** At least three methods, a majority of sound ones, and faults large relative to the noise.
- **Diversity of conclusions has a role too.** Version 1 said to preserve diversity of methods, not of conclusions. Review A disagreed, and the assistant now agrees. Different beliefs lead agents to run different experiments, and if agreement makes everyone stop investigating a plausible alternative, convergence itself reduces the capacity to find future errors. Zollman's work on the *transient* diversity of beliefs points the same way: some diversity helps a community find the truth, and diversity kept forever can stop it from converging.

The useful line is therefore not between methods and conclusions. It is between **diversity that keeps informative inquiry going**, and **diversity that merely keeps known errors**. The latter is what E5 shows when agents ignore exposed errors.

A further failure condition: methods that look different but share an unrecognized calibration standard or background assumption give an *illusion* of independence. That is the shared-error floor of E1, and the shared-theory case of E4.

**The conjecture, restated:** a good collective world model lets its conclusions converge as far as the evidence supports, keeps open the alternatives the evidence still leaves open and that would lead to informative inquiry, and keeps enough genuinely independent methods to make errors visible. How many is a matter of cost, error correlation and what is at stake. It keeps provenance, and it stays open to new kinds of method, because no internal diversity can see an error every method shares.

## 6. Prior art

Review A checked the following and found that they substantially limit claims of originality; the assistant has not yet checked them in their sources, so none is quoted here.
- **Inter-laboratory comparison in metrology** (for example Guthrie, NIST, 2007): laboratories measuring common artifacts to find systematic differences. This is an existing, operational form of the reference bridge, not merely an analogy. Proficiency-testing data are the natural place to test E6.
- **Longino** (*Science as Social Knowledge*, 1990): objectivity as a property of social processes of criticism.
- **Galison:** trading zones, where coordination precedes shared theory. The closest prior work on conjecture 2.
- **Kuhn:** incommensurability, the strongest challenge to the operational compatibility assumption.
- **Zollman** (2007; *The Epistemic Benefit of Transient Diversity*, 2010): limited communication can raise collective reliability and slow convergence; permanent diversity can block convergence.
- **Hong and Page** (2004): conditions under which functionally diverse groups outperform able ones, not an unconditional advantage.
- **DeGroot** (*Reaching a Consensus*, 1974): formal opinion pooling; convergence is not correctness.
- **Mayo,** on severe testing: a bridge is worth what its procedure could have revealed, not only whether the parties agree on its result.

The mechanisms are mostly established. What this work may add is an explicit synthesis: incompatible models, local interfaces, provenance, responsive correction and collective learning, in one checkable frame. The simulations do not establish that synthesis as a new general result.

## 7. What would falsify these results

- **Conjecture 1:** a pair of committed agents, with a true shared record of a discriminating operation, in which neither model is wrong about the actual world. `failure_is_support_or_mechanism` says this cannot happen; finding it would mean the model of agents is wrong.
- **Conjecture 2:** agents that share reproducible operations both their models speak about and still never discover a discriminating one; or a documented case in which two communities built a new shared operation, without either adopting the other's theory, that this account cannot describe.
- **Conjecture 3, as restated:** with distinct targets, real inter-laboratory or multi-site data in which a common reference does *not* improve comparisons, or does not separate instrument drift from real change, beyond what dependence-aware aggregation already achieves. That is the test review A recommends, on proficiency-testing data, with blinded histories and a prespecified false-alarm rate.
- **Conjecture 4, as restated:** a collective that stops keeping independent methods, or stops exploring open alternatives, and still detects new errors as well as one that keeps them.

## 8. Limits

- **The simulated world is simple:** Gaussian errors, a reference that every agent can measure, and correction rules supplied by the model.
- **Costs are not priced,** neither for keeping methods nor for building bridges.
- **The formal model** has no noise, no costs, no history of commitments, and no criterion for an improving revision.
- **Written within one conversation and one model family,** and assessed so far by one independent reader (working agreement 7).

## 9. How it connects

- **The anchor of the repository** (incompatible claims cannot both be true) is achievement 1 of the invitation; this note asks what has to be added to get from there to correction.
- **[WORLD_MODEL.md](../world-model/WORLD_MODEL.md):** this note tests the second half of a collective world model, how contributions are combined. Its findings agree with that note's correction: aggregation and provenance matter as much as contributor hygiene.
- **`correcting_levels_form_interval`** and **`hub_determined_network_inherits_blind_spot`** in the core are the network-level versions of the monoculture and shared-error results.
- **Step 6 of the [SCAP Seed](../../scap-seed/SEED.md):** "Common ground is not what we agree on. It is how we find out when one of us is wrong." Committed prediction plus a shared record is a minimal form of that common ground.
