#!/bin/bash

#
# Manages & saves Cast settings
#
# PE1MSZ, PE1PLM, W0CHP
#

# usage:	SETTINGS.sh [CALL] [DMR/CCS7 ID] [TEXT] [MODULE] [DMR ESSID]
# example:	SETTINGS.sh PE1MSZ 2045123 RUUD E 09

# stop cron & WPSD services
sudo wpsd-services fullstop > /dev/null 2>&1

# reset to values specified in args
sudo sed -i "/\[General\]/,/\[/ s/Callsign=.*$/Callsign=$1/1" /etc/mmdvmhost
sudo sed -i "s/callsign=.*/callsign=\'$1\';/1" /var/www/dashboard/config/ircddblocal.php
sudo sed -i "/\[FM\]/,/\[/ s/Callsign=.*$/Callsign=$1/1" /etc/mmdvmhost
sudo sed -i "s/gatewayCallsign=.*/gatewayCallsign=$1/1" /etc/ircddbgateway
sudo sed -i "s/repeaterCall1=.*/repeaterCall1=$1/1" /etc/ircddbgateway
sudo sed -i "s/ircddbUsername=.*/ircddbUsername=$1/1" /etc/ircddbgateway
sudo sed -i "s/dplusLogin=.*/dplusLogin=$1/1" /etc/ircddbgateway
sudo sed -i "s/callsign=.*/callsign=$1/1" /etc/timeserver
sudo sed -i "/\[General\]/,/\[/ s/Callsign=.*$/Callsign=$1/1" /etc/ysfgateway
sudo sed -i "/\[DMR\]/,/\[/ s/Id=.*$/Id=$2/1" /etc/ysfgateway
sudo sed -i "/\[Info\]/,/\[/ s/Name=.*$/Name=$1_DVMEGA-CAST-WPSD/1" /etc/ysfgateway
sudo sed -i "/\[APRS\]/,/\[/ s/Sescription=.*$/Description=$1_DVMEGA-CAST_WPSD/1" /etc/ysfgateway
fullcall=$(printf "%-7s" "$1")"$4"
fullcall=$(printf "%-7s" "$1")"G"
sudo sed -i "/\[General\]/,/\[/ s/Id=.*$/Id=$2/1" /etc/mmdvmhost
sudo sed -i "/\[General\]/,/\[/ s/Display=.*$/Display=$3/1" /etc/mmdvmhost
sudo sed -i "/\[DMR\]/,/\[/ s/Id=.*$/Id=$2$5/1" /etc/mmdvmhost
sudo sed -i "/\[XLX Network 1\]/,/\[/ s/Id=.*$/Id=$2/1" /etc/dmrgateway
sudo sed -i "/\[DMR Network 1\]/,/\[/ s/Id=.*$/Id=$2$5/1" /etc/dmrgateway
sudo sed -i "/\[DMR Network 2\]/,/\[/ s/Id=.*$/Id=$2$5/1" /etc/dmrgateway


sudo sed -i "/\[D-Star\]/,/\[/ s/Module=.*$/Module=$4/1" /etc/mmdvmhost
sudo sed -i "s/repeaterBand1=.*/repeaterBand1=$4/1" /etc/ircddbgateway
sudo sed -i "s/starNetBand1=.*/starNetBand1=$4/1" /etc/ircddbgateway

# Set the sendC to 1 if module C is selected in file /etc/timeserver
sudo sed -i "s/sendA=.*/sendA=0/1" /etc/timeserver
sudo sed -i "s/sendB=.*/sendB=0/1" /etc/timeserver
sudo sed -i "s/sendC=.*/sendC=0/1" /etc/timeserver
sudo sed -i "s/sendD=.*/sendD=0/1" /etc/timeserver
sudo sed -i "s/sendE=.*/sendE=0/1" /etc/timeserver
sudo sed -i "s/send$4=.*/send$4=1/1" /etc/timeserver

# reset the bad boy
sudo /usr/local/cast/bin/cast-reset

# start WPSD serviices & cron
sudo wpsd-services start > /dev/null 2>&1 &

exit 0
