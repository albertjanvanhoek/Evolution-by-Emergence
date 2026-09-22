# Handoff: Network-First EbE / Dynamic Vortex

This is the short continuation guide for a researcher or LLM.

## Do not lose this ontology

EbE is currently being treated as a theory of **recursively reorganizing networks under evaluation**.

Do not replace the network with an abstract "capacity", "certification", or pure cost model.

The reference loop is:

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

## Minimal objects

\[
G_t=(V_t,E_t,\theta_t)
\]

Dynamic typed/weighted/attributed network or hypergraph.

\[
\mathcal B(G,c)
\]

Behavior of organization \(G\) in context \(c\).

\[
G\models_c\phi
\]

Functional property \(\phi\) expressed by that behavior.

\[
E(G,\phi,c)
\iff
G\models_c\phi
\land
\forall K\prec G,\;K\not\models_c\phi
\]

Emergence relative to an admissible proper-part relation.

\[
\mathcal E(G,c)
\]

Evaluation: energy/resource balance, reward, fitness, persistence, etc.

\[
C_G(H;c)=\inf_{\pi:G\leadsto H}\mathbb E[J_c(\pi)]
\]

Effective cost of realizing later organization \(H\).

\[
\mathcal R_B(G)=\{H:C_G(H)\le B\}
\]

Budgeted accessibility.

## Second-order statement

\[
G_t\rightarrow C_{G_t}\rightarrow G_{t+1}\rightarrow C_{G_{t+1}}.
\]

Retained products of the generative process change the effective accessibility landscape of subsequent generation.

The physical generator may remain fixed.

## Dynamic Vortex

Primitive loop:

\[
X\rightarrow\phi\rightarrow r\rightarrow\operatorname{maintenance}(X).
\]

Evolution acts on the organization of this self-maintaining loop.

"Vortex" means self-reinforcing recursive flow through organization space, not literal geometric rotation.

## Cost/hierarchy findings

The key retention identity is:

\[
J(R\cup\{X\})-J(R)=\Delta M_R(X)-S_R(X),
\]

where \(S_R(X)\) is expected future saving and \(\Delta M_R(X)\) is marginal retention/maintenance cost.

Retention is favored when expected reuse/compression savings exceed maintenance.

For a hierarchy, lower-level modules can be retained for two reasons:

\[
\boxed{
\text{direct reuse value}
+
\text{representation/compression value}
>
\text{maintenance cost}.
}
\]

A pure scaffold can have zero direct task value but remain optimal because it lowers the cost of representing/maintaining later organization.

## Important falsifications / corrections

Do **not** restore these discarded assumptions:

- emergence requires external certification;
- non-emergence means no function;
- persistence determines whether function exists;
- retained organization necessarily expands full closure;
- every retained module helps;
- more retained structure is always better;
- hierarchy follows automatically from cheap caching;
- the evaluator must be energy or any one universal unit.

## Simulation status

Exploratory computational results discussed during theory development suggested:

- arbitrary retention often creates burden rather than gain;
- repeated reuse and low maintenance predict beneficial retention;
- path dependence and lock-in can arise with finite resources;
- Boolean circuits can expand budgeted functional accessibility while full closure stays fixed;
- compositional retention can generate nested reusable modules;
- destroying cross-task repeated substructure collapses most hierarchy;
- making references expensive weakens hierarchy.

**These numerical results are not yet reproduced by versioned code in this repository. Do not cite them as verified results.**

## Grounding status

Strongest current fits:

- technology;
- inherited/recombinant biological modules.

Good but more careful:

- neural learning (distributed representation);
- autocatalytic chemistry (strong for network/persistence/accessibility, weaker for generic symbolic hierarchy).

## Next theorem target

Remove the pre-given hierarchy.

Given only:

1. a distribution of recurrent network constructions;
2. a cost of reconstructing subgraphs;
3. a cost of retaining/referencing them;

derive sufficient conditions under which an optimal repertoire **discovers recurrent suborganizations** and constructs a nested hierarchy.

Only after this network-level theorem and semantics are stable should Lean formalization resume.
