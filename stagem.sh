#!/bin/bash
sed 's/#CLIENT#//g' -i /etc/fstab
#grub-install /dev/sda
refind-install
cp -fv /etc/cluster/refind.conf /boot/EFI/Microsoft/Boot
cp -fv /etc/cluster/lxdm.conf /var/lib/lxdm/lxdm.conf
udevadm hwdb --update
mkinitcpio -p linux-lts
#grub-mkconfig -o /boot/grub/grub.cfg
# depmod -a
#netctl disable eth
systemctl stop openvpn-client@client-irnok
systemctl disable openvpn-client@client-irnok
systemctl disable frr
systemctl disable docker
systemctl disable nfs-server.service
systemctl disable squid.service
systemctl enable nfs-client.target
systemctl restart nfs-client.target

# update-grub2
