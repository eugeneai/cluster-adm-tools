#!/bin/bash
grub-install /dev/sda
mkinitcpio -p linux
grub-mkconfig -o /boot/grub/grub.cfg
systemctl disable openvpn

# update-grub2
