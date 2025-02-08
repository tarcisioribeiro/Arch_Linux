hyprctl dispatch workspace 1; code &
sleep 3
hyprctl dispatch workspace 2; google-chrome-stable &
sleep 3
hyprctl dispatch workspace 3; kitty --hold sh -c "btop" &
sleep 3
hyprctl dispatch workspace 3; kitty --hold sh -c "VBoxManage startvm UbuntuServer --type headless && yazi" &
sleep 3
hyprctl dispatch workspace 3; kitty &
sleep 3
hyprctl dispatch workspace 4; youtube-music-desktop-app &