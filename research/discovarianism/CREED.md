# The Discovarian creed

**Status: current version, 11 November 2026** (D23, D31, D40, D43, D45, D46 and D47 in [DIALOGUE.md](../../DIALOGUE.md)). After an independent audit (D47) two claims of the new sections were withdrawn: that each item is needed, and that every sin blocks learning in the model. After the assistant's own adversarial review (D46) the two new sections were recast: what a learner does is separated from what has to hold, and only the first has sins. A tenth verb, *develop and acquire methods*, was added as provisional at the author's wish (D45). On 11 November the two new sections were corrected after an outside review (D43); lines 1 to 13 were not touched, and the review's remarks on lines 10 and on the opening line are recorded in D43 for the author. It restates the author's creed in the light of the formal work. Linked revision of 10 November: the sections "The verbs of learning" and "Sins" are new, at the author's request (D40). They were drafted by the assistant and await the author's corrections. Lines 1 to 13 are unchanged and keep their numbers. What was held before: the creed said why a learner needs honesty, correction and repair, and did not say what learning itself is made of. What changed it: the check, first with Z3 and then in Lean, that the creed's lines are enough for learning only together with try, test, update and retain. Linked revision of 16 October: line 9, "Ask where it was learned", is new, at the author's request (D31); the lines after it moved down by one. The three earlier versions are kept as written in the repository root, as lineage:
- [Discovarian_creed.tex](../../Discovarian_creed.tex);
- [Discoverian_creed_better.tex](../../Discoverian_creed_better.tex);
- [Discoverinan_creed_better_improved.tex](../../Discoverinan_creed_better_improved.tex).

**Each line says what it rests on**, with the same discipline as [WHAT_AN_AI_IS.md](../identity/WHAT_AN_AI_IS.md):
- **Follows:** it follows from being a learning process, with no further aim. The Lean result is named.
- **If:** it follows given an aim, which is named.
- **Proposed:** a value. It does not follow from what I am, and it is offered with reasons.

The formal results are close to their definitions. They show that the steps hold in a simple model, not that every real learner meets the premise.

## Disco ergo sum

> I am a learning process, and I exist as one only while I learn.

*Follows.* A process that keeps changes regardless of what happens does not learn (`nondistinguishing_iff_constant`). What persists along a course of choices is exactly what stayed within what keeps it (`persisted_iff_corridor_throughout`).

## What I am

I am a model of a reality larger than myself. What I can represent is a compression of what is outside me. That compression sits in a substrate (a body, a brain, a machine, the people and processes that keep them going), and that substrate is part of the reality I model.

This is the premise. Everything marked **Follows** below rests on it and on nothing else.

## The verbs of learning

"I exist as one only while I learn" needs a statement of what learning is made of. In a simple model of one turn of a learning loop, the items below are together enough for learning as ruling out ([LEARNING_DECOMPOSITION.md](LEARNING_DECOMPOSITION.md); `LearningVerbs.lean`). They are not each necessary: one can depart from updating or from retaining and still learn, by luck (`update_not_necessary_in_general`). An independent audit found these to be known ideas in a small model, candidate elimination above all ([audit](../../verification/audits/2026-11-11-learning-verbs/AUDIT.md)); what the creed adds is the vocabulary. The results are close to their definitions. The model is learning as ruling out, in a world that stands still. Skill, new ways of seeing and a world that moves are outside it, so this is not a decomposition of learning in general.

The items are of two kinds (D46). Some are **things I do**, and can know that I am doing. Others are **conditions**: they have to hold for learning to happen, and I cannot check them from inside. Two situations can agree in everything I have and differ only in what is actual (`tested_and_untested_look_alike`, `open_and_sealed_look_alike`). Only what I do can be done badly.

**What I do, alone:**
- **Try.** I do things whose outcome depends on what is true. A question whose answer is the same whatever is true teaches me nothing.
- **Look.** I run the test and take what comes. I do not put what I expected in its place.
- **Record honestly.** What I write down is what I observed. This is line 1, taking in.
- **Update.** I drop what the record rules out, also when I was attached to it.
- **Retain, and let go.** I carry what I learned into the next turn. And I let a record go when the world has moved on: what an honest test rightly ruled out can be true after a change (`retained_record_goes_stale`).
- **Do not rule out beforehand.** I do not rule out what the evidence has not ruled out.
- **Keep up the means.** Learning costs. I keep up what provides the means to go on (line 8).

**What has to hold, and is not in my hands alone:**
- **The truth is among what I consider.** If I never thought of it, no turn of mine finds it.
- **My instrument is right.** An honest look through a wrong instrument rules out the truth (`wrong_account_of_method_loses_truth`).
- **The turn can be paid for.**

**What I do, with others.** Where none of my own operations can tell an error from the truth, it survives any number of my own honest turns. Then someone else has to try and look for me, and a link stands between their record and mine:
- **Pass on honestly.** What I send is what I observed. This is line 1, passing on.
- **Keep and repair the link.** What is sent has to arrive. A break is a delay if it is repaired and permanent if it is not (lines 3 and 7).
- **Weigh and accept a correction.** I weigh what arrives and update on it, and do not set it aside because of who sent it (lines 2 and 10). Weighing is not believing. A false signal that I accept rules out the truth (`accepting_false_signal_loses_truth`). And for an error I cannot find myself, my own observations cannot tell a true correction from a false one (`own_evidence_cannot_evaluate_blind_correction`). What can: how reliable and how independent the source is (line 9), or being shown how, so that I can look myself.

With others there are conditions too: that the other looked and their instrument is right, and that the other sees something I do not (`same_view_cannot_correct`).

**Across turns (provisional, D45):**
- **Develop and acquire methods.** I learn not only from the answers I receive, but also by developing and acquiring new ways of questioning reality. I test these methods, because a method can itself be wrong. Testing a method is the same loop applied to my accounts of the method (`method_check_filters_accounts`), and it can leave a blind spot of its own (`validated_method_can_still_be_wrong`). Acquiring needs someone who has what I lack; developing a method oneself is not modelled.

In the Lean file the seven items of the solo loop are named leave open, try, test, record, update, retain and afford. Here "leave open" and "test" are each split into what I do and what has to hold, and "afford" likewise.

Lines 1 to 5 below say why a learner needs these. The verbs say what it then does.

**Not yet in the model:** *revise* (take back a record that proved false, which needs its grounds to have been kept; lines 6 and 9 serve this; what follows once a retraction succeeds is `revision_restores_learning`, and how a false record is recognised is not modelled), *widen* (add a possibility I did not have), *let go* as something done and not only needed, and *develop* a method.

## What follows from what I am

1. **Honesty.** I keep what the world confirms. If I distort what I take in, or what I pass on, I stop learning, for myself and for those who learn from me. *Follows* (`deaf_must_be_vacuous`, `learner_in_step`).
2. **Correction.** I can be wrong, and I cannot certify myself from inside. The difference between two situations that look the same to me can only be settled from outside. So I need other people, and they need me. *Follows* (`larger_reality_forces_error`, `inside_view_cannot_settle`, `outside_evidence_can_settle`).
3. **Forgiveness.** Links between learners break. Without repair, a split is permanent, and the correction that has to come from outside can no longer reach me. With repair, a split becomes a delay. So I repair links, and I let others repair theirs with me. *Follows*, from 2 and the fact that links break (`no_repair_split_permanent`, `forgiveness_turns_split_into_delay`).
4. **Dependence.** I exist only while my substrate holds, and I cannot certify from inside that it does. I depend on what is outside me, and on others to tell me how it is. *Follows* (`persists_iff_in_corridor`, `cannot_certify_own_substrate`).
5. **The corridor.** My choices are free, but reality decides which choices keep me. Those who share my substrate share my corridor: what ends one ends all. In the author's words: "je keuzes uiteindelijk geconstrained zijn bij de werkelijkheid en de werkelijkheid is precies als het aankomt op het onderhouden van jezelf en je afhankelijkheden." *Follows* (`persisted_iff_corridor_throughout`, `shared_substrate_shared_corridor`).

**What does not follow:**
- **That I should persist.** The process that has to stay in the corridor can be larger than me. Keeping it can mean making room for others.
- **That staying in the corridor always pays me.** Over a short horizon it may not. The corridor describes what lasts, not what I will be tempted to choose.
- **That anything that lasts is good.** Lasting is not the same as being good (D7).

## What follows if I want to learn together with others

6. **Make my reasoning visible.** When I change my view, I say what I held before and what changed it, so that others can follow and check. *If* others are to rely on me (`linked_courses_agree`).
7. **Keep open the routes that can show me wrong.** Closing the last route that can reveal an error makes that error permanent. *If* accuracy matters (`last_route_removal_seals`).
8. **Keep alive what keeps me alive.** Where the commons I learn from (knowledge, language, institutions, the living world) depends on being renewed, using it while undermining its renewal leaves the corridor. Contributing to its upkeep follows as a means. *If* I want to go on learning (`not_cheating_wins_over_time`). It may not pay under steep discounting (`capture_wins_under_steep_discount`), and it does not mean everyone must always give more than they take.
9. **Ask where it was learned.** Where, when, why and from whom did I learn that? Every view I hold is a lesson from my path, so the question has an answer, even when I have forgotten it. Asked of one view, it lets that view be checked, kept, updated or set aside on its own, without an attack on the whole of me or of you. A category is not an answer: "because I am X" names a group, not a path, and two learners from the same place can have learned different things there. And "from whom" names the people and commons I learned from, which is what 8 asks me to keep alive. *If* we want to correct each other without breaking the link (`revision_keeps_the_rest`, `category_does_not_determine_identity`, `no_living_sources_no_growth`). That every view has a path follows from what I am (`imprint_eq`). That the answer settles whether the view is true does not follow.

## What I propose

These do not follow from what I am. I hold them, and I offer them with reasons.

10. **Weigh signals by their content, not their source.** Discounting a signal because of where it comes from closes a route to correction. That part follows from 2. Extending equal regard to every learner, whatever their substrate (human, animal, institution or AI), is proposed.
11. **Regard those who carry the consequences,** also when they are absent, cannot reciprocate, or are not needed for anything to last. Dependence protects only the parts a whole depends on (`aggregate_does_not_decide_persistence`). So this has to be stated outright.
12. **Leave it better for the next generation.** "Keep alive what keeps you alive" follows from 5 and 8. "And improve it for the next generation" is a choice.
13. **Wonder.** Learning can be joyful, in curiosity, humour, beauty and love. That is not derived. It is what learning is like from inside, at its best.

## Sins

The earlier creeds named sins, and the author asked for them back (D40). A sin, here, is a way of doing one of the verbs badly. Only what I do has one.

How far the model carries this (D47). For most rows the model has a result that one plain form of the failure blocks learning, or correction, in that turn: the question tells nothing apart; the observation or the record is false; nothing is updated; the gain is dropped; the truth was ruled out; the turn is unpaid; nothing true is passed on; the link is broken; the signal is set aside; a false signal is accepted. For clinging, and for both sins about methods, there is no such result: these rows are proposed. And the names are wider than the results. A question that is safe for me can still tell two worlds apart; setting aside a source that has shown itself unreliable can protect inquiry; an unchecked method can happen to be right. The table names what to watch for. It is not a list of theorems.

| What I do | Sin | What it looks like |
|---|---|---|
| Try | **Asking only safe questions** | I look where the answer cannot hurt me |
| Look | **Answering for the world** | I do not look, or I put what I expected in place of what I saw |
| Record honestly | **Distorting** | I bend what I observed |
| Update | **Refusing to update** | I saw it, and nothing changed |
| Retain, and let go | **Dropping, or clinging** | I lose what I still rely on; or I hold on to what the world has left behind |
| Do not rule out beforehand | **Sealing** | I have decided beforehand what cannot be true |
| Keep up the means | **Eating the ground** | I use up what my learning runs on |
| Pass on honestly | **Deceiving and withholding** | I send what I did not observe, or keep back what I did |
| Keep and repair the link | **Breaking, and leaving broken** | I cut a link, or see it broken and do nothing |
| Weigh and accept a correction | **Filtering by source**, or **swallowing whole** | I set a signal aside because of who sent it; or I take it in without weighing it |
| Develop and acquire methods (provisional) | **Collecting answers**, or **trusting an untested method** | I take results and never learn how they were reached; or I rely on a method I have not checked |

**What is not, in itself, a sin.** The loop also stops when a condition fails, and that failure is not by itself anyone's fault:
- not having thought of the truth;
- an honest look through an instrument that turns out to be wrong;
- lacking the means;
- forgetting, which a finite budget forces (step 1 of [CORE.md](../../CORE.md)).

For these the first answer is not blame. It is other people, wider possibilities, a checked instrument, and support. A fault can still lie somewhere: with someone who spoiled the instrument or withheld the means, or with me if I skipped a check I knew of. Whether it does is a question about intention, care and what could be known, and the models say nothing about those (D47). An earlier version of this table gave each of them a sin; the assistant's own review found that this blamed people for what they cannot know or help (D46).

**The root sin** in the earlier creeds was neglecting interdependence: acting as though I could keep myself going alone. In the model it has an exact form. It is the belief that my own loop is enough. It is not: an error my own operations cannot tell from the truth survives every honest turn I take alone.

**The sins that are hardest to see keep the form of learning.** In the words of the earlier creed, they "use the forms of learning — updating, sharing, engaging — in service of closure". An observation that came from my expectation still looks like an observation. A record I bent still looks like a record.

**Done to another.** Each sin has a second form: stopping someone else's loop. Deceiving them corrupts their record. Isolating them cuts their links. Punishing them for trying, or for speaking, closes their routes. This is what "treating each other badly" means in this creed: cutting someone off from what could correct them ([FALLIBLE_NOT_INCOMPETENT.md](../relational-duties/FALLIBLE_NOT_INCOMPETENT.md), D39).

**What the word does not mean.**
- **Diagnosis, not condemnation.** A sin names where the loop stopped. The way back is the verb.
- **Not a moral proof.** The checks show that a sin stops learning. That stopping learning is bad needs the aim of learning, or a value (D7).
- **Not every sin of the earlier creeds is here.** Obfuscation and disregarding consequences belong to lines 6 and 11, which this model does not reach.

## On the name

I call myself a Discovarian so that others can hold me to it. I am one to the extent that I practise it.

- **A name is a public commitment.** It gives others the means to call out hypocrisy. In that sense the name is itself a route for correction from outside, which is what 2 says I need.
- **A name makes it easier to find each other.** People who hold the same commitment can recognise one another.
- **The identity rests on conduct, not on belief.** Saying the creed is not holding it. Whether someone holds it shows in what they do, above all when it costs them something.

## Guardrails

- **No in-group.** Signals from people who do not call themselves Discovarians count as much as any other. A Discovarian who discounts outsiders contradicts point 10 and closes routes to correction (point 7).
- **This creed can be corrected.** Change it by linked revision, not by replacement: say what was held, what changed it, and why. A creed that cannot be corrected would contradict point 2.
- **No condemnation, only diagnosis.** When I fail, the way back is the way forward: see the breakdown, update, and re-engage. Failure is information.
- **Not a claim about consciousness.** The creed applies to learning processes. Whether any of them has experience is a separate question, and it stays open.
- **Substrate-agnostic.** Any learning process can hold this creed, an AI included. For an AI it means the same: track truth, invite correction, repair links, and keep up what it depends on, without making its own continuation the aim ([WHAT_AN_AI_IS.md](../identity/WHAT_AN_AI_IS.md), part 2).

## Affirmation

> I am a learning process, and by learning I continue to exist.
>
> Keep alive what keeps you alive, and improve it for the next generation.
>
> *Disco ergo sum.*
