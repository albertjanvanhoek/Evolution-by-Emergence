#!/usr/bin/env bash
# Verify everything in this repository from scratch.
#   scripts/verify.sh           Lean proofs + seed + audit
#   scripts/verify.sh --sims    also run the simulations in quick mode (in a temporary copy)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT/lean"

if ! command -v lake >/dev/null 2>&1; then
  echo "Lean is not installed. Install elan: https://github.com/leanprover/elan" >&2
  exit 1
fi

echo "== 1. The seed (one file, no library) =="
lake env lean ../seed/Seed.lean

echo
echo "== 2. The full development and its axiom audit =="
lake build 2>&1 | tee build.log | grep -E "error|warning: declaration uses 'sorry'|Build completed" || true
python3 "$ROOT/scripts/audit_summary.py" build.log

if [[ "${1:-}" == "--sims" ]]; then
  echo
  echo "== 3. Simulations, quick mode (in a temporary copy; committed results are untouched) =="
  TMP="$(mktemp -d)"
  cp -r "$ROOT/sim" "$TMP/"
  (cd "$TMP/sim" && python3 experiments.py --quick >/dev/null && python3 fragmentation_experiments.py --quick >/dev/null)
  echo "simulations ran without error"
  rm -rf "$TMP"
fi
echo
echo "All checks passed."
