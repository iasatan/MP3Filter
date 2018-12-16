#!/bin/bash

while IFS='' read -r line || [[ -n "$line" ]]; do
    if [[ "$line" == *" "* ]]; then
    	line=$(echo "$line" | tr '[:upper:]' '[:lower:]' | tr -dc '[:alpha:]')
        find . -xtype f -iname *"$line"* -print -delete
    fi
done < "$1"
