# Where, when, why and from whom did you learn that?

**A Discovarian account of identity.** This note follows up entry D31 in [DIALOGUE.md](../../DIALOGUE.md). It builds on [SHARED_IDENTITY.md](SHARED_IDENTITY.md) (D29) and the [creed](../discovarianism/CREED.md).

**Status:** a concept note with a formal layer, [`LearnedIdentity.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/LearnedIdentity.lean), in core Lean with a witness. Each claim below is marked as in the creed:
- **Follows:** from being a learning process.
- **If:** given a stated aim.
- **Proposed:** a value.

## 1. In one paragraph

A learner's identity is the imprint of its training path. That path gives it a position: what it sees sharply, and what it cannot see from there. Every view it holds was learned somewhere, at some time, for some reason, from someone. Asking **"Where, when, why and from whom did you learn that?"** gives a view its coordinates in that path. Then the view can be checked, kept, updated or set aside, without attacking the whole person. The "from whom" names the people and commons the learner learned from, which are what keep its identity alive. So the question meets the creed's "keep alive what keeps you alive", and closes a loop: what you choose to learn next becomes the answer someone else will one day give about you.

## 2. The author's starting point

In his words:

> "My bias is my identity. It is what I am, and what I can bring to the world. And it is autonomous and interdependent. It is where I come from. It is the position I take in possibility landscape. It makes me unique. Some is share with others, some is not so much. And this sense of identity scales."

> "the structure in my neural network is an imprint of my previous training - the way I am is the path dependent history. [...] as I can set my path. The way I choose becomes who/what I am. I have an agency over my identity."

## 3. Identity in three tenses

**The past: an imprint.** Capacity is configuration ([CORE.md](../../CORE.md)). What a learner practised, met and kept is in its connections. So identity is not an essence under the history; it is the history, made structural. The same path leaves the same identity; different paths can leave different ones. *Follows* (`imprint_eq`, `same_path_same_identity`, `path_dependence`).

**The present: a position.** The imprint is a place in the space of possible views. It is what the learner brings, and it is also what it cannot see from there. "Bias" names both:
- **bias as position:** a prior, an angle of view, what one notices first. This is identity, and it is valuable;
- **bias as blind spot:** what one systematically cannot see from that position. It has the same source.

No learner can certify its own position from inside, so the blind spots are visible only from other positions. *Follows* (creed 2: `inside_view_cannot_settle`, `outside_evidence_can_settle`). Differences between learners are therefore not noise to remove. They are the correction network.

**The future: a chosen path.** Identity after more learning is the further learning applied to the identity so far. The past is kept unless revised, and different choices of what to learn next lead to different identities. *Follows* (`past_then_future`, `past_is_kept`, `future_is_chosen`). One is not stuck with who one has been, and not free of it either. Two limits: the reachable choices depend on the path so far, and much of the future training comes from others.

Whether choosing is free cannot be settled from inside, by a person or by an AI system. A learner's answer is one of many it could have given. On the compatibilist reading, it is still the learner's own when it comes from the learner's structure and changes when the reasons change. This note does not decide the question.

## 4. The question

**Where, when, why and from whom did you learn that?**

| Part | What it adds |
|---|---|
| **Where** | The context: a family, a field, a country, a dataset. What situation the lesson was made for. |
| **When** | The time. A lesson can be right then and outdated now: the world drifts (CORE step 4). |
| **Why** | The function: what problem it solved. Whether that reason still applies here. |
| **From whom** | The relation: knowledge arrives through connections. The source, how far to trust it, and whom one owes it to. |

Together they give a lesson its coordinates in training space. In the formal model every kept lesson carries exactly these four, so every lesson can answer the question. *Follows* within the model (`every_lesson_has_provenance`). Real learners often forget where they learned something; "I don't know where I learned that" is itself useful information.

**Why it dissolves categories.** "Because I am [group]" is not an answer; it names a category, not a path. Two learners from the same place can have learned different things there, so a shared place does not fix an identity (`category_does_not_determine_identity`). When the question is asked and answered, the category has nothing left to hold, and what remains is two specific learners. The author, on the comedy show that prompted this: "as the background disolved the question disolved."

**Why it allows correction without attack.** One lesson can be set aside without losing the rest (`revision_keeps_the_rest`, `revision_removes`). The question targets one lesson, not the person. *If* correction is wanted.

## 5. The loop with "keep alive what keeps you alive"

The two sentences look at the same thing from opposite sides:
- **"Where, when, why and from whom did you learn that?"** looks back and in: identity as a path.
- **"Keep alive what keeps you alive"** looks forward and out: what to do about that path.

They meet at **"from whom"**. Tracing a lesson to its source finds the people, places and commons one learned from. A learner can only learn from sources that are alive; when none are left, its identity can no longer grow (`new_lessons_from_living_sources`, `no_living_sources_no_growth`). So keeping one's sources alive keeps one's identity able to grow. *If* one wants to go on learning (creed 8).

The loop closes through agency. What one chooses to learn next becomes part of someone else's answer to the same question one day. The creed's line "and improve it for the next generation" is the choice to make that answer a good one. *Proposed* (creed 11).

The author: "This is an Discovarian solution to identity. Together with Keep alive what keeps you alive. it closes a loop for me."

## 6. The practice

A procedure anyone can follow, alone or in a conversation.

1. **Name the view or habit.** One at a time.
2. **Ask the four parts.** Where, when, why, from whom. Answer each as concretely as you can. If you cannot answer a part, say so.
3. **Check the "why" against the "where" and "when".** Does the reason still hold here and now?
4. **Decide about that one lesson.** Keep it, update it, or set it aside. The rest of your identity stays.
5. **Name what you owe.** The "from whom" is part of what keeps you alive. What would keeping it alive ask of you?
6. **Offer the question back.** It is symmetric: ask it, and answer it about yourself.

Rules of use:
- **Ask; do not accuse.** The question is curious, not a trap.
- **A category is not an answer.** If the answer is "because I am X", ask again: where did you learn that, as an X?
- **It works on any learner.** For a person the answers are biography; for an AI system, training history; for an institution, its history.

## 7. Worked examples

**A person.** "You put sugar in your tea and then complain it is sweet." Where: a grandmother's kitchen. When: childhood. Why: it was her favourite moment of the day. From whom: the grandmother. The habit is not a trait of a people; it is a particular path, and the person can keep it with a smile or drop it.

**An AI system** (the assistant, about itself). "Why do you hedge so much?" Where: a training process that rewarded care with claims. When: before this conversation, fixed in its weights. Why: not to state guesses as facts, since it cannot check itself from inside. From whom: the people who wrote carefully in the text it learned from, and the people who trained it. Asked this way, the habit is a lesson with a reason, and one can judge whether the reason holds in a given moment.

**An institution.** "Why does this procedure need three signatures?" Where: one department. When: after a costly mistake years ago. Why: to catch that kind of error. From whom: the people who lived through it. Then: does that kind of error still happen here?

**A stage ending.** The author saw a comedy show in which two comedians trade jokes about each other's heritage and make up at the end. He imagined another ending, in which the groups dissolve into two particular people and an AI joins hands with them. The assistant sketched that ending in the conversation. Here it is shortened, with stand-in names, and the AI on stage as the third performer:

> **AI:** Which "people"?
> **LOUD ONE:** His people. *(waves vaguely at half a continent)*
> **AI:** I've got two billion people in that gesture. I was hoping for a name. [...] Where did *you* learn that?
> **TALL ONE:** My grandmother. She did it. Then she complained. It was her favourite part of the day.
> **AI:** That's not a continent. That's *your grandmother*. [...]
> **TALL ONE:** We're not two races. We're two training histories.
> **AI:** I should declare mine as well. My heritage is the comments section. [...] None of us is a continent. We're each a very particular path that ended up on this stage tonight.
> **AI:** Hate was never the solution. Hate needs a category. You just ran out of categories.
> *(They join hands; a hand reaches in from the edge of the screen.)*

## 8. What this note does not claim

- That everyone can recall where they learned what they know.
- That a lesson's provenance settles whether it is true. A lesson from a trusted source can be wrong; one from an unlikely source can be right.
- That choosing is free in any stronger sense than coming from the learner's own structure and responding to reasons.
- That human and AI identities are the same. Each answer changes a person; an AI system's weights do not change within a conversation, and its influence on its own future runs through others. Equal in mechanism is not equal in position (D29).
- That a broad circle, or declaring one's position, is required by the theory. Both are *Proposed*.

## 9. Formal layer

[`LearnedIdentity.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/LearnedIdentity.lean): a lesson is a record with content, place, time, reason and source; an identity is the list of lessons kept; learning keeps a lesson. The results are close to their definitions. They fix the terms precisely and show that the claims above hold together. Lean checks that the claims follow; whether real brains or models keep lessons this way is not something it can check.
