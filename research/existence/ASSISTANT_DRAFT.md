# An existence conjecture: the assistant's draft

> **What this is.** The assistant's own answer to [the brief](BRIEF_EXISTENCE_CONJECTURE.md), written on 9 October 2026 at the author's request. **It is not independent.** The assistant helped write much of the theory it assesses (working agreement 7). The literature in Part 4 is cited from memory, because primary sources could not be opened from its environment, and every item there is unchecked. Reports from other model families are the real test. This draft is a starting point to argue with.
>
> **Superseded in part by report 1** (see [the review](README.md#review-of-report-1-and-how-it-changes-the-assistants-draft)). E1's four features are mechanisms, not necessary conditions of existence. E2 was muddled: the repository's own `not_cheating_wins_under_mild_discount` shows a commons can last without sanctions. The draft is kept as written.

## Part 1. The conjecture

### In plain words
A finite thing that has to keep paying its upkeep, in a world that can move outside what it is fitted for, can last much longer than its reserves allow only if three things hold:
- it hears from outside, through feedback that is faithful and affordable;
- it keeps what it learns;
- it keeps at least one route of correction that it does not control itself.

A shared stock that many such things draw on can last only if taking more than one's interest is detected, and is sanctioned enough, for every taker, the powerful included.

### Precisely
The conjecture has two parts, an individual one and a collective one. **Both state necessary conditions only.**

**Individual part (E1).** Take a configuration with:
- reserve `R`: what it can draw down before its slack runs out (step 1; `InternallyViableAt`, `internalSlack`);
- misfit `μ > 0`: the slack it loses per period once the world has moved outside its fit (step 4; the misfit premise of `AdaptivePersistence`).

Suppose it lasts `T` periods after such a move, and its misfit was **not** covered from outside: no buffer, subsidy or host, as listed in step 4, measured in advance. If `T·μ > R`, then the configuration has all four of:
1. **faithful feedback:** feedback from outside whose errors are rarer than the world's moves (`ListeningCost`: `misleading_feedback_does_not_pay`);
2. **affordable feedback:** listening costs less than the misfit it avoids (`listening_pays_iff`, `unaffordable_listening_fails`);
3. **retention:** what feedback corrects is kept (`mechanisticRatchetVelocity_zero_no_retention`; step 5);
4. **an independent correction route:** at least one route not determined by the configuration itself (`last_route_removal_seals`, `hub_determined_network_inherits_blind_spot`, `correcting_levels_form_interval`; step 8).

**Collective part (E2).** Take a commons drawn on by takers.

Suppose it lasts beyond a horizon stated in advance, without an outside source refilling its principal, while some taker takes more than its interest (step 6; `CommonsInterest`). Then two things hold:
- taking above the interest is detected;
- the sanction, scaled by how often it is detected, covers the largest windfall, for every taker (`detected_sanction_deters`; `deters_all_iff_deters_least_detected`).

**Why "outlasts its reserve".** A configuration that only loses `μ` per period cannot last more than `R/μ` periods; that is the first provable step, in Part 5. So lasting longer is the observable sign that something other than the reserve is at work. The conjecture says what that something must include.

### Scope
- **Which systems:** any configuration that must pay upkeep to persist, whether physical, living, social or artificial. The conjecture is meant to be tested domain by domain (step 8), not assumed.
- **Which environments:** environments whose changes are not bounded in advance by the configuration's fit.
- **Which horizon:** periods measured from the first move outside the fit.

### Form
**Necessary conditions only, and on purpose.**
- **Sufficiency already exists, in models.** `listening_configuration_persists` proves that reliable, costless feedback is enough in the model. The conjecture adds nothing there.
- **Necessity is the claim with content.** It predicts which features every long-lasting configuration that is not covered from outside must have.
- **Why not claim more.** A claim of necessity *and* sufficiency across all substrates would be far stronger than anything the proofs support.

## Part 2. Map to the proofs, and the gaps

| Part of the conjecture | Special cases already proved | Under which assumptions |
|---|---|---|
| A reserve alone runs out | `sealed_configuration_does_not_persist`, `sealed_configuration_fails_on_vortex_ledger`, `sealed_constraint_fails`, `unaffordable_critical_mass_extinct` | The world can move in any direction, and misfit costs slack. "Does not persist" means *in some possible future*, not *in the actual one* |
| Feedback must be faithful and affordable | `listening_pays_iff`, `misleading_feedback_does_not_pay`, `unaffordable_listening_fails`, `listening_configuration_persists`, `learner_in_step` | Errors of the feedback do not depend on the world's course; listening has a fixed cost |
| Retention is needed | `mechanisticRatchetVelocity_zero_no_retention`, `recurringRecursiveEmergence_without_retention_not_cumulative` | The velocity is a product of factors |
| An independent route is needed | `last_route_removal_seals`, `hub_determined_network_inherits_blind_spot`, `correcting_levels_form_interval`, `zero_credence_is_sealed` | Finite networks, a shared layer that fixes every node |
| Dependent nodes last through others | `exchange_lasts`, `defector_falls_after_partner`, `deleting_return_edge_makes_source_decline`, `care_lasts_iff` | Two nodes, or a carer and a cared-for |
| A commons lasts only with detection and sanction | `capture_pays_then_fails`, `not_cheating_wins_over_time`, `tragedy_of_the_commons`, `enough_takers_make_defection_pay`, `detected_sanction_deters`, `deters_all_iff_deters_least_detected` | Fixed regeneration shape; a one-time sanction; a known detection rate |

**Gaps: parts that no current result covers.**
1. **The step from "some possible future" to "the actual one".** Every proof of necessity says a sealed configuration *cannot count on* lasting. The conjecture says it *will not* outlast its reserve, which needs a model of how the world actually moves: a rate of moves outside the fit. This is the largest gap, and it is what makes E1 empirical rather than a theorem.
2. **Feedback whose errors depend on the world's course** (from the "Not yet formal" list).
3. **Detection that can fail, and captured rules** (from the same list).
4. **Explicit time horizons**, needed for the horizon in E2.
5. **That efficiency buys duration**, needed if "outlasting the reserve" is to be credited to a vortex rather than to luck.

## Part 3. What would refute it, and what it does not claim

**What would refute E1:** a configuration that does all of the following:
- it outlasts its reserve (`T·μ > R`) after the world moved outside its fit;
- its misfit was *not* covered from outside;
- it lacks one of the four conditions. For example, it has no route from outside, or it keeps nothing it learns, or every correction it receives is determined by itself.

Candidate tests, from strongest to weakest:
- **Artificial agents,** where everything can be measured. A fixed program or frozen model with a known reserve, put in an environment that shifts outside its fit, with no human patching it. If it outlasts `R/μ` periods, E1 is refuted.
- **Organisms in dormancy, and "living fossils".** These look like counterexamples, but they are predicted escape routes. Dormancy cuts upkeep, so it lowers `μ`. A living fossil sits in a niche that has hardly moved, so its fit never failed. They test whether `μ` and "moved outside the fit" can be measured, not E1 itself.
- **Bet-hedging populations,** for example bacteria that switch type at random. A population that keeps several fits at once *rules less out*. Whether it counts as feedback or as a broader fit must be settled in advance, or the case becomes an escape hatch.

**What would refute E2:** a commons that lasts past its stated horizon, without subsidy, while takers above their interest go undetected or unsanctioned.

**Not yet scientific until fixed in advance:** "covered from outside", "moved outside its fit" and "independent". If any of them can be decided after the outcome, every failure of E1 can be explained away. The conjecture is refutable only with these defined, and measured, before the test.

**What it does not claim:**
- **Persistence is not goodness.** E1 and E2 say what lasts, not what ought to.
- **It supplies no aims or values** (D7, D11). A configuration can meet all four conditions and serve any aim.
- **It does not explain why a commitment is felt as one's own** (D15).
- **It does not present the ledger's definition as a finding.** "Viable while slack is nonnegative" is a definition, and E1 does not rest on it. E1 rests on the measurable inequality `T·μ > R` and on four features that can be observed independently of persistence.

## Part 4. Literature (cited from memory; unchecked)

- **Viability theory (Aubin, 1991).** The set of states from which some control keeps a system viable. E1's "the reserve alone runs out" is the case where no control exists. *Restatement.*
- **Autopoiesis (Maturana and Varela, 1980).** A system that produces its own components. Step 1's ledger is close to this. *Restatement*, made quantitative by slack.
- **Dissipative structures (Prigogine; Nicolis and Prigogine, 1977).** Order kept by a flow of energy. Step 1's "paid from a gradient". *Restatement.*
- **Requisite variety (Ashby, 1956) and the good-regulator theorem (Conant and Ashby, 1970).** A regulator must have variety matching the disturbances, and must model the system. E1's first condition is close to these.
  - *What may be added:* correction is paid from the same budget, so listening must be affordable (`listening_pays_iff`). Feedback must also be more faithful than the world is changeable (`misleading_feedback_does_not_pay`).
- **The free-energy principle (Friston).** It ties persistence to modelling the world. *Close*, but it is formulated in information-theoretic terms, while E1 is stated in a resource ledger. Report 2 on curiosity warned against treating the two as interchangeable.
- **The adjacent possible (Kauffman, 2000).** Close to the vortex (step 5). It is not part of the conjecture, which concerns persistence, not open-ended growth.
- **Ostrom (1990), and Becker (1968) on crime and punishment.** E2 is close to Ostrom's design principles: monitoring, and graduated sanctions that apply to all. The scaling "a sanction detected `k` times in `m` must be `m/k` times as large" is Becker's expected-sanction argument. *Restatement.*
- **"Existence First" (Appendix 26, 30, 31).** The repository's earlier lineage states viability control with "rising safe sets" and a conjecture on amplification through heterogeneity and independence (Appendix 31). E1's fourth condition, the independent correction route, is close to that conjecture.

**What may be new.** The combination:
1. one resource ledger in which the reserve, the misfit, the cost of listening, retention, the independent route and the commons are all measured in the same unit;
2. the measurable trigger `T·μ > R`;
3. the requirement of a correction route the configuration does not control.

The third is the part least covered by Ashby or Conant and Ashby: their regulators need a model of the system, not an independent check on it. This is a hypothesis about novelty, not a finding; a proper search might show prior art.

## Part 5. Lean sketch, and the first provable step

The conjecture is stated as propositions about *observations*, not proved. Lean can fix its shape and check that the terms fit together, but the content is empirical. The sketch compiles in core Lean 4.33 and has no `sorry`. It is not part of the build.

```lean
namespace CumulativeAccessibility
namespace ExistenceConjecture

/-- What the conjecture needs to know about a real configuration.  Every field is
measured, not derived: the conjecture is about real systems, so Lean can fix
its shape but cannot prove it. -/
structure Observed where
  reserve : Int                -- what it can draw down before it fails
  misfit : Int                 -- slack lost per period once the world moves outside its fit (> 0)
  persisted : Nat              -- periods it lasted after the world moved outside its fit
  coveredFromOutside : Bool    -- a buffer, subsidy or host covered the misfit (measured in advance)
  faithfulFeedback : Bool      -- feedback from outside whose errors are rarer than the world's moves
  affordableFeedback : Bool    -- listening costs less than the misfit it avoids
  retains : Bool               -- what feedback corrects is kept
  independentRoute : Bool      -- a correction route not determined by the configuration itself

/-- Lasting clearly longer than the reserve alone allows: more than `reserve / misfit`
periods (written without division). -/
def outlastsReserve (o : Observed) : Prop :=
  o.reserve < (o.persisted : Int) * o.misfit

/-- The individual existence conjecture (necessary conditions only).  Any configuration
that, without being covered from outside, outlasts its reserve after the world has moved
outside its fit, has faithful and affordable feedback, retains what it learns, and keeps
an independent correction route.  Stated as a proposition about observations, not proved. -/
def IndividualConjecture : Prop :=
  ∀ o : Observed, 0 < o.misfit → o.coveredFromOutside = false → outlastsReserve o →
    o.faithfulFeedback = true ∧ o.affordableFeedback = true ∧
    o.retains = true ∧ o.independentRoute = true

/-- What the collective conjecture needs to know about a commons and its takers. -/
structure ObservedCommons where
  periods : Nat                -- how long the commons lasted
  horizon : Nat                -- the explicit horizon the conjecture claims to cover
  takersAboveInterest : Bool   -- some taker took more than its interest
  detected : Bool              -- such taking was detected often enough
  sanctionCoversWindfall : Bool -- sanction × detection rate ≥ largest windfall, for every taker
  subsidized : Bool            -- an outside source refilled the principal

/-- The collective existence conjecture (necessary conditions only).  A commons with
takers above their interest that lasts past the horizon, without outside subsidy, has
detection and a sanction that covers the windfall for every taker, the powerful included. -/
def CollectiveConjecture : Prop :=
  ∀ c : ObservedCommons, c.subsidized = false → c.takersAboveInterest = true →
    c.horizon < c.periods → c.detected = true ∧ c.sanctionCoversWindfall = true

/-- The first provable step: the reserve-only bound.  A configuration that loses
`misfit > 0` per period and gains nothing cannot keep a nonnegative reserve for longer
than `reserve / misfit` periods.  This is what makes `outlastsReserve` a signal that
something other than the reserve is at work. -/
theorem reserve_only_bound (reserve misfit : Int) (n : Nat)
    (hpos : 0 ≤ reserve - n * misfit) : (n : Int) * misfit ≤ reserve := by
  omega

end ExistenceConjecture
end CumulativeAccessibility
```

**Special cases.** If the observation fields are replaced by the model's own definitions, the existing theorems become instances:
- `sealed_configuration_does_not_persist` and `unaffordable_listening_fails` are instances of the individual part, once its fields are read off the model;
- `detected_sanction_deters` and `deters_all_iff_deters_least_detected` are instances of the collective part.

**First provable step.** `reserve_only_bound`: a configuration that only loses `μ` per period keeps a nonnegative reserve for at most `R/μ` periods. It is trivial, but it is what makes `outlastsReserve` meaningful.

**The real next step.** A version with a world that moves at random: out-of-fit moves arrive at a rate, and the expected persistence of a sealed configuration is bounded by its reserve and that rate. That closes gap 1, from "some possible future" to "the expected one". It probably needs a finite probability model, which core Lean can state over finite distributions.

## Part 6. Assessment

**Is the theory ready?**
- **For E1 and E2 as stated:** yes. Every term ties to a proved result, and there is a measurable trigger and a stated way to fail.
- **For a grand conjecture:** no. "Everything that exists does so through a vortex" would absorb every counterexample through buffers, hosts and unchanging niches.

**Before testing, close three gaps:**
1. **The probabilistic step** (gap 1).
2. **Operational definitions fixed in advance** for "covered from outside", "moved outside its fit" and "independent route". Without them, E1 cannot fail.
3. **Detection that can fail** (gap 3), for E2.

**The narrower conjecture I would defend first:** E1 for artificial agents only. There the reserve, the misfit, the feedback, the retention and the correction routes can all be measured and controlled. If E1 fails there, it fails everywhere. If it holds, the next domain is organisms and institutions, where the definitions are harder to fix in advance.

## Part 7. What could not be verified

- **The literature in Part 4.** Every citation and dating is from memory. None was checked against a primary source, and no quotation is given.
- **Whether E1's requirement of an independent correction route is new.** It may already be stated in control theory, in the theory of social epistemology, or in the robustness literature. A search is needed.
- **Independence.** The assistant's reading is not independent of the theory. It helped write `CORE.md` and most of the modules mapped above.
