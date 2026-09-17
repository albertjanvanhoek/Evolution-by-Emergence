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

The newer maintenance formalization sharpens the unit of analysis. The relevant object is not necessarily an individual learner, an edge, or even a single cycle. It can be a **recurrent maintenance module**: a set of bounded processes whose return paths jointly reproduce the corrective capacity that none can maintain alone.

This motivates the distinction

\[
\text{node state}
\quad\neq\quad
\text{edge count}
\quad\neq\quad
\text{network maintenance capacity}.
\]

A useful connection is therefore not defined merely by its existence. Its value depends on what recurrent corrective paths it participates in and whether those paths preserve task-relevant adaptive capacity.

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
6. **Recurrent maintenance** — explicit two- and three-process constructions show that individually subcritical processes can have a positive joint maintenance witness when closed-loop gain covers their autonomous maintenance deficits. For the directed three-cycle \(A\to B\to C\to A\), the exact canonical-witness boundary is
   \[
   k_{AB}k_{BC}k_{CA}
   \ge
   (1-r_A)(1-r_B)(1-r_C).
   \]
   Above the strict boundary, Lean verifies a positive state whose first component grows while the other two are exactly at replacement. Deleting the return edge \(C\to A\) makes a positive subcritical \(A\) decline.

The sixth module is deliberately narrower than the full matrix result suggested by the model. The general statement using a normalized maintenance matrix \(G=(I-R)^{-1}K\) and a spectral-radius threshold \(\rho(G)>1\) belongs to classical nonnegative-matrix / reproduction-number theory and is **not** claimed as machine-checked here.

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

The recurrent-maintenance extension adds a second sentence:

> not maximum connectivity, but enough correctly organized return paths to preserve corrective capacity.

This matters because adding an edge is not automatically beneficial and removing an edge is not automatically harmful. The relevant question is whether the action preserves or enlarges the network's future capacity to detect error, correct, repair, and reorganize for the declared task.

### Formalization

See:

    formalization/collective-alignment/CollectiveAlignment.lean

and:

    formalization/collective-alignment/MaintenanceReproduction.lean

as well as:

    papers/sufficient-alignment/verify_alignment.py

The maintenance file machine-checks only the finite algebraic claims stated above. It does not formalize the general Perron-Frobenius theorem, a universal theory of collective intelligence, or any moral interpretation of the model.

### SCAP v2

See [SCAP_V2.md](SCAP_V2.md) for the compact operational reinterpretation of the Sustainable Collaborative Alignment Protocol. It distinguishes theorem-backed functions from human-language implementations and explicitly keeps the protocol itself corrigible.

## Formal verification map

See [FORMAL_VERIFICATION.md](FORMAL_VERIFICATION.md) for the claim-by-claim mapping from manuscript statements to exact Lean declarations.
