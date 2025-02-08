#!/usr/bin/bash
cd ~/Pictures
cp wallpapers/dracula-programming-room-day.png dracula-programming-room.png
cp wallpapers/dracula-skyline-day.png dracula-skyline.png
killall hyprpaper > /dev/null 2>&1
hyprpaper & > /dev/null 2>&1
