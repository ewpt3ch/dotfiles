#!/bin/sh
# Script to start dwm in loop

while true; do
		$HOME/bin/dwmstatus
    	sleep 2
done &

while true; do
	dwm >/dev/null
	# to log stderrors to a file 
	#dwm 2> /tmp/dwm.log
done 