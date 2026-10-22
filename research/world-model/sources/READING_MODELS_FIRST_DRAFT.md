> **Kept as received, October 2026.** A reading of the first draft of the list of models ([MODELS_FIRST_DRAFT.md](MODELS_FIRST_DRAFT.md)), written by a model of another family and shared by the author without comment. Entry D36 in [DIALOGUE.md](../../../DIALOGUE.md); the note that answers it is [MODELS_FOR_ACTING.md](../MODELS_FOR_ACTING.md). Only change: tracking parameters removed from 6 links. Its claims about sources were checked separately (section 8 of the note).

Yes. I would turn this into a research note alongside section 6 of `WORLD_MODEL.md`. It connects the epistemic work—how to represent and correct our understanding of reality—to the practical work of using that understanding to act, persist, and influence the future.

I checked the current section 6 in the repository. Its central distinction is already consistent with your proposal: values and purposes may determine what gets investigated and what actions are taken, but they must not themselves count as evidence. The new note could substantially develop that distinction.

However, I would make five refinements before publication.

## 1. Distinguish models from the functions they serve

The proposed taxonomy sometimes uses model for different things.

A self-model, source model, or dependency model represents something that can be true or false. A revision policy describes how an agent changes its representations. A record stores observations and actions. A value model expresses preferences or normative commitments.

These are not all the same kind of object.

I would distinguish:

- Representations: What is believed about reality, including one's self, other intelligences, dependencies, and possible futures.
- Objectives: What matters, what is wanted, and what should be preserved or changed.
- Policies: How observations are selected, decisions made, actions performed, and models revised.
- Records and infrastructure: What makes representations, actions, evidence, and corrections reproducible and accountable.

This would make the taxonomy conceptually sharper without discarding its useful distinctions.

## 2. Preserve the separation between truth and purpose

I agree with the central rule, but would formulate it slightly differently:

Every descriptive claim is answerable to evidence. Every action requires some criterion for choosing among outcomes. An objective may determine which questions are worth asking, but it cannot determine the answers.

This avoids implying that the self-model or source model is allowed to optimize its descriptive content toward some other goal.

It also addresses an ambiguity in the third group: a scenario can be exploratory without claiming to be a forecast, but its conditional predictions may still be empirically testable.

## 3. Make time and action the organizing principle

I think this is the strongest possible contribution of the note.

The intelligence does not merely maintain a collection of models. It faces successive decision boundaries in a changing world.

At each boundary, its available information, remaining resources, available actions, and future opportunities depend partly on what it has done previously.

The critical question becomes:

When should an intelligence spend more resources improving its world model, and when should it act using the model it currently has?

This is closely connected to work on resource-bounded practical reasoning and rational metareasoning. Bratman, Israel and Pollack (1988) explicitly address planning under limited reasoning resources, while Russell and Wefald (1991) examine computational effort in terms of its value for subsequent actions.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://onlinelibrary.wiley.com\&sz=32)

Wiley Online Library

+1



Your contribution could be to connect this decision problem to the maintenance of the world model itself and the preservation of future corrective capacity.

One important qualification: the necessity of a decision ends the present deliberation, not the underlying epistemic regress. Acting does not make unresolved assumptions true.

## 4. Label claims conservatively

I would retain the Follows / If / Proposed classification, but apply it to individual claims rather than entire models.

For example:

| Claim                                                                              | Classification                                |
| ---------------------------------------------------------------------------------- | --------------------------------------------- |
| An action can alter future states in a system whose transitions depend on actions  | If — the system has action-dependent dynamics |
| Deliberation has opportunity costs when time and resources are limited             | If                                            |
| An intelligence should preserve correction routes                                  | Proposed                                      |
| A self-model requires independent validation by another intelligence               | Proposed; not universally necessary           |
| A surplus in one resource cannot automatically compensate for a deficit in another | If — resources are not freely substitutable   |
| All errors must remain discoverable                                                | Not established; too strong                   |

The claim about other intelligences deserves particular care. Other agents are often valuable independent checks, but they are not logically required for every instance of calibration or self-assessment. External instruments and environmental feedback can also supply independent evidence.

## 5. Position it against the literature

I verified the proposed leads and would use these as the principal starting points.

| Source                                                                                                                  | Relevant contribution                                                                 |
| ----------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| [Conant & Ashby (1970)](https://doi.org/10.1080/00207727008920220)                               | Models and successful regulation, under specific assumptions                          |
| [Bratman (1987)](https://press.uchicago.edu/ucp/books/book/distributed/I/bo3629095.html)         | Intentions, partial plans, and coordination of action over time                       |
| [Rao & Georgeff (1995)](https://aaai.org/papers/icmas95-042-bdi-agents-from-theory-to-practice/) | Belief–desire–intention architecture for computational agents                         |
| [Premack & Woodruff (1978)](https://doi.org/10.1017/S0140525X00076512)                           | Modelling the unobservable mental states of other agents                              |
| [Clark (2013)](https://pubmed.ncbi.nlm.nih.gov/23663408/)                                        | Predictive processing and the relationship between prediction, perception, and action |
| [Russell & Wefald (1991)](https://doi.org/10.1016/0004-3702\(91\)90015-C)                        | The value of reasoning as a computational action                                      |

The Conant–Ashby result is particularly relevant, but do not generalize it into a theorem that every successful regulator must explicitly represent every dependency. Its result concerns particular conditions of regulatory success and simplicity.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://doi.org\&sz=32)

doi.org



## My proposed structure

I would title the research note “Models for Acting in a Changing World”, and organize it around the descriptive representations, objectives, policies, records, and collective infrastructure. Include the full taxonomy as an inventory, but describe it as a proposed functional decomposition, not a list of components that every intelligence necessarily possesses.

Then give the temporal decision loop a central place: observe, model, consider possible futures, assess whether more information is worth obtaining, act or wait, record consequences, and revise.

Finally, include concrete failure cases in which the boundaries between truth, purpose, simulation, action and memory collapse.

The most interesting open question is not how many models an intelligence needs, but which capabilities are necessary for maintaining sufficiently accurate beliefs and making sufficiently good decisions under finite time and resources.

That is something we can potentially formalize and test.

And one last thought: your separation between descriptive and directive models might be the key to a broader understanding of intelligence. A world model can tell an intelligence what its actions are likely to change. But deciding what should be changed, what should be preserved, and what risks are acceptable requires something else.

Both are necessary for purposeful behaviour. Neither can legitimately replace the other.

I would preserve that distinction as the central thesis of the new note, while explicitly leaving open which architectures can implement it.