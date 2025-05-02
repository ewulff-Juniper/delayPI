#!/bin/bash

#Adds rate limit, 25% packet loss, and 30-70 delay in each direction
#Multiple impedments on one interface must be on the same line
tc qdisc add dev eth0 root netem rate 5mbit loss 25% delay 50ms 20ms 25%
tc qdisc add dev eth1 root netem rate 10mbit loss 25% delay 50ms 20ms 25%