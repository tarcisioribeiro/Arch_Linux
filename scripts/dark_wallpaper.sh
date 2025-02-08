#!/usr/bin/bash
cd ~/Pictures
cp wallpapers/dracula-programming-room-night.png dracula-programming-room.png
cp wallpapers/dracula-skyline-night.png dracula-skyline.png
killall hyprpaper > /dev/null 2>&1
hyprpaper & > /dev/null 2>&1
