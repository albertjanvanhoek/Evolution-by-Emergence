# Persistence Does Not Measure Function

This directory is the reproducible paper package for:

**Persistence Does Not Measure Function: Separating Fitness Balance, Productive Efficiency, Maintained Mass, Structural Support, and Functional Capacity in Self-Maintaining Networks**

## Start here

- [manuscript.md](manuscript.md) — readable manuscript.
- [figures/integrated_hollowing_margin.svg](figures/integrated_hollowing_margin.svg) — integrated hollowing: productive efficiency and total maintained mass rise while the declared functional margin crosses zero.
- [figures/downstream_extraction_margin.svg](figures/downstream_extraction_margin.svg) — one-way extraction: global equilibrium productivity measures stay fixed while functional margin is consumed.
- [figures/make_figures.py](figures/make_figures.py) — pure-Python source that regenerates both SVGs and the sensitivity table.
- [figures/threshold_sensitivity.csv](figures/threshold_sensitivity.csv) — sensitivity of the hollowing crossing to the declared threshold.
- [REPRODUCIBILITY.md](REPRODUCIBILITY.md) — exact parameters, proof locations, CI instructions, and epistemic scope.
- [references.bib](references.bib) — bibliography.
- [CLAIMS.md](CLAIMS.md) — claim ledger separating derived, machine-checked, classical, counterexample-supported, and explicitly unclaimed statements.

## Main claim

The paper separates five quantities that should not be conflated:

1. equilibrium fitness balance;
2. productive efficiency;
3. maintained mass;
4. structural organization/support;
5. externally declared functional capacity.

The worked model supplies two continuous counterexamples:

- **Integrated hollowing:** productive efficiency and total maintained mass rise while a required functional capacity falls through threshold.
- **One-way extraction:** global equilibrium productivity measures remain unchanged while functional margin is consumed.

For degree-one homogeneous capacities under uniform host dilution,

\[
\kappa_{\rm crit}=M^0,
\]

where \(M^0\) is the host's pre-extraction functional margin.

## Authoritative proofs

The Lean sources are intentionally kept in one place rather than copied into this paper directory:

- [../../formalization/persistence-drift/FunctionalThresholds.lean](../../formalization/persistence-drift/FunctionalThresholds.lean)
- [../../formalization/persistence-drift/EquilibriumExposure.lean](../../formalization/persistence-drift/EquilibriumExposure.lean)
- [../../formalization/persistence-drift/FunctionalCompetition.lean](../../formalization/persistence-drift/FunctionalCompetition.lean)
- [../../formalization/persistence-drift/ReturnPathPrice.lean](../../formalization/persistence-drift/ReturnPathPrice.lean)

The paper-specific threshold proof state was verified at commit:

    eadc51028da96fd7e92fe38af66b61743bae10a0

See [REPRODUCIBILITY.md](REPRODUCIBILITY.md) for theorem names and build commands.

## Scope

This is a **counterexample/methods paper**, not a claim to new Perron-Frobenius or resource-competition mathematics. The contribution is the diagnostic separation of quantities that are easily conflated in models of self-maintaining organization and the demonstration, within one model, that their implications can diverge.

Lean verifies mathematical consequences of stated assumptions. It does not validate the empirical interpretation of a capacity map or threshold.

## License

The repository-level license applies.
