# Approach 3: a thick vortex as a 2D field on its own world-sheet (7 November 2026)

*Working note, the next step after [`FIVE_APPROACHES.md`](FIVE_APPROACHES.md). Pen and paper plus one cheap measurement. Not a result. † = seen only in search excerpts.*

**In short.** The colour field on a centre-vortex sheet is an RP² field, not an S² field. The 2D RP² model is exactly the case where an all-coupling gap is *disputed*, because of Z₂ point vortices. A heuristic argument says these point vortices are absent on vortex sheets, which would bring the sheet back to the O(3) case of the new theorem. But the hypotheses of that theorem (planar graph, nearest-neighbour nonnegative couplings, fixed geometry) do not hold on vortex sheets as they stand. A first measurement finds no coherent colour field at the lattice scale, and only a partly coherent one after smoothing. Approach 3 is therefore a conditional question about an infrared model, not yet a route for Yang–Mills.

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

## 6. What approach 3 is now

A conditional question about an infrared model, not a route for Yang–Mills yet:

> In a random vortex world-surface ensemble (as in Engelhardt's vortex models) carrying an RP² colour field with no point vortices and nearest-neighbour ferromagnetic couplings, does the colour decorrelate exponentially along the sheets at every coupling?

This is a question about the 2D O(3) model on random, non-planar surfaces. The methods of the new proof might extend to it: the twist estimate needs annuli, and random planar surfaces have them in a statistical sense. Connecting it to Yang–Mills would need a derivation of that ensemble from the lattice theory, which is the renormalisation problem again.

What a positive answer would give: colour coherence on sheets is short-ranged, so at large scales vortices act as unoriented Z₂ objects; a finite physical density of orientation flips (abelian monopoles) on the sheets. What it would not give: confinement or a gap in 4D. Those need the sheets themselves to percolate and the twist free energy to be small.

## Next steps

- [ ] Literature: how Engelhardt's models treat colour on the sheets, and the lattice data on monopoles on vortices (fractions, intersections).
- [ ] Mathematics: what Proposition 3.1 of the OpenAI proof (the annular twist) needs from the graph. Does it hold on finite planar graphs of bounded degree, and on random planar maps?
- [ ] Numerics at 16⁴ or 24⁴ for colour coherence at the thick-vortex scale: ask the author first (cost).
- [ ] Check §3 directly: count end points of sign-flip lines on P-vortex sheets after smoothing.
