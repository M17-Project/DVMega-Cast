#!/bin/bash

#
# DMR Config parameter writer
#
# PE1MSZ, PE1PLM, W0CHP
#
# usage: WPED.sh [config-params]
#

FILE=/usr/loca/cast/etc/dmrpre.txt

echo $1 > $FILE

