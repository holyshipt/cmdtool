#!/usr/bin/env bash -x

cheat::find() {
   for path in $(echo "$FM_PATH" | tr ':' '\n'); do
      find "$path" -iname '*.cheat'
   done
}

cheat::_join_multiline_using_sed() {
   tr '\n' '\f' \
      | sed -E 's/\\\f *//g' \
      | tr '\f' '\n'
}

cheat::_join_multiline() {
   if ${FM_USE_PERL:-false}; then
      perl -0pe 's/\\\n *//g' \
         || cheat::_join_multiline_using_sed
   else
      cheat::_join_multiline_using_sed
   fi
}

cheat::read_all() {
   for cheat in $(cheat::find); do
      echo
      cat "$cheat" | cheat::_join_multiline
      echo
   done
}

cheat::memoized_read_all() {
   if [ -n "${FM_CACHE:-}" ]; then
      echo "$FM_CACHE"
      return
   fi
   if command_exists perl; then
      export FM_USE_PERL=true
   else
      export FM_USE_PERL=false
   fi
   local -r cheats="$(cheat::read_all)"
   echo "$cheats"
}

cheat::pretty() {
   awk 'function color(c,s) {
           printf("\033[38;5;%dm%s\033[38;5;1m",c,s)
        }

      /^%/ { tags=" ["substr($0, 3)"]"; next }
      /^#/ { print color(240, $0) color(233, tags); next }
      /^\$/ { next }
   NF { print color(233, $0) color(233, tags); next }'
}
# color 1 => # show me leaves
# color 2 => highlight search term
# color 3 => command/text
# color 4 => default tags

cheat::_until_percentage() {
   awk 'BEGIN { count=0; }

      /^%/ { if (count >= 1) exit;
             else { count++; print $0; next; } }
   { print $0 }'
}

cheat::from_selection() {
   local -r cheats="$1"
   local -r selection="$2"

   local -r tags="$(dict::get "$selection" tags)"

   echo "$cheats" \
      | grep "% ${tags}" -A99999 \
      | cheat::_until_percentage
#      || (echoerr "No valid cheatsheet!"; exit 67)
}
