#1/bin/bash

#
# Cast Mainboard Firmware Updater (called from Cast Update Pg.)
#
# PE1MSZ, PE1PLM, W0CHP
#

# let's only stop what's neccessary...
systemctl stop cron.service  > /dev/null 2>&1
systemctl stop pistar-watchdog.timer > /dev/null 2>&1
systemctl stop pistar-watchdog.service > /dev/null 2>&1
systemctl stop mmdvmhost.timer > /dev/null 2>&1
systemctl stop mmdvmhost.service > /dev/null 2>&1

# firmware received in zip-format, unzip and continue
DIR="/opt/cast/usr-local-cast-www/cast-firmware/fw/castmain"
UPLOADED="$DIR/*.zip"
for zipped in $UPLOADED
do
    sudo unzip -o ${zipped} -d $DIR
done

FIRMWARE="$DIR/*.hex"
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
    if [ ! -d "$DIR/backup" ] ; then
	mkdir $DIR/backup
    fi
    sudo mv ${found} "$DIR/backup/"
    sudo mv $UPLOADED "$DIR/backup/"
    sudo /usr/local/cast/bin/cast-reset
    sleep 2

    systemctl start mmdvmhost.service > /dev/null 2>&1
    systemctl start mmdvmhost.timer > /dev/null 2>&1
    systemctl start pistar-watchdog.service > /dev/null 2>&1
    systemctl start pistar-watchdog.timer > /dev/null 2>&1
    systemctl start cron.service > /dev/null 2>&1
done

