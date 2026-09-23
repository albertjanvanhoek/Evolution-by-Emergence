"""Regression tests for numerical endpoints and model-scope counterexamples."""
import math
import unittest

import numpy as np

from crm import (CRM, Ledger, arity2_critical_mass, arity2_time_to,
                 birth_death_hit_prob, generator, gillespie, linear_extinction_prob,
                 ode_trajectory, project_down, transient_distribution)


class FixedRNG:
    def exponential(self, scale):
        return 100.0

    def random(self):
        return 0.0


class CRMTests(unittest.TestCase):
    def test_linear_critical_hitting_is_not_survival(self):
        m = CRM(alpha={1: 1.0})
        self.assertAlmostEqual(birth_death_hit_prob(m, 3, 100), 0.03)
        self.assertEqual(linear_extinction_prob(1.0, 3), 1.0)
        self.assertEqual(linear_extinction_prob(0.0, 3), 1.0)

    def test_linear_hitting_closed_form(self):
        for r in (0.5, 0.9, 1.01, 2.0):
            m = CRM(alpha={1: r})
            expected = (1 - r ** -3) / (1 - r ** -20)
            self.assertAlmostEqual(birth_death_hit_prob(m, 3, 20), expected)

    def test_pairwise_formula_matches_numerical_ode(self):
        m = CRM(alpha={2: 0.2})
        self.assertAlmostEqual(arity2_critical_mass(m), 11.0)
        ts, ns = ode_trajectory(m, 20.0, 2.0, 2000)
        self.assertAlmostEqual(ns[-1], 2000, places=5)
        self.assertAlmostEqual(ts[-1], arity2_time_to(m, 20, 2000), places=6)

    def test_ledger_scale_invariance_and_integer_admission(self):
        for n in range(50):
            a, b = Ledger(20, 1, 3), Ledger(140, 7, 21)
            self.assertEqual(a.affordable(n), b.affordable(n))
        m = CRM(alpha={1: 4.0}, ledger=Ledger(10.5, 0, 1))
        self.assertGreater(m.P(9), 0)
        self.assertEqual(m.P(10), 0)
        for eta in (1, 2):
            self.assertTrue(Ledger(0, eta, 1).affordable(10**6))

    def test_initial_projection_and_terminal_state_without_recording(self):
        m = CRM(delta=0, ledger=Ledger(8, 0, 1))
        r = gillespie(m, 20, 2, record=False)
        self.assertEqual(r.n[-1], 8)
        self.assertEqual(r.t_end, 2)

    def test_future_shock_cannot_pass_horizon(self):
        class Schedule:
            breaks = [10.0]
            def __call__(self, t):
                return Ledger(1 if t >= 10 else 100, 0, 1)
        m = CRM(delta=0.01)
        r = gillespie(m, 20, 5, rng=FixedRNG(), ledger_schedule=Schedule())
        self.assertEqual(r.t[-1], 5)
        self.assertEqual(r.n[-1], 20)
        self.assertEqual(m.ledger.B0, 100)

    def test_zero_rate_interval_can_restart_at_breakpoint(self):
        class Schedule:
            breaks = [1.0]
            def __call__(self, t):
                return Ledger(10 if t >= 1 else 0, 0, 0)
        r = gillespie(CRM(mode='effort', delta=0), 0, 2,
                      rng=np.random.default_rng(23), ledger_schedule=Schedule())
        self.assertGreater(r.n[-1], 0)
        self.assertEqual(r.t[-1], 2)

    def test_missing_schedule_breakpoints_rejected(self):
        with self.assertRaises(ValueError):
            gillespie(CRM(), 1, 2, ledger_schedule=lambda t: Ledger())

    def test_event_limit_is_not_silently_counted_as_survival(self):
        with self.assertRaises(RuntimeError):
            gillespie(CRM(delta=0, alpha={1: 2}), 1, 10,
                      rng=np.random.default_rng(1), max_events=1)

    def test_ctmc_conserves_probability(self):
        m = CRM(alpha={2: 0.2}, ledger=Ledger(15, 0, 1))
        Q = generator(m, 15)
        np.testing.assert_allclose(Q.sum(axis=1), 0, atol=1e-13)
        p = np.zeros(16); p[15] = 1
        pt = transient_distribution(m, p, 3, 15)
        self.assertAlmostEqual(pt.sum(), 1)
        self.assertGreaterEqual(pt.min(), -1e-13)
        projected = project_down(pt, 5)
        self.assertAlmostEqual(projected.sum(), 1)
        self.assertEqual(projected[6:].sum(), 0)

    def test_below_threshold_has_positive_finite_survival(self):
        m = CRM(alpha={2: 0.2}, ledger=Ledger(8, 0, 1))
        p = np.zeros(9); p[8] = 1
        surv = transient_distribution(m, p, 1, 8)[1:].sum()
        self.assertGreater(surv, 0.0)
        self.assertLess(surv, 1.0)

    def test_finite_cap_above_threshold_still_absorbs(self):
        m = CRM(alpha={2: 0.2}, ledger=Ledger(12, 0, 1))
        p = np.zeros(13); p[12] = 1
        surv = transient_distribution(m, p, 1000, 12)[1:].sum()
        self.assertLess(surv, 1e-10)

    def test_leverage_does_not_imply_an_upcrossing(self):
        m = CRM(mode='effort', phi=0.05, beta=0.2, ledger=Ledger(100, 1, 1))
        self.assertGreater(m.Rc(10), m.Rc(100))
        self.assertGreater(m.Rc(100), 1.0)

    def test_balanced_effort_has_linear_mean_only_at_critical_coefficient(self):
        m = CRM(mode='effort', phi=0.05, beta=0.2, ledger=Ledger(100, 1, 1))
        ts, ns = ode_trajectory(m, 20, 3)
        self.assertAlmostEqual(ns[-1], 35, places=7)
        m.phi = 0.1
        self.assertGreater(m.P_raw(100) - m.L(100), 10)

    def test_ode_ceiling_is_K_not_K_minus_one(self):
        m = CRM(delta=1, alpha={1: 4}, ledger=Ledger(10, 0, 1))
        ts, ns = ode_trajectory(m, 5, 3)
        self.assertAlmostEqual(ns[-1], 10)
        self.assertEqual(ts[-1], 3)

    def test_short_shock_can_leave_recovery_possible(self):
        m = CRM(alpha={2: 0.2}, ledger=Ledger(8, 0, 1))
        p = np.zeros(41); p[8] = 1
        pt = transient_distribution(m, p, 0.01, 40)
        m.ledger = Ledger(40, 0, 1)
        recovery = sum(pt[n] * birth_death_hit_prob(m, n, 30) for n in range(2, 30))
        self.assertGreater(recovery, 0.01)

    def test_zero_denominator_Rc_is_undefined(self):
        self.assertTrue(math.isnan(CRM().Rc(0)))


if __name__ == '__main__':
    unittest.main()
