# World models, and what makes one functional

This folder follows entry D34 in [DIALOGUE.md](../../DIALOGUE.md). It distinguishes a **world model**, any representation that supports inference about what is not observed, from a **functional world model**, one maintained so that it stays useful and correctable; and it asks what keeping one functional takes, for a single holder and for a collective.

| File | What it is |
|---|---|
| [WORLD_MODEL.md](WORLD_MODEL.md) | The definition note, third version |
| [sources/REVIEW_1.md](sources/REVIEW_1.md) | The independent review of the first version, kept as received |
| [sources/RESPONSE_1.md](sources/RESPONSE_1.md) | The response to it, point by point |
| [sources/REVIEW_2_PART0.md](sources/REVIEW_2_PART0.md) | Review 2's blind Part 0 answers, recorded before it saw the material |
| [sources/REVIEW_2.md](sources/REVIEW_2.md) | The second independent review, kept as received |
| [sources/RESPONSE_2.md](sources/RESPONSE_2.md) | The response to it, point by point, with how much weight it carries |
| [sources/REVIEW_3_PART0.md](sources/REVIEW_3_PART0.md) | Review 3's blind Part 0 answers, recorded before it saw the material |
| [sources/REVIEW_3.md](sources/REVIEW_3.md) | The third independent review, kept as received |
| [sources/RESPONSE_3.md](sources/RESPONSE_3.md) | The response to it, point by point |
| [briefs/REVIEW_BRIEF.md](briefs/REVIEW_BRIEF.md) | The brief given for review 1 |
| [briefs/REVIEW_BRIEF_2.md](briefs/REVIEW_BRIEF_2.md) | The brief for a second review, in two messages with a blind start |

**Status:** a definition note, outside the core. Review 1 found the first version not ready to open the core. Review 2, by a lighter reader, and review 3 found later versions ready with changes, which are made. Its formal layer is [`WorldModel.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/WorldModel.lean): core Lean, 30 results and a witness, for evidential fit at the level of possibilities only.

**The definition.**

> A **functional world model** is a world model, for a stated scope and use, held with the aim of fitting how things are, regardless of what its holder wants, and tested against evidence whose outcomes are not fixed by the claims being tested. It aims to be as sharp as the evidence supports, subject to calibration. And it is correctable: its beliefs, its background assumptions and its range of possibilities can all be revised, by the holder or by the system that maintains it, and it handles inconsistency by revising.

**For a collective, two halves:** contributors pass on what their evidence supports, with how sure they are and where it came from; and the collective combines contributions in a way that tolerates individual error and keeps provenance.

**Companion:** [world-model-integrity](../world-model-integrity/README.md) (D33), on what others owe a holder's world model.
