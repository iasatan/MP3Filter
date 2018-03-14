#!/bin/bash

while IFS='' read -r line || [[ -n "$line" ]]; do
    if [[ "$line" == *" "* ]]; then
        find . -xtype f -iname *"$line"* -print -delete
    fi
done < "$1"
