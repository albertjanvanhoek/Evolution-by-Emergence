# Handoff: EbE Centre — Retained Organization Becomes Causal Structure

This file is the short continuation guide for a researcher or LLM.

## Core invariant

The current centre of Evolution by Emergence is:

> **Retained organization becomes causal structure for future change.**

Equivalent formulation:

> **The system's history becomes part of its transition machinery.**

The minimal recursive form is

\[
\boxed{
G_t
\rightarrow
\mathcal K[G_t,\Gamma_t]
\rightarrow
G'_t
\rightarrow
\mathcal V(G'_t,\Gamma_t)
\rightarrow
G_{t+1}
\rightarrow
\mathcal K[G_{t+1},\Gamma_{t+1}]
}
\]

The decisive second-order condition is

\[
\boxed{
\mathcal K[G_{t+1},\Gamma_{t+1}]
\neq
\mathcal K[G_t,\Gamma_t].
}
\]

Here:

- \(G_t\): current relational organization;
- \(\Gamma_t\): environment/gradient/opportunity condition;
- \(\mathcal K\): effective transition machinery generating candidate future organization;
- \(G'_t\): candidate reorganization;
- \(\mathcal V\): viability/selection/evaluation consequence;
- retention/reconstruction produces historically available organization \(G_{t+1}\).

## Do not lose the level of abstraction

The network is the mathematical representation of relational organization, not the deepest claim.

Use a network/hypergraph when appropriate:

\[
G=(V,E,\theta).
\]

But do not argue that EbE applies merely because something can be drawn as a graph.

A valid mapping must identify:

1. a relational organization;
2. a mechanism of reorganization;
3. system-level behavior/function;
4. differential continuation;
5. retention/reconstruction;
6. a resulting change in the future transition structure.

The unity claimed is structural, not mechanical.

## Emergence

Emergence is the creative event within the recursive process.

A strict compositional-emergence test is:

\[
E(G,\phi,c)
\iff
G\models_c\phi
\land
\forall K\prec G,\;K\not\models_c\phi.
\]

This is useful but should not be required for every organizational change.

General route:

\[
\text{reorganization}
\rightarrow
\text{changed behavior/function}.
\]

Special emergent route:

\[
\text{reorganization}
\rightarrow
\text{whole-level capability absent from declared parts}.
\]

Compact interpretation:

> **Emergence creates candidates; persistence writes some of them into future dynamics.**

## Accessibility

Accessibility is more general than cost.

A generic finite-horizon object can be written

\[
\mathcal A_T(S\mid G,\Gamma,q),
\]

where \(q\) is the current generative mechanism.

Costed reachability is a specialization:

\[
C_G(H;c)
=
\inf_{\pi:G\leadsto H}\mathbb E[J_c(\pi)].
\]

Depending on the domain, historical retention may change:

- probability of reaching a successor;
- rate;
- energy/resource requirement;
- number of construction steps;
- mutational/developmental distance;
- learning effort;
- search effort;
- coordination/design cost.

Do not promote one of these units into the universal ontology.

## Dynamic Vortex

A minimal self-maintaining loop is

\[
X\rightarrow\phi\rightarrow r\rightarrow\operatorname{maintenance}(X).
\]

The vortex becomes evolutionary when alternative organizations of this loop are differentially retained and thereby alter later \(\mathcal K\).

"Vortex" means a self-reinforcing recursive flow in which organization shapes the conditions of its own continuation and change; it does not mean literal geometric rotation.

## Four grounding examples

### Neural learning

- organization: connectivity/weights/recruitment;
- reorganization: plasticity;
- differential consequence: reward, prediction error, task success, viability;
- retention: stable/recruitable learned organization;
- changed transition machinery: later tasks become easier/harder/differently learnable.

### Autocatalytic chemistry

- organization: reaction-catalysis hypernetwork;
- reorganization: appearance/loss of species, catalysts, pathways;
- differential consequence: kinetic/resource persistence;
- retention: self-regeneration;
- changed transition machinery: catalysts/organization alter later reaction accessibility and rates.

### Biological inheritance

- organization: regulatory/developmental/domain network;
- reorganization: mutation, recombination, duplication, regulatory change;
- differential consequence: viability/reproduction;
- retention: inheritance and developmental reconstruction;
- changed transition machinery: evolved architecture biases future phenotypic variation/evolvability.

### Technology

- organization: components, interfaces, designs, production capabilities;
- reorganization: invention/recombination;
- differential consequence: performance, reliability, cost, adoption;
- retention: designs, standards, manufacturing knowledge;
- changed transition machinery: retained technologies become building blocks for later construction.

## Cost/hierarchy findings

The retention identity remains useful as one specialization.

Let

\[
J(R)=\mathbb E[D_R(Y)]+M(R).
\]

For candidate \(X\):

\[
J(R\cup\{X\})-J(R)
=
\Delta M_R(X)-S_R(X).
\]

Retention is favored when expected future savings exceed marginal maintenance.

For nested reusable modules:

\[
\boxed{
\text{direct reuse value}
+
\text{hierarchical compression value}
>
\text{maintenance cost}.
}
\]

These results explain one route by which retained organization can modify future transition machinery. They do not define EbE as a whole.

## Important corrections already learned

Do not restore the following assumptions:

- persistence determines whether function exists;
- every organizational update must be strictly emergent;
- external validation is universal;
- cost is the universal measure of accessibility;
- retention always helps;
- full closure must expand;
- more retained modules always imply more accessibility;
- cheap caching automatically produces hierarchy;
- complexity must increase monotonically;
- a fixed fundamental generator must change for second-order evolution;
- network representability alone establishes an EbE mapping.

## Simulation status

Exploratory simulations suggested:

- retention can create gains, losses, or both;
- recurrent substructure and maintenance burden jointly matter;
- finite-resource histories produce path dependence and lock-in;
- budgeted accessibility can expand while full closure stays fixed;
- compositional retention can generate nested modules;
- destroying shared substructure largely removes hierarchy;
- expensive references weaken hierarchy.

These results are **not yet reproduced by versioned repository code** and should not be cited as verified results.

## Next theorem target

The next theorem should be formulated around the centre, not around a pre-given hierarchy:

> Given recurrent relational structure, differential retention, and finite construction/maintenance constraints, under what conditions does retained organization necessarily alter the effective transition operator for future organization?

A stronger follow-up can ask when this induces reusable coarse-grained modules and hierarchy.

Only after these semantics are stable should Lean formalization resume.
