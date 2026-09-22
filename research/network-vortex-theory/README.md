# Retained Organization and the Dynamic Vortex — working EbE architecture

> **Status: working compression of the recurring EbE pattern — not yet the final formal theory.**
>
> This directory preserves the current centre of the theory so later formalization cannot silently replace it with a narrower cost, validation, or closure model.

## Centre

Evolution by Emergence (EbE) is currently organized around one proposed invariant:

> **Retained organization becomes causal structure for future change.**

Equivalently:

> **The system's history becomes part of its transition machinery.**

The compact recursive form is

\[
\boxed{
G_t
\longrightarrow
\mathcal K[G_t,\Gamma_t]
\longrightarrow
G'_t
\longrightarrow
\mathcal V(G'_t,\Gamma_t)
\longrightarrow
G_{t+1}
\longrightarrow
\mathcal K[G_{t+1},\Gamma_{t+1}]
}
\]

where:

- \(G_t\) is current relational organization;
- \(\Gamma_t\) is the relevant surrounding condition, gradient, or opportunity structure;
- \(\mathcal K[G_t,\Gamma_t]\) is the **effective transition machinery**: the distribution/rules/costs by which future organization can be generated from the present;
- \(G'_t\) is candidate reorganization;
- \(\mathcal V\) is its viability/selection/evaluative consequence;
- retention/reconstruction produces the historically available organization \(G_{t+1}\).

The distinctive recursive event is

\[
\boxed{
\mathcal K[G_{t+1},\Gamma_{t+1}]
\neq
\mathcal K[G_t,\Gamma_t].
}
\]

The process has changed the conditions of its own future change.

## Why a network still matters

A network or hypergraph is the minimal mathematical compression used here for **relational organization**:

\[
G=(V,E,\theta).
\]

This does **not** assert that reality is literally a graph. It asserts that when components and relations among them matter to what a system can do, network language is a compact substrate-neutral representation.

Representability as a network is not enough for EbE. A real application must identify mechanistically:

1. relational organization;
2. how that organization changes;
3. how organization affects behavior/function;
4. what produces differential continuation;
5. how organization is retained or reconstructed;
6. how that retained history changes later transition possibilities.

## Role of emergence

Emergence is the creative event inside the loop, not the whole loop.

Existing organization can combine/reorganize into a configuration with changed or new system-level capability. A strict compositional-emergence predicate is one important special case:

\[
E(G,\phi,c)
\iff
G\models_c\phi
\land
\forall K\prec G,\;K\not\models_c\phi.
\]

Not every useful organizational update must satisfy this strict predicate.

A compact distinction is:

> **Emergence creates candidates; persistence writes some of them into future dynamics.**

## Role of accessibility, cost, and hierarchy

The present organization induces a future accessibility structure. One general representation is a finite-horizon accessibility kernel

\[
\mathcal A_T(S\mid G,\Gamma,q),
\]

the chance or degree to which persistent successor organization in \(S\) can be realized within horizon \(T\).

Costed reachability is an important specialization:

\[
C_G(H;c)=\inf_{\pi:G\leadsto H}\mathbb E[J_c(\pi)].
\]

Retention may therefore change future accessibility by changing probability, rate, energy, number of construction steps, mutation/developmental distance, learning effort, design effort, or another declared route measure.

The recent retention and hierarchy theorems are **subresults of this accessibility change**, not the ontology of EbE.

## Dynamic Vortex

The Dynamic Vortex is the self-maintaining version of the recursion.

A minimal loop is

\[
X\rightarrow\phi\rightarrow r\rightarrow\operatorname{maintenance}(X),
\]

where organization produces function, function affects resource/continuation conditions, and those conditions maintain or reconstruct the organization.

When variants of the loop are differentially retained, the organization of the loop evolves.

Thus the system is not merely moving on a fixed landscape. Its retained history can change the channel through which later movement occurs.

## Cross-domain interpretation

The same abstract positions can be occupied by different mechanisms:

| Role | Neural learning | Chemistry | Biological inheritance | Technology |
|---|---|---|---|---|
| relational organization | neural connectivity/dynamics | reaction-catalysis network | regulatory/developmental/module network | component/interface/production network |
| reorganization | plasticity/learning | reaction-network change | mutation/recombination/development | invention/recombination |
| differential consequence | reward/error/viability | kinetic/resource persistence | reproduction/viability | performance/adoption/cost |
| retention | learned organization | self-regeneration | heredity/reconstruction | design/standard/manufacture |
| changed future machinery | learnability | reaction accessibility | evolvability/developmental bias | constructibility |

The mechanisms differ. The proposed unity is structural.

## Files

- [WORKING_THEORY.md](WORKING_THEORY.md) — canonical current compression and definitions.
- [HANDOFF.md](HANDOFF.md) — continuation guide for a researcher or LLM.
- [theorem-notes/README.md](theorem-notes/README.md) — current retention/hierarchy theorem program.
- [simulations/README.md](simulations/README.md) — exploratory computational results and reproduction requirements.

## Guardrail

A future formalization has drifted away from the current EbE centre if it cannot still express:

\[
\boxed{
\text{retained organization}
\rightarrow
\text{changed effective transition machinery}
\rightarrow
\text{changed future organization}.
}
\]

Lean should come after that semantic relationship is fixed.
