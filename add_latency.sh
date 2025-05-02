#!/bin/bash

#Add 750ms of delay both interfaces
tc qdisc add dev eth1 root netem delay 750ms
tc qdisc add dev eth0 root netem delay 750ms