#!/bin/bash
if `acpi -a | grep -q on`
then
  echo "Â"
else
  bat=`acpi -b | awk '{print $4}'`
  bat="${bat%%%*}" #remove percent
  if [[ $bat -gt 75 ]]
  then
    echo "ó"
  elif [[ $bat -gt 25 ]]
  then
    if [[ $bat -gt 45 ]]
    then 
      echo "ò"
    else
      echo "ò" $bat"%"
    fi
  else
    echo "ñ" $bat"%"
  fi
fi
