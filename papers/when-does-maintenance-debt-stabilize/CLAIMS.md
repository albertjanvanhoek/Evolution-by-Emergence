# Claim ledger

| ID | Statement | Status |
|---|---|---|
| M1 | The base model has interior equilibrium \(h^*=K^*=1-c/\alpha\), \(x^*=(\delta/a)(1-c/\alpha)\) when \(x^*\in(0,1)\). | Exact algebra; machine checked in the end-to-end formalization |
| M2 | With \(b=x^*(1-x^*)\), the base characteristic polynomial is \(\lambda^3+(\delta+\varepsilon)\lambda^2+\delta\varepsilon\lambda+a\alpha b\varepsilon\). | Exact calculation; special case of the machine-checked debt-aware polynomial |
| M3 | The base equilibrium is Hurwitz iff \(\delta(\delta+\varepsilon)>a\alpha b\) in the positive-parameter interior regime. | Exact cubic criterion |
| M4 | At equality, the polynomial factorizes as \((\lambda+\delta+\varepsilon)(\lambda^2+\delta\varepsilon)\). | Exact algebra |
| M5 | The equality in M4 is an imaginary-axis spectral boundary; a full nonlinear Hopf theorem requires additional conditions. | Exact spectral statement plus scope restriction |
| M6 | Every differentiable interior periodic orbit of the base ODE has \(\langle h\rangle=\langle K\rangle=1-c/\alpha\) and \(\langle x\rangle=(\delta/a)(1-c/\alpha)\). | Exact theorem; machine checked from the ODE using FTC |
| M7 | Maintenance debt \(D=\delta K-ax\) satisfies \(D=-\dot K\). | Exact identity |
| M8 | Every periodic orbit covered by M6 has \(\langle D\rangle=0\). | Exact corollary |
| M9 | Adding debt sensitivity \(\gamma\) through \(\dot x=x(1-x)[\alpha(1-h)-c+\gamma(\delta K-ax)]\) leaves the interior equilibrium location unchanged. | Exact algebra; machine checked |
| M10 | The debt-aware nonlinear vector field has Jacobian \(J_\gamma=\begin{pmatrix}-a\gamma b&\delta\gamma b&-\alpha b\\a&-\delta&0\\0&\varepsilon&-\varepsilon\end{pmatrix}\). | Exact differentiation; machine checked directly from the nonlinear flow |
| M11 | The debt-aware characteristic polynomial is \(\lambda^3+(\delta+\varepsilon+ab\gamma)\lambda^2+(\delta\varepsilon+ab\varepsilon\gamma)\lambda+a\alpha b\varepsilon\). | Exact determinant identity; machine checked |
| M12 | The debt-aware equilibrium is Hurwitz when \((\delta+\varepsilon+ab\gamma)(\delta+ab\gamma)>a\alpha b\). | Exact root-location result; relevant cubic theorem proved directly in Lean |
| M13 | \(y_{\rm crit}=(\sqrt{\varepsilon^2+4a\alpha b}-\varepsilon)/2\) solves \(y(y+\varepsilon)=a\alpha b\). | Exact theorem; machine checked |
| M14 | \(\gamma_{\rm crit}=(y_{\rm crit}-\delta)/(ab)\), and \(\gamma>\gamma_{\rm crit}\) implies all characteristic roots have negative real part under the stated positivity/interiority assumptions. | Exact theorem; machine checked |
| M15 | The stability-side expression is monotone increasing in nonnegative \(\gamma\). | Exact theorem; machine checked |
| M16 | For \(\alpha=1,c=0.2,a=1,\delta=\varepsilon=0.2\), \(x^*=0.16\), \(b=0.1344\), \(\gamma_{\rm crit}=0.595238\ldots\). | Numerical evaluation of exact formulas |
| M17 | The model distinguishes visible state from replacement balance: \(K\) can be high while \(D>0\) and \(\dot K<0\). | Exact model implication / interpretation |
| M18 | Oscillatory behavior-environment feedback is established in prior feedback-evolving game models. | Literature-positioning claim |
| M19 | A Hurwitz Jacobian implies local asymptotic stability for the relevant \(C^1\) nonlinear system by the standard linearization theorem. | Standard external theorem; not formalized in this repository |
| M20 | The reported formal declarations contain no sorryAx. | Verification-status claim; final green CI commit recorded in REPRODUCIBILITY.md |

## Non-claims

The paper does not claim that:

- all maintenance systems are accurately represented by three scalar state variables;
- feedback-induced oscillations are novel;
- all oscillations arise from slow-fast separation;
- the spectral boundary alone proves a nonlinear Hopf bifurcation;
- debt sensitivity is costless, instantaneous, or universally stabilizing outside the stated model;
- zero mean maintenance debt makes a cycle harmless;
- the model derives the evolutionary origin or institutional adoption of debt-sensitive control;
- local Hurwitz stability implies global stability;
- a periodic orbit necessarily exists whenever the base equilibrium is non-Hurwitz;
- the same empirical variable definitions apply across organisms, institutions, infrastructure, ecosystems, or economies;
- oscillation by itself constitutes cumulative emergence.
