#!/bin/bash
cd /mnt/gentoo
rm -rf /mnt/gentoo/{local,selinux,data,lib64}
ln -sf usr/lib lib64
/mnt/gentoo/usr/bin/arch-chroot /mnt/gentoo /root/stagem.sh
umount /dev/sda3
umount /dev/sda2
