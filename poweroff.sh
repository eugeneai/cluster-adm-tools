#!/bin/bash
echo "[base]" > /var/lib/lxdm/lxdm.conf
echo "last_session=/usr/share/xsessions/mate.desktop" >> /var/lib/lxdm/lxdm.conf
echo "last_lang=" >> /var/lib/lxdm/lxdm.conf
poweroff
