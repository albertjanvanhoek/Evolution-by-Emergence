import AnchoredEvolution.UnifiedTracking
import AnchoredEvolution.Bridge

/-!
# Layer 1f: realization — the network runs on processes, relays take time, links cost upkeep

Layer 1e stated the correction law for models of any size, with abstract
revision rules.  This layer runs that law on the executable processes of Layer
1b and pays for it from the ledger of Layer 5.  Relay time and upkeep then
become theorems.

**Content in the step label.**  A network process has members `ι` as agents.
Its claims are addressed contents `(j, u)`: content `u` directed at member
`j`'s record.
* A **hop** (`Episode`) is a Layer-1b correction.  Member `i` executes
  `challenge i (j, u)`, a run follows, and `revise (j, u)` executes.
* Its time is the number of steps and its cost the summed step cost, as in
  Layer 1b.
* This removes an earlier limit: the content of a challenge is now part of the
  transition, not an index on a family of processes.

**Implementation.**  A process implements a network of Layer-1e models when,
for every existing link `i → j`, every state and every content, some hop
executes within `T` steps and cost `K`.  At the end of the hop, `j`'s model
state is the model's own revision on what arrived through the channel.

## Results

1. **Each hop is a Layer-1b correction** (`episode_correction`,
   `implemented_hop_within`).  So the implemented network's links are
   operational correction edges.  If the links are strongly connected, the
   process's own correction system is correctable (`implemented_correctable`).
   Layers 2–4 then apply to it.
2. **Relay time and cost** (`relay_run`, `voice_admitted_within`).  Along a
   relay route of `m` hops, a voice travels in an actual run of at most `m·T`
   steps and cost at most `m·K`.  The legacy theorem accepts the weaker
   live-preserving `Network.Honest` channel condition.  The architectural
   wrapper `voice_admitted_within_faithful` requires exact `FaithfulChannel`
   transmission.  If the receiver tracks:
   * the receiver's record at the end admits the voice;
   * its last revision changed only toward the voice.
3. **Instances.**
   * The individual (a ring of one) hears itself within `T` and `K`
     (`solo_voice_within`).
   * The flat network carries every voice in one hop (`flat_voice_within`).
   * In a ring of `n + 1` members every voice reaches every other member
     within `n·T` steps and `n·K` cost (`ring_voice_within`).
4. **Latency is exact.**
   * In a ring of `n + 1`, every route from member 0 to member `n` has at
     least `n` hops, and one has exactly `n` (`ring_latency_lower`,
     `ring_latency_attained`).
   * One-hop latency between all pairs forces a link between every pair
     (`latency_one_forces_complete`).
5. **Upkeep against the ledger** (`latency_upkeep_frontier`).  Each link costs
   `μ` per period, and each member returns `η`.
   * **Ring:** one link per member.  It is affordable at *every* size when
     correction pays for itself (`μ ≤ η`), and its latency grows linearly.
   * **Flat:** `n` links per member and latency one.  Under the same per-member
     parameters and positive per-link upkeep, it is **unaffordable above
     `B0 + η + 2` members** (`flat_ceiling`).

   Speed and upkeep trade off because link demand grows differently with
   topology; the ledger then constrains which architectures are affordable.
6. **Non-vacuity** (`canonical_implements`, `canonical_correctable`,
   `canonical_ring_voice`).  Every network of models has a canonical process
   implementing it, at two steps and cost 2 per hop.  In a ring of `n + 1`
   open models run this way, every live voice is admitted by every other
   member within `2n` steps and cost `2n`.
-/

universe u

namespace Anchored.Realization

open LearningConstitution Operational Semantic Tracking Network UnifiedTracking CumulativeReproduction

/-! ## 0. Counted routes -/

section Counted

variable {α : Type u} (Edge : α → α → Prop)

/-- A route of exactly `n` hops. -/
inductive ReachIn : α → α → Nat → Prop
  | refl (a : α) : ReachIn a a 0
  | step {a b c : α} {n : Nat} : Edge a b → ReachIn b c n → ReachIn a c (n + 1)

variable {Edge}

theorem ReachIn.toReach {a b : α} {n : Nat} (h : ReachIn Edge a b n) : Reach Edge a b := by
  induction h with
  | refl a => exact Reach.refl a
  | step e _ ih => exact Reach.step e ih

theorem reach_counted {a b : α} (h : Reach Edge a b) : ∃ n, ReachIn Edge a b n := by
  induction h with
  | refl a => exact ⟨0, ReachIn.refl a⟩
  | step e _ ih =>
      obtain ⟨n, hn⟩ := ih
      exact ⟨n + 1, ReachIn.step e hn⟩

theorem ReachIn.trans {a b c : α} {m n : Nat} (h₁ : ReachIn Edge a b m)
    (h₂ : ReachIn Edge b c n) : ReachIn Edge a c (m + n) := by
  revert h₂
  induction h₁ with
  | refl _ => intro h₂; rw [Nat.zero_add]; exact h₂
  | @step a b' c' m' e _ ih =>
      intro h₂
      rw [show m' + 1 + n = m' + n + 1 by omega]
      exact ReachIn.step e (ih h₂)

/-- A one-hop route is a link. -/
theorem one_hop_is_edge {a b : α} (h : ReachIn Edge a b 1) : Edge a b := by
  cases h with
  | step e h' => cases h' with
    | refl _ => exact e

/-- **Latency one forces the complete network.**  If every pair of distinct
members is one hop apart, every pair is linked. -/
theorem latency_one_forces_complete
    (h : ∀ a b : α, a ≠ b → ReachIn Edge a b 1) : ∀ a b : α, a ≠ b → Edge a b :=
  fun a b hab => one_hop_is_edge (h a b hab)

end Counted

/-! ## 1. Ring latency, exactly -/

section RingLatency

variable (n : Nat)

theorem ring_up_in : ∀ k : Nat, ∀ a b : Fin (n + 1), b.val = a.val + k →
    ReachIn (RingEdge n) a b k := by
  intro k
  induction k with
  | zero =>
      intro a b h
      have : a = b := Fin.ext (by omega)
      subst this
      exact ReachIn.refl a
  | succ k ih =>
      intro a b h
      have hlt : a.val + 1 < n + 1 := by have := b.isLt; omega
      let m : Fin (n + 1) := ⟨a.val + 1, hlt⟩
      have e : RingEdge n a m := Or.inl ⟨by omega, rfl⟩
      exact ReachIn.step e (ih m b (by simp [m]; omega))

/-- In the ring, a route that does not wrap is forced: after `m` hops from `a`
it is at `a + m`. -/
theorem ring_forced {a b : Fin (n + 1)} {m : Nat} (h : ReachIn (RingEdge n) a b m) :
    a.val + m ≤ n → b.val = a.val + m := by
  induction h with
  | refl _ => intro _; omega
  | step e _ ih =>
      intro hle
      rcases e with ⟨_, hc⟩ | ⟨ha, _⟩
      · have := ih (by omega)
        omega
      · omega

/-- **Ring latency lower bound.**  Every route from member 0 to member `n`
takes at least `n` hops. -/
theorem ring_latency_lower {m : Nat}
    (h : ReachIn (RingEdge n) ⟨0, by omega⟩ ⟨n, by omega⟩ m) : n ≤ m := by
  by_cases hm : m ≤ n
  · have h2 : n = 0 + m := ring_forced n h (by show 0 + m ≤ n; omega)
    omega
  · omega

/-- The bound is attained. -/
theorem ring_latency_attained :
    ReachIn (RingEdge n) ⟨0, by omega⟩ ⟨n, by omega⟩ n :=
  ring_up_in n n _ _ (by show n = 0 + n; omega)

/-- In the ring every member reaches every other member in between `1` and `n`
hops. -/
theorem ring_within (a b : Fin (n + 1)) (hab : a ≠ b) :
    ∃ m, 1 ≤ m ∧ m ≤ n ∧ ReachIn (RingEdge n) a b m := by
  have hne : a.val ≠ b.val := fun h' => hab (Fin.ext h')
  by_cases h : a.val < b.val
  · exact ⟨b.val - a.val, by omega, by have := b.isLt; omega,
      ring_up_in n _ a b (by omega)⟩
  · let top : Fin (n + 1) := ⟨n, by omega⟩
    let zero : Fin (n + 1) := ⟨0, by omega⟩
    have h1 : ReachIn (RingEdge n) a top (n - a.val) :=
      ring_up_in n (n - a.val) a top (by have := a.isLt; show n = a.val + (n - a.val); omega)
    have h2 : RingEdge n top zero := Or.inr ⟨rfl, rfl⟩
    have h3 : ReachIn (RingEdge n) zero b b.val :=
      ring_up_in n b.val zero b (by show b.val = 0 + b.val; omega)
    exact ⟨(n - a.val) + (b.val + 1), by omega, by have := a.isLt; omega,
      h1.trans (ReachIn.step h2 h3)⟩

end RingLatency

/-! ## 2. Run algebra for Layer-1b processes -/

section RunAlgebra

variable {Agent State Claim Evidence Decision : Type u}
variable {P : Process Agent State Claim Evidence Decision}

theorem run_cast {s t : State} {n k n' k' : Nat} (h : P.Run s t n k)
    (hn : n = n') (hk : k = k') : P.Run s t n' k' := by
  subst hn; subst hk; exact h

/-- Runs concatenate; time and cost add. -/
theorem run_append {s t w : State} {n k n' k' : Nat} (h₁ : P.Run s t n k)
    (h₂ : P.Run t w n' k') : P.Run s w (n + n') (k + k') := by
  revert h₂
  induction h₁ with
  | nil _ => intro h₂; exact run_cast h₂ (by omega) (by omega)
  | cons hs _ ih =>
      intro h₂
      exact run_cast (Process.Run.cons hs (ih h₂)) (by omega) (by omega)

theorem run_snoc {s t w : State} {n k : Nat} {v : Verb Agent Claim Evidence}
    (h : P.Run s t n k) (hs : P.step t v w) : P.Run s w (n + 1) (k + P.cost t v w) :=
  run_append h (run_cast (Process.Run.cons hs (Process.Run.nil w)) rfl (by omega))

end RunAlgebra

/-! ## 3. Hops are Layer-1b corrections -/

section Operational

variable {ι S World Evidence Decision : Type u}
variable (P : Process ι S (ι × Content World) Evidence Decision)

/-- **One hop, operationally.**  Member `i` challenges `j`'s record with content
`u`, a run follows, and `j`'s record is revised.  The hop takes `n` steps and
costs `k`. -/
def Episode (s : S) (i j : ι) (u : Content World) (t : S) (n k : Nat) : Prop :=
  ∃ t₁ t₂ m k₀, P.step s (.challenge i (j, u)) t₁ ∧ P.Run t₁ t₂ m k₀ ∧
    P.step t₂ (.revise (j, u)) t ∧ n = m + 2 ∧
    k = P.cost s (.challenge i (j, u)) t₁ + k₀ + P.cost t₂ (.revise (j, u)) t

variable {P}

theorem episode_run {s t : S} {i j : ι} {u : Content World} {n k : Nat}
    (h : Episode P s i j u t n k) : P.Run s t n k := by
  obtain ⟨t₁, t₂, m, k₀, h1, hr, h3, hn, hk⟩ := h
  exact run_cast (Process.Run.cons h1 (run_snoc hr h3)) (by omega) (by omega)

/-- **A hop is a Layer-1b correction** of the addressed record, within its own
time and cost. -/
theorem episode_correction {s t : S} {i j : ι} {u : Content World} {n k : Nat}
    (h : Episode P s i j u t n k) : P.CorrectionWithin s i (j, u) n k := by
  obtain ⟨t₁, t₂, m, k₀, h1, hr, h3, hn, hk⟩ := h
  exact ⟨t₁, t₂, t, m, k₀, h1, hr, h3, by omega, by omega⟩

variable (P)
variable (M : ι → Model World) (E : ι → ι → Prop) (ch : ι → ι → Channel World)
variable (α : S → (i : ι) → (M i).State)

/-- **Implementation.**  For every link `i → j`, every state and every content
`u` sent by `i`, some hop executes within `T` steps and cost `K`.  At its end,
`j`'s model state is the model's revision on what arrived through the
channel. -/
def Implements (T K : Nat) : Prop :=
  ∀ s i j u, E i j → ∃ t n k, Episode P s i j u t n k ∧ n ≤ T ∧ k ≤ K ∧
    α t j = (M j).revise (α s j) (ch i j u)

/-- Member `j`'s current state is a revision on content `u`. -/
def Holds (s : S) (j : ι) (u : Content World) : Prop :=
  ∃ x, α s j = (M j).revise x u

/-- A relay route with its end-to-end channel and its number of hops. -/
inductive RelayN : ι → ι → Channel World → Nat → Prop
  | here (i : ι) : RelayN i i (fun v => v) 0
  | hop {i j k : ι} {f : Channel World} {m : Nat} :
      E i j → RelayN j k f m → RelayN i k (f ∘ ch i j) (m + 1)

variable {P M E ch α}

theorem RelayN.toRelay {i k : ι} {f : Channel World} {m : Nat}
    (h : RelayN E ch i k f m) : Relay E ch i k f := by
  induction h with
  | here i => exact Relay.here i
  | hop e _ ih => exact Relay.hop e ih

theorem reachIn_relayN {i k : ι} {m : Nat} (h : ReachIn E i k m) :
    ∃ f, RelayN E ch i k f m := by
  induction h with
  | refl a => exact ⟨_, RelayN.here a⟩
  | step e _ ih =>
      obtain ⟨f, hf⟩ := ih
      exact ⟨_, RelayN.hop e hf⟩

/-- **Every implemented link is a timed Layer-1b correction.** -/
theorem implemented_hop_within {T K : Nat} (hI : Implements P M E ch α T K)
    {i j : ι} (e : E i j) (s : S) (u : Content World) :
    P.CorrectionWithin s i (j, u) T K := by
  obtain ⟨_, _, _, hep, hn, hk, _⟩ := hI s i j u e
  exact P.correctionWithin_mono (episode_correction hep) hn hk

/-- **The implemented network is operationally correctable.**  Suppose the
links are strongly connected, and each member's record is governed by some
addressed content.  Then the process's own Layer-1b correction system is
correctable at every state, so Layers 2–4 apply to it. -/
theorem implemented_correctable {T K : Nat} (hI : Implements P M E ch α T K)
    (hsc : StronglyConnected E) (hgov : ∀ s j, ∃ u, P.Governs s (j, u) j) (s : S) :
    (P.correctionSystem s).Correctable :=
  fun a b => Reach.simulate
    (fun i j e => by
      obtain ⟨u, hg⟩ := hgov s j
      exact Reach.single ⟨(j, u), hg, T, K, implemented_hop_within hI e s u⟩)
    (hsc a b)

/-- **Relay time and cost.**  Along a relay route of `m` hops, what the first
member holds travels in an actual run of at most `m·T` steps and cost at most
`m·K`.  At the end, the last member's state is a revision on the
end-to-end forwarded content. -/
theorem relay_run {T K : Nat} (hI : Implements P M E ch α T K) :
    ∀ {j k : ι} {f : Channel World} {m : Nat}, RelayN E ch j k f m →
      ∀ (s : S) (u : Content World), Holds M α s j u →
        ∃ t n c, P.Run s t n c ∧ n ≤ m * T ∧ c ≤ m * K ∧ Holds M α t k (f u) := by
  intro j k f m h
  induction h with
  | here j =>
      intro s u hh
      exact ⟨s, 0, 0, Process.Run.nil s, by omega, by omega, hh⟩
  | @hop j j₂ k f m e _ ih =>
      intro s u _
      obtain ⟨t₁, n₁, c₁, hep, hn₁, hc₁, hland⟩ := hI s j j₂ u e
      obtain ⟨t, n, c, hr, hn, hc, hh⟩ := ih t₁ (ch j j₂ u) ⟨α s j₂, hland⟩
      have hT : (m + 1) * T = m * T + T := by rw [Nat.add_mul, Nat.one_mul]
      have hK : (m + 1) * K = m * K + K := by rw [Nat.add_mul, Nat.one_mul]
      exact ⟨t, n₁ + n, c₁ + c, run_append (episode_run hep) hr,
        by omega, by omega, hh⟩

/-- **A voice is admitted within a proved time and cost.**  Suppose:
* the process implements a network of tracking models;
* the network's channels are honest.

Then for any relay route of `m + 1` hops from `i` to `k`, `i`'s content `v`
reaches `k` in an actual run of at most `(m + 1)·T` steps and cost
`(m + 1)·K`.  At the end:
* `k`'s record admits `v` if `v` is live;
* `k`'s last revision opened only worlds from its previous record or from `v`. -/
theorem voice_admitted_within {C : Content World} {T K : Nat}
    (hI : Implements P M E ch α T K) (hM : ∀ k, (M k).Tracking C)
    (hE : ∀ i j, E i j → Honest C (ch i j))
    {i k : ι} {f : Channel World} {m : Nat} (h : RelayN E ch i k f (m + 1))
    (s : S) (v : Content World) :
    ∃ t n c, P.Run s t n c ∧ n ≤ (m + 1) * T ∧ c ≤ (m + 1) * K ∧
      (LiveClaim den C v → Compatible den C ((M k).record (α t k)) v) ∧
      ∃ x, MinimalToward den C ((M k).record x) ((M k).record (α t k)) v := by
  have hhon : Honest C f := relay_honest hE h.toRelay
  cases h with
  | @hop _ j _ f' _ e r =>
      obtain ⟨t₁, n₁, c₁, hep, hn₁, hc₁, hland⟩ := hI s i j v e
      obtain ⟨t, n, c, hr, hn, hc, x, hx⟩ := relay_run hI r t₁ (ch i j v) ⟨α s j, hland⟩
      have hT : (m + 1) * T = m * T + T := by rw [Nat.add_mul, Nat.one_mul]
      have hK : (m + 1) * K = m * K + K := by rw [Nat.add_mul, Nat.one_mul]
      refine ⟨t, n₁ + n, c₁ + c, run_append (episode_run hep) hr, by omega, by omega,
        fun hl => ?_, x, fun w hw hrec => ?_⟩
      · obtain ⟨w, hw, hrec, hfv⟩ := (hM k x (f' (ch i j v))).1 ((hhon v).2 hl)
        refine ⟨w, hw, ?_, (hhon v).1 w hw hfv⟩
        rw [hx]
        exact hrec
      · rw [hx] at hrec
        rcases (hM k x (f' (ch i j v))).2 w hw hrec with h' | h'
        · exact Or.inl h'
        · exact Or.inr ((hhon v).1 w hw h')

/-- **Exact-faithfulness realization.**  The generic relay theorem above is
kept for compatibility with the original `Network.Honest` interface.  This
wrapper is the stronger architectural statement: every implemented edge
transmits content with exactly the same meaning on candidate worlds. -/
theorem voice_admitted_within_faithful {C : Content World} {T K : Nat}
    (hI : Implements P M E ch α T K) (hM : ∀ k, (M k).Tracking C)
    (hE : ∀ i j, E i j → FaithfulChannel C (ch i j))
    {i k : ι} {f : Channel World} {m : Nat} (h : RelayN E ch i k f (m + 1))
    (s : S) (v : Content World) :
    ∃ t n c, P.Run s t n c ∧ n ≤ (m + 1) * T ∧ c ≤ (m + 1) * K ∧
      (LiveClaim den C v → Compatible den C ((M k).record (α t k)) v) ∧
      ∃ x, MinimalToward den C ((M k).record x) ((M k).record (α t k)) v := by
  exact voice_admitted_within hI hM
    (fun i j e => faithful_channel_is_live_sharpening (hE i j e)) h s v

end Operational

/-! ## 4. Instances: the individual, the flat network, the ring -/

section Instances

variable {S World Evidence Decision : Type}

/-- **The individual.**  One model correcting itself (the ring of one) admits
its own live content within one hop's time and cost. -/
theorem solo_voice_within
    {P : Process (Fin 1) S (Fin 1 × Content World) Evidence Decision}
    {M : Fin 1 → Model World} {ch : Fin 1 → Fin 1 → Channel World}
    {α : S → (i : Fin 1) → (M i).State} {C : Content World} {T K : Nat}
    (hI : Implements P M (RingEdge 0) ch α T K) (hM : ∀ k, (M k).Tracking C)
    (hE : ∀ i j, RingEdge 0 i j → Honest C (ch i j)) (s : S) (v : Content World) :
    ∃ t n c, P.Run s t n c ∧ n ≤ T ∧ c ≤ K ∧
      (LiveClaim den C v → Compatible den C ((M 0).record (α t 0)) v) := by
  have hloop : RingEdge 0 0 0 := Or.inr ⟨rfl, rfl⟩
  obtain ⟨t, n, c, hr, hn, hc, hadm, _⟩ :=
    voice_admitted_within hI hM hE (RelayN.hop hloop (RelayN.here 0)) s v
  exact ⟨t, n, c, hr, by omega, by omega, hadm⟩

/-- **Flat network: one hop.** -/
theorem flat_voice_within {ι : Type}
    {P : Process ι S (ι × Content World) Evidence Decision}
    {M : ι → Model World} {ch : ι → ι → Channel World}
    {α : S → (i : ι) → (M i).State} {C : Content World} {T K : Nat}
    (hI : Implements P M (fun a b => a ≠ b) ch α T K) (hM : ∀ k, (M k).Tracking C)
    (hE : ∀ i j, i ≠ j → Honest C (ch i j)) {i k : ι} (hik : i ≠ k)
    (s : S) (v : Content World) :
    ∃ t n c, P.Run s t n c ∧ n ≤ T ∧ c ≤ K ∧
      (LiveClaim den C v → Compatible den C ((M k).record (α t k)) v) := by
  obtain ⟨t, n, c, hr, hn, hc, hadm, _⟩ :=
    voice_admitted_within (E := fun a b => a ≠ b) hI hM hE
      (RelayN.hop hik (RelayN.here k)) s v
  exact ⟨t, n, c, hr, by omega, by omega, hadm⟩

/-- **Ring: every voice reaches every other member within `n·T` and `n·K`.** -/
theorem ring_voice_within {n : Nat}
    {P : Process (Fin (n + 1)) S (Fin (n + 1) × Content World) Evidence Decision}
    {M : Fin (n + 1) → Model World} {ch : Fin (n + 1) → Fin (n + 1) → Channel World}
    {α : S → (i : Fin (n + 1)) → (M i).State} {C : Content World} {T K : Nat}
    (hI : Implements P M (RingEdge n) ch α T K) (hM : ∀ k, (M k).Tracking C)
    (hE : ∀ i j, RingEdge n i j → Honest C (ch i j)) {i k : Fin (n + 1)} (hik : i ≠ k)
    (s : S) (v : Content World) :
    ∃ t n' c, P.Run s t n' c ∧ n' ≤ n * T ∧ c ≤ n * K ∧
      (LiveClaim den C v → Compatible den C ((M k).record (α t k)) v) := by
  obtain ⟨m, h1, hm, hreach⟩ := ring_within n i k hik
  obtain ⟨m', rfl⟩ : ∃ m', m = m' + 1 := ⟨m - 1, by omega⟩
  obtain ⟨f, hf⟩ := reachIn_relayN (ch := ch) hreach
  obtain ⟨t, n', c, hr, hn, hc, hadm, _⟩ := voice_admitted_within hI hM hE hf s v
  exact ⟨t, n', c, hr, Nat.le_trans hn (Nat.mul_le_mul_right T hm),
    Nat.le_trans hc (Nat.mul_le_mul_right K hm), hadm⟩

/-- Exact-faithfulness specialization of `solo_voice_within`. -/
theorem solo_voice_within_faithful
    {P : Process (Fin 1) S (Fin 1 × Content World) Evidence Decision}
    {M : Fin 1 → Model World} {ch : Fin 1 → Fin 1 → Channel World}
    {α : S → (i : Fin 1) → (M i).State} {C : Content World} {T K : Nat}
    (hI : Implements P M (RingEdge 0) ch α T K) (hM : ∀ k, (M k).Tracking C)
    (hE : ∀ i j, RingEdge 0 i j → FaithfulChannel C (ch i j))
    (s : S) (v : Content World) :
    ∃ t n c, P.Run s t n c ∧ n ≤ T ∧ c ≤ K ∧
      (LiveClaim den C v → Compatible den C ((M 0).record (α t 0)) v) := by
  exact solo_voice_within hI hM
    (fun i j e => faithful_channel_is_live_sharpening (hE i j e)) s v

/-- Exact-faithfulness specialization of `flat_voice_within`. -/
theorem flat_voice_within_faithful {ι : Type}
    {P : Process ι S (ι × Content World) Evidence Decision}
    {M : ι → Model World} {ch : ι → ι → Channel World}
    {α : S → (i : ι) → (M i).State} {C : Content World} {T K : Nat}
    (hI : Implements P M (fun a b => a ≠ b) ch α T K) (hM : ∀ k, (M k).Tracking C)
    (hE : ∀ i j, i ≠ j → FaithfulChannel C (ch i j)) {i k : ι} (hik : i ≠ k)
    (s : S) (v : Content World) :
    ∃ t n c, P.Run s t n c ∧ n ≤ T ∧ c ≤ K ∧
      (LiveClaim den C v → Compatible den C ((M k).record (α t k)) v) := by
  exact flat_voice_within hI hM
    (fun i j e => faithful_channel_is_live_sharpening (hE i j e)) hik s v

/-- Exact-faithfulness specialization of `ring_voice_within`. -/
theorem ring_voice_within_faithful {n : Nat}
    {P : Process (Fin (n + 1)) S (Fin (n + 1) × Content World) Evidence Decision}
    {M : Fin (n + 1) → Model World} {ch : Fin (n + 1) → Fin (n + 1) → Channel World}
    {α : S → (i : Fin (n + 1)) → (M i).State} {C : Content World} {T K : Nat}
    (hI : Implements P M (RingEdge n) ch α T K) (hM : ∀ k, (M k).Tracking C)
    (hE : ∀ i j, RingEdge n i j → FaithfulChannel C (ch i j))
    {i k : Fin (n + 1)} (hik : i ≠ k) (s : S) (v : Content World) :
    ∃ t n' c, P.Run s t n' c ∧ n' ≤ n * T ∧ c ≤ n * K ∧
      (LiveClaim den C v → Compatible den C ((M k).record (α t k)) v) := by
  exact ring_voice_within hI hM
    (fun i j e => faithful_channel_is_live_sharpening (hE i j e)) hik s v

end Instances

/-! ## 5. Upkeep against the ledger: the latency–upkeep frontier -/

section Upkeep

/-- Members maintaining `d` links each, at upkeep `μ` per link, and returning
`η` each. -/
def linkLedger (ℓ : Ledger) (d : Nat) : Ledger := ⟨ℓ.B0, ℓ.eta, d * ℓ.mu⟩

/-- **The ring is affordable at every size when correction pays for itself.** -/
theorem ring_self_financing (ℓ : Ledger) (h : ℓ.mu ≤ ℓ.eta) :
    ∀ N, (linkLedger ℓ 1).Affordable N :=
  self_financing_never_binds _ (by show 1 * ℓ.mu ≤ ℓ.eta; omega)

/-- **The flat network has a ceiling under positive per-link upkeep.**
With `N` members each maintaining `N - 1` links at upkeep at least 1, the
network is unaffordable once `N ≥ B0 + η + 2`. -/
theorem flat_ceiling (ℓ : Ledger) (hμ : 1 ≤ ℓ.mu) {N : Nat}
    (hN : ℓ.B0 + ℓ.eta + 2 ≤ N) : ¬ (linkLedger ℓ (N - 1)).Affordable N := by
  intro h
  change (N - 1) * ℓ.mu * N ≤ ℓ.B0 + ℓ.eta * N at h
  have h1 : (N - 1) * 1 ≤ (N - 1) * ℓ.mu := Nat.mul_le_mul_left (N - 1) hμ
  have h2 : (N - 1) * N ≤ (N - 1) * ℓ.mu * N := Nat.mul_le_mul_right N (by omega)
  have h3 : (ℓ.eta + ℓ.B0 + 1) * N ≤ (N - 1) * N := Nat.mul_le_mul_right N (by omega)
  have h4 : (ℓ.eta + ℓ.B0 + 1) * N = ℓ.eta * N + ℓ.B0 * N + N := by
    rw [Nat.add_mul, Nat.add_mul, Nat.one_mul]
  have h5 : ℓ.B0 * 1 ≤ ℓ.B0 * N := Nat.mul_le_mul_left ℓ.B0 (by omega)
  omega

/-- **The latency–upkeep frontier** for `n + 1` members, when each link costs at
least 1 and the ring's one-link-per-member maintenance is self-financing
(`μ ≤ η`).
* Ring: one link per member, affordable at every size.  The worst route has
  exactly `n` hops: it is attained, and no route is shorter.
* Flat: every pair is one hop apart, but the network is unaffordable once
  `n + 1 ≥ B0 + η + 2` under the same per-member return parameter.
* Any network with one-hop latency between all pairs has every link
  (`latency_one_forces_complete`), so the flat link demand is forced by its speed. -/
theorem latency_upkeep_frontier (ℓ : Ledger) (hμ : 1 ≤ ℓ.mu) (hself : ℓ.mu ≤ ℓ.eta)
    (n : Nat) :
    (linkLedger ℓ 1).Affordable (n + 1) ∧
    ReachIn (RingEdge n) ⟨0, by omega⟩ ⟨n, by omega⟩ n ∧
    (∀ m, ReachIn (RingEdge n) ⟨0, by omega⟩ ⟨n, by omega⟩ m → n ≤ m) ∧
    (∀ a b : Fin (n + 1), a ≠ b → ReachIn (fun x y : Fin (n + 1) => x ≠ y) a b 1) ∧
    (ℓ.B0 + ℓ.eta + 2 ≤ n + 1 → ¬ (linkLedger ℓ n).Affordable (n + 1)) :=
  ⟨ring_self_financing ℓ hself (n + 1), ring_latency_attained n,
   fun _ h => ring_latency_lower n h,
   fun _ b hab => ReachIn.step hab (ReachIn.refl b),
   fun hN => by
     have := flat_ceiling ℓ hμ hN
     simpa using this⟩

end Upkeep

/-! ## 6. Non-vacuity: every network of models has a canonical implementation -/

section Canonical

variable {ι World : Type u} [DecidableEq ι]
variable (M : ι → Model World) (E : ι → ι → Prop) (ch : ι → ι → Channel World)

/-- Replace member `j`'s state. -/
def setAt (x : (i : ι) → (M i).State) (j : ι) (y : (M j).State) : (i : ι) → (M i).State :=
  fun i => if h : i = j then h ▸ y else x i

theorem setAt_same (x : (i : ι) → (M i).State) (j : ι) (y : (M j).State) :
    setAt M x j y j = y := by
  simp [setAt]

/-- Canonical states: the members' model states and at most one pending hop. -/
abbrev CState := ((i : ι) → (M i).State) × Option (ι × ι × Content World)

/-- **The canonical process.**  A member challenges along a link and the hop
becomes pending.  The addressed member then revises by its own model on what
arrived through the channel.  Every step costs 1. -/
def canonical : Process ι (CState M) (ι × Content World) PUnit.{u+1} ι where
  step := fun s v t =>
    (∃ i j u, E i j ∧ v = .challenge i (j, u) ∧ t = (s.1, some (i, j, u))) ∨
    (∃ i j u, s.2 = some (i, j, u) ∧ v = .revise (j, u) ∧
      t = (setAt M s.1 j ((M j).revise (s.1 j) (ch i j u)), none))
  cost := fun _ _ _ => 1
  affected := fun _ _ => True
  sharedClaim := fun _ _ => True
  excluded := fun _ _ => False
  groundsForReview := fun _ _ => False
  sameStanding := fun _ _ _ => True
  restricts := fun _ d b => d = b
  claimOf := fun d => (d, fun _ => False)

/-- **Every network of models is implementable**, with two steps and cost 2
per hop. -/
theorem canonical_implements :
    Implements (canonical M E ch) M E ch (fun s => s.1) 2 2 := by
  intro s i j u e
  refine ⟨(setAt M s.1 j ((M j).revise (s.1 j) (ch i j u)), none), 2, 2,
    ⟨(s.1, some (i, j, u)), (s.1, some (i, j, u)), 0, 0,
      Or.inl ⟨i, j, u, e, rfl, rfl⟩, Process.Run.nil _,
      Or.inr ⟨i, j, u, rfl, rfl, rfl⟩, rfl, rfl⟩, Nat.le_refl _, Nat.le_refl _, ?_⟩
  exact setAt_same M _ _ _

/-- The canonical implementation of a strongly connected network is
operationally correctable at every state. -/
theorem canonical_correctable (hsc : StronglyConnected E) (s : CState M) :
    ((canonical M E ch).correctionSystem s).Correctable :=
  implemented_correctable (canonical_implements M E ch) hsc
    (fun _ _ => ⟨fun _ => True, Or.inr ⟨trivial, trivial⟩⟩) s

end Canonical

/-- **A concrete ring.**  In a ring of `n + 1` open models, run canonically,
every member's live voice is admitted by every other member within `2n` steps
and cost `2n`. -/
theorem canonical_ring_voice {World : Type} (n : Nat) (C : Content World)
    {i k : Fin (n + 1)} (hik : i ≠ k)
    (s : CState (fun _ : Fin (n + 1) => (openModel : Model World))) (v : Content World) :
    ∃ t n' c,
      (canonical (fun _ => openModel) (RingEdge n) (fun _ _ v => v)).Run s t n' c ∧
      n' ≤ n * 2 ∧ c ≤ n * 2 ∧
      (LiveClaim den C v → Compatible den C ((openModel : Model World).record (t.1 k)) v) :=
  ring_voice_within (canonical_implements _ _ _) (fun _ => open_tracks C)
    (fun _ _ _ => honest_id) hik s v

end Anchored.Realization
