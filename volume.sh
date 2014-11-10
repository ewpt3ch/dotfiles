#!/bin/bash
mute=`amixer get Master | grep "Front Left:" | awk '{print $6}'`
if [ $mute == "[on]" ]
then
  vol=`amixer get Master | grep "Front Left:" | awk '{print $5}' | tr -d '[]'`
  echo "vol" $vol
else
  echo "mute"
fi
