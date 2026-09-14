# Claim ledger

| ID | Statement | Status |
|---|---|---|
| R1 | The feedback law \(u=kz\) is negative feedback because larger deviation \(z\) increases an action that enters \(\dot z\) with negative sign. | Definition/model property |
| R2 | \(z^*(k)=\eta/(\gamma+\beta k)\). | Exact derivation |
| R3 | Functional sufficiency \(M^*(k)=m-z^*(k)\ge0\) is equivalent to \(\eta\le m(\gamma+\beta k)\). | Exact derivation; Lean target |
| R4 | If \(\eta>m\gamma\), the minimum function-preserving gain is \(k_{\rm func}=(\eta/m-\gamma)/\beta\). | Exact derivation |
| R5 | With \(g(k)=g_0-Lz^*-c_0k-c_1kz^*\), the regulatory advantage over \(k=0\) factors as \(\Delta g(k)=k[\eta(\beta L-c_1\gamma)-c_0\gamma(\gamma+\beta k)]/[\gamma(\gamma+\beta k)]\). | Exact derivation; Lean target |
| R6 | If \(A=\beta L-c_1\gamma\le0\), no positive controller gain can have positive return under this objective. | Exact consequence |
| R7 | If \(A>0\), \(\Delta g(k)\) is strictly concave and a positive selected optimum exists exactly when \(\eta A>c_0\gamma^2\). | Exact calculus result |
| R8 | On the positive branch, \(k_{\rm opt}=(\sqrt{\eta A/c_0}-\gamma)/\beta\). | Exact calculus result |
| R9 | At that optimum, \(z^*_{\rm opt}=\sqrt{\eta c_0/A}\) and \(M^*_{\rm opt}=m-\sqrt{\eta c_0/A}\). | Exact consequence |
| R10 | The selected optimum is functionally sufficient iff \(\eta\le A m^2/c_0\). | Main alignment result |
| R11 | If constitutive controller cost is shared across \(n\) beneficiaries, the alignment boundary becomes \(\eta\le n A m^2/c_0\). | Exact corollary under stated pooling assumption |
| R12 | In a Poisson rare-shock limit with survival factors \(s_0<s_1\), regulation is favored iff \(\nu\log(s_1/s_0)>c\). | Exact result for the separate stochastic limiting model |
| R13 | Threat frequency alone does not determine regulator retention; severity/avoided loss and regulatory cost matter jointly. | Consequence of R5/R12 |
| R14 | The present scalar model is not a universal theory of biological regulation. | Scope statement |

## Classical ingredients, not novelty claims

- Negative-feedback control and homeostasis.
- Energetic/resource costs of biological adaptation.
- Economy–effectiveness tradeoffs in regulatory networks.
- Cost–benefit optimization of gene expression.
- Responsive versus constitutive strategies in fluctuating environments.
- Sensing versus stochastic switching.
- Regulatory loss during genome reduction.

## Explicit non-claims

The paper does not claim that:

- natural selection always maximizes the scalar growth objective used here;
- every biological controller is linear or proportional;
- all functional thresholds are externally imposed in real organisms;
- pooled regulation is always beneficial;
- rare regulators are necessarily lost;
- continuous-threat regulators are necessarily retained;
- the economy–effectiveness tradeoff is novel;
- the formal proofs validate empirical biological assumptions.

## Proposed empirical predictions

Under otherwise comparable conditions:

1. increasing perturbation load should increase selected regulatory investment;
2. reducing exposure should weaken selection for costly regulatory capacity;
3. large constitutive monitoring cost should make low-exposure regulators especially vulnerable;
4. stronger consequence severity can retain preparedness even when events are rare;
5. cost pooling should preserve preparedness at lower individual exposure than unpooled maintenance;
6. selection-optimal regulation can remain below an independently specified functional or safety threshold.
