#!/bin/bash
# Iniciando o monitor externo
xrandr --output HDMI-1-2 --auto
# Configura os monitores usando xrandr
xrandr --output eDP-1 --mode 1920x1080 --rate 60 --pos 2560x0 --rotate normal \
    --output HDMI-1-2 --mode 2560x1080 --rate 75 --pos 0x0 --rotate normal \
    --output DP-1-3 --off
