# 4D SU(2): frustration of the centre sector

Pilot for [`../../NOTE_SU2_FRUSTRATION.md`](../../NOTE_SU2_FRUSTRATION.md).

- `su2.py`: Wilson action, Kennedy–Pendleton heatbath + overrelaxation, Wilson loops, direct maximal centre gauge.
- `test_su2.py`: checks (quaternion algebra, gauge invariance, staples, plaquette values).
- `frustration.py BETA [L] [NCONF] [SEED]`: writes `frustration_b{BETA}_L{L}_s{SEED}.json` (per configuration and a summary).
- `plot_frustration.py`: makes `frustration_su2.png` from `out/`.

Runs used in the note: `python frustration.py BETA 8 20 1` for BETA in 2.0 2.2 2.3 2.4 2.5 2.6 2.8 3.0 3.5 (numpy, scipy; about 1–3 minutes per β on one core).

Step 2, Z₂ monopoles forbidden:
- `nomono.py BETA MODE [L] [NCONF] [SEED]`, MODE = `nomono` or `wilson`: same measurements for both actions (Wilson loops up to 3×3, Creutz ratios, negative plaquettes and their clusters, Z₂ flux per plane, centre-sector frustration after DMCG). Writes `{MODE}_b{BETA}_L{L}_s{SEED}.json`.
- Runs used in the note (`out2/`): `nomono` at β = 1.6, 2.0, 2.3 and `wilson` at β = 2.2, 2.4, 2.6, 2.8, all `8 12 2` (about 6 minutes per `nomono` run on one core).
