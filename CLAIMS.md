# CLAIMS

Machine-readable-oriented claim ledger for agentic evaluation.

## Fields
- **claim_id**: stable identifier
- **claim**: concise proposition
- **source_files**: where this is discussed
- **evidence_type**: conceptual, formal, empirical-programmatic, or mixed
- **falsification_path**: concrete way to challenge/test the claim
- **evaluation_prompt**: reusable prompt skeleton for autonomous evaluators


## Current theory core ledger — September 2026

The canonical prose statement is [THEORY.md](THEORY.md). Exact theorem names,
formal status, and proof boundaries are in
[FORMAL_THEORY_MAP.md](FORMAL_THEORY_MAP.md).

These claims are intentionally narrower than "Evolution by Emergence is true in
every domain." The final universality claim remains a research programme.

| claim_id | claim | source_files | evidence_type | falsification / review path |
|---|---|---|---|---|
| CLM_EBE_CORE_001 | Productive organization is downstream of encounter, association persistence, and conversion; reduced affinity models can have exact intermediate optima under stated mechanisms. | \`THEORY.md\`; \`papers/affinity-before-accessibility/\`; \`formalization/affinity-layer/AffinityLayer.lean\` | Machine-checked reduced models + interpretation | Find empirical/model classes where the proposed affinity mechanisms fail, or show the pre-accessibility decomposition hides the relevant causal variable. |
| CLM_EBE_CORE_002 | Recurrent interaction can maintain a positive organization even when components are individually subcritical; exact finite dyad/three-cycle thresholds are machine checked. | \`formalization/collective-alignment/MaintenanceReproduction.lean\`; \`MaintenanceDynamics.lean\` | Machine checked | Produce a counterexample to the exact finite theorem or show the finite-cycle abstraction is inappropriate for the target system. |
| CLM_EBE_CORE_003 | For a declared organization/gradient ledger, internal slack is captured throughput minus maintenance; higher uptake and/or lower maintenance cannot reduce slack. | \`EndogenousBudgetBridge.lean\`; \`DYNAMIC_OVERVIEW.md\` | Machine checked conditional ledger | Challenge the uptake/maintenance decomposition or its empirical measurability in an application. |
| CLM_EBE_CORE_004 | Recurring opportunity plus bounded resource-feasible validated response can produce recurrent validated uptake; opportunity, resource feasibility, validation, and retention are logically distinct. | \`ResponseDynamics.lean\`; \`BoundedResponseWitness.lean\`; \`ValidatedUptake.lean\` | Machine checked + separation witnesses | Find a hidden implication between predicates or a missing causal variable that invalidates the chosen interface. |
| CLM_EBE_CORE_005 | Retained generated organization can become parent material for later generation, making history causally relevant to later accessibility. | \`GenerativeClosure.lean\` | Machine checked witness | Show the retained-history interpretation does not survive turnover/recovery models, or construct an equivalent nonhistorical representation. |
| CLM_EBE_CORE_006 | Retained module change or generator-rule change can strictly expand future search; viable state transitions can therefore be second-order accessibility clicks. | \`ModuleGeneratedEvolvability.lean\`; \`GeneratorRuleEvolution.lean\`; \`RecursiveAccessibility.lean\` | Machine checked | Attack the mapping from model state to search operator or show the strict-expansion criterion is insufficient for evolvability. |
| CLM_EBE_CORE_007 | The integrated dynamic-vortex interface composes endogenous resource-funded response with recurring second-order organizational updates; under explicit retention/representation assumptions it yields open-ended retained novelty, unbounded envelope capacity, and recurring second-order updates. | \`DynamicVortex.lean\`; \`DynamicVortexWitness.lean\` | Machine checked + concrete witness | Test whether the response→physical-state-update premise is tautological, overly strong, or mechanistically unjustified in useful applications. |
| CLM_EBE_CORE_008 | Under specific competition/cost assumptions, cheaper functionally equivalent implementations release slack and can increase search; state-dependent return paths can nevertheless overwhelm the ordinary positive selection component. | \`PersistenceDrift.lean\`; \`FunctionalCompetition.lean\`; \`ReturnPathPrice.lean\` | Machine checked toy models | Relax equivalence/cost laws or introduce state feedback and test whether the directional result survives. |
| CLM_EBE_CORE_009 | Persistence, function, selected control, sufficient control, capacity, and realized novelty are distinct quantities; persistence or selection alone does not define success. | \`EquilibriumExposure.lean\`; \`FunctionalThresholds.lean\`; \`RegulatoryReturn.lean\`; \`CollectiveAlignment.lean\`; \`OpenEndedCapacity.lean\` | Machine-checked separations + declared functional criteria | Provide a theorem or empirical domain in which the coordinates collapse under justified assumptions. |
| CLM_EBE_CORE_010 | A fixed finite distinguishability universe saturates; open-ended cumulative retained novelty requires unbounded effective distinguishability capacity in the stated representation model. | \`FiniteGenerativeSaturation.lean\`; \`OpenEndedCapacity.lean\` | Machine checked | Find a counterexample under the exact definitions or identify a weaker capacity condition sufficient for the same open-endedness notion. |
| CLM_EBE_CORE_011 | Under explicit physical speed/action assumptions, bounded finite-time resources bound fixed-resolution organizational depth; recursive accessibility does not imply finite-time physical explosion. | \`verification/organizational-depth/OrganizationalDepth.lean\`; \`OperationalBridge.lean\`; \`PackingDepth.lean\` | Machine checked conditional physical theorem | Challenge the speed-law hypothesis, operational metric bridge, budget decomposition, or fixed-resolution definition. |
| CLM_EBE_CORE_012 | EbE's broad cross-domain claim is best treated as a synthesis/architecture research programme, not as a machine-checked universality theorem or a collection of wholly novel mechanisms. | \`THEORY.md\`; \`verification/audits/2026-09-15-literature/\` | Literature-audited synthesis / interpretive claim | Identify a stronger antecedent for the integrated architecture, or domains where the architecture adds no explanatory or predictive value over established formulations. |
| CLM_EBE_CORE_013 | Accessibility has a quantitative directed cost geometry: if a retained organizational change weakly lowers every declared target cost and strictly lowers at least one, then some budget threshold exhibits strict binary accessibility expansion. | `QuantitativeAccessibility.lean`; `papers/learning-conditions-for-learning/` | Machine checked + concrete witness | Challenge the cost-order formalization, exhibit a counterexample under the exact definitions, or show that an alternative quantitative object captures the intended accessibility concept with fewer assumptions. |
| CLM_EBE_CORE_014 | For intelligent networks, an internal learning-maintenance process state can be separated from the outside accessibility geometry through an application-specific map; endogenous self-improvement requires a system-generated process change. A stronger rate-grounded recursive test additionally requires preservation of declared prior functions and a strictly better normalized held-out functional-learning rate profile from a matched starting organization. | `IntelligentLearningMaintenance.lean`; `papers/learning-conditions-for-learning/` | Machine-checked interface + modelling/empirical programme | Show that the process/geometry separation is tautological or unidentifiable, or that the matched rate test fails to distinguish process improvement from task difficulty, environmental mismatch, or ordinary learning. |
| CLM_EBE_CORE_015 | Organizational state and functional target can be separated formally. If retained organizational change weakly lowers every declared functional target cost and strictly lowers at least one, then some budget threshold exhibits strict functional-repertoire expansion. Functional gain can be normalized by a positive time/resource interval to define a target-wise ratchet-rate profile. Qualitative recurrence alone does not imply a positive speed floor; with bounded opportunity gap K and bounded validated-response lag Δ, every window of width K+Δ+1 contains a validated update. The maintained three-cycle gives K=0 under an explicit support→opportunity bridge, and a further minimum-gain premise yields a functional-gain certificate in every Δ+1 window. | `FunctionalRatchetVelocity.lean`; `RatchetVelocityLedger.lean`; `BoundedUpdateRate.lean`; `papers/functional-organization-ratchet-velocity/` | Machine checked + concrete witness + conditional mechanism ledger + research programme for dynamics | Challenge the organization/function type separation, the cost operationalization, the Pareto-like retained criterion, rate normalization, or show that an established formalism already captures the same cost-geometric rate object more directly. |

### Current core non-claims

The current theory does not infer:

- function from persistence;
- truth from external validation;
- improvement from novelty;
- progress from selection;
- empirical causality from a satisfiability witness;
- physical free energy from dimensionless accessibility margin;
- moral obligation from persistence;
- universality from cross-domain analogy;
- novelty of individual mechanisms merely because they are placed in EbE notation;
- value from lower transition cost without a declared target criterion;
- universal causal effects from intelligent-network labels such as honesty, repair, forgiveness, or diversity;
- function uniquely from static network structure;
- or a universal scalar amount of organization from the functional cost geometry.

---

## Earlier/application claim ledger

The stable claim IDs below are retained for compatibility with earlier agentic
evaluation workflows. Some are broader application or governance hypotheses and
should not be confused with the current machine-backed core above.


| claim_id | claim | source_files | evidence_type | falsification_path | evaluation_prompt |
|---|---|---|---|---|---|
| CLM_EBE_001 | Emergence-driven evolutionary dynamics are not limited to biology and can model social and artificial systems. | `README.md`; `Chapters/Chapter_1.tex`; `Chapters/Chapter_9.tex` | Conceptual + cross-domain synthesis | Provide a domain where network/feedback framing fails to explain persistence or adaptation better than non-network alternatives. | "Given domain X, compare EbE-style network explanation vs baseline linear explanation. Which predicts outcomes better and why?" |
| CLM_EBE_002 | Intelligence viability is constrained by layered substrate dependency I->B->R->P. | `README.md`; `Chapters/Chapter_6.tex`; `Backmatter/Appendix26.tex` | Formal-conceptual | Show a persistent intelligence model that maximizes long-run performance while violating one substrate floor. | "Evaluate strategy S for explicit B/R/P floor violations and estimate downstream failure risk over horizon H." |
| CLM_EBE_003 | O1/O2/O3 follow functionally from the dependency model (not merely from normative preference). | `README.md`; `Backmatter/Appendix26.tex` | Formal argument | Derive alternative operators from same premises that achieve equal or better viability without O1/O2/O3 properties. | "From stated premises, derive minimal operator set; test whether O1/O2/O3 are necessary, sufficient, or replaceable." |
| CLM_EBE_004 | SCAP operationalizes O1/O2/O3 into implementable governance blocks. | `README.md`; `Backmatter/Appendix.tex`; `Backmatter/AppendixIII.tex` | Operational mapping | Identify SCAP blocks that do not map cleanly to O1/O2/O3 or yield contradictory incentives under realistic constraints. | "Map each SCAP block to O1/O2/O3, list missing links/conflicts, and propose revisions." |
| CLM_EBE_005 | Better proof economies (cheap verification, costly deception) improve persistence quality in complex systems. | `README.md`; `Backmatter/Appendix26.tex` | Theory with empirical implications | Produce cases where stronger verification infrastructure worsens long-horizon persistence after controlling for context. | "Assess system Y before/after verification reforms; estimate persistence, trust, and adaptation deltas." |
| CLM_EBE_006 | Stress weakens checking loops and increases contaminated updates ("mud"), raising decision error rates. | `README.md`; `Backmatter/appendixXI.tex`; `Backmatter/appendixXII.tex` | Mechanistic hypothesis | Show robust datasets where stress increase is not associated with degraded checking quality or error increase. | "For cohort/data Z, test correlation/causal link between stress markers and model-update/decision quality metrics." |
| CLM_EBE_007 | Collective alignment is usefully modeled as a task- and horizon-specific viability region of the interaction architecture rather than as perfect agreement or perfect behavior by every node. | `papers/sufficient-alignment/manuscript.md`; `papers/sufficient-alignment/SCAP_V2.md` | Formal-conceptual framework | Construct tasks where the proposed architecture variables fail to predict collective accessibility, or where node-level conformity outperforms protocol-level alignment after controlling for information diversity and cost. | "For network N and task U, define a performance threshold and test whether a nontrivial alignment viability region predicts success better than node-level conformity." |
| CLM_EBE_008 | On a declared cooperative corrective edge, deterministic garbling of task-relevant information cannot expand attainable decision value; redundant correction can convert imperfect component reliability into higher network reliability. | `papers/sufficient-alignment/manuscript.md`; `formalization/collective-alignment/CollectiveAlignment.lean` | Formal + classical-theorem specialization | Violate the common-objective/information assumptions or introduce correlated errors and show when the conclusion no longer holds; empirically test whether improving signal fidelity or independent correction channels improves joint performance. | "Identify the cooperative objective, signal channel, and error correlation structure; test the signal-fidelity and redundancy predictions." |
| CLM_EBE_009 | A collaboration/correction protocol must itself be maintained and reproduced across agent turnover; in the minimal carrier model (R_{protocol}=mp), expected carrier counts grow above one and decline below one, while repair is optimal only inside an explicit value-of-repair region. | `papers/sufficient-alignment/manuscript.md`; `papers/sufficient-alignment/SCAP_V2.md`; `formalization/collective-alignment/CollectiveAlignment.lean` | Formal toy models + synthesis | Test protocol transmission and repair in real or simulated learning networks; estimate whether persistence changes across the predicted thresholds and whether recurrence/exploitation invalidates the simple repair model. | "Estimate transmission, repair, and outside-option parameters for system X; compare observed protocol persistence and edge repair to the model thresholds." |

## Suggested evaluator output schema (JSON)

```json
{
  "claim_id": "CLM_EBE_003",
  "result": "supported|mixed|challenged",
  "confidence": 0.0,
  "supporting_evidence": ["..."],
  "counterevidence": ["..."],
  "assumptions": ["..."],
  "next_tests": ["..."]
}
```

