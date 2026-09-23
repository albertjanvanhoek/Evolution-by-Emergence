"""Summarise the Lean axiom audit printed by `lake build`.

Usage: python scripts/audit_summary.py lean/build.log
Exits with status 1 if any result depends on `sorryAx` (an unfinished proof).
"""
import re
import sys

text = open(sys.argv[1] if len(sys.argv) > 1 else "lean/build.log").read()
# Lean may wrap long axiom lists over several lines; join them first.
text = re.sub(r"\n\s+", " ", text)
entries = {}
for name, rest in re.findall(r"'([^']+)' (does not depend on any axioms|depends on axioms: \[[^\]]*\])", text):
    entries[name] = rest

total = len(entries)
none = sum(1 for r in entries.values() if r.startswith("does not"))
classical = [n for n, r in entries.items() if "Classical.choice" in r]
sorry = [n for n, r in entries.items() if "sorryAx" in r]
std = total - none - len(classical) - len(sorry)

print(f"results audited:              {total}")
print(f"  with no axioms at all:      {none}")
print(f"  with standard axioms only:  {std}   (propext / Quot.sound)")
print(f"  using classical logic:      {len(classical)}")
for n in classical:
    print(f"      {n}")
print(f"  unfinished (sorry):         {len(sorry)}")
for n in sorry:
    print(f"      {n}")
sys.exit(1 if sorry or total == 0 else 0)
