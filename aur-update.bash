#!/bin/bash
#script to update packages installed from aur
#uses cower -ud and makepkg -i
#written because meat stopped working

#path variables
AURBUILD=/tmp/makepkg

#create necessary dirs if not exist
mkdir -p ${AURBUILD}

cower --update --download --target=${AURBUILD}

cd ${AURBUILD}
for dir in ${AURBUILD}/*
do
  cd ${dir}
  twmnc -t "aur-build" -c "building ${dir}" -d 5000
  makepkg --install
  cd ${AURBUILD}
  rm -r ${dir}
done
