#!/bin/bash

#
# Sets All modes to what boolean is passed to the argument:
# 
# STMD.sh DMR(0,1) D-Star(0,1) YSF(0,1)
# 
#   This script is used by the Cast display udp service when
#   a user enables/disabled their delected modes.
#
# PE1MSZ, PE1PLM, W0CHP
#

if [ "$#" -ne 3 ]; then
    echo "Bad syntax"
    exit 1
fi

MMDVMCONFIG="/etc/mmdvmhost"

# existing mode statuses:
DMR_e=$(awk -F'=' '/\[DMR\]/{flag=1; next} flag && /Enable/{gsub(/[[:space:]]/, "", $2); print $2; flag=0}' ${MMDVMCONFIG})
DStar_e=$(awk -F'=' '/\[D-Star\]/{flag=1; next} flag && /Enable/{gsub(/[[:space:]]/, "", $2); print $2; flag=0}' ${MMDVMCONFIG})
YSF_e=$(awk -F'=' '/\[System Fusion\]/{flag=1; next} flag && /Enable/{gsub(/[[:space:]]/, "", $2); print $2; flag=0}' ${MMDVMCONFIG})

# map STMD.sh's 3 args
arg1=$1  # DMR
arg2=$2  # D-Star
arg3=$3  # YSF

# Convert STMD's mode status boolean args to wpsd-mode-manager's mode status string args
convert_to_status() {
    case "$1" in
        0) echo "Disable" ;;
        1) echo "Enable" ;;
    esac
}
# now map the mode status booleans to strings for wpsd-mode-manager using convert_to_status()
DMR_s=$(convert_to_status "$arg1")
DStar_s=$(convert_to_status "$arg2")
YSF_s=$(convert_to_status "$arg3")

# check if the desired status is different from the current status before calling wpsd-mode-manager
if [ "$DMR_s" != "$DMR_e" ]; then
    sudo /usr/local/sbin/wpsd-mode-manager "DMR" "$DMR_s"
fi

if [ "$DStar_s" != "$DStar_e" ]; then
    sudo /usr/local/sbin/wpsd-mode-manager "D-Star" "$DStar_s"
fi

if [ "$YSF_s" != "$YSF_e" ]; then
    sudo /usr/local/sbin/wpsd-mode-manager "YSF" "$YSF_s"
fi

