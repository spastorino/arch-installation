#!/bin/sh

mkdir -p ~/src/aur
pushd ~/src/aur

git clone https://aur.archlinux.org/beersmith.git
pushd beersmith
makepkg -sir
git clean -xdf
popd

git clone https://aur.archlinux.org/brother-hll2350dw.git
pushd brother-hll2350dw
makepkg -sir
git clean -xdf
popd

lpadmin -p Brother -D "Brother HL-L2350DW series" -E -v "usb://Brother/HL-L2350DW%20series?serial=U64964D8N396813" -m brother-HLL2350DW-cups-en.ppd
lpoptions -d Brother
lpoptions -p Brother -o PageSize=A4

git clone https://aur.archlinux.org/dymo-cups-drivers.git
pushd dymo-cups-drivers
makepkg -sir
git clean -xdf
popd

lpadmin -p DYMO -D "DYMO LabelWriter 450 Turbo" -E -v "usb://DYMO/LabelWriter%20450%20Turbo?serial=16071714230436" -m lw450t.ppd

git clone https://aur.archlinux.org/emsdk.git
pushd emsdk
makepkg -sir
git clean -xdf
popd

git clone https://aur.archlinux.org/flamegraph.git
pushd flamegraph
makepkg -sir
git clean -xdf
popd

git clone https://aur.archlinux.org/git-imerge-git.git
pushd git-imerge-git
makepkg -sir
git clean -xdf
popd

git clone https://aur.archlinux.org/gnome-shell-extension-system76-power-git.git
pushd gnome-shell-extension-system76-power-git
makepkg -sir
git clean -xdf
popd

git clone https://aur.archlinux.org/green-recorder.git
pushd green-recorder
makepkg -sir
git clean -xdf
popd

# Dependencies of hotspot
git clone https://aur.archlinux.org/rustc-demangle.git
pushd rustc-demangle
makepkg -sir
git clean -xdf
popd
git clone https://aur.archlinux.org/kddockwidgets.git
pushd kddockwidgets
makepkg -sir
git clean -xdf
popd

git clone https://aur.archlinux.org/hotspot.git
pushd hotspot
makepkg -sir
git clean -xdf
popd

git clone https://aur.archlinux.org/servo-latest.git
pushd servo-latest
makepkg -sir
git clean -xdf
popd

git clone https://aur.archlinux.org/spotify.git
pushd spotify
makepkg -sir
git clean -xdf
popd

git clone https://aur.archlinux.org/stremio.git
pushd stremio
makepkg -sir
git clean -xdf
popd

git clone https://aur.archlinux.org/teams.git
pushd teams
makepkg -sir
git clean -xdf
popd

git clone https://aur.archlinux.org/virtualbox-ext-oracle.git
pushd virtualbox-ext-oracle
makepkg -sir
git clean -xdf
popd

git clone https://aur.archlinux.org/zoom.git
pushd zoom
makepkg -sir
git clean -xdf
popd

git clone https://aur.archlinux.org/system76-dkms-git.git
pushd system76-dkms-git
makepkg -sir
git clean -xdf
popd

git clone https://aur.archlinux.org/system76-acpi-dkms.git
pushd system76-acpi-dkms
makepkg -sir
git clean -xdf
popd

git clone https://aur.archlinux.org/system76-driver.git
pushd system76-driver
makepkg -sir
systemctl enable system76.service
systemctl start system76.service
git clean -xdf
popd

git clone https://aur.archlinux.org/system76-power.git
pushd system76-power
makepkg -sir
systemctl enable com.system76.PowerDaemon.service
systemctl start com.system76.PowerDaemon.service
git clean -xdf
popd

git clone https://aur.archlinux.org/system76-wallpapers.git
pushd system76-wallpapers
makepkg -sir
git clean -xdf
popd

popd
