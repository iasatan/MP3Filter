#!/bin/bash
basedir="/home/iasatan/Downloads/MP3Filter";
echo "removeDuplicates-------------------------------------------------------------------------"
bash "$basedir"/removeDuplicates.sh "$basedir"

bash "$basedir"/removeBad.sh

