[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
#exec openbox-session
conky | while read -r; do xsetroot -name "$REPLY"; done &
redshift &
pulseaudio --start &
exec dbus-launch --exit-with-session --sh-syntax dwm
