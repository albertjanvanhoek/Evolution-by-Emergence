# Formalization map

This directory contains the machine-checked components that support the current
**Evolution by Emergence** theory.

Start with:

- [../THEORY.md](../THEORY.md) — accessible full theory.
- [../FORMAL_THEORY_MAP.md](../FORMAL_THEORY_MAP.md) — claim-to-theorem map.
- [../DYNAMIC_OVERVIEW.md](../DYNAMIC_OVERVIEW.md) — integrated recursive core.

## Packages

| Package | Role in the theory | Primary entry point |
|---|---|---|
| \`affinity-layer\` | encounter/association layer before productive coupling | \`AffinityLayer.lean\` |
| \`collective-alignment\` | recurrent maintenance, correction, protocol inheritance, sufficient alignment | \`CollectiveAlignment.lean\`, \`MaintenanceReproduction.lean\`, \`MaintenanceDynamics.lean\` |
| \`persistence-drift\` | persistence/function separation, regulation, implementation competition, slack/search drift, return-path effects | \`PersistenceDrift.lean\`, \`FunctionalCompetition.lean\`, \`ReturnPathPrice.lean\` |
| \`cumulative-accessibility\` | retention, generative closure, open-ended capacity, endogenous response budget, full dynamic vortex | \`CumulativeAccessibility/DynamicVortex.lean\`, \`DynamicVortexWitness.lean\` |
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

### Cumulative accessibility / dynamic vortex

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

For a mathematical reviewer:

1. \`cumulative-accessibility/CumulativeAccessibility/DynamicVortex.lean\`
2. \`cumulative-accessibility/CumulativeAccessibility/DynamicVortexWitness.lean\`
3. \`collective-alignment/MaintenanceDynamics.lean\`
4. \`persistence-drift/PersistenceDrift.lean\`
5. \`persistence-drift/ReturnPathPrice.lean\`
6. \`../verification/organizational-depth/OperationalBridge.lean\`
7. \`../verification/organizational-depth/PackingDepth.lean\`

Then use [../FORMAL_THEORY_MAP.md](../FORMAL_THEORY_MAP.md) to trace the
surrounding claims and explicit non-claims.
