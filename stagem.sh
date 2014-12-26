#!/bin/bash
grub-install /dev/sda
udevadm hwdb --update
mkinitcpio -p linux
grub-mkconfig -o /boot/grub/grub.cfg
netctl disable eth
systemctl stop openvpn@cyber
systemctl disable openvpn@cyber
systemctl disable docker
systemctl disacle nfs-server.service
systemctl enable nfs-client.target
systemctl restart nfs-client.target

# update-grub2
