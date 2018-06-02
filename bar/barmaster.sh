#!/bin/sh

#launch any needed bars

#Variables

	#geometry
	width=1920
	height=25
	
	#Font
	font="-xos4-terminus-medium-r-normal-*-12-120-72-72-c-60-iso8859-1"
#	font="-nerdypepper-scientifica-medium-r-normal-*-11-80-100-100-c-50-iso10646-1"
#sourcing solors from xresources and pywal
. "${HOME}/.cache/wal/colors.sh"

bar="lemonbar -g ${width}x${height}+0+0 -d -f ${font} -B $color0 -F $color15"

#closing all previous instances of the bar
killall -q lemonbar

while pgrep -f lemonbar >/dev/null; do sleep 1; done

#launch bar
${HOME}/sys-comps/bar/bar1.sh | $bar &
