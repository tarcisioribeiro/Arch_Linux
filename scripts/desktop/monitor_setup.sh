#!/bin/bash

xrandr \
  --output HDMI-1-2 --primary --mode 2560x1080 --rate 75 --pos 1920x0 --rotate normal \
  --output eDP-1 --mode 1920x1080 --rate 60 --pos 4480x0 --rotate normal \
  --output DP-1-3 --off

i3-msg "workspace 1; move workspace to output HDMI-1-2"
i3-msg "workspace 2; move workspace to output eDP-1"
sleep 1
i3-msg "workspace 1; exec code"
sleep 1
i3-msg "workspace 1; exec kitty"
sleep 1
i3-msg "workspace 2; exec google-chrome-stable"
sleep 1
i3-msg "workspace 1"
sleep 1
nitrogen --restore
