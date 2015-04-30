#!/bin/bash
if [ -x /usr/bin/cmus-remote ]
then
  status=`cmus-remote -Q | grep status | awk '{print $2}'`
  if [ $status == "paused" ]
  then
    status="→"
  else
    status="æ"
  fi
  duration=`cmus-remote -Q | grep duration | awk '{print $2}'`
  position=`cmus-remote -Q | grep position | awk '{print $2}'`
  ((timeleft = $duration - $position))
  ((timelefth = timeleft / 60))
  ((timeleftm = timeleft % 60))
  artist=`cmus-remote -Q | grep -w artist | cut -d ' ' -f3-`
  song=`cmus-remote -Q | grep title | cut -d ' ' -f3-`
  echo $artist'-'$song $status $timelefth':'$timeleftm
fi
