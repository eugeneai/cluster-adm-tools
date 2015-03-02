#!/bin/bash

IFS='
'

IP=$1
U=guest@$IP

# DEBUG=echo

DIR="/home/guest"
DIR1="$DIR/.VirtualBox"
DIR2="$DIR/VirtualBox VMs"
DIR21="$DIR/VirtualBox\ VMs"
DIR22="$DIR/VirtualBox_VMs"

ssh-copy-id guest@$IP
$DEBUG ssh root@$IP chown guest:users -R $DIR1
# $DEBUG rsync -u $DIR1/VirtualBox.xml* $U:/$DIR1
$DEBUG ssh root@$IP chown guest:users -R $DIR21
$DEBUG ssh root@$IP mv $DIR21 $DIR22
$DEBUG mv $DIR2 $DIR22
$DEBUG rsync --progress --stats -arzu $DIR22/VirtualXP $U:$DIR22
$DEBUG ssh root@$IP mv $DIR22 $DIR21
$DEBUG mv $DIR22 $DIR2
