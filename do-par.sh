#!/bin/bash

. ips.sh

for ip in $ips;
do
	#echo "Node $ip"
	if [ "$myip" = "$ip" ]
	then
		echo "skip myself."
	else
            ping -W 2 -c 1 $ip 2>1 > /dev/null
            if [ $? -eq 0 ] ;
            then
		ssh root@$ip "$*" &
		#echo "Done"
            else
                echo "Error: Station $ip is down."
            fi
	fi
done
