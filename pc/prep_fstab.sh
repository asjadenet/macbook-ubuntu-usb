#!/bin/bash
sudo sed -i '/\/boot\/efi/d' /etc/fstab

if mount | grep -q "/boot/efi"; then
    efipartition=$(mount | grep "/boot/efi" | awk '{print $1;}')
    echo "efi partition /boot/efi  device is $efipartition, trying to unmount.."
    sudo umount $efipartition
fi
partition=$(mount | grep "on / type ext4" | awk '{print $1;}')
devicename="${partition::-1}"
#echo "devicename $devicename"
efidevice="${devicename}1"
#echo "efidevice $efidevice"
uuid=$(blkid -o value -s UUID $efidevice)
sudo bash -c "echo UUID=$uuid /boot/efi auto defaults 0 0 >> /etc/fstab"
echo "Your /etc/fstab is prepared for booting from macbook GRUB"
