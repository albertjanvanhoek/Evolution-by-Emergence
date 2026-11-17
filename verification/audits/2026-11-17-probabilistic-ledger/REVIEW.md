# Independent review: A probabilistic ledger for learning

**Review date:** 17 November 2026  
**Repository:** `albertjanvanhoek/Evolution-by-Emergence`  
**Version actually reviewed:** `claude/probabilistic-ledger` at commit [`b1bd9374c1097815ae0157ac35d4fbcb9dabd724`](https://github.com/albertjanvanhoek/Evolution-by-Emergence/tree/b1bd9374c1097815ae0157ac35d4fbcb9dabd724). The files in the brief were **not** on `main` at its inspected head, `64e488dc2afab9e89964dd66e848986de7a45885`.  
**Scope:** Mathematical and mapping audit of the [working note](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/claude/probabilistic-ledger/research/probabilistic-ledger/README.md), [script](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/claude/probabilistic-ledger/research/probabilistic-ledger/ledger.py), [output](https://github.com/albertjanvanhoek/Evolution-by-Emergence/blob/claude/probabilistic-ledger/research/probabilistic-ledger/results.txt), and the earlier `LearningRatchet.lean`, learning decomposition, creed, 11 November audit, and dialogue entries D12/D21/D47/D50. The note and script are by another assistant; this review was independently written.

## Verdict in three sentences

The numerical results checked independently are correct, and the log-score and information-theoretic identities are standard, but the asserted equivalence of the count ledger to hard-elimination Bayes and several claims that those identities *replace* the old ledger are mathematically or conceptually overstated. The strongest defects are a selection-biased comparison labelled a “false record,” the use of a different scoring target to criticize the count ledger, the identification of a fixed hazard with the whole action “retain, and let go,” and an asserted *exact* mapping to the creed that has counterexamples. The work does not derive resource prices, has no demonstrated novel mathematical result, and should remain a bounded comparison of models rather than a validated probabilistic resource ledger.

### Reproduction and evidence status

I read the complete `ledger.py` through the GitHub connector and compared the source against `results.txt`. I **could not transfer and execute the original 462-line GitHub file as bytes** in the isolated execution environment; instead I ran an *independently written* Python standard-library checker of all five cases, enumerating all `2^16` observation sequences in each filtering scenario and all four states in each information example. I also independently ran the **20,000-trial, fixed-seed (17) Bayesian-update property check**; it reproduced the reported largest numerical gap **7.77 × 10⁻¹⁶**. All numerical values agreed with the published output to its printed precision. **This is independent numerical reproduction, not execution of the original source file**; the exact `All assertions passed` line is from the repository's `results.txt`, not an execution of its 462-line original in this review. The independent checker is supplied alongside this review as a separate reproducibility artifact.

| Check | Repository output | Independent check | Difference at reported precision |
|---|---|---|---|
| Case 1: gain removing B | 0.2877 nats | 0.2876820725 | None |
| Case 2: log-loss excess over turns 0–20 | 3.3646 nats | 3.3646402517 | None |
| Case 4(a): model-first/world-second | −0.0607 / +0.0595 | −0.0606820 / +0.0594922 | None |
| Case 4(a): world-first/model-second | −0.0621 / +0.0610 | −0.0621474 / +0.0609575 | None |
| Case 4(b): static, hazard 0 / 0.1 | 3.861 / 6.608 | 3.860882 / 6.607812 | None |
| Case 4(b): single switch, hazard 0 / 0.1 | 28.122 / 9.101 | 28.122022 / 9.100660 | None |
| Case 5: one-turn gain, true accuracy .8 / .6 / .3 | +.1927 / −.0845 / −.5004 | +.1927448 / −.0845141 / −.5004024 | None |
| Case 5: log-odds drift | +.8318 / +.2773 / −.5545 | +.8317766 / +.2772589 / −.5545177 | None |
| Case 5: expected log-loss at turn 20 | .0039 / .6881 / 11.1831 | .0038777 / .6880830 / 11.1830982 | None |
| Case 3: XOR, redundant, and complementary information | 0, 1 or 2 bits as stated | Direct enumeration of four equally likely `(a,b)` pairs | None |
| Random property check | “20,000; largest gap 7.77e−16” | 20,000 fixed-seed independent trials; max gap 7.77e−16 | None |

No *numerical discrepancy* was found in the checks above. That does not validate the interpretation or the unexecuted original assertions.

## Part 1 — Mathematics and mapping

### 1. Case 1: splitting — **Correct with a precision defect**

For a fixed actual atom `A`, replacing an *incorrect* atom `B` by a refinement whose total mass remains `q(B)` leaves `q(A)` and therefore `−ln q(A)` invariant. The displayed numbers (count misfit `2 → 11`, log-loss `ln 2`, gain `ln(4/3)`) are correct; the uniform-over-listed-atoms trap is real.

The cleaner condition is: **fix the random variable or event being scored (equivalently, a measurable partition), then score the push-forward probability on that fixed outcome space.** An arbitrary refinement of the latent space preserves the score if it preserves the push-forward distribution, including the mass of the observed event. A sufficient statistic is neither necessary nor the relevant concept in general. Locality of the logarithmic score explains why reallocating mass *among other atoms* cannot affect the realized score; strict propriety alone does not confer this property (the Brier score on fine atomic outcomes, for example, depends on the other predicted probabilities). Bernardo [R1] explicitly characterizes the local log utility under regularity assumptions; Gneiting and Raftery [R2] cover proper scoring more broadly.

The note's statement that the count ledger is a *special case* of hard-elimination Bayes with a uniform distribution is **wrong as an accounting equivalence**. Uniform hard elimination yields `−ln q(A)=ln n` for `n` surviving equally weighted hypotheses, whereas `LearningRatchet.misfit` is `n−1` plus possible additional `lost` cost. These are monotone but different cost functions; no single constant exchange rate makes them equal for `n=2,3,4,...`. Moreover, the example's elimination of *ten* refined B-states in one turn is not an instance of `learnOwn`, which removes exactly one `own` error per turn. The split identifies a representational arbitrariness in the cost rule, not a one-turn simulation or formal replacement of that transition system.

### 2. Case 2: retained false record — **Correct with a significant precision defect**

Under ordinary multiplicative Bayes updating, a posterior assigning the actual hypothesis probability zero cannot revive that hypothesis from later observations while the same hypothesis space, likelihood and update rule are retained. Its state log-loss is infinite, but the further claim that *all later learning is blocked* does **not** follow: posterior probabilities among surviving wrong hypotheses can still be updated if a subsequent operation distinguishes them. In the script's hard-elimination example, B and C have identical responses to the *one* available operation; their indistinguishability is a second assumption. `LearningRatchet`'s stronger blanket blocking behavior is explicitly imposed by `learnOwn` when `lost > 0`; it cannot be said to have been proved as a universal consequence of zero posterior mass.

The noisy arithmetic is correct: with accuracy .8 and a balanced binary prior, observing `1` changes `q(A)` from .5 to .2, an opposite `0` cancels the log-odds shift, and the *expected* log-loss difference in the particular comparison decreases from .9163 to .0041 across 20 further draws. However, that observed `1` is **a legitimate noisy outcome under true A, with probability .2**, not an inaccurately observed or dishonestly recorded datum under the stated stochastic instrument. Calling it a “false record” conflates a low-likelihood observation with measurement or transcription error. The discarded-record comparator has retrospective access to the true world and ignores an observation precisely because it is unfavorable to that truth; this is not a matched comparison of two ordinary Bayesian learners with the same epistemic information. Averaging over the initial observation and latent world, keeping an honestly generated observation is the properly Bayesian operation under the stipulated correct model.

A finite prior penalty is **not guaranteed to be repaid** by arbitrary subsequent “honest” observations: recovery requires useful future evidence, positive support, and assumptions on correct specification/identifiability; lack of information, further change, or model misspecification can prevent it. The precise conclusion is that **hard zero support causes a permanent exclusion under standard Bayes conditioning; positive support allows recovery under suitable data**, not that false records are generally finite debts later repaid. Lindley's original discussion [R3] also stresses that changing the knowledge base can change what formerly had probability zero. “Cromwell's rule” is a *caution against* assigning dogmatic zero/one probabilities to contingent possibilities, not a theorem asserting that zero probability is desirable.

### 3. Case 3: two learners — **Correct identity; mapping overstated**

`I(T;X,Y)=I(T;X)+I(T;Y|X)` is the standard chain rule, and the four illustrated distributions produce the claimed values. `I(T;Y|X)=0` characterizes conditional independence, including the script's literally duplicated observation `Y=X`. It is **not equivalent** to having the same operation, point of view, method, or information source: two *independent noisy executions of the same instrument* can provide positive conditional information. Conversely, formally different instruments can be redundant. The `differs` Boolean in `LearningRatchet.linked` encodes a stipulated useful link; it is not an empirical claim that any different view adds one bit.

The XOR synergy example is a genuine illustration that information about a target `T` need not equal information about the complete world `W=(a,b)`. But `LearningRatchet` counts errors about **the full represented world**, not about a separately defined target `T`; observing `a` correctly removes two of the four *world* possibilities. Changing the scored target to `T=a xor b` and then accusing the count ledger of falsely recording progress is not an apples-to-apples refutation. The count model lacks a principled quantitative treatment of target-specific redundancy and synergy; it does not purport to add `I(T;X)+I(T;Y)` or claim an information-theoretic chain rule. Williams and Beer [R4] already analyze these phenomena.

Hence the chain rule is a **possible new alternative ledger conditional on a declared target, joint distribution and scoring objective**, not a replacement theorem proved from `LearningRatchet`.

### 4. Case 4: moving world — **Correct with a precision defect**

**(a) KL split.** Both telescoping decompositions of `KL(p_1||q_1)−KL(p_0||q_0)` are exactly correct, and the opposing attribution signs are correctly calculated. The average of the two orders is a **two-factor Shapley-style attribution convention**, not a unique statistical or physical decomposition or an obligatory default. A causal or temporal question usually gives a defensible ordering (e.g. change the environment, then update the predictor); another analysis might decompose expected predictive loss or regret along an actual stochastic process. The note should not imply that the symmetric split is selected by an invariant theorem. Its `ΔH(p)=+.062147...` correction is sound.

**(b) Hazard filtering.** Exact sequence enumeration confirms `3.861 vs 6.608` in the static path and `28.122 vs 9.101` with a midpoint switch. These are **illustrative comparisons for the specifically selected observation accuracy, horizon, single-switch path, and hazards**. They do not establish that positive hazard always outperforms zero when the world moves, nor that zero hazard is always optimal for static data in finite samples under arbitrary priors and scoring conventions.

Most importantly, the algorithm `forward_filter` never deletes its observations or performs a distinct “let go” action: both learners retain the information needed for filtering in a posterior sufficient state. `h` is an *assumed transition probability in a hidden-state model*, not a model of deliberately reviewing, retracting, erasing, preserving time-stamped records, or deciding when to stop using an inference. Calling the whole creed verb “one parameter” is **not fair**. Adams and MacKay [R5] already show hazard-based Bayesian changepoint inference, albeit with a different state model; stability–plasticity trade-offs are established more generally [R6].

### 5. Case 5: wrong instrument — **Correct with a precision defect**

Independent arithmetic verifies all nine numbers. For `m=.8` and a balanced prior, if the actual frequency of observation `0` under A is `r`, the initial expected log-posterior gain and log-odds drift are respectively

`r ln(.8/.5)+(1−r)ln(.2/.5)` and `(2r−1)ln 4`.

At `r=.6`, those are `−.084514` and `+.277259`; at `r=.3`, `−.500402` and `−.554518`. Conditional on independent identically distributed observations and the stated positive prior and fixed two-model likelihoods, the strong law yields convergence to A when `r>.5` and to B when `r<.5` (the zero-drift boundary needs separate treatment). Those examples correctly separate **one-step expected score gain** from long-term posterior selection.

A substantive ambiguity remains: for `r=.3`, the probability model for B (`P(0|B)=.2`) is closer in KL to the actual observation law than the model for A (`P(0|A)=.8`), so convergence to **B is not convergence to the true world**; it is convergence to the KL-closest *represented sampling distribution*. For `r=.6` the A model is closer even though wrong. This is a known misspecification phenomenon, not a general theorem under arbitrary dependence, prior support, or non-identifiability [R7]. The note correctly acknowledges its known status but should distinguish the true label A from the best approximating probabilistic model.

### 6. General result and the creed — **Correct identity; wrong claim of exact correspondence**

Given `q(w*)>0`, a correctly specified likelihood `p(x|w)`, and positive prior-predictive probability wherever `p(x|w*)>0`, Bayes' rule implies

`ln q(w*|x)−ln q(w*) = ln[p(x|w*)/q(x)]`.

Taking expectation with respect to observations generated under the actual world yields **exactly** `KL(p(·|w*) || q(·)) ≥ 0`. Equality holds iff `p(·|w*)=q(·)` almost everywhere (on the relevant support). This is a standard log-score/Bayesian identity [R1, R2]; the 20,000-trial numerical test is corroboration, not evidence of novelty.

The note says that “Try” has an *exact role*, because a nondiscriminating operation has zero information gain. **The converse is false, even if the operation discriminates among modeled worlds.** Counterexample: three worlds A, B, C, prior `(0.2, 0.4, 0.4)`, actual A, with probability of a positive outcome `(0.5, 0.2, 0.8)`. The operation discriminates B from C, yet the predictive probability is `0.2×.5+0.4×.2+0.4×.8=.5`, exactly the likelihood under A; the actual-world expected gain is zero. If one averages *also over the world's prior*, one obtains `I(W;X)`, whose equality condition for a full-support prior does correspond to **no distributional discrimination between any supported worlds**. The note has instead used the conditional-on-actual-world KL, so these statements must not be conflated.

“Look” and “record honestly” are epistemic and procedural verbs, while the mathematical condition is that the **record's distribution agrees with the actual-world likelihood**; the identity cannot certify whether a human or program was honest, and an honest observation under a wrong instrument need not satisfy the assumed model. “My instrument is right” is a sufficient modeling premise for the KL guarantee, not a separately identified creed theorem. There is no formal mapping from the creed predicates or `LearningVerbs.lean` to these probability assumptions. **Thus the proposed exact mapping to the creed is a reading, not a demonstrated exact correspondence.**

Finally, a positive *expected log score gain* does not by itself prove increased **resource slack**, because `λ`, the cost of experimentation, recurrence, upkeep and the mapping from probability to resources remain unmodelled.

### 7. Section 5: exchange rate λ — **Correct with a precision defect**

The note is right that merely changing the *unit of error* from a count to nats does not determine what error costs in units of reserve. A bookkeeping equation such as `reserve_(t+1)=reserve_t+u−cost_try−λ[−ln q_t(w_t)]` requires `λ` with units reserve per nat **plus a reason to use realized true-world log-loss as a recurrent resource drain**. These are *two* choices: a conversion coefficient and a loss-to-resource functional form, not a single parameter that settles the problem. There is also a separate choice of *what* is scored (latent world, observation, action outcome, or prediction target), and whose loss is charged.

A fixed positive `λ` cannot make `λ ln n` equal `n−1` for all `n`; the suggested fatal criticism that a single constant λ can reproduce **every** count bill is therefore false. If λ is permitted to vary arbitrarily by state or time, it can fit the old bill by definition; that merely moves all arbitrariness into the conversion rule.

There **are principled task-specific choices**: negative log probability is a specified scoring loss; posterior information can change the optimal expected decision utility [R8]; Kelly's particular fair-odds/log-wealth problem gives a precise interpretation of information in attainable growth [R9]; and explicit predictive mistake costs can calibrate reserve units. None supplies a universal λ for all learners. Landauer's `k_B T` scale is a physical conditional statement about specified memory operations, not a universal resource-to-log-loss exchange rate [R10–R13]. The comparison to D12 is fair as a statement that the **benefit to upkeep remains a premise**, but saying that D12 left open *precisely the scalar λ* is stronger than the actual record.

### 8. Precision audit — **Correct with multiple overstatements**

The following sentence-level issues materially change what is supported:

1. **“The count ledger is the special case of hard elimination with a uniform belief.”** False as an equality of costs or transitions (`n−1` versus `ln n`; count also carries `own`, `blind` and `lost`).
2. **“A false record ... with noise ... a finite debt.”** In case 2(c) the observation is correctly generated with probability .2, not a false measurement or false record; the discard comparator is retrospectively privileged.
3. **“Later honest observations repay”** is shown only in one identifiable, stationary binary model, and as an expectation under its selected observation sequence setup.
4. **“Hard elimination blocks later learning.”** It blocks re-entry of a zero-prior truth under ordinary Bayes updating; it does not block all posterior updates among wrong surviving hypotheses.
5. **“The two terms become the chain rule.”** No theorem connects `own`/`blind` counters to random variables or conditionally independent observations; the target `T` is introduced from outside the old ledger.
6. **“Same view” = zero conditional mutual information.** Valid only with an information-theoretically redundant view; identical instruments with fresh independent data can add information.
7. **“Synergy ... count ledger books a gain where nothing about T was learned.”** It *did* eliminate full-world candidates; the criticism switches the scoring target.
8. **“Retain, and let go become one parameter.”** The code specifies a hazard in the transition model but has no action of dropping, revising, recording as historical, or selectively retaining evidence.
9. **“Three creed items appear ... with an exact role.”** No proven correspondence; the example in item 6 is a counterexample to identifying conditional zero gain with nondiscrimination.
10. **“With noise [learning_turn_raises_slack] holds in expectation.”** Expected posterior log-score change holds; expected reserve improvement requires the additional operational coupling and experimental costs. The proof in `LearningRatchet` is not thereby transferred.
11. **“Every number below comes from ledger.py; the checks are exact enumerations, except ... property.”** The computations shown are deterministic and the 16-turn enumeration is exact *for the finite model* but performed in floating-point arithmetic. “Exact enumeration” should not be read as exact real-number arithmetic.
12. **“Signs in cases 4 and 5 are robust.”** The specific algebra in case 5 has thresholds, but hazard comparison in case 4 depends on the path, assumed hazards, observation accuracy, and scoring timing; no parameter-robust result is shown.

## Part 2 — Closest prior work, what differs, and stopping points

The following are **primary papers, author's manuscripts, author's own book text, or publisher/author records** accessed for this review. When only an abstract/description or bibliographic record was accessible, that limitation is stated. The references are full enough to locate each source; no claim of exhaustive priority review is made.

### 1. Expected Bayesian log-score gain and value of information

**Closest prior:** Bernardo [R1] derives expected information as an expected-utility criterion and characterizes the local logarithmic proper utility under assumptions. Gneiting and Raftery [R2] develop general proper scoring rules. Howard [R8] expressly treats the value of information by jointly considering probabilities and economic consequences. In the separate log-growth setting, Kelly [R9] supplies a specific mapping from information to expected capital growth.

**What the note adds:** *Nothing mathematically.* It writes the conditional-on-a-fixed-actual-world Bayesian log-posterior identity next to a finite-resource ledger, but does not demonstrate a new expected-value-of-sample-information or growth result. Importantly, **information gain is not the same as expected decision value** without specifying actions, losses, and available decisions. Verified at the level of Bernardo's actual manuscript and the other authors'/publishers' records and abstracts; the full Howard and Kelly analyses were not reproduced.

### 2. Chain rule; redundancy, synergy, unique information

**Closest prior:** Shannon [R14] is the foundational source for entropy/conditional information; Williams and Beer [R4] directly study the multivariate decomposition and explicitly separate redundancy and synergy, including the idea of information available only jointly.

**What the note adds:** Nothing to information theory. Using `T` for an EbE target makes the comparison concrete but does not establish an exact relation to the counters of `LearningRatchet`. Williams and Beer's own preprint was inspected; a general uniqueness claim for partial information decomposition is **not** made, since the chosen redundancy definition matters.

### 3. Bayesian hazard filtering, change points, stability–plasticity

**Closest prior:** Adams and MacKay [R5] perform Bayesian online changepoint detection with a model of segment transitions and a prior on run lengths. Carpenter and Grossberg [R6] discuss the stability–plasticity problem in adaptive category learning, but in a different architecture.

**What the note adds:** A two-state, sixteen-step illustration of the standard stability-versus-adaptation trade-off; no new filtering method and no formal action model for deliberate forgetting. Adams/MacKay's original author manuscript was inspected; the Carpenter/Grossberg author record and abstract were checked, not the entirety of their derivations.

### 4. Bayesian misspecification and KL-closest model

**Closest prior:** Kleijn and van der Vaart [R7] explicitly study posterior behavior when the true data-generating distribution is outside the statistical model and characterize concentration near KL minimizers under assumptions.

**What the note adds:** Nothing to asymptotic theory; it gives an elementary two-likelihood example and usefully distinguishes initial expected posterior-score change from eventual likelihood-ratio drift. Institutional author record/abstract and bibliographic details verified; no claim that the full paper's conditions were checked here.

### 5. Cromwell's rule and zero-probability conditioning

**Closest prior:** Lindley [R3], §6.8 of *Understanding Uncertainty*, states the practical injunction against exact zero/one probabilities for contingent claims and notes the consequence of changing the knowledge base. The multiplicative-zero fact itself is immediate from Bayes' rule with positive evidence probability.

**What the note adds:** Nothing about Bayesian zero support. It mislabels hard elimination as something that *follows from* Cromwell's rule; that rule cautions against assigning dogmatic zeros to nonlogical possibilities. Lindley's own published text was inspected, including the caveat that a changed knowledge base can permit revision.

### 6. Proper scoring rules and choice of partition

**Closest prior:** Bernardo [R1] treats local scoring; Gneiting and Raftery [R2] discuss proper scores and different scoring targets. A logarithmic score is local **relative to its chosen outcome**, not invariant under an arbitrary change in the outcome itself.

**What the note adds:** A worked refinement example applicable to this repository. The fixed scored variable/push-forward distribution gives the cleaner invariance statement. The same issue is already governed by familiar scoring-rule and measure-theoretic distinctions.

### 7. Physical leads and λ

- **Landauer [R10].** Primary article/publisher record supports logically irreversible computing and thermodynamic consequences in a specified physical setting. It does **not** fix the economic/biological `λ` for predictive model error; a bit erased is not the same quantity as one nat of wrong latent-world log-loss.
- **Bennett [R11].** Primary journal record and abstract support the role of logically reversible computation and the separation of computation from necessary dissipative operations. Does **not** provide a universal `λ`.
- **Still, Sivak, Bell and Crooks [R12].** APS's own abstract states a relation between nonpredictive retained information and dissipation in stochastic driven systems. This is the most pertinent *mechanism lead*; it does **not** say that the ledger's `−ln q(w*)` is physical dissipation or specify a universal conversion to reserve units.
- **Shiraishi, Funo and Saito [R13].** APS's own abstract states a speed/entropy-production/dynamical-activity inequality for classical Markov processes. It constrains the kinetics of an explicitly defined physical process, not the `λ` in this abstract learning ledger.
- **Welling, Lu and Holdijk [R15].** Cambridge University Press's 2026 description confirms the scope: a unifying treatment connecting variational-free-energy methods of generative AI with stochastic thermodynamics. The **book's derivations were not read**. It is verified only as a relevant lead, not as a source for an EbE cost conversion.

**Overall for the physical layer:** **none** of the accessed primary statements yields a universal `λ` converting true-world log-loss to ongoing resource depletion. One might derive an *operation-specific* coefficient in a fully specified device or decision system; without such a system it remains a modeling choice.

## Five disconfirmation questions from the brief

| Potential disconfirmation | Answer | Reason |
|---|---|---|
| One of the five findings is wrong, or follows from chosen numbers rather than structure | **Yes** | The arithmetic is correct but the hazard-ranking is example-specific; the noisy “false record” is a legitimate stochastic outcome; the target switch in synergy makes the criticism non-comparable. |
| Correctly read, the count ledger already has a property said to be absent | **Yes, in part** | `same_view_is_solo` already has no extra decrement for the same Boolean view; it does not, however, quantify statistical redundancy or synergy. The count ledger also did not claim to measure information about an arbitrary target `T`. |
| Switching to log-loss removes nothing because λ can reproduce every count bill | **No for fixed λ; yes if unconstrained state-dependent λ is allowed** | A constant cannot convert `ln n` to `n−1` for all `n`. If one is free to fit a different conversion to every state, the ledger remains arbitrary by construction. |
| Mapping to creed verbs is decoration rather than exact correspondence | **Yes as an exact correspondence** | The predicates/actions in the creed are not represented by a formally defined mapping, and the conditional KL zero-gain criterion has an explicit discriminating-operation counterexample. The links remain suggestive interpretation. |
| Known work has already done the mathematics | **Yes** | The identities, filtering model, proper scoring principles, misspecification behavior, and synergy examples have established antecedents; no mathematical sharpening is demonstrated. The specific juxtaposition with EbE is repository-specific, not a new theorem. |

## What could not be checked, and why

1. **Original script execution.** The original GitHub source could be read by the app connection but could not be materialized as an executable file in the isolated Python environment. An independently written implementation reproduced the reported values for all five cases and the full 20,000-trial seed-17 property check, including its 7.77 × 10⁻¹⁶ maximum gap; the original file's actual assertions and final `All assertions passed` line were not executed from its bytes.
2. **The reviewed note on `main`.** `main` was at a commit from 11 November lacking the `research/probabilistic-ledger` directory and D50. The review therefore used the exact 17 November branch head stated above. If the branch is subsequently amended or merged, this review will not automatically cover the new version.
3. **Formal proof or Lean port.** There is no Lean formalization of the proposed probabilistic ledger to check; `LearningRatchet.lean` was read for its declared definitions and assumptions, not recompiled in this review.
4. **A comprehensive priority review.** A bounded check of the primary publications named above cannot establish that no one has published the exact EbE-style juxtaposition. The literature cited is enough to establish the standard status of the substantive mathematics.
5. **Full physical derivations and conventions.** For Landauer, Bennett, Still et al., and Shiraishi et al., this review used primary author/publisher texts and journal abstracts/records where accessible, not a full independent derivation or adjudication of differing speed-limit conventions. The Welling book was checked at publisher-description level only. No claimed energy conversion was verified.
6. **External empirical validity.** No actual learning system, real resource budget or calibrated cost of misprediction was studied. The sign and scale of real resource effects are therefore unknown.

## Primary-source references

**[R1]** Bernardo, José M. (1979). “Expected Information as Expected Utility.” *The Annals of Statistics* **7**(3), 686–690. DOI: [10.1214/aos/1176344689](https://doi.org/10.1214/aos/1176344689). [Author-hosted original](https://www.uv.es/~bernardo/1979AS.pdf).

**[R2]** Gneiting, Tilmann, and Adrian E. Raftery (2007). “Strictly Proper Scoring Rules, Prediction, and Estimation.” *Journal of the American Statistical Association* **102**(477), 359–378. DOI: [10.1198/016214506000001437](https://doi.org/10.1198/016214506000001437). [Author-hosted manuscript](https://sites.stat.washington.edu/raftery/Research/PDF/Gneiting2007jasa.pdf).

**[R3]** Lindley, Dennis V. (2006). *Understanding Uncertainty*. Hoboken, NJ: John Wiley & Sons, §6.8, “Cromwell's Rule.” DOI: [10.1002/0470055480](https://doi.org/10.1002/0470055480). [Author's published text (digitized copy)](https://www.nu.edu.ye/wp-content/uploads/2014/05/Lindley-D.V.-Understanding-uncertainty-2006.pdf).

**[R4]** Williams, Paul L., and Randall D. Beer (2010). “Nonnegative Decomposition of Multivariate Information.” *arXiv preprint* **arXiv:1004.2515** (cs.IT). [Author preprint](https://arxiv.org/abs/1004.2515). This is a 2010 preprint reference, **not** a claimed journal publication.

**[R5]** Adams, Ryan Prescott, and David J. C. MacKay (2007). “Bayesian Online Changepoint Detection.” *arXiv preprint* **arXiv:0710.3742** (stat.ML). [Author-hosted manuscript](https://www.cs.princeton.edu/~rpa/pubs/adams2007changepoint.pdf).

**[R6]** Carpenter, Gail A., and Stephen Grossberg (1987). “ART 2: Self-organization of Stable Category Recognition Codes for Analog Input Patterns.” *Applied Optics* **26**(23), 4919–4930. [Author-hosted article](https://sites.bu.edu/steveg/files/2016/06/CarGro1987AppliedOptics.pdf). Verified as a prior stability–plasticity lead; this review did not audit the full paper.

**[R7]** Kleijn, B. J. K., and A. W. van der Vaart (2006). “Misspecification in Infinite-Dimensional Bayesian Statistics.” *The Annals of Statistics* **34**(2), 837–877. DOI: [10.1214/009053606000000029](https://doi.org/10.1214/009053606000000029). [Institutional author record](https://research.vu.nl/en/publications/misspecification-in-infinite-dimensional-bayesian-statistics/).

**[R8]** Howard, Ronald A. (1966). “Information Value Theory.” *IEEE Transactions on Systems Science and Cybernetics* **2**(1), 22–26. DOI: [10.1109/TSSC.1966.300074](https://doi.org/10.1109/TSSC.1966.300074). [Publisher record](https://ieeexplore.ieee.org/document/4082064/). Only the publisher abstract/record was used for the value-of-information claim.

**[R9]** Kelly, John L., Jr. (1956). “A New Interpretation of Information Rate.” *The Bell System Technical Journal* **35**(4), 917–926. DOI: [10.1002/j.1538-7305.1956.tb03809.x](https://doi.org/10.1002/j.1538-7305.1956.tb03809.x). [Nokia Bell Labs author/publisher record](https://www.nokia.com/bell-labs/publications-and-media/publications/a-new-interpretation-of-information-rate/).

**[R10]** Landauer, Rolf (1961). “Irreversibility and Heat Generation in the Computing Process.” *IBM Journal of Research and Development* **5**(3), 183–191. DOI: [10.1147/rd.53.0183](https://doi.org/10.1147/rd.53.0183). [Publisher record](https://ieeexplore.ieee.org/abstract/document/5392446/authors).

**[R11]** Bennett, Charles H. (1982). “The Thermodynamics of Computation—a Review.” *International Journal of Theoretical Physics* **21**, 905–940. DOI: [10.1007/BF02084158](https://doi.org/10.1007/BF02084158). [Publisher record](https://link.springer.com/article/10.1007/BF02084158).

**[R12]** Still, Susanne, David A. Sivak, Anthony J. Bell, and Gavin E. Crooks (2012). “Thermodynamics of Prediction.” *Physical Review Letters* **109**, 120604. DOI: [10.1103/PhysRevLett.109.120604](https://doi.org/10.1103/PhysRevLett.109.120604). [Publisher abstract](https://journals.aps.org/prl/abstract/10.1103/PhysRevLett.109.120604).

**[R13]** Shiraishi, Naoto, Ken Funo, and Keiji Saito (2018). “Speed Limit for Classical Stochastic Processes.” *Physical Review Letters* **121**, 070601. DOI: [10.1103/PhysRevLett.121.070601](https://doi.org/10.1103/PhysRevLett.121.070601). [Publisher abstract](https://journals.aps.org/prl/abstract/10.1103/PhysRevLett.121.070601).

**[R14]** Shannon, Claude E. (1948). “A Mathematical Theory of Communication.” *The Bell System Technical Journal* **27**(3), 379–423; **27**(4), 623–656. [Original article reproduction](https://people.math.harvard.edu/~ctm/home/text/others/shannon/entropy/entropy.pdf). Used for the foundational conditional-information framework, not to attribute the repository's exact notation to Shannon.

**[R15]** Welling, Max, Sirui Lu, and Lars Holdijk (2026). *Generative AI and Stochastic Thermodynamics: A Tale of Free Energies*. Cambridge: Cambridge University Press. [Publisher's book record and description](https://www.cambridge.org/core/books/generative-ai-and-stochastic-thermodynamics/A462AB4186719C2D4EBCC1F58A5D5764). Full book **not read**.

---

**Final assessment:** The branch offers a numerically checked illustration of the consequences of choosing log-loss instead of a count. The genuine gain is not a derived resource law but an explicit display of the assumptions the earlier count ledger hid; the note currently claims more than its code supports when it equates probabilistic states with economic costs, Bayesian noise with false reporting, and information-theoretic conditions with moral or procedural verbs.
