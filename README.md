# Evolution by Emergence Repository
## EbE + TLC: two connected frameworks

> **Status:** Active work in progress. Core ideas are stable to read, while structure and drafts continue to evolve.

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
4. `Backmatter/Appendix26.tex` (Existence First formal framing)
5. `Backmatter/Appendix.tex` + `Backmatter/AppendixIII.tex` (SCAP operations)
6. `Chapters/Chapter_13.tex` (AI implications)

---

## Core thesis (one paragraph)

Across biology, society, and artificial systems, persistence under entropy pressure drives the emergence of increasingly structured feedback networks. Intelligence is substrate-constrained (Body → Resources → Planet), which creates alignment requirements. In this framing, cooperation and corrigibility are not just ethical preferences—they are viability conditions.

In TLC terms, those same viability pressures appear inside collaboration itself: systems that cannot absorb error, update models, and preserve reciprocal learning eventually fragment.

---

## Repository overview

This repository brings together two primary tracks and one operations layer:

1. **Evolution by Emergence (EbE)** — descriptive and integrative framework
2. **Theory of Long-term Collaboration (TLC)** — durable collaboration framework for learning networks
3. **Existence First + SCAP** — formal/operator and implementation layers derived from EbE

**Author:** Albert Jan van Hoek (with AI collaboration)
**Website:** https://albertjanvanhoek.github.io/Evolution-by-Emergence/
**License metadata:** `citation.cff`

---

## Key concepts

### 1) Ten EbE principles
- Universality of emergence
- Dynamic networks over static lineages
- Feedback loops as drivers
- Interdependence and non-linear causality
- Competition + collaboration duality
- Constrained agency ("forced free will")
- Non-linear progression
- Complexity-science integration
- Holistic / non-reductionist perspective
- Implications for life and matter

### 2) Four-layer dependency model
`INTELLIGENCE (I) -> BODY (B) -> RESOURCES (R) -> PLANET (P)`

### 3) Three universal operators (Existence First)
- **O1 Control Dispersion**: avoid opaque chokepoints
- **O2 Proof Economy**: make truth cheaper than deception
- **O3 Substrate Provision**: maintain shared enabling conditions

### 4) SCAP (operations layer)
SCAP translates O1/O2/O3 into practical governance, audit, and educational implementation blocks.

### 5) TLC (long-term collaboration layer)
- Collaboration is interaction between **learning networks**, not fixed labels.
- Durable collaboration depends on recursive feedback, error-correction, and mutual model updating.
- Norms such as forgiveness, neutrality, and reciprocity can be treated as structural collaboration mechanisms.

---

## Recommended reading paths

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
- `Backmatter/Appendix26.tex`

### AI engineers
- `Chapters/Chapter_13.tex`
- `Backmatter/Appendix26.tex`
- `Backmatter/Appendix.tex`

### Governance / policy teams
- `Backmatter/Appendix.tex`
- `Backmatter/AppendixIII.tex`
- `Backmatter/AppendixXIII.tex`

### Philosophers / interdisciplinary readers
- `Chapters/Chapter_5.tex`
- `Backmatter/AppendixV.tex`
- `Backmatter/AppendixVI.tex`

---

## Project structure

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

### MkDocs site
```bash
mkdocs serve
```

### Book compilation (LaTeX)
Primary manuscript entry file:
- `Instructions_to_complile_the_book.tex`

Example local build command:
```bash
latexmk -pdf Instructions_to_complile_the_book.tex
```

If your TeX environment is missing packages, use the precompiled PDFs in `pdf of content/`.

---

## Citation

Please cite this work using metadata in:
- `citation.cff`

---

## Contributing

Contributions are welcome, especially:
- conceptual critique and falsification attempts
- empirical links and missing references
- clarity and structure improvements
- mappings from framework claims to measurable indicators

Agent-focused contributions (machine-readable ontology summaries, benchmark tasks, and executable evaluation scripts) are also encouraged.
