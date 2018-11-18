#!/bin/bash
basedir="/home/iasatan/Downloads/MP3Filter";
echo "removeArtists-------------------------------------------------------------------------"
bash "$basedir"/removeArtists2.sh "$basedir"/artists.txt
bash "$basedir"/removeArtists3.sh