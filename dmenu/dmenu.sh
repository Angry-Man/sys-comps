#!/usr/bin/zsh

#Source colors and set font

. "${HOME}/.cache/wal/colors.sh"

font=creep2-11

dmenu_run -l 3 -fn $font -sb $color9 -sf $color0 -nb $color0 -nf $color15 -i -b
