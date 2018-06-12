#! /bin/sh

# create /etc/hostcp.conf which contains ip address to our bootserver
dmesg | grep bootserver= | cut -d = -f2 | cut -d , -f1 > /etc/hostcp.conf
