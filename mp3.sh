#!/bin/bash
basedir="/home/iasatan/Downloads/MP3Filter";
if [[ $(grep -c "$PWD##*/" "$basedir"/stored.txt) -lt 1 ]]; then
    echo "removeNonMusic-------------------------------------------------------------------------"
    bash $basedir/removeNonMusic.sh
    echo "removeArtists-------------------------------------------------------------------------"
    bash "$basedir"/removeArtists2.sh "$basedir"/artists.txt
	echo "removeShortOrLongMusic-------------------------------------------------------------------------"
    bash "$basedir"/removeShortOrLongSongs.sh
    echo "removeArtists2-------------------------------------------------------------------------"
    bash "$basedir"/removeArtists.sh
    echo "Remove Bad Genres-------------------------------------------------------------------------"
    bash "$basedir"/removeBadGenres.sh
    echo "classify new artists"
    bash "$basedir"/checkArtist.sh
    echo "removeArtists-------------------------------------------------------------------------"
    bash "$basedir"/removeArtists2.sh "$basedir"/artists.txt
    echo "removeArtists2-------------------------------------------------------------------------"
    bash "$basedir"/removeArtists.sh
    echo "removeDuplicates-------------------------------------------------------------------------"
    bash "$basedir"/removeDuplicates.sh
    echo "removeEmptyDirs-------------------------------------------------------------------------"
    find . -type d -empty -delete -print
    directory=${PWD##*/}
    echo "$directory" >> "$basedir"/stored.txt
    cd "$basedir"
    echo "commiting to git"
    git pull
    git add .
    git commit -m "$directory"" added"
    git push
fi
