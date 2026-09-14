# Claim ledger

| ID | Statement | Status |
|---|---|---|
| R1 | The feedback law \(u=kz\) is negative feedback because larger deviation \(z\) increases an action that enters \(\dot z\) with negative sign. | Definition/model property |
| R2 | \(z^*(k)=\eta/(\gamma+\beta k)\). | Exact derivation |
| R3 | Functional sufficiency \(M^*(k)=m-z^*(k)\ge0\) is equivalent to \(\eta\le m(\gamma+\beta k)\). | Exact derivation; machine-checked algebraic core |
| R4 | If \(\eta>m\gamma\), the minimum function-preserving gain is \(k_{\rm func}=(\eta/m-\gamma)/\beta\). | Exact derivation |
| R5 | With \(g(k)=g_0-Lz^*-c_0k-c_1kz^*\), the regulatory advantage factors as \(\Delta g(k)=k[\eta(\beta L-c_1\gamma)-c_0\gamma(\gamma+\beta k)]/[\gamma(\gamma+\beta k)]\). | Exact derivation; machine checked |
| R6 | If \(A=\beta L-c_1\gamma\le0\), no positive controller gain can have positive return under this objective. | Exact consequence; machine checked |
| R7 | For \(A>0\), the linear objective is strictly concave in \(k\), and a feasible denominator satisfying \(\eta A=c_0(\gamma+\beta k)^2\) is the global optimum. | Exact calculus/algebra result; global-optimum certificate machine checked |
| R8 | On the positive branch, \(k_{\rm opt}=(\sqrt{\eta A/c_0}-\gamma)/\beta\). | Exact consequence of R7 |
| R9 | At that optimum, \(z^*_{\rm opt}=\sqrt{\eta c_0/A}\) and \(M^*_{\rm opt}=m-\sqrt{\eta c_0/A}\). | Exact consequence |
| R10 | In the linear model, the selected optimum is functionally sufficient iff \(\eta\le A m^2/c_0\). | Exact alignment result; specialization of R15 |
| R11 | Under sufficiently shared, non-rival constitutive infrastructure, replacing \(c_0\) by \(c_0/n\) shifts the linear alignment boundary to \(\eta\le n A m^2/c_0\). | Exact corollary under explicit sharing assumption |
| R12 | If \(n\) is a discrete beneficiary count, the minimum feasible pool size is \(\lceil\eta c_0/(Am^2)\rceil\). | Exact integer interpretation of R11 |
| R13 | In a Poisson rare-shock limit with survival factors \(s_0<s_1\), regulation is favored iff \(\nu\log(s_1/s_0)>c\). | Exact result for the separate stochastic limiting model |
| R14 | Threat frequency alone does not determine regulator retention; severity/avoided loss and regulatory cost matter jointly. | Consequence of R5/R13 |
| R15 | For general \(g(k)=g_0-\Phi(z^*)-C(k)-c_1kz^*\), with \(\Phi''\ge0\), \(C'>0\), \(C''\ge0\), and \(\eta>m\gamma\), alignment is equivalent to \(\beta m^2\Phi'(m)\ge\eta C'(k_{\rm func})+c_1\gamma m^2\). | General marginal-alignment theorem; local algebraic condition machine checked, concavity assumptions analytic |
| R16 | Defining \(\Psi'(m)=\Phi'(m)-c_1\gamma/\beta\), R15 is equivalent to \(\beta m^2\Psi'(m)\ge\eta C'(k_{\rm func})\). | Exact reformulation; machine checked |
| R17 | For \(\Phi_p(z)=Lm(z/m)^p\) and \(C(k)=c_0k\), alignment requires \(p\ge[c_1\gamma+\eta c_0/m^2]/(\beta L)\). | Exact corollary |
| R18 | For fixed finite \(\Psi'(m)>0\), if \(kC'(k)\to\infty\), a fixed functional boundary is eventually underprovided as disturbance tends to infinity. | Asymptotic consequence of R16 on the overloaded branch |
| R19 | For \(C(k)=c_0k^a\), \(a>0\), R18 applies; \(C(k)\sim c_0\log k\) is critical because \(kC'(k)\to c_0\), while \(C(k)\sim c_0(\log k)^2\) still gives eventual separation. | Exact/asymptotic corollaries |
| R20 | The boundary criterion R15 is local at \(z=m\): it decides aligned versus non-aligned but does not determine the magnitude of \(M^*_{\rm opt}\). | Scope statement |
| R21 | The present scalar model is not a universal theory of biological regulation and does not prove a monotone evolutionary ratchet. | Scope statement |

## Classical ingredients, not novelty claims

- Negative-feedback control and homeostasis.
- Energetic/resource costs of biological adaptation.
- Economy–effectiveness tradeoffs in regulatory networks.
- Cost–benefit optimization of gene expression.
- Responsive versus constitutive strategies in fluctuating environments.
- Sensing versus stochastic switching.
- Regulatory loss during genome reduction.
- Convex optimization and marginal-cost/marginal-benefit reasoning.

## Explicit non-claims

The paper does not claim that:

- natural selection always maximizes the scalar growth objective used here;
- every biological controller is linear or proportional;
- all functional thresholds are externally imposed in real organisms;
- pooled regulation is always beneficial;
- the \(1/n\) pooling law holds when controller infrastructure must be duplicated proportionally;
- rare regulators are necessarily lost;
- continuous-threat regulators are necessarily retained;
- the economy–effectiveness tradeoff is novel;
- the marginal-alignment inequality supplies the size of the functional margin;
- the asymptotic separation results imply that a finite real system reaches the crossing;
- the formal proofs validate empirical biological assumptions;
- the paper establishes a universal forward direction of evolution or organization.

## Proposed empirical predictions

Under otherwise comparable conditions:

1. increasing perturbation load should increase selected regulatory investment in the linear worked model;
2. reducing exposure should weaken selection for costly regulatory capacity;
3. large constitutive monitoring cost should make low-exposure regulators especially vulnerable;
4. stronger consequence severity can retain preparedness even when events are rare;
5. where constitutive infrastructure is genuinely shared and non-rival, pooling can preserve preparedness at lower individual exposure than duplicated control;
6. selection-optimal regulation can remain below an independently specified functional or safety threshold;
7. alignment should depend on the marginal slope of the endogenous objective at the functional boundary, not merely on whether regulation is present;
8. for comparable systems, steeper functional penalties or slower-growing marginal controller costs should expand the range over which selected and sufficient control coincide.
