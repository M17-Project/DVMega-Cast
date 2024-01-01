#!/bin/bash

#
# Writes DMR presets from Cast USP server into preset file
#
# PE1MSZ, PE1PLM, W0CHP
#
# usage: WPRD.sh [config-params]
#

FILE=/usr/local/cast/etc/dmrpre.txt

echo $1 | sudo tee $FILE > /dev/null

