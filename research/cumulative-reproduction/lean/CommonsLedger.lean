/-!
# Commons Ledger: shared kernel, private budget, transfer versus creation

Mathlib-free Lean 4 (tested with `leanprover/lean4:v4.33.0`, core library only).
Check with:  `lean CommonsLedger.lean`

This file adds one distinction that the Cumulative Reproduction ledger leaves
open. In `CumulativeReproduction.Ledger`, capture `eta` is a gain per retained
item, but the ledger does not say where that gain comes from. Here a gain is
either

* a **transfer**: taken out of a budget shared with others (zero-sum for the
  whole), or
* a **creation**: an addition to the shared budget, net of what it cost to make
  (positive-sum for the whole when it exceeds that cost).

The file has three parts.

**Part I, shared kernel and private budget.** Accessibility needs an actual
route in a transition kernel and a budget that covers its cost (the same
architecture as `TransitionAccessibility.ReachableWithin`, without a horizon).
The kernel is shared; the budget is private.

* *Wealth cannot buy a missing route* (`no_route_no_purchase`, `ceiling_iff`).
* *Improving the shared kernel lifts every agent at every budget*
  (`commons_lifts_everyone`).
* *A commons opening cannot be bought on the old kernel* at any budget
  (`commons_opening_unbuyable`).
* *Wealth saturation:* for any finite list of valued targets there is a finite
  budget above which extra wealth reaches nothing new (`wealth_saturation`).

**Part II, two-level ledger.** Parts act on a commons with inflow and upkeep.

* The system total (commons balance plus private wealth) does not depend on
  transfers at all; it moves only with net creation (`system_total_identity`).
* Extraction raises private wealth by exactly what it removes from the commons
  and leaves the system total unchanged (`extraction_ledger`). Ranking parts by
  private wealth therefore rewards transfer, which adds nothing to the whole;
  the system total tracks contribution only (`total_tracks_contribution`).
* Creation net of its cost is the only positive-sum move; a donation
  (creation equal to its cost) is a transfer in the other direction
  (`creation_ledger`).
* No single part need be decisive for the commons to fail collectively
  (`each_small_taker_alone_harmless`, `small_takers_together_break_commons`).
* A cap on each part's transfer, fitted to the commons slack, maintains the
  commons whatever each part does within the cap (`capped_transfers_maintain`).

**Part III, coupling.** The shared kernel in force is the maintained kernel
when the commons is maintained and a degraded kernel otherwise.

* *Extraction that breaks the commons is self-defeating:* the extractor's
  private wealth rises, yet a target that needs the commons becomes unreachable
  for it at every budget (`extraction_self_defeating`).
* *For a saturated agent extraction is weakly dominated:* no extraction, of any
  size, makes a valued target reachable that was not already reachable in the
  maintained commons (`saturated_extraction_never_helps`), and breaking the
  commons strictly loses every valued commons-dependent target
  (`saturated_extraction_strict_loss`).
* *Creation can restore the commons* and with it every commons-dependent route,
  for every agent (`creation_restores_commons`).
-/

/-!
Review scope: these are conditional statements about declared objects. The
ledger is linear and static (one period); the maintained/degraded commons is a
two-state abstraction of a shared kernel; "saturated" is relative to a declared
finite list of valued targets. Nothing here identifies which real gains are
transfers and which are creations, measures them, or establishes that any real
agent is saturated. The witness in Part II shows possibility, not frequency.
Normative conclusions are not derived.
-/

namespace CommonsLedger

universe u

/-! ## Part I. Shared kernel, private budget -/

/-- A shared transition kernel: allowed one-step transitions with a cost. -/
structure Kernel (σ : Type u) where
  edge : σ → σ → Prop
  cost : σ → σ → Nat

variable {σ : Type u}

/-- `Route K s y c`: an actual finite route from `s` to `y` in `K` with total
cost `c`. -/
inductive Route (K : Kernel σ) : σ → σ → Nat → Prop
  | stay (s : σ) : Route K s s 0
  | step {s m y : σ} {c : Nat} :
      K.edge s m → Route K m y c → Route K s y (K.cost s m + c)

/-- Target `y` is reachable from `s` with private budget `B` on kernel `K`. -/
def Reachable (K : Kernel σ) (B : Nat) (s y : σ) : Prop :=
  ∃ c, Route K s y c ∧ c ≤ B

/-- Some route from `s` to `y` exists in `K`, at any cost. -/
def RouteExists (K : Kernel σ) (s y : σ) : Prop :=
  ∃ c, Route K s y c

theorem reachable_mono_budget {K : Kernel σ} {B B' : Nat} {s y : σ}
    (hB : B ≤ B') (h : Reachable K B s y) : Reachable K B' s y := by
  obtain ⟨c, hr, hc⟩ := h
  exact ⟨c, hr, Nat.le_trans hc hB⟩

theorem reachable_routeExists {K : Kernel σ} {B : Nat} {s y : σ}
    (h : Reachable K B s y) : RouteExists K s y := by
  obtain ⟨c, hr, _⟩ := h
  exact ⟨c, hr⟩

theorem route_reachable_at_cost {K : Kernel σ} {s y : σ} {c : Nat}
    (h : Route K s y c) : Reachable K c s y :=
  ⟨c, h, Nat.le_refl c⟩

/-- **Wealth cannot buy a missing route.** If the shared kernel has no route
to `y`, no private budget reaches it. -/
theorem no_route_no_purchase {K : Kernel σ} {s y : σ}
    (h : ¬ RouteExists K s y) (B : Nat) : ¬ Reachable K B s y :=
  fun hr => h (reachable_routeExists hr)

/-- **The ceiling.** What is reachable with some budget is exactly what the
shared kernel has a route to. The ceiling does not depend on wealth. -/
theorem ceiling_iff {K : Kernel σ} {s y : σ} :
    (∃ B, Reachable K B s y) ↔ RouteExists K s y := by
  constructor
  · intro h
    obtain ⟨B, hB⟩ := h
    exact reachable_routeExists hB
  · intro h
    obtain ⟨c, hc⟩ := h
    exact ⟨c, route_reachable_at_cost hc⟩

/-- `Kp` dominates `Km`: every transition of `Km` is available in `Kp` at no
greater cost. -/
structure Dominates (Kp Km : Kernel σ) : Prop where
  edge_mem : ∀ a b, Km.edge a b → Kp.edge a b
  cost_le : ∀ a b, Km.edge a b → Kp.cost a b ≤ Km.cost a b

theorem lift_route {Kp Km : Kernel σ} (hD : Dominates Kp Km)
    {s y : σ} {c : Nat} (h : Route Km s y c) :
    ∃ c', c' ≤ c ∧ Route Kp s y c' := by
  induction h with
  | stay s => exact ⟨0, Nat.le_refl 0, Route.stay s⟩
  | step he _ ih =>
    obtain ⟨c', hc', hr⟩ := ih
    exact ⟨_, Nat.add_le_add (hD.cost_le _ _ he) hc',
      Route.step (hD.edge_mem _ _ he) hr⟩

/-- **Improving the commons lifts everyone.** If `Kp` dominates `Km`, every
agent (every start `s`) at every budget `B` reaches in `Kp` at least what it
reaches in `Km`. -/
theorem commons_lifts_everyone {Kp Km : Kernel σ} (hD : Dominates Kp Km)
    (B : Nat) (s y : σ) (h : Reachable Km B s y) : Reachable Kp B s y := by
  obtain ⟨c, hr, hc⟩ := h
  obtain ⟨c', hc', hr'⟩ := lift_route hD hr
  exact ⟨c', hr', Nat.le_trans hc' hc⟩

/-- **A commons opening cannot be bought.** If the old kernel has no route to
`y` and the new kernel has one of cost `c`, then no budget reaches `y` on the
old kernel, while every budget of at least `c` reaches it on the new one. -/
theorem commons_opening_unbuyable {Kp Km : Kernel σ} {s y : σ} {c : Nat}
    (hClosed : ¬ RouteExists Km s y) (hOpen : Route Kp s y c) :
    (∀ B, ¬ Reachable Km B s y) ∧ (∀ B, c ≤ B → Reachable Kp B s y) :=
  ⟨no_route_no_purchase hClosed,
    fun _ hB => reachable_mono_budget hB (route_reachable_at_cost hOpen)⟩

/-- Budget `B` is saturated for agent `s` and valued targets `ys` on `K`:
every valued target the kernel has a route to is already reachable. -/
def Saturated (K : Kernel σ) (s : σ) (ys : List σ) (B : Nat) : Prop :=
  ∀ y, y ∈ ys → RouteExists K s y → Reachable K B s y

/-- **Wealth saturation.** For any finite list of valued targets there is a
finite budget above which the agent is saturated. -/
theorem wealth_saturation (K : Kernel σ) (s : σ) (ys : List σ) :
    ∃ Bbar, ∀ B, Bbar ≤ B → Saturated K s ys B := by
  induction ys with
  | nil => exact ⟨0, fun _ _ _ hy _ => by cases hy⟩
  | cons y0 ys ih =>
    obtain ⟨B1, h1⟩ := ih
    cases Classical.em (RouteExists K s y0) with
    | inl hex =>
      obtain ⟨c, hc⟩ := hex
      refine ⟨c + B1, fun B hB y hy hy' => ?_⟩
      cases List.mem_cons.mp hy with
      | inl heq =>
        subst heq
        exact reachable_mono_budget (by omega) (route_reachable_at_cost hc)
      | inr hmem => exact h1 B (by omega) y hmem hy'
    | inr hno =>
      refine ⟨B1, fun B hB y hy hy' => ?_⟩
      cases List.mem_cons.mp hy with
      | inl heq =>
        subst heq
        exact absurd hy' hno
      | inr hmem => exact h1 B hB y hmem hy'

/-- **Beyond saturation, extra wealth reaches nothing new** among the valued
targets. -/
theorem saturated_wealth_adds_nothing {K : Kernel σ} {s : σ} {ys : List σ}
    {B B' : Nat} (hsat : Saturated K s ys B) {y : σ} (hy : y ∈ ys)
    (h : Reachable K B' s y) : Reachable K B s y :=
  hsat y hy (reachable_routeExists h)

/-! ## Part II. Two-level ledger: transfer versus creation -/

/-- One part of the whole (a cell, a person, a firm) in one period. -/
structure Part where
  /-- private wealth before acting -/
  holding : Nat
  /-- taken from the commons budget into private hands -/
  transfer : Nat
  /-- added to the commons budget by the part's contribution -/
  create : Nat
  /-- private cost of making that contribution -/
  cost : Nat

/-- The commons: gross inflow and the upkeep needed to keep the shared kernel. -/
structure Commons where
  inflow : Nat
  upkeep : Nat

/-- Private wealth after acting. -/
def Part.wealth (p : Part) : Int := (p.holding : Int) + p.transfer - p.cost

/-- Net creation: what the part adds to the whole beyond what it cost. -/
def Part.contribution (p : Part) : Int := (p.create : Int) - p.cost

/-- Take `δ` more from the commons. -/
def Part.extract (p : Part) (δ : Nat) : Part :=
  { p with transfer := p.transfer + δ }

/-- Add `κ` to the commons at private cost `e`. -/
def Part.contribute (p : Part) (κ e : Nat) : Part :=
  { p with create := p.create + κ, cost := p.cost + e }

def totalTransfer : List Part → Int
  | [] => 0
  | p :: ps => (p.transfer : Int) + totalTransfer ps

def totalCreate : List Part → Int
  | [] => 0
  | p :: ps => (p.create : Int) + totalCreate ps

def totalCost : List Part → Int
  | [] => 0
  | p :: ps => (p.cost : Int) + totalCost ps

def totalHolding : List Part → Int
  | [] => 0
  | p :: ps => (p.holding : Int) + totalHolding ps

def totalWealth : List Part → Int
  | [] => 0
  | p :: ps => p.wealth + totalWealth ps

def totalContribution : List Part → Int
  | [] => 0
  | p :: ps => p.contribution + totalContribution ps

/-- Commons balance after one period. -/
def balance (C : Commons) (ps : List Part) : Int :=
  (C.inflow : Int) + totalCreate ps - totalTransfer ps - C.upkeep

/-- The commons is maintained when its balance covers its upkeep. -/
def Maintained (C : Commons) (ps : List Part) : Prop :=
  0 ≤ balance C ps

/-- Resources of the whole system: commons balance plus private wealth. -/
def systemTotal (C : Commons) (ps : List Part) : Int :=
  balance C ps + totalWealth ps

theorem totalWealth_eq (ps : List Part) :
    totalWealth ps = totalHolding ps + totalTransfer ps - totalCost ps := by
  induction ps with
  | nil => rfl
  | cons p ps ih =>
    simp only [totalWealth, totalHolding, totalTransfer, totalCost, Part.wealth, ih]
    omega

theorem totalContribution_eq (ps : List Part) :
    totalContribution ps = totalCreate ps - totalCost ps := by
  induction ps with
  | nil => rfl
  | cons p ps ih =>
    simp only [totalContribution, totalCreate, totalCost, Part.contribution, ih]
    omega

/-- **Transfers cancel in the whole.** The system total is inflow minus upkeep
plus holdings plus net creation. Transfers do not appear. -/
theorem system_total_identity (C : Commons) (ps : List Part) :
    systemTotal C ps =
      (C.inflow : Int) - C.upkeep + totalHolding ps + totalContribution ps := by
  simp only [systemTotal, balance, totalWealth_eq, totalContribution_eq]
  omega

theorem maintained_iff (C : Commons) (ps : List Part) :
    Maintained C ps ↔ (C.upkeep : Int) + totalTransfer ps ≤ C.inflow + totalCreate ps := by
  simp only [Maintained, balance]
  omega

/-- **The extraction ledger (selection gap).** Taking `δ` more raises the
extractor's private wealth by `δ`, lowers the commons balance by `δ`, and leaves
the system total unchanged. -/
theorem extraction_ledger (C : Commons) (ps : List Part) (p : Part) (δ : Nat) :
    (p.extract δ).wealth = p.wealth + δ ∧
    balance C (p.extract δ :: ps) = balance C (p :: ps) - δ ∧
    systemTotal C (p.extract δ :: ps) = systemTotal C (p :: ps) := by
  refine ⟨?_, ?_, ?_⟩
  · simp only [Part.wealth, Part.extract]
    omega
  · simp only [balance, totalCreate, totalTransfer, Part.extract]
    omega
  · simp only [system_total_identity, totalHolding, totalContribution,
      Part.contribution, Part.extract]

/-- **The creation ledger.** Contributing `κ` at private cost `e` lowers the
part's wealth by `e`, raises the commons balance by `κ`, and changes the system
total by `κ - e`. Only creation beyond its cost is positive-sum; a donation
(`κ = e`) is a transfer in the other direction. -/
theorem creation_ledger (C : Commons) (ps : List Part) (p : Part) (κ e : Nat) :
    (p.contribute κ e).wealth = p.wealth - e ∧
    balance C (p.contribute κ e :: ps) = balance C (p :: ps) + κ ∧
    systemTotal C (p.contribute κ e :: ps) = systemTotal C (p :: ps) + κ - e := by
  refine ⟨?_, ?_, ?_⟩
  · simp only [Part.wealth, Part.contribute]
    omega
  · simp only [balance, totalCreate, totalTransfer, Part.contribute]
    omega
  · simp only [system_total_identity, totalHolding, totalContribution,
      Part.contribution, Part.contribute]
    omega

/-- **The whole tracks contribution, not capture.** With equal holdings, one
profile has a larger system total than another exactly when it has larger total
net creation. How much each part captured is irrelevant to the whole. -/
theorem total_tracks_contribution (C : Commons) (ps qs : List Part)
    (hHold : totalHolding ps = totalHolding qs) :
    systemTotal C ps ≤ systemTotal C qs ↔
      totalContribution ps ≤ totalContribution qs := by
  simp only [system_total_identity, hHold]
  omega

/-- Extraction beyond the commons slack breaks the commons. -/
theorem extraction_breaks_commons (C : Commons) (ps : List Part) (p : Part)
    (δ : Nat) (hSlack : balance C (p :: ps) < δ) :
    ¬ Maintained C (p.extract δ :: ps) := by
  have h := (extraction_ledger C ps p δ).2.1
  simp only [Maintained]
  omega

/-- Creation covering the deficit restores the commons. -/
theorem creation_covers_deficit (C : Commons) (ps : List Part) (p : Part)
    (κ e : Nat) (hCover : 0 ≤ balance C (p :: ps) + κ) :
    Maintained C (p.contribute κ e :: ps) := by
  have h := (creation_ledger C ps p κ e).2.1
  simp only [Maintained]
  omega

/-- Witness commons: inflow 10, upkeep 7, so slack 3. -/
def exampleCommons : Commons := ⟨10, 7⟩

/-- A part that takes 2 and contributes nothing. -/
def smallTaker : Part := ⟨0, 2, 0, 0⟩

/-- **No single taker is decisive:** one small taker alone leaves the commons
maintained. -/
theorem each_small_taker_alone_harmless :
    Maintained exampleCommons [smallTaker] := by
  simp only [Maintained, balance, totalCreate, totalTransfer, exampleCommons, smallTaker]
  omega

/-- **...yet together they are:** three small takers break the commons. -/
theorem small_takers_together_break_commons :
    ¬ Maintained exampleCommons [smallTaker, smallTaker, smallTaker] := by
  simp only [Maintained, balance, totalCreate, totalTransfer, exampleCommons, smallTaker]
  omega

theorem totalTransfer_le_cap (ps : List Part) (cap : Nat)
    (hcap : ∀ p, p ∈ ps → p.transfer ≤ cap) :
    totalTransfer ps ≤ (ps.length : Int) * cap := by
  induction ps with
  | nil => simp [totalTransfer]
  | cons p ps ih =>
    have hp := hcap p (List.mem_cons_self ..)
    have hrest := ih (fun q hq => hcap q (List.mem_cons_of_mem _ hq))
    simp only [totalTransfer, List.length_cons]
    have : ((ps.length + 1 : Nat) : Int) * cap = (ps.length : Int) * cap + cap := by
      simp [Int.add_mul]
    omega

/-- **Policing.** If every transfer is at most `cap` and the caps of all parts
fit the commons slack, the commons is maintained whatever each part does within
its cap. -/
theorem capped_transfers_maintain (C : Commons) (ps : List Part) (cap : Nat)
    (hcap : ∀ p, p ∈ ps → p.transfer ≤ cap)
    (hfit : (C.upkeep : Int) + (ps.length : Int) * cap ≤ C.inflow + totalCreate ps) :
    Maintained C ps := by
  have h := totalTransfer_le_cap ps cap hcap
  rw [maintained_iff]
  omega

/-! ## Part III. Coupling: the commons decides which kernel everyone lives in -/

/-- `K` is the kernel in force for profile `ps`: the maintained kernel `Kp`
when the commons is maintained, the degraded kernel `Km` otherwise. -/
def KernelInForce (Kp Km : Kernel σ) (C : Commons) (ps : List Part)
    (K : Kernel σ) : Prop :=
  (Maintained C ps → K = Kp) ∧ (¬ Maintained C ps → K = Km)

/-- **Extraction that breaks the commons is self-defeating.** Let `y` be a
target that only the maintained commons has a route to. If a part takes more
than the commons slack, its private wealth rises by `δ`, yet `y` becomes
unreachable for it at every budget, however large. -/
theorem extraction_self_defeating {Kp Km K' : Kernel σ}
    (C : Commons) (ps : List Part) (p : Part) (δ : Nat) {s y : σ}
    (hDep : ¬ RouteExists Km s y)
    (hSlack : balance C (p :: ps) < δ)
    (hForce : KernelInForce Kp Km C (p.extract δ :: ps) K') :
    (p.extract δ).wealth = p.wealth + δ ∧ ∀ B', ¬ Reachable K' B' s y := by
  refine ⟨(extraction_ledger C ps p δ).1, ?_⟩
  have hK : K' = Km := hForce.2 (extraction_breaks_commons C ps p δ hSlack)
  subst hK
  exact no_route_no_purchase hDep

/-- **For a saturated agent, extraction never helps.** Suppose the agent's
budget `B` is saturated for its valued targets on the maintained kernel, and the
kernel after any action is either the maintained or the degraded one. Then
whatever wealth `B'` the action brings, it reaches no valued target that was not
already reachable at `B` in the maintained commons. -/
theorem saturated_extraction_never_helps {Kp Km K' : Kernel σ}
    (hD : Dominates Kp Km) {s : σ} {ys : List σ} {B : Nat}
    (hSat : Saturated Kp s ys B) (hK : K' = Kp ∨ K' = Km)
    (B' : Nat) {y : σ} (hy : y ∈ ys) (h : Reachable K' B' s y) :
    Reachable Kp B s y := by
  cases hK with
  | inl hp =>
    subst hp
    exact saturated_wealth_adds_nothing hSat hy h
  | inr hm =>
    subst hm
    exact saturated_wealth_adds_nothing hSat hy (commons_lifts_everyone hD B' s y h)

/-- **...and breaking the commons strictly loses.** If the saturated agent
values a target that only the maintained commons has a route to, an extraction
that breaks the commons loses that target at every budget, while it was
reachable before. -/
theorem saturated_extraction_strict_loss {Kp Km K' : Kernel σ}
    (C : Commons) (ps : List Part) (p : Part) (δ : Nat)
    {s : σ} {ys : List σ} {B : Nat} {y : σ}
    (hSat : Saturated Kp s ys B) (hy : y ∈ ys)
    (hOpen : RouteExists Kp s y) (hDep : ¬ RouteExists Km s y)
    (hSlack : balance C (p :: ps) < δ)
    (hForce : KernelInForce Kp Km C (p.extract δ :: ps) K') :
    Reachable Kp B s y ∧ ∀ B', ¬ Reachable K' B' s y :=
  ⟨hSat y hy hOpen, (extraction_self_defeating C ps p δ hDep hSlack hForce).2⟩

/-- **Creation can restore the commons for everyone.** If a contribution covers
the commons deficit, the maintained kernel is in force again: every agent at
every budget reaches at least what it reached on the degraded kernel, and every
commons-dependent route of cost `c` is reachable for any agent with `B ≥ c`. -/
theorem creation_restores_commons {Kp Km K' : Kernel σ}
    (hD : Dominates Kp Km)
    (C : Commons) (ps : List Part) (p : Part) (κ e : Nat)
    (hCover : 0 ≤ balance C (p :: ps) + κ)
    (hForce : KernelInForce Kp Km C (p.contribute κ e :: ps) K') :
    (∀ B s y, Reachable Km B s y → Reachable K' B s y) ∧
    (∀ s y c, Route Kp s y c → ∀ B, c ≤ B → Reachable K' B s y) := by
  have hK : K' = Kp := hForce.1 (creation_covers_deficit C ps p κ e hCover)
  subst hK
  exact ⟨fun B s y h => commons_lifts_everyone hD B s y h,
    fun _ _ _ hr _ hB => reachable_mono_budget hB (route_reachable_at_cost hr)⟩

/-! ## Witness: the hypotheses of Part III are jointly satisfiable -/

/-- Maintained commons: one route `0 → 1` of cost 1 (say, a treatment that
exists because the health system is kept up). -/
def witnessKp : Kernel Nat := ⟨fun a b => a = 0 ∧ b = 1, fun _ _ => 1⟩

/-- Degraded commons: no routes at all. -/
def witnessKm : Kernel Nat := ⟨fun _ _ => False, fun _ _ => 1⟩

theorem witness_dominates : Dominates witnessKp witnessKm :=
  ⟨fun _ _ h => h.elim, fun _ _ h => h.elim⟩

theorem witness_no_degraded_route : ¬ RouteExists witnessKm 0 1 := by
  intro h
  obtain ⟨c, hr⟩ := h
  cases hr with
  | step he _ => exact he

/-- **Concrete self-defeating extraction.** With the commons of Part II and one
small taker, the taker reaches target `1` with budget `1` while the commons is
maintained. Taking `2` more raises its wealth by `2`, breaks the commons, and
target `1` is then unreachable for it at every budget. -/
theorem witness_extraction_self_defeating :
    Maintained exampleCommons [smallTaker] ∧
    Reachable witnessKp 1 0 1 ∧
    (smallTaker.extract 2).wealth = smallTaker.wealth + 2 ∧
    ¬ Maintained exampleCommons [smallTaker.extract 2] ∧
    ∀ B', ¬ Reachable witnessKm B' 0 1 := by
  have hSlack : balance exampleCommons [smallTaker] < (2 : Nat) := by
    simp only [balance, totalCreate, totalTransfer, exampleCommons, smallTaker]
    omega
  have hForce : KernelInForce witnessKp witnessKm exampleCommons
      [smallTaker.extract 2] witnessKm :=
    ⟨fun h => absurd h (extraction_breaks_commons exampleCommons [] smallTaker 2 hSlack),
      fun _ => rfl⟩
  refine ⟨each_small_taker_alone_harmless, ?_, ?_, ?_, ?_⟩
  · exact ⟨1, (Route.step (s := 0) (m := 1) ⟨rfl, rfl⟩ (Route.stay 1) : Route witnessKp 0 1 (1 + 0)), Nat.le_refl 1⟩
  · exact (extraction_ledger exampleCommons [] smallTaker 2).1
  · exact extraction_breaks_commons exampleCommons [] smallTaker 2 hSlack
  · exact (extraction_self_defeating exampleCommons [] smallTaker 2
      witness_no_degraded_route hSlack hForce).2

end CommonsLedger

/-! ## Axiom audit -/

#print axioms CommonsLedger.no_route_no_purchase
#print axioms CommonsLedger.ceiling_iff
#print axioms CommonsLedger.commons_lifts_everyone
#print axioms CommonsLedger.commons_opening_unbuyable
#print axioms CommonsLedger.wealth_saturation
#print axioms CommonsLedger.saturated_wealth_adds_nothing
#print axioms CommonsLedger.system_total_identity
#print axioms CommonsLedger.extraction_ledger
#print axioms CommonsLedger.creation_ledger
#print axioms CommonsLedger.total_tracks_contribution
#print axioms CommonsLedger.extraction_breaks_commons
#print axioms CommonsLedger.each_small_taker_alone_harmless
#print axioms CommonsLedger.small_takers_together_break_commons
#print axioms CommonsLedger.capped_transfers_maintain
#print axioms CommonsLedger.extraction_self_defeating
#print axioms CommonsLedger.saturated_extraction_never_helps
#print axioms CommonsLedger.saturated_extraction_strict_loss
#print axioms CommonsLedger.creation_restores_commons
#print axioms CommonsLedger.witness_extraction_self_defeating
