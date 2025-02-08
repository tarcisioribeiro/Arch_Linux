#!/usr/bin/bash
cd ~/Pictures
cp wallpapers/dracula-programming-room-day.png dracula-programming-room.png
killall hyprpaper
hyprpaper &
