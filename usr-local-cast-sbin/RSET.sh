#!/bin/bash

#
# Loads master settings into Cast UDP server (invoked via touchscreen)
#
# NOTE: this is also called from the WPSD config page if Cast unit is detected.
#       This allows the setting to be saved from the dashboard as well as the Nextion touchscreen.
#
# PE1MSZ, PE1PLM, W0CHP
#

input="/usr/local/cast/etc/settings.txt"
((i = 0))
while IFS= read -r line
do
((i=i+1))
 sudo echo -n  "$line" >/dev/udp/127.0.0.1/40095
done < "$input"

