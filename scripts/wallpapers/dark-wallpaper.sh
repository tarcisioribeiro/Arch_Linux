#!/usr/bin/bash
cd ~/Pictures
cp versions/dracula-programming-room-night.png dracula-programming-room.png
cp versions/dracula-skyline-night.png dracula-skyline.png
cp versions/dracula-jet-fighters-night.png dracula-jet-fighters.png
sleep 5
hyprctl reload
