#!/bin/bash
# Перекодирует рекурсивно в текущем каталоге имена
# файлов и каталогов в транслит.

shopt -s nullglob

for NAME in * ; do

# Меняем в названии файла квадратные скобки на круглые - а то sed клинит квадратными
  NBR=`echo "$NAME" | tr '[' '('`
  NBR=`echo "$NBR"  | tr ']' ')'`
  if [[ "$NAME" != "$NBR" ]]; then
    mv -v -- "$NAME" "$NBR"
  fi

# Меняем дефис в начале названия файла на символ нижнего подчёркивания - что бы file, move да и вообще
# другие команды не воспринимали такие названия файлов как параметры
  DSH=`echo $NBR  | sed "s/^-/_/g"`
  if [[ "$DSH" != "$NBR" ]]; then
    mv -v -- "$NBR" "$DSH"
  fi

  TRS=`echo $DSH  | sed "y/абвгдезийклмнопрстуфхцы/abvgdezijklmnoprstufxcy/"`
  TRS=`echo $TRS  | sed "y/АБВГДЕЗИЙКЛМНОПРСТУФХЦЫ/ABVGDEZIJKLMNOPRSTUFXCY/"`
  TRS=${TRS//ч/ch};
  TRS=${TRS//Ч/CH} TRS=${TRS//ш/sh};
  TRS=${TRS//Ш/SH} TRS=${TRS//ё/yo};
  TRS=${TRS//Ё/YO} TRS=${TRS//ж/zh};
  TRS=${TRS//Ж/ZH} TRS=${TRS//щ/sch};
  TRS=${TRS//Щ/SСH} TRS=${TRS//э/ye};
  TRS=${TRS//Э/YE} TRS=${TRS//ю/yu};
  TRS=${TRS//Ю/YU} TRS=${TRS//я/ya};
  TRS=${TRS//Я/YA} TRS=${TRS//ъ/\'};
  TRS=${TRS//Ъ/\'} TRS=${TRS//ь/\'};
  TRS=${TRS//Ь/\'}

  if [[ `file -b "$DSH"` == directory ]]; then
    if [[ "$DSH" != "$TRS" ]]; then
      mv -v "$DSH" "$TRS"
    fi
      cd "$TRS"
      "$0"
      cd ..
  else
    if [[ "$DSH" != "$TRS" ]]; then
      mv -v "$DSH" "$TRS"
    fi
  fi
done
