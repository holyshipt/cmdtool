#!/usr/bin/env bash

health::fzf() {
   if ! command_exists fzf && ! [ $FM_ENV -eq "test" ]; then
      echoerr "You need to install fzf before using FM"
      echoerr "Please refer to https://github.com/junegunn/fzf for install instructions"
      exit 66
   fi
}
