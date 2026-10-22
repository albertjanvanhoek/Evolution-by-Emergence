# Cooperative error identification: can different world models correct each other?

**Status: four conjectures under investigation, third version, October 2026** (D35 in [DIALOGUE.md](../../DIALOGUE.md)). A smallest formal model and a set of simulations, written to find out where the conjectures fail. **Nothing here is established.** The first version was assessed by an independent reader ([review A](sources/REVIEW_A.md)), who found a decisive error in how it read its own simulations ([response](sources/RESPONSE_A.md)). The same reader then audited the second version ([review B](sources/REVIEW_B.md)), saying itself that this was not an independent review; this version answers it ([response](sources/RESPONSE_B.md)). A reader with no prior exposure has not yet assessed it; [briefs/REVIEW_BRIEF.md](briefs/REVIEW_BRIEF.md) is for that.

| Part | Where |
|---|---|
| The invitation that started it, verbatim | [sources/INVITATION.md](sources/INVITATION.md) |
| The formal model | [`CooperativeCorrection.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/CooperativeCorrection.lean): core Lean, 14 results and 2 witnesses |
| The simulations, version 2 | [simulation/sim.py](simulation/sim.py), seeded; results in [simulation/results/RESULTS.md](simulation/results/RESULTS.md) |
| Version 1, as reviewed | [simulation/sim_v1.py](simulation/sim_v1.py), [simulation/results_v1/](simulation/results_v1/RESULTS.md) |
| Reviews A and B, review A's blind start, and the responses | [sources/](sources/) |
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

### What review B changed

The audit found two further problems and drew the lesson that ties this note together.
- **A definition did not match its prose.** An "available bridge" did not require both agents to be committed, so an agent with an empty support could still form one. It now does (`available_bridge_has_nonempty_supports`).
- **The bridge works only if the reference is commutable.** The reference corrects a method only if the method errs on the reference as it does on its real target. Version 2 assumed this exactly. With a reference-specific error as large as the method error, correcting through the bridge makes comparisons *worse* than not correcting. Metrology has a name for the condition: **commutability** of reference materials. New experiment E7 measures how much the results depend on it.
- **"Who is wrong" was stated too broadly.** Before an operation, the logic does not say which agent will be exposed. After a true record, it does identify the failing model. What it does not identify is the failing component, or anything at all when the record itself is unreliable (`true_record_identifies_failing_model`).

**The lesson.** In the reviewer's words: "an apparently shared evidential bridge is itself a model-dependent object whose validity must be tested." A bridge assumes, for example, that a reference behaves like the real targets, and that assumption can be wrong in exactly the way any model can be. So the shared procedures by which intelligences find each other's errors must stay open to correction themselves. That is the repository's anchor applied once more: the bridge is a model too.

## 3. The smallest formal model

[`CooperativeCorrection.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/CooperativeCorrection.lean) models two agents over possible worlds. Each has:
- a **support**, the worlds it keeps possible;
- **its own model of the operations** that can be performed: what each operation yields in each world.

**What is shared, and what is not.** The two agents may differ in both their supports and their operation models; their models of an operation may disagree at every world. What they share is an **operational compatibility assumption**: the same types of worlds, operations and outcomes, and exact identification of which operation was performed. That is much less than a shared interpretation. But it is not nothing, and how two agents with different vocabularies would reach it is not modelled.

**Discovering a bridge among available operations.** An available bridge is a shared operation with two things:
- a **shared record:** both agents accept *which outcome occurred*;
- **commitment:** before the operation, each states which outcomes its model allows, a set that is neither empty nor everything.

And the allowed outcomes of the two agents must not overlap: the operation **discriminates** them. Requiring commitment from both excludes the degenerate case of an empty support (`available_bridge_has_nonempty_supports`). The model shows the consequences of having such an operation available. It does not show how a new operation, or a shared vocabulary for one, is built.

**Logical results:**
- **A discriminating operation exposes at least one agent,** whatever the outcome (`discrimination_exposes_one`).
- **Before the outcome, it does not say which** (`exposure_does_not_say_who`). **After a true record, it does:** an agent whose model does not allow the recorded outcome is in error (`true_record_identifies_failing_model`). What stays open is which component failed, and everything when the record itself may be wrong, for example two instruments that disagree with no third reference.
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

**One assumption carries all of E6:** each method errs on the reference exactly as it errs on its real target, and an instrument drift reaches both alike. E7 relaxes it.

### E7. Commutability: the bridge is only as good as the reference

Added after review B. First, each method gets an extra, persistent error on the reference only, while the method error on the real targets stays at sd 0.5:

| Reference-specific error (sd) | Comparisons, corrected through the bridge | Comparisons, own measurement only |
|---|---|---|
| 0 | 0.162 | 0.653 |
| 0.1 | 0.216 | 0.653 |
| 0.25 | 0.391 | 0.653 |
| 0.4 | 0.591 | 0.653 |
| 0.5 | 0.729 | 0.653 |
| 1.0 | 1.428 | 0.653 |

Second, only part of an instrument drift reaches the reference. The drift is then detected through the reference, at 0.5% false alarms, in 1.4% of runs when none of it reaches the reference, 13% at 25%, 55% at 50%, 90% at 75%, and 99% when all of it does.

So the bridge helps when the reference is close to commutable, and hurts when the reference's own error is as large as the method error it is meant to remove. The result reproduces review B's own sensitivity analysis. In metrology, commutability is assessed for exactly this reason: a NIST page for "Recommendations for assessing commutability part 1: general experimental design" (*Clinical Chemistry*, 2018) calls it "a property of a reference material that relates to the closeness of agreement between results" for the reference and for real samples across measurement procedures (the last part paraphrased).

E6 and E7 are about **calibrating measurement systems** that share a numerical scale and an additive error structure. They do not yet represent world models whose concepts or causal descriptions are incompatible.

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
| a **shared** recording bias (20% of operations) | 7.2 | 8.5 | 0.95 |
| a **shared** recording bias (50% of operations) | 8.0 | 9.8 | 0.89 |

When records are shaped by *different* theories, disagreement prevents a false shared record, so bridges become rarer but stay sound. When both agents record through a *shared* bias, here a stand-in for a shared theory rather than a model of one, the false record passes every reproducibility check: there are *more* apparent bridges, and up to 11% of exposures are wrong. Version 1 said that theory-laden perception blocks bridges rather than corrupting them. That holds only when the theories differ. The 100% correct in the baseline is a finite-sample result: records there can still be wrong, rarely.

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
| 1. Minimal cooperation | **Supported, narrowly** | Exposure follows from a shared record and incompatible commitments; after a true record the failing model is identified, but not its failing component, and nothing is corrected |
| 2. Bridge construction | **Partly supported** | Discovery of discriminating operations among available ones is shown; construction of a new interface is not |
| 3. Collective improvement | **Partly supported** | With a common target, gains come from pooling and provenance, not from the bridge; with distinct targets, the bridge adds a great deal, if the reference is commutable |
| 4. Preserved diversity | **Partly supported** | Independent methods make errors visible that a monoculture cannot see; the optimum number depends on assumptions, and diversity of conclusions has a role too |

### 1. Minimal cooperation

The logical result holds. Two agents can establish that an outcome is incompatible with at least one of their models without sharing the rest of their models. After a true record, they can also say *which* model failed. The result is narrower than its name suggests, though: it does not say which part of the failing model is wrong, it depends on the record being true, and it corrects nothing.

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
- shared faults, including a shared recording bias, which pass reproducibility checks and corrupt the bridge;
- a bridge that is itself wrong, such as a non-commutable reference (E7).

### 3. Collective improvement

**With a common target,** the gains over independent agents come from pooling independent methods (RMSE 0.50 to 0.21–0.25) and from **provenance**, counting origins rather than copies (0.275 to 0.246, coverage 0.86 to 0.95). The bridge adds nothing to the estimate, the calibration, the individual correction or the detection of a new drift.

**With distinct targets,** which is the situation of models that do not measure the same things, the bridge does what nothing else can:
- comparisons between targets become four times more accurate;
- instrument errors are told apart from real changes in the world.

So the improvement attributable to cooperative error identification, as distinct from good aggregation, appears where the agents' ordinary observations are not directly comparable, **and the bridge between them is commutable** (E7). Strictly, E6 and E7 show this for measurement systems on a common scale; whether it extends to world models whose concepts are incompatible is untested.

Version 1's slogan correction stands, now on firmer ground: "do not maximize agreement" is too strong. Agreement reached by provenance-aware pooling of independent methods is accurate and well calibrated. What fails is agreement that ignores dependence or overstates certainty.

Failure conditions:
- dependent sources treated as independent;
- an error shared by every method;
- agents that do not act on exposed errors;
- a non-commutable bridge, which can make the collective worse than no bridge;
- bridges that cost more to build and maintain than they return, which the simulations do not price.

### 4. Preserved diversity

**What holds:** independent methods make errors visible that a monoculture cannot see. With one method shared by six agents, a drift is undetectable from inside (E2).

**What had to be corrected:**
- **The optimum number of methods is conditional.** It holds under exchangeable independent errors, equal costs and squared error.
- **Localization is conditional.** At least three methods, a majority of sound ones, and faults large relative to the noise.
- **Diversity of conclusions has a role too.** Version 1 said to preserve diversity of methods, not of conclusions. Review A disagreed, and the assistant now agrees. Different beliefs lead agents to run different experiments, and if agreement makes everyone stop investigating a plausible alternative, convergence itself reduces the capacity to find future errors. Zollman's work on the *transient* diversity of beliefs points the same way: some diversity helps a community find the truth, and diversity kept forever can stop it from converging.

The useful line is therefore not between methods and conclusions. It is between **diversity that keeps informative inquiry going**, and **diversity that merely keeps known errors**. The latter is what E5 shows when agents ignore exposed errors.

And justified agreement does not make independent capacity expendable. Review B's point: even where the evidence has settled a question, a collective may need alternative methods to detect a later change in the world, or a shared assumption that later proves false.

A further failure condition: methods that look different but share an unrecognized calibration standard or background assumption give an *illusion* of independence. That is the shared-error floor of E1, and the shared-theory case of E4.

**The conjecture, restated:** a good collective world model lets its conclusions converge as far as the evidence supports, keeps open the alternatives the evidence still leaves open and that would lead to informative inquiry, and keeps enough genuinely independent methods to make errors visible. How many is a matter of cost, error correlation and what is at stake. It keeps provenance, and it stays open to new kinds of method, because no internal diversity can see an error every method shares.

## 6. Prior art

Reviews A and B checked the following and found that they substantially limit claims of originality. The assistant has checked only the commutability source in E7; the others are not quoted here.
- **Inter-laboratory comparison in metrology** (for example Guthrie, NIST, 2007): laboratories measuring common artifacts to find systematic differences. This is an existing, operational form of the reference bridge, not merely an analogy. Proficiency-testing data are the natural place to test E6.
- **Longino** (*Science as Social Knowledge*, 1990): objectivity as a property of social processes of criticism.
- **Galison:** trading zones, where coordination precedes shared theory. The closest prior work on conjecture 2.
- **Kuhn:** incommensurability, the strongest challenge to the operational compatibility assumption.
- **Zollman** (2007; *The Epistemic Benefit of Transient Diversity*, 2010): limited communication can raise collective reliability and slow convergence; permanent diversity can block convergence.
- **Hong and Page** (2004): conditions under which functionally diverse groups outperform able ones, not an unconditional advantage.
- **DeGroot** (*Reaching a Consensus*, 1974): formal opinion pooling; convergence is not correctness.
- **Commutability of reference materials** in laboratory metrology (IFCC and NIST work; see E7): when a reference allows valid comparison between methods, and when it adds error. The closest existing account of the condition E7 found.
- **Mayo,** on severe testing: a bridge is worth what its procedure would reliably reveal if an error were there, a stronger criterion than reproducibility or agreement.

The mechanisms are mostly established. What this work may add is an explicit synthesis: incompatible models, local interfaces, provenance, responsive correction and collective learning, in one checkable frame. The simulations do not establish that synthesis as a new general result.

## 7. What would falsify these results

Each test names a population, the conditions and the measure of success, as review B asked.

- **Conjecture 1.** *Population:* pairs of agents, human or AI, that commit in writing to allowed outcomes before an operation and then record its outcome together. *Would count against it:* cases with a true record in which the agent whose commitment excluded that outcome had no error, in its support or its model of the operation. `true_record_identifies_failing_model` says this cannot happen, so such a case would show the model of agents to be wrong.
- **Conjecture 2.** *Population:* groups with different evidential standards, such as two scientific communities or two AI systems trained on different data, given operations both can perform. *Measure:* the share of operations tried that become shared, reproducible and discriminating, and the share of resulting exposures later confirmed. *Would count against it:* no shared operations emerging where they are available, or exposures that are confirmed no more often than chance. A separate, harder test would concern construction: documented cases in which a new shared operation was built without either side adopting the other's theory.
- **Conjecture 3, as restated.** *Population:* inter-laboratory or multi-site measurement programmes with distinct targets and shared reference materials of known commutability (high, partial and none), as review B proposes. *Measure:* error of comparisons between sites, interval coverage, and detection of real instrument drift at a prespecified false-alarm rate, with blinded histories. *Would count against it:* references of high commutability that do not improve comparisons or drift detection beyond dependence-aware aggregation without a reference.
- **Conjecture 4, as restated.** *Population:* collectives facing a later change in the world or a shared assumption that proves false. *Measure:* delay until the error is detected, against the cost of keeping methods. *Would count against it:* a collective that drops independent methods, or stops exploring open alternatives, and still detects such errors as early and as reliably as one that keeps them, at the same cost.

## 8. Limits

- **The simulated world is simple:** Gaussian errors on a common scale, an additive error model, a reference that every agent can measure, and correction rules supplied by the model. World models with incompatible concepts are not simulated.
- **Costs are not priced,** neither for keeping methods nor for building bridges.
- **The formal model** has no noise, no costs, no history of commitments, and no criterion for an improving revision.
- **Written within one conversation and one model family,** and assessed so far by one independent reader, twice (working agreement 7).

## 9. How it connects

- **The anchor of the repository** (incompatible claims cannot both be true) is achievement 1 of the invitation; this note asks what has to be added to get from there to correction.
- **[WORLD_MODEL.md](../world-model/WORLD_MODEL.md):** this note tests the second half of a collective world model, how contributions are combined. Its findings agree with that note's correction: aggregation and provenance matter as much as contributor hygiene.
- **`correcting_levels_form_interval`** and **`hub_determined_network_inherits_blind_spot`** in the core are the network-level versions of the monoculture and shared-error results.
- **Step 6 of the [SCAP Seed](../../scap-seed/SEED.md):** "Common ground is not what we agree on. It is how we find out when one of us is wrong." Committed prediction plus a shared record is a minimal form of that common ground.
