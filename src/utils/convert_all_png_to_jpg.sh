#!/bin/bash

for img in *.png; do
    filename=${img%.*}
    convert "$filename.png" -filter Lanczos -quality 98 -sampling-factor 1x1 "$filename.jpg"
done
