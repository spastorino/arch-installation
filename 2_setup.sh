#!/bin/sh

root_name = $1

## Configure time
ln -sf /usr/share/zoneinfo/America/Montevideo /etc/localtime
# Generate '/etc/adjtime'.
hwclock --systohc

## Localization
sed -i '/^#en_US.UTF-8/s/^#//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

## Network

# 1. Create the hostname file.
echo "Hostname?"
read hostname
echo $hostname > /etc/hostname

# 2. Add matching entries to '/etc/hosts'.
# If the system has a permanent IP address, it should be used instead of 127.0.1.1. 
echo -e 127.0.0.1'\t'localhost >> /etc/hosts
echo -e ::1'\t\t'localhost >> /etc/hosts
echo -e 127.0.1.1'\t'$hostname.localdomain'\t'$hostname >> /etc/hosts

## Initramfs
sed -i 's/HOOKS=(base udev autodetect modconf kms keyboard keymap consolefont block filesystems fsck)/HOOKS=(base udev autodetect modconf kms keyboard keymap consolefont block encrypt lvm2 filesystems fsck)/g' /etc/mkinitcpio.conf
mkinitcpio -P

## Sysctl settings
# Disable coredumps
echo "kernel.core_pattern=|/bin/false" > /etc/sysctl.d/50-coredump.conf
# Enable magic SysRq key
echo "kernel.sysrq=1" > /etc/sysctl.d/99-sysctl.conf

## Root password and new user
passwd

# Create user
echo "New username?"
read user_name
useradd -m -G users,wheel,adm -s /bin/bash $user_name
passwd $user_name

## Boot loader
# Install intel micro code
pacman -S intel-ucode iucode-tool --noconfirm

# Install EFI boot manager
pacman -S efibootmgr --noconfirm

echo "bootmgr entries to remove? (0 means do not remove anything)"
read entries

if [ $entries > 0 ]; then
  # Remove bootmanager entries
  for i in $(seq 0 $(($entries -1))); do
    efibootmgr -B -b 000$i
  done
fi

# Install systemd-boot bootloader
bootctl install

# Generate boot entries
echo 'title Arch Linux' > /boot/loader/entries/arch.conf
echo 'linux /vmlinuz-linux' >> /boot/loader/entries/arch.conf
echo 'initrd /intel-ucode.img' >> /boot/loader/entries/arch.conf
echo 'initrd /initramfs-linux.img' >> /boot/loader/entries/arch.conf
echo "options cryptdevice=$root_name:cryptdata root=/dev/mapper/lvm-root rw" >> /boot/loader/entries/arch.conf

echo 'title Arch Linux LTS' > /boot/loader/entries/arch-lts.conf
echo 'linux /vmlinuz-linux-lts' >> /boot/loader/entries/arch-lts.conf
echo 'initrd /intel-ucode.img' >> /boot/loader/entries/arch-lts.conf
echo 'initrd /initramfs-linux-lts.img' >> /boot/loader/entries/arch-lts.conf
echo "options cryptdevice=$root_name:cryptdata root=/dev/mapper/lvm-root rw" >> /boot/loader/entries/arch-lts.conf

echo "default arch" >> /boot/loader/loader.conf

## Reboot

echo "Run the following commands:"
echo "umount -R /mnt"
echo "reboot"

# Exit chroot
exit
