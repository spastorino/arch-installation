#!/bin/sh

echo -n "WiFi password:"
read -s WIFI_PASS
echo

# Wi-Fi
nmcli device wifi connect pascas password '$WIFI_PASS'

cat <<EOT > ~/.config/gtk-3.0/settings.ini
[Settings]
gtk-enable-primary-paste=true
EOT

# Bluetooth
pacman -S bluez bluez-utils bluez-tools
systemctl enable bluetooth.service
systemctl start bluetooth.service

# Configure bluetooth mouse
echo -e "pair EC:66:BD:17:10:8D\nconnect EC:66:BD:17:10:8D\n" | bluetoothctl
# Configure bluetooth keyboard
# This won't work because pin is needed after pairing. Insert pin + enter on bluetooth keyboard
echo -e "pair 34:88:5D:72:98:71\nconnect 34:88:5D:72:98:71\n" | bluetoothctl

# FIXME: automate this
# Run pavucontrol
# Mute mic from camera
# Mute regular mic
# Set blue mic as fallback
#pavucontrol

# Screencasts
pacman -S obs-studio

## Check
#https://linuxconfig.org/how-to-install-gnome-shell-extensions-from-zip-file-using-command-line-on-ubuntu-18-04-bionic-beaver-linux

# Copy backup files
cp $BACKUP/monitors.xml ~santiago/.config/
cp -a $BACKUP/.mozilla ~santiago
cp -a .profile ~/
cp -a .bashrc ~/
cp -a .config/keybase ~/
cp -a .git ~/
cp -a .gitconfig ~/
cp -a .gitignore ~/
cp -a .gnupg ~/
cp -a .ssh ~/
cp -a .tmux* ~/
~/.tmux/plugins/tpm/bin/install_plugins
cp -a .vim* ~/
cp -a .wallpapers ~/

# Install gnome extensions

# Download ...
# autoselectheadset@josephlbarnett.github.com
# Decompress to ~/.local/share/gnome-shell/extensions/autoselectheadset@josephlbarnett.github.com

# Gsettings

gsettings set org.gtk.Settings.FileChooser show-hidden true
gsettings set org.gnome.desktop.background color-shading-type 'solid'
gsettings set org.gnome.desktop.background picture-options 'zoom'
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/System76-Robot-by_Kate_Hazen_of_System76.png'
gsettings set org.gnome.desktop.background primary-color '#000000'
gsettings set org.gnome.desktop.background secondary-color '#000000'
gsettings set org.gnome.desktop.screensaver color-shading-type 'solid'
gsettings set org.gnome.desktop.screensaver picture-options 'zoom'
gsettings set org.gnome.desktop.screensaver picture-uri 'file:///usr/share/backgrounds/System76-Robot-by_Kate_Hazen_of_System76.png'
gsettings set org.gnome.desktop.screensaver primary-color '#000000'
gsettings set org.gnome.desktop.screensaver secondary-color '#000000'
gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'firefox-developer-edition.desktop', 'firefox-nightly.desktop', 'chromium.desktop', 'torbrowser.desktop', 'beersmith3.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Nautilus.desktop']"
gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing 'rgba'

gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"

# Nautilus
gsettings set org.gtk.Settings.FileChooser sort-directories-first true
gsettings set org.gnome.nautilus.list-view use-tree-view true
gsettings set org.gnome.nautilus.list-view default-visible-columns "['name', 'size', 'type', 'date_modified']"
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
gsettings set org.gnome.nautilus.preferences default-sort-order type

# GWeather
gsettings set org.gnome.GWeather temperature-unit 'centigrade'

# World clock
gsettings set org.gnome.clocks world-clocks "[{'location': <(uint32 2, <('Portland', 'KPDX', true, [(0.79571014457688405, -2.1397785149603687)], [(0.7945341242735976, -2.1411037260081156)])>)>}, {'location': <(uint32 2, <('Boston', 'KBOS', true, [(0.73933117517543911, -1.2393680058718144)], [(0.73929408692883414, -1.2402270045697685)])>)>}, {'location': <(uint32 2, <('Berlin', 'EDDT', true, [(0.91746141594945008, 0.23241968454167572)], [(0.91658875132345297, 0.23387411976724018)])>)>}]"
gsettings set org.gnome.Weather locations "[<(uint32 2, <('Montevideo', 'SUAA', true, [(-0.60708368566759674, -0.98174770424681035)], [(-0.60838784804456447, -0.98036597943788406)])>)>]"

gsettings set org.gnome.shell enabled-extensions "['system76-power@system76.com', 'permanent-notifications@bonzini.gnu.org']"
gsettings set org.gnome.desktop.interface clock-show-weekday true
xdg-settings set default-web-browser firefox.desktop

gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true
gsettings set org.gnome.desktop.peripherals.mouse speed 1.0
gsettings set org.gnome.desktop.peripherals.touchpad speed 1.0
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.media-handling autorun-x-content-start-app "@as []"
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+altgr-intl')]"
gsettings set org.gnome.desktop.privacy remember-recent-files false
gsettings set org.gnome.desktop.session idle-delay "uint32 0"
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'

# date time automatic
gsettings set org.gnome.desktop.interface clock-format '12h'
gsettings set org.gtk.Settings.FileChooser clock-format '12h'

# set profile picture
gsettings set org.gnome.desktop.sound event-sounds false

# block blue light at night
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 1000

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

gsettings set org.gnome.deja-dup.include-list "['/home/santiago', '/etc']"
gsettings set org.gnome.deja-dup.exclude-list ['/home/santiago/.local/share/Trash', '/home/santiago/.ccache']
gsettings set org.gnome.deja-dup.local.folder '/mnt/backup/Backup/Galago'
gsettings set org.gnome.deja-dup.delete-after 365

# Xorg HIDPI & LoDPI settings
# LoDPI on left
#xrandr --output DP-1 --mode 3840x2160 --primary --output eDP-1 --mode 1920x1080 --scale 2x2 --pos -3840x0 --panning 3840x2160
# LoDPI on left
#xrandr --output DP-1 --mode 3840x2160 --primary --output eDP-1 --mode 1920x1080 --scale 2x2 --right-of DP-1 --panning 3840x2160+3840+0
