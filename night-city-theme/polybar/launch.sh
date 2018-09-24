#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch top-bar
#polybar -c $HOME/.config/polybar/night-config top &
#echo "Bars launched..."

if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar -c $HOME/.config/polybar/night-config top &
	done
else
	polybar -c $HOME/.config/polybar/night-config &
fi
