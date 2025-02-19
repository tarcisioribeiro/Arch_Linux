#!/bin/bash
red() {
  echo "" && echo -e "\033[31m$1\033[0m" && echo ""
}

green() {
  echo "" && echo -e "\033[32m$1\033[0m" && echo ""
}

blue() {
  echo "" && echo -e "\033[34m$1\033[0m" && echo ""
}

clearwait() {
  clear && sleep 1
}

SESSION_NAME="dev"

tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? != 0 ]; then
  tmux new-session -d -s $SESSION_NAME -n "editor"

  tmux send-keys -t $SESSION_NAME:0 "nvim" C-m

  tmux new-window -t $SESSION_NAME -n "server"
  tmux send-keys -t $SESSION_NAME:1 "cd ~ && python3 -m http.server" C-m

  tmux new-window -t $SESSION_NAME -n "monitor"
  tmux split-window -h -t $SESSION_NAME:2
  tmux send-keys -t $SESSION_NAME:2.0 "btop" C-m
  #  tmux send-keys -t $SESSION_NAME:2.1 "tail -f /var/log/syslog" C-m

  tmux select-layout -t $SESSION_NAME:2 even-horizontal
fi

clearwait
green "Sessão '$SESSION_NAME' criada com sucesso!"
