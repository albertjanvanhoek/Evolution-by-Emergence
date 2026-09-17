# Sufficient Alignment

## A Viability Framework for Collective Intelligence

This package develops the collective-intelligence interpretation of SCAP and the Theory of Long-Term Collaboration.

## Core idea

Alignment is treated as a **viability region**, not a requirement that every node behave perfectly or hold the same model.

For a network \(N\), collaboration architecture \(C\), target \(U\), horizon \(H\), and required success level \(p_\star\),

\[
\mathcal V_{\rm align}(U,p_\star)
=
\{C:\Gamma_H(N,C;U)\ge p_\star\}.
\]

A network is sufficiently aligned for the declared task when its interaction architecture lies inside that region.

The present extension makes explicit that **task viability and maintenance of corrective capacity are different questions**.

### 1. Task viability

Does the current architecture perform the declared task well enough?

\[
\Gamma_H(N,C;U)\ge p_\star.
\]

### 2. Maintenance viability

Can the network reproduce enough of the learning/correction capacity on which future task viability depends?

For a local linear maintenance model

\[
x_{t+1}=(R+K)x_t,
\]

where \(R=\operatorname{diag}(r_i)\) contains autonomous retention factors and \(K\ge0\) contains directed cross-maintenance contributions, define the normalized maintenance matrix

\[
G=(I-R)^{-1}K
\]

when every declared autonomous retention factor satisfies \(r_i<1\).

The associated maintenance reproduction number is

\[
\mathcal R_M=\rho(G).
\]

In the standard nonnegative linear-system interpretation, \(\mathcal R_M>1\) marks a locally supercritical maintenance architecture: the network can reproduce more corrective capacity through its return structure than its components lose autonomously. The arbitrary-network spectral-radius theorem is classical Perron--Frobenius / next-generation-matrix mathematics; it is not claimed as new and is not yet re-proved in Lean here.

This introduces a useful distinction:

\[
\boxed{
\text{performing well now}
\neq
\text{preserving the capacity to keep correcting later}
}
\]

A system can therefore be task-viable while accumulating maintenance debt, or maintenance-viable while still failing the declared external task. The proposed sufficient-alignment picture ultimately requires both task performance and externally corrigible maintenance.

## Six theorem modules

1. **Signal fidelity / honesty** — a deterministic garbling cannot expand the optimal decision set; every garbled-signal policy can be lifted to the ungarbled signal with identical value.
2. **Redundant correction** — for independent 2-out-of-3 correction channels,
   \[
   R_3(p)=3p^2-2p^3,
   \]
   with exact half-threshold at \(p=1/2\) and redundancy gain for \(1/2<p<1\).
3. **Selected vs sufficient alignment** — in the quadratic toy model, private optimization can select effort below the network's functional threshold.
4. **Protocol inheritance** — \(R_{\rm protocol}=mp\); expected carrier counts grow above one and decline below one. Full stochastic survival uses the standard Galton--Watson theorem.
5. **Repair / forgiveness** — repair beats termination exactly when
   \[
   C_R\le r(V-W).
   \]
6. **Maintenance reproduction / return-loop closure** — for a simple directed cycle of subcritical learning processes, cross-maintenance must overcome the product of their autonomous deficits. For a dyad,
   \[
   k_{AB}k_{BA}>(1-r_A)(1-r_B),
   \]
   and for the directed triad \(A\to B\to C\to A\),
   \[
   k_{AB}k_{BC}k_{CA}
   >(1-r_A)(1-r_B)(1-r_C).
   \]
   The Lean formalization also proves the corresponding finite-cycle product threshold and an explicit three-agent witness where the full triad is super-unit although every induced dyad is open-loop.

## Why the return loop matters

The extension changes the natural unit of analysis.

A useful corrective relation does not have to return value directly to the same partner. A maintenance path may close through a larger network:

\[
A\to B\to C\to A.
\]

Accordingly, reciprocity is interpreted here as **closure of generative return paths**, not equality of bilateral exchange.

For a simple cycle, breaking one required edge destroys the closed-loop product. More generally, recurrent maintenance belongs to strongly connected network structure rather than to edge count alone. Maximum connectivity is therefore not the target; the target is an architecture whose selective connections preserve externally testable correction and adaptation.

This motivates the stronger working formulation:

> The relevant unit of persistent collective intelligence is not necessarily the learner, the edge, or even one isolated cycle, but a recurrent organization of processes whose mutual maintenance is sufficient to reproduce externally corrigible adaptive capacity.

The phrase **externally corrigible** is essential. Mere self-reproduction is not enough: a tumor, coercive organization, or self-sealing misinformation network can also persist. Maintenance reproduction is therefore not itself a moral or epistemic success criterion; it must remain coupled to declared external performance and correction tests.

## Interpretation

SCAP is reframed as a proposed **heritable maintenance protocol for collective intelligence**, not as a demand for moral perfection.

The paper distinguishes:

\[
\text{object-level diversity}
\quad\text{from}\quad
\text{protocol-level alignment}.
\]

The target remains:

> not aligned minds, but interoperable learning processes.

The maintenance-reproduction extension sharpens that target: interoperable learning processes must not only exchange useful correction at one time point; enough of the correction architecture must be regenerated through time.

## Formalization

Core file:

    formalization/collective-alignment/CollectiveAlignment.lean

Maintenance-reproduction module:

    formalization/collective-alignment/CollectiveAlignment/MaintenanceReproduction.lean

Numerical checks:

    papers/sufficient-alignment/verify_alignment.py

The Lean module machine-checks the dyadic, triadic, explicit-witness, and finite-cycle product-threshold algebra. It deliberately does **not** claim a machine-checked proof of the full arbitrary-network Perron--Frobenius spectral-radius theorem.

## SCAP v2

See [SCAP_V2.md](SCAP_V2.md) for the compact operational reinterpretation of the Sustainable Collaborative Alignment Protocol. It distinguishes theorem-backed functions from human-language implementations and explicitly keeps the protocol itself corrigible.

## Formal verification map

See [FORMAL_VERIFICATION.md](FORMAL_VERIFICATION.md) for the claim-by-claim mapping from manuscript statements to exact Lean declarations.
