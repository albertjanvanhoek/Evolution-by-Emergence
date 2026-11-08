# Approach 3: a thick vortex as a 2D field on its own world-sheet (7 November 2026)

*Working note, the next step after [`FIVE_APPROACHES.md`](FIVE_APPROACHES.md). Pen and paper plus two cheap measurements. Not a result. † = seen only in search excerpts.*

**In short.** The colour field on a centre-vortex sheet is an RP² field, not an S² field. The 2D RP² model is exactly the case where an all-coupling gap is *disputed*, because of Z₂ point vortices. A heuristic argument says these point vortices are absent on vortex sheets, which would bring the sheet back to the O(3) case of the new theorem. But the hypotheses of that theorem (planar graph, nearest-neighbour nonnegative couplings, fixed geometry) do not hold on vortex sheets as they stand. A first measurement finds no coherent colour field at the lattice scale, and only a partly coherent one after smoothing. Approach 3 is therefore a conditional question about an infrared model, not yet a route for Yang–Mills. A closer reading of the O(3) proof (§6) shows that its twist estimate does not need planarity as such, only the two edge directions of the square lattice; a test on non-planar graphs with short extra edges is consistent with the estimate surviving, while long extra edges destroy it.

## Prior work (found after a first version of this note)

- **World-sheet sigma models on vortices are known in other theories.** In N = 1* supersymmetric SU(2) gauge theory with equal masses, the Z₂ vortices acquire orientational zero modes and become non-abelian strings. Their world-sheet theory is the two-dimensional non-supersymmetric O(3) sigma model, and a confined monopole appears as a kink on it (arXiv:hep-th/0408235 †, abstract). For U(N) theories the world-sheet theory is CP^{N−1} (arXiv:1207.2070 †; arXiv:1101.2574 † for dense QCD). These are strings in a Higgs phase, not the centre vortices of pure Yang–Mills.
- **Random vortex world-surface models** (Engelhardt, Quandt, Reinhardt) describe the infrared of pure SU(2) and SU(3) Yang–Mills by thick vortex surfaces on a lattice whose spacing is the vortex thickness. The authors write that no analytical approach is known for such a quantum string ensemble (hep-lat/0509114 †).
- **Vortex surfaces behave like rigid strings:** their action correlates with the curvature of the surface, and their area scales in physical units (arXiv:0705.3745 †).

So the idea of an O(3) field on a vortex world-sheet is not new. What may be new here is narrower: the observation that for pure-Yang–Mills centre vortices the field is sign-blind (RP²), the link to the disputed RP² case, and the question whether the 2026 O(3) theorem can be applied on such sheets (§6). That last question is also open for the Higgs-phase strings above, where the world-sheet theory is O(3) itself.

## 1. The world-sheet field is RP², not S²

A thin centre vortex multiplies a linked Wilson loop by −1. For every unit vector n, exp(iπ n·σ) = −1. The centre flux therefore does not see the sign of the colour direction n. Inside a thick vortex the flux builds up as exp(iα(r) n·σ) with α going from 0 to π across the core, and (n, α) and (−n, −α) give the same flux. So the natural field on the sheet is n up to sign: a point of RP² = S²/±. Non-orientable sheets, which the lattice data show (Engelhardt, hep-lat/0512015 †; hep-th/9911145 †), are then natural: they are sheets on which n has no consistent sign.

## 2. The 2D RP² model is the disputed case

The 2D RP² model has the same local geometry as O(3), and perturbation theory predicts a gap at all couplings. But π₁(RP²) = Z₂ allows point vortices, and whether they cause a transition has been argued for thirty years:
- Caracciolo (arXiv:hep-lat/9212012 †) saw no asymptotic scaling up to correlation lengths of about 220, which casts doubt on RP² and O(3) being in the same universality class.
- A tensor-network study (arXiv:2202.07597 †) sees an abrupt onset of scaling, consistent with earlier hints of a finite-temperature transition.
- Another tensor-network study (Phys. Rev. E 106, 014104 †) finds a single disordered phase with a strong crossover where the Z₂ vortices dissociate.
- A 2D "RP² gauge model" (arXiv:hep-lat/9801032 †) interpolates between RP² and O(3) through a chemical potential for the Z₂ vortices, and reports the conventional O(3) renormalised trajectory.

So the new O(3) theorem does not settle RP². The difference is exactly the Z₂ point vortices.

## 3. Are there Z₂ point vortices on a vortex sheet? A heuristic: no

A Z₂ point vortex of the sheet field is a point around which n comes back as −n: the end point of a line on the sheet across which the sign of n flips. In abelian gauges these flip lines are the world-lines of abelian monopoles on the vortex sheet (Engelhardt, hep-lat/0512015 †; hep-th/9911145 †). Monopole currents are conserved, so these lines are closed: they do not end. If they also stay on the sheets (lattice simulations report abelian monopoles localised on centre vortices, as cited in arXiv:0801.0262 †), the sheet field has **no point vortices**. Only a global sign twist remains around orientation-reversing cycles of the sheet. Locally the field is then an S² field, the O(3) case, which is also the "vortices suppressed" side of the RP² gauge model.

**Weak points.** A monopole line can leave a sheet where two sheets intersect. "Monopoles lie on vortices" is a statistical statement from lattice studies, not an identity. And the flip lines of a gauge-fixed picture are gauge dependent; only the absence of their end points matters, and that has not been checked here.

## 4. The hypotheses of the O(3) theorem, one by one

| Hypothesis of the theorem (OpenAI, Theorem 1.1) | On a vortex sheet | Status |
|---|---|---|
| Spins on S², interaction σ·σ' linear in each spin | RP²; locally S² if §3 holds, with a global sign twist on orientation-reversing cycles | plausible locally; the global twist is not covered |
| A finite subgraph of the square lattice Z² | A random, non-orientable surface of any genus, with self-intersections; locally square-lattice-like away from intersections | **not covered**: the twist estimate needs planar annuli |
| Nearest-neighbour pair couplings with strengths in [0, β] | The couplings come from integrating out the bulk; they may be multi-body or long-range, and are not derived | **not established** |
| Fixed graph and couplings (the bound is uniform over them) | Sheet geometry and colour fluctuate together (annealed) | covered only if the geometry can be conditioned on without spoiling the couplings |
| Free boundary | Closed surfaces | fine for finite graphs, but these are not planar |

The uniformity of the theorem over subgraphs and over couplings in [0, β] is a real asset: it already allows holes and random environments. The two real obstacles are planarity (the annulus) and the derivation of the couplings.

## 5. A first measurement: is the colour direction coherent along P-vortex sheets?

**Method** (`pilot/su2_frustration/worldsheet.py`, `out4/`). β = 2.4, 8⁴, Wilson action, 6 configurations, optionally Wilson-flowed, then direct maximal centre gauge. For every plaquette, n_p is the unit vector part of its holonomy, defined up to sign. Two P-plaquettes that are opposite faces of a common 3-cube are neighbours on a flat piece of sheet; we transport one direction across the cube along one link (adjoint action, blind to the centre sign) and average (n_p · n_q)². Random directions give 1/3; fully aligned give 1. The same average over all opposite-face pairs measures the smoothness of the background field. Checks: Haar-random links give 0.333, and the background average is unchanged by a random gauge transformation.

| flow time t | P-plaquette density | (n·n')², neighbouring P-plaquettes on a sheet | (n·n')², all opposite-face pairs | P pairs |
|---|---|---|---|---|
| 0 | 0.049 | 0.341 | 0.335 | 2628 |
| 0.2 | 0.022 | 0.370 | 0.357 | 1505 |
| 0.5 | 0.0075 | 0.499 | 0.447 | 592 |

At β = 2.6 without flow, only 24 neighbouring P-pairs occur (0.387 against 0.335).

**Reading.** At the lattice scale the colour direction on P-vortex sheets is noise, like everywhere else: plaquette holonomies are dominated by short-wavelength fluctuations. After smoothing to about 2a, the sheets become partly coherent, somewhat more than the background. A world-sheet colour field, if there is one, is an infrared object at the scale of the vortex thickness, about 8a at β = 2.4. That is beyond 8⁴.

**Limits.** Six configurations, one β with flow; DMCG local maxima; only flat neighbours (opposite faces) are compared, so bends of the sheet are left out; the error on the t = 0.5 value is a few hundredths.

## 6. What the twist estimate needs from the graph (reading of the proof, and a test)

**The projector form, linking to the CP track.** Even if §3 holds and n can be given a sign everywhere, the natural interaction on a vortex sheet is the sign-blind (n·n')², the projector form, not n·n'. Lifting n to S² does not make the interaction linear. So what the sheet needs is not the O(3) theorem itself but the twist estimate for the real-projector (RP) interaction, restricted to configurations without point vortices. [`CPN_TWIST.md`](CPN_TWIST.md) records that for RP^{N−1} the rotation generators have operator norm 2, so the constants of Section 2 must be recomputed. That computation is shared by the CP track and this one.

**Where the square lattice is used.** Reading Sections 2 and 3 of the OpenAI preprint line by line:
- **Proposition 2.2 holds on every finite graph.** The paper says so: its constants do not depend on the graph, the family size or the fixed spins.
- **The gauge identity (3.4) also holds on every graph**, for any vertex function Θ equal to one on the inner pinned layer and zero on the outer one. Its gradient h = dΘ then has ‖h‖₂² equal to the Dirichlet energy of Θ, which is at least the effective conductance between the two layers.
- **Only Lemma 3.2 uses the square annulus.** It builds the multiscale family of plane waves, with r^{-3/2} weights summed over all scales r ≤ N, whose summed commutator current equals λ_N h̃ with λ_N ≳ log N, at a total cost of order log N. That ratio, (log N)² against log N, is the whole gain.
- **What the lemma really uses is not planarity but the two edge directions.** The identity Σ_i S(f_i, f̄_i) = −iλ_N h̃ is exact because each group of frequencies is symmetric under the reflection that fixes one axis, so the sines along the other axis cancel. The transfer from h̃ to h in (3.17)–(3.19) then needs ‖h − h̃‖₁ ≤ C/N, that is a per-edge accuracy of order N⁻³ on O(N²) edges.
- **For an extra edge in another direction v, the identity holds only approximately.** The cosine factor of the transverse component deviates by a relative amount of roughly ℓ²/log N, summed over the top scales (our rough estimate). Over a positive density of such edges, ‖h − h̃‖₁ grows like N/log N, and the ℓ¹ transfer fails. **This is the only obstruction we found.** It is technical: the transfer step bounds X(dc) by β‖d‖₁, and a sharper bound, or a frequency family adapted to each edge direction, might remove it. *Our reading, not checked by anyone else.*

**A test: non-planar but local graphs** (`pilot/twist_graph.py`, `pilot/twist_graph_out/`). O(3) on the annulus N ≤ ‖x‖∞ ≤ 2N with the same measurement as `pilot/annulus_twist.py` (thermodynamic integration of d/dt log Z, 2000 + 8000 sweeps per twist angle, 9 angles). Extra edges join free vertices only: "short" edges have sup-length 2 to 4 (local wormholes; the graph is no longer planar), "long" edges join random pairs anywhere (the negative control). ρ is the number of extra edges per free vertex. The planar runs reproduce the earlier values (18.36 against 18.31 at N = 4). Twist cost f(π/2) = −log Z(π/2)/Z(0), errors 0.03–0.23:

| graph | β | N = 4 | 8 | 16 | 32 | change 16 → 32 |
|---|---|---|---|---|---|---|
| planar | 2.0 | 18.36 | 16.01 | 14.18 | 12.45 | −12% |
| planar | 2.3 | 22.29 | 20.29 | 17.89 | 15.57 | −13% |
| planar | 2.6 | 26.20 | 24.25 | 22.12 | 21.03 | −5% |
| short, ρ = 0.1 | 2.0 | 20.84 | 22.59 | 21.46 | 19.59 | −9% |
| short, ρ = 0.3 | 2.0 | 24.48 | 31.66 | 34.44 | 35.59 | +3% |
| long, ρ = 0.01 | 2.0 | 18.37 | 16.80 | 17.81 | 25.46 | +43% |
| long, ρ = 0.1 | 2.0 | 20.51 | 24.70 | 43.08 | 81.11 | +88% |

**Reading.**
- **Long edges destroy the effect,** as they should: they make the graph effectively higher-dimensional, and the cost grows with the number of long edges.
- **Short edges act like a stronger coupling.** A bond of length ℓ adds stiffness of order ℓ², so short wormholes raise the effective coupling more than their number suggests. At ρ = 0.1 the cost first rises (a boundary-layer effect at small N: no extra edges can reach the pinned layers) and then falls, by 9% from N = 16 to 32, between the planar rates at β = 2.3 and 2.6. At ρ = 0.3 the rise is flattening (+9%, then +3%); the fall would start beyond N = 32.
- **So the numerics are consistent with the twist estimate surviving local non-planarity,** with a larger effective coupling. They do not show it: N ≤ 32, one graph per setting, and a falling cost is also what any gapped model gives.

**Update: proved (pending human review).** [`TWIST_NONPLANAR.md`](TWIST_NONPLANAR.md) proves the bounded-range statement below, written by an assistant of another model family and checked step by step by this one (PR #144). The key change is to stop the frequency shells at ⌊√N⌋ and normalise by their linear moment. That keeps a gain of order log N and gives ‖h − h̃‖₁ = O(1/log N), which is enough for the transfer. The same note corrects three points of this section, and the corrections are right:
- the transfer does **not** need ‖h − h̃‖₁ = O(1/N); O(1/log N) suffices, so the "only obstruction" named above is a limitation of the full-shell construction, not of the statement;
- the geometric input is more than two edge directions: the two-dimensional shell count and the Fourier bound on a torus are essential too (they extend to any fixed range);
- a density of non-axis edges does not by itself prove the N/log N growth; positions, directions and profiles matter.

**The lemma this suggests** (originally a conjecture; see the update above):

> Proposition 3.1 holds, with a constant depending on β, ℓ, D and ρ, for O(3) on the square annulus plus extra edges of sup-length at most ℓ, with every vertex of degree at most D.

With the proof, planarity can be replaced by a weaker condition: the sheet (or a piece of it) must map **injectively into the square annulus with every edge of bounded length**. A sheet with small handles at bounded density may satisfy this after refining the target lattice; that is a geometric question about sheets, not settled here. Handles at all scales would still be excluded, as the long-edge control suggests. The other gaps of §4 remain: the projector form (norm-2 constants), the derivation of the couplings, and annealed geometry.

## 7. What approach 3 is now

A conditional question about an infrared model, not a route for Yang–Mills yet:

> In a random vortex world-surface ensemble (as in Engelhardt's vortex models) carrying an RP² colour field with no point vortices and nearest-neighbour ferromagnetic couplings, does the colour decorrelate exponentially along the sheets at every coupling?

This is a question about the 2D O(3) model on random, non-planar surfaces. The methods of the new proof might extend to it: the twist estimate needs annuli, and random planar surfaces have them in a statistical sense. Connecting it to Yang–Mills would need a derivation of that ensemble from the lattice theory, which is the renormalisation problem again.

What a positive answer would give: colour coherence on sheets is short-ranged, so at large scales vortices act as unoriented Z₂ objects; a finite physical density of orientation flips (abelian monopoles) on the sheets. What it would not give: confinement or a gap in 4D. Those need the sheets themselves to percolate and the twist free energy to be small.

## Next steps

- [ ] Literature: how Engelhardt's models treat colour on the sheets, and the lattice data on monopoles on vortices (fractions, intersections).
- [x] Mathematics, first pass: Proposition 3.1 needs the two edge directions of the square lattice (through the exact identity (3.8) and the ℓ¹ transfer), not planarity as such. See §6.
- [x] Prove or refute the lemma of §6: proved in [`TWIST_NONPLANAR.md`](TWIST_NONPLANAR.md) (shortened frequency family), reviewed by a second model family; human review still needed.
- [ ] Section 4 of the O(3) proof (sign clusters, crossings) on bounded-range graphs: needed to turn the twist estimate into exponential decay there.
- [ ] Recompute the constants of Section 2 for the real-projector interaction (norm-2 generators), together with the CP track.
- [ ] Numerics at 16⁴ or 24⁴ for colour coherence at the thick-vortex scale: ask the author first (cost).
- [ ] Check §3 directly: count end points of sign-flip lines on P-vortex sheets after smoothing.
