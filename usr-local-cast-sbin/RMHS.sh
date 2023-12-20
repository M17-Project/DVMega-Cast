#
# Places Cast in Hotspot Mode
#
# PE1MSZ, PE1PLM, W0CHP
#

sudo systemctl stop mmdvmhost.service > /dev/null 2>&1

sudo sed -i "/\[Modem\]/,/\[/ s/Hardware=.*$/Hardware=dvmpicasths/1" /etc/dstar-radio.mmdvmhost
sudo sed -i "/\[Modem\]/,/\[/ s/Port=.*$/Port=\/dev\/ttyS2/1" /etc/mmdvmhost
# sudo sed -i "s%.*Hardware=dvmpicast.*%Hardware=dvmpicasthd%" /etc/dstar-radio.mmdvmhost
# sudo sed -i "s%Port=/dev/ttyAMA0%Port=/dev/ttyS2%1" /etc/mmdvmhost
sudo sed -i "/repeaterType1=/c\\repeaterType1=0" /etc/ircddbgateway

# reset the bad boy
sudo /usr/local/cast/bin/cast-reset
sudo gpio mode 10 in
sleep 1

sudo systemctl start mmdvmhost.service > /dev/null 2>&1 &
