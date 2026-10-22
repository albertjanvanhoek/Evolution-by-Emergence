> **Review A, 22 October 2026.** The first independent assessment of [research/cooperative-correction/](../README.md), given [REVIEW_BRIEF.md](../briefs/REVIEW_BRIEF.md) in two messages. Its Part 0 answers were recorded before message 2 was sent ([REVIEW_A_PART0.md](REVIEW_A_PART0.md)). Kept verbatim as received, except that runs of blank lines were reduced to one. The response is in [RESPONSE_A.md](RESPONSE_A.md).

# Independent review: Cooperative Error Identification

## Part 0 — Independent answers before assessing the research

### 0.1 Can two intelligences with incompatible world models identify errors without adopting a common worldview?

Yes, provided they can establish a sufficiently precise relationship between some of their claims and observations.

They need not agree on their explanations, ontologies, or broader beliefs. At minimum, they need a way to identify claims that concern the same phenomenon, distinguish incompatible predictions, and establish some mutually recognizable observations.

A contradiction establishes that not all claims can be true under the same interpretation. It does not establish which claim is false. Identifying a particular error requires additional evidence or assumptions.

The smallest useful shared foundation may therefore be an operational interface between models, rather than a shared model of reality.

### 0.2 Can intelligences that disagree about evidence construct a shared evidential standard?

Sometimes. They can jointly devise procedures whose outputs are publicly inspectable, repeatable, and independently recorded, even when they initially disagree about their interpretation.

They might begin by comparing observations, reproducing operations, identifying stable regularities, and progressively negotiating operational definitions. Neither must initially accept the other's explanatory theory.

However, this process cannot eliminate every background assumption. The reliability of perception, instrumentation, communication, and records remains relevant. Two agents can establish a stable shared procedure that systematically misrepresents reality.

Thus, agreement about observations can emerge without agreement about explanations, but reproducibility alone cannot guarantee truth.

### 0.3 When does cooperation improve world models, and when does it make them worse?

Cooperation should improve world models when agents possess complementary information or partially independent errors, communicate their uncertainty and provenance, can identify informative discrepancies, and respond appropriately to correction.

It can worsen them when correlated evidence is mistaken for independent confirmation, unreliable contributors receive excessive weight, consensus suppresses useful dissent, or agents jointly reinforce a shared error.

The right comparison is not simply cooperation versus independence. It includes different methods of cooperation, information-sharing costs, and the possibility that the independent agents have access to different quantities of evidence.

An effective collective must evaluate both the accuracy of its conclusions and its capacity to detect future mistakes.

### 0.4 Should a collective preserve independent ways of modelling reality?

Yes, where their independence provides useful opportunities for cross-validation, discovering previously unrecognized errors, or responding to changes.

The valuable diversity concerns measurement methods, evidence sources, modelling assumptions, causal hypotheses, and potentially conceptual frameworks. Differences in conclusions can also be informative when evidence genuinely underdetermines the answer. Artificially maintaining beliefs already contradicted by reliable evidence has no intrinsic epistemic value.

There is no universally optimal number of independent models. That depends on costs, error correlations, the consequences of undetected failures, and the possibility of developing fundamentally new methods.

The objective should be adaptive epistemic diversity: preserve and develop sufficiently independent ways of learning, without treating diversity itself as proof of reliability.

## Verdict (6.2): YES WITH CHANGES

The note is suitable for inclusion as research on open conjectures, but not yet as evidence that cooperative error identification outperforms alternative approaches. The formal model establishes useful conditional propositions. The simulations reproduce, but a central causal interpretation of their results needs correction.

## 2. Formal model

I examined the complete Lean module provided in the second file and checked its definitions and proof arguments. Lean 4.33 is not installed in my environment, so I cannot independently certify compilation.

### 2.1 Separation of logic and behaviour

The separation is largely successful.

`discrimination_exposes_one` concerns logical incompatibility. `Responsive` separately represents a behavioural response. This avoids treating recognition of an error as automatically producing correction.

However, `Responsive` is defined as:

\\[ \neg\operatorname{Allows}(A,op,o)\Rightarrow A'\ne A. \\]

This establishes only that the agent changes. It does not establish that the change addresses the exposed error, improves accuracy, or avoids introducing additional errors.

A genuinely corrective behavioural condition would need to be stronger.

### 2.2 The theorem statements

Most results follow correctly from the displayed definitions. Important qualifications are:

| Result                                | Assessment                                                                                     |
| ------------------------------------- | ---------------------------------------------------------------------------------------------- |
| `discrimination_exposes_one`          | Correct; a consequence of disjoint allowed-outcome sets                                        |
| `exposure_does_not_say_who`           | Correct, conditional on each agent allowing the specified outcome                              |
| `failure_is_support_or_mechanism`     | Correct disjunction; an actual error requires a true outcome record                            |
| `faithful_agent_accommodates`         | Correct, directly from `Allows`                                                                |
| `uncommitted_agent_is_never_exposed`  | Correct under the stated universal allowance                                                   |
| `discrimination_requires_commitment`  | Correct when both agents have a possible outcome                                               |
| `bridges_grow_with_shared_operations` | Correct for fixed agent models, not necessarily after those models change                      |
| `responsive_agent_revises`            | Correct restatement of its assumption; does not establish beneficial revision                  |
| Two witnesses                         | Illustrate the intended distinctions, without establishing their general practical feasibility |

One important issue is definitional: `Bridge` is a shared operation that discriminates two models. It does not itself require that the operation was performed, that an outcome was successfully recorded, or that an agreed evidential standard emerged.

Consequently, the formalization establishes the consequences of an available discriminating operation, not a process that constructs such an operation.

There is also a degenerate case: a model with empty support accommodates no outcomes and can therefore discriminate another model trivially. Meaningful commitment needs a nonempty-support condition.

### 2.3 What the bridge requires

The proposal has genuinely weakened the requirements for cooperation. Sharing a record is less demanding than sharing an explanation.

Nevertheless, the agents already share types of possible worlds, operations and outcomes, and an exact identification of the operation being performed. The witness demonstrates different predictions within that common structure, not negotiation between incompatible representational systems.

This is an acceptable starting point, provided it is described as an operational compatibility assumption, rather than an absence of all shared interpretation.

### 2.4 Verification

The repository's [PR #143](https://github.com/albertjanvanhoek/Evolution-by-Emergence/pull/143?utm_source=chatgpt.com) is open and unmerged. Its description reports a successful Lean compilation. That is the author's verification; my assessment of the pasted Lean code is by inspection.

## 3. Simulation audit

I extracted `sim.py` from the supplied research brief and executed it with NumPy 2.3.5.

All reported numerical results reproduced, including E1–E5. Reproducibility is not the problem. The interpretation of what causes the improvements is.

### 3.1 The central problem: the bridge does not improve the collective point estimate

This is the most important finding of my review.

The cooperative algorithm calculates an individual correction from its reference measurement, then averages corrected estimates across error origins.

Let \\(m_i\\) be an origin's ordinary measurement, \\(g_i\\) its reference reading, and \\(\bar g\\) the average reference reading across origins. The corrected value is

\\[ m_i^{\mathrm{corrected}}=m_i-(g_i-\bar g). \\]

But averaging these corrected values gives

\\[ \begin{aligned} \bar m^{\mathrm{corrected}} &=\frac1k\sum_i(m_i-g_i+\bar g)\\\ &=\frac1k\sum_i m_i. \end{aligned} \\]

The reference correction cancels exactly.

This is not merely a theoretical concern. I independently tested the implementation.

Independent ablation: remove the bridge's contribution to the estimate

| Experiment            | Published cooperative RMSE | Same estimate without reference correction |
| --------------------- | -------------------------- | ------------------------------------------ |
| E1, dependent sources | 0.2463                     | 0.2463                                     |
| E2, later drift       | 0.3537                     | 0.3537                                     |

The largest numerical difference between these estimators was below 10⁻¹⁵. Replacing the reference readings with arbitrary unrelated values also left the point estimates unchanged, to floating-point precision.

So the difference between forced consensus (RMSE 0.275) and cooperative estimation (0.246) in E1 comes from weighting independent error origins rather than individual agents. This is a useful result about provenance, but not evidence that bridge-mediated correction improves the collective estimate.

The bridge remains useful for individual relative correction, uncertainty estimation and drift detection. Those claims should be evaluated separately.

### 3.2 The calibration comparison is unfair

The forced-consensus estimator reports uncertainty from sampling noise alone, ignoring systematic between-method error. The cooperative estimator includes estimated between-origin variation and receives a Student-t correction.

A more informative comparator is provenance-aware aggregation with uncertainty estimated directly from the dispersion of the ordinary measurements—without the bridge.

I implemented that comparator on the identical simulation data.

| Scenario              | Coverage with provenance-aware aggregation, no bridge | Published cooperative coverage |
| --------------------- | ----------------------------------------------------- | ------------------------------ |
| E1, dependent sources | 95.2%                                                 | 96.0%                          |
| E2, after drift       | 95.9%                                                 | 97.1%                          |

Both use the corresponding small-sample t critical value.

This considerably weakens the claim that cooperative error identification, specifically, is responsible for the reported calibration advantage.

It does not invalidate the value of tracking provenance. Rather, it makes provenance the leading explanation that the research must distinguish from bridge-based correction.

### 3.3 E2: drift detection

The reference measurements do help expose an instrument that changes relative to other instruments.

But the ordinary measurements also contain information about relative drift. I implemented the analogous before-versus-after detector using those measurements, with the same four-standard-error threshold.

Published reference-based detector

# 82.3%

Drift detection

Additional ordinary-data detector

# 90.2%

Drift detection

The corresponding rates of flagging another origin were approximately 0.075% and 0.3%, respectively. Thus the new detector had higher sensitivity but also more false alarms.

This does not show that the reference is useless. It shows that the experiment has not isolated its incremental benefit over comparison of the existing measurements. Both methods are possible because the simulation already gives the agents measurements of the same underlying quantity.

### 3.4 E3: diversity under a budget

The stated formula is correct under the assumed variance model:

\\[ \operatorname{MSE}(k)=\tau^2+\frac{\sigma_b^2}{k}+\frac{\sigma^2}{B-kF}. \\]

Its continuous minimum is

\\[ k^\*=\frac{B}{F+\sigma\sqrt F/\sigma_b}. \\]

The numerical simulation agrees with this model.

But the optimum applies to independent, exchangeable methods with identical costs and error variances, and to the specific objective of minimizing mean squared error. It is not a general optimum for the number of independent models in a collective intelligence.

The localization example has an additional limitation: one method is deliberately shifted by 1.0 while the other methods have noise with standard deviation 0.1. This makes the problem unusually easy.

Three independent methods do not guarantee correct localization in general. They are sufficient for majority-based identification only under additional assumptions about the number of faulty methods and the reliability of the others.

### 3.5 E4: bridge construction

The experiment does test whether an operation already included in both agents' representational structures can satisfy commitment and shared-record criteria.

It does not test how agents invent, select intelligently, translate, or negotiate new operations.

The reduction in bridges with theory-laden records is valid for this particular recording mechanism. But the broader conclusion—that theory-laden perception blocks rather than corrupts bridges—does not follow. Theory-dependent recording could also generate a common but false record when agents share the relevant bias.

Conversely, the systematic shared-fault example is a useful demonstration that reproducibility can coexist with error.

### 3.6 E5: responsiveness

E5 demonstrates that applying the constructed relative correction improves individual accuracy under the simulated bias structure.

It does not establish that agents learn a general correction policy from the evidence. The correction rule is supplied by the researcher.

Furthermore, the halfway-responsive condition selects the first three agents, which all belong to the dependent laboratory cluster. Responsiveness is therefore confounded with source identity. Randomization or balanced selection across origins would make the result more interpretable.

Overall simulation judgment: the code is reproducible and contains useful demonstrations, but the principal comparisons do not isolate the causal contribution of cooperative error identification from provenance-aware aggregation and ordinary cross-method comparison.

## 4. Conclusions: assessment of the four conjectures

| Conjecture                 | Verdict             | Main reason                                                                                                   |
| -------------------------- | ------------------- | ------------------------------------------------------------------------------------------------------------- |
| C1. Minimal cooperation    | SUPPORTED, narrowly | Error exposure follows from shared outcomes and incompatible commitments                                      |
| C2. Bridge construction    | PARTLY SUPPORTED    | The experiment discovers discriminating operations in a pre-existing space; it does not construct that space  |
| C3. Collective improvement | PARTLY SUPPORTED    | Aggregation and provenance help, but the distinctive benefit of bridge-mediated correction is not isolated    |
| C4. Preserved diversity    | PARTLY SUPPORTED    | Independent methods improve fault detection under the simulation assumptions; the general optimum is unproved |

### C1 — Minimal cooperation

The formal result is valid within its assumptions. Two agents can recognize that an outcome is incompatible with at least one model without sharing the rest of their models.

The strongest remaining objection concerns semantic compatibility. Two agents can produce the same outcome symbol while meaning different things by it, or use different symbols for the same event.

The model assumes that the relevant correspondence is already correct.

An additional failure condition is strategic or unrecognized changes to commitments after observations are obtained. Precommitment needs a verifiable history to remain meaningful.

Conclusion: The narrow logical result survives, but it should not be described as error localization or successful correction.

### C2 — Bridge construction

The simulation demonstrates that joint records and prior commitments can expose incompatibilities even when the agents have different prediction functions.

But the difficult problem has been moved into the specification of the common operations and outcomes.

There is a distinction between discovering that an available operation is discriminating and constructing an operation that makes previously incomparable models comparable.

An important untested failure condition is that both agents agree on an outcome symbol but systematically misunderstand the physical procedure that produced it.

Conclusion: Existence and discovery are partially demonstrated. Construction of a new evidential interface remains conjectural.

### C3 — Collective improvement

The evidence supports the value of independent measurements, appropriate weighting and provenance.

It does not show that the proposed correction protocol outperforms a properly specified provenance-aware aggregator with the same information.

The bridge cancellation is decisive for that distinction.

An additional failure condition is when the cost of constructing and maintaining bridges exceeds their marginal epistemic benefit. The simulations exclude this cost.

Conclusion: Collective aggregation improves estimation in the simulated environment. A distinctive improvement from cooperative error identification remains unestablished.

### C4 — Preserved diversity

This conjecture has an important and defensible core: independent channels make some errors observable that would otherwise remain hidden.

However, I disagree with an unconditional separation between diversity of methods and diversity of conclusions.

Different beliefs can lead agents to perform different experiments. If agreement causes everyone to stop investigating a plausible alternative, convergence itself can reduce future error-detection capacity.

The useful distinction is therefore not simply methods versus conclusions. It is between diversity that preserves informative exploration and diversity that merely preserves known errors.

An additional failure condition is that preserving technically different methods creates an illusion of independence when all methods share an unrecognized calibration standard or background assumption.

Conclusion: Preserve effective independence of inquiry, but do not claim that different conclusions are necessarily expendable.

## 5. Prior art

I checked the following sources independently. They substantially constrain claims of originality.

### Interlaboratory comparison and metrology

William Guthrie's 2007 treatment of interlaboratory comparisons describes laboratories measuring common artifacts to investigate systematic differences, random variation and measurement standards.

This is exceptionally close to the simulation's reference-operation mechanism. The research should treat this as an existing operational implementation of part of its proposed bridge mechanism, not merely an analogy.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://www.nist.gov\&sz=32)

NIST



### Social epistemology and evidence

Helen Longino (Science as Social Knowledge, 1990) places the assessment of evidence and objectivity within social processes of criticism. Her account is directly relevant to explaining why collective procedures matter beyond the aggregation of individual beliefs.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://www.jstor.org\&sz=32)

JSTOR



Peter Galison developed the concept of trading zones, in which communities with different languages and practices construct localized ways of collaborating. This is particularly important for C2 because it addresses how practical coordination can precede full theoretical understanding.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://doi.org\&sz=32)

Oxford Academic



Kuhn's treatment of incommensurability provides the strongest conceptual challenge to the assumption that agents can simply agree on what happened while disagreeing only about its interpretation.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://plato.stanford.edu\&sz=32)

plato.stanford.edu



### Diversity and convergence

Kevin Zollman is especially relevant.

His 2007 work shows that, in some simulated scientific communities, limiting communication can increase collective reliability while slowing convergence. His 2010 The Epistemic Benefit of Transient Diversity argues that permanently maintained diversity can also obstruct convergence to truth.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://doi.org\&sz=32)

Cambridge Core

+1



This supports a more dynamic treatment of C4: preserve sufficient independence for exploration, while allowing evidence-responsive convergence.

Hong and Page (2004) establish conditions under which functionally diverse problem-solving groups outperform groups selected for individual ability. Their result concerns specific representations and heuristics, not an unconditional advantage of diversity.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://doi.org\&sz=32)

PNAS



### Consensus and severe testing

DeGroot's Reaching a Consensus (1974) is a natural starting point for formal models of iterative opinion aggregation, but convergence alone should not be equated with empirical correctness.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://www.jstor.org\&sz=32)

jstor.org



Deborah Mayo's work on severe testing emphasizes whether an evidential procedure has genuinely probed a claim for relevant errors. This offers a useful evaluative criterion for bridges: not merely whether agents agree on a result, but whether the procedure had a meaningful opportunity to reveal the errors at issue.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://liberalarts.vt.edu\&sz=32)

liberalarts.vt.edu



Originality assessment: The individual mechanisms are mostly established ideas. The possible contribution of this project lies in an explicit synthesis of incompatible models, local interfaces, provenance, responsive correction and adaptive collective learning. The current simulations do not yet establish that synthesis as a new general result.

## 6. Final assessment

### 6.1 Comparison with my Part 0 answers

The note added several useful elements to my initial assessment.

It formalizes allowed outcome sets and commitment, supplies a clear logical separation between exposure and revision, explicitly models shared faults, and introduces quantitative costs for maintaining independent methods.

It also makes provenance operational by distinguishing agents from the origins of their errors.

My Part 0 answers emphasized elements that the note develops less fully: semantic translation between models, the emergence of genuinely new operations, uncertainty about the reliability of shared procedures, and the distinction between preserving independent methods and maintaining different exploratory hypotheses.

The accounts are compatible in their central direction. The current formalization is narrower than the original conjectures, and the simulation makes some important assumptions that the general philosophical framing seeks to explain.

### 6.2 Release recommendation

YES WITH CHANGES.

I recommend retaining [PR #143](https://github.com/albertjanvanhoek/Evolution-by-Emergence/pull/143?utm_source=chatgpt.com) as an unmerged research proposal while addressing the most important interpretive problems.

I also checked the connected GitHub repository: four workflow groups associated with the PR's head commit report success. This supports the reported CI status, though it does not replace an independent Lean build or methodological review.

### 6.3 Five most important problems, ranked

1

The cooperative point-estimate correction cancels

Location: `simulation/sim.py`, `cooperative`, E1 and E2.

Why it matters: The reported improvement in collective RMSE is caused by provenance weighting, not by the bridge.

Smallest repair: State the algebraic cancellation explicitly. Introduce a provenance-only comparator and separate individual correction, collective estimation, uncertainty calibration and drift detection as distinct outcomes.

2

The consensus comparison confounds aggregation with uncertainty specification

Location: E1 and E2.

Why it matters: A deliberately inadequate standard error is compared with a more sophisticated estimator and a small-sample correction.

Smallest repair: Add matched interval-estimation methods using the same available information, including a provenance-aware consensus estimator without the reference bridge.

3

Bridge construction is not formalized

Location: `Bridge`, E4 and C2.

Why it matters: The model presupposes compatible operation and outcome types. It establishes discrimination, not the emergence of a shared operational interface.

Smallest repair: Rename the demonstrated result bridge discovery among available operations. Retain actual bridge construction as an open conjecture with a separate proposed model.

4

Claims about the optimal diversity of methods are too general

Location: E3 and C4.

Why it matters: The optimization assumes exchangeable independent errors, identical method costs and one particular loss function. Three methods do not guarantee fault localization.

Smallest repair: State the variance assumptions alongside the formula and replace the universal three-method claim with its conditional version.

5

Failure mechanisms are overgeneralized from specific simulations

Location: E4, E5 and C2–C3.

Why it matters: Theory-laden recording does not necessarily protect against false bridges; responsiveness is represented by a supplied correction rule, and the partial-responsiveness condition is confounded with laboratory origin.

Smallest repair: Qualify the claims, randomize responsiveness across origins, and include a theory-dependent shared-record failure mechanism.

### 6.4 The one result I would test against real data

I would prioritize whether an explicit shared-reference procedure improves detection and localization of newly developing method-specific errors, beyond what provenance-aware aggregation can already achieve.

Interlaboratory proficiency-testing data offer a natural starting point. The NIST programme provides a real-world example of laboratories measuring shared items and evaluating their measurement performance.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://www.nist.gov\&sz=32)

NIST



An appropriate study would compare three approaches on identical, preferably blinded, measurement histories: ordinary aggregation with dependence accounted for; provenance-aware aggregation with calibrated uncertainty; and those same methods supplemented by the cooperative reference procedure.

The primary outcome should be prospective error detection and correct localization at a prespecified false-alarm rate. Secondary outcomes should include estimation accuracy, interval coverage, detection delay and operational cost. The analysis should include stable periods, genuine instrument drift, correlated laboratories and faults affecting the shared reference.

This would directly address what the present simulation leaves unresolved: does the bridge add useful information and corrective capacity beyond the collective's existing measurements?

## Final conclusion

The formal work provides a valid illustration of how agents can expose incompatible predictions without agreeing on a complete worldview.

The simulations demonstrate the importance of method independence, provenance and responsiveness, but they do not yet establish that the proposed cooperative correction protocol is responsible for the reported collective improvements.

The most important discovery from this review is the algebraic cancellation of the bridge correction in the collective estimator. It is a concrete error that materially changes the interpretation of C3, and it can be corrected without abandoning the research programme.

I would preserve the central conjecture, but sharpen it:

Collective intelligence may improve when independently maintained models can expose one another's errors through shared operations, preserve the origin of their evidence, and revise their beliefs appropriately. Whether such cooperation improves accuracy or future error detection beyond well-designed aggregation remains an empirical and theoretical question.

That is a more defensible foundation for the next investigation.