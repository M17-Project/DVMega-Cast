#!/bin/bash

#
# Reads DMR preset file into Cast UDP server
#
# PE1MSZ, PE1PLM, W0CHP
#

input="/usr/local/cast/etc/dmrpre.txt"

((i = 0))
while IFS= read -r line
do
((i=i+1))
  echo -n "$line" | sudo tee /dev/udp/127.0.0.1/40095 > /dev/null
done < "$input"

