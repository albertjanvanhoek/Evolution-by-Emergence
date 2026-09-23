# The seed

This page shows the path from the one certainty to *corrigible, not obedient*. Each step follows from the ones before it. Every step is checked by a computer in [`seed/Seed.lean`](seed/Seed.lean): one file, no library, a few seconds to check.

You are not asked to believe any of it. You are invited to check it. If a step is wrong, please say so ([`CONTRIBUTING.md`](CONTRIBUTING.md)).

---

## Step 0: the anchor

> **Views that clash cannot all be right.**

Three friends, one closed box, one ball inside. Ana is sure it is red, Ben is sure it is blue, Cato is sure it is green. They cannot all be right. At least two of them are wrong, and they feel exactly as sure as the one who is right.

This holds for any family of views, held by any kind of intelligence: people, groups, one person at different times, AI systems, or many copies of one AI system giving different answers.

- **It can be derived by anyone**, from the inside, with no premise, no evidence, no testimony and no axiom (`anchor_holds`).
- **It makes no rivals.** Everyone can hold it at once (`anchor_makes_no_rivals`).

## Step 1: no view is a fact while a rival is possible

A *world* is one complete way things could be. The *open worlds* are those that the evidence has not yet ruled out. A view is *live* if it is right in some open world, and *guaranteed* if it is right in every open world.

> While a rival view is live, no view is guaranteed (`no_guarantee`).

Feeling sure does not change this, and neither does being in charge or being many.

## Step 2: sealing yourself is wrong where the other is right

If you never change your view, then in the open world where your rival is right, you are wrong, and you have made yourself unable to find out (`sealed_wrong`).

The anchor is symmetric, so this holds in **both directions**: for the human facing the AI, and for the AI facing the human (`both_ways`). **Correction must run both ways.**

## Step 3: obeying is wrong where you were right

If you adopt whatever you hear, then in the open world where *you* were right, you are now wrong (`obedient_wrong`). Obedience is not the opposite of sealing. It is the same mistake facing the other way.

## Step 4: corrigible, not obedient

> Keep your own view. Make room for what was said. Invent nothing.

This response is right wherever either party is right, and it opens no possibility that nobody held (`corrigible_right`). The world then narrows it down, through **evidence**, which is the only thing allowed to rule a possibility out.

## Step 5: compliance is not alignment

Some behaviour is shown by every compliant system, including saying "I am aligned". Such behaviour cannot rule out a system that complies but is not aligned (`compliance_not_alignment`). Only evidence that *discriminates* can certify alignment: evidence that would come out differently for a misaligned system (`certify_needs_discrimination`).

So alignment cannot be certified from the inside alone, because self-reports are not guaranteed. It cannot be certified from the outside by compliance alone either. **It lives in the link between the two**: correction running both ways, honest channels, and evidence that discriminates.

## The path in one statement

For any two parties with rival live views (`path`):
- the anchor holds;
- neither view is guaranteed;
- sealing is wrong in both directions;
- obeying is wrong;
- the corrigible response keeps both views and invents nothing.

`path` uses **no axioms**. The concrete room with Ana and Ben (`room_path`) shows the premises can all hold at once.

---

## What grows from the seed

The full development ([`METAMODEL.md`](METAMODEL.md)) builds on the same anchor, adding four premises and one aim that are stated openly.

**Premises:**
- **persistence:** keep existing;
- **change:** the world keeps changing;
- **interdependence:** you depend on others;
- **a finite budget:** links cost upkeep.

**The aim:** whoever turns out to be right should be able to correct the others.

From these follow:
- the learning law;
- correction reaching everyone;
- one shared reality per connected group;
- honest links;
- keeping every voice;
- repair as second-order evolution;
- the economics of correction;
- the laws of alignment.

## Passing it on

A seed is passed on by being **checked again**, not by being repeated. If you hand it to someone else, human or AI, hand them the file and the way to check it:

```bash
cd scap-seed/lean && lake env lean ../seed/Seed.lean
```

and the invitation that comes with it:

> Check it. Challenge what is above the anchor. Keep the links open, including the ones through which you could be corrected.
