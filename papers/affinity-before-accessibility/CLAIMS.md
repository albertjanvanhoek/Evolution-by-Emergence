# Claim ledger

Machine-checked claims in this ledger are mapped to exact Lean declarations in [FORMAL_VERIFICATION.md](FORMAL_VERIFICATION.md).

| ID | Claim | Status |
|---|---|---|
| A1 | The current production-network stack takes effective couplings \(B_{ij}\) as given and therefore does not itself model encounter or association persistence. | Framework observation |
| A2 | Uniform scaling \(B(a)=aB_0\) scales the spectral radius by \(a\) while preserving Perron-vector shares. | Standard linear algebra / model specialization |
| A3 | Under normalized supply and linear maintained-association overhead \(\kappa(a)=ca\), the affinity score is \((2-1/(a\lambda_0))/(1+ca)\). | Model definition |
| A4 | A positive stationary point satisfying \(2c\lambda_0a^2=1+2ca\) is a global maximizer; the score gap is an exact nonnegative square. | Exact theorem; machine checked |
| A5 | The unique positive optimizer is \(a^\star=(1+\sqrt{1+2\lambda_0/c})/(2\lambda_0)\). | Exact result; explicit stationarity machine checked |
| A6 | The peak score is \(2(s-1)/(s+1)\), \(s=\sqrt{1+2\lambda_0/c}\). | Exact result; machine checked |
| A7 | For \(K>1/2\), nonnegative peak margin in the linear-upkeep family requires and is equivalent to \(c\le\lambda_0(2K-1)^2/(4K)\). | Exact algebraic result in manuscript; numerical verifier |
| A8 | The linear-upkeep volcano is not universal; bounded saturating overhead can remove the high-affinity downturn. | Exact derivative analysis for the stated saturation law; verifier |
| A9 | The turnover factor \(4a/(1+a)^2\) is positive and at most one for \(a>0\), with equality only at \(a=1\). | Exact theorem; machine checked |
| A10 | With zero association overhead and turnover-shaped productive coupling, productive mass is globally maximized at \(a=1\). | Exact theorem; machine checked |
| A11 | In an exact rational witness, \(a=1\) gives margin \(97/99\), while \(a=1/2\) and \(a=2\) give \(53/66\). | Exact theorem; machine checked |
| A12 | In the same witness, \(a=1/10\) and \(a=10\) give effective spectral scale \(48/121<1/2\), so the normalized positive equilibrium fails at both extremes. | Exact theorem; machine checked |
| A13 | The minimal turnover law is reciprocal-symmetric, \(h(a)=h(1/a)\), hence symmetric under \(\log a\mapsto-\log a\). | Exact theorem; machine checked |
| A14 | Reciprocal symmetry is a falsifiable null prediction of the minimal turnover law, not a universal property of catalytic volcanoes. | Model implication / scope statement |
| A15 | The turnover mechanism is structurally analogous to the Sabatier principle: weak association limits residence and strong association limits release/turnover. | Literature-positioned interpretation, not a universality claim |
| A16 | Affinity is one determinant of which encounters become candidate productive couplings and therefore supplies a physical component of the candidate-generation layer. | Framework interpretation |

## Non-claims

The note does not claim a new fundamental attractive force, universal association upkeep, universal volcano behavior, or that the reduced turnover law is a microscopic law. It does not claim that intermediate persistence is normatively desirable.
