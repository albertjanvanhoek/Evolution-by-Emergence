# Perplexity as the Workbench's Clock

Working note, November 2026. Not peer-reviewed. Lineage: a follow-up to two January 2026 preprints, "Watching Evolution Happen: Reinforcement Learning as a Workbench for the Law of Increasing Functional Information" and [The velocity of functional information](../../Individual_essays/The%20velocity%20of%20information.tex).

## What it is

On 22 November 2026 OpenAI published base-model log-perplexity for its model generations and proposed it as a shared safety index. This note reads that curve through the two earlier preprints. In short:

- held-out loss is a scale for functional information, in order though not in magnitude;
- thresholds on a smoothly falling loss set where capabilities appear, and velocity sets when;
- the ratchet fixes prerequisites, not routes: capabilities form a partial order, and each lab's order is one route through it;
- the outside position that makes a training run a clean experiment shrinks as models take part in their own selection;
- capability is a stack, a skill to use skills on top of skill, and a base-model index sees only the bottom of it.

It states five predictions with what would count against each. One of them (even spacing of bands, Prediction 5) already fails a first check against the published numbers. Appendix A designs a test on open model checkpoints. The design has not been run.

## Files

- [manuscript.md](manuscript.md): the note.
- [figures/partial-order.png](figures/partial-order.png): Figure 1, an illustrative prerequisite order.

## How well the sources were checked

Working agreement 1 asks for every figure and quote to be seen in its primary source.

| Source | Seen how |
| --- | --- |
| The author's two preprints | In full |
| Pachocki (2026), "Perplexity and Intelligence" | Through a fetch tool that returns a summary of the page, not the page itself. The figures agree with several press reports. The author should read the essay before the note is cited. |
| OpenAI (2026), Navier–Stokes post; Unite.AI | Excerpts in search results |
| Hazen et al. (2007); Wong et al. (2023); Xia et al. (2022); Hidalgo and Hausmann (2009); Hidalgo and Stojkoski; WHO Joint External Evaluation | Abstracts or excerpts in search results |
| Pythia; PolyPythias; OLMo and OLMo 2; Olsson et al. (2022) | Abstracts or excerpts in search results |
| Schaeffer et al. (2023) | Not opened; cited from the assistant's background knowledge |

No literature audit has been done (see D47). Nothing in the note should be called new until one has.

## Open

- An outside review, by another model family or a human reader.
- Running the pilot in Appendix A on the author's own machine.
- Whether any of the five predictions belong in [PREDICTIONS.md](../../PREDICTIONS.md).
- See D52 in [DIALOGUE.md](../../DIALOGUE.md).
