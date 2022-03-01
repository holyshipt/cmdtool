#!/usr/bin/env bash
sed_new_old(){
  option="s/$1/$2/g;p"
  echo "`sed -n $option $3`"
}

sed_print_line(){
  option="$1p"
  echo "`sed -n $option $2`"
}

sed_print_lines_between(){
  option="$1,$2p"
  echo "`sed -n $option $3`"
}

sed_print_x_lines_from(){
  option="$1,+$2p"
  echo "`sed -n $option $3`"
}

sed_print_starts_with(){
  option="/^$1/p"
  echo "`sed -n $option $2`"
}

sed_delete_line(){
  option="$1d" 
  echo "`sed -i $option $2`"
}

sed_delete_starts_with(){
  option="/^$1/d"
  echo "`sed -i $option $2`"
}

sed_append_lines_match(){
  option="/$1/a $2"
  echo "`sed -i $option $3`"
}
