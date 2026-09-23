# Evolution by Emergence

## v21: cumulative evolution with an explicit intelligent-system specialization

Evolution by Emergence (EbE) asks:

> **How can organization that exists now become causal material that changes which organization can exist next, while itself being produced, lost and maintained under finite resources?**

v21 is the current review object. It preserves the v20 retained-organization/accessibility core, adds the reviewed Cumulative Reproduction Model as a separate dynamical specialization, and keeps the newer Anchored Correctability / SCAP work explicitly scoped to intelligent systems.

The universal interpretation remains a **candidate to be challenged**, not an established empirical law.

## Start here

### Universal Evolution by Emergence

1. **[THEORY_CORE_V21.md](THEORY_CORE_V21.md)** — current universal theory synthesis.
2. **[FORMAL_THEORY_MAP.md](FORMAL_THEORY_MAP.md)** — theorem and specialization map.
3. **[FORMAL_THEORY_ENDPOINT.md](FORMAL_THEORY_ENDPOINT.md)** — review object, scope and failure conditions.
4. **[formalization/cumulative-accessibility/README.md](formalization/cumulative-accessibility/README.md)** — identity-sensitive retained-organization/accessibility formal core inherited from v20.
5. **[research/cumulative-reproduction/README.md](research/cumulative-reproduction/README.md)** — reviewed production/loss/resource dynamics and E1–E8 experiments.

### Intelligent-system specialization

1. **[UNIVERSAL_TO_INTELLIGENCE.md](UNIVERSAL_TO_INTELLIGENCE.md)** — explicit specialization seam; mapping, not equivalence.
2. **[research/anchored-correctability/README.md](research/anchored-correctability/README.md)** — current deep intelligent-system endpoint: semantics, tracking, realization, persistence, SCAP and alignment.
3. **[scap-seed/README.md](scap-seed/README.md)** — smaller self-contained replay/review object with its own Lean project, claims ledger and simulations.

The intelligent-system track introduces candidate worlds, semantic claims, evidence, challenge, answerability and tracking. Those are not silently promoted to universal EbE primitives.

## Universal core in one paragraph

The structural state is represented as active organization `G`, retained organization `R`, context `Gamma`, and gross budget. Retention consumes maintenance cost and can also alter transition machinery, thereby changing which future organization is reachable within a horizon and budget. Strict compositional emergence constrains what future function can finance before realization. Finite resources prevent unconstrained positive-cost retention and bounded single-unit reuse bounds declared accessible repertoire.

The reviewed Cumulative Reproduction Model adds a complementary count-level question: under a declared production/loss law and resource ledger, how does a retained repertoire grow, collapse, plateau or fluctuate? The structural and dynamical questions are deliberately kept distinct.

```text
retained identity / structure
        |
        +--> transition machinery --> future accessibility
        |
        +--> maintenance burden
        |
        +--> production / loss / admission --> next retained repertoire
```

A complete empirical application may need both item identity/function and count/rate dynamics.

## What changed since v20

v20 remains an immutable historical review object for the retained-organization/accessibility theory. v21 adds:

- the reviewed Cumulative Reproduction Model under `research/cumulative-reproduction/`;
- explicit separation of structural accessibility from repertoire-level dynamics;
- the current Anchored Correctability / Persistence / SCAP package as a **separate intelligent-system specialization**;
- the Alignment layer distinguishing corrigibility from obedience/sycophancy and behavioural compliance from verification;
- the self-contained `scap-seed/` subproject;
- a repository-level specialization map and v21 integration verification matrix.

## Intelligent-system endpoint

The current deep specialization follows roughly:

```text
anchor
 -> live candidate worlds
 -> executable challenge/revision
 -> semantic answerability
 -> content-sensitive tracking
 -> individuals / groups / recursive networks
 -> unified transition law
 -> dynamic evidence
 -> operational realization
 -> changing world + link failure/repair
 -> SCAP persistence conditions
 -> alignment specialization
```

Its formal SCAP object separates:

```text
Connected ∧ Faithful ∧ Evidence-open ∧ Repairable ∧ Affordable.
```

This is a theorem-level object under explicit semantic and operational premises. It is not a new universal axiom of EbE.

## Start small: SCAP Seed

[SCAP Seed](scap-seed/README.md) is deliberately smaller than the research endpoint. It exists so a reviewer can replay the anchor-to-corrigibility path without loading the whole repository. It remains self-contained and keeps its own licensing and verification boundary.

What is proved inside the seed does not certify the rest of the repository, and the rest of the repository does not weaken the seed's local theorems.

## Verification boundaries

The repository now has four independently checked surfaces:

- `formalization/cumulative-accessibility/` — universal structural core;
- `research/cumulative-reproduction/` — reviewed count-level dynamics and numerical checks;
- `research/anchored-correctability/` — deep intelligent-system specialization;
- `scap-seed/` — portable seed.

`.github/workflows/v21-integration-check.yml` runs these surfaces together on a release candidate commit. A green matrix means each declared package passed its own verification on that commit; it does **not** mean one package proves the others.

## Important distinctions

v21 keeps the following separations explicit:

- state dependence ≠ cumulative evolution;
- structural accessibility ≠ repertoire count dynamics;
- deterministic growth ≠ finite-horizon stochastic survival;
- finite-target hitting ≠ eventual survival;
- emergence ≠ retention;
- persistence ≠ function;
- validation ≠ truth;
- exact semantic relay ≠ live-preserving sharpening;
- intelligent-system semantics ≠ universal EbE primitives;
- machine checking ≠ empirical truth.

## Review and falsification

Reviewers are asked to localize criticism:

1. **formal validity** — does a conclusion fail under its exact premises?
2. **semantic adequacy** — does a predicate fail to mean what the prose claims?
3. **model separation** — have structural and count-level models been conflated?
4. **hidden assumptions** — are counting, resources, parentage, or semantic premises doing unacknowledged work?
5. **prior art** — does an existing theory already provide an equal or stronger architecture?
6. **cross-domain mapping** — can target systems instantiate the interfaces non-arbitrarily?
7. **universality** — is there a genuine cumulative system with no defensible retained-history effect on later accessibility?
8. **specialization failure** — does the intelligent-system mapping add unjustified semantics or fail to instantiate the universal interfaces it claims to specialize?

A successful falsification, narrowing, or prior-art correction is a useful outcome.

## Reproduce

Universal structural core:

```bash
cd formalization/cumulative-accessibility
lake update
lake exe cache get
lake build CumulativeAccessibility.AuditAll CumulativeAccessibility.VerificationSurface
lake env lean CumulativeAccessibility/VerificationSurface.lean
```

The other three packages have their own README and path-scoped CI instructions.

## Release lineage

- **v21** — current synthesis: universal retained-organization/accessibility + reviewed cumulative-reproduction dynamics, with the intelligent-system specialization explicitly separated.
- **v20** — immutable retained-organization/accessibility peer-review release.
- **v19** — Retained Organization and Correctable Learning.
- **v18** — The Learning Constitution: Correctable Interdependence.
- **v17** — Recursive Organization Core.
- **v16** — Full Theory Peer-Review Release / Dynamic Vortex integration.

Use [RESEARCH_GUIDE.md](RESEARCH_GUIDE.md) for the wider corpus and historical routes.

---

*Evolution by Emergence is an active, corrigible research corpus by Albert Jan van Hoek with AI collaboration. Formal verification establishes mathematical implications under explicit assumptions. Scientific interpretation, application, and normative conclusions remain open to evidence and peer review.*
