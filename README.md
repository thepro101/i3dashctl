# i3dashctl

## Overview

`i3dashctl` is a Bash script designed to manage and display multiple dashboards on different workspaces in the i3 window manager using Chromium in incognito mode. This script allows users to define the display number, URLs, toggle interval, and log file, and it supports splitting the dashboard across multiple workspaces.

## Features

- Launch multiple dashboards in Chromium on different i3 workspaces.
- Toggle between workspaces at specified intervals.
- Supports splitting the dashboard view.
- Customizable display number, URLs, toggle interval, and log file.

## Usage

To use `i3dashctl`, execute the script with the appropriate flags:

```bash
./i3dashctl -u <URL1> -u <URL2> -d <DISPLAY_NUM> -t <TOGGLE_INTERVAL> -l <LOG_FILE> -s <SPLIT_DASHBOARD>
```

### Flags

- `-u <URL>`: Specifies a URL to open in a new workspace. This flag can be used multiple times to open multiple URLs.
- `-d <DISPLAY_NUM>`: Sets the display number (e.g., `:0`, `:1`). This is useful when running the script on a specific X display.
- `-t <TOGGLE_INTERVAL>`: Sets the interval in seconds for toggling between workspaces.
- `-l <LOG_FILE>`: Specifies the log file to record the script's activities.
- `-s <SPLIT_DASHBOARD>`: Enables or disables splitting the dashboard view across multiple workspaces. Accepts `true` or `false`.

### Examples

#### Example 1: Basic Usage

Open two dashboards on display `:0`, toggling every 10 seconds, and log activities to `i3dashctl.log`:

```bash
./i3dashctl -u https://dashboard1.com -u https://dashboard2.com -d :0 -t 10 -l i3dashctl.log
```

#### Example 2: Split Dashboard

Open three dashboards on display `:1` with a split view, and log activities to `dashboard.log`:

```bash
./i3dashctl -u https://dashboard1.com -u https://dashboard2.com -u https://dashboard3.com -d :1 -l dashboard.log -s true
```

## Script Details

Here's a brief explanation of the main functions in the script:

### `parse_args`

This function parses the command line arguments and sets the corresponding variables.

### `kill_chrome`

Kills all existing Chromium processes to ensure a clean start.

### `launch_chrome`

Creates a new workspace and launches Chromium with the specified URL in fullscreen mode.

### `toggle_workspace`

Toggles between i3 workspaces at the specified interval.

## Logging

The script logs its activities, including session start times, URLs being opened, and workspace toggling, to the specified log file.

## Demo
![](https://github.com/thepro101/i3dashctl/blob/ffa91baf676e81251164c164ff591d778f96e0f3/demo.gif)

---

Feel free to customize the script and README.md to fit your specific needs. If you encounter any issues or have suggestions for improvement, please open an issue or submit a pull request.
