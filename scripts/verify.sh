#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."

report=$(lean -DwarningAsError=true Graffiti256.lean 2>&1) || {
  printf '%s\n' "$report" >&2
  exit 1
}
printf '%s\n' "$report"
expected="'Graffiti256.conjecture256_false' depends on axioms: [propext, Classical.choice, Quot.sound]"
if ! printf '%s\n' "$report" | tr -d '\r' | grep -Fxq "$expected"; then
  printf '%s\n' 'Unexpected axiom report.' >&2
  exit 1
fi
