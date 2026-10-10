# Report 3: Milinkovic & Aru's biological computationalism and Evolution by Emergence

> Received from the author as a PDF on 10 October 2026: a deep-research report by a model of another family (OpenAI). Kept as its extracted text. Citation markers and link tracking parameters are removed. The two formulas and the table did not survive text extraction; they are rebuilt here from the extracted text, with no change to their content. Reviewed in [../README.md](../README.md) and entry D21 of [DIALOGUE.md](../../../DIALOGUE.md).

## Executive summary

**Synthesis — main verdict.** Milinkovic and Aru's *On biological and artificial consciousness: A case for biological computationalism* is best understood as a substrate-sensitive challenge to the empirical instantiation of Evolution by Emergence (EbE), not as a competing theory of persistence. Their strongest overlap with EbE is unusually direct: both put energetic constraint, maintenance cost, changing organization, and dependence among interacting components near the center of the explanation rather than treating them as implementation details. Milinkovic and Aru argue that metabolic scarcity helped shape the organization of the brain; EbE formalizes a more abstract claim in which a configuration has slack equal to uptake minus maintenance, and can reinvest that slack in further response and reconfiguration.

But the paper also exposes an important limitation in EbE's present mathematics. Much of the EbE ledger is single-scale and additive: whole slack is the sum of part slack, and pure internal transfers cancel. Milinkovic and Aru's central biological claim is almost the converse at the implementation level: brain function arises from bidirectional interactions among scales, continuous and discrete processes, fields, morphology, metabolism, and circuitry, such that a clean decomposition into independent levels may lose causal structure.

That does not invalidate EbE. CORE.md already explicitly says the theory describes a process rather than a substrate, and that whether a real brain satisfies its premises remains to be shown. EbECore.lean likewise states that its machine-checked results prove conditional implications, not that real systems satisfy the assumptions. The productive response, therefore, is not to make EbE biological. It is to make the boundary between substrate-neutral process, substrate-specific realization, and claims about consciousness much sharper.

My strongest recommendation is to add a multiscale, boundary-explicit extension of the ledger. The existing additive theory would then appear as the separable limiting case. That would turn Milinkovic and Aru from a potential objection into a concrete source of tests.

## What Milinkovic and Aru actually claim

**Established.** The paper is Borjan Milinkovic and Jaan Aru, "On biological and artificial consciousness: A case for biological computationalism," *Neuroscience & Biobehavioral Reviews* 181 (2026), article 106524, first available online 17 December 2025, DOI 10.1016/j.neubiorev.2025.106524. It is a review and theoretical proposal, not an experimental demonstration of a new consciousness mechanism. [1] The uploaded version is the publisher's article.

Their argument has three layers that need to be kept separate.

**Established — neurobiology.** Brains are metabolically expensive, neurons perform substantially richer computations than simple point neurons, continuous electrochemical variables coexist with discrete spikes, and local electric fields can influence neural activity. Attwell and Laughlin's energy-budget analysis estimated that action potentials and postsynaptic glutamatergic effects account for much of signaling expenditure in rodent gray matter and argued that energetic cost favors efficient neural codes and wiring. [2] Hasenstaub and colleagues experimentally and computationally found evidence that ion-channel configurations can minimize energy expenditure subject to functional constraints. [3] Human cortical dendrites exhibit nonlinear dendritic action potentials. [4] Models of realistic pyramidal neurons require considerably deeper artificial networks than point-neuron approximations to reproduce their input-output mapping. [5] Weak endogenous-scale electric fields can alter and entrain neuronal activity in experimental preparations. [6]

Milinkovic and Aru assemble these observations into the proposition that metabolic limitation does more than constrain a pre-existing computation. In §3.1, p. 6, they describe energy constraint as "not merely a boundary condition but a driving principle of neural organisation." Figure 2 on p. 8 illustrates their intended architecture: metabolic regulation at cellular scales, synaptic and ephaptic interactions, local-field dynamics, and large-scale brain activity form an interacting continuum rather than a stack of independent computational layers.

**Synthesis — biological computationalism.** They infer from those facts that biological computation is characterized by at least three coupled properties: metabolic embedding; scale-inseparable interaction among molecular, cellular, population and whole-brain processes; and hybrid continuous/discrete computation in physical time. Their Figure 3 on p. 11 converts this into a proposed design space for consciousness-relevant artificial systems: hybrid computation, metabolic/energetic embedding across scales, and adaptive coupling between physical structure and dynamics.

**Hypothesis — consciousness.** The further claim—that those biological computational properties are necessary for consciousness—is not established by the evidence reviewed. The authors are appropriately cautious. In §3.4 they say "there is no privileged scale of computation", and later that these features "may constitute necessary conditions for consciousness." "May" matters.

A new human EEG study by Milinkovic and colleagues, published in September 2026, strengthens the empirical multiscale part but also illustrates the caution required. Under propofol and xenon, which abolish conscious report, there was actually more measured emergence in one sense, but it was fragmented and highly variable; ketamine showed less total emergence while preserving some macroscopic organization. The authors explicitly warn against equating the amount of emergence with consciousness. [7] That is highly relevant to EbE: emergence by itself is not the explanatory variable. Organization, persistence, coupling and retained causal structure matter.

## What EbE presently says

**Established — as a formal system.** EbE begins with an accounting interface. `EndogenousBudgetBridge.lean` defines an external gradient, organization-dependent uptake, maintenance demand, and

  slack_t = uptake_t − maintenance_t.

A configuration is internally viable exactly when this slack is nonnegative. A declared fraction of slack can become an endogenous response budget. The module is explicit that the external gradient is supplied as a boundary condition and that its "slack" must not automatically be identified with physical free energy.

CORE.md then builds the broader story: persistence through connections; cost-sensitive selection; reconfiguration in changing environments; feedback and retention; and a "vortex" in which retained improvements can increase slack and widen the future set of affordable changes. It explicitly distinguishes the process from the material that implements it and says that the biological brain inspired the model but has not thereby been shown to instantiate it.

**Established — proved conditional results.** EbECore.lean collects the machine-checked results. Among them are: viability iff internal slack is nonnegative; removal of a return edge can make a supported node decline; under specified assumptions cost selection increases slack; sealed configurations can fail in changing environments while affordable reliable listening can preserve fit; retention can create further access; and a vortex turn can jointly open budget and future search.

At the network level, `NetworkVortexLedger.lean` introduces a particularly important distinction between creation and transfer. Pure transfers sum to zero. They can determine which part survives but cannot increase total network slack. The file proves, under its additive assumptions, that a whole can remain unchanged while a transfer makes one part nonviable. `CommonsVortex.lean` adds stock-and-flow dynamics in which creation, upkeep, return flows and regeneration determine whether both node and commons can persist.

`CuriosityValue.lean`, which sits outside the core, extends the same accounting logic to exploration. An exploration costing K, producing a retained per-period saving s, improves reserve after n periods iff K < ns. Crucially, the file says explicitly that the key empirical premise—better models actually reducing upkeep or misfit—is assumed rather than derived.

That distinction is exemplary. It is also exactly the distinction needed in the comparison with biological computationalism: Lean establishes what follows from the ledger; biology must establish whether the ledger describes the brain.

## Where the two frameworks meet and diverge

| EbE premise | EbE definition/location | Milinkovic & Aru claim / relevant passage | Supporting evidence checked | Verdict |
|---|---|---|---|---|
| Upkeep from a gradient | Slack = uptake − maintenance; viability iff slack ≥ 0 in `EndogenousBudgetBridge`. | Neural organization is profoundly constrained by metabolic expenditure; §3.1 argues energetic scarcity shapes architecture. | Energy-budget modelling and ion-channel energetics support real energetic constraints. [8] | Compatible, but biological mapping needs an explicit boundary. |
| Existence through connections | Reciprocal support and return paths in CORE/EbECore; network parts can depend on transfers. | Brain processes are mutually coupled across cellular, field and larger scales rather than functioning independently. | Ephaptic feedback and complex dendritic interactions show real nonlocal and non-point-neuron coupling. [9] | Compatible, but M&A imply stronger interdependence than EbE currently represents. |
| Learning by reconfiguration | Step 4–5: adaptation changes organization; retained change can alter future accessibility. | Their third design criterion concerns physical circuitry and dynamics changing together across the lifespan. | Neural structural and dendritic complexity establish reconfigurability, but do not test EbE's vortex. [10] | Compatible / uncertain as an empirical instantiation. |
| Retention | Retained intermediates become material for subsequent change; second-order accessibility results in the core. | Evolutionary accretion and persistent structural organization are emphasized, but there is no equivalent formal retention operator. | Paper synthesizes biological literature rather than testing EbE-style cumulative retention. | Uncertain; conceptual similarity only. |
| Additive part ledger | Whole slack equals sum of part slack under additive aggregation; pure transfers cancel. | Scales mutually generate and constrain each other; scale separation can erase relevant causal organization. | Field effects and multiscale anesthesia results make causal cross-scale coupling plausible. [11] | Potential conflict if EbE's additive decomposition is claimed to be biologically complete. |
| Substrate neutrality | CORE says EbE describes a process, not a substrate. | Biological computationalism argues physical realization may matter fundamentally for consciousness. | No current experiment establishes that only substrate-embedded hybrid systems can be conscious. | Compatible for persistence; conflict only if EbE claimed substrate-independence of consciousness. |
| Correction / external feedback | Step 4 and intelligence-specific results require reliable feedback/correction routes. | The paper is about biological computation and consciousness, not epistemic correction or truth tracking. | No direct evidence linking their mechanisms to EbE correction. | Uncertain / orthogonal. |
| Commons | Network-wide balance, regeneration, transfers and capture in `CommonsVortex`. | Metabolic support, glia, extracellular media and shared fields are discussed, but not a commons in EbE's stock-and-return-path sense. | Metabolic and field interactions support shared conditions, not EbE's commons dynamics. | Uncertain; analogy should not be treated as evidence. |

**Synthesis.** The deepest agreement is therefore not "brains prove EbE." It is more modest and more useful:

> The cost of maintaining a computational organization can help determine which organization exists.

Milinkovic and Aru provide biological mechanisms by which that statement can be true. EbE provides a formal accounting language for some consequences once it is true. Neither establishes the other.

The deepest tension concerns decomposition. Suppose a macroscale electric field alters the excitability and therefore the energetic cost of the neurons that generate that field. The field is neither conveniently an external resource nor simply a zero-sum transfer among neurons. It is an emergent collective variable that feeds back on its own constituents. Experiments showing ephaptic effects make this more than a philosophical possibility. [6] In that setting,

  S_whole ≠ Σ_i S_i

unless the interaction term is represented somewhere.

EbE's current theorem that transfers cancel is mathematically sound under its aggregation premises. Milinkovic and Aru suggest that those premises may sometimes be the thing biology violates.

## What I would change in EbE

**Synthesis — keep the core substrate-neutral.** I would not rewrite EbE to say that metabolic, continuous or field-based computation is necessary. That would sacrifice one of its strongest distinctions: the theory describes a candidate abstract process, while instantiation has to be demonstrated separately. CORE.md already says this unusually clearly.

I would instead sharpen three boundaries.

First, distinguish process invariance from implementation invariance:

> The same abstract persistence relation may be instantiated in different substrates. This does not imply that every substrate can instantiate every higher-level property, or that implementation details are causally irrelevant.

That sentence would make it impossible to infer artificial consciousness merely because an AI satisfies an EbE-like learning ledger.

Second, make the accounting boundary explicit. A neuron does not straightforwardly "take energy from the environment." Its ion gradients are maintained by ATP-dependent pumps; ATP production depends on oxygen and metabolic substrate; those depend on glia, vasculature, lungs, circulation and the organism. What looks like an external gradient at one level is maintained organization at another. Milinkovic and Aru's multiscale framing makes this nested dependence especially salient.

Third, introduce a multiscale extension. A minimal formal generalization could be

  S_s(t) = U_s(t) − M_s(t) + Σ_{r≠s} C_{r→s}(t),

where s indexes scale and C_{r→s} is the effect of organization at scale r on effective slack at scale s. The important new case is when

  Σ_s Σ_{r≠s} C_{r→s} ≠ 0.

Then cross-scale organization is not a pure redistribution. It changes effective capacity or cost.

**Hypothesis.** A useful new EbE conjecture would be that biologically relevant coarse-graining can itself be a form of "creation": an organization at one scale changes the feasible dynamics or maintenance burden at another. That is much closer to Milinkovic and Aru's biological claim than simply saying that parts exchange resources.

The first Lean step should be deliberately modest: generalize `NetworkVortexLedger` with an explicit interaction term and prove that the existing transfer-cancellation theorems are recovered when the cross-scale interaction sum is zero. That would preserve all current results as a separable special case rather than replacing them.

A second later extension could replace a single scalar reserve with several non-substitutable constraints—energy, material, bandwidth, temperature or time. EbE already moves in this direction in `CareTransfer`, where a surplus in one reserve dimension does not automatically offset a deficit in another. This may be more biologically realistic than interpreting every cost as one universal energetic currency.

## Tests that could separate the claims

**Hypothesis — metabolic slack test.** Measure an adaptive task while experimentally varying the energy available to neural computation within a physiologically safe range. Record metabolic expenditure, plastic change and subsequent learning capacity. EbE's biological mapping predicts that, if the response/search budget really derives from metabolic slack, reductions in usable margin should reduce affordable reconfiguration or its rate. Milinkovic and Aru predict something stronger: chronic energetic constraint should influence which computational organization emerges, not merely how quickly a fixed architecture operates. Their claim would be weakened if large changes in energetic constraints altered speed but left multiscale architecture and adaptive organization essentially invariant. The energy dependence of neural signaling makes the premise plausible, but does not already establish this prediction. [8]

**Hypothesis — cross-scale intervention test.** Preserve ordinary synaptic input-output statistics as far as experimentally possible while selectively disrupting a candidate cross-scale route such as ephaptic field coupling, astrocytic metabolic coupling or a characteristic mesoscale oscillatory interaction. Milinkovic and Aru predict that removing such coupling can destroy computational properties not recoverable merely by matching local spike statistics. A simple substrate-neutral EbE ledger predicts no special consequence unless the intervention changes feedback, retention, uptake, upkeep or future accessibility. Existing field experiments establish that such coupling can influence neuronal dynamics, but not that it is necessary for consciousness. [6]

**Hypothesis — matched artificial systems test.** Compare a conventional digital ANN with an analog, mixed-signal or fluidic/iontronic system on the same adaptive problem under a matched energy budget and information supply. Measure task performance, energy per successful adaptation, retention, recovery after perturbation and whether earlier retained organization lowers the cost of later adaptation. EbE predicts the relevant advantage should be expressible through better uptake, lower upkeep, cheaper search or greater retained accessibility, regardless of substrate. Milinkovic and Aru's stronger view predicts an additional advantage from physical-time, multiscale, hybrid organization itself.

The cleanest formal test is even simpler. Add non-additive cross-scale coupling to the ledger and ask which theorems survive. If all of EbE's important persistence results survive after replacing additive decomposition with interaction-sensitive accounting, biological computationalism mainly enriches the implementation. If core network results fail except in the separable limit, Milinkovic and Aru have identified a genuine boundary of the present theory.

There is also a useful negative prediction. EbE should not predict consciousness from vortex membership. A kidney, immune system, firm, artificial learner or ecosystem could conceivably satisfy some EbE persistence conditions without thereby being conscious. Milinkovic and Aru's paper makes this separation more important, not less. Their theory is explicitly trying to explain what kind of physical computation might matter to consciousness; EbE is trying to describe conditions under which configurations persist and accumulate organization.

## Search, evidence limits, and primary sources

**Established — search method.** I read the uploaded publisher PDF of Milinkovic and Aru, including its argument, Figures 2 and 3, conclusions and references. I checked its bibliographic record independently in PubMed. [1] I then read the current repository versions of `CORE.md`, `EbECore.lean`, `EndogenousBudgetBridge.lean`, `NetworkVortexLedger.lean`, `CommonsVortex.lean`, and `CuriosityValue.lean`. I independently checked several primary studies central to the biological argument: energetic cost, dendritic computation, ephaptic coupling and the now-published 2026 anesthesia/multiscale study. [12]

This was not a line-by-line audit of every reference in Milinkovic and Aru. In particular, their sections on computability, Tarski hierarchies, real-number computation, neuromorphic hardware and fluidic computation make additional claims that would warrant a dedicated mathematical and engineering review before being incorporated into EbE. Their leap from continuous physical computation to limitations of digital approximation is also stronger than the neurobiological evidence alone establishes. The experimental sources show that brains use continuous, field-mediated and metabolically constrained processes; they do not prove that a sufficiently different digital or synthetic implementation could not reproduce the relevant causal organization.

Likewise, the 2026 anesthesia paper is informative but not a proof of the biological-computationalist thesis. Its most interesting finding for EbE may actually be negative: more measured "emergence" did not simply mean more consciousness. What mattered was the organization of emergent dynamics. [7] That is consistent with EbE's own movement away from emergence as a magic word toward explicit ledgers, retention, accessibility and causal consequences.

**Primary sources and links.**
- Milinkovic, B. & Aru, J. (2026), *Neuroscience & Biobehavioral Reviews* 181:106524, DOI 10.1016/j.neubiorev.2025.106524. [1]
- Attwell, D. & Laughlin, S.B. (2001), "An energy budget for signaling in the grey matter of the brain," DOI 10.1097/00004647-200110000-00001. [2]
- Hasenstaub, A. et al. (2010), "Metabolic cost as a unifying principle governing neuronal biophysics," DOI 10.1073/pnas.0914886107. [3]
- Gidon, A. et al. (2020), "Dendritic action potentials and computation in human layer 2/3 cortical neurons," DOI 10.1126/science.aax6239. [4]
- Beniaguev, D., Segev, I. & London, M. (2021), "Single cortical neurons as deep artificial neural networks," DOI 10.1016/j.neuron.2021.07.002. [5]
- Anastassiou, C.A. et al. (2011), "Ephaptic coupling of cortical neurons," DOI 10.1038/nn.2727. [13]
- Fröhlich, F. & McCormick, D.A. (2010), "Endogenous electric fields may guide neocortical network activity," DOI 10.1016/j.neuron.2010.06.005. [14]
- Milinkovic, B. et al. (2026), "Emergent multiscale organisation of neural dynamics fragments in anaesthesia," DOI 10.1162/IMAG.a.1364. [7]

**Synthesis — bottom line.** Milinkovic and Aru strengthen the motivation for EbE's most concrete idea—organization has a maintenance price, and that price can shape what organization is possible—while challenging the simplest way of bookkeeping it. Their paper suggests that in brains the interesting unit may not be a node with an independently measurable upkeep, but a nested set of processes whose costs and capacities are partly generated by their coupling across scales. EbE can accommodate that without giving up substrate neutrality, provided substrate neutrality means the same abstract questions can be asked across substrates, not the substrate never matters.

That distinction is, in my view, the most important thing this paper teaches EbE.

## Notes

- [1] On biological and artificial consciousness: A case for biological computationalism. https://pubmed.ncbi.nlm.nih.gov/41419099/
- [2], [8], [12] An energy budget for signaling in the grey matter of the brain. https://pubmed.ncbi.nlm.nih.gov/11598490/
- [3] Metabolic cost as a unifying principle governing neuronal biophysics. https://pubmed.ncbi.nlm.nih.gov/20616090/
- [4], [10] Dendritic action potentials and computation in human layer 2/3 cortical neurons. https://pubmed.ncbi.nlm.nih.gov/31896716/
- [5] Single cortical neurons as deep artificial neural networks. https://pubmed.ncbi.nlm.nih.gov/34380016/
- [6], [9], [11], [13] Ephaptic coupling of cortical neurons. https://pubmed.ncbi.nlm.nih.gov/21240273/
- [7] Emergent multiscale organisation of neural dynamics fragments in anaesthesia. https://pubmed.ncbi.nlm.nih.gov/42761966/
- [14] Endogenous electric fields may guide neocortical network activity. https://pubmed.ncbi.nlm.nih.gov/20624597/
