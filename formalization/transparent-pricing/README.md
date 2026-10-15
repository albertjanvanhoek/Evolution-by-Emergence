# Transparent pricing: formal layer

A standalone Lean package (core Lean 4.33, no Mathlib) for [research/transparent-pricing/](../../research/transparent-pricing/README.md). It has its own CI: `.github/workflows/transparent-pricing-check.yml`.

| File | What it proves |
|---|---|
| [`TransparentPricing.lean`](TransparentPricing.lean) | The protocol: traceability in supply networks of any depth; absolute versus percentage margins; the exact cost of a margin and the advantage of a separate bounty, for any demand; demand at cost does not reveal value; hidden margins and checking; scarcity (clearing charge, allocation, queues, routing into capacity); the other jobs of profit (risk, cost discipline, entry, surplus, renewal); sizing the bounty (fixed pool, cap, tokens, matching, payment in parts); external costs passed on once; discovering the reward by competing bids; expiring efficiency rewards; systematic deficits and pooling; who pays (incidence); when fixed costs spiral. 65 results, with a witness |
| [`StackedTariffs.lean`](StackedTariffs.lean) | A seed tariff: capacity pricing within one step, volume pricing raises the share when users leave, at-cost stacking conserves cost, percentage margins compound, interface costs make the price grow with depth, worst-case step errors add, renewal. 11 results, with a witness |
| [`Audit.lean`](Audit.lean) | `#print axioms` for every result. CI fails on `sorryAx` |

Each result is a conditional implication under the premises in its docstring. Most are close to arithmetic once the setting is fixed; the substance is in the setting. See the research README for which results carry an argument, what is assumed, and what is a value choice.

## Check locally

```bash
cd formalization/transparent-pricing
lake build
lake env lean Audit.lean
```
