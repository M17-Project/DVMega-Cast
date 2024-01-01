#!/bin/bash

#
# Writes D-Star presets to file from Cast UDP server
#
# PE1MSZ, PE1PLM, W0CHP
#
# usage: WPRE.sh [config-params]
#

FILE=/usr/local/cast/etc/dstarpre.txt

formatted_input=$(printf "%s" "$1")
echo "$formatted_input" | sudo tee "$FILE" > /dev/null
