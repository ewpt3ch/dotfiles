[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
exec openbox-session
