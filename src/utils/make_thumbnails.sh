#!/bin/bash

THUMB_DIR="thumbs"

mkdir "${THUMB_DIR}"

for filename in ./*.jpg; do
  basename="$(basename "$filename" .jpg)"

  convert "./$basename.jpg" -filter Lanczos -resize 500x -unsharp 1.5x1+0.7+0.02 -quality 75 -sampling-factor 1x1 "${THUMB_DIR}/$basename.jpg"

  echo -n "."
done

echo ""

exit 0
