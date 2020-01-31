#!/bin/bash

# DEBUG="echo"

set -o xtrace

IP=$1
# We suppose by default that we do the initial installation of the node.
OPTION="renew"
# Otherwise OPTION will be "renew"
ROOT=""
# PCM="/etc/pacman.conf"
PCM="/mnt/new"

# $DEBUG apt-get clean
ssh-copy-id root@$IP

RC=$(ssh root@$IP "ls $PCM")

if [ "$RC" = "$PCM" ] ; then
    OPTION="new"
fi


echo "The variant is $OPTION $RC"
# exit 0

if [ "$OPTION" = "new" ] ; then
    FROOT="/mnt/arch"
    DIRS="bin mnt run srv var lib lib64 media opt sbin usr boot"
    #dev  etc  home  proc  root  sys
else
    sleep $[ ( $RANDOM % 10 )  + 1 ]s
    FROOT="/"
    DIRS="boot opt srv usr var"
fi


#DIRS="test"
UDIRS="home root"
#UDIRS="test2"
RSYNC="rsync --timeout=15 --stats --progress -avz --exclude-from=exclude-main.txt --delete-after"
URSYNC="rsync --timeout=15 --stats --progress -avzu --max-size=5M --exclude-from=exclude-main.txt"
WHERE="root@$IP:$FROOT"
RSYNC_PASSWORD="1111"
FDEV="/root/dev"

#cat stagem.sh.in > stagem.sh
#UNAME=$(uname -r)
#echo "dpkg-reconfigure linux-image-$UNAME" >> stagem.sh

$DEBUG ssh root@$IP 'bash -s' < /root/cluster/stage1-$OPTION.sh

$DEBUG $RSYNC --exclude-from=exclude-etc.txt --delete-after /etc/ $WHERE/etc

# exit 0

for D in $DIRS
do
    RS="$RSYNC /$D $WHERE"
    # echo ">>>>>>>>>>> $RS"
    $DEBUG $RS
done

for D in $UDIRS
do
    RS="$URSYNC /$D $WHERE"
    $DEBUG $RS
done

#Rsyncyng dev
if [ "$OPTION" = "new" ] ; then
    # mkdir -p $FDEV
    # mount --bind /dev $FDEV
    $DEBUG $RSYNC $FDEV/ $WHERE/dev
fi


# $DEBUG ssh root@$IP "echo $IP > /etc/mosix/mosip"

$DEBUG ssh root@$IP 'bash -s' < /root/cluster/stage2-$OPTION.sh

echo "The sync is ended."

#$DEBUG sleep 2s
