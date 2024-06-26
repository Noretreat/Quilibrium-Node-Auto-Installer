#!/bin/bash

# Define the tmux session name
SESSION_NAME="node"

# Kill the tmux session if it exists
tmux has-session -t $SESSION_NAME 2>/dev/null
if [ $? == 0 ]; then
  tmux kill-session -t $SESSION_NAME
fi

# Navigate to the .config directory
cd /ceremonyclient/node/.config

# Remove the store folder
rm -rf store

# Start a new tmux session and run the node command
tmux new-session -d -s $SESSION_NAME

# Send commands to the new tmux session
tmux send-keys -t $SESSION_NAME "cd /ceremonyclient/node/" C-m
tmux send-keys -t $SESSION_NAME "./release_autorun.sh" C-m

# Notify when done
echo "Script execution completed."
