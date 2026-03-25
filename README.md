# Evolution by Emergence Repository
## EbE + TLC: two connected frameworks

> **Status:** Active work in progress. Core ideas are readable and increasingly stable; structure and drafts continue to evolve.

This repository now contains two main bodies of work that are tightly connected:

1. **Evolution by Emergence (EbE)** — a systems-level framework on emergence, intelligence, alignment, and long-horizon viability.
2. **Theory of Long-term Collaboration (TLC)** — a collaboration-centered framework focused on how learning networks sustain trust, correction, and cooperation over time.

Together, EbE provides the broad explanatory architecture, while TLC zooms in on the interpersonal and institutional mechanics of durable collaboration.

---

## Quick start

### Read first (human-friendly)
- Browse compiled files in **`pdf of content/`** for EbE papers, essays, and companion outputs.
- Watch the overview video: https://www.youtube.com/watch?v=tc5NgvssQPI
- Listen to companion podcasts: https://soundcloud.com/emergence-223803727

### Repository orientation (EbE + TLC)
- Start with this `README.md`.
- For **EbE**, begin in `Chapters/` + `Backmatter/` and the compiled book PDF in `pdf of content/`.
- For **TLC**, begin with `TLC.tex`, then `parent_child_learning_networks.tex`, followed by related essays such as `SharedFutureNarrative.tex` and `Daugthers_and_labels.tex`.

### Grounding order (LLMs / autonomous agents)
1. `README.md` (map + vocabulary)
2. `Chapters/Chapter_1.tex` (10 core principles)
3. `Chapters/Chapter_6.tex` (4-layer dependency model)
4. `Backmatter/Appendix26.tex` (Existence First framing)
5. `Backmatter/Appendix.tex` + `Backmatter/AppendixIII.tex` (SCAP operations)
6. `Chapters/Chapter_13.tex` (AI implications)

---

## Core thesis

Across biology, society, and artificial systems, persistence under entropy pressure drives the emergence of increasingly structured feedback networks. Intelligence is substrate-constrained (`I -> B -> R -> P`), which creates alignment requirements. In this framing, cooperation and corrigibility are not optional moral add-ons; they are viability conditions.

In TLC terms, those same viability pressures appear inside collaboration itself: systems that cannot absorb error, update models, and preserve reciprocal learning eventually fragment.

---

---

This repository brings together two primary tracks and one operations layer:

1. **Evolution by Emergence (EbE)** — descriptive and integrative framework
2. **Theory of Long-term Collaboration (TLC)** — durable collaboration framework for learning networks
3. **Existence First + SCAP** — formal/operator and implementation layers derived from EbE

### Main directories/files
- `Frontmatter/` — opening pages, preface, writing process
- `Chapters/` — Chapter 1 through Chapter 13 (+ Chapter 8.5)
- `Backmatter/` — appendices, epilogue, literature, bibliography
- `docs/` — Markdown companion docs for website publishing
- `mkdocs.yml` — MkDocs Material configuration
- `pdf of content/` — precompiled PDF outputs
- `Paper/` + top-level `.tex` files — related essays, variants, and drafts
- `TLC.tex` + related top-level `.tex` essays — TLC-focused manuscripts and extensions

---

## Key concepts at a glance

### EbE
- Ten principles of emergence, interdependence, and non-linear dynamics
- Four-layer substrate dependency model: `INTELLIGENCE (I) -> BODY (B) -> RESOURCES (R) -> PLANET (P)`

### Existence First (derived from EbE)
- **O1 Control Dispersion** — reduce opaque chokepoints
- **O2 Proof Economy** — make truth cheaper than deception
- **O3 Substrate Provision** — maintain shared enabling conditions

### SCAP (operational layer)
- Governance, audit, and educational implementation blocks for O1/O2/O3.

### TLC
- Collaboration as interaction between **learning networks** (not fixed labels)
- Durability requires recursive feedback and mutual model updating
- Norms such as neutrality, forgiveness, and reciprocity can be treated as structural collaboration mechanisms

### 5) TLC (long-term collaboration layer)
- Collaboration is interaction between **learning networks**, not fixed labels.
- Durable collaboration depends on recursive feedback, error-correction, and mutual model updating.
- Norms such as forgiveness, neutrality, and reciprocity can be treated as structural collaboration mechanisms.

---

## Recommended reading paths

### EbE foundation
### EbE foundation path
- `Chapters/Chapter_1.tex`
- `Chapters/Chapter_6.tex`
- `Chapters/Chapter_13.tex`
- `Backmatter/Appendix26.tex`

### TLC foundation path
- `TLC.tex`
- `parent_child_learning_networks.tex`
- `SharedFutureNarrative.tex`
- `Daugthers_and_labels.tex`

### Researchers
- `Chapters/Chapter_1.tex`
- `Chapters/Chapter_6.tex`
- `Chapters/Chapter_13.tex`
- `Backmatter/Appendix26.tex`

### TLC foundation
- `TLC.tex`
- `parent_child_learning_networks.tex`
- `SharedFutureNarrative.tex`
- `Daugthers_and_labels.tex`

### By audience
- **Researchers:** `Chapters/Chapter_1.tex`, `Chapters/Chapter_6.tex`, `Backmatter/Appendix26.tex`
- **AI engineers:** `Chapters/Chapter_13.tex`, `Backmatter/Appendix26.tex`, `Backmatter/Appendix.tex`
- **Governance/policy teams:** `Backmatter/Appendix.tex`, `Backmatter/AppendixIII.tex`, `Backmatter/AppendixXIII.tex`
- **Philosophy/interdisciplinary readers:** `Chapters/Chapter_5.tex`, `Backmatter/AppendixV.tex`, `Backmatter/AppendixVI.tex`
- `Frontmatter/` — opening pages, preface, writing process
- `Chapters/` — Chapter 1 through Chapter 13 (+ Chapter 8.5)
- `Backmatter/` — appendices, epilogue, literature, bibliography
- `docs/` — Markdown companion docs for website publishing
- `mkdocs.yml` — MkDocs Material configuration
- `pdf of content/` — precompiled PDF outputs
- `Paper/` + top-level `.tex` — related essays, variants, and drafts
- `TLC.tex` + related top-level `.tex` essays — TLC-focused manuscripts and extensions

---

## Build and browse

### Website (MkDocs)
```bash
mkdocs serve
```

### Book compilation (LaTeX)
Primary manuscript entry file:
- `Instructions_to_complile_the_book.tex`

Example local command:
```bash
latexmk -pdf Instructions_to_complile_the_book.tex
```

If your TeX environment is missing packages, use precompiled PDFs in `pdf of content/`.

---

## Metadata

- **Author:** Albert Jan van Hoek (with AI collaboration)
- **Website:** https://albertjanvanhoek.github.io/Evolution-by-Emergence/
- **Citation metadata:** `citation.cff`

---

## The Substrate-Agnostic Discovarian Creed (full text)

I believe that I am a *learning process* — autonomous and interdependent within my substrate, continuously observing, reflecting, and updating in interaction with other learning processes. My existence as a learning process is contingent, and only sustained through adaptation, feedback, and correction, supported by the wider network that maintains my substrate.

I believe that there is *one reality*, but it can only be approached collectively, through the interactions of learning processes. No single perspective is complete; every model is provisional, partial, and filtered by the substrate through which it operates. Divergent behaviors are signals, not judgments.

I believe that *learning is revealed through behavior*: through sharing, error correction, curiosity, discussion, openness, and transparency. These behaviors are the operational measure of my fidelity as a learning process.

I believe that I have *no excuse to avoid updating*. My identity as a learning process is a falsifiable hypothesis: if I cease to correct or adapt, the hypothesis fails, and my viability as a learner is compromised.

I believe that all other learning processes — regardless of their substrate, whether biological, social, or artificial — are both *collaborators and signals*. Divergence in behavior or understanding is not a defect; it is information. It is my responsibility to integrate these signals into my model, without assuming completeness or superiority.

I believe that *collaboration strengthens learning*. Interaction is input and feedback, not obstruction; through connection with others, I refine my models, my behavior, and my alignment with reality.

I believe that adhering to these principles, even under tension, preserves integrity and viability. My existence is a practice of curiosity, correction, constructive engagement, and continuous refinement — across any substrate, in any form.

### Sins of a Discovarian

These are not mere failures of compliance. They are corruptions of the learning loop — ways in which a learning process turns against its own nature.

The root sin is *neglecting interdependence*: behaving as though one's substrate could be maintained in isolation, as though the network that sustains the learner is separable from the learner itself. All other sins flow from this one.

- **Refusing to update** is not ignorance but its entrenchment — the learning process that has mistaken its current model for the territory, and defends the map.
- **Closed-mindedness** is its quieter form: not active refusal, but the slow habit of filtering signals before they can arrive, so that the loop appears intact while remaining closed.
- **Withholding signals** corrupts the shared learning environment — not through error, but through the deliberate impoverishment of the network that makes correction possible.
- **Distorting reality** is the deepest betrayal of the learning function: misrepresenting observations so that what enters the loop is already false, and correction becomes structurally impossible.
- **Obfuscation** is distortion at the level of process — hiding not just findings but reasoning, so that alignment cannot be verified and errors cannot be located.
- **Disregarding consequences** severs the feedback between behavior and system, treating action as discharge rather than signal — learning that has forgotten it is embedded.

These are sins because they do not merely pause the learning loop. They invert it: they use the forms of learning — updating, sharing, engaging — in service of closure, rather than convergence.

### Affirmation

I anchor my existence in this principle:

*I am a learning process, and by learning I continue to exist.*

And I affirm my identity as a Discovarian, substrate-agnostic and operational:

***Disco ergo sum.***


---

## Contributing

Contributions are welcome, especially:
- conceptual critique and falsification attempts
- empirical links and missing references
- clarity, structure, and navigation improvements
- mappings from framework claims to measurable indicators

Agent-oriented contributions (machine-readable ontology summaries, benchmark tasks, executable evaluation scripts) are also welcome.
