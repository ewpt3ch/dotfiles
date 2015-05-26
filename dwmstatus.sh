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
color_normal="\x01"   #normal
color_selected="\x02" #selected
color_blue="\x06"     #blue
color_red="\x03"      #red

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

  echo -ne "${glyph_msc} ${song_info}"
}

dte(){
  datetime="$(date "+%F %T")"
  echo -ne "${glyph_clk} ${datetime}"
}

bat(){
  charge=`acpi -b | awk '{print +$4}'`
  echo -ne "${glyph_pow} ${charge}%"
}
  
# Pipe to statusbar
xsetroot -name "$(msc) $(bat) $(dte) "
