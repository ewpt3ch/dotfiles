[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
#exec openbox-session
conky | while read -r; do xsetroot -name "$REPLY"; done &
redshift &
#pulseaudio --start &
start-pulseaudio-x11
google-musicmanager &
exec dbus-launch --exit-with-session --sh-syntax dwm
