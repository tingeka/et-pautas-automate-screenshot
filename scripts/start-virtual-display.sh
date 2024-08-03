#!/bin/bash

LOCKFILE=/tmp/xvfb.lock

# Check if Xvfb is already running
if [ ! -e $LOCKFILE ]; then
  touch $LOCKFILE
  # Start Xvfb on display :1
  Xvfb :1 -screen 0 1920x1080x24 &
  export DISPLAY=:1
  # Start i3 window manager
  i3 &
  # Remove lockfile on exit
  trap "rm -f $LOCKFILE" EXIT
fi
