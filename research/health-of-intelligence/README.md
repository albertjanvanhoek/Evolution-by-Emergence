# The health of intelligence, and of the commons

**Status: concept stage, October 2026.** Hypotheses and a measurement programme, not results. Nothing here is a validated instrument. The theory these notes apply is in [CORE.md](../../CORE.md).

## The question

Quality of life is measured with instruments such as EQ-5D, which take the intelligence of the person for granted and mean nothing for an AI system. Can the health of intelligence be measured in the same functional terms for a person, an AI system and an institution? And because health and intelligence are relational, what is the health of the commons they live in?

## Read in this order

1. **[HEALTH_OF_INTELLIGENCE.md](HEALTH_OF_INTELLIGENCE.md):** the concept note.
   - a working definition;
   - what exists already;
   - the unit of analysis;
   - five domains (grounding, learning and retention, correction and source independence, resources, robustness);
   - supported intelligence;
   - why a profile comes before a score;
   - equity;
   - what it teaches the theory.
2. **[HEALTH_OF_THE_COMMONS.md](HEALTH_OF_THE_COMMONS.md):** the concept note on the commons.
   - inflow, stock and outflow;
   - the same profile read at node, relation and commons level;
   - reach;
   - care as a transfer;
   - many ledgers;
   - the AI case.
3. **[REVIEW_OF_THE_REPORTS.md](REVIEW_OF_THE_REPORTS.md):** the reviews of the three research reports, what was adopted and what changed in the repository.
4. **[briefs/](briefs/):** the two research briefs, verbatim.
   - **[Brief 1](briefs/BRIEF_1_HEALTH_OF_INTELLIGENCE.md):** the health of intelligence; answered by the two reports.
   - **[Brief 2](briefs/BRIEF_2_HEALTH_OF_THE_COMMONS.md):** the health of the commons; answered by report C.
5. **[sources/](sources/):** the reports produced from the two briefs.
   - Report A, *Toward a Shared Measure of the Health of Intelligence*;
   - Report B, *A shared measure of the health of intelligence: critical research overview*.
   - Report C, *The Health of the Commons: Relational Health and Intelligence Across Persons, AI Systems, and Shared Conditions* (from brief 2).

   All three were written by AI research agents for the author. They are kept as received, as the record. Reports A and C contain citation-marker leftovers, and report A also contains tracking parameters in its links. Check any source they cite against its original record before quoting it.

## What is machine-checked

- **[`HealthProfile.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/HealthProfile.lean):** a product of stage scores is zero exactly when a stage is zero, a sum hides a failed stage, and order-preserving relabelling of ordinal levels can reverse rankings under a sum or a product, while dominance survives.
- **[`CareTransfer.lean`](../../formalization/cumulative-accessibility/CumulativeAccessibility/CareTransfer.lean):** care moves slack without creating it, care lasts exactly when it fits the carer's slack plus respite on every dimension of the carer's reserve (a surplus in one does not cover a deficit in another), the carer burns out otherwise, and the cared-for falls once care stops.
- **Related results in `CORE.md`:** `internallyViable_iff_exists_viable_transfer`, `transfer_breaks_part_with_whole_unchanged`, the commons results of step 6 and the correction results of step 8.

## Next steps

- Make power, distribution and rights, and time horizons explicit in the theory (report C).
- State carer exhaustion with uncertain costs and several carers.
- The cheapest first test (H1 in [PREDICTIONS.md](../../PREDICTIONS.md)): correction integrity across substrates, starting with AI systems, using matched valid and misleading feedback and planted errors.
- Define "staying in step" operationally for each kind of unit.
