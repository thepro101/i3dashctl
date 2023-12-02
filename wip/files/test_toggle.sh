
#!/bin/bash
           
# Default flag values
log_to_file=false
display_num=0
interval=5
          
# Parse command line options
while getopts "o:d:i:" opt; do
  case $opt in
    o) log_file="$OPTARG"; log_to_file=true ;;
    d) display_num="$OPTARG" ;;
    i) interval="$OPTARG" ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
  esac
done
    
# Set display environment variable
export DISPLAY=":$display_num"
                              
# Function to toggle i3 workspaces
toggle_workspace() {
  i3-msg "workspace next"
}
 
# Start toggling i3 workspaces
if $log_to_file; then
  if [ -z "$log_file" ]; then
    echo "Error: Log file location not specified using -o option" >&2; exit 1
  fi
  while true; do
    toggle_workspace >> "$log_file" 2>&1
    sleep "$interval"
  done
else
  while true; do
    toggle_workspace
    sleep "$interval"
  done
fi

