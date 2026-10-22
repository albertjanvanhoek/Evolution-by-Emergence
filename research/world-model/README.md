# What a world model is

This folder follows entry D34 in [DIALOGUE.md](../../DIALOGUE.md). It defines a world model: what it is, why it is valuable, how it scales from a cell to a society and to AI systems, what contributing to a collective world model requires, and what a world model requires.

| File | What it is |
|---|---|
| [WORLD_MODEL.md](WORLD_MODEL.md) | The definition, its value, how it scales, its constituents, and how it fits the rest of the repository |

**Status:** a definition. Its formal layer is [`WorldModel.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/WorldModel.lean): core Lean, 22 results with a witness, outside the core. Practices and a checklist are to be distilled from the definition next.

**The definition.**

> A **world model** is a model held with the aim of fitting how things are, regardless of what its holder wants, and kept answerable to evidence from outside. It is **sharp** to the extent that its claims rule out possible worlds, and **functional** to the extent that it supports prediction and action in the situations its holder meets. It remains a world model only while it stays **open**: every claim it makes can still be shown wrong by evidence that can reach it.

**The rule in one line:** as sharp as the evidence allows, and no sharper.

**Why it matters in one line:** a world model lets its holder make its mistakes in the model instead of in reality.

**Companion:** [world-model-integrity](../world-model-integrity/README.md) (D33) is about what others owe a holder's world model; this folder is about what a holder must do to have one.
