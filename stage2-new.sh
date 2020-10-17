#!/bin/bash
cd /mnt/arch
rm -rf /mnt/arch/{local,selinux,data,lib64}
ln -sf usr/lib lib64
/mnt/arch/usr/bin/arch-chroot /mnt/arch /root/cluster-adm-tools/stagem.sh
umount /mnt/arch

