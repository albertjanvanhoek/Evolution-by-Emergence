# Welcome to the Real World

*How You Live in Your Own Simulation of Reality — and How We Can Still Share a World*  
**A Theory of Persistence, Emergence, Learning, and Correctable Intelligence**

**Evolution by Emergence v22.2**

v22.2 makes **persistence** the premise of the formal core. Two things that earlier versions took as given are now derived from it: staying correctable, and the need for the vortex to keep turning. Nothing is removed: the v22.0 universal core, the Cumulative Reproduction Model, the intelligent-system specialization and the v22.1 front door are retained. The title's "simulation of reality" means the internal model through which a system experiences and acts in the world; it is not a claim that reality itself is simulated.

## 0. Since this release

These notes describe v22.2 as released. Since then, on `main`:

- [`EbECore.lean`](formalization/ebe-core/EbECore.lean) prints and audits **81** results, reorganized around the eight steps of [`CORE.md`](CORE.md); it no longer has a "Persistence first" section.
- `PersistenceFirst.lean` and `PersistenceRequiresVortex.lean` remain, as narrower results. Section 1 overstates them: "correctability becomes a theorem" holds only under the reciprocity premise, that partners keep sustaining an agent only while it answers their correction, and `reciprocity_is_load_bearing` shows that without that premise it fails.
- New since v22.2: the commons as the vortex of the whole (`CommonsVortex`, `CommonsCapture`, `CommonsInterest`), discounting (`CommonsDiscount`), several takers (`CommonsTakers`), reciprocal dependence (`Reciprocity`), partner switching (`PartnerSwitching`), the cost of listening (`ListeningCost`), and the scope, related work and honesty notes in `CORE.md`.

## 1. One premise, two consequences, five laws

The theory starts from two insights:

1. **The room.** Intelligences are fundamentally non-certain. Incompatible views cannot all be right, and no view can certify itself from the inside.
2. **Substrate dependence.** An intelligence exists only while the substrate and the network that sustain it are maintained.

Two consequences follow, both machine-checked:

- **Persistence requires correctability.** If an agent depends on partners who keep sustaining it only while it answers their correction (reciprocity), then persisting requires answering correction within its buffer, and sealing itself off is fatal once the buffer runs out. Across an interdependent network, the correction routes must also reach everyone. The correctability aim that `Anchor.lean` takes as a chosen premise becomes a theorem.
- **Persistence requires the vortex.** In an open-ended world, being ready for what can happen forces an ever-growing repertoire. With positive upkeep on everything retained, capture must keep growing: the vortex has to keep turning. Persistence requires the vortex; it does not produce it. The existing countermodels still show the vortex can stop.

[`CORE.md`](CORE.md) is reframed around this. It now says what the derivation assumes, and separates what is derived from persistence from what is not.

## 2. New formal results

**`research/anchored-correctability/lean/AnchoredEvolution/PersistenceFirst.lean`** (Mathlib-free):

- `persistence_requires_correction_within` and `sealing_is_fatal_after_buffer`;
- `indefinite_persistence_requires_recurring_correction`;
- `interdependence_and_persistence_force_correctability`: a strongly connected, reciprocal support network whose members all persist has strongly connected correction routes;
- `persistence_replaces_the_aim`: `CorrectabilityAim` holds as a consequence;
- `persistence_first_witness` (non-vacuity);
- `reciprocity_is_load_bearing`: without reciprocity, a substrate-dependent agent can persist forever while never answering correction.

**`formalization/cumulative-accessibility/CumulativeAccessibility/PersistenceRequiresVortex.lean`**:

- `open_world_forces_unbounded_repertoire`;
- `persistence_in_open_world_requires_unbounded_capture`;
- `persistence_requires_vortex_witness` (non-vacuity).

Both files are wired into their packages' audits and CI. [`EbECore.lean`](formalization/ebe-core/EbECore.lean) gains a "Persistence first" section and now prints and audits **44** results (previously 37). The EbE Core Check pins the new count.

## 3. Predictions: `PREDICTIONS.md`

[`PREDICTIONS.md`](PREDICTIONS.md) states what the framework predicts, in a form that can be wrong:

- **Part I — descriptive predictions.** Ten predictions about the architecture of persisting collectives of fallible intelligences, plus one exception for sealed persistence. Examples: no exempt members, restrictions with detours, nested correctable interfaces, the shared-layer blind spot, repair mechanisms, and buffer-timed dropping of members who stop answering. Each names the theorem it rests on, a falsifier and a test bed.
- **Part II — SCAP as a conditional design result.** What agents who want to persist together, and understand the premises, would rationally build. It comes with three conditions without which it fails: SCAP must itself stay correctable; understanding is not enforcement; declared is not operational.

## 4. Front door and metadata

- `README.md` describes correctability as derived from persistence rather than chosen, and links `PREDICTIONS.md`.
- `RELEASE_VERSION`, `CITATION.cff`, `.zenodo.json`, the README citation and the `ebe_core` dependency example are synchronized to v22.2; the public title is unchanged.
- The integration check additionally requires `PREDICTIONS.md` and the persistence modules in `EbECore.lean`.
- The stable Zenodo DOI used across the release lineage is `10.5281/zenodo.15207807`; Zenodo assigns the exact v22.2 version DOI when this GitHub release is archived.

## 5. Status of the claims

- **Proved:** each result in `EbECore.lean` is a machine-checked implication under the premises stated in its theorem.
- **Derived from persistence:** that correctability and a turning vortex are *required* for persistence, under substrate dependence with a finite buffer, reciprocal support, an open-ended world, readiness and positive upkeep.
- **Not derived:** that real systems keep producing vortex turns, or that any domain satisfies the premises. Application mappings (what counts as capture, upkeep, a filter, a link or a correction) are assumptions to be tested.
- **Not claimed:** empirical universality, that the predictions have been tested, or normative conclusions.

## 6. Open work remains open

The open problems of v22.0 and v22.1 remain: the reachability–independence trade-off, decoding and trust, total rather than pivotal contribution, the full upkeep/responsibility argument, empirical tests of whether real updates are correction-preserving, numerical identity and continuation, and cross-world-space transition semantics. v22.2 adds the test beds named in `PREDICTIONS.md`: simulated collectives of AI agents, open-source and wiki communities, and institutional histories.

The v22.1 release notes remain available at the `v22.1` tag.
