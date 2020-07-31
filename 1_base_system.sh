#!/bin/sh

# This is the main OS basic installation script.
#
# Run this script as root as soon as ArchLinux installation boots.
#
# FIXME: Most of the things like wifi, disks, etc are hardcoded for my System76 Galago Pro laptop.
# In any case, feel free to use this script as a guide to setup your computer.

# Configure Wi-Fi
echo -n "WiFi network: "
read ESSID
echo -n "WiFi password:"
read -s WIFI_PASS
echo

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

# Enable network time synchronization
timedatectl set-ntp true

echo "Swap size (e.g. 8GiB):"
read SWAP_SIZE
# Partition and format disk
cat <<EOT | parted -a optimal ---pretend-input-tty /dev/nvme0n1
	mklabel gpt
        yes
	mkpart ESP fat32 1MiB 513MiB
	set 1 boot on
	mkpart primary ext4 513MiB 100%
	resizepart 2 -$SWAP_SIZE
        yes
	mkpart primary linux-swap -$SWAP_SIZE 100%
	quit
EOT
mkfs.fat -F32 /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p2
mkswap /dev/nvme0n1p3
swapon /dev/nvme0n1p3

# Mount root and boot
mount /dev/nvme0n1p2 /mnt
mkdir -p /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot

# Install base and base-devel
pacstrap /mnt base base-devel

# Generate fstab
genfstab -U /mnt > /mnt/etc/fstab

# Chroot into new system
arch-chroot /mnt

# Configure timezone
ln -sf /usr/share/zoneinfo/America/Montevideo /etc/localtime
hwclock --systohc

# Generate en_US.UTF-8 locales
sed -i '/^#en_US.UTF-8/s/^#//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Configure hostname
echo "archlinux" > /etc/hostname
cat <<EOT >> /etc/hosts
127.0.0.1	localhost
::1		localhost
127.0.1.1	archlinux.localdomain	archlinux
EOT

# Set root password
passwd

# Install intel micro code
pacman -S intel-ucode
pacman -S iucode-tool

# Install systemd-boot EFI boot manager
bootctl install

# Generate boot entries
cat <<EOT > /boot/loader/entries/arch.conf
title	Arch Linux
linux	/vmlinuz-linux
initrd	/intel-ucode.img
initrd	/initramfs-linux.img
options	root=/dev/nvme0n1p2 rw ec_sys.write_support=1
EOT
echo "default arch" > /boot/loader/loader.conf

# Install wifi packages
pacman -S iw wpa_supplicant crda

# Exit chroot
exit

# Umount all mounted filesystems
umount -R /mnt

# Reboot
reboot
