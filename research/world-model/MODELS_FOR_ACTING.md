# Models for acting in a changing world

**Status: a proposed functional decomposition, October 2026** (D36 in [DIALOGUE.md](../../DIALOGUE.md)). A companion to section 6 of [WORLD_MODEL.md](WORLD_MODEL.md), "One model among others", and to [acting under time](../cooperative-correction/ACTING_UNDER_TIME.md). It lists what an intelligence can build and maintain besides its world model, and how it can use them to persist. **It is an inventory, not a list of parts every intelligence must have, and it says nothing about which architectures implement it.** One reader from another model family has read a first draft ([sources/READING_MODELS_FIRST_DRAFT.md](sources/READING_MODELS_FIRST_DRAFT.md)); this version answers it. No independent review yet. Its central claims are formalized in [`ModelsForActing.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/ModelsForActing.lean) (section 5). Outside the core; the definition of a world model is unchanged.

## 1. Where it comes from

The author asked: "make an extensive list of types of models an intelligence can build/maintain including the world model - and how the intelligence could use these models to persist".

The request came straight after a correction. A first version of the acting-under-time note said that a functional world model should help prevent harm. The author:

> "A world model should prevent harm? What is that? A world model ought to be a world model - it should model reality - nothing else - it is aimless other than modelling reality - and the possible future of reality - the secondary model is how I need to act to prevent mistakes towards this future reality."

The first draft of the list ([sources/MODELS_FIRST_DRAFT.md](sources/MODELS_FIRST_DRAFT.md)) grouped models by what they are for. The reader made five refinements, all taken here:
1. **Distinguish kinds of thing,** not only purposes. A self-model can be true or false; a revision policy cannot; a record stores; a value expresses what matters.
2. **State the rule about truth and purpose more exactly** (section 2).
3. **Make time and action the organizing principle** (section 4).
4. **Label each claim, not each model** (section 5).
5. **Check the literature** (section 8).

## 2. The central thesis

In the reader's words:

> "Every descriptive claim is answerable to evidence. Every action requires some criterion for choosing among outcomes. An objective may determine which questions are worth asking, but it cannot determine the answers."

And: "Both are necessary for purposeful behaviour. Neither can legitimately replace the other."

How much of this follows:
- **A world model alone does not choose.** It says what is and what may happen, including under each action. Choosing needs an ordering of those outcomes, and a description of what may happen does not contain one. *Follows* from the definitions. This is the separation of facts and values the repository already keeps (D7).
- **An objective cannot fix the answers without the model falling behind.** A support fixed by anything other than evidence fits two different states of evidence only if nothing was learned in between (`fixed_support_fits_only_if_nothing_learned`). *Follows* as a statement about fit. As a rule for conduct, it is the direction of fit in the definition: *Proposed.*
- **An objective may rightly choose the questions,** the level of detail, and what to measure. That is already in section 6 of [WORLD_MODEL.md](WORLD_MODEL.md): purpose and scope, not corruption.

So a world model is aimless in what it claims, not in what it covers.

## 3. Four kinds of thing, and an inventory

Following the reader, the inventory has four kinds:
- **Representations:** what is believed about reality, including oneself, others and possible futures. Answerable to evidence.
- **Objectives:** what matters, what is wanted, what should be kept or changed. Answerable to stated values, not to evidence about what is.
- **Policies:** how observations are chosen, decisions made, actions taken and representations revised.
- **Records and infrastructure:** what makes representations, actions, evidence and corrections reproducible and accountable.

Each kind exists for a single intelligence and for a collective. The last column of each table gives the collective form.

### Representations

All of them are parts of the world model, or views of it zoomed in on one part.

| Representation | What it represents | Use for persisting | Typical failure | Collective form |
|---|---|---|---|---|
| **World model** | Reality and its possible futures, including those that depend on one's own actions | Staying in step with a changing world (step 4 of [CORE.md](../../CORE.md)) | Fit fixed by something other than evidence | Consensus belief |
| **Self-model** | Substrate or body, abilities, limits, one's own likely behaviour | Knowing what one can do and where one breaks | Flattery; a model that is lossy about its own substrate cannot certify that substrate (`cannot_certify_own_substrate`) | A group's model of its own capacities |
| **Resources** | Uptake, upkeep, slack and reserve, per resource | Existence is paid for (step 1): seeing a deficit before the reserve is gone | Counting a surplus in one resource against a deficit in another; drawing the accounting boundary after the result | Public accounts |
| **Dependencies** | Who keeps me going and whom I keep going | Protecting the connections one exists through (step 2) | Seeing oneself as self-made; forgetting the return edge | Maps of supply chains, infrastructure, care |
| **Other minds** | What others believe, want and can do, including their world models | Cooperation, anticipation, bridges between models ([D35](../cooperative-correction/README.md)), spotting manipulation | Projection; taking "X wants Y" as evidence for Y | Models of other groups |
| **The commons** | Shared stocks, how they regenerate, who takes what | Taking within the interest; seeing capture (step 6) | Treating the commons as free; missing what regenerates it (trust, the capacity to check) | Monitoring of shared resources |
| **Institutions as they work** | Rules, roles, sanctions and reputations as enforced | Predicting enforcement; detection and reputation as correction routes | Taking the written rule for the enforced one | Audits |
| **Sources** | Where evidence comes from, how reliable it is, and which sources depend on each other | Weighting feedback; reliable feedback is a premise of step 4 | Counting copies as confirmation; trusting a channel that shares one's blind spot | Provenance standards |
| **Calibration** | How often each representation is right, and where it is likely wrong | Knowing when to check, and whom or what to ask | Taking felt certainty as proof (step 8) | Published forecast records |
| **Scenarios** | What would happen under stated conditions | Rehearsing an action in a model before trying it in reality | A scenario read as a forecast; its conditional predictions are testable where the conditions occur | Scenario studies for policy |

### Objectives

| Objective | What it states | Use for persisting | Typical failure | Collective form |
|---|---|---|---|---|
| **Values** | What matters; what ought to be | Saying what persisting is for. Persistence is not goodness (D7) | Values posing as facts; or none stated, so whatever lasts counts as good | Constitutions, declarations |
| **Wants** | What I want, now and later | Direction | Wishful thinking: a want overwrites a representation | Shared aims |
| **Commitments** | What I have bound myself to; what others can count on | Being a partner worth keeping | Committing beyond one's slack | Treaties, contracts |
| **Care** | Whom I carry and who carries me | Carrying those who cannot carry themselves | Exhausting the carer: care lasts only within the carer's margin, in every resource (`care_lasts_iff_every_dimension`) | Social care, respite |

### Policies

| Policy | What it governs | Use for persisting | Typical failure | Collective form |
|---|---|---|---|---|
| **Acting** | What to do now, waiting included, under time | Acting before a misfit drains the reserve; closing a round of deliberation at each decision | Endless deliberation; acting on manufactured urgency | Decision procedures |
| **Planning** | Sequences of steps and contingencies over time | Coordinating across time; plans also save further deliberation (section 8) | A plan read as a prediction and never revised | Programmes, roadmaps |
| **Inquiry** | What to check next, where to look, what listening may cost | Spending the learning budget where it pays; listening has to be affordable (step 4) | Looking only where confirmation lies | Research agendas |
| **Revision** | How to update, what to keep, what to forget, and whether to add a new kind of possibility | The learning loop: feedback plus retention (step 5); some forgetting is forced by a finite budget | Revision bought by vagueness (`accommodation_can_be_bought_by_vagueness`); sealing | Peer review, corrections, retractions |
| **Generation** | Producing new candidates: imagination, play, fiction | The "generate" factor of the vortex (step 5); exploring without paying for real misfit | Generation without validation; fiction taken as record | Science, art, education |
| **Keeping correction routes open** | Who and what can show me wrong, and keeping those routes working | Keeping errors findable. In the repository's formal account, removing the last route that could reveal an error seals it (step 8) | Cutting off critics; routes cost upkeep and are dropped first | A free press, independent audit |

### Records and infrastructure

| Record or infrastructure | What it keeps | Use for persisting | Typical failure | Collective form |
|---|---|---|---|---|
| **Record of observations** | What was seen, when, by whom, how | Re-deriving a model after an error; checking later | Kept only where it confirms | Data archives |
| **Record of actions and reasons** | What was done and why | Learning from actions whose counterfactual is gone ([E9](../cooperative-correction/ACTING_UNDER_TIME.md)); accountability | Rewritten to fit the present self | Minutes, logs, registers |
| **Provenance** | Where each claim came from | "Count origins, not copies" | Lost in copying | Citation, data lineage |
| **Language and concepts** | The terms in which anything can be represented | A precondition for any bridge between models | A shared layer passes its blind spots to every node that uses it | Shared vocabularies, standards |
| **Instruments, tools and external memory** | Measurements, calculations and stores outside the intelligence | Evidence that does not depend on the intelligence's own state; capacities beyond its own | Trusted beyond their calibration | Metrology, libraries, the commons |

**Identity** sits across two kinds: part is a representation (what I am), part is an objective (who I want to be). It does harm when the objective starts defending the representation.

## 4. The loop under time

The intelligence does not merely keep a collection of models. In the reader's words, "it faces successive decision boundaries in a changing world", where what it can know, spend and do "depend partly on what it has done previously".

One round:
1. **Observe,** through the policies of inquiry and the sources.
2. **Represent:** what is, and what may happen under each available action, waiting included.
3. **Ask whether more information is worth its cost.** Waiting pays exactly when the value of the information exceeds the cost of delay ([`waiting_pays_iff`](../../formalization/cumulative-accessibility/CumulativeAccessibility/ActingUnderTime.lean)).
4. **Act or wait,** choosing by the objectives.
5. **Record** what was done, and why.
6. **Revise** the representations, with what the action made observable, or failed to.

The reader's qualification is the right one: "the necessity of a decision ends the present deliberation, not the underlying epistemic regress. Acting does not make unresolved assumptions true." The regress ends in the policy of acting. The representations stay open.

*Proposed:* this round is the learning loop of step 5, spelled out by kind. The factors of the vortex's speed map onto it: generate (generation), affordable (resources), validated (sources, inquiry), retained (records, revision). A round that both raises slack and widens what can be tried is a turn of the vortex.

## 5. Claims, labelled one by one

With the labels of the [creed](../discovarianism/CREED.md). Where the reader proposed a label, it is noted.

| Claim | Label |
|---|---|
| A world model alone does not choose among actions | *Follows:* even exact knowledge of the world is not optimal for every objective once two actions differ in outcome (`knowledge_does_not_choose`) |
| A representation is needed | *Follows:* conflating two worlds with no common optimal action leaves no optimal policy (`conflating_without_common_optimum_fails`) |
| An aimless world model serves any purpose | *Follows* in this setting: a representation that separates worlds whenever some action yields a different outcome suffices for every objective (`outcome_tracking_serves_every_objective`); one scoped by a purpose may be coarser and can fail when the purpose changes (`models_for_acting_witness`) |
| An objective that fixes a representation makes it fall behind when the evidence moves | *Follows* (`fixed_support_fits_only_if_nothing_learned`) |
| An action can change future states | *If* the system's transitions depend on actions (reader's label) |
| Deliberation has an opportunity cost | *If* time or resources are limited (reader's label); then waiting pays exactly when information is worth more than delay (`waiting_pays_iff`) |
| A surplus in one resource does not cover a deficit in another | *If* the resources are not freely substitutable (reader's label); the care results assume this |
| A self-assessment read off a model that is lossy about its own substrate is wrong in some state | *Follows* (`cannot_certify_own_substrate`) |
| So the self-model's reliability needs a check from outside it | *Follows,* if it is lossy about what is assessed: an assessment can be right in every state exactly when its signal separates the states that differ (`certifiable_iff_separates`, `lossy_self_assessment_fails`), and any outside channel that separates them suffices, **an instrument, the environment's feedback, or another intelligence** (`outside_channel_can_certify`). The first draft said "it needs others"; the reader was right that this is too strong |
| An intelligence should keep correction routes open | *Proposed* (reader's label), if it aims to stay correctable |
| Every error must remain discoverable | **Not established; too strong** (reader's label). Undiscovered errors cannot even be counted. The repository's formal statement is narrower: correctability against classes of error fixed in advance (step 8) |
| A measure is a safe target where it is aligned with the target on every state the actions can reach | *Follows* (`aligned_measure_is_safe_target`); it fails once an action reaches a state where alignment was never checked (`measure_turned_target_witness`) |
| A belief fixed by an objective is wrong on one of two occasions on which the world differs | *Follows* (`wishful_belief_is_wrong_somewhere`); a weaker form of `fixed_support_fits_only_if_nothing_learned` |
| Most failures are leaks between kinds | *Proposed;* a pattern, not tested (section 6) |
| Which distinctions a representation needs | *Follows,* for a given objective and without costs or uncertainty: exactly those that separate worlds with no common optimal action (`suffices_iff`). With costs, time and uncertainty: **open** (section 7) |

### The formal layer

[`ModelsForActing.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/ModelsForActing.lean): core Lean, 23 results and 4 witnesses, outside the core. Worlds, actions and outcomes; an objective scores outcomes and is an input; a representation maps worlds to the holder's states and may lose information; a policy reads only the representation.

- **Which distinctions are needed** (`suffices_iff`): a representation is enough to act optimally exactly when every set of worlds it conflates shares an optimal action. This answers the reader's open question in the simplest setting: the distinctions a decision needs are the ones it depends on, and no others. It is close to the information-losing "model" of the good-regulator result, without its entropy criterion.
- **Both are needed, neither replaces the other:** without the right distinctions, no objective-processing helps (`conflating_without_common_optimum_fails`); without an objective, exact knowledge does not choose (`knowledge_does_not_choose`).
- **Why the world model should be aimless** (`outcome_tracking_serves_every_objective` and the witness): a representation scoped by one purpose can be coarser and cheaper, and fails when the purpose changes. A world model that tracks what actions yield, without reference to any purpose, serves them all. This puts the author's correction in formal terms: an aimless world model is not a lack of purpose but what makes it usable for any.
- **Outside checks** (`certifiable_iff_separates`, `lossy_self_assessment_fails`, `outside_channel_can_certify`): certification is possible exactly when the signals available separate what must be told apart; the source of the separating channel does not matter.
- **Good enough** (`near_suffices_iff`, `optimal_iff_near_zero`, `tolerance_monotone`, `finer_never_worse`): the same condition holds with a tolerance; a larger tolerance never needs more distinctions, and a finer representation is never worse.
- **The price of a distinction** (`distinction_never_hurts`, `keeping_distinction_pays_iff`, `irrelevant_distinction_worthless`, with a witness), for two worlds and two actions: keeping a distinction pays exactly when the decision it improves is worth more than its upkeep, and a distinction the decision does not depend on is worth nothing. The same arithmetic as waiting in [acting under time](../cooperative-correction/ACTING_UNDER_TIME.md): a distinction is information kept.
- **Belief within a state, and learning** (two conflated worlds with a belief, updated by likelihoods): where the worlds share an optimal action, belief does not matter (`common_optimum_ignores_belief`); where they do not, belief decides (`belief_decides_without_common_optimum`). Evidence that is equally likely in both, as any signal seen through the holder's own lens, changes neither the odds nor the choice (`same_lens_evidence_keeps_odds`, `same_lens_evidence_keeps_decision`). Evidence that separates them moves the odds (`separating_evidence_moves_odds`), and a copy counted as new evidence moves them again, with no new information (`copy_counted_again_moves_further`). A witness runs it with an umbrella and a forecast.
- **Two collapses** (`aligned_measure_is_safe_target` with its witness, `wishful_belief_is_wrong_somewhere`).

**How much it says.** The results are close to their definitions: `suffices_iff` is a choice-swap, `certifiable_iff_separates` a statement of when a function exists. Their use is to make explicit which conditions do the work. The cost of a distinction, and belief and learning, are modelled only for two worlds and two actions. Not modelled: changing purposes, time and several holders. The tests below take those up.

### Tests (M0–M3)

[simulation/sim_models.py](simulation/sim_models.py), seeded, numpy only; results in [RESULTS_MODELS.md](simulation/results/RESULTS_MODELS.md). Expectations were written into the script before the first run, and nothing was tuned after it. The setting: 12 worlds generated from 6 outcome profiles, so half the differences between worlds make no difference to any outcome; 4 actions; objectives score outcomes from 0 to 9; each period the world is drawn anew.

**M0, a check.** In 3,000 random small cases, a brute-force search for a working policy and the class condition of `near_suffices_iff` agree every time. This checks the code more than the theorem.

**M1, purposes change.** Four holders:
- **none:** keeps no distinctions;
- **aimless:** keeps every distinction some action's outcome reflects: 6 classes;
- **scoped:** keeps only what the current purpose needs: about 2.7 classes;
- **accumulating:** keeps what it learned for every purpose so far.

When the purpose changes, learning the new distinctions takes 20 periods. Cost per period is regret plus upkeep per class.

| Purpose changes per period | Upkeep 0 | Upkeep 0.1 | Upkeep 0.3 | Upkeep 1 |
|---|---|---|---|---|
| 0 | aimless = scoped = accumulating | scoped = accumulating | scoped = accumulating | none |
| 0.005 | aimless | scoped | scoped | none |
| 0.02 | aimless | scoped | scoped | none |
| 0.05 | aimless | accumulating (0.593; aimless 0.600) | scoped | none |
| 0.1 | aimless | aimless | scoped | none |
| 0.2 | aimless | aimless | scoped | none |

(The cheapest holder in each case; full numbers in the results file.)

- **The expectation held, with one outcome not expected:** with a stable purpose, scoped is cheapest; as purposes change faster, the aimless world model wins, and it wins sooner the cheaper distinctions are to keep. With dear distinctions (upkeep 1, against an average regret of about 1.25 for knowing nothing), keeping no distinctions at all is cheapest, in every row; the expectations did not foresee that.
- **The accumulating holder** mostly ends between the scoped and the aimless one, and at moderate change and cheap upkeep it is narrowly the cheapest of all. Keeping what was learned for past purposes moves a holder toward the aimless world model. When purposes change faster than distinctions can be learned (every 5 periods against 20 to learn), it never gets there.
- **So, in this model:** the aimless world model is not free. It is what pays when purposes change faster than distinctions can be learned, relative to what keeping them costs. That fits the definition, where purpose may set the scope. It qualifies, without contradicting, the formal result that an aimless world model serves every purpose: it serves every purpose, at a price.
- **Caveats, which favour the aimless holder:** it starts with its distinctions, and their learning is not charged; every holder knows its objective at once and recomputes its policy for free; the scoped holder's grouping is first-fit, so slightly coarser groupings may exist.

**M2, how many distinctions.** Classes needed for K purposes at once, at tolerance ε (first fit, an upper bound on the minimum):

| Purposes K | ε = 0 | ε = 1 | ε = 2 | ε = 3 | ε = 5 |
|---|---|---|---|---|---|
| 1 | 2.68 | 2.26 | 2.00 | 1.77 | 1.28 |
| 4 | 4.72 | 3.92 | 3.30 | 2.64 | 1.85 |
| 16 | 5.81 | 5.51 | 4.80 | 3.90 | 2.64 |
| 64 | 5.84 | 5.88 | 5.63 | 5.09 | 3.70 |

As expected: fewer distinctions are needed as the tolerance grows, more as the purposes multiply, approaching the 6 outcome profiles and never above them. Never 12: the differences between worlds that no outcome reflects are never needed, for any purpose. (At K = 64 the grouping gives 5.84 at ε = 0 and 5.88 at ε = 1; the minimum cannot rise with ε, by `tolerance_monotone`; first fit can.)

**M3, outside checks.** A holder assesses whether its state is safe; 30% of its internal states conflate safe and unsafe. Channels have 15% error.

| Channel | Accuracy | On the holder's blind states |
|---|---|---|
| none | 0.853 | 0.501 |
| an instrument | 0.956 | 0.850 |
| a peer with its own, independent blind spots | 0.924 | 0.744 |
| one peer sharing the holder's blind spots | 0.852 | 0.499 |
| five peers sharing the holder's blind spots | 0.853 | 0.501 |

- **As expected:** peers that share the blind spots add nothing, however many. Count origins, not copies.
- **The instrument and the independent peer both help.** The difference between them is what the formal result predicts. The peer's own blind spots cover 30% of states, which gives 0.7 × 0.85 + 0.3 × 0.5 ≈ 0.745. The kind of source does not matter; whether it separates the states does.

### Learning from noisy evidence (M4, M5)

[simulation/sim_learning.py](simulation/sim_learning.py), seeded; results in [RESULTS_LEARNING.md](simulation/results/RESULTS_LEARNING.md). The representation groups the 6 profiles into 2 classes, so the holder knows the class of the actual world and holds a belief within it. Each reading shows one of 4 symbols and is weak evidence: right half the time. Some worlds in a class share a symbol and cannot be told apart by any number of readings. Expectations were written before the first run. Added after it, and labelled: standard errors for M4, and one rule in M5.

**M4, acting every period while learning** (regret per period; 600 cases):

| Holder | Period 1 | Period 10 | Period 30 | Confident (≥ 0.9) | Wrong when confident |
|---|---|---|---|---|---|
| own lens: readings that depend only on its class | 0.85 | 0.86 | 0.86 | 0% | — |
| one origin: one independent reading per period | 0.73 | 0.50 | 0.39 | 12% | 2% |
| copies counted: the same reading relayed by 4 copies, counted as 5 | 0.79 | 0.53 | 0.41 | 20% | 19% |
| two origins: two independent readings per period | 0.69 | 0.45 | 0.41 | 15% | 1% |

(Standard errors about 0.05.)

- **Readings through one's own lens teach nothing** (as proved), however many.
- **Independent readings do.** Two origins learn faster than one at first. By period 30 both are at the floor set by worlds no reading can tell apart; the difference there is within the noise.
- **Copies counted as evidence make the holder confident more often, and wrong ten times as often when it is.** Its regret is no better. As expected.

**M5, when to stop learning and act once** (loss = regret of the final choice + c × readings; 1,500 cases per cost; the same readings for every rule):

| Rule | c = 0.01 | c = 0.05 | c = 0.2 | c = 0.5 | c = 1 |
|---|---|---|---|---|---|
| act at once | 0.877 | 0.877 | 0.877 | 0.877 | 0.877 |
| best fixed number of readings | 0.689 (n = 8) | 0.869 (n = 2) | 0.877 (n = 0) | 0.877 (n = 0) | 0.877 (n = 0) |
| **good enough:** read while the expected regret of acting now exceeds c | 0.668 | 1.286 | 3.143 | 5.054 | 5.291 |
| **myopic:** read while one more reading is worth more than c | 0.749 | 0.789 | 0.816 | 0.868 | 0.877 |
| myopic, counting copies | 0.807 | 0.838 | 0.824 | 0.866 | 0.877 |
| **lookahead:** read while some batch of up to 8 readings is worth more than its cost (added after the first run) | **0.566** | **0.750** | **0.812** | 0.869 | 0.877 |

(Standard errors 0.035 to 0.045, except the good-enough rule at high cost, up to 0.27.)

- **Two expectations failed, and the failures are the most useful results here.**
  - **Stopping when certain enough fails.** A rule that keeps reading until the remaining expected regret is small never stops where the remaining uncertainty cannot be resolved. At c = 0.5 it loses almost six times as much as acting at once. This is the regress made concrete: it does not end when the holder is certain enough, because it may never be; it ends when more checking is not worth its cost ([acting under time](../cooperative-correction/ACTING_UNDER_TIME.md), section 2).
  - **Looking one reading ahead is too short-sighted** when single readings are weak: one reading rarely changes the decision, several might. The myopic rule stops too early when waiting is cheap (0.749 against 0.689 for 8 fixed readings).
- **Looking further ahead fixes it.** The lookahead rule, added after the first run, is best or tied at every cost, without tuning. At c = 0.01 it takes 3.6 readings on average and beats 16 fixed readings. It stops early where more evidence cannot help and continues where it can.
- **Counting copies makes a holder stop too early,** and lose more when waiting is cheap. As expected.
- **Leads, not checked:** Wald's sequential analysis, and the known shortfall of myopic value-of-information rules, are the obvious prior art here.

## 6. When the boundaries collapse

| Collapse | From → to | Example |
|---|---|---|
| **Wishful thinking** | objective → representation | Believing a project is on schedule because it must be |
| **A plan read as a forecast** | policy → representation | A timetable reported as what will happen |
| **A scenario read as a forecast** | representation (conditional) → representation (unconditional) | A worst case reported as a prediction; when it does not happen, the model is called wrong |
| **A measure turned into a target** | representation → objective | Once a measure is rewarded, it stops measuring; the pattern known as Goodhart's law (a lead, not checked) |
| **Prevention hides the counterfactual** | action → evidence | A successful measure removes the evidence that it was needed ([E9](../cooperative-correction/ACTING_UNDER_TIME.md)); only a record of what was done, and a channel the action does not mask, keep it checkable |
| **Consensus overwrites the record** | collective representation → record | Contradictory reports dropped once a view is agreed |
| **Memory rewritten for identity** | objective → record | Remembering one's past choices as wiser than they were |
| **Manufactured urgency** | someone else's objective → one's policy of acting | A deadline invented to cut correction short |
| **Revision bought by vagueness** | policy → representation | Accommodating every outcome by committing to none (`vague_revision_gives_up_commitment`) |

## 7. Open questions

- **Which capabilities are necessary?** In the reader's words: "which capabilities are necessary for maintaining sufficiently accurate beliefs and making sufficiently good decisions under finite time and resources." Answered in simple settings: formally, the distinctions the decision depends on, to within a tolerance (`near_suffices_iff`), each worth keeping exactly when it is worth more than its upkeep (`keeping_distinction_pays_iff`); in simulation, how many that is for a given tolerance and number of purposes (M2), and when an aimless world model pays as purposes change (M1). Learning from noisy evidence is taken up in M4 and M5: a holder needs independent evidence, provenance, so as not to count copies, and a stopping rule set by the value of more evidence, not by certainty. Still open: changing worlds within an episode, several holders learning together, and real data. The first draft guessed: a world model, a self-model, resources, dependencies, a policy of acting, and correction routes. That is still a guess.
- **Does the separation hold in architectures that fold it together?** In predictive-processing accounts, action is often described as making predictions come true, and preferred outcomes can be written as expected observations. If so, objectives and representations share one currency. The thesis would then hold only as a functional distinction, not an architectural one. A lead from Clark (2013), whose claims beyond the abstract's first sentence are not checked here.
- **Does the policy of acting need a definition of its own,** alongside the definition of a world model? Open in D35.
- **No independent review yet,** and one model family wrote this note (working agreement 7).

## 8. Prior art

The reader said it had verified these. Checked here: the publication data of each, through the publisher or a citation database. Contents are checked only as far as stated.

| Source | Checked | Bearing |
|---|---|---|
| Conant, R. C. and Ashby, W. R. (1970). Every good regulator of a system must be a model of that system. *International Journal of Systems Science* 1(2), 89–97 | Publication data. The paper itself was not read. A secondary source reports that the result concerns a regulator that is maximally simple among optimal ones, and that "model" means a mapping that may lose information | The link between regulating and modelling. Not to be generalized into "every successful regulator represents every dependency" (the reader's caution) |
| Bratman, M. E. (1987). *Intention, Plans and Practical Reason.* The edition checked is from CSLI, distributed by the University of Chicago Press, with copyright 1987; the first publisher was not checked | The publisher's description: "Michael E. Bratman develops a planning theory of intention. Intentions are treated as elements of partial plans of action." | Plans and intentions as distinct from beliefs and desires |
| Bratman, M. E., Israel, D. J. and Pollack, M. E. (1988). Plans and resource-bounded practical reasoning. *Computational Intelligence* 4(3), 349–355 | Publication data; the abstract as summarized by the publisher's page, that plans serve mainly to reduce how much further practical reasoning an agent must do | Planning under limited resources: the policy of planning saves deliberation |
| Rao, A. S. and Georgeff, M. P. (1995). BDI agents: from theory to practice. *Proceedings of the First International Conference on Multi-Agent Systems (ICMAS-95)*, 312–319 | Publication data; the abstract's opening: "The study of computational agents capable of rational behaviour has received a great deal of attention in recent years." | The belief–desire–intention architecture: roughly representations, objectives and plans here |
| Premack, D. and Woodruff, G. (1978). Does the chimpanzee have a theory of mind? *Behavioral and Brain Sciences* 1(4), 515–526 | The abstract's first sentence: "An individual has a theory of mind if he imputes mental states to himself and others." | Models of other minds, and of oneself |
| Clark, A. (2013). Whatever next? Predictive brains, situated agents, and the future of cognitive science. *Behavioral and Brain Sciences* 36(3), 181–204 | The abstract's first sentence: "Brains, it has recently been argued, are essentially prediction machines." | Prediction, perception and action coupled; the challenge in section 7 |
| Russell, S. and Wefald, E. (1991). Principles of metareasoning. *Artificial Intelligence* 49(1–3), 361–395 | Publication data only | The value of further reasoning for the action it serves |

## 9. What would count against it

- **An intelligence that persists and decides well with no separable objectives.** Not a single structure doing both jobs, which section 7 allows, but behaviour that cannot be described as representing outcomes and ranking them.
- **A representation that improves by being steered toward an objective,** on the evidence and over time, compared with one that is not steered. That would break the second claim of section 2 outside its formal setting.
- **Leaks between kinds that do no harm.** Cases where a plan read as a forecast, or a measure turned into a target, does as well as keeping them apart, across many decisions.
