import Mathlib

open scoped BigOperators

namespace FixedResolution

/-- Material accounting bounds the number of independently counted realizations. -/
theorem realization_bound
    (N : ℕ → ℝ) (Mstar mmin : ℝ)
    (hmmin : 0 < mmin)
    (halloc : ∀ n, N n * mmin ≤ Mstar) :
    ∀ n, N n ≤ Mstar / mmin := by
  intro n
  exact (le_div_iff₀ hmmin).2 (halloc n)

/-- The OA decomposition `lambda = N * nu * p` is uniformly bounded when
material, per-realization generation, and probability are bounded. -/
theorem accessibility_rate_bound
    (N nu p : ℕ → ℝ) (Mstar mmin numax : ℝ)
    (hMstar : 0 ≤ Mstar)
    (hmmin : 0 < mmin)
    (hnumax : 0 ≤ numax)
    (hN0 : ∀ n, 0 ≤ N n)
    (halloc : ∀ n, N n * mmin ≤ Mstar)
    (hnu0 : ∀ n, 0 ≤ nu n)
    (hnub : ∀ n, nu n ≤ numax)
    (hp0 : ∀ n, 0 ≤ p n)
    (hpb : ∀ n, p n ≤ 1) :
    ∀ n, N n * nu n * p n ≤ (Mstar / mmin) * numax := by
  intro n
  have hN : N n ≤ Mstar / mmin := realization_bound N Mstar mmin hmmin halloc n
  have hNmax0 : 0 ≤ Mstar / mmin := div_nonneg hMstar hmmin.le
  have hNnu : N n * nu n ≤ (Mstar / mmin) * numax :=
    mul_le_mul hN (hnub n) (hnu0 n) hNmax0
  have hNnu0 : 0 ≤ N n * nu n := mul_nonneg (hN0 n) (hnu0 n)
  have hmul := mul_le_mul hNnu (hpb n) (hp0 n) (mul_nonneg hNmax0 hnumax)
  simpa using hmul

/-- If positive rates are uniformly bounded above, their reciprocal partial sums
have a linear lower bound. This is the deterministic core of the C-route
non-explosion argument. -/
theorem reciprocal_partial_sum_lower_bound
    (lambda : ℕ → ℝ) (Lambda : ℝ)
    (hLambda : 0 < Lambda)
    (hlambda0 : ∀ n, 0 < lambda n)
    (hlambdab : ∀ n, lambda n ≤ Lambda)
    (k : ℕ) :
    (k : ℝ) / Lambda ≤ ∑ n in Finset.range k, 1 / lambda n := by
  have hs :
      ∑ n in Finset.range k, (1 / Lambda : ℝ) ≤
        ∑ n in Finset.range k, 1 / lambda n := by
    refine Finset.sum_le_sum ?_
    intro n hn
    exact one_div_le_one_div_of_le (hlambda0 n) (hlambdab n)
  simpa [div_eq_mul_inv] using hs

/-- A uniformly bounded positive rate sequence has a nonsummable reciprocal
series. -/
theorem reciprocal_not_summable
    (lambda : ℕ → ℝ) (Lambda : ℝ)
    (hLambda : 0 < Lambda)
    (hlambda0 : ∀ n, 0 < lambda n)
    (hlambdab : ∀ n, lambda n ≤ Lambda) :
    ¬ Summable (fun n => 1 / lambda n) := by
  intro hs
  have hzero : Filter.Tendsto (fun n => 1 / lambda n) Filter.atTop (nhds 0) :=
    hs.tendsto_atTop_zero
  have hpos : 0 < (1 / Lambda : ℝ) := one_div_pos.mpr hLambda
  have hev : ∀ᶠ n in Filter.atTop, 1 / lambda n < 1 / Lambda :=
    ((tendsto_order.1 hzero).2 _ hpos)
  filter_upwards [hev] with n hn
  have hlo : 1 / Lambda ≤ 1 / lambda n :=
    one_div_le_one_div_of_le (hlambda0 n) (hlambdab n)
  linarith

/-- Finite-prefix weighted action inequality. This is Cauchy--Schwarz applied
under the pointwise speed--distance constraint. -/
theorem weighted_finite_action_sq
    {ι : Type*} [DecidableEq ι]
    (s : Finset ι) (eps tau c d : ι → ℝ)
    (heps : ∀ i ∈ s, 0 ≤ eps i)
    (htau : ∀ i ∈ s, 0 ≤ tau i)
    (hc : ∀ i ∈ s, 0 ≤ c i)
    (haction : ∀ i ∈ s, c i * (d i) ^ 2 ≤ eps i * tau i) :
    (∑ i ∈ s, Real.sqrt (c i) * d i) ^ 2 ≤
      (∑ i ∈ s, eps i) * (∑ i ∈ s, tau i) := by
  apply Finset.sum_sq_le_sum_mul_sum_of_sq_le_mul s heps htau
  intro i hi
  calc
    (Real.sqrt (c i) * d i) ^ 2
        = c i * (d i) ^ 2 := by
            rw [mul_pow, Real.sq_sqrt (hc i hi)]
    _ ≤ eps i * tau i := haction i hi

/-- Uniform-coefficient squared finite-action bound. -/
theorem finite_action_sq
    {ι : Type*} [DecidableEq ι]
    (s : Finset ι) (eps tau d : ι → ℝ) (c : ℝ)
    (heps : ∀ i ∈ s, 0 ≤ eps i)
    (htau : ∀ i ∈ s, 0 ≤ tau i)
    (hd : ∀ i ∈ s, 0 ≤ d i)
    (hc : 0 ≤ c)
    (haction : ∀ i ∈ s, c * (d i) ^ 2 ≤ eps i * tau i) :
    c * (∑ i ∈ s, d i) ^ 2 ≤
      (∑ i ∈ s, eps i) * (∑ i ∈ s, tau i) := by
  have hweighted := weighted_finite_action_sq s eps tau (fun _ => c) d heps htau
    (fun _ _ => hc) (fun i hi => haction i hi)
  have hsqrt : (Real.sqrt c) ^ 2 = c := Real.sq_sqrt hc
  have hsum :
      (∑ i ∈ s, Real.sqrt c * d i) = Real.sqrt c * ∑ i ∈ s, d i := by
    rw [Finset.mul_sum]
  rw [hsum, mul_pow, hsqrt] at hweighted
  exact hweighted

/-- Manuscript form of the finite-action bound. -/
theorem finite_action_bound
    {ι : Type*} [DecidableEq ι]
    (s : Finset ι) (eps tau d : ι → ℝ) (c : ℝ)
    (heps : ∀ i ∈ s, 0 ≤ eps i)
    (htau : ∀ i ∈ s, 0 ≤ tau i)
    (hd : ∀ i ∈ s, 0 ≤ d i)
    (hc : 0 < c)
    (haction : ∀ i ∈ s, c * (d i) ^ 2 ≤ eps i * tau i) :
    (∑ i ∈ s, d i) ≤
      (1 / Real.sqrt c) *
        Real.sqrt ((∑ i ∈ s, eps i) * (∑ i ∈ s, tau i)) := by
  have hsq := finite_action_sq s eps tau d c heps htau hd hc.le haction
  have hE : 0 ≤ ∑ i ∈ s, eps i := Finset.sum_nonneg heps
  have hT : 0 ≤ ∑ i ∈ s, tau i := Finset.sum_nonneg htau
  have hET : 0 ≤ (∑ i ∈ s, eps i) * (∑ i ∈ s, tau i) := mul_nonneg hE hT
  have hcroot : 0 < Real.sqrt c := Real.sqrt_pos.2 hc
  have hD : 0 ≤ ∑ i ∈ s, d i := Finset.sum_nonneg hd
  have hleft0 : 0 ≤ Real.sqrt c * (∑ i ∈ s, d i) := mul_nonneg hcroot.le hD
  have hright0 : 0 ≤ Real.sqrt ((∑ i ∈ s, eps i) * (∑ i ∈ s, tau i)) :=
    Real.sqrt_nonneg _
  have hsquares :
      (Real.sqrt c * (∑ i ∈ s, d i)) ^ 2 ≤
        (Real.sqrt ((∑ i ∈ s, eps i) * (∑ i ∈ s, tau i))) ^ 2 := by
    rw [mul_pow, Real.sq_sqrt hc.le, Real.sq_sqrt hET]
    exact hsq
  have hlin :
      Real.sqrt c * (∑ i ∈ s, d i) ≤
        Real.sqrt ((∑ i ∈ s, eps i) * (∑ i ∈ s, tau i)) :=
    (sq_le_sq₀ hleft0 hright0).mp hsquares
  apply (le_div_iff₀ hcroot).2
  simpa [div_eq_mul_inv, mul_comm, mul_left_comm, mul_assoc] using hlin

/-- Fixed-resolution counting in squared form. If every counted transition has
physical distance at least `delta`, then its cardinality is controlled by the
same finite-action budget. -/
theorem fixed_resolution_count_sq
    {ι : Type*} [DecidableEq ι]
    (s : Finset ι) (eps tau d : ι → ℝ) (c delta : ℝ)
    (heps : ∀ i ∈ s, 0 ≤ eps i)
    (htau : ∀ i ∈ s, 0 ≤ tau i)
    (hd : ∀ i ∈ s, 0 ≤ d i)
    (hc : 0 ≤ c)
    (hdelta : 0 ≤ delta)
    (hresolved : ∀ i ∈ s, delta ≤ d i)
    (haction : ∀ i ∈ s, c * (d i) ^ 2 ≤ eps i * tau i) :
    c * (((s.card : ℕ) : ℝ) * delta) ^ 2 ≤
      (∑ i ∈ s, eps i) * (∑ i ∈ s, tau i) := by
  have hsum := finite_action_sq s eps tau d c heps htau hd hc haction
  have hcount : ((s.card : ℕ) : ℝ) * delta ≤ ∑ i ∈ s, d i := by
    have h := Finset.sum_le_sum hresolved
    simpa using h
  have hcount0 : 0 ≤ ((s.card : ℕ) : ℝ) * delta :=
    mul_nonneg (by positivity) hdelta
  have hD : 0 ≤ ∑ i ∈ s, d i := Finset.sum_nonneg hd
  have hsqcount : (((s.card : ℕ) : ℝ) * delta) ^ 2 ≤ (∑ i ∈ s, d i) ^ 2 :=
    (sq_le_sq₀ hcount0 hD).2 hcount
  exact (mul_le_mul_of_nonneg_left hsqcount hc).trans hsum

/-- Fixed-resolution counting in manuscript form. -/
theorem fixed_resolution_count_bound
    {ι : Type*} [DecidableEq ι]
    (s : Finset ι) (eps tau d : ι → ℝ) (c delta : ℝ)
    (heps : ∀ i ∈ s, 0 ≤ eps i)
    (htau : ∀ i ∈ s, 0 ≤ tau i)
    (hd : ∀ i ∈ s, 0 ≤ d i)
    (hc : 0 < c)
    (hdelta : 0 < delta)
    (hresolved : ∀ i ∈ s, delta ≤ d i)
    (haction : ∀ i ∈ s, c * (d i) ^ 2 ≤ eps i * tau i) :
    ((s.card : ℕ) : ℝ) * delta ≤
      (1 / Real.sqrt c) *
        Real.sqrt ((∑ i ∈ s, eps i) * (∑ i ∈ s, tau i)) := by
  have hdist := finite_action_bound s eps tau d c heps htau hd hc haction
  have hcount : ((s.card : ℕ) : ℝ) * delta ≤ ∑ i ∈ s, d i := by
    have h := Finset.sum_le_sum hresolved
    simpa using h
  exact hcount.trans hdist

/-- Weighted finite-action bound in manuscript form. -/
theorem weighted_finite_action_bound
    {ι : Type*} [DecidableEq ι]
    (s : Finset ι) (eps tau c d : ι → ℝ)
    (heps : ∀ i ∈ s, 0 ≤ eps i)
    (htau : ∀ i ∈ s, 0 ≤ tau i)
    (hc : ∀ i ∈ s, 0 ≤ c i)
    (hd : ∀ i ∈ s, 0 ≤ d i)
    (haction : ∀ i ∈ s, c i * (d i) ^ 2 ≤ eps i * tau i) :
    (∑ i ∈ s, Real.sqrt (c i) * d i) ≤
      Real.sqrt ((∑ i ∈ s, eps i) * (∑ i ∈ s, tau i)) := by
  have hsq := weighted_finite_action_sq s eps tau c d heps htau hc haction
  have hleft0 : 0 ≤ ∑ i ∈ s, Real.sqrt (c i) * d i := by
    exact Finset.sum_nonneg fun i hi => mul_nonneg (Real.sqrt_nonneg _) (hd i hi)
  have hE : 0 ≤ ∑ i ∈ s, eps i := Finset.sum_nonneg heps
  have hT : 0 ≤ ∑ i ∈ s, tau i := Finset.sum_nonneg htau
  have hET : 0 ≤ (∑ i ∈ s, eps i) * (∑ i ∈ s, tau i) := mul_nonneg hE hT
  have hright0 : 0 ≤ Real.sqrt ((∑ i ∈ s, eps i) * (∑ i ∈ s, tau i)) :=
    Real.sqrt_nonneg _
  have hsquares :
      (∑ i ∈ s, Real.sqrt (c i) * d i) ^ 2 ≤
        (Real.sqrt ((∑ i ∈ s, eps i) * (∑ i ∈ s, tau i))) ^ 2 := by
    rw [Real.sq_sqrt hET]
    exact hsq
  exact (sq_le_sq₀ hleft0 hright0).mp hsquares

end FixedResolution
