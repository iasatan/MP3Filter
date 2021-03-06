#!/bin/bash
basedir="/home/iasatan/Downloads/MP3Filter";
touch /tmp/tempBadArtists.txt
echo "removeNonMusic-------------------------------------------------------------------------"
bash "$basedir"/removeNonMusic.sh
echo "remove unoriginal music-------------------------------------------------------------------------"
bash "$basedir"/removeUnoriginalMusic.sh
echo "removeArtists-------------------------------------------------------------------------"
bash "$basedir"/removeArtists2.sh "$basedir/MP3Library"/artists.txt
echo "removeShortOrLongMusic-------------------------------------------------------------------------"
bash "$basedir"/removeShortOrLongSongs.sh
echo "removeArtists2-------------------------------------------------------------------------"
bash "$basedir"/removeArtists.sh "$basedir"
echo "Remove Bad Genres-------------------------------------------------------------------------"
bash "$basedir"/removeBadGenres.sh "$basedir"
echo "classify new artists"
bash "$basedir"/checkArtist.sh "$basedir"
echo "removeArtists-------------------------------------------------------------------------"
bash "$basedir"/removeArtists2.sh /tmp/tempBadArtists.txt
echo "removeArtists2-------------------------------------------------------------------------"
bash "$basedir"/removeArtists3.sh
echo "removeEmptyDirs-------------------------------------------------------------------------"
find . -type d -empty -delete -print
cd "$basedir/MP3Library"
sort -u everyArtist.txt > tempEveryArtists.txt
rm everyArtist.txt
mv tempEveryArtists.txt everyArtist.txt