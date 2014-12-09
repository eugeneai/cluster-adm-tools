#!/bin/bash
grub-install /dev/sda
udevadm hwdb --update
mkinitcpio -p linux
grub-mkconfig -o /boot/grub/grub.cfg
netctl disable eth
systemctl stop openvpn
systemctl disable openvpn
systemctl disable docker

# update-grub2
