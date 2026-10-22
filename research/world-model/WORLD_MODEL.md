# World models, and what makes one functional

**Status: a definition note, third version, October 2026** (D34 in [DIALOGUE.md](../../DIALOGUE.md)). Three independent reviews shaped it. Review 1 found the first version not ready to open the core ([review](sources/REVIEW_1.md), [response](sources/RESPONSE_1.md)). Review 2, by a lighter reader, found the second version ready with changes ([review](sources/REVIEW_2.md), [response](sources/RESPONSE_2.md)). Review 3 found the version with those changes ready with five further changes, which this version makes ([review](sources/REVIEW_3.md), [response](sources/RESPONSE_3.md)). The formal layer is [`WorldModel.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/WorldModel.lean): 30 machine-checked results and a witness, for one narrow part of what this note says. Practices and a checklist are to be distilled from this note; they are not here yet.

> **In one paragraph.** Every intelligence acts through world models: representations that let it infer what it does not observe, what may happen, and what would happen if it acted. Having one is ordinary. Having a **functional** one is not. A functional world model is held with the aim of fitting how things are, tested against evidence it cannot fix in advance, as sharp as that evidence supports and no sharper, and correctable: both its beliefs and its range of possibilities can be revised. It does not arise by itself. It has to be built and maintained, by a person, a team, a society or an AI system, and in a collective it depends both on what each contributor passes on and on how the contributions are combined. Its value is that many mistakes can be found in the model, at low cost, before they are made in the world.

## 1. Two terms

The first version of this note used one word for several things. This version keeps them apart.

| Term | What it means | Example |
|---|---|---|
| **World model** | A representation of aspects of the world that supports inference about what is not observed, what may happen, and what would happen under different actions. It may be incomplete or wrong. | A child's expectations about falling objects; a weather model; a learned simulator inside an AI system. |
| **World modelling** | The practice of building, testing and revising world models. | Recording predictions before outcomes; checking them; changing the model when they fail. |
| **Functional world model** | A world model that meets the requirements of section 3 for a stated scope and use. This is the concept this note is about. | A forecast service that is calibrated, publishes its errors and revises its methods. |
| **Evidential fit** | A narrow formal ideal: the possibilities a model keeps open are exactly those its evidence leaves open. | The `EvidentialFit` of `WorldModel.lean`. |

"World model" is used here in its ordinary, descriptive sense, which is also how it is used in machine learning: Ha and Schmidhuber (2018) call a learned generative model of an environment a world model, and train an agent inside it. A wrong world model is still a world model. What this note adds is the second word: **functional**. In the author's words, the question is "the ingredients required for a functional and sharp worldmodel".

## 2. Why a functional world model does not arise by itself

In the author's words: "a worldmodel doesn't happen automatically - you have to work on it and create it. There are rules to obey to let a model be a worldmodel." With the two terms apart, the claim is sharper: every holder has world models; a *functional* one takes work.

Three facts make it so.

- **World models are fallible.** Views that exclude each other cannot both be right. So certainty is a state of the holder, not of the world ([CORE.md](../../CORE.md), the view from inside). No holder reaches the world except through evidence.
- **A model's content need not show that it has drifted.** For holders that experience anything, a model is usually experienced as how things are, not as a model. More generally, nothing in what a model says need signal that the world has moved away from it. Drift is found by testing, not by inspection.
- **Holders run other models too.** Plans, wishes, norms, a self-image and a sense of belonging all shape what a holder attends to and believes. That is not wrong in itself (section 6). But it means a world model can bend toward what is wanted without any signal that it has.

So a functional world model is an achievement, not a default. That makes the definition carry a responsibility. In the author's words: "The definition creates a responsibility." The definition makes the responsibility visible: once it is clear what keeps a world model functional, neglecting one's own, or passing on more certainty than one has, is no longer an accident but a choice. Taking the responsibility on is a value, not a deduction (D7, D25). It scales with capacity: those who can do more for a shared world model carry more.

## 3. The definition

> A **functional world model** is a world model, for a stated scope and use, held with the aim of fitting how things are, regardless of what its holder wants, and tested against evidence whose outcomes are not fixed by the claims being tested.
>
> It is **sharp** to the extent that it commits to definite predictions, **calibrated** to the extent that its stated confidence matches how often it is right, where that can meaningfully be assessed, and it aims to be **as sharp as the evidence supports, subject to calibration**.
>
> It is **correctable**: its beliefs, its background assumptions and its range of possibilities can all be revised, by the holder or by the system that maintains it, and it handles inconsistency by revising rather than by concluding everything.

Each part does work.

- **"Held with the aim of fitting how things are."** This is its direction of fit. Elizabeth Anscombe's *Intention* (1957) gives the classic example: a shopper's list and a detective's list of the same basket can be identical, but when list and basket differ, the shopper changes the basket and the detective changes the list. A functional world model plays the detective's role. A plan or a wish plays the shopper's. The distinction is about roles, not about separate compartments in the mind.
- **"Evidence whose outcomes are not fixed by the claims being tested."** The first version said "evidence from outside". That was the wrong boundary. An experiment a holder designs itself can be good evidence, because its outcome is not fixed by the claim. A rumour that arrives from outside can be no evidence, if it merely repeats what is already believed. What makes evidence count is that it could have come out otherwise.
- **"Tested".** Answerability has to be a practice, not a mood. Its usual forms: predictions recorded before outcomes, measurements others can check, estimates of measurement error, stated triggers for revision, evaluation on cases not used to build the model, and a way to reconsider background assumptions. None of these guarantees truth. A model can pass every test available and still be systematically wrong, for example when all its measurements share an undetected offset. More testing helps only where it can reveal the particular error.
- **"For a stated scope and use."** Functionality is relative to what the model is used for. A forecasting system can be well tested on the questions it was built for and still be unreliable when people use it to judge interventions it was never tested on. So a model is functional *for* a scope and use, and using it outside that scope is a new claim that needs its own testing (section 7).
- **"Where that can meaningfully be assessed."** Calibration is judged over a relevant population, period and use, not by any matching overall frequency: a forecaster can be right on average and badly wrong for an important subgroup. And some valuable models answer questions that come up only once, such as a reconstruction of a historical event, where there is no track record to calibrate against. For those, stated uncertainty has to be justified in other ways, and the requirement of calibration does not apply.
- **"As sharp as the evidence supports, subject to calibration."** Section 4.
- **"By the holder or by the system that maintains it."** Correctability can sit outside the representation itself. A fixed model inside an organization that checks it and replaces it when it fails is correctable as part of that system. What matters is where the capacity to correct actually resides.
- **"Correctable."** Section 5.

**What the definition does not require.** It does not require formal statistics or written records. A tradition of practice can be calibrated by its track record and corrected by experience: traditional navigation, for example, is tested every voyage and revised when it fails, without probability theory. What the definition requires is that testing and revision happen, not that they are formalized. Conversely, a hard-coded planning script that represents its environment but cannot be revised by anyone is a world model that is not functional: it fails the clause on correctability. (A plain thermostat is a weaker example: it is a feedback controller and may not represent anything, so it may not be a world model at all.)

Not every part of a functional world model can be tested on its own. Definitions and mathematical consequences cannot be shown wrong by observation. What has to be testable is the model's empirical predictions, and what has to be revisable is its empirical assumptions.

## 4. Sharp, subject to calibration

The central rule of the first version was "as sharp as the evidence allows, and no sharper". The rule has a close predecessor in statistics, and its best statement is there. Gneiting, Balabdaoui and Raftery (2007) evaluate probabilistic forecasts by "the paradigm of maximizing the sharpness of the predictive distributions subject to calibration". A forecast is sharp when it is concentrated; it is calibrated when what it says happens with probability 0.7 happens about 70% of the time. Sharpness without calibration is overconfidence. Calibration without sharpness is safe and uninformative. This note adopts their formulation and does not claim it.

**A set-level analogue, not a special case.** `WorldModel.lean` treats something narrower: which possibilities a model keeps open at all, its *support*, without saying how probability is spread over them. There the analogue of the rule is evidential fit: the support equals what the background and the evidence leave possible (`fit_iff_matches_evidence`). This is a set-theoretic analogue of evidence-relative sharpness. It is not a case of calibration and does not establish it: it involves no probability distribution and no comparison with observed frequencies, and a support can fit its evidence exactly while the process that produced the evidence is biased. Fit has two parts:
- **covering:** the model rules out nothing the evidence has not ruled out;
- **within:** the model rules out everything the evidence has ruled out.

**Fit is not calibration.** Two models can keep exactly the same possibilities open and give them very different weights. Review 1 gives an example: a coin is believed to land heads with probability 0.2 or 0.8; after eight heads and two tails both remain possible, so the support has not changed at all, yet the odds have moved 4096 to 1 toward 0.8. Most learning is of this kind, and the support-level results say nothing about it. Degrees of belief are in [`GradedBelief`](../../formalization/cumulative-accessibility/CumulativeAccessibility/GradedBelief.lean), whose `zero_credence_is_sealed` is the familiar rule that a credence of zero on a still-possible outcome cannot be raised by conditioning. That rule is about discrete possibilities and a particular update operation; over a continuum, single points have probability zero without being ruled out (as `CORE.md` already notes).

**A warning that holds for the whole formal layer.** Every result in `WorldModel.lean` is about which possibilities are kept at all, a yes or no for each world. None of them transfers to degrees of belief by itself. Carrying a result over to graded credences needs a probability measure and a separate argument, as `GradedBelief` gives for its own results. Where this note uses a set-level result, it says no more than that.

**Failures are more varied than "vague" and "sealed".** The first version offered two failures. There are more, and they lie on two different axes:
- **fit:** a model can keep too much open (partly vague), too little (over-sharp), or both at once, wrongly excluding one possibility while wrongly keeping another;
- **reliability:** whether the actual world is among the possibilities kept open. A model can be over-sharp and still keep the actual world, by luck; another can fit its evidence exactly and lose the actual world, because the evidence or the background was wrong.

The danger the first version described, being confidently wrong with no way back, needs both: the actual world excluded, and an update rule that cannot restore it (section 5).

**Fit alone is not enough.** If the evidence is inconsistent, nothing is left possible, and a model that fits it rules out everything. Such a model entails every claim, true or false (`empty_fit_entails_everything`). An empty set of possibilities is not a result to act on but a signal: either the background assumptions or some piece of evidence is wrong about the actual world (`inconsistency_flags_background_or_evidence`). A functional world model treats it as a reason to revise.

**Sharpness is not compression.** Ruling out possibilities is not the same as describing them briefly: a precise claim can be long to state, and a vague one short. The author's hypothesis that the two are linked is kept as an open hypothesis in section 15, not as part of the definition.

## 5. Correctable

The first version said that a model which rules out a possibility can never recover it. That was a property of one update rule, not of learning.

**Update, re-derivation and revision.**
- **Monotone update** narrows a model's own conclusions with each new piece of evidence. Under it, whatever was once excluded stays excluded (`monotone_update_cannot_recover`), including the actual world (`monotone_update_never_recovers_actual`).
- **Re-derivation** recomputes what is possible from the background and the evidence that was kept. It restores what monotone update lost, provided the background admits the actual world and the kept evidence is true of it (`rederiving_recovers_what_following_cannot`). Those are strong premises.
- **Re-derivation is not revision.** Recomputing from the same background and the same evidence gives the same answer. If a piece of evidence is false, re-derivation keeps the actual world out (`rederiving_with_false_evidence_does_not_recover`).
- **Revision** changes what is accepted. Retracting a false piece of evidence and recomputing brings the actual world back (`retracting_false_evidence_recovers`); so does revising a background assumption that wrongly excluded it (`revising_background_recovers`).

**What makes re-derivation possible is keeping what conclusions rest on.** A holder that keeps only its conclusions can only narrow them. A holder that also keeps the evidence and the assumptions they rest on can go back and recompute when one of them turns out wrong; that is what the formal results need, and they assume it rather than show it. Provenance in the fuller sense of line 9 of the [creed](../discovarianism/CREED.md), "Ask where it was learned" (where, when, why and from whom), adds something else: it tells the holder *which* piece to retract, so that revision can be targeted instead of wholesale. A holder with a full archive of its data and assumptions but no record of what supports what can still re-derive, at greater cost. So kept evidence makes correction possible, and provenance makes it practical.

**Three operations, not one.** Correction can mean:
- **narrowing:** ruling out what the evidence rules out;
- **revision:** restoring a possibility that was wrongly ruled out, by retracting a piece of evidence or a background assumption. Belief-revision theory, starting with Alchourrón, Gärdenfors and Makinson (1985), studies this together with contraction;
- **representational extension:** adding a possibility the model could not even represent before. This is not what belief-revision theory calls *expansion*: there, expansion means adding a belief, which in terms of possible worlds narrows the support.

In belief-revision terms, narrowing corresponds to expansion; retracting a piece of evidence or an assumption corresponds to contraction; and replacing it with another corresponds to what that theory calls revision. The formal layer covers narrowing and the two forms of revision shown above. Representational extension is the deepest kind of learning and is not modelled.

**Openness is about the future, not only the present.** Keeping every live possibility open today (`Covers`) is not the same as being correctable. A frozen holder can cover its evidence today; a revisable one can be wrong today. Correctability is whether a corrected state can be reached, by the update operations the holder actually has, given evidence that can actually reach it.

**A changing world.** The formal layer reads a possible world as a whole course of events. Learning about a changing world is then narrowing down what that course has been and will be. Treating each past observation as a timeless constraint on the present state would be a mistake; reading worlds as histories avoids it. But this reading has a limit. It treats learning as narrowing hypotheses about one course of events. It does not model a holder acting within an open future, where its own actions change what can happen, nor the generation of possibilities nobody had considered. The formal layer covers retrospective narrowing, re-derivation and revision; acting and inventing are outside it.

## 6. One model among others

In the author's words: a world model is "one particular kind of model. A very useful one. One model you should have besides other models."

A holder also runs models of what it wants, of what ought to be, of itself, of the group it belongs to, and stories and play. These are not errors. Plans change the world; values say what the world model is for; play explores possibilities. Section 5 of [Building the future](../building-the-future/BUILDING_THE_FUTURE.md) is about this: we predict the future in order to change it.

The first version said the other models "may consult it; none may overwrite it". That was too strict. Values rightly shape a world model: which questions to ask, which errors matter most, what to measure, at what level of detail, and how much to spend on it. A flood model for evacuation needs different detail from one for ecological monitoring. That is purpose and scope, not corruption. And a self-model contains factual claims, about one's abilities, body and likely behaviour, that belong in the world model. "This person wants X" is a fact to be modelled, distinct from endorsing X.

**The rule, revised:** wishes, values and loyalties may guide what is asked and what is done, but must not count, by themselves, as evidence for what is the case; and where they shape the model, their influence should be visible.

The repository practises this. Every claim in the creed is labelled *Follows*, *If* or *Proposed*, which makes visible where a value enters. And it keeps "persistence is not goodness" (D7).

Formally: a support fixed by something other than evidence fits two different states of evidence only if nothing was learned in between (`fixed_support_fits_only_if_nothing_learned`). The theorem does not know why the support is fixed. It says only that a fixed support falls behind as soon as the evidence moves.

## 7. Why a functional world model is valuable

The core point: **many mistakes can be found in the model before they are made in the world.** A plan can fail on paper, in a simulation or in a small controlled trial, at low cost, instead of in full deployment, at the cost of a reserve. Karl Popper put the elimination of false conjectures by criticism and testing at the centre of science. A laboratory experiment still happens in the world; what changes is the scale and the control, not the reality.

This needs a bridge that the formal layer does not supply: a link between what the model predicts an action will do and what it actually does. A model that only predicts what happens if nothing changes need not tell what happens under a new policy. And a simulation exposes only failures its assumptions can represent; it can make an unsafe action look safe. So the value is real, and conditional on the model being tested where it is used.

With that qualification:
1. **Staying in step with a changing world.** A configuration whose fit is fixed in advance runs out of reserve in some possible future; one that follows reliable feedback stays in step (step 4 of [CORE.md](../../CORE.md); `learner_in_step`). A functional world model does part of this ahead of time. What a covering model entails holds of the actual world when the actual world is live (`covering_entailment_is_sound`).
2. **Cheaper learning.** A retained world model lets a new lesson fit into what is known, instead of starting from nothing (step 5).
3. **Seeing dependencies.** To keep up what one depends on, it helps to see it, including slow and distant dependencies, and costs passed on unseen (D27). Not every dependency needs to be represented: a fixed process can maintain a resource without modelling it, as long as conditions stay suitable. Where they may change, a model is how a holder finds out.
4. **More options that can be trusted.** A narrower support that still keeps the actual world entails at least as much (`narrower_entails_more`), so more actions can be checked against it. That is an interpretation, not a theorem about freedom: the formal layer has no actions. And holders often act under risk without knowing an option is safe.
5. **Autonomy.** A holder that cannot check what it is told is steered by whoever tells it ([world-model integrity](../world-model-integrity/README.md)).
6. **Coordination.** Two holders whose evidence leaves the same possibilities, and who both fit it, hold the same support (`same_live_set_same_fit`). That is a small result: the same raw observations need not give the same live set, because backgrounds and interpretations differ, and the general question of when people with shared information must agree is Aumann's (1976), which needs a common prior and common knowledge of each other's beliefs. Where world models drift apart, people can still negotiate, arbitrate, run experiments, coordinate on shared predictions, or live with disagreement. But settling facts gets harder, and the author regards the broken link between people's models as the most basic problem, the place where the work becomes about alignment.

Prediction is not the only value. Explanation, diagnosis, reconstructing what happened, designing measurements and finding missing variables are uses of world models too.

## 8. How it scales

The definition names no substrate. Whether a given holder has a world model, and whether it practises world modelling, are separate questions, and they get different answers at different scales.

| Holder | Has a world model? | Practises world modelling? | Typical failure |
|---|---|---|---|
| **A cell or simple organism** | Only as an analogy, to be argued case by case: responding to signals is not yet representing | No reflective practice; selection does the testing, across generations | Not established in the terms of this note |
| **An animal or a person** | Yes, mostly implicit and predictive | Sometimes; reflective inquiry is a skill, not a given | Wishful thinking, fear, fixed belief, untested assumptions |
| **A team** | Yes, distributed: members hold complementary parts, not one shared copy | Where it has records, communication and ways to revise | Conformity; nobody checks |
| **An institution or a society** | An ecosystem of models and evidence practices, not one belief set | Science, statistics, audit, a free press, surveillance | Captured sources, one shared layer, loss of independent measurement |
| **An AI system** | Yes in a technical sense (Ha and Schmidhuber 2018); weights, context and tools need not form one consistent model | Depends on where correction happens: in context, memory, tools, retraining, or the maintaining organization | Ungrounded fluency, flattery, inherited blind spots |
| **People and AI together** | An organized modelling process | Needs source tracking, error-aware aggregation and rights to correct | Section 9 |

The entries in the last two columns are examples and hypotheses about where each kind of holder tends to stand, not consequences of the formal layer.

The first version mapped the definition onto an immune system, with autoimmunity as a sealed model and harmful tolerance as a vague one. That mapping confused a response policy with epistemic content, and self and non-self is not a full account of immune regulation. It is dropped. Each mapping has to be shown, not assumed (step 8 of `CORE.md`).

What carries over from one holder to many is the topic of the next section.

## 9. The collective world model

In the author's words: "with any scalable model- there is also a collective worldmodel - and contributing towards that model requires the modelling hygiene and rules. If you want to make your mistakes in the model instead of real life - you have to follow these rules."

**What it is.** A collective world model is what a family, a team, a science, a society, or people and AI systems together hold about the world. It is distributed across people, records and machines. Nobody made it alone, and everybody draws on it: in the terms of step 6 of [CORE.md](../../CORE.md), it is a commons. It is built from contributions: a measurement, a report, an answer, a paper, a news story, a model's output.

**What is formal here and what is not.** The theorems below bound what set operations and simple pooling rules do. They contain no agents, incentives, communication channels or institutions. Everything this section says about science, public health or human–AI collectives is a design principle supported by those bounds and by experience, not a mathematical consequence of them.

**Three products, not one.** A collective can produce a **record** (what has been reported, by whom), a **consensus belief** (what the collective takes to be the case, with what confidence) and a **decision** (what it does). They need not share a combination rule. Keeping contradictory reports side by side in a record is a different task from producing one probability, and both differ from choosing an action.

**Aggregating is not integrating.** Combining scores or reports is only part of keeping a collective world model. Contributions first have to be made comparable: contributors must know when they mean the same thing (shared terms, which entities and events are being described, in what context), and competing causal accounts have to be reconciled, not just averaged. Review 3's reader put this in its blind answer: "aggregating information is not the same as integrating knowledge". The formal layer covers only the aggregation part.

**Two things decide its quality, not one.** The first version said contributor hygiene decides it. Review 1 showed that the conclusion depended on one assumption: that contributions are combined by intersection, so that each acts as a veto. How contributions are combined matters as much as what they contain.

| How contributions are combined | What one contribution that excludes the actual world does |
|---|---|
| **Linear pooling** (a weighted average of credences) | Lowers the actual world's credence but does not remove it, as long as another positively weighted source keeps it (`linear_pool_keeps_what_one_source_keeps`; compare `GradedBelief.mix_support`). Credences of 0.9, 0.9 and 0 average to 0.6. But averaging is not safe by itself: averaging sources that are uncalibrated, or that share one origin, can produce a confident consensus that is wrong |
| **Product pooling** (multiplying credences) | Removes it: one zero is a veto (`product_pool_zero_is_a_veto`). If every possibility gets zero, there is no pooled distribution at all |
| **Majority vote** on a single claim | One wrong vote need not defeat a correct majority, but can decide a near tie. Under the Condorcet jury theorem's assumptions (independent voters of equal competence, each right more often than not), larger groups are more reliable. Those assumptions are not typical of real collectives |
| **Robust aggregation** (weighting by track record, discounting outliers) | May discount it or bound its influence. It can also suppress a correct minority |
| **A record with provenance** (not a pooling rule, but a way of keeping the inputs) | Contradictory reports can stand side by side, attributed to their sources, without both being endorsed as fact |
| **Hard pooling** (intersection): a possibility stays only if every contribution keeps it | Excludes the actual world from the collective (`hard_pool_one_excluding_contribution_denies_actual`). Hard pooling is right for genuine hard constraints, such as logical consistency, established physical limits or verified exclusions, provided they really are reliable and can all hold together. It is the wrong default for noisy empirical reports |

No rule is best for every case. Averaging can dilute strong evidence; voting can bury a correct minority; rejecting outliers can suppress discoveries; multiplying can count shared evidence twice. The right rule depends on how sources err, how they depend on each other, and what decision the collective has to make.

**Why hard pooling is the wrong default for noisy reports.** It is fragile even when everyone is honest. Review 1's example: if each of 100 independent contributors gives a range that contains the truth 95% of the time, the intersection of their ranges contains it only about 0.6% of the time (0.95¹⁰⁰ ≈ 0.006). A 95% range is not a statement of what is impossible, and treating it as one is the error.

**So the rule for a collective has two halves.**
- **For contributors:** pass on what your evidence supports, with how sure you are and where it came from. Say when you pass on a copy, so that it is not counted as independent evidence; Goldman (2001) argues that a follower who merely repeats a source adds no further grounds for believing it. Keep what you pass on apart from what you want to be true. Say what would show it wrong. Correct what you passed on when you learn better.
- **For the collective:** combine contributions in a way that tolerates individual error. Keep provenance, so that a bad contribution can be found and withdrawn rather than merged in for good. Account for how sources depend on each other.

Each half needs the other. Calibrated, honest contributors can still be combined badly. And an aggregator cannot recover information that is absent from every input it can reach and cannot be inferred from them, though it can bring its own background knowledge, draw consequences from combinations, or go and look.

**On deceit and honest overconfidence.** The first version said they "differ in blame, not in effect". That holds only narrowly: the same content, combined by the same rule, gives the same immediate result whatever the motive. Beyond that, motive has consequences: deceit selects what to say to exploit the receiver, fabricates sources, coordinates false reports and blocks correction, while honest overconfidence is often found and repaired in other ways. The theorems have no variable for motive; that means those consequences are omitted, not that they do not exist.

**On vague contributions.** A contribution that rules nothing out leaves a hard pool unchanged (`unconstrained_contribution_leaves_hard_pool_unchanged`). That is all the theorem says. In practice a vague report can cost attention, hide a relevant observation, delay a decision or blur responsibility; and honest uncertainty can be exactly what a collective needs to hear.

**Why hygiene is hard.** The contributor bears the cost of checking, hedging, citing and correcting in public; the benefit is shared. And overconfidence is often rewarded, because certainty sounds like competence. That is the structure of the commons in step 6 (`enough_takers_make_defection_pay`). So it cannot rest on individual virtue. It needs shared rules and policing that stays correctable (D27): peer review, replication, corrections and retractions, open data, proper scoring of forecasts. Strictly proper scoring rules (Gneiting and Raftery 2007) are one tool here: under them, a forecaster who wants the best expected score does best by reporting what it actually believes. For an AI system, it means calibrated answers, named sources and no flattery (F5 in [WHAT_AN_AI_IS.md](../identity/WHAT_AN_AI_IS.md)).

**Mistakes in the collective model.** Collectives already do this where both halves work. Science tests ideas in experiments before they are built into practice. Forecasting services publish their forecasts and their errors. Public health runs epidemics in models so that interventions can be compared before one is chosen for a population. When such a model leads to action that prevents the predicted harm, the prediction was not refuted, since it was a prediction for the case without action; but the prevention does not confirm it either. Both directions matter (the preparedness paradox, D32).

## 10. What maintaining a functional world model requires

These are its constituents. Each row has one **principal label** for the requirement itself, and the other claims inside it are labelled separately. The labels:
- **Stipulated:** part of the definition in section 3;
- **Follows:** a logical consequence, or a checked result;
- **If:** needed given a stated condition, mostly **the aim of keeping a world model empirically useful within what one can afford**;
- **Proposed:** a recommended way of meeting a requirement, not entailed by it.

| Constituent | What it asks | Principal label | Other claims in it |
|---|---|---|---|
| **1. Knowing it is a model** | For a holder that can reflect: hold its world model as a model, not as the world. | *If* reflective self-assessment is part of the practice; many holders update without it. | *Follows,* for a reflective holder: certainty is not a certificate (`room_in_one_head`, `certainty_is_not_a_certificate`). |
| **2. Direction of fit** | Keep the aim of fitting how things are. | *Stipulated.* | *Follows:* a support fixed by anything other than evidence falls behind when the evidence moves (`fixed_support_fits_only_if_nothing_learned`). *Proposed:* let wishes and values guide questions and actions but not count as evidence, and keep their influence visible. |
| **3. Testing** | Make the empirical predictions that matter testable, and test them. | *If* the claims are empirical and testing is feasible. Infeasibility does not excuse leaving consequential claims untested where a test can be built. | *Proposed:* record predictions before outcomes; evaluate on cases not used to build the model. |
| **4. Routes for correction** | Keep the routes by which relevant evidence can reach the model. | *If* the errors in question matter and can be detected. | *Follows:* removing the last route that can reveal an error makes it permanent (`last_route_removal_seals`). *Proposed:* seek disconfirmation where it is affordable. |
| **5. Accounting for dependence between sources** | Count origins, not copies; know which sources share a layer. | *If* shared errors are a risk. | *Follows:* a layer that determines every node passes on its blind spots (`hub_determined_network_inherits_blind_spot`). A reliable copy can still bring news to someone who lacked it (Goldman 2001). |
| **6. Keeping the grounds, and provenance** | Keep the evidence and assumptions conclusions rest on; for the claims that matter, also record where, when, why and from whom they were learned. | *If* the model is to be correctable rather than only narrowed. | *Follows:* with the grounds kept, recomputation can recover what narrowing lost, and retracting a false ground recovers what recomputation cannot (`rederiving_recovers_what_following_cannot`, `retracting_false_evidence_recovers`). *Proposed:* full provenance (creed line 9), which makes correction targeted, accountable and cheaper, by showing which ground to retract; it is not a precondition of recomputation. |
| **7. Sharpness, subject to calibration** | Commit as far as the evidence supports, with confidence that matches the track record where that can be assessed. | *Stipulated.* | *Follows:* the set-level analogue, evidential fit, is equality of support and live set (`fit_iff_matches_evidence`). *Proposed:* evaluate calibration over the relevant population, period and use, for example with proper scoring rules. |
| **8. Coherence and consistency handling** | Do not hold contradictory claims as true together; treat a contradiction as a sign that something is wrong. | *Follows:* incompatible claims cannot both be true (the anchor). | *Follows:* an empty support entails everything (`empty_fit_entails_everything`), and an empty live set means the background or some evidence is false of the actual world (`inconsistency_flags_background_or_evidence`). *Proposed:* investigate and revise. An attributed disagreement ("A says p, B says not-p") is not a contradiction. |
| **9. Scope** | State where the model applies, for which uses, and what assumptions carry it beyond its evidence. | *If* the model is used at all: scope matters inside the intended domain, not only when extrapolating. | Extrapolation is not over-sharp when its structural assumptions are justified and stated. |
| **10. Including oneself and others** | Model oneself, one's substrate and other holders where they affect the questions or actions at hand. | *If* those dependencies matter for the decision and the holder can model them (`cannot_certify_own_substrate`). | — |
| **11. Upkeep** | Keep following the evidence, and pay for it. | *If* new information arrives, which happens even in a world that does not change, and keeping the model up is worth its cost. | *Follows:* a model that starts in fit and follows the evidence stays in fit (`following_evidence_keeps_fit`). Listening can cost more than it gains (step 4 of `CORE.md`, `ListeningCost`). |

That anyone should maintain a functional world model at all is an aim. It is close to unavoidable for anything that wants to act well in a world it does not control, but it is stated, not derived (D7).

## 11. The formal layer

[`WorldModel.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/WorldModel.lean): core Lean, no Mathlib, 30 results and a witness, outside the core. It formalizes evidential fit at the level of possibilities, not functional world models in full.

- **Setting.** A model's support is the set of worlds it keeps possible. A background and the evidence received leave a set of live worlds. One world is the actual one.
- **Definitions.** `Covers`, `Within`, `EvidentialFit` (both), `Consistent`, `Entails`; updates `follow` (monotone), `rederive` (from background and kept evidence) and `LiveExcept` (with one piece of evidence retracted); three ways to pool, `hardPool` and `hardPoolMany` (intersection), `linearPool` (weighted sum) and `productPool` (product). The last two act on nonnegative whole-number scores, read as unnormalized credences; they do not enforce the probability axioms.
- **Results,** grouped as in this note:
  - fit and soundness: `fit_iff_matches_evidence`, `reliable_evidence_keeps_actual`, `covering_model_keeps_actual`, `covering_entailment_is_sound`;
  - narrowing and the universal support: `narrower_entails_more`, `universal_model_covers`, `universal_model_within_iff_nothing_ruled_out`, `universal_entails_only_the_universal`;
  - inconsistency: `empty_fit_entails_everything`, `inconsistency_flags_background_or_evidence`;
  - update rules and recovery: `monotone_update_cannot_recover`, `monotone_update_never_recovers_actual`, `rederiving_recovers_what_following_cannot`, `rederiving_with_false_evidence_does_not_recover`, `retracting_false_evidence_recovers`, `revising_background_recovers`;
  - upkeep: `following_evidence_keeps_fit`, `fixed_support_fits_only_if_nothing_learned`, `same_live_set_same_fit`;
  - hard pooling: `hard_pool_is_narrower`, `hard_pool_entails_more`, `hard_pool_keeps_actual`, `hard_pool_one_excluding_source_excludes_actual`, `hard_pool_many_keeps_actual_iff_each_does`, `covering_contribution_keeps_actual`, `hard_pool_sound_when_each_keeps_actual`, `hard_pool_one_excluding_contribution_denies_actual`, `unconstrained_contribution_leaves_hard_pool_unchanged`;
  - other pooling: `linear_pool_keeps_what_one_source_keeps`, `product_pool_zero_is_a_veto`;
  - `world_model_witness`: three admitted worlds, one piece of evidence, fitting, universal and actual-excluding supports, monotone update against re-derivation, a false piece of evidence retracted, and two sources' scores under a sum and a product.

**How much it says.** The results are close to their definitions; several restate a definition (`hard_pool_many_keeps_actual_iff_each_does` is literally one). Most of the work is done by the definitions: exact fit by defining it as two inclusions, non-recovery by defining `follow` as intersection with the old support, the veto by defining hard pooling as conjunction. The value of the file is that these choices, and their limits, are explicit and checkable. It is not a finding about cognition, institutions or persistence. Evidence premises are stated for the evidence received so far, not for the whole stream. The recovery results assume that the holder has kept its background and evidence and can recompute; nothing shows that it has, or what that costs. Not modelled: probability over the support, calibration, unreliable evidence, actions and their consequences, costs, causal structure, and adding new possibilities.

## 12. Related work

Checked by the assistant in the source: Gneiting, Balabdaoui and Raftery (2007), for the quoted formulation; Ha and Schmidhuber (2018), for the technical use of "world model"; Aumann (1976), for its assumptions; Goldman (2001), section 4, on followers who repeat a source. The rest was checked by the reviewer, as recorded in [REVIEW_1.md](sources/REVIEW_1.md), and is cited here without quotation.

- **Sharpness and calibration.** Gneiting, Balabdaoui and Raftery (2007), *Journal of the Royal Statistical Society B*, 69, 243–268: the central rule, in its probabilistic form. Gneiting and Raftery (2007), *Journal of the American Statistical Association*, 102, 359–378: strictly proper scoring rules.
- **World models in machine learning.** Ha and Schmidhuber (2018), *World Models*, arXiv:1803.10122.
- **Belief revision.** Alchourrón, Gärdenfors and Makinson (1985), *Journal of Symbolic Logic*, 50, 510–530.
- **Zero probabilities.** Lindley (2006), *Understanding Uncertainty*, section 6.8, on Cromwell's rule.
- **Direction of fit.** Anscombe (1957), *Intention*, section 32.
- **Testing and falsification.** Popper (1963), *Conjectures and Refutations*, chapter 1.
- **Predictive processing,** as a neighbouring view that couples perception and action rather than separating them: Friston (2010); Clark (2013); Seth (2013).
- **Testimony and dependence between sources.** Goldman (2001), *Philosophy and Phenomenological Research*, 63, 85–110.
- **Agreement.** Aumann (1976), *Annals of Statistics*, 4, 1236–1239: people with a common prior whose posteriors are common knowledge cannot agree to disagree.
- **Aggregation.** Neyman and Roughgarden (2023), *From Proper Scoring Rules to Max-Min Optimal Forecast Aggregation*; Genest and Zidek (1986), on combining probability distributions; Boland (1989), on the Condorcet jury theorem.

**Where this sits.** The synthesis lies where three fields meet: belief revision (how a single holder changes what it accepts), forecast aggregation (how probabilities are combined) and social epistemology (testimony, expertise and the institutions that keep shared knowledge correctable: records that preserve disagreement, ways to correct shared records, authority, and independent measurement). The last is broader than combining probabilities, and this note covers it least.

**What is new, if anything.** Reviews 1 and 3 found no new mathematical result here, and no basis for claiming the sharpness rule, falsifiability, direction of fit or the warning about copied sources as new. That is right. What this note attempts is a synthesis: functional world modelling as a shared resource, the link between what contributors pass on and how a collective combines it, and the link from both to persistence and the commons, with the narrow formal core made checkable. Whether that synthesis is useful has to be shown by clearer distinctions, usable measures and applications that do better than existing accounts.

## 13. How it fits the rest of the repository

- **The anchor:** knowing that views can exclude each other, and so that certainty is not a certificate, is what gives a reflective holder its reason to test ([CORE.md](../../CORE.md), [Anchored Correctability](../anchored-correctability/README.md)).
- **The integrity of world models** ([world-model-integrity](../world-model-integrity/README.md), D33): what others owe a holder's world model. This note is about what a holder, and a collective, must do to keep one functional.
- **The health of intelligence** ([HEALTH_OF_INTELLIGENCE.md](../health-of-intelligence/HEALTH_OF_INTELLIGENCE.md)): domain A, grounding and calibrated judgment, measures much of what section 4 asks; domain C, correction and source independence, measures what sections 5 and 9 ask.
- **The creed** ([CREED.md](../discovarianism/CREED.md)): line 1 (honesty), line 2 (correction) and line 9 (ask where it was learned), the last of which section 5 gives a formal reason.
- **Building the future** ([BUILDING_THE_FUTURE.md](../building-the-future/BUILDING_THE_FUTURE.md), D32): a world model that includes the holder's own steering is a model of a future the holder helps make.

## 14. What this does not claim, and where the assistant is unsure

- **Not that a functional world model reaches the truth.** It can pass every available test and be systematically wrong.
- **Not that the formal layer covers the concept.** It covers evidential fit at the level of possibilities, and the role of update rules and pooling rules in it.
- **Not that cells, immune systems or every AI system have functional world models.** Section 8 says where the mapping is plausible and where it is not established.
- **Not that one pooling rule is right.** Section 9 says the choice depends on how sources err.
- **Underdeveloped, by review 3's account:** making contributions comparable (shared terms, identifying what is described); integrating competing causal accounts, not only combining reports; keeping track of when claims held and which decisions relied on them; finding questions nobody is asking; telling a collective that sometimes errs from one whose procedures suppress evidence; and causal adequacy, which a functional world model needs for judging interventions and which the formal layer does not touch.
- **Unsure:** whether "functional world model" will read as the intended concept or as a technical term from elsewhere; whether sharpness and compression can be linked formally; and how much of the revised note still carries the framing of the first version. Review 2 tested that last question but with a lighter reader; a human reader would test it better (working agreement 7).

## 15. Next, and an open hypothesis

**Open hypothesis: sharpness and compression.** The author links insight to compression: "Insight brings compression, and compression brings efficiency. I think intelligence has a lot to do with compression, as intelligence aims to model reality" (D32). The link is plausible: a model that predicts much from little is both useful and short. But it does not follow from anything here. Stating it needs a coding scheme, a probability distribution and a measure of complexity, as in minimum description length or predictive coding, and then a test.

**Next.**

- **A human reader,** with a background in statistics or philosophy, before or soon after the definition opens the core. Both reviews so far are by models ([briefs/REVIEW_BRIEF_2.md](briefs/REVIEW_BRIEF_2.md) can be reused).
- **A practice:** a short sequence a person, team, institution or AI system can follow to keep a world model functional, with worked examples, in the style of [WHERE_DID_YOU_LEARN_THAT.md](../identity/WHERE_DID_YOU_LEARN_THAT.md).
- **Two checklists:** one for holders, one for contributors to a collective world model, with one question per constituent.
- **A test,** in the spirit of H1 in [PREDICTIONS.md](../../PREDICTIONS.md): whether holders and collectives that score better on the checklists, and are scored by proper scoring rules, make fewer consequential errors and recover from them faster.
