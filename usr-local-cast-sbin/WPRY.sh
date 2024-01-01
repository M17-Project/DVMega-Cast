#!/bin/bash

#
# Writes YSF presets to file from Cast UDP server
#
# PE1MSZ, PE1PLM, W0CHP
#
# usage: WPRY.sh [config-params]
#

FILE=/usr/local/cast/etc/ysfpre.txt

echo $1 | sudo tee $FILE > /dev/null

