# v20 peer-review protocol

Use this protocol for independent adversarial review of the **Evolution by Emergence v20 cumulative-evolution theory**.

The review object is the immutable v20 release. Always resolve the release/tag to its exact commit SHA before analysis.

## Copy-paste reviewer prompt

    Act as an adversarial scientific peer reviewer of the v20 release of:

    https://github.com/albertjanvanhoek/Evolution-by-Emergence

    Resolve tag/release v20 to an exact commit SHA before analysis and report it.

    PURPOSE

    Evolution by Emergence v20 proposes a substrate-agnostic architecture for
    cumulative evolution in which retained organization can change later
    transition machinery and future accessibility while itself consuming a
    finite maintenance budget.

    The proposed universality is a hypothesis to challenge, not an established
    empirical law and not a priority claim.

    Your job is to determine whether:

    1. the formal implications are correct;
    2. the definitions mean what the prose says they mean;
    3. any conclusion is hidden inside a premise;
    4. an equal or stronger architecture already exists in the literature;
    5. the factorization adds explanatory value;
    6. the same interfaces can be mapped non-arbitrarily to genuinely different
       cumulative-evolution systems;
    7. a counterexample breaks or narrows the proposed universality.

    ACCESS GATE

    Report:

    REPOSITORY ACCESS: yes / no
    EXACT V20 COMMIT SHA: <sha / unresolved>
    SOURCE-FILE ACCESS: yes / no
    LEAN EXECUTION: yes / no
    LITERATURE SEARCH: yes / no

    If repository access fails, do not invent file contents, theorem names,
    proof results, or release metadata.

    CORE READING ORDER

    README.md
    THEORY_CORE_V20.md
    FORMAL_THEORY_MAP.md
    FORMAL_THEORY_ENDPOINT.md
    formalization/cumulative-accessibility/UNIVERSAL_LAW_CANDIDATE.md
    formalization/cumulative-accessibility/README.md
    RELEASE_NOTES.md

    CANONICAL LEAN SURFACE

    formalization/cumulative-accessibility/CumulativeAccessibility/RetainedOrganizationCore.lean
    formalization/cumulative-accessibility/CumulativeAccessibility/TransitionAccessibility.lean
    formalization/cumulative-accessibility/CumulativeAccessibility/EmergentAssemblyBarrier.lean
    formalization/cumulative-accessibility/CumulativeAccessibility/TransitionMediatedEmergence.lean
    formalization/cumulative-accessibility/CumulativeAccessibility/GenerativeLeverage.lean
    formalization/cumulative-accessibility/CumulativeAccessibility/PaidReuseHierarchy.lean
    formalization/cumulative-accessibility/CumulativeAccessibility/RepetitionDepth.lean
    formalization/cumulative-accessibility/CumulativeAccessibility/DynamicVortex.lean
    formalization/cumulative-accessibility/CumulativeAccessibility/AuditAll.lean
    formalization/cumulative-accessibility/CumulativeAccessibility/VerificationSurface.lean

    RECONSTRUCT THE THEORY BEFORE CRITICIZING IT

    Reconstruct this recursive architecture from the source:

    gross budget
      -> maintenance cost of retained organization
      -> free budget

    retained organization
      -> transition machinery
      -> finite-horizon accessibility
      -> generated / reachable organization
      -> budget-constrained retention
      -> changed retained organization

    Then separately reconstruct the strict-emergence assembly barrier and the
    bounded-memory / bounded-reuse constraints.

    THEOREM-DIRECTION RULE

    Preserve implication direction.

    In particular:

    - positive paid opening + non-decreasing upkeep implies a necessary
      retained-kernel advantage;
    - route saving that exceeds marginal upkeep is a sufficient condition for
      a paid-opening budget window;
    - these two statements are not claimed as converses;
    - strict compositional emergence does not imply retention;
    - the emergent future function cannot by itself finance a positively costly
      proper intermediate under the declared benefit condition;
    - finite resource budget can make full retention infeasible but does not
      determine which item should be retained;
    - bounded retained cardinality plus bounded single-unit reuse bounds
      accessible cardinality under the declared encoding.

    CORE CLAIMS TO ATTACK

    A. PAID RETAINED TRANSFER
    Retained organization is tested by matched retain/ablate counterfactuals
    after each arm pays its own maintenance burden.

    B. KERNEL -> ACCESSIBILITY
    Accessibility is induced from actual routes through weighted transition
    machinery for the canonical theorem surface.

    C. NECESSARY KERNEL ADVANTAGE
    If retention costs weakly more yet creates positive paid opening, the
    ablated kernel cannot dominate the retained kernel.

    D. SUFFICIENT ROUTE-SAVING CONDITION
    A retained route saving exceeding marginal upkeep opens a common-gross-
    budget accessibility window.

    E. EMERGENT ASSEMBLY BARRIER
    A future strictly emergent function cannot finance proper non-realizing
    intermediates by that future function alone when they have positive upkeep.

    F. AUXILIARY SUPPORT ESCAPE
    A viable proper intermediate may persist through another function, reuse,
    exaptation, subsidy, drift, or another declared support route.

    G. FINITE-BUDGET RETENTION TRADE-OFF
    If every candidate costs at least mu > 0 and B < |C| mu, full retention is
    infeasible.

    H. BOUNDED GENERATIVE LEVERAGE
    Under the declared injective bounded-reuse encoding, |A| <= |R| d and
    |A| mu <= B d.

    I. NESTED LEARNING-LIKE INTERPRETATION
    The same abstract history -> retention -> transition -> accessibility loop
    is proposed as a cross-scale interpretation. This is not machine-proved
    empirical universality and does not imply literal cognition at every level.

    REQUIRED ADVERSARIAL PROBES

    Try to construct or identify:

    1. positive paid opening with no genuine transition-machinery advantage
       while satisfying the exact upkeep assumptions;
    2. a counterexample to the route-saving theorem under its exact premises;
    3. a hidden dependence between retain/ablate arms that invalidates the
       counterfactual interpretation;
    4. an emergent proper part that obtains the claimed future-function benefit
       without realizing that function under the exact specialization;
    5. a positive-cost candidate set that violates the finite-budget no-go;
    6. unbounded accessibility under uniformly bounded retained cardinality and
       bounded single-unit reuse while satisfying the exact encoding;
    7. a genuine cumulative-evolution system for which the v20 interfaces can
       only be obtained by arbitrary relabeling;
    8. an existing theory that already contains an equal or stronger full
       factorization.

    SEPARATIONS TO PRESERVE

    state dependence != cumulative transfer
    retention != benefit
    retention != truth
    novelty != improvement
    emergence != retention
    possibility != realization
    generability != finite admission
    necessary condition != sufficient condition
    learning-like dynamics != literal psychological learning
    cross-domain analogy != empirical universality
    fixed ambient Lean type != strong unprestatable ontology creation
    machine proof != empirical validation

    FORMAL VERIFICATION

    If Lean can be executed, run from formalization/cumulative-accessibility:

    lake update
    lake exe cache get
    lake build CumulativeAccessibility.AuditAll CumulativeAccessibility.VerificationSurface
    lake env lean CumulativeAccessibility/VerificationSurface.lean

    Search the audited output for sorryAx.

    Distinguish clearly among:
    - source inspection;
    - repository CI status;
    - your own independent Lean execution.

    LITERATURE REVIEW

    Search specifically for architectures combining, in one framework:

    - retained or historical organization as causal state;
    - endogenous modification of transition accessibility;
    - explicit maintenance/resource cost of retained state;
    - retain/ablate or equivalent counterfactual transfer;
    - recursive reuse of retained organization;
    - emergence/assembly constraints;
    - bounded-memory / bounded-reuse limits on open-ended accessibility.

    Do not claim novelty merely because individual components appear under
    different names in different literatures.

    OUTPUT FORMAT

    1. Access report and exact commit SHA
    2. Reconstructed theory in your own words
    3. Formal findings, ordered by severity
    4. Semantic findings
    5. Prior-art findings
    6. Cross-domain mapping findings
    7. Counterexamples / failed probes
    8. Claims that survived your attacks
    9. Minimal revisions needed
    10. Remaining empirical tests

    For each criticism, cite the exact file, definition, theorem, or prose claim.
    Separate theorem defects from modelling burden and empirical uncertainty.

    A successful falsification, narrowing, or prior-art correction counts as a
    useful review result.

## Short reviewer prompt

For a lighter-weight first pass:

> Review the immutable v20 release of albertjanvanhoek/Evolution-by-Emergence as an adversarial scientific reviewer. Resolve v20 to an exact SHA. Read THEORY_CORE_V20.md, FORMAL_THEORY_MAP.md, and the five primary Lean modules RetainedOrganizationCore.lean, TransitionAccessibility.lean, EmergentAssemblyBarrier.lean, TransitionMediatedEmergence.lean, and GenerativeLeverage.lean. Check theorem direction, semantic adequacy, hidden assumptions, equal-or-stronger prior art, and whether the architecture maps non-arbitrarily across distinct cumulative-evolution domains. Treat universality as a hypothesis to falsify, not as established. Report the strongest counterexample or narrowing you can find.