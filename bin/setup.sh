#!/bin/bash

# Update and install required packages
echo "Running the setup script..."
sudo apt-get update
sudo apt-get install -y x11-apps x11-utils x11-xserver-utils xvfb i3 scrot npm

# Get the directory of the current script
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
START_VIRTUAL_X="$SCRIPT_DIR/start-virtual-display.sh"

# Check if the file exists and is not executable
if [ ! -x "$START_VIRTUAL_X" ]; then
  if [ -e "$START_VIRTUAL_X" ]; then
    echo "File '$START_VIRTUAL_X' is not executable. Making it executable..."
    chmod +x "$START_VIRTUAL_X"
  else
    echo "File '$START_VIRTUAL_X' does not exist. Please create it first."
    exit 1
  fi
fi

# Add script call to .bashrc
echo "Setting up .bashrc to run the Xvfb startup script..."
# Check if the line is already in .bashrc
if ! grep -q 'start-virtual-x.sh' ~/.bashrc; then
  echo 'if [ -z "$DISPLAY" ]; then' >> ~/.bashrc
  echo "  $START_VIRTUAL_X" >> ~/.bashrc
  echo 'fi' >> ~/.bashrc
fi

echo ".bashrc updated to run the Xvfb startup script."
