#!/bin/bash

#
# Nextion TFT uploader (called from Cast Update Pg.)
#
# PE1MSZ, PE1PLM, W0CHP
#

sudo wpsd-services fullstop

# firmware received in zip-format, unzip and continue
UPLOADED=./nextion/*.zip
for zipped in $UPLOADED
do
    sudo unzip -o ${zipped} -d ./nextion
done

FIRMWARE=./nextion/*.tft
for found in $FIRMWARE
do
    echo "Found $found firmware..."

    case ${found} in
	(*F024*)  python3 /usr/local/cast/sbin/nextionupload.py /dev/ttyAMA0 NX3224F024 ${found};;
	(*T024*)  python3 /usr/local/cast/sbin/nextionupload.py /dev/ttyAMA0 NX3224T024 ${found};;
    esac

    # Firmware found, uploading with python-script.
    # pythonupload has been modified!!

    #python ./nextion/nextionupload.py /dev/ttyAMA0 NX3224F024 ${found}

    # move to backup folder, and reboot
    sudo mv ./nextion/*.tft ./nextion/backup
    sudo mv ./nextion/*.zip ./nextion/backup
    # to make it work, reset mainboard, and reboot afterwards.
    sleep 2 
    sudo cast-reset
    sleep 2 
    sudo wpsd-services start
 done

