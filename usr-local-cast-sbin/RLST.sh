#!/bin/bash

#
# Cast Memory list managment; pushes list into cast UDPserver
#
# PE1MSZ, PE1PLM, W0CHP
#

input="/usr/local/cast/etc/castmemlist.txt"

mapfile -t lines < "$input"

for ((i=0; i<${#lines[@]}; i++)); do
  sudo echo -n "0,LS$((i+1)),${lines[i]}" >/dev/udp/127.0.0.1/40095
done

