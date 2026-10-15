# Research brief: pricing for maximum distribution, with an at-cost price structure and an explicit bounty for solving problems

This is the brief given to research agents (D30). It is kept as sent, except that the seed example no longer names the organisation it came from.

## The problem

In standard microeconomics a seller maximises profit, not distribution. A seller with pricing power can raise profit by offering *less*: scarcity keeps the price up while demand stays the same. That's rational for the seller, but collectively it's a loss. People who would pay the cost are left out, and the value they'd have gained disappears (the deadweight loss of market power). For goods with near-zero marginal cost, such as software, knowledge, data and medicines once developed, the loss is largest: restricting access saves almost nothing.

There is also no shared reference for what things ought to cost. Distributional choices (who gains, who is excluded, who pays for what no one causes) are hidden inside margins. And profit plays two roles at once: it is a reward for solving a problem, and a price that restricts access.

## The proposal to research

A pricing structure that optimises for **low price and maximum distribution**, while keeping the incentive to solve problems. It has four parts:

1. **An at-cost price, built recursively.** Each provider's price is its own cost plus what it pays its suppliers, passed on transparently through the chain. Costs are classified by what causes them: what grows with a user's use is passed through, the rest is covered by a capacity-based rate.
2. **Interfaces funded as a commons.** Shared infrastructure that no single user causes (metering, billing, reserves, standards) is funded centrally, so adding a link to the chain costs almost nothing.
3. **An explicit bounty, separate from the price.** Profit is understood as a bounty: the reward for whoever solves a problem. Instead of collecting it by restricting access, it is paid separately, sized by the value the solution creates, as revealed by demand.
4. **Traceable distribution.** Because costs and bounties are explicit, the ethical choices become visible and open to debate: how large a bounty is, who pays it, who is subsidised.

## Seed example (illustration only)

An internal tariff for a digital service:
- **Price** = entry fee + capacity rate × time + pass-through of metered use.
- **Capacity rate:** cost per capacity unit ÷ the users one unit can serve, so prices don't depend on how many others participate.
- **Costs no user causes** are funded centrally.
- **Rate setting:** rates are fixed annually, with a reserve that absorbs deviations within a band.
- **No profit.**

A formal check (Lean 4, under stated premises) found:
1. Capacity pricing recovers step costs to within one capacity unit.
2. Volume-based allocation of fixed costs causes a death spiral.
3. At-cost stacking conserves cost exactly.
4. Margins compound across layers.
5. Any positive cost per interface limits the depth of a chain.
6. Step errors add up across layers unless reserves are pooled.
7. Covering running costs without renewal runs a service down.

Test these findings against the literature; don't assume them.

## Research questions

1. **The cost of restricting supply.** What does theory and evidence say about the deadweight loss of market power and its size (Harberger 1954 and later estimates)? Why is it largest for non-rival goods (Arrow 1962)? How do price discrimination and tiered pricing change distribution?
2. **Economy-wide at-cost price systems.** Cover Leontief's input-output price model, the Hawkins–Simon condition, and Sraffa (1960). Do recursive at-cost prices exist, are they unique and stable, and what do national input-output tables offer as a practical cost reference?
3. **Separating the bounty from the price.** Cover patent buyouts (Kremer 1998); prizes instead of patents (Stiglitz and others); advance market commitments, especially the pneumococcal vaccine AMC; the Health Impact Fund (Hollis and Pogge); open-source and public-goods funding models. How is the reward sized, who funds it, how is value measured when prices are set at cost, and what were the outcomes?
4. **The strongest objection: knowledge, incentives and discovery.** Cover Mises (1920) and Hayek ("The Use of Knowledge in Society", 1945); Lange and Lerner's market-socialist replies, and modern computational revisits; the incentive problems of cost-based pricing: cost-plus regulation, the Averch–Johnson effect, Laffont and Tirole. Does an explicit bounty, sized by demand, answer the objection that only profit signals what should exist and rewards efficiency and innovation? What else would be needed?
5. **Fixed costs and the commons.** Cover Hotelling (1938), Coase ("The Marginal Cost Controversy", 1946), Oi (1971) on two-part tariffs, Ramsey–Boiteux pricing, club goods, Ostrom's design principles (especially "nested enterprises") and commons-based peer production (Benkler). How should infrastructure no single user causes be funded and governed at scale?
6. **Externalities and sustainability.** Cover Pigou, true cost accounting and true pricing (including the True Price Foundation), and environmental input-output analysis. Can a recursive at-cost structure carry environmental and social costs through supply chains?
7. **Traceable distribution.** Look at open-book accounting, cooperative surplus distribution, the Economy for the Common Good, doughnut economics and participatory budgeting. Does making distributional choices explicit change the choices made? What is the evidence?
8. **Cases at scale.** Cover cooperatives and federations trading at cost (Mondragon, energy and agricultural cooperatives), regulated utilities, shared public infrastructure consortia, platform cooperatives, and planned-economy experience. What worked and what failed, and why: death spirals, capture of rate-setting or bounty funds, under-funded renewal, loss of innovation?
9. **Composition and stability across chains.** Cover double marginalization (Spengler 1950), the bullwhip effect (Lee, Padmanabhan and Whang 1997), transaction costs as the limit on chain depth (Coase 1937, Williamson), and fair allocation of shared costs (Shapley, Aumann–Shapley; Billera, Heath and Raanan 1978).
10. **Coexistence and transition.** Can an at-cost layer with a bounty fund operate inside a market economy, for example as a reference price or public option that firms compete against? What precedents and legal constraints exist (competition law, EU state aid)?

## Deliverables

1. A report of around 6,000–10,000 words, with:
   - an executive summary of at most one page, with a clear verdict: what is established, what is partly new, what is genuinely new, and the strongest reasons it might not work;
   - one section per research question;
   - a prior-art table: source, what it covers, closeness to the proposal, gaps;
   - a section testing each of the seven formal findings: supported, contradicted, or refined;
   - a section on sizing and governing the bounty;
   - a design sketch of a minimal pilot in one sector or chain, ideally one with low marginal cost, such as software or a medicine;
   - risks and open questions.
2. A source list with full citations and links.

## Rules

- **Check before claiming.** Only cite figures, quotes or attributions you have seen in their primary source. Search summaries and secondary sites are leads, not sources. Mark anything you couldn't verify.
- Separate evidence, inference and value judgement. Whether distribution or profit should be the goal is a value; say so where it matters.
- Give the objections (Hayek, incentive theory, historical failures) as much weight as the supporting work. A finding that the idea already exists, or fails for a known reason, is a valuable result.
- Write plainly: short sentences, plain words.
