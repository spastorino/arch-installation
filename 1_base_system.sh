#!/bin/sh

# This is the main Arch Linux basic installation script.
#
# Run this script as root as soon as ArchLinux installation boots.

######################
# Prepare
######################

## Connect to the internet

echo "WiFi network?"
read ssid
echo "WiFi password?"
read -s wifi_passwd
echo
iwctl --passphrase $wifi_passwd station wlan0 connect $ssid

## Update the system clock

timedatectl set-ntp true

## Partition the disks

# Detect and list the drives.
lsblk -f

# Choice the drive to use :
echo "Drive? (for instance /dev/nvme0n1)"
read drive_name

(
echo g       # Create new GPT partition table
echo n       # Create new partition (for EFI).
echo         # Set default partition number.
echo         # Set default first sector.
echo +1G     # Set +1G as last sector.
echo n       # Create new partition (for root).
echo         # Set default partition number.
echo         # Set default first sector.
echo         # Set last sector.
echo t       # Change partition type.
echo 1       # Pick first partition.
echo 1       # Change first partition to EFI system.
echo w       # write changes. 
) | fdisk $drive_name -w always -W always

efi_name=$drive_name
root_name=$drive_name
if [[ "$drive_name" == "/dev/nvme"* || "$drive_name" == "/dev/mmcblk0"* ]]; then
  efi_name+=p1
  root_name+=p2
else
  efi_name+=1
  root_name+=2
fi

## Format the partitions

# Create EFI partition
mkfs.fat -F32 -n EFI $efi_name
# Encrypt the root partition
cryptsetup -v luksFormat $root_name
# Open the encrypted root partition
cryptsetup luksOpen $root_name cryptdata

echo "Swap size (e.g. 8G):"
read swap_size

pvcreate /dev/mapper/cryptdata
vgcreate lvm /dev/mapper/cryptdata
lvcreate -L $swap_size -n swap lvm
lvcreate -l '100%FREE' -n root lvm
cryptsetup config $root_name --label luks

mkswap /dev/lvm/swap
mkfs.ext4 /dev/mapper/lvm-root

# Mount the file systems

mount /dev/mapper/lvm-root /mnt
mount --mkdir $efi_name -o uid=0,gid=0,fmask=0077,dmask=0077 /mnt/boot
swapon /dev/mapper/lvm-swap

######################
# Install
# ####################

# Install essential packages

pacstrap -K /mnt base base-devel linux linux-headers linux-lts linux-lts-headers linux-firmware 
# userspace utilities for file systems
pacstrap /mnt btrfs-progs dosfstools exfatprogs e2fsprogs ntfs-3g udftools
# utilities for accessing and managing LVM
pacstrap /mnt lvm2
# software necessary for networking
pacstrap /mnt iwd
# text editor
pacstrap /mnt vim
# packages for accessing documentation in man and info pages
pacstrap /mnt man-db man-pages

######################
# Configure
# ####################

## Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

## Chroot into new system
arch-chroot /mnt sh 2_setup.sh $root_name
