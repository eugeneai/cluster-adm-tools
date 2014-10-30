#!/bin/bash

HOSTNAME=$(echo /etc/hostname)

if [ $HOSTNAME=="V208-01" ]; then
    echo "SERVER"
else
    echo "NODE"
fi
