# Welcome to the Real World

*How You Live in Your Own Simulation of Reality — and How We Can Still Share a World*  
**A Theory of Persistence, Emergence, Learning, and Correctable Intelligence**

**Evolution by Emergence v22.0** — a substrate-agnostic candidate theory of persistence and cumulative organization, with a machine-checked specialization for correctable intelligent systems.

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15207807.svg)](https://doi.org/10.5281/zenodo.15207807)
[![Anchored Correctability](https://github.com/albertjanvanhoek/Evolution-by-Emergence/actions/workflows/anchored-correctability-check.yml/badge.svg)](https://github.com/albertjanvanhoek/Evolution-by-Emergence/actions/workflows/anchored-correctability-check.yml)
[![License](https://img.shields.io/badge/license-CC--BY--4.0%20OR%20Apache--2.0-blue.svg)](DUAL-LICENSING.md)

## What this is

**Evolution by Emergence (EbE)** studies how retained organization can become causal material for what becomes possible next, while being produced, lost and maintained under finite resources. The title's **simulation of reality** means the internal model through which a system experiences and acts in the world; it is not a claim that reality itself is simulated. The [current universal theory core](THEORY_CORE_V21.md) is a candidate architecture, not an established empirical law. Its intelligent-system specialization starts from one premise-free structural anchor — **claims that exclude each other cannot all be true** — and then, conditional on a stated aim of continued reality-tracking/correctability, derives machine-checked constraints on how a learning system can change without making its remaining errors structurally undiscoverable. This is independent work by Albert Jan van Hoek; interpretations and applications are the author's own and are not institutional positions.

## Start here

| If you want to… | Go to |
|---|---|
| understand the central argument quickly | [SCAP Seed](scap-seed/SEED.md), then [Anchor-Safety](research/anchored-correctability/ANCHOR_SAFETY.md) |
| understand the universal EbE theory | [THEORY_CORE_V21.md](THEORY_CORE_V21.md) and [FORMAL_THEORY_MAP.md](FORMAL_THEORY_MAP.md) |
| read the book sources | [Chapters/](Chapters/) and the [online book edition](https://albertjanvanhoek.github.io/Evolution-by-Emergence/) |
| check the proofs | [Verify](#verify) below |
| see what is proved, assumed and open | [CLAIMS_V21.md](CLAIMS_V21.md), [ANCHOR_SAFETY.md](research/anchored-correctability/ANCHOR_SAFETY.md), [SELF_MODEL.md](research/anchored-correctability/SELF_MODEL.md) |
| start from the smallest replayable formal object | [scap-seed/](scap-seed/) |
| browse the papers | [papers/](papers/) |
| listen or watch | [Listen and watch](#listen-and-watch) below |
| cite the project | [Cite](#cite) below |

## The argument in six steps

1. **The anchor.** Mutually incompatible live claims cannot all be true; while a live rival remains, certainty from inside a model is not itself a certificate of correspondence with reality. See [TheRoom.lean](papers/the-room-learning-constitution/TheRoom.lean) and the [SCAP Seed](scap-seed/SEED.md).
2. **Common ground.** Before agreement, informative content can itself be rivalled; the shareable structure is the maintained possibility of correction rather than a proposition all sides already accept. See [Alignment.lean](research/anchored-correctability/lean/AnchoredEvolution/Alignment.lean).
3. **Anchor-safety.** Learn, act and commit, but do not make a still-live error in a retained commitment structurally undiscoverable. See [ANCHOR_SAFETY.md](research/anchored-correctability/ANCHOR_SAFETY.md).
4. **Self-model.** Claims a system makes about itself receive no epistemic exemption from claims about the world. See [SELF_MODEL.md](research/anchored-correctability/SELF_MODEL.md).
5. **Shared layer.** A shared representation can help as a connector of independent views; if it becomes their common determinant, its blind spots can propagate through the network. This is an information-theoretic result, not a claim about nationality, ownership, training provenance or benefit distribution. See [GlobalLayer.lean](research/anchored-correctability/lean/AnchoredEvolution/GlobalLayer.lean) and [SharedLayerDynamics.lean](research/anchored-correctability/lean/AnchoredEvolution/SharedLayerDynamics.lean).
6. **Transitions.** A learning network may forget, compress, re-encode, rewire and change members provided blind live cuts do not expand. See [CorrectionTransition.lean](research/anchored-correctability/lean/AnchoredEvolution/CorrectionTransition.lean).

> **A healthy intelligence, individual or shared, does not need its parts to stay unchanged; it needs change never to erase the last way of discovering a still-live error.**

## Repository map

### Current core

- **Universal theory:** [THEORY_CORE_V21.md](THEORY_CORE_V21.md), [FORMAL_THEORY_MAP.md](FORMAL_THEORY_MAP.md), [FORMAL_THEORY_ENDPOINT.md](FORMAL_THEORY_ENDPOINT.md), and the specialization seam [UNIVERSAL_TO_INTELLIGENCE.md](UNIVERSAL_TO_INTELLIGENCE.md).
- **Universal Lean formalization:** [formalization/](formalization/) and especially [formalization/cumulative-accessibility/](formalization/cumulative-accessibility/).
- **Cumulative Reproduction Model:** [research/cumulative-reproduction/](research/cumulative-reproduction/) — production, loss, resource dynamics and numerical experiments.
- **Anchored Correctability:** [research/anchored-correctability/](research/anchored-correctability/) — semantics, tracking, networks, persistence, SCAP, alignment, Anchor-Safety, self-model, shared layers and correction-preserving transitions.
- **Portable seed:** [scap-seed/](scap-seed/) — a smaller self-contained Lean project with its own ledger and simulations.
- **Independent verification material:** [verification/](verification/).
- **Papers:** [papers/](papers/).
- **Book:** [Chapters/](Chapters/), [Backmatter/](Backmatter/), `main.tex`, and the website sources under [docs/](docs/) with [mkdocs.yml](mkdocs.yml).

### Archive and lineage — kept in place, as written

Nothing in this release deletes, moves, renames or rewrites the historical corpus.

- [THEORY_CORE_V17.md](THEORY_CORE_V17.md) — earlier recursive-organization core; superseded as the repository front door by the v21 universal synthesis.
- [THEORY_CORE_V20.md](THEORY_CORE_V20.md) — frozen retained-organization/accessibility peer-review core; inherited by later releases.
- [THEORY_CORE_V21.md](THEORY_CORE_V21.md) — current universal core inherited unchanged by v22.
- [THEORY.md](THEORY.md), [DYNAMIC_OVERVIEW.md](DYNAMIC_OVERVIEW.md), [APPLICATION_MAPPINGS_V17.md](APPLICATION_MAPPINGS_V17.md) — broader earlier syntheses and mappings; retained for lineage.
- [Individual_essays/](Individual_essays/) and [Original linkedIN posts/](Original%20linkedIN%20posts/) — essays and original posts, kept as written.
- [Discovarian_creed.tex](Discovarian_creed.tex), [Discoverian_creed_better.tex](Discoverian_creed_better.tex), [Discoverinan_creed_better_improved.tex](Discoverinan_creed_better_improved.tex) — historical creeds, kept as written.
- [Presentations/](Presentations/) — presentation sources, kept as written.
- Rendered and source papers under [papers/](papers/) — including historical PDFs; source lineage is preserved rather than normalized.
- [RESEARCH_GUIDE.md](RESEARCH_GUIDE.md) provides a wider map of the corpus.

## Verify

The current Lean toolchain for the principal formal packages is **`leanprover/lean4:v4.33.0`**.

Universal retained-organization/accessibility core:

```bash
cd formalization/cumulative-accessibility
lake update
lake exe cache get
lake build CumulativeAccessibility.AuditAll CumulativeAccessibility.VerificationSurface
lake env lean CumulativeAccessibility/VerificationSurface.lean
```

Deep intelligent-system package:

```bash
cd research/anchored-correctability/lean
lake build
```

Its audit surfaces are in `lean/AnchoredEvolution/*Audit.lean`. CI rejects `sorryAx` and pins these counts:

| Audit | Headline results |
|---|---:|
| `Audit.lean` | 227 |
| `AnchorSafetyAudit.lean` | 16 |
| `SelfModelAudit.lean` | 11 |
| `GlobalLayerAudit.lean` | 4 |
| `SharedLayerDynamicsAudit.lean` | 11 |
| `CorrectionTransitionAudit.lean` | 16 |

Within the 16-result **Anchor-Safety** audit, 15 results are axiom-free; `anchorSafe_iff_cuts_separated` uses classical logic in one direction. Other older formal surfaces have their own explicit axiom reports; machine checking proves implications under stated premises, not empirical truth.

Cumulative Reproduction Model:

```bash
cd research/cumulative-reproduction/lean
lean CumulativeReproduction.lean
```

SCAP Seed:

```bash
cd scap-seed
scripts/verify.sh
```

The seed audits **184 headline results**. The integrated release matrix is [.github/workflows/v21-integration-check.yml](.github/workflows/v21-integration-check.yml); the deep package has its own [anchored-correctability workflow](.github/workflows/anchored-correctability-check.yml).

## What is proved, assumed and open

| Status | What it means here |
|---|---|
| **Proved** | Lean-checked implications under the definitions and hypotheses in the formal files; axiom status is printed in the audit files. |
| **Assumed** | Named premises such as liveness, the chosen correctability/reality-tracking aim, evidence reliability where invoked, resource bounds, and model-to-domain mappings. |
| **Interpretation / open** | Empirical universality, whether real humans/organizations/models instantiate the predicates, numerical identity, causal social interpretations, political/normative conclusions, and other domain claims not established by the formal proofs. |

Full ledgers: [CLAIMS_V21.md](CLAIMS_V21.md), [ANCHOR_SAFETY.md](research/anchored-correctability/ANCHOR_SAFETY.md), [SELF_MODEL.md](research/anchored-correctability/SELF_MODEL.md), and [scap-seed/CLAIMS.md](scap-seed/CLAIMS.md).

Open problems remain visible rather than being converted into claims: the **reachability–independence trade-off** (including the Zollman-style concern that more connectivity can erase independent exploration), decoding and trust, total rather than merely pivotal contribution, the full upkeep/responsibility argument, and empirical tests of whether real updates are correction-preserving.

## Listen and watch

The work also exists as music, spoken word and video:

- **Emergence on SoundCloud:** https://soundcloud.com/emergence-223803727
- **Autonomous Interdependence on YouTube:** https://www.youtube.com/@AutonomousInterdependence
- **Online book edition:** https://albertjanvanhoek.github.io/Evolution-by-Emergence/

The website is the historical online book edition; this README is the current repository front door.

## Cite

The long-lived Zenodo DOI used across the release lineage is **10.5281/zenodo.15207807**. Cite the exact tagged release/Zenodo version when reproducibility requires a fixed snapshot; Zenodo assigns the v22.0 version DOI after archival.

```bibtex
@software{vanhoek_welcome_real_world_v22,
  author  = {van Hoek, Albert Jan},
  title   = {Welcome to the Real World: How You Live in Your Own Simulation of Reality — and How We Can Still Share a World. A Theory of Persistence, Emergence, Learning, and Correctable Intelligence},
  version = {v22.0},
  year    = {2026},
  doi     = {10.5281/zenodo.15207807},
  url     = {https://github.com/albertjanvanhoek/Evolution-by-Emergence}
}
```

Plain text:

> van Hoek, Albert Jan. (2026). *Welcome to the Real World: How You Live in Your Own Simulation of Reality — and How We Can Still Share a World. A Theory of Persistence, Emergence, Learning, and Correctable Intelligence* (v22.0). Zenodo. https://doi.org/10.5281/zenodo.15207807

See [CITATION.cff](CITATION.cff) for machine-readable citation metadata. The project was developed with substantial AI-assisted drafting, critique and formalization support; formal claims are checked by Lean, while authorship and responsibility for the released work remain with the named author.

## License

Except where a file or third-party notice says otherwise, original repository material is available under **CC BY 4.0 OR Apache-2.0**; choose either license. See [DUAL-LICENSING.md](DUAL-LICENSING.md), [LICENSE-APACHE-2.0](LICENSE-APACHE-2.0), and [License](License).

Some subprojects or third-party materials carry their own notices; those local terms remain authoritative.
