#!/bin/bash

#
# Places Cast in Hotspot Mode
#
# PE1MSZ, PE1PLM, W0CHP
#

# Don't run this if called from config page:
if [ "$1" != "conf_page" ]; then
    sudo systemctl stop mmdvmhost.service > /dev/null 2>&1
fi

sudo sed -i "/\[Modem\]/,/\[/ s/Hardware=.*$/Hardware=dvmpicasths/1" /etc/dstar-radio.mmdvmhost
sudo sed -i "/\[Modem\]/,/\[/ s/Port=.*$/Port=\/dev\/ttyS2/1" /etc/mmdvmhost
sudo sed -i "/\[Modem\]/,/\[/ s/UARTSpeed=.*$/UARTSpeed=115200/1" /etc/mmdvmhost
# sudo sed -i "s%.*Hardware=dvmpicast.*%Hardware=dvmpicasthd%" /etc/dstar-radio.mmdvmhost
# sudo sed -i "s%Port=/dev/ttyAMA0%Port=/dev/ttyS2%1" /etc/mmdvmhost
sudo sed -i "/repeaterType1=/c\\repeaterType1=0" /etc/ircddbgateway

# reset the bad boy
# Don't run this if called from config page:
if [ "$1" != "conf_page" ]; then
    sudo /usr/local/cast/bin/cast-reset
fi
sudo gpio mode 10 in
sleep 1

# Don't run this if called from config page:
if [ "$1" != "conf_page" ]; then
    sudo systemctl start mmdvmhost.service > /dev/null 2>&1 &
fi

sudo systemctl start castserial.service > /dev/null 2>&1 &

exit 0
