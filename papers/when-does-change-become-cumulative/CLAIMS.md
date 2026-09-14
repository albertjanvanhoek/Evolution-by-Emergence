# Claim ledger

| ID | Statement | Status |
|---|---|---|
| C1 | A declared operational repertoire can be induced from finite-horizon target hitting scores after fixing target family, protocol, horizon, establishment criterion, and threshold. | Definition / operational construction |
| C2 | Preservation is inclusion of the declared accessible repertoire. | Definition |
| C3 | A strict order-theoretic click is proper inclusion of the declared accessible repertoire. | Definition |
| C4 | Preservation is reflexive and transitive; strict clicks compose with preservation. | Exact set-theoretic result; machine checked |
| C5 | Set expansion alone does not establish historical causation; historical attribution requires retained earlier structure to contribute causally to at least one newly accessible target. | Definition linking to parent causal framework |
| C6 | Pointwise score dominance preserves thresholded accessibility, and an upward threshold crossing yields strict expansion. | Exact result; machine checked |
| C7 | Pointwise cost domination preserves budget-feasible accessibility, but is stronger than retention. | Exact result; machine checked |
| C8 | Strict pointwise cost domination is achievable in general. | Exact abstract witness; machine checked |
| C9 | A productive non-substituting network extension provides a concrete strict-domination witness; the numerical v=100, f=.01 example and exact rational f=1/100, v=44 cost witness both lower inherited A and B costs. | Closed-form model calculation; rational cost inequalities machine checked; numerical witness reproduced |
| C10 | Uniform positive dilution cannot pointwise dominate any declared positive inherited cost. | Exact result; machine checked |
| C11 | For an attained binding cost \(c^\star\) of the declared in-budget inherited repertoire, uniform-dilution retention holds iff \(\kappa\le B/c^\star-1\). | Exact theorem; machine checked |
| C12 | The margin ratio obeys \((1+M_{t+1})/(1+M_t)=c_t^\star/c_{t+1}^\star\) for positive budget and binding costs. | Exact identity; machine checked |
| C13 | Under pure dilution, \(M_{t+1}=(M_t-\kappa)/(1+\kappa)\). | Exact identity; machine checked |
| C14 | If \(M_1>M_0\ge0\), there exists a nonempty coupling interval \((M_0,M_1]\) of loads unaffordable before and affordable after. | Exact result; machine checked |
| C15 | If maintained production rises \(X_1>X_0\) and \(\kappa>0\), there is a nonempty threshold interval \((X_0\kappa/(1+\kappa), X_1\kappa/(1+\kappa)]\). | Exact result; machine checked |
| C16 | An exact rational two-click cost witness exists: \(\{A,B\}\subsetneq\{A,B,C\}\subsetneq\{A,B,C,D\}\). | Exact result; machine checked |
| C17 | In that witness, attempting the second click directly at baseline loses inherited A and leaves D inaccessible. | Exact result; machine checked |
| C18 | The exact first click raises margin from \(2/3\) to \(97/99\), and \(\kappa=9/10\) lies in the opened coupling interval. | Exact result; machine checked |
| C19 | \(\theta_D=1/2\) lies in the exact production window opened by \(X_0=1\to X_1=7/6\) at \(\kappa=9/10\). | Exact result; machine checked |
| C20 | Route-level cost dominance is reflexive/transitive and preserves route-feasible targets, but is only a strong sufficient condition in separable settings. | Exact result plus scope statement; machine checked |
| C21 | Graph extension does not in general imply realized accessibility extension under shared resource constraints. | Model result / conceptual consequence |
| C22 | For repeated non-returning loads on a fixed declared repertoire, \(\prod_i(1+\kappa_i)\le1+M_0\) is necessary for retention. | Exact algebraic consequence |
| C23 | If every such load satisfies \(\kappa_i\ge\kappa_{\min}>0\), then \(n\le\log(1+M_0)/\log(1+\kappa_{\min})\). | Exact analytical bound |
| C24 | Without a positive minimum load, finite margin alone does not imply finite-step exhaustion; arbitrarily small accepted loads can yield an infinite sequence with vanishing slack. | Scope/correction |
| C25 | The order-theoretic click rate should be state dependent: \(\lambda(s)=\nu(s)Q_s(\mathcal C(s))\). | Proposed forward-dynamics formulation, not yet a theorem of directional drift |
| C26 | The paper does not establish that \(Q_s\) evolves toward more winding candidates. | Open problem / non-claim |

## Non-claims

The paper does not claim that:

- evolution generally preserves every capability;
- a unique declared inherited set is supplied by the dynamics;
- larger accessible sets are intrinsically better;
- complexity is monotone;
- cost is the definition of organizational accessibility;
- finite cost is generally equivalent to positive finite-horizon hitting probability;
- every acquisition raises inherited costs;
- every productive acquisition lowers inherited costs;
- every extension is a uniform-dilution load;
- every recombination, transfer, symbiosis, or cross-scale bridge is a click;
- route dominance is necessary for cumulative change;
- order-theoretic expansion alone establishes historical causation;
- finite margin alone guarantees a last rung when arbitrarily small loads are allowed;
- the exact cost-profile Lean witness formalizes the full ODE/eigenvalue derivation of the production network;
- the paper establishes a universal forward direction of evolution.
