#!/bin/sh

cat <<EOT > /etc/udev/rules.d/99-logitech-webcam.rules
#SUBSYSTEM=="video4linux", KERNEL=="video[0-9]*", ATTRS{product}=="Logi Webcam C920e", ATTR{index}=="0", RUN+="/usr/bin/v4l2-ctl -d /dev/video0 -c exposure_auto=1", RUN+="/usr/bin/v4l2-ctl -d /dev/video0 -c focus_automatic_continuous=0", RUN+="/usr/bin/v4l2-ctl -d /dev/video0 -c exposure_absolute=600", RUN+="/usr/bin/v4l2-ctl -d /dev/video0 -c focus_absolute=35"
SUBSYSTEM=="video4linux", KERNEL=="video[0-9]*", ATTRS{product}=="Logi Webcam C920e", ATTR{index}=="0", RUN+="/usr/bin/v4l2-ctl -c focus_automatic_continuous=0"
EOT

# Keychron keyboard, to upgrade most of the bios (mouse and wireless keyboard),
# visit https://launcher.keychron.com/ and may be useful also https://usevia.app/
# To upgrade keychron keyboard firmware the only way seems to be:
# dfu-util -a 0 --dfuse-address 0x08000000:leave -D k1_max_ansi_white_v1.1.1_2504231209.bin
cat <<EOT > /etc/udev/rules.d/99-via.rules
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", TAG+="uaccess", TAG+="udev-acl"
EOT

echo "Namecheap dynamic dns password? Advanced DNS -> Dynamic DNS Password"
read -s dyndns_pass
echo
cat <<EOT > /etc/ddclient/ddclient.conf
use=web, web=dynamicdns.park-your-domain.com/getip
protocol=namecheap,				\
server=dynamicdns.park-your-domain.com,		\
login=santiagopastorino.com,			\
password=$dyndns_pass				\
dev
EOT
