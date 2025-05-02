#!/bin/bash

#Rate limit traffic going out eth0 to 5mbit, if eth0 is connect to wan this limits upload
tc qdisc add dev eth0 root netem rate 5mbit

#Rate limit traffic going out eth0 to 10mbit, if eth1 is connect to a client this limits download
tc qdisc add dev eth1 root netem rate 10mbit