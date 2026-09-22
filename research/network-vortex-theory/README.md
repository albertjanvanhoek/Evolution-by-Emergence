# Network Vortex Theory — working EbE architecture

> **Status: working mathematical architecture — not yet the formal EbE theory.**
>
> This directory records the current reasoning so that later formalization cannot silently change the ontology.

This research checkpoint preserves the current direction of **Evolution by Emergence (EbE)** after an explicit reset of the mathematical language.

The central decision is:

> **The network remains the universal abstraction layer.**

Costs, energy, reward, fitness, persistence, and description length are evaluative or accessibility quantities defined *over* network organization. They do not replace the network ontology.

## Reference architecture

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

A compact second-order form is

\[
G_t
\rightarrow
(C_{G_t},\mathcal E_{G_t})
\rightarrow
G_{t+1}
\rightarrow
(C_{G_{t+1}},\mathcal E_{G_{t+1}})
\rightarrow\cdots
\]

where:

- \(G_t\) is the current network organization;
- \(\mathcal E\) is an evaluator (energy balance, reward, fitness, persistence, existence, etc.);
- \(C_G(H)\) is the effective cost of reaching organization \(H\) from network \(G\).

The theory is **not** that the fundamental physical generator must change. The retained network can instead change the *effective accessibility geometry* of later reorganization.

## Dynamic Vortex interpretation

The "vortex" is not literal rotation. It is the feedback loop by which organization changes the landscape that in turn shapes future organization.

A minimal self-maintaining loop is

\[
X \rightarrow \phi \rightarrow r \rightarrow \operatorname{maintenance}(X),
\]

where organization \(X\) produces function \(\phi\), which captures or generates resources \(r\), which maintain \(X\).

The evolutionary extension is that variants of such loops can be differentially retained, so the organization of the loop itself changes over time.

## Files

- [WORKING_THEORY.md](WORKING_THEORY.md) — canonical current architecture and equations.
- [HANDOFF.md](HANDOFF.md) — short continuation guide for a researcher or LLM.
- [theorem-notes/README.md](theorem-notes/README.md) — current theorem program and algebraic results.
- [simulations/README.md](simulations/README.md) — exploratory computational findings and reproducibility status.

## Discipline for future work

A proposed formalization has drifted away from EbE if it loses any of the following:

1. **network organization** as the primary object;
2. **emergent behavior/function** arising from organization;
3. **evaluation** that biases persistence;
4. **retention/reproducibility** of organization;
5. **changed future accessibility** caused by retained organization;
6. **recursive feedback** from current organization into the conditions of future reorganization.

Lean should be used only after these semantics are fixed.
