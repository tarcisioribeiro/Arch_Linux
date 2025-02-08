#!/usr/bin/bash
cd ~/Pictures
cp wallpapers/dracula-programming-room-night.png dracula-programming-room.png
killall hyprpaper
hyprpaper &
