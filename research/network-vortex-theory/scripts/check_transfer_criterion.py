#!/usr/bin/env python3
"""Check the paid transfer criterion in a cost specialization.

Transfer is deliberately evaluated on an unvisited target. Retention can
help, do nothing, or hurt after upkeep is charged.
"""

from dataclasses import dataclass


@dataclass(frozen=True)
class Case:
    scratch_cost: float
    retained_run_cost: float
    upkeep: float

    @property
    def net_transfer(self) -> float:
        return self.scratch_cost - (self.upkeep + self.retained_run_cost)

    @property
    def transfers(self) -> bool:
        return self.net_transfer > 0


def main():
    cases = [
        # positive transfer
        Case(scratch_cost=10.0, retained_run_cost=4.0, upkeep=2.0),
        # neutral
        Case(scratch_cost=10.0, retained_run_cost=8.0, upkeep=2.0),
        # burden
        Case(scratch_cost=10.0, retained_run_cost=9.0, upkeep=2.0),
    ]

    assert cases[0].transfers
    assert cases[1].net_transfer == 0
    assert not cases[2].transfers

    # Repetition can amortize paid retention.
    scratch = 6.0
    reuse = 1.0
    upkeep = 7.0
    outcomes = []
    for n in range(1, 8):
        no_retention = n * scratch
        with_retention = scratch + upkeep + n * reuse
        outcomes.append(with_retention < no_retention)

    assert outcomes[:2] == [False, False]
    assert any(outcomes[2:])

    print("PASS: paid transfer can succeed, fail, or emerge only after reuse")


if __name__ == "__main__":
    main()
