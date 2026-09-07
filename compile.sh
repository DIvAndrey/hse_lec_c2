#!/usr/bin/env bash
# Compiles notes to PDFs (white theme), recursively in all subdirectories.
#   *.typ — compiled directly (dark-theme lines commented out, as before)
#   *.md  — converted via pandoc -> typst, wrapped in a light theme, compiled
set -euo pipefail
cd "$(dirname "$0")"

command -v typst >/dev/null || { echo "error: typst not found in PATH" >&2; exit 1; }
if ! command -v pandoc >/dev/null 2>&1; then
  if [[ -x ".tools/pandoc" ]]; then
    PATH="$PWD/.tools:$PATH"
  else
    echo "error: pandoc not found in PATH (needed to convert .md)" >&2
    exit 1
  fi
fi

tmpdir="$(mktemp -d)"
tmpfiles=()
cleanup() {
  rm -rf "$tmpdir"
  local t
  for t in ${tmpfiles[@]+"${tmpfiles[@]}"}; do rm -f "$t"; done
}
trap cleanup EXIT

# ---- light theme prepended to every .md converted from markdown ----
read -r -d '' MD_PREAMBLE <<'EOF' || true
#set page(paper: "a4", margin: (x: 2cm, y: 2.2cm), numbering: "1")
#set text(font: "Libertinus Serif", size: 10pt, lang: "ru")
#set heading(numbering: none)
// pandoc's typst writer emits a *bare* #horizontalrule (or #divider, name differs across
// versions) for markdown "---", so these must be content, not functions: its own default
// template does `#let horizontalrule = line(...)`. `line.with(...)` returns a function, and
// inserting a bare function into markup just prints it as text, i.e. "(..) => ..".
#let divider = line(length: 100%, stroke: luma(180))
#let horizontalrule = divider
#show raw.where(block: true): block.with(
  fill: luma(245), inset: 8pt, radius: 4pt, width: 100%,
)
#show raw.where(block: false): box.with(fill: luma(240), inset: (x: 3pt, y: 0pt), outset: (y: 3pt), radius: 3pt)
#show link: underline
EOF

compile_typ() {
  local src="$1" out="${1%.typ}.pdf" dir base tmp
  dir="$(dirname "$src")"; base="$(basename "${src%.typ}")"
  tmp="$dir/.compile-$base.typ"; tmpfiles+=("$tmp")
  sed \
    -e 's|^#set text(white)$|// #set text(white)|' \
    -e 's|^#set page(fill: rgb("#303446"))$|// #set page(fill: rgb("#303446"))|' \
    "$src" > "$tmp"
  typst compile "$tmp" "$out"
  echo "compiled $out"
}

compile_md() {
  local src="$1" out="${1%.md}.pdf" dir base tmp
  dir="$(dirname "$src")"; base="$(basename "${src%.md}")"
  tmp="$dir/.compile-$base.typ"; tmpfiles+=("$tmp")
  pandoc "$src" -f markdown -t typst -o "$tmpdir/body.typ"
  { printf '%s\n' "$MD_PREAMBLE"; cat "$tmpdir/body.typ"; } > "$tmp"
  typst compile "$tmp" "$out"
  echo "compiled $out"
}

shopt -s nullglob globstar
count=0
for f in **/*.typ **/*.md; do
  [[ -f "$f" ]] || continue
  base="$(basename "$f")"
  [[ "$base" == .* ]] && continue            # skip hidden/temp files
  if [[ "$f" == *.typ ]]; then compile_typ "$f"; else compile_md "$f"; fi
  count=$((count + 1))
done

echo "done: $count file(s) compiled"
