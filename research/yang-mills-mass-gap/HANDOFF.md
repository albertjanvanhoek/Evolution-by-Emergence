# Research handoff — Yang–Mills routes and CP loop pinning

**Snapshot prepared:** 8 November 2026  
**Status:** open research record; analytic arguments and numerical pilots, **not** a mass-gap proof, a peer-reviewed article, or a new theorem in the EbE core.  
**Repository PR:** [#144](https://github.com/albertjanvanhoek/Evolution-by-Emergence/pull/144)  
**Open tasks:** [human mathematical review #145](https://github.com/albertjanvanhoek/Evolution-by-Emergence/issues/145) · [strong multi-gateway networks #146](https://github.com/albertjanvanhoek/Evolution-by-Emergence/issues/146) · [multiple annular boundary sites #147](https://github.com/albertjanvanhoek/Evolution-by-Emergence/issues/147)

## Read this first

This folder records an exploratory attempt to identify usable routes toward the **four-dimensional Yang–Mills mass-gap problem**. The most developed analytic direction now concerns **two-dimensional CP^(q−1) projector spin models**. That model is a separate test case; even proving exponential decay for it would **not** settle the Yang–Mills problem. The work is preserved so that other researchers can reproduce, criticize, correct and continue it without relying on the original conversations.

**No Yang–Mills or general CP mass-gap theorem has been established.** Several finite-graph comparisons and an O(3) twist extension are presented with mathematical proofs in this folder, but **none has been certified by an external human expert**. Agreement among automated readers, a green Lean workflow and numerical corroboration are distinct forms of evidence; none replaces external peer review.

For a minimal entry route:

1. [Research overview and closed routes](README.md) and [ROUTE.md](ROUTE.md).
2. [The precise missing CP annulus lemma](CPN_STEP4.md) — this remains **open**.
3. [CP loop representation](CPN_POSITIVE_LOOPS.md), [pinning comparison](CPN_PINNING.md) and [two-terminal gluing proof](CPN_TWO_TERMINAL_GLUING_PROOF.md).
4. [Single-gateway positive reduction](CPN_TWO_TERMINAL_POSITIVE_REDUCTION.md), [separate-routes theorem and multi-gateway screens](CPN_MULTI_GATEWAY.md), and [the exact finite squarefree certificate](CPN_MULTI_GATEWAY_SYMBOLIC_Q.md).
5. [Reproduce the checks](REPRODUCE.md) and [snapshot release notes](RELEASE_CANDIDATE.md).

## Claim and evidence ledger

| Subject | What the folder actually provides | What it does **not** establish |
|---|---|---|
| **Lean / RG bookkeeping** | 14 audited *conditional* Lean statements for finite-space covariance splitting, transfer bounds and physical-scale assumptions; [source](lean/) and [workflow](../../.github/workflows/yang-mills-mass-gap-check.yml) | The physical hypotheses, a continuum limit, or a spectral mass gap |
| **4D SU(2) gauge pilots** | Exploratory twist and centre-frustration calculations; prior-art check against the SO(3) × Z(2) formulation; [route](ROUTE.md), [frustration](NOTE_SU2_FRUSTRATION.md) | An all-coupling confinement theorem, a valid route to the Clay problem, or evidence of novelty of the centre decomposition |
| **2D O(3) twist** | [Bounded-range, non-planar twist estimate](TWIST_NONPLANAR.md) with cross-checks | A new spectral gap theorem or externally verified priority |
| **CP single- and two-terminal comparisons** | Analytic candidate proofs for stars, double stars, graphical fusion, one-gateway internal networks and a relative slope; [gluing proof](CPN_TWO_TERMINAL_GLUING_PROOF.md) and [independent audit](CPN_TWO_TERMINAL_INDEPENDENT_AUDIT.md) | Arbitrary multi-site annular boundaries, external human validation, or a general CP decay theorem |
| **CP multiple gateways** | An analytic separate-routes argument; full-model numerical screens; a symbolic **squarefree** seven-edge certificate at all formal q≥2; [multi-gateway note](CPN_MULTI_GATEWAY.md), [certificate](CPN_MULTI_GATEWAY_SYMBOLIC_Q.md) | Monotonicity for all strongly coupled three-terminal gateways in the **untruncated** model; volume-uniform estimates |
| **Larger bridge to Yang–Mills** | Failed-route documentation and conditional conjectures for follow-up | Any demonstrated implication from the CP model to the 4D continuum physical Hilbert-space gap |

**Terminology:** “Analytic candidate proof” means a complete mathematical argument was written and internally cross-checked; external review could still reveal errors or prior art. “Exact” in a **finite Taylor/squarefree** test refers to its rational arithmetic **within the stated truncation**, not the untruncated Gibbs measure. “Uniform relative” applies only under the explicitly stated single-gateway conditions.

## Where a new contributor can help

**First priority — independently audit mathematical claims.** Start with [issue #145](https://github.com/albertjanvanhoek/Evolution-by-Emergence/issues/145). In particular check the event-resolved gluing identity, the orthogonal-pinning argument and its q=2 rational continuation, the rank-two likelihood-ratio comparison, and the O(3) nonplanar twist estimate. Search primary mathematical literature for already-known results. Report counterexamples, invalid assumptions and nomenclature corrections; negative findings are useful.

**Second priority — the genuine multi-gateway gap.** In [issue #146](https://github.com/albertjanvanhoek/Evolution-by-Emergence/issues/146), study the normalized probability `h(p)` of a **direct marked-strand excursion** when multiple strongly coupled gateways meet both pinned sources and the outer site. The correct target is `h'(p) >= 0` (or an explicit counterexample) in the **full exponential model**, preferably with network-size control. Do **not** require individual alternation classes `a_k/c_k` to increase: the stronger property fails in the documented finite squarefree test even when `h` increases.

**Third priority — real boundary layers.** In [issue #147](https://github.com/albertjanvanhoek/Evolution-by-Emergence/issues/147), replace the sole outer marked vertex by **many** boundary vertices. A two-terminal scalar kernel is insufficient; the exterior permutation/wiring state must be retained. Precisely define annulus excursions and prove or falsify the multi-annulus pinning lemma in [CPN_STEP4.md](CPN_STEP4.md). Then, and only then, revisit the proposed decay argument.

The completed pilots in [RESULTS.md](pilot/RESULTS.md) and the SU(2) and CP notes are useful controls and counterexample sources. A newcomer need not repeat all pilot simulations before reviewing the actual mathematical gap.

## Contributing and reporting

- Open an issue or PR against the repository, link one of #145–#147, and specify the **exact theorem/definition/equation** addressed.
- For a proof, state the graph class, allowed edge strengths, dimension `q`, event definition, volume dependence and boundary conditions. Distinguish full exponential interactions from any edge-count truncation.
- For a computation, provide exact input couplings, random seeds (if applicable), numerical error method or rational certificate, software dependencies and a minimal command. Never report a small-grid non-counterexample as a theorem.
- Say plainly if a result matches known literature, if the primary source was not read, or if it relies on an unverified lemma. A corrected failed approach is part of the project.
- The repository's [working agreements](../../CLAUDE.md) and [dialogue](../../DIALOGUE.md) include provenance and the requirement to expose uncertainty or disagreement. The archive is independent of the EbE proved core.

## Publication, attribution and versions

The wider repository currently identifies its own theory release as **v23.0**; this folder should be released as a **separate dated research snapshot** rather than incrementing the theory's version or modifying its `CITATION.cff` by implication. See [RELEASE_CANDIDATE.md](RELEASE_CANDIDATE.md) for proposed release copy and a manual publication checklist. Cite the **exact snapshot tag or commit**, and preserve contributor provenance. Licensing is [CC BY 4.0 **OR** Apache-2.0](../../DUAL-LICENSING.md), subject to any file-specific or third-party rights notices.

**Merge decision and release publication are reserved to the repository owner.** Before any public claims about mathematical priority or completeness, seek review from a human specialist in constructive field theory, lattice gauge theory, or mathematical probability.
