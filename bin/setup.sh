#!/bin/bash

# Update and install required packages
echo "Running the setup script..."
sudo apt-get update
sudo apt-get install -y x11-apps x11-utils x11-xserver-utils xvfb i3 scrot npm

# Get the directory of the current script
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

# Path to the start-virtual-x.sh script
START_VIRTUAL_X="$SCRIPT_DIR/start-virtual-display.sh"

echo "Script Directory: $SCRIPT_DIR"
echo "Start Virtual X Script: $START_VIRTUAL_X"

# Check if the file exists
if [ ! -e "$START_VIRTUAL_X" ]; then
    echo "File '$START_VIRTUAL_X' does not exist. Please create it first."
    exit 1
fi

# Check if the file has exec perms
if [ ! -x "$START_VIRTUAL_X" ]; then
    echo "File '$START_VIRTUAL_X' is not executable. Making it executable..."
    chmod +x "$START_VIRTUAL_X"
fi

# Add script call to .bashrc
echo "Setting up .bashrc to run the Xvfb startup script..."
# Check if the line is already in .bashrc
if ! grep -q "start-virtual-display.sh" ~/.bashrc; then
    # Append the lines to .bashrc
    {
        echo ''
        echo 'if [ -z "$DISPLAY" ]; then'
        echo "  $START_VIRTUAL_X"
        echo 'fi'
        echo ''
    } >> ~/.bashrc
    echo ".bashrc updated to run the Xvfb startup script."
else
    echo ".bashrc already contains the startup script line."
fi
