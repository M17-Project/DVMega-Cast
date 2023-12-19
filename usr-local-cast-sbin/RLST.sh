#!/bin/bash

#
# Cast Memory list managment
#
# PE1MSZ, PE1PLM, W0CHP
#

## Not needed since file will always be in /usr/local/cast/etc/castmemlist.txt...
#FILE=/var/www/dashboard/castmemlist.txt
#if [ -f "$FILE" ]; then
    #sudo cp /var/www/dashboard/castmemlist.txt /home/pi-star/castmemlist.txt
#else
    #sudo cp /home/pi-star/castmemlist.txt /var/www/dashboard/castmemlist.txt 
#fi

input="/usr/local/cast/etc/castmemlist.txt"
((i = 0))
while IFS= read -r line
do
((i=i+1))
  sudo echo -n  "0,LS$i,$line" >/dev/udp/127.0.0.1/40095
done < "$input"

