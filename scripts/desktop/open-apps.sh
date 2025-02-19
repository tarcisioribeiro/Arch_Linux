hyprctl dispatch workspace 1
code &
sleep 5
hyprctl dispatch workspace 2
google-chrome-stable &
sleep 5
hyprctl dispatch workspace 3
kitty -- sh -c "~/scripts/tmux-setup.sh && tmux attach -t 'dev'" &
sleep 5
hyprctl dispatch workspace 4
youtube-music-desktop-app &
sleep 10
hyprctl dispatch workspace 4
kitty -- sh -c "cava" &
sleep 5
hyprctl dispatch workspace 5
telegram-desktop &
sleep 5
hyprctl dispatch workspace 5
obsidian &
