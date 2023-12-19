#!/bin/bash

#
# Sets YSF/FCS reflectors/rooms
#
# PE1MSZ, PE1PLM, W0CHP
#

# usage:	SETYSF.sh [YSF-Reflector/FCS Room]
# examples:	SETYSF.sh FCS00290  --  SETYSF.sh US-America-Link

sudo systemctl stop ysfgateway.service > /dev/null 2>&1

sudo sed -i "/\[Network\]/,/\[/ s/Startup=.*$/Startup=$1/1" /etc/ysfgateway

#sudo cast-reset

sudo systemctl start ysfgateway.service > /dev/null 2>&1 &
