#!/bin/bash
           
# Default values
DISPLAY_NUM=":0"
URLS=()
#CHROME_COMMAND="chromium-browser"
CHROME_COMMAND="chromium-browser --new-window"

##revised command
#CHROME_COMMAND="chromium-browser 
#--user-data-dir=$tmpdir1 \
#--incognito \
#--disable-infobars \
#--disable-suggestions-service \
#--no-first-run \
#--start-fullscreen \
#--new-window"

                                 
# Function to parse command line arguments
parse_args() {
    while getopts "u:d:" opt; do
        case ${opt} in
            u)
                URLS+=("$OPTARG")
                ;;
            d)
                DISPLAY_NUM="$OPTARG"
                ;;
            \?)
                echo "Invalid option: -$OPTARG" >&2
                exit 1
                ;;
        esac
    done
}
 
# Function to kill all chromium-browser processes
kill_chrome() {
    pkill -f chromium-browser
}
 
# Function to create a new workspace and launch chromium-browser with specified URL
launch_chrome() {
    local workspace=$1
    local url=$2

$CHROME_COMMAND ${URLS[$i]} &
}
 
# Main execution starts here
parse_args "$@"
               
# Kill all existing chromium-browser processes
kill_chrome
           
i3-msg workspace 1

# Create workspaces and launch chromium-browser for each URL
for ((i=0; i<${#URLS[@]}; i++)); do
    workspace=$((i+1))
    url="${URLS[$i]}"

#echo i3-msg workspace $workspace
i3-msg workspace $workspace & sleep 5 
launch_chrome
done
   
#You can run this script in a terminal by providing the URLs as command-line arguments using the `-u` flag. For example:
                                                                                                                       
#./launch_dash.sh -u "https://espn.com" -u "https://claytonkendall.com" -u "https://github.com"
