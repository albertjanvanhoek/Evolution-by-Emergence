# Maintaining the Edges of Learning

## Inside verbs, outside geometry, and the velocity of corrigible intelligent networks

Focused intelligent-network paper in the Evolution by Emergence programme.

### Scope

This paper deliberately fixes both **scale** and **meta-level**.

- **Scale:** nodes are intelligent agents; edges are interaction channels between agents.
- **L0:** content learning — beliefs, skills, models, solutions.
- **L1:** learning-maintenance — processes that form, maintain, use, and restore the edges through which correction can occur.
- **L2:** learning how to improve those learning-maintenance processes.

The paper focuses on **L1**.

It therefore does **not** treat a brain's neurons, an LLM's internal weights, cells in an organism, and people in a society as the same empirical system. Those may instantiate related higher-level EbE dynamics, but they belong to different scales.

### Central question

> **How do intelligent networks maintain the edges through which they learn?**

The paper uses two descriptions of the same network dynamics.

**Inside:** agents seek, listen, signal faithfully, expose uncertainty, test, revise, maintain disagreement, maintain edges, repair, re-engage, retain, and recombine.

**Outside:** the network has a changing directed accessibility-cost geometry. Edges and collective transitions can be more or less accessible, plastic, viscous, persistent, repairable, and fast.

The bridge is application-specific:

\[
P_t \xrightarrow{\Gamma} C_t.
\]

No learning verb is assumed to have a universally positive effect.

### Central proposition

> **An informative relationship has value not only because of what travels across it now, but because preserving it can retain a route through which either participant may be corrected later.**

This does not imply that every relationship should be preserved, that more contact is always beneficial, or that trust should be unconditional. The proposed target is **selective corrigibility**: low resistance to evidence-supported correction while retaining sufficient resistance to unsupported perturbation.

### Files

- `manuscript.md` — full working manuscript.
- `FORMAL_VERIFICATION.md` — mapping from paper claims to the existing Lean formalization.
- `LITERATURE_POSITIONING.md` — closest neighboring literatures, prior-art boundaries, and novelty claim.
- `../learning-conditions-for-learning/` — broader intelligent learning-maintenance framework from which this focused agent-network paper is specialized.
- `../functional-organization-ratchet-velocity/` — universal/outside functional-rate companion.

### Formal sources

The paper reuses existing checked results rather than creating a new universal theorem layer:

- `formalization/cumulative-accessibility/CumulativeAccessibility/QuantitativeAccessibility.lean`
- `formalization/cumulative-accessibility/CumulativeAccessibility/IntelligentLearningMaintenance.lean`
- `formalization/cumulative-accessibility/CumulativeAccessibility/FunctionalRatchetVelocity.lean`
- `formalization/cumulative-accessibility/CumulativeAccessibility/RatchetVelocityLedger.lean`
- `formalization/cumulative-accessibility/CumulativeAccessibility/BoundedUpdateRate.lean`
- `formalization/cumulative-accessibility/CumulativeAccessibility/SearchValidationTradeoff.lean`

### Review targets

The highest-value criticisms are:

1. Does fixing the scale at agent-to-agent interaction remove the ambiguity that affected the broader learning paper?
2. Can edge accessibility/viscosity be operationalized without collapsing distinct constructs such as trust, psychological safety, communication fidelity, and contact frequency?
3. Is the distinction between content disagreement at L0 and maintenance of correction channels at L1 empirically useful?
4. Under what conditions does preserving an informative edge actually reduce future correction cost?
5. Does repair measurably restore future learning opportunity rather than merely subjective trust?
6. Is the proposed “informational option value” of an edge identifiable in longitudinal experiments?
7. Can multi-agent LLM and human-group experiments distinguish immediate performance from preservation of future learnability?
8. Does existing collective-learning, team-learning, or trust-repair theory already contain the same inside/outside construction more directly?

A counterexample, stronger antecedent, failed operationalization, or simpler model is a useful result.
