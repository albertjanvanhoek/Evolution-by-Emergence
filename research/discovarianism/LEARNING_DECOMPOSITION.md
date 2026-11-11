# A decomposition of learning into verbs

**Status:** a concept note with a small formal model, 10 November 2026 (D40 in [DIALOGUE.md](../../DIALOGUE.md)). It follows the author's remark that the [creed](CREED.md) "is like a decomposition of learning. Learning happens when you obey these verbs - and vice versa", and the assistant's reply that the creed covers one direction only. The model was first checked with Z3 at the author's request, and then ported to Lean, also at his request: [`LearningVerbs.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/LearningVerbs.lean), 35 theorems in core Lean, in the repository's CI. Section 7 says which checks are in which.

## 1. The claim

In a simple model of one turn of a learning loop, seven verbs are together enough for learning, and each one is needed. Where a learner's own operations cannot tell an error from the truth, a second set of seven verbs, between two learners, removes the error, and each of those is needed too. The creed's lines are the second set. The first set is what the creed does not yet say.

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

The author's claim: "for me collaboration is just too brains doing what brains do - so it is the same". Tested in [`LongCollaboration.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/LongCollaboration.lean), 28 theorems in core Lean.

**The model.** Two learners. In each turn each has an error it cannot find alone and the other can. A learner is corrected in a turn exactly when the seven verbs between learners hold in its direction. Staying in costs one unit per turn, and being corrected pays for the turn. Each starts with a reserve and is out when it reaches zero.

**Results.**
- **All verbs, from both, and it lasts.** If both do all seven verbs in every turn, nothing changes from turn to turn (`all_verbs_last`).
- **One verb missing on either side, and it ends.** Both are out after as many turns as their two reserves together (`ends_within_reserves`). So the collaboration lasts for every number of turns exactly when both do all seven (`lasts_iff_all_verbs`).
- **Taking without giving runs on the other's reserve.** A learner who does everything except test and pass on is itself corrected, in turn n, exactly while n is below the other's reserve (`taker_corrected_only_while_other_lasts`).
- **A reserve turns a lapse into a cost.** With a reserve of two each, one turn of any conduct does not end it (`one_lapse_survivable`).
- **The two have to differ.** If the other's operation does not tell the wrong world from the actual one either, all seven verbs leave the error in place (`same_view_cannot_correct`, in `LearningVerbs.lean`).

**What this says about the claim.** It holds for the verbs: no new verb is needed. Three things change, and none of them is a verb of one brain.
1. **The verbs become mutual.** In one exchange, my own testing and passing on are not needed for my own correction; only the other's are. In a lasting collaboration they are needed for mine too, because they are what keeps the other in. This is the step from "honesty helps the other" to "honesty keeps what corrects me alive" (creed, line 8).
2. **Difference is a condition.** Two learners who see the same cannot correct each other. This is a property of the pair, not something either one does in a turn (D35, conjecture 4).
3. **Reserve is a condition.** Without slack, the first lapse ends it. With slack, a lapse is paid for and repair is possible (creed, line 3).

**How much this says.**
- **The budget rule is strong.** Being corrected by the other is each learner's only income, and it exactly pays for one turn. With other income, or a partner to switch to, a learner can last without the other, and these results do not apply. Between a person and an AI system this matters: the person can switch, so the pair is closed in one direction at most ([relational duties](../relational-duties/README.md), "Positions differ").
- **The results are close to that rule.**
- **Conduct is the same in every turn,** except in the lapse result.
- **A fresh error each turn is assumed.** In a fixed space the exchange runs out (A4).
- **"Corrected" is linked to section 4 by reading.** It is defined as the conjunction that `seven_verbs_correct` proves sufficient; the module does not import it.

## 10. The loop on the vortex ledger (D42)

A review of [CORE.md](../../CORE.md) found that its two lines meet at one word. Steps 1 to 7 are a ledger (slack, selection, the vortex); step 8 is the Room (a fallible model that needs correction). They meet at feedback, which the vortex speed counts as a fraction, "validated", and step 4 takes as given. [`LearningVortex.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/LearningVortex.lean) (24 theorems, core Lean) puts the loop of section 3 on the ledger of step 1.

**The model.** A learner holds a reserve. Each wrong world it keeps possible costs one unit per turn: misfit costs slack, the premise of step 4. It takes up a fixed amount per turn, and a try costs something. Some errors its own operations can tell apart; some they cannot.

**1. The loop pays for its own next turn.** A learning turn removes one wrong world and so raises slack by one, for good (`learning_turn_raises_slack`). A learner whose reserve covers the way down is viable in every turn (`loop_closes`); a sealed one, from the same start with misfit above uptake, runs out (`efficiency_buys_duration`). In section 3 "afford" was given from outside. Here it is paid from the reserve, and each turn's gain lowers the cost of all later turns.

**2. The speed has a sign.** The vortex speed is a product of fractions, so its worst case is zero. The verbs show a worse one. A try whose record is false and is retained:
- looks the same from inside as a learning turn, one fewer world kept possible (`false_and_true_turn_look_alike`);
- lowers slack (`false_turn_lowers_slack`), and is worse than discarding the try (`retaining_false_is_worse_than_discarding`);
- stops all later learning, although every verb is done from then on (`after_false_turn_no_learning`, `retained_false_record_fails`);
- is undone by taking the record back (`revision_restores_learning`). This is a first form of the candidate verb *revise*.

**3. The speed has two terms.** Alone, the errors the learner cannot tell apart stay, however much it tries (`solo_keeps_blind`), and if they cost more than its uptake it runs out although it does all seven verbs (`solo_fails_on_blind_spot`). A link to the same view adds nothing (`same_view_is_solo`). A link to a different view removes them (`errors_removed_two_terms`, `link_decides`).

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
- **A ratchet, not yet a vortex.** The space is fixed, so the loop closes and then stops. A vortex needs kept changes that also widen what can be tried, which is not modelled. The vortex has widening and no truth; the verbs have truth and no widening.
- **The setting carries the results.** Every kept error costs the same, in every turn. Where misfit is free, or someone else pays for it, a sealed learner lasts; step 4 says so.
- **`need` ignores uptake,** so the reserve condition is sufficient and not necessary.
- **The link is free and cannot break** here; `LongCollaboration` and `Reciprocity` treat that.
- **The kinds of turn are linked to the verbs by reading,** not by import.

## 11. What is new here and what restates earlier results

Noticed in the review of D42, after sections 4 and 9 were written.
- **New:** the solo loop of section 3 (seven verbs, each needed, each failure possible), and section 10.
- **Restated in one small model:** the blind spot (`ModelOfLargerReality.inside_view_cannot_settle`), repair as delay (`Persistence.forgiveness_turns_split_into_delay`), and the need for a different view (the two-learner form of `hub_determined_network_inherits_blind_spot`).
- **Largely a restatement:** section 9 is `Reciprocity` with the exchanged good named as correction. `Reciprocity` is the richer model, because giving costs there, so defection pays at first. In section 9 giving is free.

