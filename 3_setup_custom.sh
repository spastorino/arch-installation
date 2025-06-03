#!/bin/sh

cat <<EOT > /etc/udev/rules.d/99-logitech-webcam.rules
#SUBSYSTEM=="video4linux", KERNEL=="video[0-9]*", ATTRS{product}=="Logi Webcam C920e", ATTR{index}=="0", RUN+="/usr/bin/v4l2-ctl -d /dev/video0 -c exposure_auto=1", RUN+="/usr/bin/v4l2-ctl -d /dev/video0 -c focus_automatic_continuous=0", RUN+="/usr/bin/v4l2-ctl -d /dev/video0 -c exposure_absolute=600", RUN+="/usr/bin/v4l2-ctl -d /dev/video0 -c focus_absolute=35"
SUBSYSTEM=="video4linux", KERNEL=="video[0-9]*", ATTRS{product}=="Logi Webcam C920e", ATTR{index}=="0", RUN+="/usr/bin/v4l2-ctl -c focus_automatic_continuous=0"
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
