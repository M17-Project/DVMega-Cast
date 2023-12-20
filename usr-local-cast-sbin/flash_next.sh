#!/bin/bash

#
# Nextion TFT uploader (called from Cast Update Pg.)
#
# PE1MSZ, PE1PLM, W0CHP
#

sudo wpsd-services fullstop

sleep 5

# firmware received in zip-format, unzip and continue
DIR="/opt/cast/usr-local-cast-www/cast-firmware/fw/nextion"
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
	(*F024*)  python3 /usr/local/cast/sbin/nextionupload.py /dev/ttyAMA0 NX3224F024 ${found};;
	(*T024*)  python3 /usr/local/cast/sbin/nextionupload.py /dev/ttyAMA0 NX3224T024 ${found};;
    esac

    # Make a backup of the uploaded FW to backup-folder
    if [ ! -d "$DIR/backup" ] ; then
	mkdir $DIR/backup
    fi
    sudo mv ${found} "$DIR/backup/"
    sudo mv $UPLOADED "$DIR/backup/"
    sleep 2 
    sudo /usr/local/cast/bin/cast-reset
    sleep 2 
    sudo systemctl start cron.service > /dev/null 2>&1
done

