#!/bin/bash

MP_DIR="8mp_photos"

mkdir "${MP_DIR}"

newline=1

for img in *.jpg; do
    OUTPUT="$(identify -verbose $img | grep "pixels:" | sed s/M// | sed s/Number// | sed s/pixels:// | tr -d " \t\n\r")"

    re='^[0-9]+([.][0-9]+)?$'
    if ! [[ $OUTPUT =~ $re ]] ; then
      if [[ $newline = 2 ]]; then
        echo ""
        newline=1
      fi

      echo "ERROR: The megapixel count is not a valid number! File ${img}." >&2; continue
    fi

    MIN_MEGAPIXEL_COUNT="7.98"

    if ! echo "$OUTPUT $MIN_MEGAPIXEL_COUNT -p" | dc | grep > /dev/null ^-; then
      # echo "$OUTPUT > $MIN_MEGAPIXEL_COUNT"
      # echo "${img}"

      cp "${img}" "${MP_DIR}/${img}"

      echo -n "."
      newline=2
    else
      if [[ $newline = 2 ]]; then
        echo ""
        newline=1
      fi
      echo "!!! The file ${img} is a ${OUTPUT}MP image. $OUTPUT < $MIN_MEGAPIXEL_COUNT"
    fi
done

if [[ $newline = 2 ]]; then
  echo ""
  newline=1
fi

exit 0
