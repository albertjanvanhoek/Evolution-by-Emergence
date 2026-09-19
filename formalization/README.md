# Formalization map

This directory contains the machine-checked components that support the current
**Evolution by Emergence** theory.

Start with:

- [../THEORY_CORE_V17.md](../THEORY_CORE_V17.md) — candidate self-standing formal theory.
- [../FORMAL_THEORY_ENDPOINT.md](../FORMAL_THEORY_ENDPOINT.md) — review-readiness target.
- [../FORMAL_THEORY_MAP.md](../FORMAL_THEORY_MAP.md) — claim-to-theorem map.
- [../THEORY.md](../THEORY.md) — broader synthesis around the formal core.
- [../DYNAMIC_OVERVIEW.md](../DYNAMIC_OVERVIEW.md) — complementary v16 resource/dynamic-vortex layer.

## Packages

| Package | Role in the theory | Primary entry point |
|---|---|---|
| \`affinity-layer\` | encounter/association layer before productive coupling | \`AffinityLayer.lean\` |
| \`collective-alignment\` | recurrent maintenance, correction, protocol inheritance, sufficient alignment | \`CollectiveAlignment.lean\`, \`MaintenanceReproduction.lean\`, \`MaintenanceDynamics.lean\` |
| \`persistence-drift\` | persistence/function separation, regulation, implementation competition, slack/search drift, return-path effects | \`PersistenceDrift.lean\`, \`FunctionalCompetition.lean\`, \`ReturnPathPrice.lean\` |
| `cumulative-accessibility` | retention, generative closure, recursive emergence, active/history separation, finite moving envelopes, endogenous response budget, and dynamic vortex | `CumulativeAccessibility/EvolutionByEmergenceV17Core.lean`, `ConstructiveRecursiveEmergence.lean`, `ActiveHistory.lean`, `DynamicVortex.lean` |
| \`../verification/organizational-depth\` | finite-time/fixed-resolution physical boundary and maintenance-debt end-to-end model | \`OrganizationalDepth.lean\`, \`OperationalBridge.lean\`, \`PackingDepth.lean\`, \`MaintenanceDynamicsEndToEnd.lean\` |

## Evidence hierarchy

A green Lean build means:

> the stated theorem follows from the stated formal assumptions in the pinned
> Lean/Mathlib environment.

It does **not** mean:

- the assumptions are empirically true;
- the model is universal;
- the theorem is novel;
- a philosophical interpretation follows automatically.

The formal-theory map marks these boundaries explicitly.

---

## Reproduce package checks locally

### Affinity layer

\`\`\`bash
cd formalization/affinity-layer
lake update
lake exe cache get
lake build
lake env lean AffinityLayer.lean
\`\`\`

### Collective alignment

\`\`\`bash
cd formalization/collective-alignment
lake update
lake exe cache get
lake build
lake env lean CollectiveAlignment.lean
lake env lean MaintenanceReproduction.lean
lake env lean MaintenanceDynamics.lean
\`\`\`

### Persistence drift

\`\`\`bash
cd formalization/persistence-drift
lake update
lake exe cache get
lake build
lake env lean PersistenceDrift.lean
lake env lean FunctionalCompetition.lean
lake env lean ReturnPathPrice.lean
lake env lean RegulatoryReturn.lean
lake env lean EquilibriumExposure.lean
lake env lean FunctionalThresholds.lean
\`\`\`

### Cumulative accessibility / v17 recursive core / dynamic vortex

\`\`\`bash
cd formalization/cumulative-accessibility
lake update
lake exe cache get
lake build
lake build \
  CumulativeAccessibility.AuditAll \
  CumulativeAccessibility.VerificationSurface \
  CumulativeAccessibility.DynamicVortexWitness
lake env lean CumulativeAccessibility/VerificationSurface.lean
lake env lean CumulativeAccessibility/EvolutionByEmergenceV17Core.lean
lake env lean CumulativeAccessibility/ConstructiveRecursiveEmergence.lean
lake env lean CumulativeAccessibility/ActiveHistory.lean
lake env lean CumulativeAccessibility/DynamicVortex.lean
lake env lean CumulativeAccessibility/DynamicVortexWitness.lean
\`\`\`

### Organizational depth

\`\`\`bash
cd verification/organizational-depth
lake update
lake exe cache get
lake build
lake env lean OrganizationalDepth.lean
lake env lean OperationalBridge.lean
lake env lean PackingDepth.lean
lake env lean MaintenanceDynamicsEndToEnd.lean
\`\`\`

For each theory-surface source, inspect the printed axiom dependencies and reject
a result if it depends on \`sorryAx\`.

---

## Full repository verification

The workflow

\`\`\`text
.github/workflows/full-theory-proof-check.yml
\`\`\`

is the meta-verification surface for the current theory. It builds the major
Lean packages and runs selected source-level axiom audits.

Package-specific workflows remain authoritative for their additional numerical
and paper-specific reproducibility checks.

---

## Where to review first

For the candidate v17 formal theory:

1. `CumulativeAccessibility/EvolutionByEmergenceV17Core.lean` — canonical operational, promotion-driven, constructive-projection, historical, and finite-boundary surface.
2. `CumulativeAccessibility/ConstructiveRecursiveEmergence.lean` — configuration-level construction bridge.
3. `CumulativeAccessibility/ActiveHistory.lean` — active versus cumulative-history semantics and turnover witness.
4. `CumulativeAccessibility/LocalEmergenceReproduction.lean` — moving-envelope correction and calibrated local certificate.
5. `CumulativeAccessibility/EndogenousEnvelopePromotion.lean` — essential-parent, finite-admission, promotion-driven successor route.
6. `CumulativeAccessibility/VerificationSurface.lean` — advertised axiom audit.

For the broader v16 resource/maintenance integration, then inspect `DynamicVortex.lean`, `DynamicVortexWitness.lean`, and the supporting maintenance/response modules.

The globally finite `EvolutionByEmergenceCore.lean` remains part of the dependency history and finite diagnostic surface; it is not the canonical v17 open-ended certificate.
