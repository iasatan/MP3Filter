#!/bin/bash
basedir="/home/iasatan/Downloads/MP3Filter";
bash "$basedir"/removeBad.sh
echo "removeDuplicates-------------------------------------------------------------------------"
bash "$basedir"/removeDuplicates.sh "$basedir"
echo "commiting to git"
directory=${PWD##*/}
cd "$basedir/MP3Library"
#git pull
git add .
git commit -m "$directory"" added"
git push