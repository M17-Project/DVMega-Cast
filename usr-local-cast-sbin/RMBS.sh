#!/bin/bash

#
# Places Cast in Base Station/IP Radio Mode
#
# PE1MSZ, PE1PLM, W0CHP
#

# Don't run this if called from config page:
if [ "$1" != "conf_page" ]; then
    sudo systemctl stop pistar-watchdog > /dev/null 2>&1
    sudo systemctl stop pistar-watchdog.timer > /dev/null 2>&1
    sudo systemctl stop mmdvmhost.timer > /dev/null 2>&1
    sudo systemctl stop mmdvmhost.service > /dev/null 2>&1
fi

sudo sed -i "/\[Modem\]/,/\[/ s/Hardware=.*$/Hardware=dvmpicast/1" /etc/dstar-radio.mmdvmhost
sudo sed -i "/\[Modem\]/,/\[/ s/Port=.*$/Port=\/dev\/ttyAMA0/1" /etc/mmdvmhost
sudo sed -i "/\[Modem\]/,/\[/ s/UARTSpeed=.*$/UARTSpeed=/1" /etc/mmdvmhost
sudo sed -i "/repeaterType1=/c\\repeaterType1=0" /etc/ircddbgateway

sed -i '/MMDVM protocol version: 1, description:/d; /MMDVM protocol version: 2, description:/d' /var/log/pi-star/MMDVM-*.log  >/dev/null 2>&1

# reset the bad boy
# Don't run this if called from config page:
if [ "$1" != "conf_page" ]; then
    sudo /usr/local/cast/bin/cast-reset
fi
sudo gpio mode 10 in
sleep 1

sudo systemctl stop castserial.service > /dev/null 2>&1 &

# Don't run this if called from config page:
if [ "$1" != "conf_page" ]; then
    sudo systemctl start mmdvmhost.service > /dev/null 2>&1 &
    sudo systemctl start mmdvmhost.timer > /dev/null 2>&1 &
    sudo systemctl start pistar-watchdog > /dev/null 2>&1
    sudo systemctl start pistar-watchdog.timer > /dev/null 2>&1
fi

while ! grep -q "description:" /var/log/pi-star/MMDVM-*.log; do
    sleep 1
done
sudo /usr/local/sbin/.wpsd-sys-cache >/dev/null 2>&1

exit 0
