#!/bin/bash
#based on https://github.com/cdown/passmenu
#and jasnowryan.com/blog

shopt -s nullglob globstar

nb='#2F4F4F'
nf='#00FFFF'
sb='#2F4F4F'
sf='#ADFF2F'
font="Inconsolataicon-12"
dmenucmd=( dmenu -i -fn "$font" -nb "$nb" -nf "$nf" -sb "$sb" -sf "$sf" )

prefix=${PASSWORD_STORE_DIR:-~/.password-store}
files=( "$prefix"/**/*.gpg )
files=( "${files[@]#"$prefix"/}" )
files=( "${files[@]%.gpg}" )
fbase=( "${files[@]##*/}" )

word=$(printf '%s\n' "${fbase[@]}" | "${dmenucmd[@]}" "$@")

if [[ -n $word ]]; then
  for match in "${files[@]}"; do
    if [[ $word == ${match#*/} ]]; then
      /usr/bin/pass show -c "$match" 2>/dev/null
    fi
  done
fi
