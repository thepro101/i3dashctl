#!/bin/bash
           
interval=10 # Interval in seconds
workspace_count=$(i3-msg -t get_workspaces | jq '. | length')
chromium_cmd1="chromium-browser & disown"
chromium_cmd2="chromium-browser & disown"
export DISPLAY=:0
                               
if [[ $workspace_count -lt 2 ]]; then
    # If there is only one workspace, create another one and open Chromium
    pkill -f chromium-browser/chrome
    i3-msg workspace 1
    sleep 1
    $chromium_cmd1
    sleep 5
    i3-msg workspace 2 & $chromium_cmd2
fi
  
while true; do
    # Toggle between workspaces
    i3-msg workspace next
    sleep $interval
done

