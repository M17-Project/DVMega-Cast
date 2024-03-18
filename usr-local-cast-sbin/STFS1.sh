#!/bin/bash

#
# Sets YSF Mode to Enabled
#
# PE1MSZ, PE1PLM, W0CHP
#

sudo wpsd-services fullstop > /dev/null 2>&1

sudo sed -i "/\[System Fusion\]/,/\[/ s/Enable=.*$/Enable=1/1" /etc/mmdvmhost
sudo sed -i "/\[System Fusion Network\]/,/\[/ s/Enable=.*$/Enable=1/1" /etc/mmdvmhost

sudo /usr/local/cast/bin/cast-reset

sudo wpsd-services start > /dev/null 2>&1

