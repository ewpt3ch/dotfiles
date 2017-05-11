#!/bin/bash
#script to update packages installed from aur
#uses cower -ud and makepkg -i
#written because meat stopped working

#path variables
AURBUILD=/tmp/makepkg

#create necessary dirs if not exist
mkdir -p ${AURBUILD}

#cower --update --download --target=${AURBUILD}
cower -d -t ${AURBUILD} cower

cd ${AURBUILD}
for dir in ${AURBUILD}/* 
do
  cd ${dir}
  echo "building ${dir}"
  echo "makepkg --install"
  cd ${AURBUILD}
  rm -r ${dir}
done
