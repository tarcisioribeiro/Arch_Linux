#!/usr/bin/bash
cd ~/Pictures
cp versions/dracula-programming-room-day.png dracula-programming-room.png
cp versions/dracula-skyline-day.png dracula-skyline.png
cp versions/dracula-jet-fighters-day.png dracula-jet-fighters.png
sleep 5
hyprctl reload
