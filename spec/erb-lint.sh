#!/bin/sh

for erbfile in $@; do
        erb -x -T '-' $erbfile | ruby -c
        if [[ $? != 0 ]]; then
         echo "Error in $erbfile"
                exit 1
        fi
done
