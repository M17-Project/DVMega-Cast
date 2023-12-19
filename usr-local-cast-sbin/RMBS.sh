#!/bin/bash

#
# Places Cast in Base Station/IP Radio Mode
#
# PE1MSZ, PE1PLM, W0CHP
#

# stop cron & WPSD services
sudo wpsd-services fullstop > /dev/null 2>&1

sudo sed -i "/\[Modem\]/,/\[/ s/Hardware=.*$/Hardware=dvmpicast/1" /etc/dstar-radio.mmdvmhost
sudo sed -i "/\[Modem\]/,/\[/ s/Port=.*$/Port=\/dev\/ttyAMA0/1" /etc/mmdvmhost
sudo sed -i "/repeaterType1=/c\\repeaterType1=0" /etc/ircddbgateway

# reet the bad boy
sudo /usr/local/cast/bin/cast-reset
sudo gpio mode 10 in

# start WPSD serviices & cron
sudo wpsd-services start > /dev/null 2>&1 &

exit 0
