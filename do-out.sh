#!/bin/bash

. ips.sh

for ip in $ips;
do
	echo "Node $ip"
	if [ "$myip" = "$ip" ]
	then
		echo "skip."
	else
            ping -W 2 -c 1 $ip
            if [ $? -eq 0 ] ;
            then
		"$*" $ip &
		echo "Done"
            else
                echo "Station $ip is down."
            fi
	fi
done
