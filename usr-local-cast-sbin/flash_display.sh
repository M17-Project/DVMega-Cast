#!/bin/bash

#
# Nextion TFT uploader (called from Cast Update Pg.)
#
# PE1MSZ, PE1PLM, W0CHP
#

# let's only stop what's neccessary...
sudo systemctl stop cron.service  > /dev/null 2>&1
sudo systemctl stop pistar-watchdog.timer > /dev/null 2>&1
sudo systemctl stop pistar-watchdog.service > /dev/null 2>&1
sudo systemctl stop mmdvmhost.timer > /dev/null 2>&1
sudo systemctl stop mmdvmhost.service > /dev/null 2>&1
sudo systemctl stop castserial.service > /dev/null 2>&1

sudo gpio mode 10 out

# firmware received in zip-format, unzip and continue
DIR="/opt/cast/usr-local-cast-www/cast-firmware/fw/cast_display"
UPLOADED="$DIR/*.zip"
for zipped in $UPLOADED
do
    sudo unzip -o ${zipped} -d $DIR
done

FIRMWARE="$DIR/*.tft"
for found in $FIRMWARE
do
    echo "Found $found firmware..."
    case ${found} in
	(*F024*)  python3 /usr/local/cast/sbin/nextionupload.py -p /dev/ttyAMA0 -c 115200 -u 115200 -i ${found};;
	(*J024*)  python3 /usr/local/cast/sbin/nextionupload.py -p /dev/ttyAMA0 -c 115200 -u 115200 -i ${found};;
	(*T024*)  python3 /usr/local/cast/sbin/nextionupload.py -p /dev/ttyAMA0 -c 115200 -u 115200 -i ${found};;
    esac

    # Make a backup of the uploaded FW to backup-folder
    if [ ! -d "$DIR/backup" ] ; then
	mkdir $DIR/backup
    fi
    sudo mv ${found} "$DIR/backup/"
    sudo mv $UPLOADED "$DIR/backup/"

    sudo /usr/local/cast/bin/cast-reset
    sleep 2

    sudo systemctl start castserial.service > /dev/null 2>&1
    sudo systemctl start mmdvmhost.service > /dev/null 2>&1
    sudo systemctl start mmdvmhost.timer > /dev/null 2>&1
    sudo systemctl start pistar-watchdog.service > /dev/null 2>&1
    sudo systemctl start pistar-watchdog.timer > /dev/null 2>&1
    sudo systemctl start cron.service > /dev/null 2>&1
done

