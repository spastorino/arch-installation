#!/bin/sh

# Configure Wi-Fi

cat <<EOT > /etc/iwd/main.conf
[General]
EnableNetworkConfiguration=true
EOT

# Enable networking services
systemctl enable systemd-resolved.service
systemctl start systemd-resolved.service
systemctl enable iwd.service
systemctl start iwd.service

echo "WiFi network?"
read ssid
echo "WiFi password?"
read -s wifi_passwd
echo
iwctl --passphrase $wifi_passwd station wlan0 connect $ssid

# Add Firefox nightly repo
cat <<EOT >> /etc/pacman.conf

[heftig]
SigLevel = Optional
Server = https://pkgbuild.com/~heftig/repo/\$arch
EOT

# Refresh pacman database
pacman -Sy

echo "pacman interactive? y/n"
read interactive

function pacman_install {
  if [ $interactive = 'y' ]; then
    pacman -S "$@"
  elif [ $interactive = 'n' ]; then
    pacman -S "$@" --noconfirm
  fi
}

# Install sudo
pacman_install sudo
sed -i '/^#.*wheel ALL=(ALL:ALL) ALL/s/^# //' /etc/sudoers

# Install intel video drivers
pacman_install mesa vulkan-intel intel-media-driver onevpl-intel-gpu libva-utils
cat <<EOT >> /etc/modprobe.d/i915.conf
options i915 enable_guc=3 enable_fbc=1 fastboot=1
EOT

# Make console font bigger
#pacman_install terminus-font
# set vconsole keymap and font
#cat <<EOT > /etc/vconsole.conf
#KEYMAP=us
#setfont ter-228b
#EOT

# Install and Start ntp
pacman_install ntp
systemctl enable ntpd.service
systemctl start ntpd.service

# Install acpid
pacman_install acpid
systemctl enable acpid.service
systemctl start acpid.service

# Install development packages
pacman_install ast-grep
pacman_install ccache
pacman_install clang
pacman_install cloc
pacman_install cmake
pacman_install code
pacman_install ctags
pacman_install diffstat
pacman_install lib32-gcc-libs
pacman_install docker
pacman_install emacs
pacman_install fzf
pacman_install gdb
pacman_install git lazygit
pacman_install go
pacman_install graphviz
pacman_install jq
pacman_install linux-tools
pacman_install mosh
pacman_install nvm nodejs npm
pacman_install openssh
pacman_install xorg-xauth
pacman_install python
pacman_install python-pip
pacman_install python-pipx
pacman_install python-pynvim
pacman_install python-virtualenv
pacman_install ripgrep
pacman_install rustup
pacman_install strace
pacman_install time
pacman_install tmate
pacman_install tmux
pacman_install tree-sitter-cli
pacman_install valgrind
pacman_install wmctrl

# Instal Gnome
pacman_install gnome gnome-extra
pacman_install network-manager-applet networkmanager
systemctl enable NetworkManager.service
systemctl enable gdm.service

systemclt disable wpa_supplicant
systemclt stop wpa_supplicant

# Check this https://wiki.archlinux.org/title/NetworkManager#Using_iwd_as_the_Wi-Fi_backend
cat <<EOT >> /etc/NetworkManager/NetworkManager.conf
[device]
wifi.backend=iwd
wifi.iwd.autoconnect=yes
EOT

cat <<EOT >> /etc/NetworkManager/dispatcher.d/99-wlan
#!/bin/bash
wired_interfaces="en.*|eth.*"
if [[ "$1" =~ $wired_interfaces ]]; then
    case "$2" in
        up)
            nmcli radio wifi off
            ;;
        down)
            nmcli radio wifi on
            ;;
    esac
fi
EOT
chmod +x /etc/NetworkManager/dispatcher.d/99-wlan

pacman_install xorg-xrandr
# Bluetooth
pacman_install bluez bluez-utils bluez-tools
systemctl enable bluetooth.service
systemctl start bluetooth.service

# Install i3
pacman_install i3

# Screencasts
pacman_install obs-studio qt6-wayland v4l2loopback-dkms

# Install Browsers
pacman_install firefox
pacman_install firefox-developer-edition
pacman_install chromium
pacman_install torbrowser-launcher

# Install UI programs and utilities
pacman_install gvim
pacman_install xclip
pacman_install xsel

# iPhone
pacman_install gvfs-afc
pacman_install ifuse

# Kindle
pacman_install mtpfs

# Ruby
pacman_install ruby
pacman_install ruby-irb
pacman_install ruby-minitest

# Install system utilities
pacman_install deja-dup
pacman_install fwupd

# Install utilities
pacman_install adobe-source-sans-pro-fonts adobe-source-serif-pro-fonts
pacman_install aspell aspell-es aspell-en
pacman_install bash-completion
pacman_install bat
pacman_install cups cups-pdf
systemctl enable cups.service
systemctl start cups.service
pacman_install dfu-util
pacman_install ethtool
pacman_install eza
pacman_install fd
pacman_install flamelens
pacman_install inferno
pacman_install gptfdisk
pacman_install htop
pacman_install hunspell
pacman_install imagemagick
pacman_install iotop
pacman_install inotify-tools
pacman_install lynx
pacman_install lshw
pacman_install lsof
pacman_install keepassxc
pacman_install meld
pacman_install mlocate
pacman_install mtr
pacman_install net-tools
pacman_install nload
pacman_install p7zip
#pacman_install python-pydbus
pacman_install qrencode
pacman_install rsync
pacman_install tree
pacman_install traceroute
pacman_install unrar
pacman_install wget
pacman_install yt-dlp

# Install virtualization programs
pacman_install vagrant
pacman_install virtualbox virtualbox-host-modules-arch virtualbox-guest-iso

# ui
pacman_install alacritty
pacman_install audacity
pacman_install audio-convert id3lib mplayer musepack-tools vorbis-tools
pacman_install libreoffice
pacman_install vlc

pacman_install bmon
pacman_install brasero
pacman_install calibre
pacman_install ghc
pacman_install gimp
pacman_install gitg
pacman_install glabels
pacman_install gnucash
pacman_install gucharmap
pacman_install hdparm
pacman_install homebank
pacman_install hugo
pacman_install hyperfine
pacman_install jdk11-openjdk
pacman_install kcachegrind
pacman_install keybase
pacman_install ldns
pacman_install massif-visualizer
pacman_install nfs-utils
pacman_install noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra nerd-fonts
pacman_install pavucontrol
pacman_install postgresql
pacman_install powerline-fonts
pacman_install powertop
pacman_install recordmydesktop
pacman_install soundconverter
pacman_install speedtest-cli
pacman_install sshfs
pacman_install tcpdump
pacman_install vinagre
pacman_install vym
pacman_install w3m
pacman_install wavemon
pacman_install wl-clipboard
# Allow Firefox screensharing on wayland
pacman_install xdg-desktop-portal-wlr
pacman_install xournalpp

pacman_install fuse3
sed -i '/^#user_allow_other/s/^#//' /etc/fuse.conf

pacman_install firefox-nightly

# Namecheap dyndns
pacman_install ddclient

# System76
pacman_install system76-firmware
pacman_install system76-scheduler

# LLMs
pacman_install ollama

pacman_install arch-wiki-docs
pacman_install dhcpcd
pacman_install dhcping
pacman_install dialog
pacman_install docker-compose
pacman_install github-cli
pacman_install glmark2
pacman_install flameshot
pacman_install foliate
pacman_install gnome-nettool
pacman_install gnome-screenshot
pacman_install gnome-themes-extra
pacman_install gnome-usage
pacman_install hyprland
pacman_install inetutils
pacman_install iw
pacman_install jfsutils
pacman_install jpegoptim
pacman_install logrotate
pacman_install mold
pacman_install mousetweaks
pacman_install nano
pacman_install nautilus-sendto
pacman_install neovim luarocks
pacman_install pacman-contrib
pacman_install pinta
pacman_install racket
pacman_install rednotebook
pacman_install reflector
pacman_install reiserfsprogs
pacman_install retext
pacman_install signal-desktop
pacman_install s-nail
pacman_install sox
pacman_install syncthing
pacman_install texlive-meta
pacman_install transmission-cli transmission-gtk
pacman_install typescript
pacman_install usbutils
pacman_install wtype
pacman_install xfsprogs
pacman_install zed

pacman_install erlang
pacman_install geoip
pacman_install llvm
pacman_install lynis
pacman_install mercurial
pacman_install mysql
pacman_install nmap
pacman_install redis
pacman_install sbt
pacman_install smlnj
pacman_install yasm
