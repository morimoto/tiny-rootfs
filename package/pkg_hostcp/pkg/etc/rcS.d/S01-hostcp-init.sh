#! /bin/sh

# create /etc/hostcp.conf which contains ip address to our bootserver
dmesg | grep bootserver= | cut -c 17- | cut -d "," -f 1 > /etc/hostcp.conf
