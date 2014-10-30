#!/bin/bash

#DEBUG="echo"

IP=$1
# We suppose by default that we do the initial installation of the node.
OPTION="new"
# Otherwise OPTION will be "renew"
ROOT=""
PCM="/etc/pacman.conf"

# $DEBUG apt-get clean
ssh-copy-id root@$IP

RC=$(ssh root@$IP "ls $PCM")

if [ "$RC" = "$PCM" ] ; then
    OPTION="renew"
fi

echo "The variant is $OPTION $RC"
sleep 5s

if [ "$OPTION" = "new" ] ; then
    FROOT="/mnt/gentoo"
    DIRS="bin cdrom mnt run srv var boot lib lib64 media opt sbin usr"
else
    FROOT="/"
    DIRS="bin srv var boot lib opt sbin usr"
fi

#DIRS="test"
UDIRS="home root"
#UDIRS="test2"
RSYNC="rsync --timeout=5 --stats --progress -avz --delete-after --exclude-from=exclude-main.txt"
URSYNC="rsync --timeout=5 --stats --progress -avzu --max-size=5M --exclude-from=exclude-main.txt"
WHERE="root@$IP:$FROOT"
RSYNC_PASSWORD="1111"
FDEV="/root/dev"

#cat stagem.sh.in > stagem.sh
#UNAME=$(uname -r)
#echo "dpkg-reconfigure linux-image-$UNAME" >> stagem.sh

if [ "$OPTION" = "new" ] ; then
    $DEBUG ssh root@$IP 'bash -s' < /root/stage1.sh
fi

for D in $DIRS
do
    RS="$RSYNC /$D $WHERE"
    echo ">>>>>>>>>>> $RS"
    $DEBUG $RS
done

for D in $UDIRS
do
    RS="$URSYNC /$D $WHERE"
    $DEBUG $RS
done

#Rsyncyng dev
if [ "$OPTION" = "new" ] ; then
    $DEBUG $RSYNC $FDEV/ $WHERE/dev
fi

$DEBUG $RSYNC --exclude-from=exclude.txt --delete-after /etc/ $WHERE/etc

$DEBUG ssh root@$IP 'bash -s' < /root/stage2-$OPTION.sh

echo "The sync is ended."

$DEBUG sleep 2s
