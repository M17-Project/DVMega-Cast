#!/bin/bash

#
# Restarts MMDVMhost in bkgnd.
#
# PE1MSZ, PE1PLM, W0CHP
#

sudo systemctl restart mmdvmhost.service > /dev/null 2>&1 &
