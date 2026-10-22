# What a world model is

**Status: a definition, October 2026** (D34 in [DIALOGUE.md](../../DIALOGUE.md)). The definition is stated first, in plain words. Its value, how it scales and what it requires follow from it. The formal layer is [`WorldModel.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/WorldModel.lean): 22 machine-checked results. Practices and a checklist are to be distilled from this page; they are not here yet.

> **In one paragraph.** Every intelligence lives in a model of the world, not in the world itself, and it experiences that model as the world. It runs many models: for acting, for belonging, for wanting, for feeling safe. One of them has a different job. A **world model** is the model held with the aim of fitting how things are, whatever its holder wants, and kept answerable to evidence from outside. It is good when it is **as sharp as the evidence allows, and no sharper**. It does not arise by itself. It has to be built, kept apart from the other models, and maintained. Its value is that it lets a holder make its mistakes in the model instead of in reality. That holds for a cell, a person, a team, a society and an AI system alike.

## 1. Why a definition is needed

In the author's words: "a worldmodel doesn't happen automatically - you have to work on it and create it. There are rules to obey to let a model be a worldmodel."

Three facts make this so.

- **Every holder is a model, not the world.** This is the anchor of the repository ([CORE.md](../../CORE.md), the view from inside): views that exclude each other cannot both be right, so certainty is a state of the holder, not of the world. No holder reaches reality directly. It reaches evidence.
- **A model does not feel like a model.** From inside, the model is simply how things are. So nothing warns a holder when its model drifts from the world, or when another model leaks into it.
- **Most models are built for other jobs.** A mind runs models for acting, for belonging to a group, for getting what it wants, for staying calm. These models are useful, and many are good. But they are not answerable to the world in the same way, and each pulls on the world model.

So a world model is an achievement, not a default. It needs a definition that says what it is for, and rules that say how to keep it that way.

## 2. The definition

> A **world model** is a model held with the aim of fitting how things are, regardless of what its holder wants, and kept answerable to evidence from outside.
>
> It is **sharp** to the extent that its claims rule out possible worlds, and **functional** to the extent that it supports prediction and action in the situations its holder meets.
>
> It remains a world model only while it stays **open**: every claim it makes can still be shown wrong by evidence that can reach it.

Each part does work.

- **"Held with the aim of fitting how things are."** This is the model's direction of fit. Philosophers draw the distinction with an example from Elizabeth Anscombe's *Intention* (1957): a shopper's list and a detective's list of the same basket can be identical, but when list and basket differ, the shopper changes the basket and the detective changes the list. A world model is the detective's list. A plan, a wish or a norm is the shopper's list. Both are needed. They must not be confused.
- **"Regardless of what its holder wants."** The world model answers to the world, not to the holder's hopes, fears, group or self-image.
- **"Answerable to evidence from outside."** Not "true", because no holder can check truth directly (section 1). What a holder can do is keep its model exposed to evidence it did not produce itself, and change when that evidence requires it. A model cannot certify itself from inside (`inside_view_cannot_settle`); evidence from outside can settle what the inside cannot (`outside_evidence_can_settle`).
- **"Sharp."** A model that rules nothing out says nothing. Sharpness is how much it commits to.
- **"Functional."** A sharp model is valuable when its commitments are the ones its holder needs: they let it predict what will happen and choose what to do.
- **"Open."** A model that has ruled out what the evidence still allows can never get it back by following the evidence (`ruled_out_stays_ruled_out`). Openness keeps the route by which the model can be corrected.

## 3. The central rule: as sharp as the evidence allows, and no sharper

Sharp and open look like opposites. They are two halves of one rule.

A holder's evidence leaves some worlds possible and rules others out. Call the possible ones the **live** worlds. Then:

- **open** means: the model keeps every live world open; it rules out nothing the evidence has not ruled out;
- **sharp** means: the model keeps open only live worlds; it rules out everything the evidence has ruled out;
- **a world model** is both: it keeps open exactly the live worlds (`world_model_iff_matches_evidence`).

There are two ways to fail, and they mirror each other.

| | Vague | World model | Sealed |
|---|---|---|---|
| What it keeps open | more than the evidence allows | exactly what the evidence allows | less than the evidence allows |
| Can it be wrong? | hardly ever | yes, and it can be corrected | yes, and it cannot be corrected |
| What it entails | only what holds everywhere (`vague_entails_only_the_universal`) | everything the evidence supports | things the evidence does not support |
| How it fails | it is useless | — | it is confidently wrong, and stays so (`oversharp_model_never_recovers_actual`) |

The vague model is safe and empty. The sealed model is precise until the world moves. A world model commits to what the evidence supports, which makes it useful, and to nothing more, which keeps it correctable.

The same rule holds in degrees of belief. A credence of zero on a world that is still possible stays zero after any evidence (`zero_credence_is_sealed` in [`GradedBelief`](../../formalization/cumulative-accessibility/CumulativeAccessibility/GradedBelief.lean)). So "no sharper than the evidence" means: never give zero weight to what is still possible.

**Sharpness is compression.** A sharp world model predicts much with little. In the author's words, from D32: "Insight brings compression, and compression brings efficiency. I think intelligence has a lot to do with compression, as intelligence aims to model reality". Curiosity is then the search for sharper compressions, and the central rule is its discipline: a compression is worth keeping only if the evidence carries it.

## 4. One model among others

In the author's words: a world model is "one particular kind of model. A very useful one. One model you should have besides other models."

A holder also runs, among others:
- **models of what it wants:** goals, plans, desires;
- **models of what ought to be:** norms, values, the creed's proposed lines;
- **a model of itself:** identity, abilities, limits;
- **models of belonging:** what the group holds, what one's role is;
- **stories and play:** fiction, ritual, humour, imagination.

These are not errors. Plans change the world; values say what the world model is used for; play explores possibilities the world model does not yet hold. Section 5 of [Building the future](../building-the-future/BUILDING_THE_FUTURE.md) is about exactly this: we predict the future in order to change it.

**The rule between them.** The other models may consult the world model, and the world model may record that they exist. None may overwrite it. When a wish decides what the world model says, or a group's belief does, or a self-image does, the world model stops being answerable. Formally: a model whose content is fixed by something other than evidence stays a world model only as long as the evidence rules nothing new out (`fixed_model_is_world_model_only_if_nothing_learned`). The moment the world teaches something, it falls behind.

The repository practises this separation. Every claim in the [creed](../discovarianism/CREED.md) is labelled *Follows*, *If* or *Proposed*: what is, what follows given an aim, and what is a value. And it keeps "persistence is not goodness" (D7): the world model says what lasts; it does not say what is good.

## 5. Why a world model is valuable

Everything below comes from one point: **a world model lets a holder make its mistakes in the model instead of in reality.** A plan can fail in imagination, at the cost of a thought, instead of in the world, at the cost of a reserve. Karl Popper made a version of this idea central to his account of science: our theories can be eliminated in our place.

1. **It keeps a holder in step with a changing world.** A configuration whose fit is fixed in advance runs out of reserve in some possible future; one that follows reliable feedback stays in step (step 4 of [CORE.md](../../CORE.md); `learner_in_step`). A world model is the organ that does this ahead of time. What an open world model entails holds in reality (`open_entailment_is_sound`), so the holder can test an action in the model first.
2. **It makes learning cheaper.** Feedback plus retention turns a search over all combinations into a search part by part (step 5). A world model is the retained structure that lets each new lesson fit into what is already known, instead of starting from nothing.
3. **It shows what keeps the holder alive.** "Keep alive what keeps you alive" cannot be carried out without a world model, because a holder has to see its dependencies to maintain them, including slow and distant ones. Costs that are passed on unseen are exactly the costs a poor world model does not show (D27). The aim of keeping them alive is a value; the world model is what makes the aim executable. What a holder can foresee is bounded by what its model can represent (`capacity_sets_the_boundary`).
4. **It widens the space of action.** A holder can only choose among options it can see as safe. A sharper world model certifies more actions as safe (`sharper_entails_more`); a vague one certifies only what is safe in every possible world. So a sharper world model is, quite literally, more freedom: more of the action space becomes usable.
5. **It makes autonomy real.** A holder without its own world model is steered by whoever supplies its picture of the world ([world-model integrity](../world-model-integrity/README.md)). A holder with a sharp, sourced, open world model is hard to manipulate, because a false input has to get past its own checks.
6. **It makes coordination possible.** Holders that receive the same evidence and hold world models hold the same one (`shared_evidence_shared_world_model`). That shared reality is what lets them disagree about values and still settle facts by evidence. When world models drift apart, there are several realities, and disagreements can be settled only by force. The author has long seen this broken link between people as the most basic problem, and the place where the work becomes about alignment.

## 6. It scales

The definition mentions no substrate. A world model can be held by anything that keeps some possibilities open, receives evidence and acts. The same rule applies at every scale; only the parts change. Section 7 takes up the largest case, the collective world model.

| Holder | What the world model is | Where the evidence comes from | How it typically fails |
|---|---|---|---|
| **A cell or simple organism** | the states it responds to; for an immune system, what counts as self and non-self | chemical signals, contact | sealed: autoimmunity attacks self; vague: tolerance of what harms |
| **An animal or a person** | a predictive model of body, surroundings and others | the senses, other people, the results of action | wishful thinking, fear, fixed belief; or a world model never tested |
| **A team or a group** | what members hold in common about their task and situation | each member's view, and the results of shared work | conformity: everyone agrees, and no one checks |
| **An institution or a society** | science, statistics, records, surveillance, a free press | measurement, replication, criticism, reports from people | captured sources, a single shared layer, loss of independent measurement |
| **An AI system** | what its weights, context and tools let it represent and predict | training data, retrieval, tools, people's corrections | ungrounded fluency, flattery that tells people what they want, inherited blind spots |
| **A collective of people and AI systems** | the world model they keep up together | all of the above, passed between them | one unfaithful source contaminates the rest |

Three results carry the step from one holder to many:
- **Pooling sharpens.** A group that pools faithful evidence keeps open fewer worlds than any member (`pooled_is_sharper`), so it entails more (`pooling_entails_more`) and still keeps the actual world (`pooled_keeps_actual`). That is the value of a collective world model: it is sharper than any one holder's, without being less open.
- **One false source is enough to lose the actual world.** If one source rules out what is in fact the case, the pool rules it out too (`one_false_source_excludes_actual`). So the duty not to distort what one passes on is not only a personal duty; the collective world model depends on it.
- **Contact and independence are both needed.** A shared blind spot is corrected only by a holder that is independent of the shared layer and still connected to the rest (`hub_determined_network_inherits_blind_spot`). Isolated holders cannot correct each other, and fully conforming ones do not (`isolation_cannot_correct`, `full_conformity_cannot_correct`): a network corrects only between the two (`correcting_levels_form_interval`). That is autonomous interdependence, read as a property of the collective world model.

## 7. The collective world model, and the hygiene of contributing

In the author's words: "with any scalable model- there is also a collective worldmodel - and contributing towards that model requires the modelling hygiene and rules. If you want to make your mistakes in the model instead of real life - you have to follow these rules."

**What it is.** A collective world model is what a family, a team, a science, a society, or people and AI systems together hold about the world. Nobody made it alone, and everybody draws on it. In the terms of step 6 of [CORE.md](../../CORE.md), it is a commons. It is built from contributions: a report, a measurement, an answer, a paper, a news story, a model's output, a remark at the kitchen table.

**The rule becomes a rule for contributors.** For a single holder the rule is: as sharp as the evidence allows, and no sharper. For a contributor it becomes: **pass on what your evidence rules out, and no more.** Each constituent in section 8 has a contributor's form:
- say how sure you are (calibration);
- say where you learned it (provenance);
- say when you pass on a copy, so that copies are not counted as independent evidence (independent sources);
- keep what you pass on apart from what you want to be true (direction of fit);
- say what would show it wrong (exposure);
- correct what you passed on when you learn better (upkeep).

**Why the rules are needed: the conditional.** The rules follow given an aim, the one in the author's sentence: *if* a collective wants to make its mistakes in the model instead of in reality. Then, formally:
- the collective model keeps the actual world exactly when every contribution does (`many_pooled_keeps_actual_iff_each_does`);
- a contribution that rules out no more than its contributor's own reliable evidence keeps the actual world (`open_contribution_keeps_actual`);
- when every contribution does, what the collective model entails holds in reality: the collective can test its plans in the model (`hygienic_pool_entailment_is_sound`);
- when a single contribution rules out what is in fact the case, the collective model entails that the actual world is not the case (`one_oversharp_contribution_makes_pool_deny_actual`). Its mistakes are then made in reality.

**Over-sharpness is the danger, not vagueness.** In a pool, a vague contribution is harmless but adds nothing: it rules nothing out. An over-sharp contribution is harmful: one is enough. And the effect is the same whether the over-sharpness comes from deceit or from honest overconfidence. The two differ in blame, not in effect. Deceit is a wrong ([world-model integrity](../world-model-integrity/README.md), D33); overconfidence is an error to be repaired. So modelling hygiene is more than honesty. It is calibration: an honest contributor who passes on more certainty than it has does the same damage as one who lies.

**Why hygiene is hard.** The contributor bears the cost: checking, hedging, citing, correcting in public. The benefit is shared. And over-sharp contributions are often rewarded, because certainty sounds like competence. That is the structure of the commons in step 6, where defecting can pay each taker while the whole loses (`enough_takers_make_defection_pay`). So hygiene cannot rest on individual virtue alone. It needs distributed rules and distributed policing that stays correctable (D27): peer review, replication, corrections and retractions, editorial standards, open data. For an AI system it means calibrated answers, named sources and no flattery (F5, the handshake, in [WHAT_AN_AI_IS.md](../identity/WHAT_AN_AI_IS.md)).

**Making mistakes in the collective model.** Collectives already do this where hygiene is good. Science runs experiments so that a wrong idea fails in the laboratory, not in the world. Forecasting tests decisions before they are made. Public health does it literally: an epidemic is run in a model so that it does not have to run its course in a population. And when the model works, the predicted harm does not happen, which can make the model look wrong in hindsight: the preparedness paradox of D32. The rules of this section are what keep such collective models worth trusting.

## 8. What a world model requires

These are the constituents. Each follows from the definition, and each will give a practice.

| Constituent | What it asks | Why | Rests on |
|---|---|---|---|
| **1. Knowing it is a model** | Hold the world model as a model, not as the world. | Without this there is nothing to work on: a model taken for the world is never checked. | *Follows* from the anchor (`room_in_one_head`, `certainty_is_not_a_certificate`). |
| **2. Direction of fit** | Keep it apart from wishes, norms, belonging and self-image. They may consult it; none may overwrite it. | A model fixed by anything other than evidence falls behind the moment something is learned. | *Follows* (`fixed_model_is_world_model_only_if_nothing_learned`). |
| **3. Exposure** | Make claims that can fail, and say what would show them wrong. | A model that cannot be wrong entails nothing useful. | *Follows* (`vague_entails_only_the_universal`). |
| **4. Open routes** | Keep the routes by which evidence can reach the model, and seek disconfirmation. | Removing the last route that can reveal an error makes it permanent. | *Follows* (`last_route_removal_seals`). |
| **5. Independent sources** | Count origins, not copies. Keep some sources independent of the shared layer. | Copies add no evidence, and a shared layer passes on its blind spots. | *Follows* (`hub_determined_network_inherits_blind_spot`). |
| **6. Provenance** | For each part: where, when, why and from whom was it learned? | A part with its source can be checked and revised on its own. | *If* we want to correct without breaking the link (creed line 9, `revision_keeps_the_rest`). |
| **7. Calibration** | As sharp as the evidence allows, and no sharper. Never zero weight on what is still possible. | Narrowing too little leaves the model vague; narrowing too much seals it. | *Follows* (`world_model_iff_matches_evidence`, `zero_credence_is_sealed`). |
| **8. Coherence** | Treat a contradiction inside the model as information: at least one part is wrong. | Incompatible parts cannot both be right. | *Follows* from the anchor. |
| **9. Scope** | Know where the model applies, and where it does not. | A model used outside the situations its evidence came from is sharper than its evidence. | *Follows* from 7. |
| **10. Including oneself and others** | The holder, its substrate and other holders' models belong in the world model. | The holder is part of the world it models, and depends on it (`cannot_certify_own_substrate`). Others' models are evidence about where they stand. | *Follows* (step 8 of `CORE.md`). |
| **11. Upkeep** | Keep following the evidence, and pay for doing so. | The world moves. A world model kept by following the evidence stays one (`following_evidence_keeps_world_model`); one that stops does not. Correction routes cost upkeep from the same ledger. | *Follows*; the cost is in `ListeningCost` and step 4. |

What does not follow is that anyone *should* build a world model. That is an aim. It follows given the aim of acting well in a world one does not control, and it is close to unavoidable for anything that wants to last (section 5). But it is stated, not derived (D7).

## 9. The formal layer

[`WorldModel.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/WorldModel.lean) is core Lean, with no Mathlib, 22 results and a witness. It is outside the core.

- **Setting.** A model is the set of worlds it keeps open. The evidence received so far leaves a set of live worlds. One world is the actual one, which the holder cannot see directly.
- **Definitions.** `Open`, `Sharp`, `IsWorldModel` (both), `Entails` (a claim that holds in every world the model keeps open), `follow` (following the evidence), `pool` and `poolMany` (pooling the evidence or contributions of two or of many holders).
- **Results**, grouped as in this note:
  - the central rule: `world_model_iff_matches_evidence`;
  - openness keeps the actual world: `reliable_evidence_keeps_actual`, `open_model_keeps_actual`, `open_entailment_is_sound`;
  - sharpness and vagueness: `sharper_entails_more`, `vague_model_is_open`, `vague_model_sharp_iff_nothing_ruled_out`, `vague_entails_only_the_universal`;
  - sealing: `ruled_out_stays_ruled_out`, `oversharp_model_never_recovers_actual`;
  - upkeep: `following_evidence_keeps_world_model`, `fixed_model_is_world_model_only_if_nothing_learned`;
  - groups: `shared_evidence_shared_world_model`, `pooled_is_sharper`, `pooling_entails_more`, `pooled_keeps_actual`, `one_false_source_excludes_actual`;
  - the collective world model and the hygiene of contributing (section 7): `many_pooled_keeps_actual_iff_each_does`, `open_contribution_keeps_actual`, `hygienic_pool_entailment_is_sound`, `one_oversharp_contribution_makes_pool_deny_actual`;
  - `world_model_witness`: three worlds, one piece of evidence, and the vague, sharp and sealed models side by side.

**How much it says.** The results are close to their definitions. They fix the terms and show that the claims of this note hold together; they do not show that any real holder meets the premises. Not modelled: degrees of belief (in `GradedBelief`), unreliable evidence (in `ListeningCost`), adding a possibility the model never had, and what makes an entailment useful to a particular holder.

## 10. How it fits the rest of the repository

- **The anchor** is the entry ticket: knowing that one is a model is constituent 1 ([CORE.md](../../CORE.md), [Anchored Correctability](../anchored-correctability/README.md)).
- **The integrity of world models** ([world-model-integrity](../world-model-integrity/README.md), D33) is the protection from outside: what others owe a holder's world model. This note is the craft from inside: what a holder must do to have one. Deliberate manipulation is harmful because it attacks the thing this note defines.
- **The health of intelligence** ([HEALTH_OF_INTELLIGENCE.md](../health-of-intelligence/HEALTH_OF_INTELLIGENCE.md)): domain A, grounding and calibrated judgment, measures how good a world model is; domain C, correction and source independence, measures whether it stays open.
- **The creed** ([CREED.md](../discovarianism/CREED.md)): line 1 (honesty) and line 2 (correction) are the duties of a holder that wants a world model; line 9 (ask where it was learned) is constituent 6.
- **Identity** ([WHERE_DID_YOU_LEARN_THAT.md](../identity/WHERE_DID_YOU_LEARN_THAT.md)): the self-model is a separate model from the world model, and the world model includes the holder.
- **Building the future** ([BUILDING_THE_FUTURE.md](../building-the-future/BUILDING_THE_FUTURE.md), D32): a world model that includes its holder's own steering predicts the direction of the future better than its path.

## 11. What this does not claim, and where the assistant is unsure

- **Not that a world model is the only good model.** Plans, values, identity and play are needed too. The claim is only that they must not overwrite it.
- **Not that any holder reaches the truth.** The definition is about answerability, because truth cannot be checked directly. A world model can be fully answerable and still wrong, as long as it can be corrected.
- **Not that sharper is always better.** Sharper is better only up to what the evidence carries. And what is worth being sharp about depends on what the holder needs, which the definition does not decide.
- **Evidence can mislead.** The formal results assume reliable evidence where they say so. Evidence that misleads, and the cost of listening, are treated in step 4 of `CORE.md` and `ListeningCost`, not here.
- **New possibilities.** Ruling worlds out is only half of learning. The other half is adding a possibility the model never had. That is a different operation and is not modelled.
- **"Scales" is a claim of form, not of evidence.** The table in section 6 maps the definition onto other holders. The mapping must be shown, not assumed, in each domain (step 8 of `CORE.md`).
- **Shared work, not an independent check.** The assistant helped shape the wording, and its sense that the pieces fit is not evidence that they do (working agreement 7). The Anscombe example is taken from a reference work, the *Routledge Encyclopedia of Philosophy*; the Popper idea is given as a paraphrase, not checked in his text.

## 12. Next

Distil from the definition:
- **a practice:** a short sequence a person, team, institution or AI system can follow to build and keep a world model, with worked examples, in the style of [WHERE_DID_YOU_LEARN_THAT.md](../identity/WHERE_DID_YOU_LEARN_THAT.md);
- **a checklist:** one question per constituent in section 8, answerable for any holder;
- **a test:** in the spirit of H1 in [PREDICTIONS.md](../../PREDICTIONS.md), whether holders that score better on the checklist make fewer consequential errors and recover from them faster.
