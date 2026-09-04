#!/usr/bin/env bash
# Compiles PDFs with white theme
set -euo pipefail
cd "$(dirname "$0")"

command -v typst >/dev/null || { echo "error: typst not found in PATH" >&2; exit 1; }

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

for name in calculus prob_theory; do
  sed \
    -e 's|^#set text(white)$|// #set text(white)|' \
    -e 's|^#set page(fill: rgb("#303446"))$|// #set page(fill: rgb("#303446"))|' \
    "$name.typ" > "$tmpdir/$name.typ"

  typst compile "$tmpdir/$name.typ" "$name.pdf"
  echo "compiled $name.pdf"
done
