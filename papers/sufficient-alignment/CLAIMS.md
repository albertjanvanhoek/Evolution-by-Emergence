# Claim ledger

Machine-checked claims in this ledger are mapped to exact Lean declarations in [FORMAL_VERIFICATION.md](FORMAL_VERIFICATION.md).

| ID | Claim | Status |
|---|---|---|
| A1 | Collective alignment can be defined as membership of a task- and horizon-specific viability region \(\mathcal V_{\rm align}\). | Framework definition |
| A2 | Every policy using a deterministic garbling of a finite signal can be lifted to the ungarbled signal with identical weighted decision value. | Exact theorem; machine checked |
| A3 | Therefore optimization with the original signal weakly dominates optimization restricted to its deterministic garbling. | Corollary of A2; classical Blackwell direction |
| A4 | This supplies a narrow technical interpretation of honesty as preservation of task-relevant signal fidelity on a declared cooperative edge. | Interpretation; conditional |
| A5 | For three independent channels with viability requiring at least two successes, \(R_3(p)=3p^2-2p^3\). | Standard reliability specialization |
| A6 | \(R_3\) is monotone on \([0,1]\). | Exact theorem; machine checked |
| A7 | \(R_3(p)\ge1/2\iff p\ge1/2\). | Exact theorem; machine checked |
| A8 | For \(1/2<p<1\), \(R_3(p)>p\). | Exact theorem; machine checked |
| A9 | Collective viability therefore need not require perfect individual reliability. | Interpretation of A5-A8 |
| A10 | \(R_{\rm protocol}=mp\) has threshold \(R_{\rm protocol}>1\iff p>1/m\) for \(m>0\). | Exact algebra; machine checked |
| A11 | In the homogeneous expectation model \(E[N_n]=N_0R^n\), expected carrier counts grow above \(R=1\) and decline for \(0<R<1\). | Exact theorem; machine checked |
| A12 | In a nondegenerate Galton-Watson process, mean offspring \(\le1\) gives almost-sure extinction and mean \(>1\) gives positive survival probability. | Classical external theorem, not re-proved |
| A13 | In the one-step repair model, repair weakly dominates termination iff \(C_R\le r(V-W)\). | Exact theorem; machine checked |
| A14 | Therefore forgiveness is not universally optimal; its functional core can be represented as repair of a valuable, repairable edge. | Interpretation of A13 |
| A15 | In the quadratic private objective \(g(e)=ve-ce^2/2\), \(e_{\rm opt}=v/c\) is a global optimum; against the 2-out-of-3 half-viability threshold, selected alignment is sufficient iff \(2v\ge c\). | Exact toy result; machine checked |
| A16 | Therefore lower-level optimization can underprovide a collectively necessary interaction architecture even when the architecture has positive network value. | Interpretation of A15 plus prior regulation/free-rider models |
| A17 | SCAP can be interpreted as a proposed heritable maintenance protocol for collective intelligence. | Synthesis / hypothesis |
| A18 | Protocol alignment can coexist with object-level disagreement and diversity. | Framework claim; not a universal performance theorem |
| A19 | Retaining correction architecture can contribute to cumulative accessibility by changing future search, retention, and learning conditions. | OA synthesis; requires application-specific causal test |
| A20 | For two subcritical processes, the normalized closed-loop maintenance ratio exceeds one iff \(k_{AB}k_{BA}>(1-r_A)(1-r_B)\). An open dyadic loop has ratio zero. | Exact algebra; machine checked |
| A21 | For the directed triad \(A\to B\to C\to A\), the normalized loop ratio exceeds one iff \(k_{AB}k_{BC}k_{CA}>(1-r_A)(1-r_B)(1-r_C)\). | Exact algebra; machine checked |
| A22 | There exists an explicit three-agent witness in which the full directed triad is super-unit while every induced dyad is open-loop, and the corresponding finite directed-cycle product threshold holds for arbitrary finite cycle length. | Exact theorem; machine checked |
| A23 | For the arbitrary nonnegative linear maintenance system \(x_{t+1}=(R+K)x_t\) with \(r_i<1\), defining \(G=(I-R)^{-1}K\), the threshold \(\rho(G)=1\) separates subcritical and supercritical maintenance in the standard next-generation/Perron--Frobenius formulation. | Classical external matrix theorem; not re-proved in Lean |
| A24 | A recurrent module need not contain any individually super-unit simple cycle: in an explicit normalized three-node example every two-edge and three-edge simple-cycle product is below one, while the uniform positive state expands by factor \(6/5\). Conversely, an explicit three-node acyclic chain loses all pure cross-maintenance contribution after three steps. | Exact finite witnesses; machine checked |
| A25 | The general interpretation of A24 is that recurrent/strongly connected return structure, rather than edge count or a single privileged cycle, is the natural carrier of self-maintenance in all-subcritical networks. | Corollary/interpretation of standard graph and nonnegative-matrix theory; general theorem not re-proved in Lean |
| A26 | Current task viability and maintenance viability are distinct: a system may currently satisfy \(\Gamma_H\ge p_\star\) while losing future corrective capacity, or maintain correction architecture while failing the declared external task. | Framework distinction / empirical hypothesis |

## Non-claims

The paper does not claim:

- honesty means full disclosure in all contexts;
- Blackwell's theorem is new;
- majority rule is a universal model of collective intelligence;
- independent errors are realistic in every network;
- protocol reproduction with mean \(>1\) guarantees a particular lineage survives;
- forgiveness is always better than exit;
- SCAP is uniquely correct;
- alignment should eliminate disagreement;
- moral obligations have been deduced from mathematics;
- the six toy-model modules exhaust collective intelligence;
- maintenance reproduction by itself implies truth, benevolence, or external task success;
- every useful recurrent module contains an individually supercritical simple cycle;
- the arbitrary-network Perron--Frobenius threshold has been re-proved in Lean in this package.
