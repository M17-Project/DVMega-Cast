#!/bin/bash

#
# Sets All modes to what boolean is passed to the argument:
# 
# STMD.sh DMR(0,1) D-Star(0,1) YSF(0,1)
# 
#   This script is used by the Cast display udp service when
#   a user enables/disabled their delected modes.
#
# PE1MSZ, PE1PLM, W0CHP
#

sudo sed -i "/\[DMR\]/,/\[/ s/Enable=.*$/Enable=$2/1" /etc/mmdvmhost
sudo sed -i "/\[DMR Network\]/,/\[/ s/Enable=.*$/Enable=$2/1" /etc/mmdvmhost

sudo sed -i "/\[D-Star\]/,/\[/ s/Enable=.*$/Enable=$1/1" /etc/mmdvmhost
sudo sed -i "/\[D-Star Network\]/,/\[/ s/Enable=.*$/Enable=$1/1" /etc/mmdvmhost

sudo sed -i "/\[System Fusion\]/,/\[/ s/Enable=.*$/Enable=$3/1" /etc/mmdvmhost
sudo sed -i "/\[System Fusion Network\]/,/\[/ s/Enable=.*$/Enable=$3/1" /etc/mmdvmhost

sudo /usr/local/cast/bin/cast-reset

sudo wpsd-services restart > /dev/null 2>&1
