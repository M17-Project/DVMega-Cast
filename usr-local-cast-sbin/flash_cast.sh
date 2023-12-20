#1/bin/bash

#
# Cast Mainboard Firmware Updater (called from Cast Update Pg.)
#
# PE1MSZ, PE1PLM, W0CHP
#

sudo wpsd-services fullstop

# firmware received in zip-format, unzip and continue
DIR=/opt/cast/usr-local-cast-www/cast-firmware/fw/castmain/
UPLOADED=$DIR/*.zip
for zipped in $UPLOADED
do
    sudo unzip -o ${zipped} -d $DIR
done

FIRMWARE=./cast/*.hex
for found in $FIRMWARE
do
    echo "Found $found firmware..."
    # take action on this file, upload it to mainboard.

    sudo gpio mode 10 out
    sudo gpio write 10 1
    sudo gpio write 10 0
    sleep 1
    sudo gpio write 10 1
    sudo stm32flash -e 123 -v -w ${found} /dev/ttyAMA0
    sudo gpio mode 10 in

    # Make a backup of the uploaded FW to backup-folder, and reboot afterwards.
    sudo mv ${found} $DIR/backup
    sudo mv $UPLOADED $DIR/backup
    sudo cast-reset
    sleep 2
    sudo wpsd-services start
done
