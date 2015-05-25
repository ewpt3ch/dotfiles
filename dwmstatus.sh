#!/bin/bash
# status script for dwm
# influenced by:
# https://bitbucket.org/jasonwryan/shiv/Scripts/dwm-status
# https://github.com/w0ng/bin/blob/master/dwm-statusbar
########################
## eric@ewpt3ch.com ####
## dwmstatus ###########
########################
# colors:

dte(){
  dte="$(date "+%I:%M")"
  echo -e "\x02$dte\x01"
}

# Pipe to statusbar
xsetroot -name "$(dte) "
