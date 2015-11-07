#!/bin/bash
# status script for dwm
# influenced by:
# https://bitbucket.org/jasonwryan/shiv/Scripts/dwm-status
# https://github.com/w0ng/bin/blob/master/dwm-statusbar
########################
## eric@ewpt3ch.com ####
## dwmstatus ###########
########################

# colors from dwm.config.h
color_normal="\x01"    #normal
color_selected="\x02"  #selected
color_urgent="\x03"    #urgent
color_important="\x04" #important
color_yellow="\x05"    #yellow
color_blue="\x06"      #blue
color_cyan="\x07"      #cyan
color_magenta="\x08"   #magenta
color_grey="\x09"      #grey

# Icon glyphs from Inconsolataicon
glyph_cpu="\u01B0"
glyph_mem="\u01B1"
glyph_dl="\u01A5"
glyph_pow="\u01B2"
glyph_clk="\u01Af"
glyph_bln="\u01AA"
glyph_msc="\u01AB"
glyph_vol="\u01AC"
glyph_mute="\u01B4"
glyph_mail="\u01AD"
glyph_wifi="\u01AE"
glyph_plug="\u01A4"

# Song info
msc(){
  if [ -x /usr/bin/cmus-remote ]
  then
    artist=`cmus-remote -Q | grep -w artist | cut -d ' ' -f3-`
    song=`cmus-remote -Q | grep title | cut -d ' ' -f3-`
    song_info=${artist}-${song}
  fi

  echo -ne "${color_selected}${glyph_msc} ${song_info}${color_normal}"
}

#Date
dte(){
  datetime="$(date "+%F %T")"
  echo -ne "${color_selected}${glyph_clk} ${datetime}${color_normal}"
}

#Power and Battery
bat(){
  on1="$(</sys/class/power_supply/ADP1/online)"
  charge="$(</sys/class/power_supply/BAT1/capacity)"
  if [[ $on1 -eq "0" && $charge -lt "25" ]]
  then
    #below 25%
    echo -ne "${color_urgent}${glyph_pow} ${charge}%${color_normal}"
  elif [[ $on1 -eq "0" && $charge -lt "35" ]]
  then
    #between 25% and 35%
    echo -ne "${color_important}${glyph_pow} ${charge}%${color_normal}"
  elif [ $on1 -eq "0" ]
  then
    #above 50%
    echo -ne "${color_selected}${glyph_pow} ${charge}%${color_normal}"
  else
    #charging
    echo -ne "${color_selected}${glyph_plug} ${charge}%${color_normal}"
  fi
}

#Volume
vol(){
  mute=`amixer get Master | grep "Front Left:" | awk '{print $6}'`
  if [ ${mute} == "[on]" ]
  then
    volume=`amixer get Master | grep "Front Left:" | awk '{print $5}' | tr -d '[]'`
    echo -ne "${glyph_vol} ${volume}"
  else
    echo -ne "${glyph_mute}"
  fi
}

#Memory
mem(){
  memused="$(free -m | awk 'NR==2 {print $3}')"
  echo -ne "${glyph_mem}${memused}M"
}

#CPU
load(){
  cpu="$(cat /proc/loadavg | awk '{print $1, $2, $3}')"
  echo -ne "${glyph_cpu} ${cpu}"
}

#Internet Connection
int(){
  host google.com > /dev/null &&
  echo -ne "${glyph_wifi}" || echo -ne "${color_important}${glyph_wifi}${color_normal}"
}

# Pipe to statusbar
xsetroot -name "$(msc) $(vol) $(load) $(mem) $(int) $(bat) $(dte) "
