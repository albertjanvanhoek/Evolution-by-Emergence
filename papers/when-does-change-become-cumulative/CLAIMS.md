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
| C9 | A productive non-substituting network extension provides a concrete strict-domination witness; the numerical \(v=100,f=.01\) example and exact rational \(f=1/100,v=125,\lambda=3/2\) cost witness both lower inherited A and B costs. | Closed-form model calculation; rational cost inequalities and margin winding machine checked; numerical witness reproduced |
| C10 | Uniform positive dilution cannot pointwise dominate any declared positive inherited cost. | Exact result; machine checked |
| C11 | For an attained binding cost \(c^\star\) of the declared in-budget inherited repertoire, uniform-dilution retention holds iff \(\kappa\le B/c^\star-1\). | Exact theorem; machine checked |
| C12 | The margin ratio obeys \((1+M_{t+1})/(1+M_t)=c_t^\star/c_{t+1}^\star\) for positive budget and binding costs. | Exact identity; machine checked |
| C13 | If the binding cost changes by a positive factor \(r\), then \(1+M_{t+1}=(1+M_t)/r\), and the margin increases iff \(r<1\). | Exact identities; machine checked |
| C13a | Under pure dilution, \(M_{t+1}=(M_t-\kappa)/(1+\kappa)\). | Exact identity; machine checked |
| C14 | Conditional on a winding step with \(M_1>M_0\ge0\), the interval \((M_0,M_1]\) is nonempty; using the exact retention theorem, any \(\kappa\) in it is non-retainable before and retainable after. This is a corollary, not the existence theorem for winding. | Exact corollary; machine checked |
| C15 | If maintained production rises \(X_1>X_0\) and \(\kappa>0\), there is a nonempty threshold interval \((X_0\kappa/(1+\kappa), X_1\kappa/(1+\kappa)]\). | Exact result; machine checked |
| C16 | An exact rational two-click cost witness exists: \(\{A,B\}\subsetneq\{A,B,C\}\subsetneq\{A,B,C,D\}\). | Exact result; machine checked |
| C17 | In that witness, attempting the second click directly at baseline loses inherited A and leaves D inaccessible. | Exact result; machine checked |
| C18 | The exact first click raises margin from \(2/3\) to \(97/99\), and \(\kappa=9/10\) lies in the opened coupling interval. | Exact result; machine checked |
| C19 | \(\theta_D=1/2\) lies in the exact production window opened by \(X_0=1\to X_1=7/6\) at \(\kappa=9/10\). | Exact result; machine checked |
| C20 | Route-level cost dominance is reflexive/transitive and preserves route-feasible targets, but is only a strong sufficient condition in separable settings. | Exact result plus scope statement; machine checked |
| C21 | Graph extension does not in general imply realized accessibility extension under shared resource constraints. | Model result / conceptual consequence |
| C22 | For repeated non-returning loads on a fixed declared repertoire, \(\prod_i(1+\kappa_i)\le1+M_0\) is necessary for retention. | Exact algebraic consequence |
| C23 | If every such load satisfies \(\kappa_i\ge\kappa_{\min}>0\), then \(n\le\log(1+M_0)/\log(1+\kappa_{\min})\). | Exact analytical bound |
| C24 | Without a positive minimum load, finite margin alone does not imply finite-step exhaustion; if a load is a strict fraction \(u<1\) of positive current margin, the next margin remains positive. | Exact deterministic correction machine checked; infinite-sequence interpretation conditional on the load process |
| C25 | With \(W=\log(1+M)\) and candidate log-multiplier \(Y=\log r\), retention filtering gives \(W_{n+1}=W_n-Y_{n+1}\) when \(Y_{n+1}\le W_n\), otherwise \(W_{n+1}=W_n\). | Exact transformation / model definition |
| C26 | For an i.i.d. state-independent candidate pool with \(\mathbb E|Y|<\infty\), positive linear log-slack growth occurs iff \(\mathbb E[Y]<0\); in that regime \(W_n/n\to-\mathbb E[Y]\) almost surely. | Analytical proposition using SLLN and Borel--Cantelli; not machine formalized |
| C27 | For \(\mathbb E[Y]>0\), the conditional drift is \(-\mathbb E[Y\mathbf 1_{Y\le w}]\); with a continuous two-sided candidate law it is positive at zero and negative for large \(w\), implying a finite sign change in mean drift. | Analytical result under stated regularity; does not by itself prove a stationary law |
| C28 | The asymptotic acceptance fraction in a filtered positive-mean regime is not generally \(P(Y\le0)\); positive spending candidates can still be accepted when \(0<Y\le W\). | Exact observation from the filter; Gaussian simulation reproduced |
| C29 | The order-theoretic click rate should be state dependent: \(\lambda(s)=\nu(s)Q_s(\mathcal C(s))\). | Proposed general forward-dynamics formulation |
| C30 | The paper does not establish that \(Q_s\) evolves toward more winding candidates. | Open problem / non-claim |

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
- the positive-mean filtered process has a universal stationary distribution, a universal factor-of-two acceptance law, or acceptance equal to the winding fraction;
- the paper establishes a universal forward direction of evolution.
