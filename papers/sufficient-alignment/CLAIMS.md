# Claim ledger

| ID | Claim | Status |
|---|---|---|
| A1 | Collective alignment can be defined as membership of a task- and horizon-specific viability region \(\mathcal V_{\rm align}\). | Framework definition |
| A2 | Every policy using a deterministic garbling of a finite signal can be lifted to the ungarbled signal with identical weighted decision value. | Exact theorem; Lean checked |
| A3 | Therefore optimization with the original signal weakly dominates optimization restricted to its deterministic garbling. | Corollary of A2; classical Blackwell direction |
| A4 | This supplies a narrow technical interpretation of honesty as preservation of task-relevant signal fidelity on a declared cooperative edge. | Interpretation; conditional |
| A5 | For three independent channels with viability requiring at least two successes, \(R_3(p)=3p^2-2p^3\). | Standard reliability specialization |
| A6 | \(R_3\) is monotone on \([0,1]\). | Exact theorem; Lean checked |
| A7 | \(R_3(p)\ge1/2\iff p\ge1/2\). | Exact theorem; Lean checked |
| A8 | For \(1/2<p<1\), \(R_3(p)>p\). | Exact theorem; Lean checked |
| A9 | Collective viability therefore need not require perfect individual reliability. | Interpretation of A5-A8 |
| A10 | \(R_{\rm protocol}=mp\) has threshold \(R_{\rm protocol}>1\iff p>1/m\) for \(m>0\). | Exact algebra; Lean checked |
| A11 | In the homogeneous expectation model \(E[N_n]=N_0R^n\), expected carrier counts grow above \(R=1\) and decline for \(0<R<1\). | Exact theorem; Lean checked |
| A12 | In a nondegenerate Galton-Watson process, mean offspring \(\le1\) gives almost-sure extinction and mean \(>1\) gives positive survival probability. | Classical external theorem, not re-proved |
| A13 | In the one-step repair model, repair weakly dominates termination iff \(C_R\le r(V-W)\). | Exact theorem; Lean checked |
| A14 | Therefore forgiveness is not universally optimal; its functional core can be represented as repair of a valuable, repairable edge. | Interpretation of A13 |
| A15 | In the quadratic private objective (g(e)=ve-ce^2/2), (e_{m opt}=v/c) is a global optimum; against the 2-out-of-3 half-viability threshold, selected alignment is sufficient iff (2v\ge c). | Exact toy result; Lean checked |
| A16 | Therefore lower-level optimization can underprovide a collectively necessary interaction architecture even when the architecture has positive network value. | Interpretation of A15 plus prior regulation/free-rider models |
| A17 | SCAP can be interpreted as a proposed heritable maintenance protocol for collective intelligence. | Synthesis / hypothesis |
| A18 | Protocol alignment can coexist with object-level disagreement and diversity. | Framework claim; not a universal performance theorem |
| A19 | Retaining correction architecture can contribute to cumulative accessibility by changing future search, retention, and learning conditions. | OA synthesis; requires application-specific causal test |

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
- the four toy models exhaust collective intelligence.
