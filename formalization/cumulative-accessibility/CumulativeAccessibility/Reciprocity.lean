namespace CumulativeAccessibility
namespace Reciprocity

/-!
# Reciprocal dependence: the defector falls with what it defected on

Step 2 of the core says that a node is held in place by its connections:
delete the return edge and the node it fed declines
(`deleting_return_edge_makes_source_decline`).  This file follows the
consequence one step further, back to the node that deleted the edge.

The same structure holds at every level, outward and inward: a person and
the society that maintains them, an organ and the body, a cell and its
tissue, a model and the people, energy and maintenance that keep it running,
a chip and the system it is part of.  Each node is a part of a larger whole and
a whole made of parts, and each depends on others that depend on it.

Setting: two nodes `A` and `B`, in whole units per step.
* Each has its own uptake `u` and upkeep `m`.
* Each gives the other something: giving costs the giver `g` and is worth `w`
  to the receiver.  **Gains from exchange** mean `g < w`.
* Each holds a reserve and is **alive** while its reserve is nonnegative; a
  node gives only while it is alive and has not defected.
* `A` **defects** by no longer giving, while still receiving as long as `B`
  can give.

Results:
* `exchange_lasts`: if exchange covers each node's upkeep, both last forever.
* `defection_pays_at_first`: in the first step, defecting leaves `A` better off
  by exactly what it no longer gives.
* `partner_falls`: if `B` cannot live on its own uptake, it dies after `A`
  defects, within its reserve plus one steps.
* `defector_falls_after_partner`: if `A` cannot live on its own uptake either,
  `A` dies too, after its partner: it outlives what it defected on by at most
  its own reserve.

So when neither node can live alone, which is what specialization means,
defection buys a windfall and then the defector's own end.  By symmetry the
same holds when the partner defects, so each node has a stake in the other
not defecting: in rules that bind both (`CommonsInterest`,
`sanction_makes_capture_unprofitable`).

Not covered: nodes that can find a new partner, partial defection, and more
than two nodes; `CommonsInterest` treats a whole of many specialists sharing
one commons.
-/

/-- The parameters of an exchange between two nodes. -/
structure Exchange where
  uA : Int
  uB : Int
  mA : Int
  mB : Int
  gA : Int
  gB : Int
  wA : Int
  wB : Int

/-- The two reserves. -/
structure Reserves where
  rA : Int
  rB : Int

/-- One step.  A node gives while it is alive, and `A` gives only if it has not
defected.  What `A` gives costs it `gA` and is worth `wA` to `B`, and the other
way round. -/
def step (e : Exchange) (defect : Bool) (s : Reserves) : Reserves :=
  let giveA : Bool := decide (0 ≤ s.rA) && !defect
  let giveB : Bool := decide (0 ≤ s.rB)
  { rA := s.rA + e.uA - e.mA - (if giveA then e.gA else 0) + (if giveB then e.wB else 0)
    rB := s.rB + e.uB - e.mB - (if giveB then e.gB else 0) + (if giveA then e.wA else 0) }

/-- The reserves over time. -/
def run (e : Exchange) (defect : Bool) (s0 : Reserves) : Nat → Reserves
  | 0 => s0
  | t + 1 => step e defect (run e defect s0 t)

/-- **Exchange lasts.**  If neither defects, and exchange covers each node's
upkeep, both reserves never fall: both last forever. -/
theorem exchange_lasts {e : Exchange} {s0 : Reserves}
    (hA : e.mA ≤ e.uA - e.gA + e.wB) (hB : e.mB ≤ e.uB - e.gB + e.wA)
    (h0A : 0 ≤ s0.rA) (h0B : 0 ≤ s0.rB) :
    ∀ t, s0.rA ≤ (run e false s0 t).rA ∧ s0.rB ≤ (run e false s0 t).rB := by
  intro t
  induction t with
  | zero => exact ⟨Int.le_refl _, Int.le_refl _⟩
  | succ t ih =>
    show s0.rA ≤ (step e false (run e false s0 t)).rA ∧
      s0.rB ≤ (step e false (run e false s0 t)).rB
    obtain ⟨ha, hb⟩ := ih
    generalize run e false s0 t = s at ha hb
    have pa : 0 ≤ s.rA := by omega
    have pb : 0 ≤ s.rB := by omega
    simp only [step, pa, pb, decide_true, Bool.not_false, Bool.and_self, ite_true]
    omega

/-- **Defection pays at first.**  While both are alive, defecting leaves `A`
better off after one step by exactly what it no longer gives, and leaves `B`
worse off by what that was worth to it. -/
theorem defection_pays_at_first {e : Exchange} {s0 : Reserves}
    (h0A : 0 ≤ s0.rA) (h0B : 0 ≤ s0.rB) :
    (run e true s0 1).rA = (run e false s0 1).rA + e.gA ∧
      (run e true s0 1).rB = (run e false s0 1).rB - e.wA := by
  show (step e true s0).rA = (step e false s0).rA + e.gA ∧
    (step e true s0).rB = (step e false s0).rB - e.wA
  simp only [step, h0A, h0B, decide_true, Bool.not_true, Bool.not_false, Bool.and_false,
    Bool.and_self, ite_true, Bool.false_eq_true, ite_false]
  constructor <;> omega

/-- After `A` defects, a node `B` that cannot live on its own uptake loses at
least one unit of reserve every step. -/
theorem partner_reserve_falls {e : Exchange} {s0 : Reserves}
    (hB : e.uB < e.mB) (hgB : 0 ≤ e.gB) :
    ∀ t, (run e true s0 t).rB ≤ s0.rB - t := by
  intro t
  induction t with
  | zero => show s0.rB ≤ s0.rB - ((0 : Nat) : Int); omega
  | succ t ih =>
    show (step e true (run e true s0 t)).rB ≤ s0.rB - ((t + 1 : Nat) : Int)
    generalize run e true s0 t = s at ih
    simp only [step, Bool.not_true, Bool.and_false]
    by_cases hb : 0 ≤ s.rB
    · simp only [hb, decide_true, ite_true]
      push_cast at ih ⊢
      omega
    · simp only [hb, decide_false]
      push_cast at ih ⊢
      omega

/-- **The partner falls.**  After `A` defects, a partner that cannot live on
its own uptake is dead from step `rB + 1` on. -/
theorem partner_falls {e : Exchange} {s0 : Reserves}
    (hB : e.uB < e.mB) (hgB : 0 ≤ e.gB) :
    ∀ t, s0.rB.toNat + 1 ≤ t → (run e true s0 t).rB < 0 := by
  intro t ht
  have h := partner_reserve_falls (s0 := s0) hB hgB t
  omega

/-- **The defector falls after its partner.**  If `A` cannot live on its own
uptake either, then after defecting it, too, is dead from some step on: it
outlives what it defected on by at most its own reserve. -/
theorem defector_falls_after_partner {e : Exchange} {s0 : Reserves}
    (hA : e.uA < e.mA) (hB : e.uB < e.mB) (hgB : 0 ≤ e.gB) :
    ∃ T, ∀ t, T ≤ t → (run e true s0 t).rA < 0 := by
  let TB := s0.rB.toNat + 1
  have hdeadB : ∀ t, TB ≤ t → (run e true s0 t).rB < 0 := partner_falls hB hgB
  have hfall : ∀ k, (run e true s0 (TB + k)).rA ≤ (run e true s0 TB).rA - k := by
    intro k
    induction k with
    | zero => show (run e true s0 (TB + 0)).rA ≤ (run e true s0 TB).rA - ((0 : Nat) : Int); simp
    | succ k ih =>
      show (step e true (run e true s0 (TB + k))).rA ≤
        (run e true s0 TB).rA - ((k + 1 : Nat) : Int)
      have hb := hdeadB (TB + k) (Nat.le_add_right _ _)
      generalize run e true s0 (TB + k) = s at ih hb
      have hb' : ¬ (0 ≤ s.rB) := by omega
      simp only [step, hb', decide_false, Bool.not_true, Bool.and_false]
      push_cast at ih ⊢
      omega
  refine ⟨TB + (run e true s0 TB).rA.toNat + 1, ?_⟩
  intro t ht
  have hk : t = TB + (t - TB) := by omega
  have h := hfall (t - TB)
  rw [← hk] at h
  omega

/-- A concrete case.  Each node takes in 2 and needs 3; giving costs 1 and is
worth 2 to the other.  Exchanging, both stay at a reserve of 1.  If `A`
defects, `A` is ahead after one step (2 against 1) and `B` is dead; `A` is
dead by step 4. -/
theorem reciprocity_witness :
    (run ⟨2, 2, 3, 3, 1, 1, 2, 2⟩ false ⟨1, 1⟩ 6).rA = 1 ∧
      (run ⟨2, 2, 3, 3, 1, 1, 2, 2⟩ false ⟨1, 1⟩ 6).rB = 1 ∧
      (run ⟨2, 2, 3, 3, 1, 1, 2, 2⟩ true ⟨1, 1⟩ 1).rA = 2 ∧
      (run ⟨2, 2, 3, 3, 1, 1, 2, 2⟩ true ⟨1, 1⟩ 1).rB < 0 ∧
      (run ⟨2, 2, 3, 3, 1, 1, 2, 2⟩ true ⟨1, 1⟩ 4).rA < 0 := by
  decide

end Reciprocity
end CumulativeAccessibility
