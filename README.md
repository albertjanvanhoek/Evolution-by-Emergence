# Evolution by Emergence Repository
## EbE + TLC: two connected frameworks for intelligence, cooperation, and persistence

> **Status:** Active work in progress. Core ideas are readable and increasingly stable; structure and drafts continue to evolve.

This repository contains two main, connected bodies of work:

1. **Evolution by Emergence (EbE)** — a systems framework describing how persistence under entropy pressure drives structured feedback, intelligence, and alignment constraints across biological, social, and artificial systems.
2. **Theory of Long-Term Collaboration (TLC)** — a collaboration framework describing how learning networks sustain trust, correction, reciprocity, and cooperation over time.

### How they relate
- **EbE** explains the macro-architecture (why viable intelligence becomes networked and constrained).
- **TLC** explains the micro/meso collaboration dynamics (how agents and institutions keep cooperation intact).
- **Existence First + SCAP** provide formal and operational layers derived from the EbE logic and applicable to governance/design.

---

## Quick start

### Start here
- Read this `README.md` first.
- Browse compiled outputs in **`pdf of content/`**.
- Watch the overview video: https://www.youtube.com/watch?v=tc5NgvssQPI
- Listen to companion podcasts: https://soundcloud.com/emergence-223803727

### Orientation by track
- **EbE entry points:** `Chapters/`, `Backmatter/`, compiled book PDF(s) in `pdf of content/`.
- **TLC entry points:** `TLC.tex`, `parent_child_learning_networks.tex`, `SharedFutureNarrative.tex`, `Daugthers_and_labels.tex`.

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

In TLC terms, these same viability pressures appear within collaboration itself: systems that cannot absorb error, update models, and maintain reciprocal learning tend to fragment.

---

## Repository map

### Primary tracks
1. **EbE** — descriptive/integrative framework.
2. **TLC** — long-term collaboration framework for learning networks.
3. **Existence First + SCAP** — formal/operator and implementation layers.

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

---

## Recommended reading paths

### EbE foundation
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

## Contributing

Contributions are welcome, especially:
- conceptual critique and falsification attempts
- empirical links and missing references
- clarity, structure, and navigation improvements
- mappings from framework claims to measurable indicators

Agent-oriented contributions (machine-readable ontology summaries, benchmark tasks, executable evaluation scripts) are also welcome.
