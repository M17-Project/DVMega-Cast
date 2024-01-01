#!/bin/bash

#
# Writes DMR presets from Cast USP server into preset file
#
# PE1MSZ, PE1PLM, W0CHP
#
# usage: WPRD.sh [config-params]
#

FILE=/usr/local/cast/etc/dmrpre.txt

formatted_input=$(printf "%s" "$1")
echo "$formatted_input" | sudo tee "$FILE" > /dev/null
