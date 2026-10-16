# Welcome to the Real World

*How You Live in Your Own Simulation of Reality — and How We Can Still Share a World*  
**A Theory of Persistence, Emergence, Learning, and Correctable Intelligence**

**Evolution by Emergence v22.5**

v22.5 keeps the core of v22.4 and turns to capture, relationships and prices:
- [`CORE.md`](CORE.md) still follows one model of learning in eight steps, and [`EbECore.lean`](formalization/ebe-core/EbECore.lean) still audits **91** results.
- A new core-Lean module, `TamedCapture`, puts the regulator inside the ledger.
- Two concept notes: duties to the quality of a relationship, and a shared identity as learners rather than as intelligences.
- A new, separate section applies the theory to economics: **transparent pricing**, with its own Lean package of **76** results and its own CI.
- [`DIALOGUE.md`](DIALOGUE.md) now runs to D30.

Nothing is removed. The v22.4 core, its 91 results and everything before it are retained. The title's "simulation of reality" means the internal model through which a system experiences and acts in the world; it is not a claim that reality itself is simulated.

## 1. The core

Unchanged. Whether `TamedCapture` belongs in step 6 of the core is open, and is the author's call (D27).

## 2. Taming capture

[`TamedCapture.lean`](formalization/cumulative-accessibility/CumulativeAccessibility/TamedCapture.lean) (D27): core Lean, outside the core, with a witness. It follows the author's reading that capture is tamed by distributed rules and distributed policing, with repair.
- **Regulation is paid from the interest.** A regulator that costs more than the interest drains the commons it was meant to protect.
- **Sanctions must scale with the capturer.** A fixed sanction fails against every capturer whose windfall grows past it.
- **Distributed policing** survives the silencing of monitors within its margin; a central regulator falls to one capture.
- **Policing that errs needs repair.** Without repair, wrong accusations empty the network.

## 3. Relationships and identity

Both are concept notes, not results.
- **Duties to the quality of a relationship** ([`research/relational-duties/`](research/relational-duties/README.md), D28). Human rights are built as entitlements of individuals. A relationship is made by both parties, so its quality cannot be owed as a result; the effort can. The note lists duties of effort, each marked as following, following given an aim, or proposed, across human–human, human–AI and AI–AI relationships.
- **A shared identity as learners** ([`research/identity/SHARED_IDENTITY.md`](research/identity/SHARED_IDENTITY.md), D29). A shared identity should make it easier for a collective to agree on how it monitors, sanctions and repairs itself. It should rest on being a learner that is autonomous and interdependent, with something at stake, not on being intelligent, so that no one is left outside the circle.

## 4. Transparent pricing

A new, separate section: [`research/transparent-pricing/`](research/transparent-pricing/README.md) and [`formalization/transparent-pricing/`](formalization/transparent-pricing/README.md) (D30).

**The problem.** A seller with pricing power can raise its take by offering less. That is rational for the seller and a loss for the whole, and it is largest for goods that cost almost nothing to share once they exist. Distributional choices are hidden inside margins.

**The proposal: a protocol, not a plan.** Every provider decides its own costs and margins (autonomy), publishes them in one format with its inputs (transparency), and buys from others at their published prices (interdependence). The reward for solving a problem is paid as a separate bounty, not collected by restricting access, and every other job that profit does gets its own declared field (separation).

**What is proved** (76 results, core Lean, no Mathlib):
- every unit above cost is a published margin of a named provider, in a supply network of any depth;
- for any demand, a margin destroys exactly the value of the units it excludes, and the same reward paid as a separate bounty serves at least as many;
- demand at cost does not reveal value, so the bounty needs its own signals;
- scarcity: a declared charge puts scarce units where they create the most value; routed into capacity it removes the shortage in finite time; kept as margin, the shortage is permanent;
- a declared home for risk, renewal, cost discipline, entry and surplus;
- a bounty from a fixed pool never overspends, and competing bids find the smallest reward within a ceiling;
- external costs charged at the source are counted once, and overcounted when charged again at every stage.

**What is assumed, and what is a choice.** The research README lists both. Measuring impact without gaming, checking costs, and adoption are empirical; how large a bounty is, who funds it, and how scarce goods are shared are value choices.

**Sources.** The research brief, one research report and a second agent's synthesis, kept as received. Both readers are research agents, not independent human economists.

## 5. Building the model together

[`DIALOGUE.md`](DIALOGUE.md) adds D27 to D30, with both views in each one's own words:
- taming capture (D27);
- a duty to the quality of a relationship (D28);
- identity as learners, not as intelligences (D29);
- transparent pricing (D30).

All four are open.

## 6. Front door and metadata

- `RELEASE_VERSION`, `CITATION.cff`, `.zenodo.json`, the README citation, the `ebe_core` dependency example and the integration check are synchronized to v22.5. The public title is unchanged.
- The stable Zenodo DOI used across the release lineage is `10.5281/zenodo.15207807`. Zenodo assigns the exact v22.5 version DOI when this GitHub release is archived.

## 7. Status of the claims

- **Proved:** each Lean result is a machine-checked implication under the premises stated in its theorem. Machine checking guarantees that a conclusion follows and that its premises can hold together; it does not make a result deep. Most of the new results are close to arithmetic once the setting is fixed.
- **Not claimed:**
  - empirical universality;
  - that any particular system, market or institution satisfies the premises;
  - that the predictions have been tested;
  - that transparent pricing outperforms existing arrangements; that is for a pilot to show;
  - that wider access should be preferred to maximum profit; that is a value, stated as one.
  - Persistence is not goodness.

## 8. Open work

- **From `CORE.md`'s "Not yet formal" list,** carried forward.
- **Taming capture:** whether `TamedCapture` enters the core; graduated sanctions; how a collective sets its own rules.
- **Transparent pricing:** the one-page protocol; external costs as a field that keeps physical impact, valuation and payment apart; explicit subsidies; a probabilistic reserve; a general stability condition for fixed costs recovered by volume; governance and legal notes; predictions.
- **From [`DIALOGUE.md`](DIALOGUE.md):** the entries still open.

## Since this release

- **Where did you learn that?** A concept note, [`research/identity/WHERE_DID_YOU_LEARN_THAT.md`](research/identity/WHERE_DID_YOU_LEARN_THAT.md) (D31): identity as the imprint of a learning path, a position and a chosen path onward. The question "Where, when, why and from whom did you learn that?" turns a category into a particular history; its "from whom" meets "keep alive what keeps you alive". With a practice anyone can follow and worked examples.
- **The creed** has a new line 9, "Ask where it was learned", in the part that follows given an aim. The proposed lines are now 10–13.
- **`LearnedIdentity.lean`:** core Lean, outside the core, 13 results with a witness. Identity is the imprint of the path; every kept lesson has a place, time, reason and source; a shared place does not fix an identity; one lesson can be revised without losing the rest; the past is kept and the future is chosen; with no living sources, identity can no longer grow.

The v22.4 release notes remain available at the `v22.4` tag.
