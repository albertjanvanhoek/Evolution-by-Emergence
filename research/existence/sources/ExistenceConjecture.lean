/-!
Registered maintenance-response conjecture: a proposed empirical bridge.

Status: definition of a proposition, NOT an established result.
No imports or additional axioms. Intended for core Lean 4.
This file has not been compiler-checked: the local Lean 4.33.0 executable
could not start because its /proc executable-path lookup was denied.

Interpret this only for an independently calibrated, preregistered experiment.
Do not quantify the claim over arbitrary ledgers or define `observed` by
`LedgerSafe`. Such a move would respectively make it false or circular.

Generalizes:
  EndogenousBudgetBridge.InternalSlackAt
  AdaptivePersistence.reserve
  NetworkVortexLedger.PartSlackAt
  CareTransfer.carerReserve and its componentwise version
  ResponseDynamics.ResourceFeasibleAt / ResourceValidatedSuccessAt

Differences: finite resource vector, explicit observation histories, causal
policies, finite horizon, and an independent operational predicate.
-/

namespace EbEExistenceSketch

abbrev Policy (O A : Nat) := List (Fin O) → Fin A
abbrev Course (W : Nat) := Nat → Fin W
abbrev History (W A : Nat) := List (Fin W × Fin A)

/-- A model fixed before the evaluation runs. Each coordinate has its own
units and floor, normalized to zero. `transfer` is signed. Its conservation,
capacity, delay and loss restrictions must be specified in `allowed`.
The functions can reconstruct a model state from the finite past history.
-/
structure Ledger (W O A K : Nat) where
  initial : Fin K → Int
  capacity : Fin K → Int
  observe : History W A → Fin W → Fin O
  uptake : History W A → Fin W → Fin A → Fin K → Int
  upkeep : History W A → Fin W → Fin A → Fin K → Int
  transfer : History W A → Fin W → Fin A → Fin K → Int
  responseCost : History W A → Fin W → Fin A → Fin K → Int
  allowed : History W A → Fin W → Fin A → Prop

structure Frame (W O A K : Nat) where
  past : History W A
  seen : List (Fin O)
  buffer : Fin K → Int

def WellFormed {W O A K : Nat} (m : Ledger W O A K) : Prop :=
  0 < W ∧ 0 < O ∧ 0 < A ∧ 0 < K ∧
  (∀ i, 0 ≤ m.initial i ∧ m.initial i ≤ m.capacity i) ∧
  (∀ h w a i, 0 ≤ m.uptake h w a i ∧
    0 ≤ m.upkeep h w a i ∧ 0 ≤ m.responseCost h w a i)

def net {W O A K : Nat} (m : Ledger W O A K)
    (h : History W A) (w : Fin W) (a : Fin A) (i : Fin K) : Int :=
  m.uptake h w a i + m.transfer h w a i -
    m.upkeep h w a i - m.responseCost h w a i

def actionAt {W O A K : Nat} (m : Ledger W O A K)
    (p : Policy O A) (s : Frame W O A K) (w : Fin W) : Fin A :=
  p (s.seen ++ [m.observe s.past w])

def advance {W O A K : Nat} (m : Ledger W O A K)
    (p : Policy O A) (s : Frame W O A K) (w : Fin W) : Frame W O A K :=
  let o := m.observe s.past w
  let a := p (s.seen ++ [o])
  { past := s.past ++ [(w, a)]
    seen := s.seen ++ [o]
    buffer := fun i => min (m.capacity i) (s.buffer i + net m s.past w a i) }

/-- A negative modeled buffer is a predicted violation. It is deliberately
not clamped to zero. No claim that physical fuel can be negative is made.
-/
def run {W O A K : Nat} (m : Ledger W O A K)
    (p : Policy O A) (e : Course W) : Nat → Frame W O A K
  | 0 => { past := [], seen := [], buffer := m.initial }
  | t + 1 => advance m p (run m p e t) (e t)

def LedgerSafe {W O A K : Nat} (m : Ledger W O A K)
    (p : Policy O A) (e : Course W) (T : Nat) : Prop :=
  (∀ t, t ≤ T → ∀ i, 0 ≤ (run m p e t).buffer i) ∧
  (∀ t, t < T →
    let s := run m p e t
    m.allowed s.past (e t) (actionAt m p s (e t)))

def RobustFeasible {W O A K : Nat} (m : Ledger W O A K)
    (admissible : Course W → Prop) (p : Policy O A) (T : Nat) : Prop :=
  ∀ e, admissible e → LedgerSafe m p e T

/-- `observed` is independently assessed service/organizational continuity
of the physical implementation of p; it must not be defined by this ledger.
The observation interface and policy implementation are part of the fixed
experiment. The same policy must work across every admissible course.
-/
def RobustOperational {W O A : Nat}
    (admissible : Course W → Prop)
    (observed : Policy O A → Course W → Nat → Prop)
    (p : Policy O A) (T : Nat) : Prop :=
  ∀ e, admissible e → ∀ t, t ≤ T → observed p e t

/-- CONJECTURE for a registered model/experiment, not for every arbitrary
choice of its arguments. WellFormed, a nonempty admissible class, calibration,
identity criteria, error bounds and the horizon are registration requirements.
This is necessity only: no converse is asserted.
-/
def ExistenceConjecture {W O A K : Nat} (m : Ledger W O A K)
    (admissible : Course W → Prop)
    (observed : Policy O A → Course W → Nat → Prop)
    (T : Nat) : Prop :=
  ∀ p, RobustOperational admissible observed p T →
    RobustFeasible m admissible p T

end EbEExistenceSketch
