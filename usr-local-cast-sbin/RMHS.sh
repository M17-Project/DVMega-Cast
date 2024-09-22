#!/bin/bash

#
# Places Cast in Hotspot Mode
#
# PE1MSZ, PE1PLM, W0CHP
#

sudo systemctl stop castserial.service > /dev/null 2>&1

# Don't run this if called from config page:
if [ "$1" != "conf_page" ]; then
    sudo systemctl stop mmdvmhost.service > /dev/null 2>&1
fi

if [ "$2" == "dual" ]; then # this is also called from the config page...
    sudo sed -i "s%.*Hardware=dvmpicast.*%Hardware=dvmpicasthd%" /etc/dstar-radio.mmdvmhost
else
    sudo sed -i "/\[Modem\]/,/\[/ s/Hardware=.*$/Hardware=dvmpicasths/1" /etc/dstar-radio.mmdvmhost
fi

sudo sed -i "/\[Modem\]/,/\[/ s/Port=.*$/Port=\/dev\/ttyS2/1" /etc/mmdvmhost
sudo sed -i "/\[Modem\]/,/\[/ s/UARTSpeed=.*$/UARTSpeed=115200/1" /etc/mmdvmhost

sed -i '/MMDVM protocol version: 1, description:/d; /MMDVM protocol version: 2, description:/d' /var/log/pi-star/MMDVM-*.log  >/dev/null 2>&1

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

sudo /usr/local/sbin/.wpsd-sys-cache >/dev/null 2>&1

exit 0

