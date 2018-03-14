#!/bin/bash
while IFS='' read -r line || [[ -n "$line" ]]; do
	line=$(echo "$line" | tr '[:upper:]' '[:lower:]' | tr -dc '[:alpha:]')
	echo "$line" >> /home/iasatan/NonSynced/artists.txt
done < "$1"
