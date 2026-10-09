# Kwalitijd (8 October 2026)

A 30-minute talk in Dutch for a general audience, by Albert Jan van Hoek, about quality of life, looking ahead, and choosing together. It tells the story of this repository from the angle of the author's own work as a health economist and public health modeller.

| File | What it is |
|---|---|
| [Kwalitijd.pptx](Kwalitijd.pptx) | The final version as presented, with speaker notes and timings per slide |
| [Kwalitijd.pdf](Kwalitijd.pdf) | The same slides as a PDF, for reading on GitHub (rendered with LibreOffice, so fonts may differ slightly) |
| [figuren/](figuren/) | The author's scripts for the TTO, standard gamble and EQ-5D-5L figures, and his speaker notes for them |

## The storyline

1. **One cone.** Every mind looks ahead through a cone: what it can measure, model and try to affect (Michael Levin's *cognitive light cone*). Inside your cone, what you see feels like the whole of reality.
2. **Cones together.** Science looks back to the Big Bang and climate models look a century ahead because many cones are joined. But cones do not add up by themselves: ten people repeating one source see one thing.
3. **Why we think formally about health.** In Seattle in 1962, seven citizens chose who would get dialysis, partly by judging people's "worth". The answer since then has been to make choices explicit and checkable: the idea behind the QALY (Klarman and colleagues, 1968), the time trade-off (Torrance, 1970), evidence from trials (Cochrane, 1972), the EQ-5D (1990), the Dutch EQ-5D-5L tariff (2016). A model joins cones: evidence, values and costs, with its assumptions on the table. The world is not linear: exponential growth, herd effects, thresholds.
4. **Quality of life.** At 65, Dutch life expectancy rose from 1981 to 2025, but still more than a third of the remaining years are not in good health (figures below). The QALY counts time multiplied by quality.
5. **Measuring it.** The time trade-off, the standard gamble, the EQ-5D-5L and the Dutch tariff, and a price per QALY (Zorginstituut reference values of €20,000–€80,000). "We measure health, not anyone's worth": the lesson of Seattle.
6. **The future.** The instrument measures the body inside the cone, not the cone itself: it assumes that we see where we are going. "Healthy and well, walking towards the cliff."
7. **Hope.** Modelling together is living together (Dewey: democracy as "a mode of associated living"). Six entry requirements for anyone who contributes to our shared cone, people and models alike:
   - be honest;
   - admit mistakes;
   - listen without obeying;
   - keep your own view;
   - give more than you take;
   - the same rules for everyone.
8. **Join in.** An invitation to take part in Infectieradar, the RIVM's participatory surveillance of infections, which the author leads. Participants fill in a short questionnaire each week ("Had je klachten van een infectie? Ook 'nee' telt mee"), so that infections are also seen in people who do not go to their GP. The slide has a link and a QR code to [infectieradar.nl](https://www.infectieradar.nl).
9. **The next possibility.** "Geld koopt geen behandeling die nog niet bestaat." Taking part produces knowledge, knowledge makes new interventions possible, those produce healthy years, and healthy people can contribute again: "en dat opent de volgende mogelijkheid". This works only if the gain is shared, which brings the talk back to the price of a healthy year:
   - *Winst nemen*: when the price rises to the threshold per QALY, we buy healthy years but do not gain them, if the same money would have bought as much health elsewhere. The threshold then works as a bounty.
   - *Winst delen*: reach as many people as possible, at a price close to the cost. The gain stays with all of us and pays for the next step.
10. **Close.** "Samen, als we eerlijk zijn over wat we zien en durven toe te geven wat we fout zagen, kijken we generaties vooruit en navigeren we de toekomst. Kwalitijd."

## How it connects to the repository

| In the talk | In the repository |
|---|---|
| Certainty feels the same as being right | The anchor and "the view from inside", [CORE.md](../../CORE.md) step 8 |
| Cones that copy one source add nothing | The shared-layer blind spot and `correcting_levels_form_interval`, [CORE.md](../../CORE.md) step 8 |
| "We measure health, not anyone's worth" | The equity rules in [HEALTH_OF_INTELLIGENCE.md](../../research/health-of-intelligence/HEALTH_OF_INTELLIGENCE.md) |
| The instrument assumes we see ahead | The starting question of [the health of intelligence](../../research/health-of-intelligence/README.md) |
| The entry requirements | The conduct in [FOR_AI_READERS.md](../../scap-seed/FOR_AI_READERS.md) and the SCAP conditions in [PREDICTIONS.md](../../PREDICTIONS.md) |
| Modelling together is living together | [DIALOGUE.md](../../DIALOGUE.md): how the author and the AI assistant build this model together |
| Money cannot buy a treatment that does not exist yet; taking part opens the next possibility | Step 5, the learning loop, and step 6, the commons, in [CORE.md](../../CORE.md) |
| Taking the gain or sharing it | Capture against contribution (`CommonsCapture`, `CommonsInterest`) in [CORE.md](../../CORE.md) step 6; the author's essays on vaccine pricing, [collective_margin_vaccine_paper_v2.tex](../../Individual_essays/collective_margin_vaccine_paper_v2.tex) and [pricing_crc_streamlined.tex](../../Individual_essays/pricing_crc_streamlined.tex) |

## How it was made

The talk is itself an example of the method it argues for. The author wrote the outline and the storyline. An AI assistant helped articulate it, find the literature and build a first deck. The author then checked the claims against the primary sources: he read the life-expectancy figures from the CBS table himself, and asked where Levin's examples came from. Two claims the assistant had taken from search summaries did not survive that check (see errata below, and entry D6 in [DIALOGUE.md](../../DIALOGUE.md)). The author made the final edits. Slides 21 and 22 (Infectieradar and the next possibility) were added on the day of the talk: the author asked for them, the assistant drafted them, and the author edited them and rewrote the closing line.

## Data: remaining life expectancy at 65

Source: CBS StatLine, *Gezonde levensverwachting; vanaf 1981* (table 71950NED), age 65. Values read from the table by the author.

| | Total | In good perceived health | Not in good health (difference) |
|---|---|---|---|
| Men 1981 | 14.33 | 9.2 | 5.1 |
| Men 2025 | 19.46 | 12.7 | 6.8 |
| Women 1981 | 18.86 | 10.8 | 8.1 |
| Women 2025 | 21.42 | 12.5 | 8.9 |

"Good perceived health" is self-reported, so a year counts as healthy or not. A QALY instead weights each year.

## Errata (kept as presented)

Slides 3 and 23 of the final version were made before the Levin examples were checked against his article:
- **Subtitle of slide 3.** Levin defines the cone as what a system can *measure, model and try to affect*, not "waarnemen, voorspellen" (perceive, predict).
- **The bacterium ("een paar micrometer, een paar minuten").** This is not one of Levin's examples. It came from a third-party summary.
- **The dog ("zijn buurt, een paar dagen").** This was a paraphrase. Levin's examples are in the caption of his figure 2 (p. 9):
  - a **tick** senses and acts only immediately next to itself, with little memory or anticipation;
  - a **dog** has significant memory but cannot be made to care about what happens several miles away or in two weeks;
  - **humans** remember about 10² years and anticipate decades ahead.

  On p. 16 he adds that humans are the only known agents whose horizon reaches beyond their own lifespan.

A corrected wording for slide 3:
- *Teek:* direct naast zich; weinig geheugen, nauwelijks vooruit.
- *Hond:* zijn eigen omgeving; niet wat over twee weken gebeurt.
- *Mens:* decennia vooruit, soms planetair; verder dan het eigen leven.

## Sources

- Levin, M. (2019). The Computational Boundary of a "Self". *Frontiers in Psychology* 10:2688. doi:10.3389/fpsyg.2019.02688
- Alexander, S. (1962). They Decide Who Lives, Who Dies. *Life*, 9 November 1962.
- Klarman, H.E., Francis, J.O. & Rosenthal, G.D. (1968). Cost effectiveness analysis applied to the treatment of chronic renal disease. *Medical Care* 6:48–54.
- Cochrane, A.L. (1972). *Effectiveness and Efficiency.* Nuffield Provincial Hospitals Trust.
- Wagenaar, W.A. & Sagaria, S.D. (1975). Misperception of exponential growth. *Perception & Psychophysics* 18:416–422.
- Versteegh, M. et al. (2016). Dutch Tariff for the Five-Level Version of EQ-5D. *Value in Health*. doi:10.1016/j.jval.2016.01.003
- Zorginstituut Nederland (2015). *Kosteneffectiviteit in de praktijk.*
- Dewey, J. (1916). *Democracy and Education*, chapter 7.
- Vennix, J.A.M. (1996). *Group Model Building.* Wiley.
- Funtowicz, S.O. & Ravetz, J.R. (1993). Science for the post-normal age. *Futures* 25:739–755.
- Landemore, H. (2013). *Democratic Reason.* Princeton University Press.
