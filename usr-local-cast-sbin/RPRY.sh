#!/bin/bash

#
# Reads YSF preset file into Cast UDP server
#
# PE1MSZ, PE1PLM, W0CHP
#

input="/usr/local/cast/etc/ysfpre.txt"

((i = 0))
mapfile -t lines < "$input"
for line in "${lines[@]}"
do
  ((i++))
  printf "%s" "$line" > /dev/udp/127.0.0.1/40095 
done

