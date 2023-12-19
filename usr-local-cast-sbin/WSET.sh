#!/bin/bash

#
# Main settings Config parameter writer
#
# PE1MSZ, PE1PLM, W0CHP
#
# usage: WSET.sh [config-params]
#

FILE=/usr/local/cast/etc/settings.txt

echo $1 > $FILE

