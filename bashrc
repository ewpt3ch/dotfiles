# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Put your fun stuff here.
#source /etc/profile.d/bash-completion.sh
source ~/todo.txt-cli/todo_completion
alias emacs='emacs -nw'
alias t='$HOME/Dropbox/todo/todo.sh -d $HOME/Dropbox/todo/todo.cfg'
alias nano='nano -w'
complete -F _todo t
PATH="/home/ewpt3ch/bin:${PATH}:./:"
export VMWARE_USE_SHIPPED_GTK="yes"
export EDITOR=:vim
export PAGER=less
keychain -q ~/.ssh/id_ecdsa
. ~/.keychain/$HOSTNAME-sh
. ~/.keychain/$HOSTNAME-sh-gpg
#Check if dropbox is running
if  dropbox.py running  ; then
  #start dropbox
  ~/bin/dropbox.py start
fi
