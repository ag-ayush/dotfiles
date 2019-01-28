#!/bin/bash

#
# credit to: gitlab.com/mehalter
#

ps cax|grep i3lock > /dev/null
if [ $? -eq 0 ]; then
  exit 0
fi

lock() {

  lockwidth=256
  lockheight=256
  . $HOME/.cache/wal/colors.sh
  convert $HOME/.config/i3/lock.png -fuzz 50% -fill "$color4" -opaque "#30AF91" /tmp/lock.png
  convert /tmp/lock.png -fuzz 10% -fill "$color0" -opaque "#FFFFFF" /tmp/lock.png
  convert /tmp/lock.png -resize "$lockwidth"x"$lockheight" /tmp/lock.png

  scrot /tmp/screen.png
  convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png

  for s in `xrandr --listactivemonitors`; do
    if `echo $s | grep -qP '^\d+(/\d+)?x\d+(/\d+)?\+\d*\+\d*'`; then
      x="$(echo $s | grep -oP '^\d+')";
      y="$(echo $s | grep -oP 'x\d+'|cut -d'x' -f2)";
      xoffset="$(echo $s | grep -oP '\+\d+\+'|cut -d'+' -f2)";
      yoffset="$(echo $s | grep -oP '\+\d+$'|cut -d'+' -f2)";
      xpos="$((xoffset + (x/2) - (lockwidth/2)))";
      ypos="$((yoffset + (y/2) - (lockheight/2)))";
      convert /tmp/screen.png /tmp/lock.png -geometry +"$xpos"+"$ypos" -composite -matte /tmp/screen.png
    fi
  done

  killall -SIGUSR1 dunst

  i3lock --nofork -i /tmp/screen.png \
    --radius=124 --ring-width=7 \
    --insidecolor=00000000 --line-uses-inside \
    --insidevercolor=00000000 --veriftext="" \
    --insidewrongcolor=00000000 --wrongtext="" \
    --ringcolor=${color4:1:6}ff \
    --separatorcolor=${color4:1:6}ff \
    --keyhlcolor=${color0:1:6}ff \
    --bshlcolor=${color0:1:6}ff \
    --ringvercolor=${color0:1:6}ff \
    --ringwrongcolor=${color2:1:6}ff \

  killall -SIGUSR2 dunst

  rm -f /tmp/screen.png /tmp/lock.png
}

lock &
