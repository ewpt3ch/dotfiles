[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
redshift &
start-pulseaudio-x11
google-musicmanager &
unclutter -noevents &
exec dbus-launch --exit-with-session --sh-syntax $HOME/bin/dwm-start
