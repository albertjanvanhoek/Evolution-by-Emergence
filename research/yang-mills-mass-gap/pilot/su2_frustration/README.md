# 4D SU(2): frustration of the centre sector

Pilot for [`../../NOTE_SU2_FRUSTRATION.md`](../../NOTE_SU2_FRUSTRATION.md).

- `su2.py`: Wilson action, Kennedy–Pendleton heatbath + overrelaxation, Wilson loops, direct maximal centre gauge.
- `test_su2.py`: checks (quaternion algebra, gauge invariance, staples, plaquette values).
- `frustration.py BETA [L] [NCONF] [SEED]`: writes `frustration_b{BETA}_L{L}_s{SEED}.json` (per configuration and a summary).
- `plot_frustration.py`: makes `frustration_su2.png` from `out/`.

Runs used in the note: `python frustration.py BETA 8 20 1` for BETA in 2.0 2.2 2.3 2.4 2.5 2.6 2.8 3.0 3.5 (numpy, scipy; about 1–3 minutes per β on one core).
