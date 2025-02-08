#!/bin/bash

# Configura os monitores usando xrandr
xrandr --output eDP-1 --mode 1920x1080 --rate 60 --pos 1920x0 --rotate normal \
    --output DP-1-3 --mode 1920x1080 --rate 60 --pos 0x0 --rotate normal
