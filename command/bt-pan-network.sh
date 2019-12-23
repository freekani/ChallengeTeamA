#!/bin/sh
/sbin/modprobe bnep
/bin/hciconfig hci0 lm master,accept
/sbin/ip link set pan0 up
/bin/hciconfig hci0 sspmode 0
