#!/bin/bash
ips=$(awk '{ print $2;}' /etc/ethers)
macs=$(awk '{ print $1;}' /etc/ethers)
myip=$(cat /etc/mosix/mosip)
