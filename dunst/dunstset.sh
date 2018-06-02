#!/usr/bin/zsh

#script to apply dunst formatting
#
#Source colors
. "${HOME}/.cache/wal/colors.sh"

#closing previous instances
killall -q dunst

#while pgrep -f dunst >/dev/null; do sleep 1; done

dunst \
	-lb "$color0" \
	-nb "$color0" \
	-cb "$color0" \
	-lf "$color2" \
	-nf "$color9" \
	-cf "$color6" \
	-frame_color "$color2" \
	-frame_width 2 \
	-fn "Terminus 8" \
	-geometry "250x250-20+45" &
