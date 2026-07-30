#!/usr/bin/env bash
# Pull the current series from the live endpoints. The last two months of each
# file are provisional by design; see the README before quoting a headline.
set -euo pipefail
base="https://datahabibi.ae/api/data/price-index.csv"
curl -fsS -o data/dubai-price-index-monthly.csv "$base"
curl -fsS -o data/dubai-rent-index-monthly.csv  "$base?series=rent"
echo "sale: $(( $(wc -l < data/dubai-price-index-monthly.csv) - 1 )) months"
echo "rent: $(( $(wc -l < data/dubai-rent-index-monthly.csv) - 1 )) months"
