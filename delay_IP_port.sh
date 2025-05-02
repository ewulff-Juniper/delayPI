#!/bin/bash

echo "Delaying IP: $1"

#Setup prio tree
tc qdisc add dev eth0 root handle 1: prio

#Match IP and port if it's given to 1:1
if [ $2 ]
then
	#Match both ip and port
	echo "With port $2"
	tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst $1 match ip dport $2 0xffff flowid 1:1
else
	#Match just ip
	tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst $1 flowid 1:1
fi

#Match all other traffic to 1:2
tc filter add dev eth0 protocol all parent 1: prio 2 u32 match ip dst 0.0.0.0/0 flowid 1:2

#Add delay to 1:1, this could be any of the impedments
tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 50ms

tc qdisc add dev eth0 parent 1:2 handle 20: sfq