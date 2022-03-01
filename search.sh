#!/usr/bin/env bash

search::cheat() {
   local -r cmd="$(echo "$1" | str::first_word)"

   #echo "% ${cmd}, cheatsh"
   #echo
   # curl -s "${CHTSH_URL:-http://cht.sh}/${cmd}?T"
}

search::filename() {
   local -r cmd="$(echo "$1" | str::first_word)"

  # echo "${cmd}_cheatsh" \
  #   | head -n1 \
  #   | awk '{print $NF}' \
  #   | xargs \
  #   | tr ' ' '_'
}

search::full_path() {
   local -r cmd="$(echo "$1" | str::first_word)"

   echo "/tmp/frostmourne/$(search::filename "$cmd").cheat"
}

search::save() {
   local -r cmd="$(echo "$1" | str::first_word)"

   local -r filepath="$(search::full_path "$cmd")"
   local -r filedir="$(dirname "$filepath")"

   if [ -f "$filepath" ]; then
      return
   fi

   mkdir -p "$filedir" &> /dev/null || true
   search::cheat "$cmd" > "$filepath"
}
