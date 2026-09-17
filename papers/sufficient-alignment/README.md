# Sufficient Alignment

## A Viability Framework for Collective Intelligence

This package develops the collective-intelligence interpretation of SCAP and the Theory of Long-Term Collaboration.

### Core idea

Alignment is treated as a **viability region**, not a requirement that every node behave perfectly or hold the same model.

For a network \(N\), collaboration architecture \(C\), target \(U\), horizon \(H\), and required success level \(p_\star\),

\[
\mathcal V_{\rm align}(U,p_\star)
=
\{C:\Gamma_H(N,C;U)\ge p_\star\}.
\]

A network is sufficiently aligned for the declared task when its interaction architecture lies inside that region.

The framework now distinguishes two kinds of reproduction:

1. **protocol reproduction** — whether a maintenance protocol is transmitted across turnover; and
2. **maintenance reproduction** — whether usable corrective capacity is regenerated through the interaction network itself.

The second distinction matters because collective intelligence may depend on recurrent return paths that are not reducible to any single node or dyad.

### Six theorem modules

1. **Signal fidelity / honesty** — a deterministic garbling cannot expand the optimal decision set; every garbled-signal policy can be lifted to the ungarbled signal with identical value.
2. **Redundant correction** — for independent 2-out-of-3 correction channels,
   \[
   R_3(p)=3p^2-2p^3,
   \]
   with exact half-threshold at \(p=1/2\) and redundancy gain for \(1/2<p<1\).
3. **Selected vs sufficient alignment** — in the quadratic toy model, private optimization can select effort below the network's functional threshold.
4. **Protocol inheritance** — \(R_{\rm protocol}=mp\); expected carrier counts grow above one and decline below one. Full stochastic survival uses the standard Galton-Watson theorem.
5. **Repair / forgiveness** — repair beats termination exactly when
   \[
   C_R\le r(V-W).
   \]
6. **Maintenance reproduction / recurrent correction** — in small linear maintenance networks, individually subcritical processes can jointly maintain corrective capacity through closed return paths. For a dyad,
   \[
   k_{AB}k_{BA}>(1-r_A)(1-r_B),
   \]
   and for the directed three-cycle \(A\to B\to C\to A\),
   \[
   k_{AB}k_{BC}k_{CA}>(1-r_A)(1-r_B)(1-r_C)
   \]
   gives an explicit algebraic witness with nondeclining coordinates and one strictly increasing coordinate. Equality gives an exact fixed point. The general arbitrary-network spectral-radius formulation is classical external mathematics and is not claimed as machine-checked here.

### Network interpretation

The maintenance-reproduction module sharpens the framework in three ways.

First, **reciprocity need not be dyadic**. A return loop can close through several different processes:

\[
A\to B\to C\to A.
\]

Second, the value of an edge is relational: an edge may matter because of the return paths it completes, not merely because of its local strength.

Third, the relevant organizational unit need not be an isolated learner or a single edge. In the general linear theory, recurrent maintenance is naturally associated with strongly connected subnetworks. This motivates the working concept of a **recurrent maintenance module**: a recurrent organization of processes whose mutual contributions are sufficient to regenerate the declared adaptive or corrective capacity.

This is a structural claim about the model, not a claim that persistence alone is desirable. A misinformation network, pathogen, or coercive organization can also be self-maintaining. Sufficient alignment therefore retains the external task criterion \(\Gamma_H\): maintenance of the correction architecture must remain tied to declared adaptive performance rather than mere self-reproduction.

### Interpretation

SCAP is reframed as a proposed **heritable maintenance protocol for collective intelligence**, not as a demand for moral perfection.

The paper distinguishes:

\[
\text{object-level diversity}
\quad\text{from}\quad
\text{protocol-level alignment}.
\]

The target is:

> not aligned minds, but interoperable learning processes.

The maintenance-reproduction extension adds a second statement:

> interoperability matters when it closes enough return paths to keep corrective capacity regenerating through the network.

### Formalization

See:

    formalization/collective-alignment/CollectiveAlignment.lean

and:

    formalization/collective-alignment/MaintenanceReproduction.lean

Numerical verification remains in:

    papers/sufficient-alignment/verify_alignment.py

The small-network product-threshold identities and explicit witnesses are machine checked. The general theorem based on the spectral radius of

\[
G=(I-R)^{-1}K
\]

is currently treated as prior Perron-Frobenius / M-matrix theory rather than re-proved in Lean.

### SCAP v2

See [SCAP_V2.md](SCAP_V2.md) for the compact operational reinterpretation of the Sustainable Collaborative Alignment Protocol. It distinguishes theorem-backed functions from human-language implementations and explicitly keeps the protocol itself corrigible.

The maintenance-reproduction result suggests a future SCAP revision should distinguish **bilateral reciprocity** from the more general requirement of **return-loop closure**. The present branch does not yet rewrite SCAP v2; that should follow only after the new module and its interpretation survive review.

## Formal verification map

See [FORMAL_VERIFICATION.md](FORMAL_VERIFICATION.md) for the claim-by-claim mapping from manuscript statements to exact Lean declarations.
