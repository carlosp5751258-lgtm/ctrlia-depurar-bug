#!/usr/bin/env bash
# Demonstrates the red → green cycle: the regression test fails with the bug and passes with the fix.
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

cp "$HERE/test_cuotas.py" "$TMP/"

echo "== Red: buggy code (must fail) =="
cp "$HERE/con-bug/cuotas.py" "$TMP/"
if (cd "$TMP" && python3 -m unittest -q); then
  echo "ERROR: the test passes with the bug, so it proves nothing" >&2
  exit 1
fi

echo "== Green: fixed code (must pass) =="
cp "$HERE/arreglado/cuotas.py" "$TMP/"
rm -rf "$TMP/__pycache__"
(cd "$TMP" && python3 -m unittest -q)
echo "Red → green confirmed."
