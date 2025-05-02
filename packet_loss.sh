#!/bin/bash

#Adds 25% packet loss to both interfaces
tc qdisc add eth0 root netem loss 25%
tc qdisc add eth1 root netem loss 25%