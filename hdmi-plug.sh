#!/bin/bash

status=$(cat /sys/class/drm/card0-HDMI-A-1/status)

if [ $status = 'connected' ]; then
  xrandr --output eDP-1 --auto --output HDMI-1 --auto --scale 2x2 --right-of eDP-1
  twmnc -t 'display' -c 'HDMI plugged'
else
  xrandr --output HDMI-1 --off
  twmnc -t 'display' -c 'HDMI unplugged'
fi
