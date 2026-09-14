# Claim ledger

This file separates the paper's mathematical deductions, classical ingredients, counterexample conclusions, and non-claims.

| ID | Statement | Status | Where checked |
|---|---|---|---|
| C1 | At a positive Perron equilibrium, gross mean production satisfies \(\bar w^*=d\). | Derived algebraically | Manuscript §3; related equilibrium formalization in \`EquilibriumExposure.lean\` |
| C2 | \(r^*=d/\lambda\) decreases and \(X^*=J/d-\ell/\lambda\) increases with \(\lambda>0\). | Derived; machine-checked for the relevant monotonicities | Manuscript §2; \`EquilibriumExposure.lean\` |
| C3 | In the \(A\)-\(B\)-\(C\) reallocation family, \(\lambda(f,v)=\sqrt{1+f(v-1)}\). | Derived algebraically | Manuscript §4; Organizational Accessibility formalization |
| C4 | Perron positivity under irreducibility does not protect quantitative abundance: \(p_B=(1-f)/(1+\lambda)\to0\) as \(f\to1^-\). | Exact counterexample | Manuscript §5 |
| C5 | Reducibility does not imply loss of full support; \(B=\begin{pmatrix}2&0\\1&1\end{pmatrix}\) has positive eigenvector \((1,1)^T\) at eigenvalue 2. | Exact counterexample | Manuscript §6 |
| C6 | For a one-way downstream extension, host composition is uniformly diluted by \(1/(1+\kappa)\), while host-internal ratios are invariant. | Derived algebraically | Manuscript §7 |
| C7 | In that downstream construction, \(\lambda\), \(r^*\), and total \(X^*\) remain unchanged while mass is redistributed. | Derived algebraically | Manuscript §7 |
| C8 | With the prespecified capacity system, integrated hollowing crosses \(M=0\) at \(f^*=0.7198206\) while \(\lambda\) and \(X^*\) rise. | Exact worked counterexample; threshold algebra machine-checked | Manuscript §§9–10; \`FunctionalThresholds.lean\` |
| C9 | For any degree-one homogeneous capacity score under uniform host dilution, \(M(\kappa)=(M^0-\kappa)/(1+\kappa)\). | Machine-checked | \`FunctionalThresholds.lean\` |
| C10 | Under the same assumptions, functional viability is equivalent to \(\kappa\le M^0\), hence \(\kappa_{\rm crit}=M^0\). | Machine-checked | \`FunctionalThresholds.lean\` |
| C11 | None of the endogenous observables considered in the worked examples recovers the prespecified functional verdict in general. | Counterexample conclusion | Manuscript §12 |
| C12 | Persistence alone does not induce a universal organizational ordering in this model class. | Counterexample conclusion, not a universal theorem about all conceivable models | Manuscript §§14–17 |
| C13 | The current model contains no endogenous regulator: \(B\) is constant and \(\Phi,\theta\) are external evaluation objects. | Model-scope statement | Manuscript §16 |
| C14 | \(R_{\rm reg}=\nu L-c\) and its pooled form are proposed bookkeeping hypotheses for a future state-dependent extension, not theorems of the current ODE. | Explicit hypothesis | Manuscript §16 |

## Classical ingredients, not novelty claims

- Perron-Frobenius positivity for irreducible non-negative matrices.
- Reducible non-negative matrix / communicating-class theory.
- The resource-competition \(R^*\) logic used for independent competing blocks.
- Degree-one homogeneity of linear and Leontief/minimum capacity maps under uniform scaling.

The paper's contribution is how these ingredients diagnose distinct questions in one self-maintaining production model and the exact counterexamples that prevent their observables from being conflated.

## Explicit non-claims

The paper does **not** establish that:

- evolution generally reduces functional capacity;
- efficiency and function are usually negatively related;
- complexity has a universal scalar definition;
- persistence necessarily increases or decreases complexity;
- the declared thresholds are biologically privileged;
- the toy production model is empirically adequate for a specific biological, social, or technological system;
- the Perron-Frobenius or resource-competition mathematics used here is new;
- the machine verification validates empirical assumptions.
- threat frequency alone determines whether a regulator is retained;
- the present model contains endogenous sensing, checkpoints, homeostatic feedback, or other biological regulation.

## Reproducibility anchors

Paper-specific Lean proof state:

    eadc51028da96fd7e92fe38af66b61743bae10a0

Current paper package:

    papers/persistence-does-not-measure-function/

Figure/source consistency is checked by:

    .github/workflows/persistence-function-paper-check.yml
