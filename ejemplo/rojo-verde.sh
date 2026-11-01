#!/usr/bin/env bash
# Demuestra el ciclo rojo → verde: el test de regresión falla con el bug y pasa con el arreglo.
set -euo pipefail
AQUI="$(cd "$(dirname "$0")" && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

cp "$AQUI/test_cuotas.py" "$TMP/"

echo "== Rojo: código con bug (debe fallar) =="
cp "$AQUI/con-bug/cuotas.py" "$TMP/"
if (cd "$TMP" && python3 -m unittest -q); then
  echo "ERROR: el test pasa con el bug, así que no prueba nada" >&2
  exit 1
fi

echo "== Verde: código arreglado (debe pasar) =="
cp "$AQUI/arreglado/cuotas.py" "$TMP/"
rm -rf "$TMP/__pycache__"
(cd "$TMP" && python3 -m unittest -q)
echo "Rojo → verde comprobado."
