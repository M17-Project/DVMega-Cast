#!/bin/bash

#
# D-Star Config parameter writer
#
# PE1MSZ, PE1PLM, W0CHP
#
# usage: WPRE.sh [config-params]
#

FILE=/usr/local/cast/etc/dstarpre.txt

echo $1 > $FILE

