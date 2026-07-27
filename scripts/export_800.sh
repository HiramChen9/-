#!/bin/sh
set -eu

if [ "$#" -lt 3 ] || [ "$1" != "--output-dir" ]; then
  echo "usage: export_800.sh --output-dir DIR IMAGE [IMAGE ...]" >&2
  exit 2
fi

output_dir=$2
shift 2
mkdir -p "$output_dir"

for source in "$@"; do
  if [ ! -f "$source" ]; then
    echo "input does not exist: $source" >&2
    exit 2
  fi

  filename=${source##*/}
  stem=${filename%.*}
  output="$output_dir/$stem-800.png"

  /usr/bin/sips \
    --resampleHeightWidthMax 800 \
    --padToHeightWidth 800 800 \
    --padColor FFFFFF \
    "$source" \
    --out "$output" >/dev/null

  echo "$output"
done
