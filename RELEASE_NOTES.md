# Evolution by Emergence v21.1 — Common Ground and Archival Metadata Repair

v21.1 is a focused update to v21. It keeps the v21 universal retained-organization/accessibility core and cumulative-reproduction specialization intact, extends the intelligent-system specialization with an audited common-ground result, and repairs the release metadata that prevented v21 from being archived by Zenodo.

## 1. Step 6: common ground is the link, not the content

The SCAP seed now makes a sharper distinction between shared content and shared correctability.

The key plain-language statement is:

> **Common ground is not what we agree on. It is how we find out when one of us is wrong.**

The seed adds three results in its own vocabulary:

- `informative_view_has_live_rival`: any informative view that rules out an open world has a live rival;
- `shareable_iff_rules_out_nothing`: content that no potentially correct rival can oppose is exactly content that rules out nothing;
- `room_agreement_is_rivalled`: agreement between two parties is not automatically common ground for everyone in the room.

The same idea is audited in both Lean packages through:

- `informative_content_has_live_rival` — no axioms;
- `shareable_iff_rules_out_nothing` — no axioms;
- `agreement_witness` — `propext` only.

This makes the intended distinction explicit: the common structure is not a proposition that everyone must already share, but the maintained route by which live rival content can remain visible and correction can still occur.

## 2. Updated audited surfaces

The SCAP seed now audits **184 results**, including **103 axiom-free** results, with no unfinished proofs.

The research Anchored Correctability package now audits **227 results**. Its CI gate is pinned to that exact count and rejects `sorryAx`.

The Step 6 results are included in both package audit files rather than existing only as prose.

## 3. Zenodo archival repair

The v21 GitHub release was created successfully but Zenodo reported:

    Citation metadata load failed

The v21 `CITATION.cff` contained the invalid CFF value:

    license: "CC-BY-4.0 OR Apache-2.0"

CFF 1.2.0 represents alternative licenses as a list, so `CITATION.cff` is now standards-compliant:

    license:
      - CC-BY-4.0
      - Apache-2.0

Zenodo's GitHub ingestion currently has a separate compatibility problem with multi-license arrays in `CITATION.cff`. To keep the repository metadata correct without depending on that parser behavior, v21.1 also adds `.zenodo.json`. Zenodo documents that `.zenodo.json` takes precedence over `CITATION.cff` for GitHub release archiving.

The Zenodo metadata therefore supplies a single archival license value, CC BY 4.0, while the repository's authoritative `DUAL-LICENSING.md` continues to grant original repository material under **CC BY 4.0 OR Apache-2.0**.

The obsolete lowercase `citation.cff`, which still described version 0.88, has been removed so there is only one current CFF citation file.

## 4. Release-metadata safeguards

The release checks now validate the citation and Zenodo metadata before a release is published. The checks require:

- a schema-valid `CITATION.cff`;
- parseable `.zenodo.json`;
- `CITATION.cff`, `.zenodo.json` and `RELEASE_VERSION` to name the same release;
- Zenodo metadata to use a single license value on the GitHub-ingestion path;
- the stale lowercase `citation.cff` to remain absent.

This turns the v21 archival failure into a regression test for later releases.

## 5. Relation to v21

v21.1 does not replace or rewrite the scientific content of v21. It contains that release line plus the audited Step 6/common-ground extension and the corrected archival metadata.

The principal review surfaces remain:

1. `THEORY_CORE_V21.md` — universal synthesis;
2. `FORMAL_THEORY_MAP.md` and `FORMAL_THEORY_ENDPOINT.md` — formal route and scope;
3. `formalization/cumulative-accessibility/` — universal retained-organization/accessibility core;
4. `research/cumulative-reproduction/` — production/loss/resource specialization;
5. `UNIVERSAL_TO_INTELLIGENCE.md` — specialization seam;
6. `research/anchored-correctability/` — deep intelligent-system specialization;
7. `scap-seed/` — portable anchor-to-corrigibility seed, now including Step 6.

The same scope boundaries remain in force: machine checking establishes the stated formal implications under their premises; it does not by itself establish empirical universality.
