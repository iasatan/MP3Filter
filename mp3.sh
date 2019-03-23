#!/bin/bash
basedir="/home/iasatan/Downloads/MP3Filter";
bash "$basedir"/removeBad.sh
echo "removeDuplicates-------------------------------------------------------------------------"
bash "$basedir"/removeDuplicates.sh "$basedir"
echo "removeEmptyDirs-------------------------------------------------------------------------"
find . -type d -empty -delete -print
directory=${PWD##*/}
cd "$basedir/MP3Library"
sort -u everyArtist.txt > tempEveryArtists.txt
rm everyArtist.txt
mv tempEveryArtists.txt everyArtist.txt
echo "commiting to git"
#git pull
git add .
git commit -m "$directory"" added"
git push