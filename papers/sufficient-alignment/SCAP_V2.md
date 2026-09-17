# SCAP v2 — A Maintenance Protocol for Collective Intelligence

## Status

This document is a **functional reinterpretation** of the Sustainable Collaborative Alignment Protocol (SCAP) in light of the Organizational Accessibility, regulation, maintenance-debt, cumulative-change, collective-alignment, and maintenance-reproduction work.

It is not a theorem that these English-language virtues are universally obligatory. The formal stack supports narrower functions. SCAP proposes human-readable practices intended to implement those functions.

## Objective

The objective is not perfect agreement or perfect behavior by every agent.

The objective is:

\[
\boxed{
\text{keep the network's collective learning process inside its viability region while preserving enough of the correction architecture to keep learning possible.}
}
\]

For a declared task \(U\), horizon \(H\), and required performance \(p_\star\),

\[
\mathcal V_{\rm align}
=
\{C:\Gamma_H(N,C;U)\ge p_\star\}.
\]

This is the **task-viability** condition.

A second, distinct question is whether the network reproduces enough of the corrective capacity on which future task viability depends. In the local linear maintenance model

\[
x_{t+1}=(R+K)x_t,
\]

with autonomous retention \(R=\operatorname{diag}(r_i)\), directed cross-maintenance matrix \(K\ge0\), and \(r_i<1\), define

\[
G=(I-R)^{-1}K,
\qquad
\mathcal R_M=\rho(G).
\]

The standard nonnegative-matrix threshold \(\mathcal R_M>1\) describes a locally supercritical maintenance architecture. The arbitrary-network spectral theorem is classical external mathematics; the accompanying Lean module machine-checks the narrower dyad, triad, explicit-witness, and finite-cycle product algebra.

SCAP is therefore a candidate protocol for keeping the interaction architecture \(C\) inside the declared task-viability region **and** for keeping enough of the correction architecture reproducible through time, while allowing \(C\) itself to remain corrigible.

---

## Principle 1 — Preserve signal fidelity

**Human-language form:** be honest on cooperative corrective edges.

**Functional form:** do not unnecessarily garble task-relevant information needed by another learner to make the declared joint decision.

**Mathematical support:** every policy available after a deterministic garbling can be reproduced after the ungarbled signal with identical value. Therefore the cleaner signal weakly expands the attainable policy set.

**Boundary:** honesty does not mean universal disclosure. Privacy, adversarial contexts, confidentiality, processing cost, and information hazards are separate constraints.

---

## Principle 2 — Remain corrigible

**Human-language form:** admit that your model can be wrong and remain reachable by relevant evidence.

**Functional form:** maintain channels by which distinctions outside the current internal model can change future model or action.

**Mathematical support:** the corrigibility constraint shows that if two possible worlds share the same internal state but later require different actions, no system cut off from discriminating information can be guaranteed to succeed in both.

**Boundary:** corrigibility does not require accepting every signal. It requires preserving the possibility of justified update.

---

## Principle 3 — Preserve useful diversity

**Human-language form:** tolerate dissent and different perspectives.

**Functional form:** do not collapse all sensors, models, and hypotheses into correlated copies before their independent information has been tested.

**Support:** redundant correction only buys robustness when failures are not perfectly correlated; collective-intelligence research likewise shows that communication topology can improve learning or destroy useful diversity.

**Boundary:** diversity is not valuable merely because it differs. The relevant quantity is nonredundant information or useful search diversity.

---

## Principle 4 — Invest enough, not infinitely

**Human-language form:** contribute to the collaboration and its institutions.

**Functional form:** maintain enough signal quality, review, repair, observability, and reciprocal return to remain inside the declared viability region.

**Mathematical support:** selected alignment can fall below sufficient alignment. In the minimal quadratic model,
\[
e_{\rm opt}=v/c,
\]
while the 2-out-of-3 half-viability threshold requires
\[
e\ge1/2.
\]
Thus selected alignment is sufficient exactly when
\[
2v\ge c.
\]

**Boundary:** maximal alignment expenditure is not the goal. Control itself has costs and can become capture.

---

## Principle 5 — Build redundancy for ordinary fallibility

**Human-language form:** do not make collective truth depend on one infallible person or institution.

**Functional form:** distribute correction across partially independent channels.

For three independent channels,
\[
R_3(p)=3p^2-2p^3.
\]

For
\[
1/2<p<1,
\]
\[
R_3(p)>p.
\]

**Interpretation:** collective reliability can exceed individual reliability without any node being perfect.

---

## Principle 6 — Repair valuable edges after reparable failure

**Human-language form:** forgive when repair is worth more than destruction.

**Functional form:** restore a damaged collaborative relation when expected recovered surplus exceeds repair cost.

In the minimal model,
\[
\boxed{
C_R\le r(V-W)
}
\]
is exactly the region in which repair weakly dominates termination.

**Boundary:** forgiveness is conditional. Persistent exploitation, low repair probability, high cost, or a good outside option can make exit the better action.

---

## Principle 7 — Close enough of the return loop

**Human-language form:** practice reciprocity and accountability.

**Functional form:** maintain enough recurrent return structure that the processes supplying useful correction, verification, repair, or other learning functions are themselves sufficiently replenished to persist.

This is broader than direct bilateral repayment. A viable return path may be

\[
A\to B\to C\to A,
\]

so \(A\) can maintain \(B\), \(B\) can maintain \(C\), and \(C\) can maintain \(A\) without any pair exchanging equal value directly.

For a two-process return loop, define autonomous retention factors \(r_A,r_B<1\) and cross-maintenance gains \(k_{AB},k_{BA}\). The normalized loop is super-unit exactly when

\[
\boxed{
k_{AB}k_{BA}>(1-r_A)(1-r_B).}
\]

For a directed triad,

\[
A\to B\to C\to A,
\]

the corresponding threshold is

\[
\boxed{
k_{AB}k_{BC}k_{CA}
>(1-r_A)(1-r_B)(1-r_C).}
\]

More generally, for a declared finite directed cycle,

\[
\boxed{
\prod_i k_i>
\prod_i(1-r_i)
}
\]

is the exact product threshold machine-checked in the Lean module.

The broader arbitrary-network formulation uses

\[
\mathcal R_M
=\rho\!\left((I-R)^{-1}K\right).
\]

This moves the interpretation of reciprocity from

> repay the same partner

 to

> preserve enough closed generative return paths for the useful maintenance architecture to reproduce.

**Boundary:** recurrence is not automatically good. A coercive organization, tumor, or misinformation network can also contain self-maintaining cycles. Return-loop closure is therefore a maintenance condition, not a sufficient truth, moral, or external-performance criterion. The maintained network must remain externally corrigible and task-tested.

---

## Principle 8 — Observe maintenance before visible failure

**Human-language form:** surface problems early; do not wait until the relationship or institution visibly collapses.

**Functional form:** monitor replacement balance and corrective reproduction, not only current stock or current performance.

The maintenance work defines
\[
D=\delta K-ax=-\dot K.
\]

A system may still look healthy while \(D>0\).

The maintenance-reproduction extension adds a second warning signal: current task performance can remain high while the return architecture that regenerates correction falls toward or below its maintenance threshold.

**Interpretation:** collective learning infrastructure can accumulate maintenance debt before its visible output fails.

---

## Principle 9 — Pass on the capacity to correct, not merely the conclusions

**Human-language form:** teach the next generation how to learn together.

Let
\[
M_n
\]
be inherited domain knowledge,
\[
Q_n
\]
the process generating candidate revisions, and
\[
C_n
\]
the correction/collaboration architecture.

The intergenerational target is not merely
\[
M_n\to M_{n+1},
\]
but some retainable transformation of
\[
\boxed{
(M_n,Q_n,C_n)\to(M_{n+1},Q_{n+1},C_{n+1}).
}
\]

For a simple protocol-carrier model,
\[
R_{\rm protocol}=mp.
\]

The protocol is super-unit in expectation when
\[
R_{\rm protocol}>1.
\]

**Boundary:** exact copying is not the goal. A correction protocol that cannot itself be corrected has become dogma.

---

## Principle 10 — Keep SCAP corrigible

SCAP is itself an organizational state.

Therefore:

\[
\boxed{
C_t\to C_{t+1}
}
\]

must remain possible.

A future agent should inherit not the instruction:

> Obey this protocol forever.

but:

> Understand what functions this protocol is trying to maintain; preserve those functions where they remain necessary; test the implementation; and change it when a better correctable architecture becomes available.

That is the protocol's reflexive condition.

---

# The compact transmission version

A new intelligent agent does not need to be told that perfect cooperation is possible.

It should be taught the following model:

1. **Your model is finite.** Relevant information can exist outside it.
2. **Other agents can carry information and capability you do not have.**
3. **Useful relations are infrastructure.** They create joint accessibility but require maintenance.
4. **Corrupting a cooperative signal reduces what the network can infer and do.**
5. **Ordinary error is inevitable.** Build redundancy and repair rather than demanding infallibility.
6. **Repair is conditional.** Preserve valuable correctable relations; exit destructive ones.
7. **Your private optimum may underfund collective learning infrastructure.**
8. **Close enough of the larger return loop.** Reciprocity need not be bilateral; useful maintenance must return somewhere through the network strongly enough to replenish what is lost.
9. **Watch replacement balance and corrective reproduction, not only visible success.**
10. **Preserve diversity that carries nonredundant information.**
11. **Pass onward the capacity for correction, including the capacity to correct this protocol.**

The target is not moral perfection.

\[
\boxed{
\textbf{The target is sufficient alignment for a network to remain
collectively intelligent while its members, models, and environment change.}
}
\]
