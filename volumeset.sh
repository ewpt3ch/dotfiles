#!/bin/bash
# script for changing the volume and sending
# notification to twmn using twmnc

step=1
sink="@DEFAULT_SINK@"

if [[ $# -eq 1 ]]; then
  case $1 in
    "up")
      pactl set-sink-mute $sink false
      pactl set-sink-volume $sink +$step%
      direction='increased to ';;
    "down")
      pactl set-sink-volume $sink -$step%
      direction='decreased to ';;
    "mute")
      pactl set-sink-mute $sink toggle;;
    *)
      echo "Invalid option";;
  esac
fi

muted=`pactl list sinks | grep "Mute" | awk '{print $2}'`
vol=`pactl list sinks | grep "front-left" | awk '{print $5}'`

if [[ $muted == "no" ]]; then
  twmnc -t 'volume' -c 'muted' -d 100
else
  twmnc -t 'volume' -c "${direction}${vol}" -d 100
fi
