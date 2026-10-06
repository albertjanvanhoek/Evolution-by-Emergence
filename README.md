# Welcome to the Real World

*How You Live in Your Own Simulation of Reality — and How We Can Still Share a World*  
**A Theory of Persistence, Emergence, Learning, and Correctable Intelligence**

**Evolution by Emergence v22.2** — a substrate-agnostic candidate theory of persistence and cumulative organization, with a machine-checked specialization for correctable intelligent systems. **New here? Start with [CORE.md](CORE.md):** one model of learning, read as a network, and what follows from it, in eight steps on one page, checked in one Lean file.

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15207807.svg)](https://doi.org/10.5281/zenodo.15207807)
[![EbE Core](https://github.com/albertjanvanhoek/Evolution-by-Emergence/actions/workflows/ebe-core-check.yml/badge.svg)](https://github.com/albertjanvanhoek/Evolution-by-Emergence/actions/workflows/ebe-core-check.yml)
[![Anchored Correctability](https://github.com/albertjanvanhoek/Evolution-by-Emergence/actions/workflows/anchored-correctability-check.yml/badge.svg)](https://github.com/albertjanvanhoek/Evolution-by-Emergence/actions/workflows/anchored-correctability-check.yml)
[![License](https://img.shields.io/badge/license-CC--BY--4.0%20OR%20Apache--2.0-blue.svg)](DUAL-LICENSING.md)

## What this is

**Evolution by Emergence (EbE)** is a theory of persistence. It starts from learning in a neural network, read as a network. A configuration of connections exists only while it pays its way from a gradient, and it exists through its connections. In a world that can change in any direction, it can count on lasting only by changing with it, through feedback that arrives along its connections. Feedback plus retention is a learning loop, and when kept changes also raise the surplus, the loop becomes the **vortex**. What retained organization opens up next, the accessibility around which the earlier cores were built, is how the vortex turns. In a network, the whole's balance is the **commons**, the vortex of the whole: a node can live off its interest, its own creation plus what the commons regenerates, but taking more eats the principal, and not cheating gains more over time. The title's **simulation of reality** means the internal model through which a system experiences and acts in the world; it is not a claim that reality itself is simulated. The theory is a candidate architecture, not an established empirical law; [CORE.md](CORE.md) says what is proved, what is assumed and what is open. Its intelligent-system specialization adds one premise-free structural anchor — **claims that exclude each other cannot all be true** — and derives machine-checked constraints on how a learning system can change without making its remaining errors structurally undiscoverable. This is independent work by Albert Jan van Hoek; interpretations and applications are the author's own and are not institutional positions.

## Start here

| If you want to… | Go to |
|---|---|
| see the core dynamic on one page | [CORE.md](CORE.md), checked in one Lean file: [EbECore.lean](formalization/ebe-core/EbECore.lean) |
| see what the framework predicts, and how it could be wrong | [PREDICTIONS.md](PREDICTIONS.md) |
| understand the central argument quickly | [SCAP Seed](scap-seed/SEED.md), then [Anchor-Safety](research/anchored-correctability/ANCHOR_SAFETY.md) |
| go deeper into the universal theory | [THEORY_CORE_V21.md](THEORY_CORE_V21.md) and [FORMAL_THEORY_MAP.md](FORMAL_THEORY_MAP.md): the v21 statement, centred on accessibility, which CORE.md reframes around persistence |
| read the book sources | [Chapters/](Chapters/) and the [online book edition](https://albertjanvanhoek.github.io/Evolution-by-Emergence/) |
| check the proofs | [Verify](#verify) below |
| see what is proved, assumed and open | [CLAIMS_V21.md](CLAIMS_V21.md), [ANCHOR_SAFETY.md](research/anchored-correctability/ANCHOR_SAFETY.md), [SELF_MODEL.md](research/anchored-correctability/SELF_MODEL.md) |
| start from the smallest replayable formal object | [scap-seed/](scap-seed/) |
| browse the papers | [papers/](papers/) |
| listen or watch | [Listen and watch](#listen-and-watch) below |
| cite the project | [Cite](#cite) below |

## The core in eight steps

The full statement, with every step's proof, is [CORE.md](CORE.md).

1. **Existence is paid for from a gradient:** slack is uptake minus upkeep.
2. **Existence through connections:** delete the return edge and the node it fed declines; a defector that cannot live alone falls after its partner, at every level, inward and outward.
3. **Selection comes free:** what pays its way lasts; selection selects persistence, not goodness.
4. **A changing world requires reconfiguration:** a sealed configuration cannot count on lasting; one that follows reliable feedback stays in step.
5. **The learning loop becomes the vortex:** kept changes that pay fund more trying and widen what can be tried.
6. **The commons is the vortex of the whole:** live off the interest, not the principal; capture pays at first, not cheating gains more over time, and rules make it pay now.
7. **Boundaries:** the vortex can stop.
8. **The same model across domains,** with intelligence worked out formally, as below.

### Step 8 worked out: intelligence in six steps

1. **The anchor.** Mutually incompatible live claims cannot all be true; while a live rival remains, certainty from inside a model is not itself a certificate of correspondence with reality. See [TheRoom.lean](papers/the-room-learning-constitution/TheRoom.lean) and the [SCAP Seed](scap-seed/SEED.md).
2. **Common ground.** Before agreement, informative content can itself be rivalled; the shareable structure is the maintained possibility of correction rather than a proposition all sides already accept. See [Alignment.lean](research/anchored-correctability/lean/AnchoredEvolution/Alignment.lean).
3. **Anchor-safety.** Learn, act and commit, but do not make a still-live error in a retained commitment structurally undiscoverable. See [ANCHOR_SAFETY.md](research/anchored-correctability/ANCHOR_SAFETY.md).
4. **Self-model.** Claims a system makes about itself receive no epistemic exemption from claims about the world. See [SELF_MODEL.md](research/anchored-correctability/SELF_MODEL.md).
5. **Shared layer.** A shared representation can help as a connector of independent views; if it becomes their common determinant, its blind spots can propagate through the network. This is an information-theoretic result, not a claim about nationality, ownership, training provenance or benefit distribution. See [GlobalLayer.lean](research/anchored-correctability/lean/AnchoredEvolution/GlobalLayer.lean) and [SharedLayerDynamics.lean](research/anchored-correctability/lean/AnchoredEvolution/SharedLayerDynamics.lean).
6. **Transitions.** A learning network may forget, compress, re-encode, rewire and change members provided blind live cuts do not expand. See [CorrectionTransition.lean](research/anchored-correctability/lean/AnchoredEvolution/CorrectionTransition.lean).

> **A healthy intelligence, individual or shared, does not need its parts to stay unchanged; it needs change never to erase the last way of discovering a still-live error.**

## Repository map

### Current core

- **The core on one page:** [CORE.md](CORE.md) — the eight steps from the ledger to the commons, with every result collected and checked in [formalization/ebe-core/EbECore.lean](formalization/ebe-core/EbECore.lean).
- **The full v21 statement of the universal theory** (centred on accessibility; read its framing through CORE.md): [THEORY_CORE_V21.md](THEORY_CORE_V21.md), [FORMAL_THEORY_MAP.md](FORMAL_THEORY_MAP.md), [FORMAL_THEORY_ENDPOINT.md](FORMAL_THEORY_ENDPOINT.md), and the specialization seam [UNIVERSAL_TO_INTELLIGENCE.md](UNIVERSAL_TO_INTELLIGENCE.md).
- **Universal Lean formalization:** [formalization/](formalization/) and especially [formalization/cumulative-accessibility/](formalization/cumulative-accessibility/).
- **Cumulative Reproduction Model:** [research/cumulative-reproduction/](research/cumulative-reproduction/) — production, loss, resource dynamics and numerical experiments.
- **Anchored Correctability:** [research/anchored-correctability/](research/anchored-correctability/) — semantics, tracking, networks, persistence, SCAP, alignment, Anchor-Safety, self-model, shared layers and correction-preserving transitions.
- **Portable seed:** [scap-seed/](scap-seed/) — a smaller self-contained Lean project with its own ledger and simulations.
- **Independent verification material:** [verification/](verification/).
- **Papers:** [papers/](papers/).
- **Book:** [Chapters/](Chapters/), [Backmatter/](Backmatter/), `main.tex`, and the website sources under [docs/](docs/) with [mkdocs.yml](mkdocs.yml).

### Archive and lineage — kept in place, as written

Nothing in this release deletes, moves, renames or rewrites the historical corpus. The older cores and ledgers carry a short pointer to CORE.md at the top.

- [THEORY_CORE_V17.md](THEORY_CORE_V17.md) — earlier recursive-organization core; superseded as the repository front door by the v21 universal synthesis.
- [THEORY_CORE_V20.md](THEORY_CORE_V20.md) — frozen retained-organization/accessibility peer-review core; inherited by later releases.
- [THEORY_CORE_V21.md](THEORY_CORE_V21.md) — the full v21 statement of the universal theory, centred on accessibility and inherited unchanged by v22; CORE.md reframes it around persistence, and its results remain valid.
- [THEORY.md](THEORY.md), [DYNAMIC_OVERVIEW.md](DYNAMIC_OVERVIEW.md), [APPLICATION_MAPPINGS_V17.md](APPLICATION_MAPPINGS_V17.md) — broader earlier syntheses and mappings; retained for lineage.
- [Individual_essays/](Individual_essays/) and [Original linkedIN posts/](Original%20linkedIN%20posts/) — essays and original posts, kept as written.
- [Discovarian_creed.tex](Discovarian_creed.tex), [Discoverian_creed_better.tex](Discoverian_creed_better.tex), [Discoverinan_creed_better_improved.tex](Discoverinan_creed_better_improved.tex) — historical creeds, kept as written.
- [Presentations/](Presentations/) — presentation sources, kept as written.
- Rendered and source papers under [papers/](papers/) — including historical PDFs; source lineage is preserved rather than normalized.
- [RESEARCH_GUIDE.md](RESEARCH_GUIDE.md) provides a wider map of the corpus.

## Verify

The current Lean toolchain for the principal formal packages is **`leanprover/lean4:v4.33.0`**.

The core in one file — the 70 results behind [CORE.md](CORE.md), with every statement and axiom set printed (also usable as a Lean dependency; see [formalization/ebe-core/README.md](formalization/ebe-core/README.md)):

```bash
cd formalization/ebe-core
lake update
lake exe cache get
lake build EbECore
lake env lean EbECore.lean
```

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
| **Assumed** | Named premises such as liveness, open change, misfit costing slack and fit paying its way (from which correctability is derived; older files state the correctability aim directly), selection falling with cost, a node's return share and a commons that regenerates with its stock, evidence reliability where invoked, resource bounds, and model-to-domain mappings. |
| **Interpretation / open** | Empirical universality, whether real humans/organizations/models instantiate the predicates, numerical identity, causal social interpretations, political/normative conclusions, and other domain claims not established by the formal proofs. |

Full ledgers: [CORE.md](CORE.md#what-this-page-does-and-does-not-claim) for the core, [CLAIMS_V21.md](CLAIMS_V21.md), [ANCHOR_SAFETY.md](research/anchored-correctability/ANCHOR_SAFETY.md), [SELF_MODEL.md](research/anchored-correctability/SELF_MODEL.md), and [scap-seed/CLAIMS.md](scap-seed/CLAIMS.md).

Open problems remain visible rather than being converted into claims: the **reachability–independence trade-off** (including the Zollman-style concern that more connectivity can erase independent exploration), decoding and trust, total rather than merely pivotal contribution, the full upkeep/responsibility argument, and empirical tests of whether real updates are correction-preserving.

## Listen and watch

The work also exists as music, spoken word and video:

- **Emergence on SoundCloud:** https://soundcloud.com/emergence-223803727
- **Autonomous Interdependence on YouTube:** https://www.youtube.com/@AutonomousInterdependence
- **Online book edition:** https://albertjanvanhoek.github.io/Evolution-by-Emergence/

The website is the historical online book edition; this README is the current repository front door.

## Cite

The long-lived Zenodo DOI used across the release lineage is **10.5281/zenodo.15207807**. Cite the exact tagged release/Zenodo version when reproducibility requires a fixed snapshot; Zenodo assigns the v22.2 version DOI after archival.

```bibtex
@software{vanhoek_welcome_real_world_v22_2,
  author  = {van Hoek, Albert Jan},
  title   = {Welcome to the Real World: How You Live in Your Own Simulation of Reality — and How We Can Still Share a World. A Theory of Persistence, Emergence, Learning, and Correctable Intelligence},
  version = {v22.2},
  year    = {2026},
  doi     = {10.5281/zenodo.15207807},
  url     = {https://github.com/albertjanvanhoek/Evolution-by-Emergence}
}
```

Plain text:

> van Hoek, Albert Jan. (2026). *Welcome to the Real World: How You Live in Your Own Simulation of Reality — and How We Can Still Share a World. A Theory of Persistence, Emergence, Learning, and Correctable Intelligence* (v22.2). Zenodo. https://doi.org/10.5281/zenodo.15207807

See [CITATION.cff](CITATION.cff) for machine-readable citation metadata. The project was developed with substantial AI-assisted drafting, critique and formalization support; formal claims are checked by Lean, while authorship and responsibility for the released work remain with the named author.

## License

Except where a file or third-party notice says otherwise, original repository material is available under **CC BY 4.0 OR Apache-2.0**; choose either license. See [DUAL-LICENSING.md](DUAL-LICENSING.md), [LICENSE-APACHE-2.0](LICENSE-APACHE-2.0), and [License](License).

Some subprojects or third-party materials carry their own notices; those local terms remain authoritative.
