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

### Five theorem modules

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

### Formalization

See:

    formalization/collective-alignment/CollectiveAlignment.lean

and:

    papers/sufficient-alignment/verify_alignment.py


### SCAP v2

See [SCAP_V2.md](SCAP_V2.md) for the compact operational reinterpretation of the Sustainable Collaborative Alignment Protocol. It distinguishes theorem-backed functions from human-language implementations and explicitly keeps the protocol itself corrigible.
