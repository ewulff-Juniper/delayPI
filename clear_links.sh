#!/bin/bash

#Clear the qdiscs for both interfaces
tc qdisc del dev eth0 root && tc qdisc del dev eth1 root