#!/bin/bash

# Define the tmux session name
SESSION_NAME="my_session"

# Kill the tmux session if it exists
tmux has-session -t $SESSION_NAME 2>/dev/null
if [ $? == 0 ]; then
  tmux kill-session -t $SESSION_NAME
fi

# Start a new tmux session and run the node command
tmux new-session -d -s $SESSION_NAME "node ."

# Navigate to the directory and run the restart script
cd /ceremonyclient/node/
./restart_node.sh
