# Evolution by Emergence
## A Universal Theory of Networks, Life, and Mind

> **Status:** Active work in progress. Core ideas are stable to read, while structure and drafts continue to evolve.

This repository contains the source materials for *Evolution by Emergence* (EbE): a book-scale framework connecting emergence, intelligence, cooperation, governance, and long-horizon system viability across biological, social, and artificial systems.

---

## Quick start

### Read first (human-friendly)
- Browse compiled files in **`pdf of content/`**.
- Watch the overview video: https://www.youtube.com/watch?v=tc5NgvssQPI
- Listen to companion podcasts: https://soundcloud.com/emergence-223803727

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

---

## Repository overview

This repository brings together three connected layers:

1. **Evolution by Emergence (EbE)** — descriptive framework
2. **Existence First** — formal, agent-neutral alignment framing derived from EbE
3. **SCAP** — Sustainable Collaborative Alignment Protocol (operational layer)

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

---

## Recommended reading paths

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
