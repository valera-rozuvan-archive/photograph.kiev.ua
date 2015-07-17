#!/bin/bash

for img in *.jpeg; do
    filename=${img%.*}
    convert "$filename.jpeg" -filter Lanczos -quality 98 -sampling-factor 1x1 "$filename.jpg"
done
