# Release candidate — dated research snapshot

**Prepared:** 8 November 2026  
**Status:** copy-ready notes and a publication checklist. **No release or tag has been published by creating this file.**  
**Proposed GitHub release title:** *Research snapshot: Yang–Mills routes and CP loop pinning — 2026-11-08*  
**Proposed tag:** `ymgap-research-2026-11-08`, **created from the final merge commit on `main`**. Verify the tag is unused before creating it.  
**Release type:** **Pre-release / research archive**. This is **not** an increment to the repo-wide *Evolution by Emergence v23.0* theory release.

## Copy-ready public release description

> ### Research snapshot: Yang–Mills routes and CP loop pinning (8 November 2026)
>
> This is a research handoff, not a solution to the Yang–Mills mass-gap problem. It collects a short, intense exploration of four-dimensional SU(2) lattice approaches, formal covariance-transfer bookkeeping, numerical controls, and analytic work on two-dimensional CP^(q−1) projector-loop models.
>
> **No four-dimensional Yang–Mills mass gap or general CP mass-gap theorem is established.** The work is shared so independent researchers can inspect its arguments, reproduce numerical and exact finite-model tests, find mistakes, establish novelty, or continue the remaining open problems.
>
> **What is included**
>
> - Conditional renormalisation and covariance-transfer statements in a standalone Lean 4 directory. The accompanying GitHub Actions workflow builds the package and audits at least 14 results without `sorryAx`. This checks formal implications, **not** their physical hypotheses.
> - Documented SU(2) and O(2)/O(3) pilots, including negative or closed routes and an explicit recognition that part of the centre-sector analysis reproduces earlier literature.
> - Candidate finite-graph CP projector-loop arguments: positive two-terminal kernels, event-resolved gluing, graphical fusion, double stars and restricted multi-gateway cases. These were cross-checked internally, **not externally refereed**.
> - An exact symbolic sign certificate on one **squarefree** seven-edge two-gateway model, with every edge used at most once. This is **not** a proof for the full exponential action.
> - Reproduction scripts, input/output data, the research dialogue and links to the unproved steps.
>
> **Open questions for contributors**
>
> - [#145 — Independent mathematical review](https://github.com/albertjanvanhoek/Evolution-by-Emergence/issues/145): check the CP gluing and pinning proofs, the O(3) bounded-range twist estimate and the literature.
> - [#146 — Strong multi-gateway CP inequality](https://github.com/albertjanvanhoek/Evolution-by-Emergence/issues/146): prove or refute normalized crossing monotonicity for strongly coupled multiple gateways in the **full** model, preferably with size-uniform bounds.
> - [#147 — Multiple outer boundary sites](https://github.com/albertjanvanhoek/Evolution-by-Emergence/issues/147): construct or falsify the necessary boundary-wiring comparison for annular layers. This remains necessary for any proposed CP decay theorem.
>
> **Start here:** [Research handoff](research/yang-mills-mass-gap/HANDOFF.md) · [Reproduction guide](research/yang-mills-mass-gap/REPRODUCE.md) · [Full folder README](research/yang-mills-mass-gap/README.md) · [Open CP annulus lemma](research/yang-mills-mass-gap/CPN_STEP4.md).
>
> **Verification limits:** A green Lean build is not a physics proof; exact arithmetic in a Taylor-truncated model is not an untruncated theorem; finite-size or Monte Carlo results do not establish continuum behavior. No result should be cited as a new verified theorem before suitable independent mathematical and literature review.
>
> **License:** Subject to file-specific and third-party notices, repository-originated material is available under **CC BY 4.0 OR Apache-2.0**, as described in [DUAL-LICENSING.md](DUAL-LICENSING.md). Please cite this **specific research snapshot tag or commit**, not only the separately versioned EbE core.

## Owner's merge-and-release checklist

This sequence is **not carried out by this note**. It is provided for the owner to approve and execute.

- [ ] **Decide the archive scope:** PR #144 has more than 240 changed files and about 46,000 added lines, with most output lines in `pilot/` (JSON, NPZ). Keeping the datasets aids reproduction but makes the review large. The owner may merge the whole archive now or split raw outputs into a separate archival PR/release; neither choice changes the mathematics.
- [ ] **Read the handoff and claim limits:** check that the title, PR body, folder README and public release text do not claim a mass gap, peer review, originality or formal proof of the CP lemmas.
- [ ] **Check file rights and provenance:** review third-party material, figures, data and citations against [DUAL-LICENSING.md](../../DUAL-LICENSING.md), including any separately licensed assets. Do not assume every pilot dependency is redistributed under the repository license.
- [ ] **Confirm merge readiness:** the PR is mergeable, relevant required checks are green, and there are no unintended modifications to the EbE proved core or its current v23.0 citation/version.
- [ ] **Merge only on the owner's explicit approval**, as a **merge commit** (never squash or rebase), following [CLAUDE.md](../../CLAUDE.md). Record the exact resulting merge commit SHA.
- [ ] **Create a GitHub Release** using the proposed tag at the **merged `main` commit**, select **Mark as pre-release**, and paste/adapt the public text above. Do not call it a peer-reviewed paper or formal proof of the Clay problem. Verify that links in the published release resolve at the tag.
- [ ] **Preserve durable provenance:** link PR #144, issues #145–147 and the merged commit; keep the branch and full pilot data accessible. Use version-specific references for all future corrections.
- [ ] **Invite outside review** from mathematical probability, constructive field theory and lattice gauge theory specialists. Add errata and follow-up releases for verified corrections; never silently replace the archived claims.

### Scope of the larger repository

The root [RELEASE_NOTES.md](../../RELEASE_NOTES.md) and [CITATION.cff](../../CITATION.cff) currently refer to **Evolution by Emergence v23.0**. The research snapshot should not silently rewrite those records. A standalone, dated GitHub pre-release tag is the less misleading form of publication; it can be cited by tag and commit until an independently reviewed paper, data record or DOI exists.

**Publication decision:** reserved to the repository owner. The preparation does not perform a merge, create a tag, or publish a release.
