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
glyph_ul="\u01A4"
glyph_pow="\u01B2"
glyph_clk="\u01Af"
glyph_bln="\u01AA"
glyph_msc="\u01AB"
glyph_vol="\u01AC"
glyph_mute="\u01B4"
glyph_mail="\u01AD"
glyph_wifi="\u01AE"

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
  charge=`acpi -b | awk '{print +$4}'`
  if [ $charge -lt "25" ]
  then
    echo -ne "${color_urgent}${glyph_pow} ${charge}%${color_normal}"
  else
    echo -ne "${color_selected}${glyph_pow} ${charge}%${color_normal}"
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

#Network
rx_old=$(cat /sys/class/net/wlp1s0/statistics/rx_bytes)
tx_old=$(cat /sys/class/net/wlp1s0/statistics/tx_bytes) 
while true; do
  #get new rx/tx counts
  rx_now=$(cat /sys/class/net/wlp1s0/statistics/rx_bytes)
  tx_now=$(cat /sys/class/net/wlp1s0/statistics/tx_bytes)
  #calculate rate (K) divide by 1024 * polling rate (sleep below)
  let rx_rate=($rx_now-$rx_old)/2048
  let tx_rate=($tx_now-$tx_old)/2048
  rx_rate(){
    echo -ne "${glyph_dl} ${rx_rate}K"
  }
  tx_rate(){
    echo -ne "${glyph_ul} ${tx_rate}K"
  }

  # Pipe to statusbar
  xsetroot -name "$(msc) $(load) $(mem) $(rx_rate)$(tx_rate) $(bat) $(vol) $(dte) "

  #reset rates
  rx_old=$rx_now
  tx_old=$tx_now
  sleep 2
done
