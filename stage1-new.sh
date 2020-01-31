#!/bin/bash

mkdir -p /mnt/arch/
mount /dev/disk/by-label/linux /mnt/arch 
mkdir -p /mnt/arch/{proc,sys,tmp,boot,mnt}
mount /dev/disk/by-label/EFI /mnt/arch/boot
