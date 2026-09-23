/-!
# Cumulative Reproduction: discrete-time core

Mathlib-free Lean 4 (tested with `leanprover/lean4:v4.33.0`, core library only).
Check with:  `lean CumulativeReproduction.lean`

The repertoire of retained organization has size `n : Nat`.  In one period it
gains `G n` newly retained items (production) and loses `L n` items (forgetting,
decay, displacement).  Sizes are truncated at zero, which models extinction of
the repertoire.

The continuous-time law in THEORY.md uses the cumulative reproduction number
`R_c(n) = P(n) / L(n)`.  In this discrete integer model, `R_c(n) > 1` corresponds
to `L n < G n`.

Statements proved here (no `sorry`, no axioms beyond Lean core):

* **Law 1, threshold.**  The repertoire grows exactly when gains exceed losses.
* **Law 2, runaway.**  If the system is supercritical everywhere above a
  starting point, the repertoire is unbounded.
* **Law 3, collapse.**  If the system is subcritical below a critical mass `c`,
  any repertoire below `c` goes extinct within its own size in steps.
* **Law 4, critical-mass dichotomy.**  Laws 2 and 3 combined: an Allee
  threshold.
* **Law 5, growth classes.**  If the excess over critical mass is linear, the
  gap grows at least exponentially.  If the excess is quadratic (arity-2
  composition), the gap grows at least doubly exponentially, the discrete
  analogue of finite-time blow-up.
* **Law 6, budget ledger.**  Take gross budget `B0 + η n` and upkeep `μ n`.
  - If `μ ≤ η` (retained items pay their own upkeep), the budget never binds.
  - If `η < μ`, every affordable repertoire satisfies `n ≤ B0 / (μ - η)`, so
    runaway is impossible regardless of leverage or arity.
  - Affordability is invariant under rescaling of the currency.
* **Law 7, unaffordable critical mass.**  With admission-respecting (clipped)
  dynamics, a critical mass above the ceiling forces extinction from any
  initial repertoire.  An affordable critical mass lets the repertoire fill up
  to the ceiling.
* **Law 8, scaffold (emergence).**  With part-wise feedback and retention of
  found parts, an arity-`k` target with `q` options per part is found within
  `k * q` trials.  Moreover `k * q ≤ q ^ k` (strict for `k ≥ 3`), where `q ^ k`
  is the size of the unscaffolded search space.
-/

/-!
Review scope: these are conditional natural-number recurrence results, not
proofs of the ODE or CTMC. The integer threshold c assumes strictly positive
net gain at c; it is not the ODE equality point N*. Clipping combines gains,
losses and ceiling projection in one period, unlike CTMC birth admission.
Quadratic excess is an explicit hypothesis, not derived from arbitrary
pairwise rates. The doubly exponential lower bound is informative for an
initial gap at least two. The scaffold needs part-correctness feedback and
counts exhaustive part evaluations; its cost is not included in the ledger.
-/

namespace CumulativeReproduction

/-! ## Dynamics -/

/-- One period: gains `G n`, losses `L n`, truncated at zero (extinction). -/
def step (G L : Nat → Nat) (n : Nat) : Nat := n + G n - L n

/-- Trajectory from initial repertoire `n0`. -/
def traj (G L : Nat → Nat) (n0 : Nat) : Nat → Nat
  | 0 => n0
  | t + 1 => step G L (traj G L n0 t)

/-! ## Law 1: threshold -/

/-- The repertoire grows exactly when gains exceed losses (`R_c > 1`). -/
theorem grows_iff (G L : Nat → Nat) (n : Nat) :
    n < step G L n ↔ L n < G n := by
  unfold step; omega

/-- A nonempty repertoire shrinks exactly when losses exceed gains (`R_c < 1`). -/
theorem shrinks_iff (G L : Nat → Nat) {n : Nat} (hn : 0 < n) :
    step G L n < n ↔ G n < L n := by
  unfold step; omega

/-- A nonempty repertoire is at equilibrium exactly when `R_c = 1`. -/
theorem fixed_iff (G L : Nat → Nat) {n : Nat} (hn : 0 < n) :
    step G L n = n ↔ G n = L n := by
  unfold step; omega

/-! ## Law 2: runaway -/

/-- Supercritical at and above `a`: every period adds at least one net item. -/
def SupercriticalFrom (G L : Nat → Nat) (a : Nat) : Prop :=
  ∀ n, a ≤ n → L n + 1 ≤ G n

theorem runaway (G L : Nat → Nat) {a n0 : Nat}
    (hsup : SupercriticalFrom G L a) (h0 : a ≤ n0) :
    ∀ t, n0 + t ≤ traj G L n0 t := by
  intro t
  induction t with
  | zero => simp [traj]
  | succ t ih =>
      have hg := hsup (traj G L n0 t) (by omega)
      show n0 + (t + 1) ≤ step G L (traj G L n0 t)
      unfold step; omega

theorem runaway_unbounded (G L : Nat → Nat) {a n0 : Nat}
    (hsup : SupercriticalFrom G L a) (h0 : a ≤ n0) :
    ∀ K, ∃ t, K < traj G L n0 t :=
  fun K => ⟨K + 1, by have := runaway G L hsup h0 (K + 1); omega⟩

/-! ## Law 3: collapse below critical mass -/

/-- Subcritical strictly below critical mass `c`: every nonempty repertoire
smaller than `c` loses at least one net item per period. -/
def SubcriticalBelow (G L : Nat → Nat) (c : Nat) : Prop :=
  ∀ n, 0 < n → n < c → G n + 1 ≤ L n

theorem step_zero (G L : Nat → Nat) (hz : G 0 = 0) : step G L 0 = 0 := by
  unfold step; omega

theorem collapse (G L : Nat → Nat) {c n0 : Nat}
    (hsub : SubcriticalBelow G L c) (hz : G 0 = 0) (h0 : n0 < c) :
    ∀ t, traj G L n0 t ≤ n0 - t := by
  intro t
  induction t with
  | zero => simp [traj]
  | succ t ih =>
      show step G L (traj G L n0 t) ≤ n0 - (t + 1)
      by_cases hx : traj G L n0 t = 0
      · rw [hx, step_zero G L hz]; omega
      · have hl := hsub (traj G L n0 t) (by omega) (by omega)
        unfold step; omega

theorem extinct_within_own_size (G L : Nat → Nat) {c n0 : Nat}
    (hsub : SubcriticalBelow G L c) (hz : G 0 = 0) (h0 : n0 < c) :
    traj G L n0 n0 = 0 := by
  have := collapse G L hsub hz h0 n0; omega

/-! ## Law 4: critical-mass dichotomy (Allee threshold) -/

theorem critical_mass_dichotomy (G L : Nat → Nat) {c n0 : Nat}
    (hsub : SubcriticalBelow G L c) (hsup : SupercriticalFrom G L c)
    (hz : G 0 = 0) :
    (c ≤ n0 → ∀ K, ∃ t, K < traj G L n0 t) ∧
    (n0 < c → traj G L n0 n0 = 0) :=
  ⟨fun h => runaway_unbounded G L hsup h,
   fun h => extinct_within_own_size G L hsub hz h⟩

/-! ## Law 5: growth classes (how fast) -/

/-- Invariant used by both growth-class theorems: nonnegative excess above `c`
keeps the trajectory at or above `c`. -/
theorem stays_above (G L : Nat → Nat) {c n0 : Nat}
    (hex : ∀ n, c ≤ n → L n ≤ G n) (h0 : c ≤ n0) :
    ∀ t, c ≤ traj G L n0 t := by
  intro t
  induction t with
  | zero => simpa [traj]
  | succ t ih =>
      have := hex _ ih
      show c ≤ step G L (traj G L n0 t)
      unfold step; omega

/-- **Arity 1 (linear excess): exponential growth.**  If each item above
critical mass adds `r` net items per period, the gap above `c` grows at least
like `(r+1)^t`. -/
theorem linear_excess_exponential (G L : Nat → Nat) {c n0 : Nat} (r : Nat)
    (hex : ∀ n, c ≤ n → L n + r * (n - c) ≤ G n) (h0 : c ≤ n0) :
    ∀ t, (r + 1) ^ t * (n0 - c) ≤ traj G L n0 t - c := by
  have hstay := stays_above G L (c := c) (n0 := n0)
    (fun n hn => by have := hex n hn; omega) h0
  intro t
  induction t with
  | zero => simp [traj]
  | succ t ih =>
      have hc := hstay t
      have he := hex (traj G L n0 t) hc
      have hmul : (r + 1) * ((r + 1) ^ t * (n0 - c)) ≤
          (r + 1) * (traj G L n0 t - c) := Nat.mul_le_mul_left _ ih
      have hstep : (r + 1) * (traj G L n0 t - c) ≤
          step G L (traj G L n0 t) - c := by
        unfold step
        rw [Nat.add_mul, Nat.one_mul]
        omega
      show (r + 1) ^ (t + 1) * (n0 - c) ≤ step G L (traj G L n0 t) - c
      rw [Nat.pow_succ, Nat.mul_comm ((r + 1) ^ t) (r + 1), Nat.mul_assoc]
      exact Nat.le_trans hmul hstep

/-- **Arity 2 (quadratic excess): doubly-exponential growth.**  If the net
gain above critical mass is at least the square of the gap, a condition requiring a suitable coefficient and threshold
for pairwise composition, the gap after `t` periods is at least
`gap0 ^ (2 ^ t)`.  This is the discrete counterpart of finite-time blow-up. -/
theorem quadratic_excess_doubly_exponential (G L : Nat → Nat) {c n0 : Nat}
    (hex : ∀ n, c ≤ n → L n + (n - c) * (n - c) ≤ G n) (h0 : c ≤ n0) :
    ∀ t, (n0 - c) ^ (2 ^ t) ≤ traj G L n0 t - c := by
  have hstay := stays_above G L (c := c) (n0 := n0)
    (fun n hn => by have := hex n hn; omega) h0
  intro t
  induction t with
  | zero => simp [traj]
  | succ t ih =>
      have hc := hstay t
      have he := hex (traj G L n0 t) hc
      have hsq : (n0 - c) ^ (2 ^ t) * (n0 - c) ^ (2 ^ t) ≤
          (traj G L n0 t - c) * (traj G L n0 t - c) :=
        Nat.mul_self_le_mul_self ih
      have hstep : (traj G L n0 t - c) * (traj G L n0 t - c) ≤
          step G L (traj G L n0 t) - c := by
        unfold step; omega
      have hpow : (n0 - c) ^ (2 ^ (t + 1)) =
          (n0 - c) ^ (2 ^ t) * (n0 - c) ^ (2 ^ t) := by
        rw [Nat.pow_succ, Nat.pow_mul, Nat.pow_two]
      show (n0 - c) ^ (2 ^ (t + 1)) ≤ step G L (traj G L n0 t) - c
      rw [hpow]
      exact Nat.le_trans hsq hstep

/-! ## Law 6: the budget ledger -/

/-- Budget ledger in one currency: exogenous gross budget `B0`, resource capture
`eta` per retained item, upkeep `mu` per retained item. -/
structure Ledger where
  B0 : Nat
  eta : Nat
  mu : Nat

/-- A repertoire of size `n` is affordable when upkeep fits the gross budget. -/
def Ledger.Affordable (ℓ : Ledger) (n : Nat) : Prop :=
  ℓ.mu * n ≤ ℓ.B0 + ℓ.eta * n

/-- **Self-financing retention never binds.**  If each retained item captures
at least its own upkeep, every repertoire size is affordable. -/
theorem self_financing_never_binds (ℓ : Ledger) (h : ℓ.mu ≤ ℓ.eta) :
    ∀ n, ℓ.Affordable n := by
  intro n
  have := Nat.mul_le_mul_right n h
  unfold Ledger.Affordable; omega

/-- **Budget ceiling.**  If upkeep exceeds capture, every affordable repertoire
satisfies `(mu - eta) * n ≤ B0`. -/
theorem ceiling_mul (ℓ : Ledger) (_h : ℓ.eta < ℓ.mu) {n : Nat}
    (hn : ℓ.Affordable n) : (ℓ.mu - ℓ.eta) * n ≤ ℓ.B0 := by
  unfold Ledger.Affordable at hn
  rw [Nat.sub_mul]; omega

/-- The ceiling `B0 / (mu - eta)`. -/
def Ledger.cap (ℓ : Ledger) : Nat := ℓ.B0 / (ℓ.mu - ℓ.eta)

theorem le_cap_of_affordable (ℓ : Ledger) (h : ℓ.eta < ℓ.mu) {n : Nat}
    (hn : ℓ.Affordable n) : n ≤ ℓ.cap := by
  unfold Ledger.cap
  rw [Nat.le_div_iff_mul_le (by omega), Nat.mul_comm]
  exact ceiling_mul ℓ h hn

theorem affordable_of_le_cap (ℓ : Ledger) (h : ℓ.eta < ℓ.mu) {n : Nat}
    (hn : n ≤ ℓ.cap) : ℓ.Affordable n := by
  unfold Ledger.cap at hn
  rw [Nat.le_div_iff_mul_le (by omega), Nat.mul_comm, Nat.sub_mul] at hn
  unfold Ledger.Affordable; omega

/-- **No runaway under a net-cost ledger.**  Any trajectory that respects
affordability at all times is bounded by the ceiling, whatever the leverage,
arity or production law. -/
theorem no_runaway_when_upkeep_exceeds_capture (ℓ : Ledger)
    (h : ℓ.eta < ℓ.mu) (x : Nat → Nat) (hA : ∀ t, ℓ.Affordable (x t)) :
    ¬ ∀ K, ∃ t, K < x t := by
  intro hU
  obtain ⟨t, ht⟩ := hU ℓ.cap
  have := le_cap_of_affordable ℓ h (hA t)
  omega

/-- **Currency invariance.**  Rescaling every budget quantity by the same
positive factor leaves affordability unchanged, so the budget law has no free
exchange rate. -/
theorem affordable_scale_invariant (ℓ : Ledger) {lam : Nat} (hl : 0 < lam)
    (n : Nat) :
    (Ledger.Affordable ⟨lam * ℓ.B0, lam * ℓ.eta, lam * ℓ.mu⟩ n) ↔
      ℓ.Affordable n := by
  unfold Ledger.Affordable
  simp only
  rw [Nat.mul_assoc, Nat.mul_assoc, ← Nat.mul_add]
  exact Nat.mul_le_mul_left_iff hl

/-! ## Law 7: admission-respecting dynamics -/

/-- Clipped dynamics: new items are admitted only up to the ceiling `K`. -/
def trajC (G L : Nat → Nat) (K n0 : Nat) : Nat → Nat
  | 0 => n0
  | t + 1 => min (step G L (trajC G L K n0 t)) K

/-- With `K = cap`, clipping is exactly admission: every state after the first
period is affordable. -/
theorem trajC_affordable (G L : Nat → Nat) (ℓ : Ledger) (h : ℓ.eta < ℓ.mu)
    (n0 : Nat) : ∀ t, ℓ.Affordable (trajC G L ℓ.cap n0 (t + 1)) := by
  intro t
  apply affordable_of_le_cap ℓ h
  show min _ _ ≤ _
  omega

/-- **Unaffordable critical mass forces extinction.**  If the critical mass
exceeds the ceiling, the repertoire goes extinct from any initial state,
however large. -/
theorem unaffordable_critical_mass_collapse (G L : Nat → Nat) {c K : Nat}
    (hsub : SubcriticalBelow G L c) (hz : G 0 = 0) (hK : K < c) (n0 : Nat) :
    ∀ t, trajC G L K n0 (t + 1) ≤ K - t := by
  intro t
  induction t with
  | zero =>
      show min _ _ ≤ K - 0
      omega
  | succ t ih =>
      show min (step G L (trajC G L K n0 (t + 1))) K ≤ K - (t + 1)
      by_cases hx : trajC G L K n0 (t + 1) = 0
      · rw [hx, step_zero G L hz]; omega
      · have hl := hsub (trajC G L K n0 (t + 1)) (by omega) (by omega)
        have : step G L (trajC G L K n0 (t + 1)) + 1 ≤ trajC G L K n0 (t + 1) := by
          unfold step; omega
        omega

theorem unaffordable_critical_mass_extinct (G L : Nat → Nat) {c K : Nat}
    (hsub : SubcriticalBelow G L c) (hz : G 0 = 0) (hK : K < c) (n0 : Nat) :
    trajC G L K n0 (K + 1) = 0 := by
  have := unaffordable_critical_mass_collapse G L hsub hz hK n0 K
  omega

/-- The ledger form of the collapse condition: if `(mu - eta) * c > B0`, the
critical mass lies above the ceiling. -/
theorem cap_lt_of_unaffordable (ℓ : Ledger) (h : ℓ.eta < ℓ.mu) {c : Nat}
    (hc : ℓ.B0 < c * (ℓ.mu - ℓ.eta)) : ℓ.cap < c := by
  unfold Ledger.cap
  exact (Nat.div_lt_iff_lt_mul (by omega)).2 hc

/-- **Affordable critical mass: the repertoire fills to the ceiling.**
Starting between critical mass and ceiling, a supercritical system gains at
least one item per period until the ceiling is reached, then stays there.
This is the plateau regime. -/
theorem affordable_critical_mass_plateau (G L : Nat → Nat) {c K n0 : Nat}
    (hsup : SupercriticalFrom G L c) (hc : c ≤ n0) (hK : n0 ≤ K) :
    ∀ t, min (n0 + t) K ≤ trajC G L K n0 t := by
  intro t
  induction t with
  | zero => show min (n0 + 0) K ≤ n0; omega
  | succ t ih =>
      have hx : c ≤ trajC G L K n0 t := by omega
      have hg := hsup _ hx
      show min (n0 + (t + 1)) K ≤ min (step G L (trajC G L K n0 t)) K
      unfold step; omega

/-- Combined budget-balance dichotomy. -/
theorem budget_balance_dichotomy (G L : Nat → Nat) (ℓ : Ledger) {c n0 : Nat}
    (hsub : SubcriticalBelow G L c) (hsup : SupercriticalFrom G L c)
    (hz : G 0 = 0) :
    -- net-cost ledger with unaffordable critical mass: extinction from anywhere
    (ℓ.eta < ℓ.mu → ℓ.B0 < c * (ℓ.mu - ℓ.eta) →
        trajC G L ℓ.cap n0 (ℓ.cap + 1) = 0) ∧
    -- self-financing ledger with enough initial mass: unbounded accumulation
    (ℓ.mu ≤ ℓ.eta → c ≤ n0 →
        (∀ n, ℓ.Affordable n) ∧ ∀ K, ∃ t, K < traj G L n0 t) :=
  ⟨fun h hc => unaffordable_critical_mass_extinct G L hsub hz
      (cap_lt_of_unaffordable ℓ h hc) n0,
   fun h hc => ⟨self_financing_never_binds ℓ h, runaway_unbounded G L hsup hc⟩⟩

/-! ## Law 8: scaffold law (emergence made load-bearing) -/

/-- Sum of `f i` for `i < k`. -/
def sumBelow (f : Nat → Nat) : Nat → Nat
  | 0 => 0
  | k + 1 => sumBelow f k + f k

/-- **Scaffolded search.**  With part-wise feedback, try the options of each
part in order and retain the correct one.  Part `i` costs `target i + 1`
trials, so an arity-`k` target is found within `k * q` trials. -/
theorem scaffolded_search_cost (k q : Nat) (target : Nat → Nat)
    (h : ∀ i, i < k → target i < q) :
    sumBelow (fun i => target i + 1) k ≤ k * q := by
  induction k with
  | zero => simp [sumBelow]
  | succ k ih =>
      have h1 := ih (fun i hi => h i (by omega))
      have h2 := h k (by omega)
      show sumBelow (fun i => target i + 1) k + (target k + 1) ≤ (k + 1) * q
      rw [Nat.add_mul, Nat.one_mul]; omega

/-- Without part-wise feedback, a strictly emergent (all-or-nothing) target of
arity `k` with `q` options per part sits in a search space of `q ^ k` joint
configurations.  Scaffolding is never worse (`k * q ≤ q ^ k` for `q ≥ 2`). -/
theorem scaffold_never_worse {q : Nat} (hq : 2 ≤ q) :
    ∀ k, 1 ≤ k → k * q ≤ q ^ k := by
  intro k hk
  induction k with
  | zero => omega
  | succ k ih =>
      rcases Nat.lt_or_ge k 1 with h0 | h1
      · have : k = 0 := by omega
        subst this; simp
      · have ih' := ih h1
        have hqk : q ≤ q ^ k := by
          have := Nat.pow_le_pow_right (n := q) (by omega) h1
          simpa using this
        have hmul : q * 1 ≤ q ^ k * (q - 1) :=
          Nat.mul_le_mul hqk (by omega)
        have hsplit : q ^ k * q = q ^ k + q ^ k * (q - 1) := by
          rw [Nat.mul_sub_one]
          have : q ^ k ≤ q ^ k * q := Nat.le_mul_of_pos_right _ (by omega)
          omega
        rw [Nat.pow_succ, Nat.add_mul, Nat.one_mul, hsplit]
        omega

/-- For `k ≥ 3` the advantage is strict: `k * q < q ^ k`.  The ratio
`q ^ k / (k * q)` grows exponentially in the arity `k`. -/
theorem scaffold_strict {q : Nat} (hq : 2 ≤ q) :
    ∀ k, 3 ≤ k → k * q < q ^ k := by
  intro k hk
  induction k with
  | zero => omega
  | succ k ih =>
      rcases Nat.lt_or_ge k 3 with h0 | h1
      · have : k = 2 := by omega
        subst this
        -- 3q < q^3  since q^3 = q*q*q ≥ 4q > 3q
        have h4 : 4 ≤ q * q := Nat.mul_le_mul hq hq
        have : 4 * q ≤ q * q * q := Nat.mul_le_mul_right q h4
        show 3 * q < q ^ 3
        rw [show q ^ 3 = q * q * q by simp [Nat.pow_succ]]
        omega
      · have ih' := ih h1
        have hqk : q ≤ q ^ k := by
          have := Nat.pow_le_pow_right (n := q) (by omega) (show 1 ≤ k by omega)
          simpa using this
        have hmul : q * 1 ≤ q ^ k * (q - 1) :=
          Nat.mul_le_mul hqk (by omega)
        have hsplit : q ^ k * q = q ^ k + q ^ k * (q - 1) := by
          rw [Nat.mul_sub_one]
          have : q ^ k ≤ q ^ k * q := Nat.le_mul_of_pos_right _ (by omega)
          omega
        rw [Nat.pow_succ, Nat.add_mul, Nat.one_mul, hsplit]
        omega

/-! ## Non-vacuity witnesses -/

/-- A concrete arity-2 system: gains `n(n-1)/2`, losses `3n + 1`.  The critical
mass is 8: below it the repertoire collapses, at or above it it runs away. -/
def gPair (n : Nat) : Nat := n * (n - 1) / 2
def lLin (n : Nat) : Nat := 3 * n + 1

example : traj gPair lLin 7 7 = 0 := by decide
example : traj gPair lLin 8 3 > 100 := by decide
example : traj gPair lLin 9 4 > 10000 := by decide

/-- Budget witness: ceiling 20 (`B0 = 40`, `eta = 1`, `mu = 3`) sits above the
critical mass 8, so the clipped system fills to 20 and stays there. -/
example : trajC gPair lLin (Ledger.cap ⟨40, 1, 3⟩) 8 10 = 20 := by decide

/-- Unaffordable witness: ceiling 5 (`B0 = 10`, `eta = 1`, `mu = 3`) is below the
critical mass 8, so even a huge initial repertoire goes extinct. -/
example : trajC gPair lLin (Ledger.cap ⟨10, 1, 3⟩) 1000 6 = 0 := by decide

end CumulativeReproduction

section Audit
open CumulativeReproduction
#print axioms grows_iff
#print axioms runaway_unbounded
#print axioms collapse
#print axioms critical_mass_dichotomy
#print axioms linear_excess_exponential
#print axioms quadratic_excess_doubly_exponential
#print axioms self_financing_never_binds
#print axioms no_runaway_when_upkeep_exceeds_capture
#print axioms affordable_scale_invariant
#print axioms trajC_affordable
#print axioms unaffordable_critical_mass_extinct
#print axioms affordable_critical_mass_plateau
#print axioms budget_balance_dichotomy
#print axioms scaffolded_search_cost
#print axioms scaffold_never_worse
#print axioms scaffold_strict
end Audit
