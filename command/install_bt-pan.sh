#!/bin/sh
apt -y install python-dbus bridge-utils
wget -O /usr/local/bin/bt-pan https://raw.githubusercontent.com/mk-fg/fgtk/master/bt-pan
chmod +x /usr/local/bin/bt-pan
