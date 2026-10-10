> **Report 2 on the biological process, October 2026.** Received from the author as a PDF and kept here as its extracted text. Three changes, following the repository's rules:
> - the product logo at the top is not reproduced;
> - the tracking parameter `?utm_source=…` is removed from every link;
> - nothing else is changed.
>
> Some formulas were cut off at the right margin in the PDF itself, so they are cut off here too. The `filecite…` marker is the research tool's own citation placeholder and does not resolve outside it.

```text
Does a Real Brain Meet the Premises of Evolution
by Emergence?
Main verdict. A real brain does meet several of the biological premises that inspired Evolution by
Emergence (EbE), but not in the clean form implied by the abstract model. The strongest matches are:
continuous energetic upkeep; dependence on other cells, circulation, and the body; reconfiguration during
learning; retention of past changes; and learning signals that ultimately constrain the brain against events
in the world. The weakest links are more revealing. There is no good evidence that finite metabolic capacity
forces forgetting in the specific sense assumed by the ledger; there is evidence for active forgetting, pruning,
and synaptic renormalization, but not that energy scarcity is their general cause. Brains use energetically
efficient codes, but evidence that adult learning literally “selects on cost” is weak. Feedback is also not
simply “from outside”: external events matter, but the signals that alter synapses are computed internally,
gated by neuromodulators, and can be generated during offline replay. Finally, learning is not adequately
described as changing neuron-to-neuron connection weights. It also changes synaptic structure, intrinsic
excitability, gene expression, protein synthesis, neuromodulatory state, glia and myelin; and evidence by
2025–2026 strongly supports at least some adult human hippocampal neurogenesis. The right conclusion is
therefore not that the brain validates EbE. Rather, the brain supplies a real example of a metabolically
maintained, relational, history-dependent adaptive process whose biological implementation is much richer
than the current abstraction. The abstraction survives best if it explicitly treats “connection”, “retention”,
“feedback”, and “cost” as functional variables rather than literal synapses, errors, or ATP. 1

Scope, method, and the theory being tested
Established — repository claim, not biological evidence. The present CORE.md says that EbE “describes
a process, not a substrate,” and now explicitly states that the brain inspired its learning model but has not
been shown to satisfy the premises. Step 8 likewise marks the biological-neural mapping as “to be shown.”
This is an important correction to earlier, stronger wording. The separate biological-process path also labels
the question as unresolved rather than established. D17 records the same conceptual separation between
the abstract process and its particular biological realization.
The biological claim I tested is therefore narrower than “is EbE true?” I asked whether the following
proposed mapping is empirically defensible:

energy/resources → maintenance of a biological configuration → feedback-dependent change → retention → histo
Synthesis. That sequence is recognizable in brains. But several arrows are many-to-many rather than oneto-one, and some of the strongest EbE statements are not biological findings. In particular, “finite budget ⇒
forced forgetting” and “selection on cost ⇒ lower-cost configuration persists” need independent empirical
support rather than being imported from the ledger.
I checked the repository directly, excluding experiments/ as requested. For biology I searched PubMed
and publisher records, prioritizing the original experimental or modelling article rather than review

1

summaries. Where a primary article was accessible only through its abstract, quotations below are explicitly
identified as coming from the abstract. Attwell and Laughlin's 2001 energy-budget article is itself a
quantitative synthesis/model based on earlier physiological measurements, not a direct experiment; I
therefore treat it as a foundational model and supplement it with empirical metabolic work. 2 This was a
broad targeted review, not a preregistered systematic review, so failure to find evidence is not evidence that
none exists.

Premise-by-premise assessment
Overview
EbE premise

What the brain evidence says

Main evidence and
species

Verdict

Upkeep from
a gradient

Neural function requires
continuous metabolic supply.
Signalling consumes most cortical
energy, but there is also substantial
non-signalling/maintenance
demand. A clean fraction
specifically for “maintaining
connections” is not known.

Attwell & Laughlin:
rodent-based
quantitative budget;
Hyder et al.: human/rat
energy-budget analysis;
human metabolic
measurements. 3

Met broadly;
specific
synapticmaintenance
claim unclear

Finite
capacity and
forced
forgetting

Synapses undergo downscaling,
elimination, and active forgetting.
But evidence does not establish
that a fixed metabolic budget
generally forces memories or
synapses to be dropped.

Sleep-associated
synaptic depression in
rats; Rac1-mediated
forgetting in flies and
mice; complement/
microglia-mediated
forgetting in mice. 4

Unclear

Existence
through
connections

Developing neurons can depend on
trophic and activity-related signals;
mature brain function depends
deeply on astrocytes,
oligodendrocytes, microglia,
vasculature and body metabolism.
But adult neurons do not generally
die when one synaptic partner
disappears.

Neurotrophin studies in
rodents; astrocytelactate dependence in
rat memory; myelin
studies in mice. 5

Met at system
level; only
partly at
neuron–neuron
level

Selection on
cost

Neural codes can be sparse and
information-efficient, and energy is
a real constraint. What is not
demonstrated is a general withinlifetime mechanism that
preferentially retains a circuit
because it is cheaper.

Fly retina; macaque V1;
metabolic budgets. 6

Unclear / partly
met

2

EbE premise

What the brain evidence says

Main evidence and
species

Verdict

Learning
from
feedback
from outside

External rewards and sensory
consequences strongly shape
learning. Dopamine can encode
reward prediction errors. But the
plasticity signal itself is internally
computed, and learning also occurs
during replay, sleep, self-generated
exploration and internal regulation.

Primate dopamine;
human and animal
plasticity; human sleep
consolidation. 7

Met with an
important
qualification

Retention

Learning produces persistent
molecular, synaptic, structural,
circuit and systems-level changes.
Sleep contributes to stabilization
and reorganization.

Mouse structural
plasticity; rat metabolic
support of long-term
memory; human
intracranial sleep
recordings. 8

Met

Upkeep from a gradient
Established. Of the six premises, this one maps most directly onto biology. A living brain cannot maintain
its electrochemical gradients, synaptic transmission, intracellular organization, or cellular integrity without
continuing energy and material throughput. The human brain is unusually metabolically expensive relative
to its mass, although the familiar “about 2% of mass, about 20% of resting energy” should be understood as
an approximate physiological comparison, not a universal constant across ages and conditions.
Comparative metabolic analysis found roughly conserved glucose use per neuron across several rodents
and primates, including humans. 9 Direct human studies show tightly regulated glucose and oxygen use
and adaptation of substrate utilization. 10
Attwell and Laughlin's classic budget estimated rodent grey-matter signalling costs from anatomy and
physiology. In their Discussion, their ranking begins:
“Most demanding are action potentials and postsynaptic potentials…”
They estimated, at their assumed firing rate, that signalling represented roughly three quarters of greymatter energy expenditure, with action potentials and postsynaptic currents dominating. 11 A later
budget using human- and rat-specific physiological and morphological parameters estimated roughly 70%
for signalling and 30% for non-signalling processes in awake resting cortex. 12
That distinction matters for EbE.
Unclear. Neither number is “the cost of keeping connections.” Synaptic maintenance includes membrane
potentials, receptor trafficking, protein turnover, cytoskeletal maintenance, organelle transport, local
translation and glial support, and these categories overlap conventional “signalling” and “housekeeping”
budgets. An experimental study showed, for example, that stable dendritic mitochondrial compartments
fuel local translation during synaptic plasticity; removing the local mitochondrial compartment abolished

3

stimulated synaptic translation and morphological plasticity. 13 A modelling analysis estimated that the
energetic cost specifically associated with synaptic plasticity is much smaller than fast excitatory
transmission, although persistent memories themselves carry ongoing molecular costs. 14
Synthesis. EbE's general premise survives well:
A brain state exists only while a continuing resource flow pays for maintaining and
operating the biological machinery that realizes it.
A stronger claim does not yet survive:
Each learned connection has a definable upkeep cost whose sum creates the brain's
effective capacity ceiling.
I found no empirical whole-brain accounting system that supports that second statement.

Finite capacity and forced forgetting
This is where the biological analogy becomes substantially weaker.
Established. Forgetting is not merely accidental decay. There are active mechanisms that weaken or
remove memory traces.
In Drosophila, Shuai et al. manipulated Rac and found in the Summary that inhibiting Rac prolonged early
memory, while increased Rac activity accelerated memory loss. 15 Comparable manipulations in mice
altered the decay of object-recognition memory, supporting an evolutionarily conserved Rac1-related
forgetting mechanism. 16 In adult mice, Wang et al. found hippocampal microglia engulfing synaptic
material; microglial depletion or inhibition of phagocytosis reduced forgetting. Their Abstract concludes:
“complement-dependent synapse elimination by microglia”
as a mechanism of remote-memory forgetting.

17

Sleep also changes synaptic strength. Vyazovskiy et al. found in rat cortex and hippocampus that AMPAreceptor and phosphorylation measures were higher after wake and lower after sleep, alongside
electrophysiological evidence consistent with net potentiation during wake and depression during sleep. In
the Abstract they write that changes were:
“consistent with synaptic potentiation during wakefulness and depression during sleep.”

18

These findings are broadly compatible with the synaptic-homeostasis idea, although they do not by
themselves prove its stronger claims.
Contested / not established. The missing link is cost ⇒ necessary forgetting. The evidence shows that
brains forget actively, that synaptic strengths are regulated, and that memory systems face interference

4

and saturation. It does not show that the brain reaches an energy-defined repertoire ceiling and therefore
must delete one retained item to keep another.
Indeed, some forgetting mechanisms are better interpreted as maintaining flexibility, controlling
interference, or remodelling memory access than as paying an ATP bill. In rats, experimental manipulation
of adult neurogenesis alters recovery from LTP saturation and memory capacity, suggesting circuit renewal
rather than a simple storage-ledger ceiling. 19
Synthesis. I would therefore change the biological mapping from:

finite energy ⇒ forced forgetting
to the weaker and better-supported:

finite energetic, structural and interference constraints ⇒ pressure for regulated plasticity, stabilization, weakenin
That is still meaningful for EbE, but it is not the same theorem.

Existence through connections
Established. Neural dependence on other cells is real, but scale matters enormously.
During development, neuronal survival can depend on signals received from target tissues and on activity.
In sympathetic neurons, NGF and depolarization act together on survival pathways. The primary paper's
Abstract describes sympathetic neurons as requiring:
“target-derived NGF and neural activity for survival during development.”

20

In vivo TrkB knockout studies in mice produced elevated postnatal neuronal death in several CNS regions
and worsened survival after axotomy. 21 Related TrkB/TrkC experiments gave direct evidence that
neurotrophins are survival factors for specific central neuronal populations. 22
But the adult brain's dependency network extends far beyond neuron-to-neuron synapses. Astrocytes
contribute metabolic substrates. In rats, blocking astrocytic glycogen breakdown or lactate transport
impaired long-term memory and LTP; disrupting neuronal lactate uptake also produced amnesia. 23
Oligodendrocytes and new myelin participate in learning: preventing formation of new oligodendrocytes
impaired acquisition of a novel motor skill in adult mice. 24 Microglia alter synaptic function and spine
density and can participate in both learning and forgetting.
system supplying oxygen and substrates.

25

Above all of these is the neurovascular

Synthesis. At the whole-brain/process level, EbE's relational intuition is strong: a brain is not an
autonomous object paying for itself. It is maintained by circulation, lungs, liver, endocrine regulation, glial
metabolism, immune surveillance and environmental inputs.
At the single-neuron level, the mapping is too strong if “existence through connections” means that the
continuing existence of an adult neuron is conditional on every reciprocal neuronal edge. Adult neurons
routinely survive the loss, creation and turnover of individual synapses. Some neurons survive major

5

deafferentation. The appropriate connection graph for survival is therefore not identical to the synaptic
graph for information processing.
That suggests a useful distinction for EbE:

functional connection  maintenance connection
=  learning connection.

=

Some edges play more than one role, but assuming that they are the same edge hides biology.

Selection on cost
Established. Neural coding often looks efficient. Laughlin's fly-eye experiment found that the response
distribution of first-order visual interneurons matched the distribution of contrasts in natural scenes; his
Abstract states that this lets neurons:
“encode contrast fluctuations most efficiently.”

26

In awake macaques viewing natural scenes, Vinje and Gallant found increased sparseness, selectivity and
decorrelation in V1 when broader contextual inputs were included. Their Abstract says the resulting sparse
representation:
“may be computationally efficient.”

27

Energy-budget analyses also give a biological reason for economy: spikes and synaptic currents are costly.
2

But the inference must stop there. Efficient coding is not the same proposition as EbE's “selection on
cost.” A circuit may be sparse because evolution optimized information transmission under energetic and
wiring constraints. A developmental circuit may be pruned because of activity-dependent competition. A
mature learner may change a connection because it improves reward or prediction. These are different
selection processes at different timescales.
Unclear. I did not find convincing evidence for a general rule of adult learning of the form:

two equally successful representations

⇒

the metabolically cheaper one is preferentially retained.

That would be a real, testable biological prediction of the theory rather than established neuroscience.
The disputed “neural Darwinism” language is therefore unnecessary here. The stronger evidence comes
from efficient coding and metabolic constraint, but that evidence supports cost as a constraint, not yet
cost as a universal within-brain selector.

Feedback from outside
Established. External consequences can provide powerful teaching information.

6

Schultz, Dayan and Montague linked primate midbrain dopamine activity to changes in predicted reward.
Their Abstract describes neurons whose output apparently signals:
“changes or errors in the predictions of future salient and rewarding events.”

28

This is an important match to EbE. What matters is not simply a stimulus but the mismatch between
expected and obtained outcome.
But “feedback from outside adjusts the connections” is biologically too direct. The reward event is
outside the nervous system; the reward-prediction error is not. It is a signal computed by the organism
from an external event, its own prediction, internal state, and neuromodulatory machinery. Plasticity is
further controlled by dopamine, norepinephrine, acetylcholine and inhibitory state. In a placebo-controlled
human motor-learning experiment, agonists and antagonists of these neuromodulatory systems changed
practice-dependent cortical plasticity in opposite directions. 29 Other human pharmacological studies find
strong dose- and receptor-dependent effects, including nonlinear effects. 30
Learning also continues when no new external feedback is arriving. During human NREM sleep, intracranial
recordings reveal coordinated prefrontal, hippocampal and neocortical dynamics consistent with
reactivation and information transfer. 31 In mice, disrupting post-learning reactivation during sleep
disrupts branch-specific formation of new dendritic spines. 32
Synthesis. A more accurate EbE statement would be:
Learning is constrained by consequences and evidence that ultimately come from
beyond the representation being changed, but the teaching signals that alter the brain
are generated and routed by the brain-body system itself.
That retains the important epistemic point—an internal model cannot make reality conform to itself—
without claiming that every plasticity update is delivered directly from outside.

Retention
Established. This premise is very well supported, but retention is not a single mechanism.
Learning can stabilize and create dendritic spines. In mice learning a whisker-based localisation task,
Kuhlman et al. found that spine formation increased early in training and predicted later performance; their
Abstract reports:
“Preexisting spines were stabilized and new persistent spines were formed.”

33

Motor learning and subsequent sleep can produce branch-specific new spines. 32 Long-term memory also
depends on molecular synthesis and metabolic support: blocking astrocytic lactate provision in rat
hippocampus spared short-term memory but impaired long-term memory. 23 At a larger scale, sleeprelated hippocampal–neocortical interactions provide a plausible systems-level route for redistributing
retained information. 34

7

Synthesis. “Retention” is therefore a useful substrate-neutral word. But in a biological brain it should
denote a family of processes:

retention = {synaptic efficacy, structure, excitability, molecular state, myelin, circuit organization, systems reorga
That is broader than “weights are kept.”

Where a real brain is unlike the current model
The sentence about connections is directionally right but biologically too narrow
The current CORE.md says:
“In a human brain, learning works mainly by changing the connections between neurons, not
by adding or replacing neurons.”
There are two separate questions here.
Established. For most adult human learning, there is no evidence that the brain rebuilds itself by replacing
large populations of neurons. Ordinary skill and memory acquisition clearly involve plasticity within an
overwhelmingly pre-existing neural architecture. Thus the word “mainly” saves part of the sentence.
But “changing connections between neurons” understates what changes.
In mice, learning changes dendritic spine number and stability. 35 New oligodendrocytes and myelin are
causally required for at least some motor-skill acquisition. 36 Astrocytic energy delivery is causally
required for long-term memory in rat hippocampus. 23 Human pharmacological work shows that
neuromodulatory systems strongly alter learning-related plasticity. 29 Gene expression, local protein
synthesis and mitochondrial positioning also participate in durable synaptic change. 37
So the biological “configuration” is more than a matrix of synaptic weights.

Adult human neurogenesis can no longer simply be dismissed
This literature changed substantially between 2018 and 2026.
Contested historically. Sorrells et al. examined post-mortem and surgical material and reported that
young neurons fell steeply during childhood and were undetectable in their adult samples. Their Abstract
concluded that adult dentate-gyrus neurogenesis:
“does not continue, or is extremely rare, in adult humans.”

38

In the same year, Boldrini et al. reported the opposite from healthy human autopsy tissue aged 14–79,
identifying progenitors and thousands of cells with immature-neuron markers. 39 The disagreement was
partly methodological, including tissue fixation, marker interpretation and the difficulty of proving cellular
birth from static human tissue.

8

Established by stronger recent evidence, with functional uncertainty remaining. In 2025, Dumitru et
al. used single-nucleus RNA sequencing, Ki67 staining and computational identification across human
hippocampi from birth to adulthood. They reported proliferating neural progenitor cells in adults and
localized progenitors to the dentate gyrus. 40 In 2026, an independent multiomic Nature study identified
molecular signatures across the adult human neurogenic trajectory and analysed their relation to ageing,
cognitive resilience and Alzheimer's disease. 41
These studies make the categorical claim “adult human brains do not add neurons” untenable.
They do not show that adding neurons is a major substrate of everyday human learning. That causal
functional link remains much less secure than in rodents.

Artificial neural networks are analogous at a much higher level than the wording
suggests
Established. Artificial networks and brains both contain interconnected units whose effective interactions
can change through learning. Beyond that abstraction, standard deep-learning training and biological
learning differ greatly.
Backpropagation computes credit through an engineered objective and backwards error propagation.
Lillicrap et al.'s review notes that strict backpropagation has historically been considered biologically
problematic, particularly because cortical feedback pathways do not obviously carry the required errors in
the required form. 42 Computational research shows that relaxed schemes such as random feedback
alignment can learn, but this is evidence about algorithms, not evidence that cortex uses those algorithms.
43

Brains also differ from conventional artificial networks in ways directly relevant to EbE: they learn online
while acting; their “weights” are not the only mutable state; they have recurrent dynamics,
neuromodulation, structural plasticity, glial metabolism, changing myelin and continual molecular turnover;
and their objective is not supplied as a single scalar loss.
Synthesis. The safe commonality is therefore:
Both biological and artificial neural systems can acquire capacities through retained
changes in the effective organization of a connected network.
The statement “artificial neural networks were built on this idea” is historically reasonable at a loose level.
The implication that their learning mechanism mirrors cerebral learning is not.

What EbE currently leaves out
Several omissions are not defects if EbE is deliberately abstract. They become defects only if biological
claims are inferred from the abstraction.

9

Established: the brain has multiple interacting plasticity substrates and timescales. Synaptic strength,
synaptic structure, intrinsic excitability, neuromodulators, gene expression, protein turnover, astrocytes,
microglia, oligodendrocytes and myelin can all affect learning or retention. 44
Established: offline processing matters. Sleep can reorganize and stabilize traces without fresh sensory
feedback. 45
Established: biological cost is multidimensional. ATP is important, but so are oxygen delivery, glucose
availability, molecular precursors, space, synaptic interference, toxicity, heat removal and temporal
constraints. 46
Synthesis: there is no obvious single cerebral scalar corresponding to EbE's slack = uptake − upkeep .
A scalar ledger is useful mathematically, but the brain is closer to a constrained vector system. Energy
surplus cannot necessarily compensate for loss of oxygen delivery, protein synthesis capacity or a specific
trophic signal. This parallels EbE's own later multidimensional treatment of care reserves better than its
simplest ledger.
Synthesis: “external feedback” and “internal update” should be separated. Reality constrains the eventual
success of a model; the immediate teaching signal is normally an internal biological event.
Synthesis: the model also needs a distinction among stability, adaptation and learning. A regulated variable
can return to baseline without retaining any information about the disturbance. Calling all such loops
learning would make the theory too broad to discriminate anything.

Where “learning process” stops: kidney versus immune system
The contrast requested in B3 turns out to be useful because it exposes a definitional problem.

The kidney is adaptive, but ordinary renal regulation is not obviously learning
Established. Kidneys respond dynamically to environmental and bodily changes. High dietary salt alters
renal expression of transport and signalling molecules in mice. 47 After unilateral nephrectomy, the
remaining human kidney increases function and grows. In one clinical series, GFR in the remaining
functioning kidney rose markedly after surgery; other cohorts document compensatory hypertrophy. 48
That is adaptation and regulation.
It is not automatically learning.
Synthesis. A useful operational boundary is:
A system has learned when past interaction leaves a retained internal change such
that, with the same present input, its future response differs because of that past
interaction.

10

Under that test, simple homeostasis does not qualify. A thermostat is not learning merely because it
corrects temperature. If its controller changes after past errors and retains the change, it may qualify.
The kidney undoubtedly undergoes retained remodelling—for example after nephrectomy—but that does
not by itself establish a feedback-selected representation or an improved response to recurrence of the
same challenge. Calling all long-lasting physiological adaptation “learning” would make the category nearly
synonymous with plasticity.
So:
Verdict for ordinary kidney regulation: not met as a learning process, though particular forms of renal
remodelling could meet a sufficiently broad definition.

The adaptive immune system is a much cleaner non-neural example
Established. Adaptive immunity has a striking feedback-plus-retention architecture. Antigen exposure
changes the relative abundance and molecular properties of responding lymphocyte clones; somatic
hypermutation generates variants; affinity-based selection changes the repertoire; and long-lived memory
cells preserve effects of past encounters.
Human studies show that somatic hypermutation changes the antigen-selected memory-B-cell repertoire.
49 Longitudinal studies after vaccination directly track persistent B-cell clones and continuing affinity
maturation. After yellow-fever vaccination, memory populations persisted and affinity maturation continued
for months. 50 Following SARS-CoV-2 mRNA vaccination, antigen-specific germinal-centre B cells persisted
for months and their descendants populated memory and plasma-cell compartments. 51 Seasonal
influenza vaccination likewise produced persistent germinal-centre lineages whose later antibodies had
increased affinity and breadth. 52
Synthesis. In some ways this is a cleaner biological instantiation of EbE's simple learning loop than the
brain:

generate variation → external challenge → differential success → retain successful variants.
The physical mechanism is completely different from synaptic learning. That strengthens the case for
separating abstract process from substrate—the central move of D17—while simultaneously warning that
“connections between neurons” cannot be foundational to the general theory.
The boundary also becomes clearer:

regulation changes output; learning changes the retained rule/state that produces future output.
That is a sharper criterion than simply “responds to feedback.”

11

How the premises could actually be tested
These are Synthesis / proposed tests, not established assays of EbE. The key is to formulate tests that
could make the mapping fail rather than merely illustrate it.

Premise

Measurement

Energetic
upkeep

Cerebral glucose/
O₂ use, ATPsensitive reporters,
local mitochondrial
demand, synaptic
protein turnover;
combine with
longitudinal circuit
structure

Finite
capacity →
forgetting

Existence
through
connections

Manipulate
energetic/resource
margin
independently of
interference; track
learned items,
spine turnover and
forgetting
Selectively
withdraw trophic
input, afferent
activity, glial
support or
vascular support
while tracking cell
and circuit survival

Unit / species

What would
support it

What would count
against the
proposed EbE
mapping

Human PET/MRS
where possible;
rodents for
cellular causality

Persistent circuit
states have
measurable
maintenance
requirements;
reducing available
energetic margin
selectively
compromises
maintenance/
plasticity

Stable learned
configurations
prove effectively
independent of
relevant
metabolic/
material
maintenance over
the tested interval

Approaching a
Mouse
longitudinal twophoton +
behavioural
memory tasks

Mainly rodents;
organoids as
complementary
model

12

measurable
resource ceiling
increases selective
weakening/
removal, and
restoring resources
relaxes that
pressure

Particular
maintenance
relations prove
necessary for
continued survival/
function

Forgetting/
pruning tracks
interference or
task value but not
resource pressure
after those are
controlled

The designated
“dependent”
biological unit
persists normally
after removal of
the supposed
maintenance
relation

Unit / species

What would
support it

What would count
against the
proposed EbE
mapping

Selection on
cost

Create two circuit
solutions with
matched
behavioural
performance but
different measured
ATP/spike cost;
follow
consolidation and
long-term
recruitment

Animal learning /
closed-loop
optogenetics

Lower-cost solution
becomes
preferentially
stabilized when
utility is matched

Retention shows
no preference for
lower metabolic
cost, or follows
reward/
information alone

External
correction

Independently
vary actual
environmental
prediction error,
reward prediction
error and
internally
generated replay

Monkeys/rodents
with dopamine
recordings;
human
behavioural/
neuroimaging
studies

Learning follows
externally anchored
discrepancies even
when internal
expectation is
controlled

Equivalent
durable adaptive
learning emerges
without any
present or
historically
grounded
external
constraint

Persistent
performance
change covaries
causally with
persistent biological
reconfiguration

Durable learned
change occurs
while all
candidate
retained
biological states
return fully to prelearning state

Premise

Measurement

Retention

Longitudinal spine/
myelin/molecular
imaging plus
behaviour; sleep
manipulation and
re-test

Rodents; selected
human imaging/
intracranial
studies

Two tests are especially important.

A direct test of “cost selects”
EbE's most distinctive biological prediction may not be that brains consume energy—that is trivial—but that
cost affects which equally useful learned configuration survives.
A clean experiment would train animals to solve one task via two alternative neural strategies engineered to
have equal behavioural reward but measurably different spike/ATP demand. Modern closed-loop neural
methods could bias one or the other strategy. After equal acquisition, remove the bias and observe which
representation consolidates.

13

Under an EbE-inspired hypothesis:

UA ≈ UB ,

CA < CB

⟹

P (retain A) > P (retain B).

Failure of that inequality across well-powered experiments would directly weaken the proposed “selection
on cost” mapping.

A direct test of “finite budget forces forgetting”
Vary three things independently:

metabolic margin,

interference,

new-learning load.

If EbE's ledger mechanism is biologically important, low metabolic margin should increase forgetting or
synaptic elimination even at fixed interference and learning load, and increasing available margin should
partly rescue it.
If forgetting is instead explained almost entirely by interference, relevance and active circuit remodelling,
then the simple budget-to-forgetting mechanism would be rejected.

A test of what “outside” means
Present identical sensory information while manipulating whether it predicts an externally consequential
outcome. Separately generate internal replay of the same sequence. Measure dopamine, relevant synaptic
plasticity and later behaviour.
The likely biological answer is not “external wins, internal loses.” Rather, past external encounters train
internal models, and internal replay can then cause further change. That would support a revised EbE
account in which external reality anchors correction, while feedback signals need not physically
originate outside the brain at the moment learning occurs. 53

Proposed correction to CORE.md
The present sentence is:
“In a human brain, learning works mainly by changing the connections between neurons, not
by adding or replacing neurons.”
I would change it. Not because its central intuition is entirely wrong, but because it encourages the reader
to identify learning with synaptic weights and now understates both glial/circuit plasticity and adult
hippocampal neurogenesis.

Suggested replacement
Synthesis — recommended text:

14

In an adult human brain, much learning reconfigures an already existing network
rather than replacing its neurons wholesale. Synaptic strength and structure are
important parts of that reconfiguration, but they are not the whole of it: learning also
involves changes in intrinsic excitability, neuromodulation, gene expression and protein
synthesis, glial metabolism, oligodendrocytes and myelin, and probably limited
addition of new neurons in the adult hippocampus. How much adult-born neurons
contribute to ordinary human learning remains unresolved. The abstraction used here
is therefore retained organization, not literally a matrix of synaptic weights.
That wording is supported by learning-related spine changes in mice, causal involvement of new
oligodendrocytes in mouse motor learning, astrocytic metabolic involvement in rat memory, human
neuromodulatory effects on cortical plasticity, and increasingly strong evidence for adult human
hippocampal progenitors/neurogenesis. 54
I would also modify the next idea in the paragraph. CORE.md currently reduces the loop to external
feedback adjusting connections and retained changes becoming the basis for later learning. A biologically
safer version would be:
The abstract loop is feedback, reconfiguration and retention. In a brain, evidence and
consequences from the world constrain learning, but the signals that change neural
tissue are generated through the brain's own sensory, neuromodulatory and recurrent
machinery; some further reorganization occurs offline during sleep and replay.
That distinction is more than wording. It prevents epistemic externality—the fact that the world ultimately
decides whether a prediction works—from being confused with mechanistic externality—the false claim
that the signal doing synaptic modification must itself come directly from outside. 55
I would leave the newer caveat immediately following this passage largely intact. The current CORE.md is
appropriately explicit that “the brain is where the model of learning came from, not something the theory
has been shown to describe.” This research supports keeping that sentence.

What the biological comparison teaches EbE
Synthesis. The exercise strengthens D17 more than it strengthens the original neural analogy.
The strongest common process is not:

neuron + synapse + error signal.
It is:

maintained organization + history-dependent reconfiguration + selective retention + continued environmental con
That description fits nervous systems without claiming that nervous systems implement the current ledger
literally. It also allows the adaptive immune system to instantiate essentially the same abstract sequence
using cell proliferation, somatic mutation and clonal selection rather than synaptic plasticity. 56

15

Four lessons seem particularly important.
First, “connection” has to be typed. A synaptic edge transmits information. A capillary supplies
metabolites. An astrocyte-neuron relation can supply fuel. A neurotrophic relation can support survival. An
oligodendrocyte changes conduction. Treating all of them as one edge may be useful in a highly abstract
graph, but a theorem whose meaning depends on removal of a particular edge needs to state what kind of
dependence that edge represents. 57
Second, retention is more fundamental than weights. The immune comparison makes this especially
clear. What matters abstractly is that the effect of a past encounter survives and alters future possibilities. In
a neural system that retained organization can reside in several biological substrates; in immunity it can
reside in clonal populations, receptor sequences and long-lived cells. 58
Third, “feedback from outside” should probably become “externally anchorable feedback.” A brain can
learn overnight from internally replayed traces, but those traces originally arose from interaction. The
distinction aligns well with EbE's later epistemic work: internal processing can propagate or reorganize
evidence; it cannot by itself certify that its model corresponds to the world. The biological evidence does not
prove that philosophical claim, but it shows why “outside feedback” cannot simply mean an exogenous
teaching pulse at every update. 34
Fourth, the strongest unproved biological step is precisely where EbE may have something testable
to add: cost. Neuroscience already knows the brain has an energy budget. It already knows codes can be
sparse. It already knows forgetting and synaptic elimination occur. What is not established is the distinctive
causal chain:

configuration costs less → has greater surplus → is preferentially retained → funds greater future plasticity.
That should be treated as a hypothesis, not as part of the neuroscientific origin story.

Final premise verdicts
On the exact B1 question:
• Upkeep from a gradient — MET, for the broad metabolic premise; unclear for the claimed cost of
maintaining learned connections specifically. 2
• Finite capacity and forced forgetting — UNCLEAR. Finite constraints and active forgetting are
established; energetic necessity for forgetting is not. 59
• Existence through connections — MET at the organism/brain-support-network level, PARTLY
MET at the neuronal level. The biological network is much richer than synapses. 60
• Selection on cost — UNCLEAR. Efficient coding supports energetic constraint, not a universal
retention-by-cheapness rule. 61
• Learning from external feedback — MET WITH QUALIFICATION. World-derived evidence and
consequences matter, but the teaching machinery is internal and learning can continue offline. 53
• Retention — MET. It occurs across several biological substrates and timescales rather than as one
kind of synaptic “weight storage.” 62

16

What I could not verify
I could not verify a credible experimental estimate of the fraction of total human brain energy used
specifically to maintain learned synaptic connections. Published energy budgets divide expenditure into
signalling and broad non-signalling categories; those are not equivalent to retained-connection upkeep.
2

I could not verify that metabolic scarcity is a general causal reason why memories must be forgotten. Active
forgetting, synaptic elimination and sleep-associated synaptic weakening are experimentally supported, but
the proposed energy-ledger causation remains a hypothesis. 63
I could not verify a general experimental result showing that, during adult learning, two functionally
equivalent neural solutions are selected according to their metabolic cost. Efficient-coding results are
compatible with that proposition but do not establish it. 61
I could not verify that adult human hippocampal neurogenesis makes a quantitatively important
contribution to ordinary human learning. The 2025 and 2026 studies greatly strengthen the evidence that
adult progenitors and a neurogenic trajectory exist; they do not provide the causal behavioural experiment
possible in animals. 64
I could not verify that the brain implements ordinary machine-learning backpropagation. Modern work
instead asks whether biologically available processes could approximate useful aspects of credit
assignment. 65
Finally, I found no reason to use “neural Darwinism” as evidence for EbE's cost-selection premise. It is
possible to make the relevant comparison using much better established work on metabolic constraints,
efficient coding, activity-dependent survival, plasticity and active forgetting without relying on that more
controversial framing.
The attached QALY paper from the earlier health-measurement work is not relevant evidence for this
biological-process question and was not used in the assessment. fileciteturn0file0
The overall result is therefore a fairly sharp one: the brain supports EbE's abstract feedback–retention
picture better than it supports the particular biological story from which that picture was originally
derived. The most defensible move is not to make the abstract model more brain-like. It is to make the
origin story more biologically exact while keeping the abstraction substrate-neutral. D17's separation of
those two levels is consequently strengthened by the evidence.

1
2
3
11 An Energy Budget for Signaling in the Grey Matter of the Brain - David Attwell, Simon B.
Laughlin, 2001

https://journals.sagepub.com/doi/abs/10.1097/00004647-200110000-00001

Molecular and electrophysiological evidence for net synaptic potentiation in wake and
depression in sleep | Nature Neuroscience
4

18

63

https://www.nature.com/articles/nn2035

17

5
20 60 Depolarization and neurotrophins converge on the phosphatidylinositol 3-kinase-Akt pathway to
synergistically regulate neuronal survival - PubMed

https://pubmed.ncbi.nlm.nih.gov/10477751/
6

26

61

A simple coding procedure enhances a neuron's information capacity - PubMed

https://pubmed.ncbi.nlm.nih.gov/7303823/
7

28

53

55

Schultz, Dayan & Montague (1997)

https://www.gatsby.ucl.ac.uk/~dayan/papers/sdm97.html
8

33

35

54

62

Structural plasticity within the barrel cortex during initial phases of whisker-dependent

learning.
https://pubmed.ncbi.nlm.nih.gov/24760867/
9 Scaling of brain metabolism with a fixed energy budget per neuron: implications for neuronal activity,
plasticity and evolution - PubMed

https://pubmed.ncbi.nlm.nih.gov/21390261/
10

Blood lactate is an important energy source for the human brain - PubMed

https://pubmed.ncbi.nlm.nih.gov/19337275/
12

Evaluating the gray and white matter energy budgets of human brain function - PubMed

https://pubmed.ncbi.nlm.nih.gov/28589753/
13

37

Spatially Stable Mitochondrial Compartments Fuel Local Translation during Plasticity - PubMed

https://pubmed.ncbi.nlm.nih.gov/30612742/
14

Metabolic constraints on synaptic learning and memory - PubMed

https://pubmed.ncbi.nlm.nih.gov/31365284/
15

Forgetting Is Regulated through Rac Activity in Drosophila - ScienceDirect

https://www.sciencedirect.com/science/article/pii/S0092867409016304
16

Hippocampal Activation of Rac1 Regulates the Forgetting of Object Recognition Memory - PubMed

https://pubmed.ncbi.nlm.nih.gov/27593377/
17

25

59

Microglia mediate forgetting via complement-dependent synaptic elimination - PubMed

https://pubmed.ncbi.nlm.nih.gov/32029629/
19

Adult Neurogenesis Conserves Hippocampal Memory Capacity - PubMed

https://pubmed.ncbi.nlm.nih.gov/29986876/

TrkB signaling is required for postnatal survival of CNS neurons and protects hippocampal and motor
neurons from axotomy-induced cell death - PubMed
21

https://pubmed.ncbi.nlm.nih.gov/9133385/

TrkB and TrkC neurotrophin receptors cooperate in promoting survival of hippocampal and cerebellar
granule neurons.
22

https://pubmed.ncbi.nlm.nih.gov/8918886/
23

44

57

Astrocyte-neuron lactate transport is required for long-term memory formation - PubMed

https://pubmed.ncbi.nlm.nih.gov/21376239/
24

36

Rapid production of new oligodendrocytes is required in the earliest stages of motor-skill learning.

https://pubmed.ncbi.nlm.nih.gov/27455109/

18

27

Sparse coding and decorrelation in primary visual cortex during natural vision.

https://pubmed.ncbi.nlm.nih.gov/10678835/
29

Modification of practice-dependent plasticity in human motor cortex by neuromodulators - PubMed

https://pubmed.ncbi.nlm.nih.gov/16221926/

Dosage‐dependent non‐linear effect of l‐dopa on human motor cortex plasticity - Monte‐Silva - 2010 The Journal of Physiology - Wiley Online Library
30

https://physoc.onlinelibrary.wiley.com/doi/abs/10.1113/jphysiol.2010.190181

Bidirectional prefrontal-hippocampal dynamics organize information transfer during sleep in
humans | Nature Communications
31

34

45

https://www.nature.com/articles/s41467-019-11444-x
32

Sleep promotes branch-specific formation of dendritic spines after learning - PubMed

https://pubmed.ncbi.nlm.nih.gov/24904169/
38

Human hippocampal neurogenesis drops sharply in children to undetectable levels in adults | Nature

https://www.nature.com/articles/nature25975.epdf
39

Human Hippocampal Neurogenesis Persists throughout Aging.

https://pubmed.ncbi.nlm.nih.gov/29625071/
40

64

Identification of proliferating neural progenitors in the adult human hippocampus.

https://pubmed.ncbi.nlm.nih.gov/40608919/
41

Human hippocampal neurogenesis in adulthood, ageing and Alzheimer’s disease | Nature

https://www.nature.com/articles/s41586-026-10169-4
42

65

Backpropagation and the brain | Nature Reviews Neuroscience

https://www.nature.com/articles/s41583-020-0277-3

Meta-learning biologically plausible plasticity rules with random feedback pathways | Nature
Communications
43

https://www.nature.com/articles/s41467-023-37562-1

Brain glucose extraction is fixed at 10% despite twofold variability in resting cerebral blood flow in
healthy humans.
46

https://pubmed.ncbi.nlm.nih.gov/41355185/
47

Dietary salt induces transcription of the prostaglandin transporter gene in renal collecting ducts.

https://pubmed.ncbi.nlm.nih.gov/18579702/
48

Compensatory renal hypertrophia in patients undergoing unilateral nephrectomy.

https://pubmed.ncbi.nlm.nih.gov/897578/
49

56

Somatic hypermutation shapes the antibody repertoire of memory B cells in humans - PubMed

https://pubmed.ncbi.nlm.nih.gov/11489956/
50

Longitudinal dynamics of the human B cell response to the yellow fever 17D vaccine - PubMed

https://pubmed.ncbi.nlm.nih.gov/32152119/
51

Germinal centre-driven maturation of B cell response to SARS-CoV-2 vaccination - PubMed

https://pubmed.ncbi.nlm.nih.gov/34751268/
52

58

Maturation of germinal center B cells after influenza virus vaccination in humans - PubMed

https://pubmed.ncbi.nlm.nih.gov/38935072/

19

```
