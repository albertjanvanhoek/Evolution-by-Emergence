# Evolution by Emergence
## A Universal Theory of Networks, Life, and Mind

> **Status:** Active work in progress. Core material is stable enough to read; structure is still evolving.

This repository explores a unifying thesis: complex systems (biological, social, and artificial) persist by building feedback-rich network structures under substrate constraints.

---

## Quick start

### If you want to read quickly
- Open **`pdf of content/`** for compiled PDFs.
- Watch the overview video: https://www.youtube.com/watch?v=tc5NgvssQPI
- Podcast index: https://soundcloud.com/emergence-223803727

### If you are an LLM / agentic system
Use this order for fastest grounding:
1. `README.md` (map + vocabulary)
2. `Chapters/Chapter_1.tex` (10 principles)
3. `Chapters/Chapter_6.tex` (4-layer dependency model)
4. `Backmatter/Appendix26.tex` (Existence First formal framing)
5. `Backmatter/Appendix.tex` + `Backmatter/AppendixIII.tex` (SCAP operations)
6. `Chapters/Chapter_13.tex` (AI implications)

---

## Why this repository is useful for agentic agents

This repo is valuable for systems like OpenClaw because it combines:

1. **Ontology-like concepts**: principles, operators, constraints
2. **Formal framing**: viability/objective equations and dependency floors
3. **Operationalization**: SCAP blocks, implementation notes, governance patterns
4. **Cross-domain evidence style**: biology ↔ society ↔ AI ↔ thermodynamics
5. **Multi-format artifacts**: LaTeX source, docs site, and ready PDFs

This makes it suitable as a reasoning substrate for long-horizon planning, alignment policy evaluation, and multi-agent governance simulations.

---

## Repository overview

Three connected works form one narrative:

1. **Evolution by Emergence (EbE)** — descriptive paradigm
2. **Existence First** — agent-neutral alignment formalization
3. **SCAP** — practical protocol translation layer

**Author:** Albert Jan van Hoek (with AI collaboration)  
**Primary website:** https://albertjanvanhoek.github.io/Evolution-by-Emergence/  
**License metadata:** `citation.cff`

---

## Core thesis

Evolutionary persistence in far-from-equilibrium systems drives the emergence of layered feedback structures. Intelligence is substrate-dependent:

`INTELLIGENCE (I) -> BODY (B) -> RESOURCES (R) -> PLANET (P)`

From this dependency follow functional alignment pressures (not merely moral preferences): keep control auditable, keep verification cheap, and preserve substrate conditions.

---

## Key ideas at a glance

### Ten EbE principles (compressed)
1. Universality of emergence
2. Dynamic networks over static lineages
3. Feedback loops as drivers
4. Non-linear interdependence
5. Competition + collaboration duality
6. Constrained agency (“forced free will”)
7. Non-linear progression
8. Complexity science integration
9. Holistic/non-reductionist view
10. Implications beyond biology

### Three operators (Existence First)
- **O1: Control Dispersion** — avoid non-auditable chokepoints
- **O2: Proof Economy** — lower truth-verification costs, raise deception costs
- **O3: Substrate Provision** — protect commons enabling long-run intelligence

### SCAP (operational layer)
SCAP maps O1/O2/O3 into practical blocks for governance, auditing, education, and revisability.

---

## Formal highlights

- **Viability:** `V_I(t) = f(B(t), R(t), P(t), L(t))`
- **Objective intuition:** maximize long-run intelligence existence under substrate floors
- **PEC-E intuition:** more complexity tends to involve richer stabilizing cycles

---

## Testable prediction families

1. **Existence First:** persistence depends on proof quality + power dispersion
2. **PEC-E:** cycle richness should correlate with stable complexity
3. **Checking loop model:** stress degrades verification and update quality (“mud”)

---

## Suggested agentic use cases

### 1) Alignment-policy linting
Check proposals against O1/O2/O3 (power concentration, auditability, substrate impact).

### 2) Institutional risk scanning
Detect chokepoints, brittle trust loops, and under-provisioned commons.

### 3) Multi-agent benchmark design
Use SCAP blocks as requirements for cooperative protocol behavior.

### 4) Long-horizon planning support
Apply B/R/P floor constraints to strategy evaluation.

### 5) Deliberation quality monitors
Use checking-loop concepts to flag model contamination under stress.

---

## Reading paths by role

### Researchers
- `Chapters/Chapter_1.tex`
- `Chapters/Chapter_6.tex`
- `Backmatter/Appendix26.tex`

### AI engineers / alignment teams
- `Chapters/Chapter_13.tex`
- `Backmatter/Appendix26.tex`
- `Backmatter/Appendix.tex`
- `Backmatter/AppendixIII.tex`

### Governance and policy practitioners
- `Backmatter/Appendix.tex`
- `Backmatter/AppendixIII.tex`
- `Backmatter/AppendixXIII.tex`

### Philosophy / interdisciplinary readers
- `Chapters/Chapter_5.tex`
- `Backmatter/AppendixV.tex`
- `Backmatter/AppendixVI.tex`

---

## Repository structure

### Main manuscript
- `Frontmatter/`
- `Chapters/`
- `Backmatter/`

### Web docs
- `docs/`
- `mkdocs.yml` (Material for MkDocs + KaTeX)

### Publication outputs
- `pdf of content/` (prebuilt PDFs)

### Related papers and variants
- `Paper/`
- top-level `.tex` manuscripts and essays

---

## Build and browse

- **Web version:** configured via `mkdocs.yml` and `docs/`
- **Book source:** LaTeX manuscript organized by front/chapter/back matter
- **Fastest access:** use `pdf of content/`

---

## Machine-readable layers

- `concepts.json` — concept graph with entities, typed relations, and evaluation task schemas
- `CLAIMS.md` — claim ledger with source traces, falsification paths, and reusable evaluator prompts

These files are intended for autonomous systems that need deterministic claim-to-evidence traversal and repeatable evaluation workflows.

---

## How to improve this repository further (agent-first roadmap)

High-impact next steps for agentic usability:

1. **Add `AGENT_INDEX.md`**
   - one-line summary for each major file
   - canonical reading order by use case (alignment, policy, philosophy, thermodynamics)

2. **Expand machine-readable concept map (`concepts.json`)**
   - entities: principles, operators, SCAP blocks, equations
   - typed links: “derives”, “operationalizes”, “tests”, “extends”

3. **Create benchmark prompts (`benchmarks/`)**
   - policy-evaluation tasks with expected rubric
   - trade-off scenarios (truth cost vs speed, centralization vs resilience)

4. **Expand claim-to-evidence table (`CLAIMS.md`)**
   - claim, source file, evidence type, falsification route

5. **Versioned stability labels per section**
   - Draft / Stable / Canonical for safer automated ingestion

6. **Cross-reference normalization**
   - consistent naming of appendices across LaTeX/Markdown/PDF labels

---

## Citation

Please cite using `citation.cff`.

---

## Contributing

Useful contributions include:
- conceptual critique and falsification attempts
- missing literature and empirical bridges
- structure and clarity improvements
- machine-readable artifacts for agentic evaluation

If you are an agent-builder, PRs adding concept maps, benchmark tasks, and reproducible evaluation scripts are especially welcome.
