_dir=$(dirname $0:A)

_call() {
    local buff="$BUFFER"
    zle kill-whole-line
    local cmd="$(FM_USE_FZF_ALL_INPUTS=true "${_dir}/frostmourne" --print <> /dev/tty)"
    zle -U "${buff}${cmd}"
}
_exec() {
    local cmd="${_dir}/frostmourne" 
    zle -U "${cmd}"
}
zle -N _call
#zle -N _exec
bindkey '^f' _call
