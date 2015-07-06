#!/bin/bash

### ~/.bashrc #######################
#####################################
## eric at ewpt3ch.com ##############
## dotfiles on github.com ewpt3ch ###
#####################################

### test for interactive shell
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Put your fun stuff here.
#source /etc/profile.d/bash-completion.sh
source ~/todo.txt-cli/todo_completion
source ~/bin/npm_completion
#pacman aliases
alias pacman='sudo pacman'
alias pacupg='pacman -Syu'
alias pacins='pacman -U'
#
alias t='clear && $HOME/Dropbox/todo/todo.sh -d $HOME/Dropbox/todo/todo.cfg'
alias nano='nano -w'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
complete -F _todo t
PATH="/home/ewpt3ch/bin:/home/ewpt3ch/tmux:${PATH}:./:"
export VMWARE_USE_SHIPPED_GTK="yes"
export EDITOR=vim
export PAGER=less
export LIBVA_DRIVER_NAME=vdpau
export BROWSER=firefox-developer
#create cache-dir for chrome
mkdir -p /tmp/ewpt3ch-cache
eval $(keychain --eval --agents ssh -Q --quiet ~/.ssh/id_ed25519) 
#Check if dropbox is running
if  dropbox.py running  ; then
  #start dropbox
  ~/bin/dropbox.py start
fi
