#!/bin/bash
ips=$(awk '{ print $2;}' win-ips.txt)
macs=$(awk '{ print $1;}' win-ips.txt)
myip="172.27.24.176"
echo $ips

echo $macs
