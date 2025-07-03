#!/bin/bash

# this script starts a wifi hotspot using nmcli cmds

IFACE="wlan0"
SSID="FlunkinWiFi"

# use 1st input as interface
if [ ! -z "$1" ]; then
  IFACE=$1
fi

# use 2nd input as ssid
if [ ! -z "$2" ]; then
  SSID=$2
fi

echo "starting hotspot with ssid='$SSID' on interface='$IFACE'..."

# check for nmcli 
if ! which nmcli > /dev/null 2>&1; then
  echo "error: nmcli command not found. get NetworkManager."
  exit 1
fi

# check the interface is even real
if ! ip link show $IFACE > /dev/null 2>&1; then
  echo "error: network interface '$IFACE' does not exist."
  exit 1
fi

# if interface is down then bring it up
STATE=$(ip link show $IFACE | grep -o "state DOWN")
if [ "$STATE" = "state DOWN" ]; then
  sudo ip link set $IFACE up
fi

# start hotspot with no password/encryption
nmcli device wifi hotspot ifname $IFACE ssid $SSID band bg password "" > /dev/null 2>&1
RET=$?

if [ $RET -eq 0 ]; then
  echo "hotspot '$SSID' started okay."
  echo "devices can connect but there is no internet."
else
  echo "failed to run hotspot. check if your interface supports AP mode."
fi
