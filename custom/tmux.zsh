#!/bin/bash

SESSION="DEVAPP"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)

PAY_SERVER="~/stripe/pay-server"
SJS="~/stripe/stripe-js-v3"

# Only create tmux session if it doesn't already exist
if [ "$SESSIONEXISTS" = "" ]
then
	# Start New Session with our name
	tmux new-session -d -s $SESSION -c $PAY_SERVER

	# Name first pane and start `pay tunnel`
	tmux rename-window -t 0 'PAY UP'
	tmux send-keys -t 'PAY UP' 'pay up' C-m

	# Start second window with `yarn tunnel`
	tmux new-window -t $SESSION:1 -n 'YARN TUNNEL'
	tmux send-keys -t 'YARN TUNNEL' 'cd ~/stripe/stripe-js-v3' C-m 'yarn tunnel' C-m

	# Star third window with `yarn start --tunnel`
	tmux new-window -t $SESSION:2 -n 'YARN START TUNNEL'
	tmux send-keys -t 'YARN START TUNNEL' 'cd ~/stripe/stripe-js-v3' C-m 'yarn start --tunnel' C-m
 fi

# Attach Session, on the Main window
tmux attach-session -t $SESSION:0
