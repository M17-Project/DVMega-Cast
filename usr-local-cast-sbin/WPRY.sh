#!/bin/bash

#
# Writes YSF presets to file from Cast UDP server
#
# PE1MSZ, PE1PLM, W0CHP
#
# usage: WPRY.sh [config-params]
#

FILE=/usr/local/cast/etc/ysfpre.txt

formatted_input=$(printf "%s" "$1")
echo "$formatted_input" | sudo tee "$FILE" > /dev/null
