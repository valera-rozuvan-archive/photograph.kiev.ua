#!/bin/bash

find . -name '*.*' -print0 | while IFS= read -r -d '' f
do
  base=${f%.*}
  ext=${f##*.}
  a=$base.${ext,,}
  [ "$a" != "$f" ] && mv -- "$f" "$a"
done

exit 0
