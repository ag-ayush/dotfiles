#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch top-bar, depending on monitors launch on all
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload -c $HOME/.config/polybar/config2 top &
  done
else
  polybar --reload -c $HOME/.config/polybar/config2 top &
fi
