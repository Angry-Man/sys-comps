#!/bin/sh

# First bar

#Date and Time

clock(){
date '+%A, %B %d, %Y | %H:%M:%S'
}

#Battery
battery() {

BATC=/sys/class/power_supply/BAT0/capacity
BATS=/sys/class/power_supply/BAT0/status

# prepend percentage with a '+' if charging, '-' otherwise
[ "`cat $BATS`" = "Charging" ] && echo -n '+' || echo -n '-'

#print out the content
sed -n p $BATC
}

#Backlight
backlight() {
#Assign the brightness and max brightness from the systemfiles
maxbrightness=/sys/class/backlight/intel_backlight/max_brightness
brightness=/sys/class/backlight/intel_backlight/brightness

#Use bc to perform arithmetic, cat to pull data from files, and sed to filter out zeros
printf '%.0f\n' $(echo "scale=3 ; `cat $brightness` / `cat $maxbrightness` * 100" | bc) 
}

#Sound Level

# parse amixer output to get ONLY the level. Will output "84%"
# `uniq` because on some hardware, The master is listed twice in

volume() {
	amixer get Master | sed -n 's/^.*\[\([0-9]\+\)%.*$/\1/p'| uniq
}

groups() {

cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`

for w in `seq 0 $((cur - 1))`; do line="${line}- "; done
line="${line}X "
for w in `seq $((cur + 2)) $tot`; do line="${line}- "; done
echo $line

}
# This will need to be modified for computer capabilities.
# Todo: add ability to show what you are connected to... (SSID or otherwards...)

network() {
   # read lo int1 int2 <<< `ip link | sed -n 's/^[0-9]: \(.*\):.*$/\1/p'`
   # if iwconfig $int1 >/dev/null 2>&1; then
   #     wifi=$int1
   #     eth0=$int2
   # else
   #     wifi=$int2
   #     eth0=$int1
   # fi
   # ip link show $eth0 | grep 'state UP' >/dev/null && int=$eth0 ||int=$wifi

    int= nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\' -f2 | sed 's/....//'


    ping -c 1 8.8.8.8 >/dev/null 2>&1 &&
        echo "$int" || echo "Disconnected"
}

#Loop to buffer everything

while :; do

	buf=""
	buf="${buf}%{l}%{O10}$(groups)"
	buf="${buf}%{c}$(clock)"
	buf="${buf}%{r}Net: $(network) | "
	buf="${buf}BL: $(backlight)% | "
	buf="${buf}Vol: $(volume)% | "
	buf="${buf}Bat: $(battery)%"
	echo $buf

#

	sleep 0.1 #Update every second
done
