#!/bin/bash
while IFS='' read -r line || [[ -n "$line" ]]; do
	if [[ "$line" == *" "* ]]; then
		line=$(echo "$line" | tr '[:upper:]' '[:lower:]' | tr -dc '[:alpha:]')
		echo "$line" >> /home/iasatan/NonSynced/artists.txt
	fi
done < "$1"
