#!/bin/bash

#
# Writes D-Star presets to file from Cast UDP server
#
# PE1MSZ, PE1PLM, W0CHP
#
# usage: WPRE.sh [config-params]
#

FILE=/usr/local/cast/etc/dstarpre.txt

echo $1 | sudo tee $FILE > /dev/null

