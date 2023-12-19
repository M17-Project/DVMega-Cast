#!/bin/bash

#
# Config parameter writer
#
# PE1MSZ, PE1PLM, W0CHP
#
# usage: WCON.sh [config-params]
#

FILE=/usr/local/cast/etc/config.txt
	
echo $1 > $FILE
sed -i 's/^\(.\{30\}\).*$/\1/' $FILE  # Cut at max length to remove unwanted buffer stuff

