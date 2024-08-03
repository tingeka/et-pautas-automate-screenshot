#!/bin/bash

# Update and install required packages
echo "Running the setup script..."
sudo apt-get update
sudo apt-get install -y x11-apps x11-utils x11-xserver-utils xfvb i3 scrot npm

# Check if the file exists and is not executable
if [ ! -x "./start-virtual-display.sh" ]; then
  echo "File 'start-virtual-display.sh' is not executable. Making it executable..."
  chmod +x "./start-virtual-display.sh"
fi

# Add script call to .bashrc
echo "Setting up .bashrc to run the Xvfb startup script..."
# Check if the line is already in .bashrc
if ! grep -q '~/start-virtual-x.sh' ~/.bashrc; then
  echo 'if [ -z "$DISPLAY" ]; then' >> ~/.bashrc
  echo '  ~/start-virtual-x.sh' >> ~/.bashrc
  echo 'fi' >> ~/.bashrc
fi

echo ".bashrc updated to run the Xvfb startup script."