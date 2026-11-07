# Five approaches that might be new (7 November 2026)

*Working note. The author asked for five approaches that do not exist yet, explored systematically, and then a first attempt. "Not found" below means not found in a first search of abstracts and excerpts; it does not mean the idea is new.*

## The gap they aim at

[`NOTE_SU2_FRUSTRATION.md`](NOTE_SU2_FRUSTRATION.md) found where the O(3) tools stop working for SU(2). In a spin model a sign excitation is a **point**: one spin flips, and only its few bonds need to be weak. In a gauge theory it is a **closed surface**, which must be cheap along its whole area. The positivity tools of both 2D proofs (FKG, cluster representations, loop soups) are built for points and lines. What would be new is **positive, mutually reinforcing structure for surfaces, with a non-abelian symmetry underneath**. Each approach below looks for it along a different axis.

| # | Axis | Idea | Status of a first check | Cheapest test |
|---|---|---|---|---|
| 1 | Scale | *Flow to positivity:* smooth the field with the gradient flow and look for a scale where the centre signs are nearly unfrustrated but still disordered. | Smoothing of centre vortices is known (Höllwieser and Engelhardt, arXiv:1411.7097 †). The frustration question was not found. | **Done below: no window.** |
| 2 | Parameter | Like Ding–Huang–Yang's real N: a continuous family of monopole-free theories from Z₂ gauge theory to SU(2), positive along the whole path (for example the fundamental–adjoint plane with monopoles forbidden). | The mixed-action phase diagram with monopole and vortex suppression is studied (Datta and Gavai †); it has bulk transitions and artefact phases. | Literature first, then a small scan. |
| 3 | Dimension | A thick centre vortex is a 2D world-surface carrying a colour direction on S². That is a 2D O(3) field *living on the vortex*. Apply the new 2D theorem there: if the colour direction decorrelates exponentially along the sheet, thick vortices look like unoriented Z₂ objects at large scales. | The colour structure of vortex sheets is known: non-orientable sheets, monopole lines where the direction flips (Engelhardt, hep-lat/0512015 †; hep-th/9911145 †). For non-abelian vortices in supersymmetric theories the world-sheet theory is a CP^{N−1} sigma model (arXiv:1207.2070 †), the same family as [`CPN_TWIST.md`](CPN_TWIST.md). Applying the 2026 O(3) theorem on the sheet was not found. | Pen and paper: what world-sheet model, which couplings, which boundary conditions. |
| 4 | Source of positivity | Bootstrap: Makeenko–Migdal loop equations plus positivity of Wilson-loop matrices (Kazakov and Zheng), extended to 't Hooft twisted sectors, for rigorous bounds on the twist free energy. | The SU(2) bootstrap exists, with string-tension estimates (arXiv:2404.16925 †). With twisted sectors: not found. | A small semidefinite programme on a 2⁴ or 3⁴ torus. |
| 5 | Representation | A cluster representation of monopole-free SU(2): the coset field V plus a random plaquette complex with p_p = 1 − e^{−2\|J_p\|}, where a Wilson loop becomes a homological-percolation event. | Proved for Potts lattice gauge theory with constant couplings (Duncan and Schweinhart, arXiv:2207.08339 †). With random couplings and a non-abelian coset: not found. | On existing configurations. Step 2 of the frustration note already predicts that the complex is nearly full, so all area law sits in V. |

## Approach 1 tested: flow to positivity

**Method** (`pilot/su2_frustration/flow.py`, `out3/`). Wilson flow in Lüscher's normalisation, Euler steps of 0.01, on 8 configurations per β (8⁴, Wilson action, β = 2.4 and 2.6). Checks: the plaquette rises along the flow, and the flow commutes with gauge transformations (differences ≤ 10⁻¹⁶). At flow times t = 0 … 1 and loop sizes R = 1, 2, 3 we measure the fraction of negative R×R loops, p, and the fraction of frustrated side-R cubes, f. For six independent random signs f would be f_ind = (1 − (1 − 2p)⁶)/2. A positive-and-disordered window would need f ≪ f_ind while p stays sizable.

**Result.** At every scale and flow time f/f_ind lies between 0.85 and 1.0. Two examples at β = 2.4: R = 2, t = 0.5: p = 0.022, f = 0.103, f_ind = 0.121. R = 3, t = 1.0: p = 0.060, f = 0.228, f_ind = 0.269. The flow removes negative loops. It does not organise them into closed surfaces. There is a weak trend towards organisation at the largest R and t (ratio 0.85), too small to call a window.

**Limits.** The sign of an R×R loop is a poor detector of a vortex whose thickness is comparable to R: a vortex that only partly overlaps the loop gives a trace near zero, and its sign is then noise. A study of the vortex free energy puts the thickness at slightly above 1 fm (hep-lat/0010076 †). With a√σ = 0.267 at β = 2.4 and √σ = 440 MeV, a ≈ 0.12 fm, so a thick vortex is about 8 lattice spacings across. A fair test needs R well above that, hence lattices of 24⁴ or more. That is beyond a cheap pilot. On 8⁴ and with this observable, approach 1 gives no window.

## Where this leaves the five

- 1: **no window** on 8⁴; a fair test needs much larger lattices.
- 5: predicted by step 2 to put all area law in V; a precise new object, but probably not a lever.
- 2: likely to run into known artefact phases; check the literature before computing.
- **3, worked out in [`WORLDSHEET.md`](WORLDSHEET.md):** the sheet field is RP², the disputed case of the 2D models; a heuristic says its point vortices are absent, which would bring it back to O(3); the theorem's hypotheses do not hold on vortex sheets as they stand; at the lattice scale the colour on sheets is noise. Approach 3 is now a conditional question about an infrared vortex model.
- **3 was the most promising.** It is the only approach that lowers the dimension to where the new theorem lives. It also connects to the CP^{N−1} work already in this folder. The first step is pen and paper: state the world-sheet model of a thick SU(2) vortex and decide whether the O(3) theorem's hypotheses (planar annulus, free boundary, bounded nonnegative strengths) can hold on a random, non-orientable surface.
- 4 is a solid, independent check that does not depend on any picture of confinement.

† seen only in search excerpts.
