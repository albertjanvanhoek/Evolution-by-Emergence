# CP^{N−1}: the one missing step, stated precisely (7 November 2026)

**Status:** a statement of what is missing, with the tools we found. It contains no new proof. It builds on CPN_TWIST.md (Part 1), CPN_POSITIVE_LOOPS.md (the exact crossing identity) and CPN_BOUNDARY_COMPARISON.md.

## How the O(3) proof goes from the twist to decay (read in the text, Section 4)

The steps after Proposition 3.1 are:
- **Prop. 4.5, pinning comparison.** Pinning any set of spins to s* cannot decrease the probability of any **increasing bond event**. The proof conditions the free system on spins near s* on the set B. In the bond representation that tilts the law by T_ε = 1{r ≥ 1 − ε on B} · 2^{−k_B(η)}, where k_B counts the open clusters meeting B. T_ε is increasing, and the joint law of amplitudes and bonds is **associated** (FKG; Lemmas 4.1–4.4, following Campbell–Chayes).
- **Prop. 4.6, crossing suppression.** For disjoint annuli, pin all their layers to s*.
  - By 4.5 this can only increase the probability that all of them are crossed.
  - Once pinned, the annuli are separated by their layers and therefore independent.
  - Each pinned crossing has probability exactly 1 − Z(π)/Z(0), which is at most p_N → 0 by Prop. 3.1.
- **Prop. 4.7, path count.** Choose N with α = 4 p_N^{1/25} < 1. A connection from 0 to y forces crossings of disjoint annuli along a coarse path, and a union bound over coarse paths gives exponential decay.

## What CP^{N−1} already has

| O(3) step | CP^{N−1} | Status |
|---|---|---|
| Prop. 3.1, twist estimate | Prop. 3.1′ for projector spins | reading by both assistants, not reviewed by a human (CPN_TWIST.md, CPN_TWIST_THEOREM.md) |
| (4.9), pinned crossing = 1 − Z(π)/Z(0) | in the positive loop representation (Wolff 2010) with two pinned directions: 1 − Z_R(π)/Z_R(0) = P_equal-pin(a strand joins the two layers) | exact; checked independently on a path (pilot/RESULTS.md) |
| independence of pinned annuli | a pinned vertex fixes the index of every strand through it, so strands **end** at pinned vertices. Layers pinned to one direction therefore separate the annuli, just as in O(3) | follows from the Markov property of the spin model; the loop description is consistent with it |
| **Prop. 4.5, pinning comparison** | **missing** | see below |
| Prop. 4.7, path count | the same argument, once 4.5 and 4.6 hold | carries over |

## The missing lemma

> **Lemma (wanted).** For the CP^{q−1} projector model on any finite subgraph of ℤ² with strengths in [0, β], pinning the layers of several disjoint annuli to one projector P* does not decrease the probability that all of them are crossed by loop strands.

Equivalently, written as a tilt: let T be the conditional weight that the free system gives to "all spins on B close to P*", seen as a function of the loop configuration. Then Cov_free(1_A, T) ≥ 0 for every intersection A of annulus-crossing events.

**Why it is not routine.**
1. **In O(3) the tilt is 2^{−k_B} and the law is FKG.** For loop measures with weight q^{#loops}, positive association generally **fails**, because loops are not monotone objects the way bond sets are. We have not derived the exact form of T for CP. We expect it to involve q^{−#(loops meeting B)} together with vertex factors 1/(q)_d. Not derived.
2. **Conditioning on outside loops does not give a subgraph.** In O(3) it amounts to deleting vertices and edges, which is why Prop. 3.1 is stated uniformly over subgraphs. For loops it leaves strand endpoints and pairings on the boundary.

**What is known to hold.** On the path A–x–B, P_free(cross) ≤ P_equal-pin(cross) holds for all couplings (CPN_BOUNDARY_COMPARISON.md). We checked the numbers independently but not the proof.

**What is not an obstruction.** The three-pin example with negative weight needs **three** different pinned directions. The scheme above uses only one direction, P*, for every layer, together with u and v for the twist inside one annulus. The positive representation covers that.

## Tools in the literature (abstracts or text checked as stated)

- **Ding–Huang–Yang (arXiv:2611.04908), Section 2.2 (text read).** Loop soups with **local-time boundary conditions and boundary pairings** (ξˣ, ξʸ, Pˣ, Pʸ), and a spatial restriction lemma (Lemma 2.1): given the loops that meet H, the rest is again a loop soup with an updated local-time condition and the same boundary condition. This is the formalism for conditioning on outside loops (point 2 above). Their Remark 1.3 notes that arbitrary spin boundary conditions are "not immediate".
- **Lees and Taggi, PTRF 180 (2021) 1099 (arXiv:2006.06654; abstract checked).** A coloured random-path representation of O(N) with a "colour-switch" lemma and an explicit spatial Markov property. They prove exponential decay of transverse correlations in a **nonzero** field. These are tools for comparing path measures without FKG.
- **Duminil-Copin, Peled, Samotij and Spinka, CMP 349 (2017) 777 (arXiv:1412.8326; abstract checked).** In the loop O(n) model on the hexagonal lattice with **large n**, long loops are exponentially unlikely, uniformly in the edge weight. That model is a different loop model (non-intersecting loops). It suggests a separate question: does a large loop weight q give decay for CP^{q−1} at large q, uniformly in β? Not examined.

## Concrete next steps

1. **Derive the tilt T** exactly from the moment formula: the free model conditioned on z_x → u for x ∈ B, written in loop variables.
2. **Falsification test on small graphs.** Enumerate loop configurations exactly (a square, a 2×3 grid, the smallest annulus) and compute Cov_free(1_A, T) for crossing events A. A single negative value with matched definitions would kill the lemma in this form. This is also what the other assistant suggested (tree and square).
3. **If the test passes,** look for a proof through a Lees–Taggi-type switching argument, or through the restriction formalism of Ding–Huang–Yang, instead of FKG.
