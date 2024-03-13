#!/bin/bash

#
# Places Cast in Base Station/IP Radio Mode
#
# PE1MSZ, PE1PLM, W0CHP
#

# Don't run this if called from config page:
if [ "$1" != "conf_page" ]; then
    sudo systemctl stop mmdvmhost.service > /dev/null 2>&1
fi

sudo sed -i "/\[Modem\]/,/\[/ s/Hardware=.*$/Hardware=dvmpicast/1" /etc/dstar-radio.mmdvmhost
sudo sed -i "/\[Modem\]/,/\[/ s/Port=.*$/Port=\/dev\/ttyAMA0/1" /etc/mmdvmhost
sudo sed -i "/\[Modem\]/,/\[/ s/UARTSpeed=.*$/UARTSpeed=/1" /etc/mmdvmhost
sudo sed -i "/repeaterType1=/c\\repeaterType1=0" /etc/ircddbgateway

# reset the bad boy
# Don't run this if called from config page:
if [ "$1" != "conf_page" ]; then
    sudo /usr/local/cast/bin/cast-reset ; sudo gpio mode 10 in
fi
sudo gpio mode 10 in
sleep 1

sudo systemctl stop castserial.service > /dev/null 2>&1 &

# Don't run this if called from config page:
if [ "$1" != "conf_page" ]; then
    sudo systemctl start mmdvmhost.service > /dev/null 2>&1 &
fi

exit 0
