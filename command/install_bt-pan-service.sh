#!/bin/sh
cp pan0 /etc/network/interfaces.d/
chmod +x bt-pan-network.sh
cp bt-pan-network.sh /usr/local/bin
cp bt-pan.service /etc/systemd/system/
cp after-default-target.service /etc/systemd/system/

systemctl enable bt-pan
systemctl enable after-default-target

