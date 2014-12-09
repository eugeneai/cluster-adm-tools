#!/bin/bash

. ips.sh

for mac in $macs;
do
	echo "Node $mac"
	wol $mac
done
