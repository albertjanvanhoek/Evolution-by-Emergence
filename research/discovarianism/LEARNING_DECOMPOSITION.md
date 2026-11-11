# A decomposition of learning into verbs

**Status:** a concept note with a small formal model, 10 November 2026 (D40 in [DIALOGUE.md](../../DIALOGUE.md)). It follows the author's remark that the [creed](CREED.md) "is like a decomposition of learning. Learning happens when you obey these verbs - and vice versa", and the assistant's reply that the creed covers one direction only. The model was first checked with Z3 at the author's request, and then ported to Lean, also at his request: [`LearningVerbs.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/LearningVerbs.lean), 55 theorems in core Lean, in the repository's CI. Section 7 says which checks are in which.

## 1. The claim

In a simple model of one turn of a learning loop, seven verbs are together enough for learning, and each one is needed. Learning here means ruling out: the claim is about the components of successful elimination-based learning in this model, not about learning in general (section 6). Where a learner's own operations cannot tell an error from the truth, a second set of seven verbs, between two learners, removes the error, and each of those is needed too. The creed's lines are the second set. The first set is what the creed does not yet say.

## 2. The model

A learner keeps a set of worlds possible. One of them is the actual world. In one turn the learner picks an operation, which yields an outcome in each world; it observes an outcome, records it, and keeps the worlds that agree with the record. What it carries into the next turn is the result, if the turn is paid for.

**Learning in one turn** means: nothing new is assumed, the actual world is still kept possible, and at least one world that was kept possible is ruled out.

This is learning as ruling out. Section 6 says what that leaves out.

## 3. The loop, alone: seven verbs

| Verb | In the model | When it fails |
|---|---|---|
| **Leave open** | the actual world is among those kept possible | the truth was ruled out beforehand, and no turn brings it back |
| **Try** | the operation yields different outcomes in at least two worlds kept possible | the outcome was the same whatever is true, so nothing is ruled out |
| **Test** | what is observed is what the operation yields in the actual world | the observation came from somewhere other than the world |
| **Record** | what is recorded is what was observed | the record is distorted |
| **Update** | keep the worlds that agree with the record | the record changes nothing |
| **Retain** | carry the result forward | what was gained is dropped |
| **Afford** | the turn is paid for | the old state is carried forward instead |

**Checked (A1 to A3).** The seven together guarantee learning in that turn. They can hold together. For each one, with the other six in place, its failure blocks learning in every case, and that failure is possible.

**Actions and conditions (D43, D46).** The seven are not all of one kind. *Try, record, update* and *retain* are things the learner does and can know it is doing. *Test* and *leave open* are defined by the actual world, which the learner does not know: two turns can agree in everything the learner has and differ only in which world is actual, one learning and the other losing the truth (`tested_and_untested_look_alike`), one open and the other sealed (`open_and_sealed_look_alike`). So these two are conditions of success. Each has a part the learner does (looking and not substituting what it expected; not ruling out beforehand) and a part it cannot check (that the instrument is right; that the truth is among what it considers). *Afford* is a condition too, and is needed by construction, because retention is defined so that an unpaid turn carries the old state forward. The creed's sins follow this split: only what is done has one.

**Saturation (A4).** In a fixed space of N worlds the seven verbs can hold for N − 1 turns in a row and never for N: after that there is nothing left to try. Checked for N = 2 to 5. This is step 7 of [CORE.md](../../CORE.md) in small: a fixed finite space saturates.

## 4. The blind spot, and seven verbs between learners

**Checked (B1).** If none of a learner's own operations yields a different outcome in a wrong world than in the actual one, that wrong world survives any number of its own honest turns. Trying harder alone does not help; the loop of section 3 has no "try" available for it. This restates the creed's line 2 (`inside_view_cannot_settle`).

Suppose another learner has an operation that does tell the two apart.

| Verb | In the model | Creed |
|---|---|---|
| **The other tests** | their observation comes from the world | (their own loop) |
| **The other passes on honestly** | what they send is what they observed | line 1 |
| **Keep the link** | what is sent arrives | lines 3 and 7 |
| **Take in honestly** | what I record is what arrived | line 1 |
| **Accept the correction** | I update on it, and do not set it aside | lines 2 and 10 |
| **Leave open** | the truth is still among what I keep possible | line 7, in part |
| **Retain** | I carry the result forward | not stated |

**Checked (B2, B3).** The seven together remove the blind spot. Each is needed, in the same sense as above.

**What this assumes, and what it does not show (D43).** The result assumes that the other has an operation that tells the two worlds apart, observes correctly and passes on faithfully. It does not show that accepting a correction is beneficial in general. Two results say how it can go wrong:
- **A false signal that is accepted rules out the truth** (`accepting_false_signal_loses_truth`). The receiver ends worse off than before.
- **For a blind spot, the receiver cannot evaluate the correction from its own evidence** (`own_evidence_cannot_evaluate_blind_correction`). Any rule that judges a signal from the receiver's own observations gives the same verdict in the actual world and in the wrong world it cannot tell apart. So a rule that accepts the signal where it is true accepts it where it is false.

So receiving a claim, weighing it and updating on it are three operations, and the model has only the first and the last. Where the claim can be tested with one's own operations, it can be weighed by its content. Where it cannot, which is the case a blind spot is, the receiver's own observations do not help. Two things can: information about the source (its record, its independence, whether independent sources agree), and being shown how, so that the receiver can look for itself (section 13). An earlier wording here said that information about the source is all that is left; the assistant's own review corrected that (D46).

**Repair (B4).** Over several turns, with the other six verbs in place, the error is gone at the end exactly when the link held in at least one turn. A break is a delay if it is repaired and permanent if it is not. Checked for 2 to 4 turns. This restates line 3 (`forgiveness_turns_split_into_delay`).

**So the two sets are one loop.** Between learners, "try" and "test" are done by someone else, and a link stands between their record and mine. Merged, there are nine verbs: leave open, try, test, record honestly, pass on honestly, keep and repair the link, update, retain, afford.

## 5. What this says about the creed

- **Covered:** honesty in taking in and in passing on (line 1), accepting correction (2, 10), repair (3), keeping routes (7). Line 8, keeping alive what keeps you alive, is the commons side of "afford".
- **Not stated in the creed:** try, test, update and retain. These are what a learner does itself. Line 13, wonder, is the wish to try, and is marked there as not derived.
- **In the creed and not in this model:** making reasoning visible (6), asking where it was learned (9), regard for those who carry the consequences (11), the next generation (12). The first two serve revision, which the model lacks (section 6). The last two are values.

The author's "vice versa" therefore holds for the nine verbs, in this model. It did not hold for the creed as it stood on 16 October. The author asked for the creed to be updated (D40): it now has a section "The verbs of learning" and a section "Sins", one sin for each verb.

## 6. How much this says

- **It is close to its definitions.** The one step of argument in A1 is this: if two worlds kept possible yield different outcomes, at least one of them differs from the actual world, and an honest record of a real test rules it out. The rest is bookkeeping. As elsewhere in the repository, the substance is in the modelling choices and in the mapping to real learners, which a solver cannot check.
- **"Needed" has a precise sense.** With the other six verbs in place, the failure of one blocks learning in that turn. It does not say that two failures cannot cancel. A wrong observation wrongly recorded can land on the truth by luck.
- **"Update" and "retain" fail in one plain way** in the checks (nothing changes; the gain is dropped), not in every way they could.
- **A modelling error found on the way.** In a first version an unpaid turn changed nothing, as a separate rule. The check "the failure is possible" then came back negative for "afford": the other six verbs could not hold in an unpaid turn at all. So "afford" was a precondition of the others and not a verb beside them, and its "needed" result was empty. The cost is now tied to retention. Every "blocks learning" check is paired with a "this case is possible" check for this reason.
- **A decomposition is not unique.** A coarser model would give fewer verbs and a finer one more. "Complete" means complete for this model.

**What the model leaves out:**
- **Revision.** A false record can rule out the truth. Getting it back needs the grounds to have been kept (`retracting_false_evidence_recovers`). "Revise" is a candidate verb, and creed lines 6 and 9 serve it.
- **Widening.** A4 shows the loop running out. Adding a possibility the learner did not have is a different operation, as CORE says of credences. "Widen" is a candidate verb.
- **Forgetting.** A finite budget cannot keep everything (step 1 of CORE).
- **Noise and degrees of belief.** Outcomes here are exact.
- **Choosing what to try.** The model asks only that the operation discriminates, not that it is a good choice.
- **Learning that is not ruling out:** skill, perception, a new way of representing. The model is about a world model in the narrow sense.

## 7. Reproduce

**Lean.** [`LearningVerbs.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/LearningVerbs.lean) proves, for worlds and outcomes of any type: the seven verbs give learning (`seven_verbs_learn`); each failure blocks it (`sealed_blocks` to `unpaid_blocks`) and can occur with the other six in place (`sealed_possible` to `unpaid_possible`); the blind spot survives (`blind_spot_survives`); the seven verbs between learners remove it (`seven_verbs_correct`), each is needed and each failure can occur; and over any number of turns the error survives exactly when the link held in no turn (`error_survives_iff_never_linked`, which the solver checked for 2 to 4 turns only). `seven_verbs_learn` uses classical logic for one case split; the "blocks" results use no axioms. **Not in Lean:** saturation (A4), which rests on the solver for N = 2 to 5.

**Z3.** `python3 z3/decomposition.py` with the `z3-solver` package (run here with version 5.4.0 as reported by the package). The script is [z3/decomposition.py](z3/decomposition.py). It prints 44 checks; [z3/results.txt](z3/results.txt) is the output of the run behind this note. Each "holds" is an unsatisfiable negation, for any number of worlds and outcomes, except A4 and B4, which are checked for the sizes given.

## 8. Open

- Saturation (A4) in Lean, for any finite number of worlds.
- Whether these results belong in the core. They are outside it now.
- A model with "revise" and "widen", to see whether nine becomes eleven.
- A reader outside this model family (working agreement 7).

## 9. A long collaboration (added later the same day, D41)

The author's claim: "for me collaboration is just too brains doing what brains do - so it is the same". Tested in [`LongCollaboration.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/LongCollaboration.lean), 31 theorems in core Lean.

**The model.** Two learners. In each turn each has an error it cannot find alone and the other can. A learner is corrected in a turn exactly when the seven verbs between learners hold in its direction. Staying in costs one unit per turn, and being corrected pays for the turn. Each starts with a reserve and is out when it reaches zero.

**Results.**
- **All verbs, from both, and it lasts.** If both do all seven verbs in every turn, nothing changes from turn to turn (`all_verbs_last`).
- **One verb missing on either side, and it ends.** Both are out after as many turns as their two reserves together (`ends_within_reserves`). So the collaboration lasts for every number of turns exactly when both do all seven (`lasts_iff_all_verbs`).
- **Taking without giving runs on the other's reserve.** A learner who does everything except test and pass on is itself corrected, in turn n, exactly while n is below the other's reserve (`taker_corrected_only_while_other_lasts`).
- **A reserve turns a lapse into a cost.** With a reserve of two each, one turn of any conduct does not end it (`one_lapse_survivable`).
- **The two have to differ.** If the other's operation does not tell the wrong world from the actual one either, all seven verbs leave the error in place (`same_view_cannot_correct`, in `LearningVerbs.lean`).

**What this says about the claim.** It holds for the verbs: no new verb is needed. Three things change, and none of them is a verb of one brain.
1. **The verbs become mutual.** In one exchange, my own testing and passing on are not needed for my own correction; only the other's are. In a lasting collaboration they are needed for mine too, because they are what keeps the other in. This is the step from "honesty helps the other" to "honesty keeps what corrects me alive" (creed, line 8).
2. **Difference is a condition.** Two learners who see the same cannot correct each other's blind spots (`same_view_cannot_correct`). They can still catch each other's failures to look or to record honestly (section 13). This is a property of the pair, not something either one does in a turn (D35, conjecture 4).
3. **Reserve is a condition.** Without slack, the first lapse ends it. With slack, a lapse is paid for and repair is possible (creed, line 3).

**How much this says.**
- **Lasting is not succeeding.** "Long" here means that mutual correction goes on. A collaboration can last and achieve little, or end having done what it was for.
- **The results sit on a knife-edge (D46).** They take being corrected to pay exactly one turn's cost. With a gain `g` and a cost `c`: if `g < c` the collaboration ends whatever the two do, even with all seven verbs (`gain_below_cost_ends`); if `c ≤ g` it lasts with all seven (`gain_at_least_cost_lasts`). That a missing verb still ends it when `c < g` is not proved.
- **The budget rule is strong.** Being corrected by the other is each learner's only income, and it exactly pays for one turn. With other income, or a partner to switch to, a learner can last without the other, and these results do not apply. Between a person and an AI system this matters: the person can switch, so the pair is closed in one direction at most ([relational duties](../relational-duties/README.md), "Positions differ").
- **The results are close to that rule.**
- **Conduct is the same in every turn,** except in the lapse result.
- **A fresh error each turn is assumed.** In a fixed space the exchange runs out (A4).
- **"Corrected" is linked to section 4 by reading.** It is defined as the conjunction that `seven_verbs_correct` proves sufficient; the module does not import it.

## 10. The loop on the vortex ledger (D42)

A review of [CORE.md](../../CORE.md) found that its two lines meet at one word. Steps 1 to 7 are a ledger (slack, selection, the vortex); step 8 is the Room (a fallible model that needs correction). They meet at feedback, which the vortex speed counts as a fraction, "validated", and step 4 takes as given. [`LearningRatchet.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/LearningRatchet.lean) (32 theorems, core Lean) puts the loop of section 3 on the ledger of step 1.

**The model.** A learner holds a reserve. Each wrong world it keeps possible costs one unit per turn: misfit costs slack, the premise of step 4. It takes up a fixed amount per turn, and a try costs something. Some errors its own operations can tell apart; some they cannot.

**1. The loop pays for its own next turn.** A learning turn removes one wrong world and so raises slack by one, for good (`learning_turn_raises_slack`). A learner whose reserve covers the way down is viable in every turn (`loop_closes`); a sealed one, from the same start with misfit above uptake, runs out (`efficiency_buys_duration`). In section 3 "afford" was given from outside. Here it is paid from the reserve, and each turn's gain lowers the cost of all later turns.

**2. The speed has a sign.** The vortex speed is a product of fractions, so its worst case is zero. The verbs show a worse one. A try whose record is false and is retained:
- cannot be told from a learning turn from inside: the learner does the same thing in both, and nothing it has shows which world is actual (`tested_and_untested_look_alike`). An earlier version proved this with a count that was defined to make it true (D46);
- changes slack by what the wrong worlds it happened to remove were costing, minus what the lost world costs (`false_turn_slack`). It lowers slack whenever the second is larger (`false_turn_lowers_slack`), and is then worse than discarding the try (`retaining_false_is_worse_than_discarding`). How many wrong worlds a false record removes depends on what it happened to say; the model leaves that open;
- excludes the actual world, so the learner no longer leaves the truth open and is no longer doing all seven verbs. In this model later tries cannot restore learning without revision (`after_false_turn_no_learning`);
- ends in an empty reserve if the misfit it leaves exceeds the uptake (`retained_false_record_fails`). The condition is needed: a wrong model with enough uptake lasts;
- is recovered from once a retraction succeeds (`revision_restores_learning`). The model restores the truth by definition; how a false record is recognised and taken back is not modelled, so this is not yet an account of the verb *revise*.

**3. The speed has two terms.** Alone, the errors the learner cannot tell apart stay, however much it tries (`solo_keeps_blind`), and if they cost more than its uptake it runs out although it does all seven verbs (`solo_fails_on_blind_spot`). A link to the same view adds nothing (`same_view_is_solo`). A link to a different view removes them (`errors_removed_two_terms`, `link_decides`), in the same turn as the learner's own (`both_terms_in_one_turn`). In an earlier version the two terms could never be active in one turn, so it was a case split and not a sum (D46).

**How the verbs map onto the factors of the vortex speed.**

| Factor | Verb |
|---|---|
| opportunity | none: the world's side |
| generate | try |
| affordable | afford |
| validated | test and record honestly; between learners, the exchange verbs |
| retained | retain |
| gain | update |
| (not a factor) | leave open |
| second-order click | not a verb here: *widen* |

**How much this says.**
- **A ratchet, not yet a vortex.** The module was first named `LearningVortex` and was renamed after an outside review (D43). The space is fixed, so the loop closes and then stops. A vortex needs kept changes that also widen what can be tried, which is not modelled. The vortex has widening and no truth; the verbs have truth and no widening.
- **The setting carries the results.** Every kept error costs the same, in every turn. Where misfit is free, or someone else pays for it, a sealed learner lasts; step 4 says so.
- **`need` ignores uptake,** so the reserve condition is sufficient and not necessary.
- **The link is free and cannot break** here; `LongCollaboration` and `Reciprocity` treat that.
- **The kinds of turn are linked to the verbs by reading,** not by import.

## 11. What is new here and what restates earlier results

Noticed in the review of D42, after sections 4 and 9 were written.
- **New:** the solo loop of section 3 (seven verbs, each needed, each failure possible), and section 10.
- **Restated in one small model:** the blind spot (`ModelOfLargerReality.inside_view_cannot_settle`), repair as delay (`Persistence.forgiveness_turns_split_into_delay`), and the need for a different view (the two-learner form of `hub_determined_network_inherits_blind_spot`).
- **Largely a restatement:** section 9 is `Reciprocity` with the exchanged good named as correction. `Reciprocity` is the richer model, because giving costs there, so defection pays at first. In section 9 giving is free.

## 12. An outside review (D43)

On 11 November the author supplied a review of this work by an assistant from another model family. It found no failed proof and several places where the prose said more than the proofs. What changed:
- **Section 10, point 2** was overstated twice and is corrected: after a false record the learner no longer does all seven verbs, and running out of reserve needs the stated inequality.
- **Revision** is now described as recovery given a successful retraction.
- **The module** `LearningVortex` is renamed `LearningRatchet`.
- **Afford** is marked as a condition that holds by construction (section 3).
- **Correction** is no longer presented as safe: section 4 states what it assumes, and two new results say how it fails.
- **"Learning"** is said to mean elimination-based learning in this model, here and in the creed.

**The question the review puts back.** In its words: "When does receiving information from another intelligence improve our access to reality, and when does it instead make our world model worse?" This note does not answer it. The pieces the repository has are `listening_pays_iff` and `misleading_feedback_does_not_pay` (`ListeningCost`), the interval of connection between isolation and conformity (`correcting_levels_form_interval`), and the two results of section 4. What is missing is a model in which corrections can be wrong, cost something, and are checked against independent sources.

## 13. Being told and being taught (D44)

The author's aim: "The verbs of learning are meant to be the best description on how learning works". A note he supplied from an assistant of another model family asked whether the decomposition is still complete when a learner can change its own learning operations. In this model it is not: a learner's operations are fixed, which is why its blind spot is fixed. This section adds the smallest step beyond that.

**The distinction.** Through a link a learner can receive two different things.
- **A result** (being told): "it is not that world". For a blind spot the receiver cannot check it (section 4), and if it is false and accepted the truth is lost.
- **An operation** (being taught): a way of asking the world that the learner did not have. The learner then tests for itself.

**Checked, in `LearningVerbs.lean`.**
- **Honest own testing never rules out the truth, whatever the operation** (`own_test_keeps_truth`). A useless operation rules nothing out; it costs the try and no more. Compare `accepting_false_signal_loses_truth`.
- **If the operation tells the error from the truth, an own test removes it** (`own_test_removes_error`). No one else's honesty is needed.
- **Acquiring such an operation ends the blindness** (`acquired_operation_opens_blind_spot`), and the learner's own evidence now separates the two worlds (`after_acquiring_observations_differ`).
- **Teaching removes a difference in methods** (`after_acquiring_other_adds_nothing`). Whatever is still blind to the learner afterwards, the teacher's operation does not tell apart either. That is all the result says. An earlier wording here went on to claim that two learners who have taught each other everything cannot correct each other. That was too strong, and was corrected by an outside reader and the author (D45): differences in evidence, implementation and experience remain. Two laboratories with the same method still catch each other's errors.
- **The same method, run twice, still corrects.** If two learners run the same operation in the same world and both test and record honestly, their records agree (`same_method_honest_records_agree`). So a disagreement shows that at least one of them failed (`same_method_disagreement_reveals_failure`). Agreement proves nothing if both failed alike (`agreement_is_not_proof`), which is why the second execution has to be independent.

**Checked, on the ledger, in `LearningRatchet.lean`.**
- **Acquiring needs a source with a different view.** From the same view there is nothing to acquire (`acquire_from_same_view_gains_nothing`). In an earlier version a learner could acquire from nobody, and so remove its own blind spot for a fee (D46).
- **Acquiring removes no error,** so misfit and slack are unchanged in that turn (`acquire_no_first_order_gain`). What changes is what the learner can find by itself (`acquire_widens`).
- **After it the learner clears its errors alone** (`taught_clears_all_alone`) and, with enough reserve, lasts without any link (`taught_lasts_alone`).
- **A learner that was only told, and is then cut off,** keeps the errors it had not yet been told about, and fails if they cost more than its uptake (`cut_off_after_telling_fails`).

**What this adds to the description of learning.** A tenth verb, provisional: *develop and acquire methods* (the name is from D45; a learner can also develop a method itself, which is not modelled). In its first form here it is *acquire an operation*. It is the verb *widen* applied to what can be tried, and the smallest case of the second-order click of step 5 of [CORE.md](../../CORE.md): a kept change whose gain is in what later turns can do. It also gives one part of an answer to the question of section 12. A claim about one's blind spot has to be taken on the reliability of its source. A method can be checked by using it.

**How much this says.**
- **An instance, not a new principle.** `new_parent_set_implies_secondOrderClick` states the second-order click in general.
- **The account of the operation is assumed right** in the results above. A method can itself be wrong; section 14 treats that.
- **Acquiring converts all blind errors at once** in the ledger model. One operation for one class of error would be closer.
- **In this model being taught costs more than being told:** the cost of acquiring, and one more turn of misfit. What it buys is independence from the link and from the teller's honesty.
- **A first-order picture of a second-order thing.** The learner's step rule is fixed and a counter changes. A learner that rewrites how it tries, tests and keeps is not modelled.
- **The loop still closes.** The set of errors is fixed, so this is still a ratchet.
- **Shared methods and remaining difference.** Teaching makes two learners alike in method. It does not make them alike in evidence or in execution, so cooperation can raise shared capability without removing what lets them correct each other. What the model does not have is noise, samples or unequal experience; the only remaining difference it can show is in whether each one tests and records honestly.

## 14. The same verbs, one level up (D45)

The question, from the outside reader and endorsed by the author: can learning at a higher level be described by the same verbs applied again, without a new mechanism at each level? For one level up, in this model, yes.

**A method can be wrong.** The learner works with an account of its operation: which outcome each world would give. If the account is wrong for the actual world, an honest record of a real test rules out the truth (`wrong_account_of_method_loses_truth`). So `own_test_keeps_truth` holds only for a method whose account is right.

**Checking a method is a learning turn.** Take the candidate accounts of the method as the "worlds", the true account as the actual one, and "apply the account to a case whose answer is known" as the operation. This is a turn of the loop of section 3, with nothing added: the model never said what a world is. With the verbs in place, the true account is kept and every account that mispredicts the known case is ruled out (`method_validation_is_a_learning_turn`).

**And it has its own blind spot.** A wrong account that agrees with the true one on the known case survives the check (`validated_method_can_still_be_wrong`). A method validated on the cases one knows can still be wrong on the others. This is `blind_spot_survives` one level up, and it is the old problem of induction in small.

**What follows.**
- **The levels are a factoring, and may be an artefact (D46).** Checking a method on a known case presupposes known cases. Without them, a surprising outcome does not say whether the view of the world or the account of the method is wrong: on the joint space of the two, the pair that was held is ruled out, and a pair that changes only the world and a pair that changes only the account both survive (`surprise_does_not_say_which`). The joint space needs nothing added to the loop either. So "the same verbs at every level" may be better put as: one loop, on a space that can sometimes be factored.
- **The levels have one form.** First order: change what I hold possible about the world. Second order: change what I hold possible about my methods. The verbs are the same; what changes is what they are applied to. Whether this continues upward is a matter of applying the same construction again, and nothing in it depends on the level.
- **No level is certain.** Each level's check leaves a blind spot that only a further case, or another learner, can reach. The regress does not end in a proof. The repository's answer to where it ends is in `ActingUnderTime`: when a decision has to be made.
- **It is a description of form, not of a working learner.** That a real learner's higher-order learning runs on the same operations is a claim about brains and models, which Lean does not check. And the results say nothing about how a learner comes up with candidate accounts in the first place: *develop* is still not modelled.

**Definitions proposed in D45, not theorems.** Intelligence: the capacity of a network-organized process to use information from interactions with reality to adapt its internal organization and behaviour. Recursive intelligence: the capacity of such a process to also modify the operations through which it learns, evaluates information and adapts. In the terms of this note, the learner of sections 3 and 4 has the first; sections 13 and 14 are a first form of the second.

## 15. The assistant's own adversarial review (D46)

At the author's request the assistant reviewed this work against itself, and tested the sharper objections in Lean before accepting them.

**Three problems with the framing.**
1. **Two of the seven "verbs" are not things a learner can do or check.** Now section 3, "Actions and conditions", and the recast creed.
2. **The model's world stands still.** The theory's premise is a world that changes. In the model retaining is always good; in a world that moves, what was rightly ruled out can become true (`retained_record_goes_stale`). There is no verb here for letting a record go, and forgetting, which step 1 of [CORE.md](../../CORE.md) says is forced, is not modelled.
3. **The levels may be an artefact.** Now in section 14.

**Six errors, corrected.** The two terms of the speed could not both be active; acquiring needed no source; "information about the source is all that is left"; the look-alike result rested on a count defined to make it true; the collaboration result sits on a knife-edge, now stated; three results had no witness, now added (`method_validation_witness`, `wrong_account_witness`).

**Not corrected, because it is not the assistant's to do alone.**
- **No literature check.** None of sections 1 to 14 has been compared with prior work. Learning as ruling out is close to version spaces; the blind spot to identifiability; the joint space to the Duhem–Quine problem; told and taught to testimony and demonstration. These names are from memory and unverified. A brief for an independent audit is in [verification/audits/2026-11-11-learning-verbs/BRIEF.md](../../verification/audits/2026-11-11-learning-verbs/BRIEF.md). Until it is done, nothing here should be presented as new.
- **A world that moves, and letting go,** need a model, not a sentence.
- **Pace.** This note grew by fifteen sections in two days, and its summaries overstated three times before a reader caught them. It should be read as a working note.

