# Working Theory: Recursive Network Organization under Evaluation

> **Status:** conceptual and mathematical research checkpoint.  
> **Not yet:** a final theory, a novelty claim, or a completed Lean formalization.

## 1. Core commitment: the network is the ontology

The universal abstraction is a dynamic network, preferably represented broadly enough to include typed, weighted, attributed, and multiway interactions:

\[
G_t=(V_t,E_t,\theta_t).
\]

A typed attributed hypergraph is a likely implementation because an interaction may involve more than two components.

**Organization is network configuration.**

Different substrates instantiate the same abstract language with different node types, edge types, time scales, and dynamical laws.

Examples:

- brain: neurons/regions, synapses, weights, activation/plasticity;
- chemistry: species, reactions, catalysis, concentrations/rates;
- biology: genes, proteins, domains, cells, regulatory and structural interactions;
- technology: components, interfaces, dependencies, production relations.

## 2. Reorganization

A transformation is

\[
G_t \xrightarrow{\rho} G_{t+1}.
\]

The transformation \(\rho\) may add or remove nodes/edges, change weights, connect modules, duplicate motifs, alter interaction parameters, or otherwise change organization.

This is the structural layer of learning/evolution.

## 3. Behavior and function

Let

\[
\mathcal B(G,c)
\]

denote behavior produced by network organization \(G\) in context \(c\).

A functional predicate \(\phi\) is expressed when

\[
G\models_c\phi
\iff
\phi(\mathcal B(G,c))=1.
\]

Function is therefore not an externally certified label. It is derived from organization plus context through behavior.

### Emergence

For an admissible proper-part relation \(K\prec G\),

\[
E(G,\phi,c)
\iff
G\models_c\phi
\land
\forall K\prec G,\;K\not\models_c\phi.
\]

This is relative to decomposition scale, admissible interventions, context, and measured behavior.

## 4. Evaluation

Network variants are not all retained equally.

Introduce an evaluation functional

\[
\mathcal E(G,c).
\]

Its physical interpretation is domain-specific. It may reflect net energy/resource balance, reproductive success, task reward, prediction-error reduction, reliability, economic value, or persistence itself.

The universal statement is only that evaluation biases persistence/reproduction/maintenance.

At the most primitive level, \(\mathcal E(G,c)>0\) may mean that \(G\) maintains or reconstructs enough of the organization required for its continuation.

Evaluation must remain distinct from emergence:

- **emergence:** what the organization does;
- **evaluation:** what happens to the organization because of its interaction with context.

## 5. Retention

"Retention" is broader than physical survival of the same object. It includes any mechanism that keeps organization reproducibly accessible:

- stable synaptic organization;
- self-maintaining chemistry;
- hereditary encoding and developmental reconstruction;
- stored design and manufacturing capability;
- reusable software/module interfaces.

A retained subnetwork can often be treated as an effective higher-scale unit:

\[
A+B+C\rightarrow X,\qquad X+D\rightarrow Y.
\]

The physical details inside \(X\) have not vanished; the network has acquired a stable mesoscopic organization with an interface.

## 6. Accessibility geometry

For a current network \(G\), define

\[
C_G(H;c)
=
\inf_{\pi:G\leadsto H}\mathbb E[J_c(\pi)],
\]

the minimum expected cost of realizing organization \(H\) from \(G\) in context \(c\).

The cost functional \(J_c\) is explicitly domain-specific. It may use energy, material, time, search effort, mutation/developmental accessibility, money, computation, or a declared combination.

The abstraction is the optimization structure, not a universal physical unit.

Budgeted reachability is

\[
\mathcal R_B(G)
=
\{H:C_G(H)\le B\}.
\]

This is distinct from unlimited logical closure.

A retained organization can leave infinite closure unchanged while moving targets across a finite accessibility boundary.

## 7. Second-order evolution

First-order change occurs within the effective landscape induced by the current network.

Second-order evolution occurs when products of the process are retained in a form that changes that landscape:

\[
G_t
\rightarrow
C_{G_t}
\rightarrow
G_{t+1}
\rightarrow
C_{G_{t+1}}.
\]

The fundamental physical rules need not change.

A concise working definition is:

> **Second-order evolution occurs when retained products of a generative process change the effective accessibility landscape of subsequent generation.**

## 8. Dynamic Vortex

The Dynamic Vortex couples organization, behavior, evaluation, resource flow, retention, and further organization.

A primitive self-maintaining loop is

\[
X
\rightarrow
\phi
\rightarrow
r
\rightarrow
\operatorname{maintenance}(X).
\]

If alternative organizations \(X'\) alter the loop and are differentially retained, the loop itself evolves.

The system is therefore not merely climbing a fixed potential. The network changes the landscape while the landscape shapes the network:

\[
G_t
\rightarrow
\mathcal E_{G_t}
\rightarrow
G_{t+1}
\rightarrow
\mathcal E_{G_{t+1}}.
\]

This feedback is the mathematically defensible content of "vortex-like".

## 9. Cost compression and reusable organization

Suppose a retained organization \(X\) lowers the cost of later construction. Then, for some target \(Y\),

\[
C_{G\oplus X}(Y)<C_G(Y).
\]

This can occur because \(X\) can be reused directly, provides a catalyst, is callable as a learned skill, is reconstructible developmentally, or can be instantiated from a retained design.

The associated accessibility gain can be meaningful even if full closure is unchanged.

## 10. Hierarchical retention

Let \(R\) denote the retained repertoire of reusable subnetworks/modules.

Let

\[
D_R(X)
\]

be the minimum representation/construction cost of organization \(X\) using references to retained members of \(R\).

Then

\[
R\subseteq R'
\Rightarrow
D_{R'}(X)\le D_R(X).
\]

If retained module \(A\) makes later module \(B\) cheaper to retain or represent, \(A\) can have second-order value even with no direct task value.

This creates a possible hierarchy:

\[
A_1\prec A_2\prec\cdots\prec A_k.
\]

Network interpretation:

\[
\text{nodes}
\rightarrow
\text{motifs}
\rightarrow
\text{modules}
\rightarrow
\text{modules of modules}.
\]

The "dictionary" language is computational shorthand for stable/reusable network modules and coarse-graining.

## 11. What the current theory does not claim

It does not currently claim that:

- every retained organization is beneficial;
- every emergent function is retained;
- full logical closure must expand;
- the fundamental generator must mutate;
- every system produces arbitrarily deep hierarchy;
- all evaluators reduce to energy;
- all costs can be expressed in one common physical unit;
- every chemical system implements a symbolic grammar;
- current results establish scientific novelty.

## 12. Four-domain grounding

### Neural learning

- \(G\): neural connectivity/weights/dynamics;
- reorganization: plasticity and recruitment changes;
- function: behavioral/computational capability;
- evaluator: reward, prediction error, task performance, metabolic constraints;
- retention: persistent/recruitable learned organization;
- accessibility: effort/cost of learning or executing later capabilities.

Strong fit to the second-order network idea. Literal symbolic dictionary interpretation remains tentative because neural representations are distributed.

### Autocatalytic chemistry

- \(G\): reaction/catalysis hypernetwork with concentrations/rates;
- reorganization: appearance/loss of species and catalytic pathways;
- function: collective production/self-maintenance;
- evaluator: resource/energy balance and persistence;
- retention: continued self-generation of relevant organization;
- accessibility: kinetic/material/free-energy cost of further reactions.

Strong fit to network emergence, persistence, and changed accessibility. Generic deep dictionary hierarchy should not be assumed.

### Biological inheritance / protein organization

- \(G\): heritable regulatory/structural network and reusable protein/domain organization;
- reorganization: mutation, duplication, recombination, fusion/fission, regulatory change;
- function: molecular/developmental phenotype;
- evaluator: differential survival/reproduction;
- retention: heredity plus reconstruction through development;
- accessibility: mutational/developmental/energetic route cost.

Strong fit to retained reusable modules and modules-of-modules.

### Technology

- \(G\): components, interfaces, designs, production capabilities;
- reorganization: invention and recombination;
- function: device/system behavior;
- evaluator: usefulness, reliability, resource cost, market/institutional selection;
- retention: standards, designs, components, manufacturing capability, know-how;
- accessibility: design/manufacturing/search/coordination cost.

Very strong fit to hierarchical reusable organization and effective vocabulary growth.

## 13. Open mathematical questions

1. What is the minimal network/hypergraph ontology that covers the intended domains without becoming vacuous?
2. What exactly is the admissible proper-part/intervention relation for emergence?
3. How should behavioral semantics \(\mathcal B(G,c)\) be specified generically?
4. Can evaluation \(\mathcal E\) be treated abstractly without smuggling in success assumptions?
5. Under what conditions does a stable subnetwork become a legitimate higher-scale effective node?
6. Can costed reachability handle resource sharing, reliability, and maintenance correctly?
7. Can the hierarchy theorem be generalized from a pre-given chain to arbitrary recurrent subgraph distributions?
8. What dynamical conditions distinguish a genuine Dynamic Vortex from ordinary optimization on a fixed landscape?
9. How do path dependence, lock-in, forgetting, and destructive retention alter the ratchet?
10. Which claims are already covered by network science, evolvability, autocatalytic-set theory, grammar compression, materialized-view selection, multilevel networks, and related literatures?

## 14. Current reference spine

Until superseded by a stronger, tested architecture, future formal work should preserve:

\[
\boxed{
\text{network reorganization}
\rightarrow
\text{emergent function}
\rightarrow
\text{evaluation}
\rightarrow
\text{differential persistence}
\rightarrow
\text{retained organization}
\rightarrow
\text{changed future accessibility}
\rightarrow
\text{further reorganization}
}
\]

The recent cost and hierarchy theorems are **subresults about changed future accessibility**, not substitutes for the complete EbE architecture.
