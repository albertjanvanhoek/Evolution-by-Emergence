# Transparent pricing: access at cost, a separate bounty, every choice visible

This section follows up entry D30 in [DIALOGUE.md](../../DIALOGUE.md). It is an application of the theory to economics, kept separate from the core.

**Status:** a research programme with a machine-checked formal layer. The formal results are conditional implications under stated premises. Whether real systems meet the premises is open, and is a question for pilots, not for Lean.

## The problem

In the author's words: "the economy is currently run as a competition - with Marginal costs - marginal profit kind of thinking - micro-economic optimization for the individual - however as a collective this is suboptimal - and as a collective we don't have a pricing reference how things ought to be costed."

A seller with pricing power can raise its take by offering less: scarcity keeps the price up. That is rational for the seller and a loss for the whole. The loss is largest for goods that cost almost nothing to share once they exist, such as software and knowledge. Distributional choices are hidden inside margins.

## The proposal

A protocol, not a plan. In the author's words: "it should not demand a central planner - this is not about communism - this is about being autonomous interdependent."

1. **Autonomy.** Every provider decides its own costs, margin and bounty.
2. **Transparency.** It publishes them in one shared format, with its inputs.
3. **Interdependence.** Each provider buys from others at their published prices, so prices compose through supply chains. Buyers, peers and the public respond to what they see.
4. **Separation.** The reward for solving a problem is paid as a separate bounty, not collected by restricting access. Every other job that profit does gets its own declared field.

The author's starting point is an internal tariff: "internal pricing extended outward is fair pricing all along."

## What is proved

The formal layer is in [formalization/transparent-pricing/](../../formalization/transparent-pricing/README.md): core Lean, no Mathlib, 68 results, an axiom audit, and its own CI.

| Claim | Result | Status |
|---|---|---|
| Every unit above cost is a published margin of a named provider, in a supply network of any depth | `price_traceable`, `above_cost_is_margins` | Proved |
| Absolute margins add along a chain; percentage margins compound | `absolute_margins_add`, `percent_margins_compound` | Proved |
| For any demand: a margin never serves more, and destroys exactly the value of the units it excludes | `higher_margin_serves_no_more`, `margin_cost_exact` | Proved |
| For any demand: the same reward paid as a separate bounty serves at least as many and creates more value | `bounty_beats_margin_any_demand` | Proved |
| Demand at cost does not reveal value, so it cannot size a bounty | `at_cost_demand_does_not_reveal_value` | Proved (counterexample) |
| Hidden margins are deterred exactly when detection times loss covers the gain | `hiding_deterred_iff` | Proved |
| A scarcity charge puts scarce units where they create the most value; a queue can waste them | `charge_allocates_best`, `queue_can_waste` | Proved |
| Scarcity revenue routed into capacity removes the shortage in finite time; kept as margin, it is permanent | `routed_removes_scarcity`, `kept_scarcity_permanent` | Proved, given the revenue buys capacity |
| Risk: a bounty must also carry the cost of failed attempts | `risk_pool_solvent_iff` | Proved |
| Cost discipline: cost-plus rewards no saving; shared savings rewards it and lowers the price | `cost_plus_no_incentive`, `shared_rewards_saving`, `shared_lowers_price` | Proved |
| Entry: open entry never raises the best price; a cheaper entrant lowers it | `entry_never_raises`, `cheaper_entrant_lowers` | Proved |
| Surplus: refunds in proportion to use make everyone pay exactly cost | `patronage_at_cost_all` | Proved |
| Renewal: funding wear keeps the service; not funding it runs it down | `renewal_keeps_service`, `no_renewal_runs_down` | Proved |
| Bounty pool: never overspent; more impact earns more; claims compete | `pool_never_overspent`, `more_impact_more_pay`, `more_claims_less_each` | Proved |
| Scarce tokens make demand signals costly; matching rewards many backers over one | `tokens_bound`, `matching_rewards_breadth` | Proved, given one identity per participant |
| Capacity pricing recovers step costs to within one unit; at-cost stacking conserves cost | `StackedTariffs.capacity_rate_within_one_fte`, `StackedTariffs.at_cost_stack_conserves` | Proved |

How much each says: most results are close to arithmetic once the setting is fixed. The ones that carry an argument are `margin_cost_exact` and `bounty_beats_margin_any_demand` (any demand), `charge_allocates_best` (an exchange argument), and `routed_removes_scarcity` with `kept_scarcity_permanent` (the incentive the author started from).

## What is assumed, and what is a choice

- **Assumed:**
  - providers adopt the format;
  - figures are checked often enough;
  - buyers compare published prices;
  - scarcity revenue really buys capacity;
  - success rates are roughly known when risk is priced;
  - a credible benchmark exists for shared savings;
  - impact is measured well and is not gamed;
  - one identity per participant.
- **Choices, not theorems:**
  - how large a bounty is, and who funds it;
  - whether scarce goods go by willingness to pay, by need or by lottery;
  - how surplus is shared;
  - which externalities are counted, and at what value.

## Sources

- [BRIEF.md](BRIEF.md): the research brief given to research agents.
- [sources/REPORT_1_AT_COST_PRICING.pdf](sources/REPORT_1_AT_COST_PRICING.pdf): report 1, by a research agent, kept as received. Which model family wrote it is not recorded. Its verdict is that the combination is partly novel, with Arrow (1962) as the closest prior art. Its central correction: profit does several jobs, and each needs its own home.
- [sources/DISTRIBUTION_FIRST_ECONOMICS.md](sources/DISTRIBUTION_FIRST_ECONOMICS.md): a synthesis by a second research agent, kept as received. It names the approach "distribution-first economics" and adds two fields: external costs and explicit subsidies. Which model family wrote it is not recorded.

Both readers are research agents, not independent human reviewers (working agreement 7).

## Plan: what else belongs here, and where

| What | Where | Why |
|---|---|---|
| The one-page protocol: the shared format, the rules, and the theorem behind each | `PROTOCOL.md` | The publishable short version |
| Review of the reports against the Lean results, including the two readings report 1 weakened | `REVIEW_OF_THE_REPORTS.md` | Keep the formal layer honest |
| Report 2, when it arrives | `sources/` | Kept as received |
| An externalities field (a physical ledger plus a separately chosen valuation) and an explicit subsidy field | `formalization/transparent-pricing/` | Raised by both reports; not yet formal |
| A probabilistic version of pooled reserves | `formalization/transparent-pricing/` | Report 1: independent errors partly cancel |
| A worked example in the published format, starting from the author's seed tariff | `PROTOCOL.md` | Only with the author's consent to publish its figures |
| Pilot design: open-source software for public institutions, with evaluation criteria | `PILOT.md` | Both reports recommend this as the first test |
| Governance and legal notes: bounty authority, a trustee for cost data (EU competition law), the state-aid route | `GOVERNANCE.md` | Report 1, questions 8 and 10 |
| Testable predictions | a new part in [PREDICTIONS.md](../../PREDICTIONS.md) | The theory's discipline: say what would count against it |
| Bridge to the theory: capture as externalised cost (D27), the commons (step 6), relational duties (D28) | this README | The economics is step 6 applied |

## How it relates to the theory

- **Capture** (step 6, D27). Restricting supply to raise the price is capture: gains to the seller, costs to those left out. `kept_scarcity_permanent` is the formal form of the author's starting complaint.
- **Taming capture** ([TamedCapture.lean](../../formalization/cumulative-accessibility/CumulativeAccessibility/TamedCapture.lean)). Checking with a loss on detection (`hiding_deterred_iff`) is distributed policing applied to prices.
- **The commons.** Interfaces funded as a commons, and a bounty pool with a hard budget, are commons with Ostrom-style governance.
- **Relational duties** (D28). Transparency of cost and margin is a duty of effort in an economic relationship: do not pass your costs to the other unseen.
