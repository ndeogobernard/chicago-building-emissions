#!/usr/bin/env bash
# Build the report PDF: Markdown -> standalone HTML (pandoc) -> PDF (headless Chromium).
# Run from this folder after running Parts 1-3, which write the figures in figures/.
set -euo pipefail
pandoc issifu_bernard_buildings_report.md -o issifu_bernard_buildings_report.html \
  --standalone --embed-resources --css report.css
CHROME="${CHROME:-chromium}"
"$CHROME" --headless --no-sandbox --disable-gpu --no-pdf-header-footer \
  --print-to-pdf="$PWD/issifu_bernard_buildings_report.pdf" "file://$PWD/issifu_bernard_buildings_report.html"
