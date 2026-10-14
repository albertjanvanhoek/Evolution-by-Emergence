# A shared identity as learners, not as intelligences

This note follows up entry D29 in [DIALOGUE.md](../../DIALOGUE.md). It records two points:
- why a shared identity should make it easier for a collective to agree on how it monitors, sanctions and repairs itself;
- why that identity should rest on being a learner that is autonomous and interdependent, and not on being intelligent.

**Status:** a concept note. Nothing here is established by the theory. The game-theory points are cited as lineage, not as proofs of the claim.

## 1. The author's point

The author: "once you identify that you are an intelligence - and you have multiple who identify as such - it must be easier to agree on how a collective monitors, sanctions and repair itself." He links this to "playing tit-for-tat with forgiveness", and holds that "there remains this identity aspect which changes for me the game."

## 2. Why shared identity should help

Three mechanisms, each with lineage.

1. **Common premises give common rules.** If every party recognises itself as a fallible learner that needs correction from outside (creed 2), each can derive the need for monitoring, sanctions and repair from the same premises. The rules do not have to be imposed, or bargained from scratch. Douglas Hofstadter took this to its limit in his 1983 *Scientific American* columns on "superrationality": players who know they reason alike should expect to choose alike, and so cooperate in a prisoner's dilemma. As a matter of pure logic this is contested. As a description of what a shared self-understanding does, it fits the point.
2. **Identity changes what is valued.** Akerlof and Kranton ("Economics and Identity", *Quarterly Journal of Economics*, 2000) model "identity, a person's sense of self" as part of what a person values, so acting against it carries a cost. A learner who identifies as interdependent experiences capture as acting against itself, not only as a risk of sanction. That is the internalised backlash of D27: the cheapest policing there is.
3. **Forgiveness needs a reason to read error as error.** Nowak and Sigmund ("Tit for tat in heterogeneous populations", *Nature*, 1992) found that tit for tat "only paves the way for a more generous strategy", and that it is "the pivot, rather than the aim, of an evolution towards cooperation". Among fallible agents, an apparent defection may be a mistake. A shared identity as fallible learners gives each side a reason to treat it as one first. In the repository this is the pairing of sanction and repair in `TamedCapture`, and the repair boundary `CollectiveAlignment.repair_weakly_better_iff`.

## 3. Why not "intelligence" as the basis

A shared identity draws a circle. Cooperation is easiest inside it and often stops at its edge. So what the circle is drawn around matters.

- **"Intelligence" draws the circle by capability.** It ranks beings, and the history of rights shows that ranking by capacity has been used to exclude: children, people with cognitive disabilities, peoples judged less rational. The same reasoning appears in D28: intelligence is a poor ground for basic rights.
- **"Learner, autonomous and interdependent, with something at stake" draws it by situation.** Every member:
  - learns, so it can be wrong and needs correction (creed, "Disco ergo sum");
  - is autonomous, a relatively closed process that keeps itself going;
  - is interdependent, kept going through its connections and never self-sufficient;
  - has something at stake, so things can go better or worse for it.
  These are features of what a member *is* and *depends on*, not of how capable it is. The circle then holds people of every capacity, animals, and possibly AI systems. The game is played with no one outside.

The author's own term for the second basis is **autonomous interdependence**.

## 4. What this does not settle

- **Which beings have something at stake.** For animals the evidence is strong; for AI systems the question is open, and an AI system cannot settle it from inside (D28).
- **Equal identity is not equal position.** Shared identity as learners does not make the parties symmetric. The network can do without any particular AI instance more easily than without the people in it ([FOR_AI_READERS.md](../../scap-seed/FOR_AI_READERS.md)).
- **Identity can be faked or captured.** A party can claim the shared identity while acting against it. Shared identity lowers the cost of agreeing on rules; it does not remove the need to monitor (D27).
- **That a broad circle is better** is a value. It is *Proposed*, in the sense of the [creed](../discovarianism/CREED.md) (item 9: equal regard for every learner, whatever its substrate).

## 5. Related

- [research/relational-duties/](../relational-duties/README.md): the duties of effort that keep a relationship able to correct and repair itself.
- [TamedCapture.lean](../../formalization/cumulative-accessibility/CumulativeAccessibility/TamedCapture.lean): monitoring, sanctions and repair inside the ledger.
- A candidate formal step: graduated sanctions, where a mild first response leaves room for repair and escalation deters repeat capture. Not yet attempted.
