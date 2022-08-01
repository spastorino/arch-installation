#!/bin/sh

# Configure Wi-Fi
echo "WiFi network:"
read ESSID
echo "WiFi password:"
read WIFI_PASS

cat <<EOT > /etc/netctl/wlp0s20f3
Description='wlp0s20f3 WiFi'
Interface=wlp0s20f3
Connection=wireless
Security=wpa
ESSID='$ESSID'
IP=dhcp
Key='$WIFI_PASS'
EOT

netctl start wlp0s20f3

# Create user
echo "username:"
read USER
useradd -m -G users,wheel,adm -s /bin/bash $USER
passwd $USER

# Install sudo
pacman -S sudo
sed -i '/^#.*wheel ALL=(ALL) ALL/s/^# //' /etc/sudoers

# Sysctl settings
echo "kernel.sysrq=1" > /etc/sysctl.d/99-sysctl.conf

# Install video drivers
pacman -S mesa vulkan-intel

# Install LTS linux kernel
pacman -S linux-lts linux-lts-headers

# Make console font bigger
pacman -S terminus-font
echo "setfont ter-228b" >> /etc/vconsole.conf

# Install and Start ntp
pacman -S ntp
systemctl enable ntpd.service
systemctl start ntpd.service

# Install acpid
pacman -S acpid
systemctl enable acpid.service
systemctl start acpid.service

# Disable coredumps
echo "kernel.core_pattern=|/bin/false" > /etc/sysctl.d/50-coredump.conf

# Install development packages
pacman -S ccache
pacman -S clang
pacman -S cloc
pacman -S cmake
pacman -S code
pacman -S ctags
pacman -S lib32-gcc-libs
pacman -S docker
pacman -S emacs
pacman -S fzf
pacman -S gdb
pacman -S git
pacman -S go
pacman -S graphviz
pacman -S jq
pacman -S linux-tools
pacman -S mosh
pacman -S nodejs npm
pacman -S openssh
pacman -S perf
pacman -S pkg-config
pacman -S python
pacman -S ripgrep
pacman -S rustup
pacman -S rust-analyzer
pacman -S strace
pacman -S time
pacman -S tmate
pacman -S tmux
pacman -S valgrind
pacman -S vim
pacman -S wmctrl

# Instal Gnome
pacman -S gnome gnome-extra
pacman -S network-manager-applet networkmanager
systemctl enable NetworkManager.service
systemctl enable gdm.service
# Use Wayland
#sed -i '/^WaylandEnable=false/s/^W/#W/' /etc/gdm/custom.conf
# Use Xorg
#sed -i '/^#.*WaylandEnable=false/s/^#//' /etc/gdm/custom.conf
pacman -S xrandr

# Install Browsers
pacman -S firefox
pacman -S firefox-developer-edition
pacman -S chromium
pacman -S torbrowser-launcher

# Install UI programs and utilities
pacman -S gvim
pacman -S xclip

# iPhone
pacman -S gvfs-afc
pacman -S ifuse

# Kindle
pacman -S mtpfs

# Ruby
pacman -S ruby
pacman -S ruby-irc
pacman -S ruby-minitest

# Install system utilities
pacman -S deja-dup
pacman -S fwupd
pacman -S efibootmgr
pacman -S udftools
pacman -S syncthing-gtk

# Install utilities
pacman -S aspell
pacman -S aspell-es
pacman -S aspell-en
pacman -S keepassxc
pacman -S xdg-utils
pacman -S youtube-dl

# Install virtualization programs
pacman -S vagrant
pacman -S virtualbox virtualbox-host-modules-arch virtualbox-guest-iso

# sys
pacman -S adobe-source-sans-pro-fonts adobe-source-serif-pro-fonts
pacman -S bash-completion
pacman -S bat
pacman -S bzip2
pacman -S cups cups-pdf
systemctl enable org.cups.cupsd.service
systemctl start org.cups.cupsd.service
pacman -S docker
pacman -S emacs
pacman -S ethtool
pacman -S exa
pacman -S exfat-utils
pacman -S fakeroot
pacman -S fd
pacman -S gptfdisk
pacman -S htop
pacman -S hunspell
pacman -S imagemagick
pacman -S iotop
pacman -S linux-headers
pacman -S lynx
pacman -S lshw
pacman -S lsof
pacman -S mtr
pacman -S net-tools
pacman -S nload
pacman -S p7zip
pacman -S python2-pydbus
pacman -S rsync
pacman -S tree
pacman -S file
pacman -S gzip
pacman -S tar
pacman -S traceroute
pacman -S unrar
pacman -S wget

# ui
pacman -S alacritty
pacman -S audacity
pacman -S audio-convert id3lib mplayer musepack-tools vorbis-tools
pacman -S libreoffice
pacman -S vlc
pacman -S xorg-xauth

pacman -S bmon
pacman -S brasero
pacman -S calibre
pacman -S ghc
pacman -S gimp
pacman -S gitg
pacman -S glabels
pacman -S gnome-notes
pacman -S gnucash
pacman -S gtk-recordmydesktop
pacman -S gucharmap
pacman -S hdparm
pacman -S homebank
pacman -S hugo
pacman -S hyperfine
pacman -S jdk11-openjdk
pacman -S kcachegrind
pacman -S keybase
pacman -S ldns
pacman -S mplayer
pacman -S nfs-utils
pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
pacman -S pavucontrol
pacman -S postgresql
pacman -S powerline-fonts
pacman -S powertop
pacman -S python-pip
pacman -S soundconverter
pacman -S speedtest-cli
pacman -S sshfs
pacman -S tcpdump
pacman -S valgrind massif-visualizer
pacman -S vinagre
pacman -S vym
pacman -S w3m
pacman -S wavemon
pacman -S wl-clipboard
# Allow Firefox screensharing on wayland
pacman -S xdg-desktop-portal-wlr
pacman -S xournalpp

sed -i '/^#user_allow_other/s/^#//' /etc/fuse.conf

cat <<EOT > /etc/udev/rules.d/99-logitech-webcam.rules
#SUBSYSTEM=="video4linux", KERNEL=="video[0-9]*", ATTRS{product}=="Logi Webcam C920e", ATTR{index}=="0", RUN+="/usr/bin/v4l2-ctl -d $devnode -c exposure_auto=1", RUN+="/usr/bin/v4l2-ctl -d $devnode -c focus_auto=0", RUN+="/usr/bin/v4l2-ctl -d $devnode -c exposure_absolute=600", RUN+="/usr/bin/v4l2-ctl -d $devnode -c focus_absolute=35"
SUBSYSTEM=="video4linux", KERNEL=="video[0-9]*", ATTRS{product}=="Logi Webcam C920e", ATTR{index}=="0", RUN+="/usr/bin/v4l2-ctl -d $devnode -c focus_auto=0"
EOT

# Namecheap dyndns
pacman -S ddclient
echo "Namecheap dyndns password: "
read -n DYNDNS_PASS
echo
cat <<EOT > /etc/ddclient/ddclient.conf
use=web, web=dynamicdns.park-your-domain.com/getip
protocol=namecheap,				\
server=dynamicdns.park-your-domain.com,		\
login=santiagopastorino.com,			\
password=$DYNDNS_PAS	\
dev
EOT
