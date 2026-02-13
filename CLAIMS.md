# CLAIMS

Machine-readable-oriented claim ledger for agentic evaluation.

## Fields
- **claim_id**: stable identifier
- **claim**: concise proposition
- **source_files**: where this is discussed
- **evidence_type**: conceptual, formal, empirical-programmatic, or mixed
- **falsification_path**: concrete way to challenge/test the claim
- **evaluation_prompt**: reusable prompt skeleton for autonomous evaluators

## Claim ledger

| claim_id | claim | source_files | evidence_type | falsification_path | evaluation_prompt |
|---|---|---|---|---|---|
| CLM_EBE_001 | Emergence-driven evolutionary dynamics are not limited to biology and can model social and artificial systems. | `README.md`; `Chapters/Chapter_1.tex`; `Chapters/Chapter_9.tex` | Conceptual + cross-domain synthesis | Provide a domain where network/feedback framing fails to explain persistence or adaptation better than non-network alternatives. | "Given domain X, compare EbE-style network explanation vs baseline linear explanation. Which predicts outcomes better and why?" |
| CLM_EBE_002 | Intelligence viability is constrained by layered substrate dependency I->B->R->P. | `README.md`; `Chapters/Chapter_6.tex`; `Backmatter/Appendix26.tex` | Formal-conceptual | Show a persistent intelligence model that maximizes long-run performance while violating one substrate floor. | "Evaluate strategy S for explicit B/R/P floor violations and estimate downstream failure risk over horizon H." |
| CLM_EBE_003 | O1/O2/O3 follow functionally from the dependency model (not merely from normative preference). | `README.md`; `Backmatter/Appendix26.tex` | Formal argument | Derive alternative operators from same premises that achieve equal or better viability without O1/O2/O3 properties. | "From stated premises, derive minimal operator set; test whether O1/O2/O3 are necessary, sufficient, or replaceable." |
| CLM_EBE_004 | SCAP operationalizes O1/O2/O3 into implementable governance blocks. | `README.md`; `Backmatter/Appendix.tex`; `Backmatter/AppendixIII.tex` | Operational mapping | Identify SCAP blocks that do not map cleanly to O1/O2/O3 or yield contradictory incentives under realistic constraints. | "Map each SCAP block to O1/O2/O3, list missing links/conflicts, and propose revisions." |
| CLM_EBE_005 | Better proof economies (cheap verification, costly deception) improve persistence quality in complex systems. | `README.md`; `Backmatter/Appendix26.tex` | Theory with empirical implications | Produce cases where stronger verification infrastructure worsens long-horizon persistence after controlling for context. | "Assess system Y before/after verification reforms; estimate persistence, trust, and adaptation deltas." |
| CLM_EBE_006 | Stress weakens checking loops and increases contaminated updates ("mud"), raising decision error rates. | `README.md`; `Backmatter/appendixXI.tex`; `Backmatter/appendixXII.tex` | Mechanistic hypothesis | Show robust datasets where stress increase is not associated with degraded checking quality or error increase. | "For cohort/data Z, test correlation/causal link between stress markers and model-update/decision quality metrics." |

## Suggested evaluator output schema (JSON)

```json
{
  "claim_id": "CLM_EBE_003",
  "result": "supported|mixed|challenged",
  "confidence": 0.0,
  "supporting_evidence": ["..."],
  "counterevidence": ["..."],
  "assumptions": ["..."],
  "next_tests": ["..."]
}
```

