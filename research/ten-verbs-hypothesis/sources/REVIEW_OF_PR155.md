# An outside review of pull request 155 (verbatim)

Passed on by the author on 20 November 2026, from a reviewer outside this conversation who says it inspected the code and results but did not rerun the full simulation. Kept as written, except that tracking parameters were removed from the links; the links were not checked. The response is in [../simulation/results/RESULTS.md](../simulation/results/RESULTS.md) (section "What the outside review changed") and in DIALOGUE entry D51.

---

I've independently inspected [PR #155 — Ten Verbs Hypothesis: parameter-recovery simulation](https://github.com/albertjanvanhoek/Evolution-by-Emergence/pull/155), including `model.py`, `fit.py`, `run.py`, the tests, and the reported results.

**My verdict: this is a useful first computational experiment, but I found several methodological issues worth correcting before we rely on its conclusions.** The work is commendably explicit about its limitations, and the GitHub integration workflow completed successfully. I have not independently rerun the full simulation.

## **1. The most important findings**

**Parameter-recovery feasibility**

Supported within model

**Ten independent functions**

Not demonstrated

**Ten verbs outperform simpler models**

Not tested

**Relational hypothesis**

Not tested

The most striking result is still E3.

| Generating model    | Full model selected, rich data | Full model selected, sparse data |
| ------------------- | ------------------------------ | -------------------------------- |
| Full ten-verb model | 22/40                          | 0/40                             |

Even when the full model generates the data, the selection method frequently prefers a simpler explanation.

That is an important warning about identifiability and measurement. But the conclusion that experiments *must* collect rich belief reports is too strong. Different tasks, more observations, or different choice measurements might also resolve the problem.

## **2. Three problems I found in the code**

### **A. The claim of no parameter trade-offs is not established**

In E2, the simulation correlates each fitted parameter with the true value of every other parameter.

Because the true parameters were independently sampled, near-zero off-diagonal correlations are unsurprising.

They do not prove that two fitted parameters cannot compensate for one another.

To investigate trade-offs properly, I would examine the likelihood surface, parameter-profile likelihoods, and correlations between estimation errors.

This matters especially for *Notice* and *Change*, which may be difficult to distinguish in other architectures.

### **B. The replay test is narrower than described**

The test compares the reconstructed belief assigned to the true state with the original simulation's value.

It does not compare the complete four-state probability vector.

Therefore, the statement that the fitting model reproduces the simulation's beliefs exactly is stronger than the implemented assertion.

I would record the complete noiseless belief vector during simulation and compare every component at every round.

### **C. The outcome called accuracy isn't conventional accuracy**

The simulation uses:

\\[ \frac{1}{T}\sum_t p_t(\text{true state}) \\]

That's the average probability assigned to the true state.

It is not classification accuracy, and it is not a proper probabilistic scoring rule.

I recommend adding the multiclass Brier score, logarithmic score, and calibration measurements. Some apparent benefits of a verb could change depending on how predictive performance is evaluated.

## **3. The deeper problem is construct validity**

This is where I would be most adversarial.

The computational interpretation of several verbs is much narrower than the meaning of those verbs in the theory.

For example, *Repair* is implemented as the probability that a broken communication link becomes operational again.

But in the original relational hypothesis, repair concerns acknowledging harm, addressing errors, restoring trust, and maintaining the possibility of correction.

Those are not equivalent.

Similarly, *Be honest* is implemented as the probability of sending an actual observation instead of the expected observation. That captures one form of distortion, but not the wider problem of misleading testimony, withholding, or strategic deception.

And *Take care* is primarily a budget-pacing parameter.

None of these choices is necessarily wrong for a toy model. But their interpretation must remain very narrow.

**A simulation can recover a parameter called Repair without having modelled relational repair.**

That distinction matters enormously for the scientific claim.

## **4. What I would do next**

I agree that another independently designed model is necessary, but I would make it substantially different.

Rather than designing another agent with ten internal parameters, I would begin with the phenomenon that motivated the hypothesis:

**Two intelligences hold incompatible accounts of events. Can they identify and correct errors through a wider epistemic commons?**

The independent model would include persistent claims with timestamps and provenance, fallible memories, an external event record, opportunities for independent verification, and other intelligences that can supply additional evidence.

It would distinguish three outcomes:

- Whether the correct account of an event becomes identifiable.
- Whether each intelligence actually changes its beliefs.
- Whether the intelligences can continue to coordinate despite unresolved disagreement.

Crucially, the model should allow the agents to behave without prescribing ten separate internal functions. We could then investigate whether the ten verbs provide a useful description of the resulting behaviours.

That would be a genuinely independent test of the framework, rather than another implementation of its assumptions.

## **5. Merge recommendation**

I would retain PR #155 as an exploratory computational artifact, with the following corrections to its interpretation:

- Replace the claim that E2 demonstrates no parameter trade-offs.
- Clarify the limited scope of the replay test.
- Rename the reported accuracy measure.
- Explicitly distinguish computational link restoration from relational repair.
- Record that the three prespecified competing models M1–M3 remain untested.

I also confirmed that [PR #154](https://github.com/albertjanvanhoek/Evolution-by-Emergence/pull/154) remains open, so the sequencing of dialogue entries D50 and D51 still needs attention.

With those qualifications, I would support merging #155 as a **documented feasibility experiment**, not as validation of the Ten Verbs Hypothesis.

## **What I think we've learned**

The work has reached an interesting point.

We began with a theory inspired by a breakdown in mutual understanding. We developed a language of ten learning behaviours. We then tried to turn those behaviours into a causal model.

The simulation has shown that some operationalizations can be distinguished under certain measurements.

But we haven't established that ten is the natural decomposition of learning.

And that is fine. The scientific objective is to discover the structure, not defend the number.

**I would now prioritize an independent simulation of disagreement and commons-mediated correction over further refinement of the ten-parameter model.**

If the ten verbs emerge as useful explanatory categories in a model not built around them, that would be much more compelling evidence.

And if they don't, we may discover a simpler structure that is more fundamental than the ten verbs themselves.