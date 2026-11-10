# A decomposition of learning into verbs

**Status:** a concept note with a small formal model, 10 November 2026 (D40 in [DIALOGUE.md](../../DIALOGUE.md)). It follows the author's remark that the [creed](CREED.md) "is like a decomposition of learning. Learning happens when you obey these verbs - and vice versa", and the assistant's reply that the creed covers one direction only. The model was checked with Z3 at the author's request. The repository's standard is Lean; nothing here is in CI.

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

`python3 z3/decomposition.py` with the `z3-solver` package (run here with version 5.4.0 as reported by the package). The script is [z3/decomposition.py](z3/decomposition.py). It prints 44 checks; [z3/results.txt](z3/results.txt) is the output of the run behind this note. Each "holds" is an unsatisfiable negation, for any number of worlds and outcomes, except A4 and B4, which are checked for the sizes given.

## 8. Open

- A Lean port of A1, B1 and B2, so that the results sit under the repository's CI.
- A model with "revise" and "widen", to see whether nine becomes eleven.
- A reader outside this model family (working agreement 7).
