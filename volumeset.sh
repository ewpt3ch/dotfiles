#!/bin/bash
# script for changing the volume and sending
# notification to twmn using twmnc

step=1

if [[ $# -eq 1 ]]; then
  case $1 in
    "up")
      amixer set Master $step%+
      direction='increased to ';;
    "down")
      amixer set Master $step%-
      direction='decreased to ';;
    "mute")
      amixer set Master toggle;;
    *)
      echo "Invalid option";;
  esac
fi

muted=`amixer get Master | grep "Front Left:" | awk '{print $6}'`
vol=`amixer get Master | grep "Front Left:" | awk '{print $5}' | tr -d '[]'`

if [[ $muted == "[off]" ]]; then
  twmnc -t 'volume' -c 'muted' -d 1000
else
  twmnc -t 'volume' -c "${direction}${vol}" -d 1000
fi
