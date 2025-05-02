#!/bin/bash

#Set up a bridge, add both interfaces, get a new IP for the bridge
ifconfig eth1 up
ip link add br0 type bridge
ip link set br0 up
ip link set dev eth0 master br0
ip link set dev eth1 master br0
ifconfig eth0 0.0.0.0
dhclient br0