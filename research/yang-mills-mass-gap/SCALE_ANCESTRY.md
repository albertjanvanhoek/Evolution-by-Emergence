# Scale ancestry: search for a precursor, not a pre-existing gap

*Research suggestion for PR #144, 7 November 2026. Motivated by the Evolution by Emergence (EbE) question of how lower-level interactions support higher-level functions. This is a proposed **method and conditional proof obligation**, not a new result in Yang–Mills theory or a claim that EbE proves a mass gap.*

## 1. Resolve the apparent chicken-and-egg problem correctly

A chicken came from an egg laid by an animal that was not yet a modern chicken. The explanatory move is to search for **an earlier, weaker precursor of the relevant function**, not to presuppose the final object at the beginning.

For a mass-gap program, the analogous question is:

> Which property of the underlying measure, or of its exactly induced coarse-grained measure, is weaker than a continuum spectral gap, arises from the original interactions, and is sufficient (together with explicit additional hypotheses) to establish the target?

This is a guide to proof design, not evidence that the needed property holds.

A **scale ancestor** is not a historical ancestor. Exact blocking is a change of description of a fixed equilibrium ensemble; it does not mean that the ensemble physically evolved through the blocking operations. In EbE, retained physical organization changes future possibilities through *time*. Here, an exact coarse-graining map changes the *description* across scales. Any purported bridge between the two must distinguish them.

Equally, a quantum mass gap is not an exploitable thermodynamic gradient. Dimensional transmutation is a physical origin for a characteristic scale, but does not itself prove a nonzero spectral gap. No novel energy source is implied.

## 2. Put the proposed precursor in a noncircular dependency graph

For each UV lattice spacing `a` and finite volume `L`, begin with a specified measure `μ_{a,L}`. Define a blocking map `B_b` and the **actual** pushforward `ν_{a,L,b} = (B_b)_# μ_{a,L}`. In particular, do not assume that `ν` is a nearest-neighbor Wilson measure.

A candidate proof route is:

1. **Microscopic starting point (given).** Specify the model, regularization, coupling trajectory, observables, and blocking map independently of the existence of a gap.
2. **Precursor certificate (to prove).** For the actual blocked specification, establish a suitable volume- and boundary-uniform mixing or influence bound at some `b=b(a)`; this is not a spectral-gap statement.
3. **Transfer (conditional mathematics partly in this PR).** Split fine covariance into blocked covariance and residual conditional covariance. Derive decay for the fine observables from separately controlled terms. See `YMGap/TotalCovariance.lean` and `YMGap/CovarianceTransfer.lean`.
4. **Physical-scale control (conditional mathematics partly in this PR).** With `a b(a) ≤ ℓ_*`, a uniform positive coarse decay rate, and a uniform *physical* decay rate for the residual, retain nonzero correlation decay in physical units. See `YMGap/PhysicalScale.lean`.
5. **Target (open).** Establish cutoff/volume-uniform constants, the necessary gauge-invariant observable family, continuum reconstruction and a positive spectral gap of the full physical Hamiltonian. Correlation decay of one plaquette observable is insufficient.

Each arrow requires independent proof or an explicitly identified assumption. The route is circular if the input certificate or continuum trajectory is defined by assuming the desired final gap.

This is directly analogous to asking of an EbE transition: *what is retained, what new functionality becomes accessible, and which precise mechanism makes it accessible?* The analogy supplies a disciplined question, not a transfer of a theorem between unrelated systems.

## 3. A checkable intermediate lemma: local upper bounds plus a certified tail

The existing numerical pilot estimates **lower bounds** on mean-response influence for selected boundary configurations. Those estimates are informative but cannot certify Dobrushin contraction, even if their signed sum is below 1.

A different, genuinely sufficient certificate can be sought in the 2D O(3) testbed.

Let `γ_i^ν(· | η)` be the exact one-site conditional law of the blocked measure. Define

```text
c_ij = sup_{η,η' differing only at j}
          TV(γ_i^ν(·|η), γ_i^ν(·|η'))
D    = sup_i sum_{j != i} c_ij .
```

The desired *sufficient* Dobrushin criterion is `D < 1`. For nearest-site decimation, the induced interaction can be long-range, so **every** coarse site matters.

Here is a finite-neighborhood-plus-tail proof obligation that may be easier to audit than trying to estimate `D` directly:

- Choose a coarse-lattice Chebyshev radius `R`.
- Prove a **uniform upper bound**, not a simulated average, on the local sum:
  `sup_i sum_{0 < d_∞(i,j) ≤ R} c_ij ≤ Q_R`.
- Prove for every remaining site and every admissible conditioning that
  `c_ij ≤ A q^{d_∞(i,j)}`, with `A ≥ 0` and `0 < q < 1`, uniformly in volume and the relevant coupling/scale range.

In the 2D square lattice there are at most `8n` sites in a Chebyshev shell of radius `n`. Therefore,

```text
D ≤ Q_R + T_R

T_R = 8 A sum_{n=R+1}^∞ n q^n
    = 8 A q^(R+1) ((R+1) - R q) / (1-q)^2 .
```

Thus the **elementary conditional lemma** is:

```text
If Q_R + 8 A q^(R+1) ((R+1) - R q) / (1-q)^2 < 1,
then D < 1.
```

For a periodic finite lattice, the shell count is bounded by the corresponding infinite-lattice count; one must still ensure the conditioning/specification and all constants are defined uniformly. For a higher-dimensional lattice, replace `8n` with the correct shell-growth count.

**This inequality is bookkeeping, not the breakthrough.** Establishing `Q_R, A, q` as rigorous upper bounds for the *actual blocked measure* in the desired regime is the hard physics. Standard upper bounds of this kind could fail because of exceptional conditioned configurations or non-Gibbsian behavior. The companion [`NOTE_O3_INFLUENCE.md`](NOTE_O3_INFLUENCE.md) explains that concern.

The inequalities above make the question operational: can one bound near-field influence and long-range tails in a way a reader can check, with constants that do not deteriorate as the volume grows?

## 4. What would count as progress or correction?

**Positive path:** Derive a true blocked Gibbs specification at a fixed test coupling and block factor; obtain certified upper bounds on local influences and the tail; demonstrate `Q_R+T_R<1` with explicit numerical/rational constants, not Monte Carlo estimates. Then study whether the certificate survives the continuum trajectory `a→0` with `a b(a)≤ℓ_*`, controlled residual terms and uniform prefactors. A certificate at one fixed `β` is *not* yet a continuum argument.

**Negative path:** Construct an explicit adversarial retained-spin configuration that makes a row sum at least 1, or demonstrate that an assumed tail bound fails. That disproves this specific sufficient criterion for the chosen blocking scheme and regime. It does **not** disprove a mass gap. This is a useful, local correction, not a failure of the broader physics.

**Uninformative path:** More values of the *signed mean-response lower-bound proxy* below 1, however numerous, do not establish the worst-case upper bound. A new simulation should target a specified uncertainty about candidate bad configurations or mixing, not be interpreted as a certificate.

An alternative if uniform Dobrushin fails is to seek a weaker observable-specific or polymer/cluster-expansion mixing criterion. That would require a **new** conditional transfer argument; one cannot simply reuse a Dobrushin conclusion.

## 5. Where this does and does not connect back to EbE

EbE's resource-constrained accessibility asks when previously retained organization causally enables a new function while its upkeep remains affordable. It distinguishes *newly generated possibilities* from *retained, causally attributable possibilities*. See `CORE.md` and `papers/when-does-change-become-cumulative/`.

The transferable methodological discipline is:

1. Identify the proposed emergent property in operational terms.
2. Search in the lower-level system for a weaker precursor, rather than assuming the mature property.
3. Specify the exact bridge that would turn the precursor into the higher-level property.
4. Test every bridge for counterexamples and quantify the boundary conditions.
5. Keep the original physical law and the stronger emergent claim distinct.

For PR #144 the concrete precursor candidate is *uniformly controlled mixing of the actual blocked specification*. For prebiotic EbE it could instead be a maintained chemical constraint or gradient-coupling mechanism. **There is currently no theorem identifying these as one and the same physical phenomenon.**

## Suggested immediate deliverable

Extend the existing worst-case influence note by trying to **prove or refute one finite-radius-plus-tail certificate** in the decimated 2D O(3) surrogate:

- exact definition of the blocked conditional law and its conditioning class;
- one `R`, explicit certified near-field upper bounds `Q_R`;
- one volume-uniform tail `(A,q)` or a counterexample explaining why such a bound fails;
- `Q_R + T_R` compared to 1, with all quantifiers and uncertainties visible.

Only after that is successful should a transfer-to-physical-units theorem be attached to the result, and only after independently proving an adequate continuum/gauge-observable bridge should it be called a Yang–Mills mass-gap route.

*Status: a falsifiable research protocol with an elementary sufficient bound, not a proof of the needed upper bounds. No changes to the EbE core or to existing Lean results are proposed.*
