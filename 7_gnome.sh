#!/bin/sh

# Turn wifi on
nmcli r wifi on

# Set Brightness level
dbus-send --session --type=method_call --dest="org.gnome.SettingsDaemon.Power" /org/gnome/SettingsDaemon/Power org.freedesktop.DBus.Properties.Set string:"org.gnome.SettingsDaemon.Power.Screen" string:"Brightness" variant:int32:60

# Configure bluetooth mouse
echo -e "pair F4:5C:A4:56:86:3A\nconnect F4:5C:A4:56:86:3A\n" | bluetoothctl
# Configure bluetooth keyboard
# This won't work because pin is needed after pairing. Insert pin + enter on bluetooth keyboard
echo -e "pair D6:00:4F:83:6B:B0\nconnect D6:00:4F:83:6B:B0\n" | bluetoothctl

# Set volume from internal speakers
# Mute mic from internal microphone
DEFAULT_SINK=$(pactl info | grep "Default Sink" | cut -d " " -f3)
DEFAULT_SOURCE=$(pactl info | grep "Default Source" | cut -d " " -f3)
pactl set-sink-volume $DEFAULT_SINK 80%
pactl set-source-mute $DEFAULT_SOURCE 1

## Check
#https://linuxconfig.org/how-to-install-gnome-shell-extensions-from-zip-file-using-command-line-on-ubuntu-18-04-bionic-beaver-linux

# Install gnome extensions

# Download ...
# autoselectheadset@josephlbarnett.github.com
# Decompress to ~/.local/share/gnome-shell/extensions/autoselectheadset@josephlbarnett.github.com

# Gsettings

gsettings set org.gtk.Settings.FileChooser show-hidden true
gsettings set org.gtk.Settings.FileChooser sort-directories-first true
gsettings set org.gtk.gtk4.Settings.FileChooser show-hidden true
gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true
gsettings set org.gnome.desktop.background color-shading-type 'solid'
gsettings set org.gnome.desktop.background picture-options 'zoom'
gsettings set org.gnome.desktop.background picture-uri 'file:///home/santiago/.local/share/backgrounds/RustConf-2020-Desktop-Background.png'
gsettings set org.gnome.desktop.background primary-color '#000000'
gsettings set org.gnome.desktop.background secondary-color '#000000'
gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
gsettings set org.gnome.desktop.screensaver color-shading-type 'solid'
gsettings set org.gnome.desktop.screensaver picture-options 'zoom'
gsettings set org.gnome.desktop.screensaver picture-uri 'file:///home/santiago/.local/share/backgrounds/RustConf-2020-Desktop-Background.png'
gsettings set org.gnome.desktop.screensaver primary-color '#000000'
gsettings set org.gnome.desktop.screensaver secondary-color '#000000'
gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'firefox-nightly.desktop', 'Zoom.desktop', 'Alacritty.desktop', 'org.gnome.Nautilus.desktop']"

# Nautilus
gsettings set org.gnome.nautilus.list-view use-tree-view true
gsettings set org.gnome.nautilus.list-view default-visible-columns "['name', 'size', 'type', 'date_modified']"
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
gsettings set org.gnome.nautilus.preferences show-hidden-files true
gsettings set org.gnome.nautilus.preferences default-sort-order name

# GWeather
gsettings set org.gnome.GWeather4 temperature-unit 'centigrade'

# World clock
gsettings set org.gnome.clocks world-clocks "[{'location': <(uint32 2, <('Portland', 'KPDX', true, [(0.79571014457688405, -2.1397785149603687)], [(0.7945341242735976, -2.1411037260081156)])>)>}, {'location': <(uint32 2, <('Boston', 'KBOS', true, [(0.73933117517543911, -1.2393680058718144)], [(0.73929408692883414, -1.2402270045697685)])>)>}, {'location': <(uint32 2, <('Berlin', 'EDDT', true, [(0.91746141594945008, 0.23241968454167572)], [(0.91658875132345297, 0.23387411976724018)])>)>}]"
gsettings set org.gnome.Weather locations "[<(uint32 2, <('Montevideo', 'SUAA', true, [(-0.60708368566759674, -0.98174770424681035)], [(-0.60838784804456447, -0.98036597943788406)])>)>]"

# TODO
gsettings set org.gnome.shell enabled-extensions "['system76-power@system76.com', 'permanent-notifications@bonzini.gnu.org']"
gsettings set org.gnome.desktop.interface clock-show-weekday true
xdg-settings set default-web-browser firefox.desktop

gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true
gsettings set org.gnome.desktop.peripherals.mouse speed 1.0
gsettings set org.gnome.desktop.peripherals.touchpad speed 1.0
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.media-handling autorun-x-content-start-app "@as []"
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+altgr-intl')]"
gsettings set org.gnome.desktop.interface enable-hot-corners false
gsettings set org.gnome.desktop.privacy remember-recent-files false
gsettings set org.gnome.desktop.session idle-delay "uint32 0"
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'

# date time automatic
timedatectl set-ntp true
gsettings set org.gnome.desktop.interface clock-format '12h'
gsettings set org.gtk.Settings.FileChooser clock-format '12h'
gsettings set org.gtk.gtk4.Settings.FileChooser clock-format '12h'

# set profile picture
gsettings set org.gnome.desktop.sound event-sounds false

# block blue light at night
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 1000
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 20.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 9.0

# Terminal
gsettings set org.gnome.Terminal.Legacy.Settings new-terminal-mode 'tab'
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'dark'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ visible-name 'Default'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ audible-bell false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:7b36f4ff-f268-4f3b-b621-9f5ad9b64a23/ visible-name 'Projector'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:7b36f4ff-f268-4f3b-b621-9f5ad9b64a23/ audible-bell false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:7b36f4ff-f268-4f3b-b621-9f5ad9b64a23/ use-system-font false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:7b36f4ff-f268-4f3b-b621-9f5ad9b64a23/ font 'Monospace 22'

# Deja Dup
gsettings set org.gnome.DejaDup backend 'remote'
gsettings set org.gnome.DejaDup delete-after 365
gsettings set org.gnome.DejaDup exclude-list ['/home/santiago/VirtualBox VMs', '/home/santiago/src/oss/rust1/build', '/home/santiago/src/oss/rust2/build', '/home/santiago/src/oss/rust3/build', '/home/santiago/src/oss/rust4/build']
gsettings set org.gnome.DejaDup include-list ['/home/santiago', '/etc']
gsettings set org.gnome.DejaDup periodic-period 1
gsettings set org.gnome.DejaDup.Remote folder '/mnt/backup/Backups/galp7'
gsettings set org.gnome.DejaDup.Remote uri 'ssh://meerkat'

systemctl start --user gcr-ssh-agent.socket
