# Delay Pi
This project aims to provide a tool to demonstrate SDWAN capabilities during a PoC or demo. This can be done physically with a PI or virtually with a vm.

## Setup
The scripts in this project can be used on either a physically PI with two ethernet interfaces or a linux VM. 
The build_bridge.sh script will build a bridge, put both interfaces on the bridge, add an l3 address to the bridge and ask for a dhcp address.
It is possible to auto run the build_bridge.sh script at start but depending on how you set it up eth0 may ask for a IP address before the build_bridge script runs and so that IP will get deleted and the bridge br0 will then ask for an IP.

Insert this Pi or VM between the SSR/SRX your demoing and one of two WAN links. Then once the bridge is built you can run any of the example scripts to introduce some sort of impedment on the link. 
It should be noted that once an impedment is added to an interface you can't add more without clearing the first. If you want to add multiple different impedments it must be done at the same time, see bad_connection.sh for an example of that.
To clear an impedment run the clear_links.sh script.

## How it works
These scripts, for the most part, use simple tc/netem commands to add an impedment to an interface. **These impedements are applied to the outgoing traffic of the specified interface.** 
For example in the rate limit example a 5mbit limit is set on eth0. If eth0 is connected to your WAN connection then that means you'll have a 5mbit upload limit.
The commands themselves are pretty simple, just remember that if you want to do multiple impedments on an interface you must add them all at once as shown in bad_connection.sh

### Targeting an application
If you want to impede only traffic destined for a certain IP/port to a singular application struggling then this is where it gets a little more complex. 
In the example delay_IP_port.sh you can see how to only impede traffic destined for a certain application. The short explanation is that we attach a filter to the root qdisc (1:) that sends matching traffic to a certain class (1:1) that gets the netem delay.
All other traffic is sent to a different class (1:2) that doesn't have a netem delay. For more information check out [this](https://lartc.org/howto/lartc.qdisc.classful.html) and [this](https://lartc.org/howto/lartc.qdisc.filters.html)
