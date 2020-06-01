#!/bin/bash
if mount | grep -q "/boot/efi type hfsplus"; then
    echo "EFI partition is hfsplus type and mounted, lets modify it.."
    sudo mkdir -p "/boot/efi/EFI/$(lsb_release -ds)/"

    echo "Creating required file for booting..."
    sudo bash -c 'echo "This file is required for booting" > "/boot/efi/EFI/$(lsb_release -ds)/mach_kernel"'
    sudo bash -c 'echo "This file is required for booting" > /boot/efi/mach_kernel'

    echo "Installing GRUB..."
    sudo grub-install --target x86_64-efi --boot-directory=/boot --efi-directory=/boot/efi --bootloader-id="$(lsb_release -ds)"

    echo "Blessing bootloader code..."
    sudo hfs-bless "/boot/efi/EFI/$(lsb_release -ds)/System/Library/CoreServices/boot.efi"

    echo "The final step is to create the grub configuration..."
    sudo sed -i 's/GRUB_HIDDEN/#GRUB_HIDDEN/g' /etc/default/grub
    sudo sed -i 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=0.1/' /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg

    echo "Adding the Ubuntu icon..."
    sudo cp /usr/share/mactel-boot-logo/ubuntu.icns /boot/efi/.VolumeIcon.icns

    echo "Done. Press any key to continue to system power off"
    echo "Please remove Ubuntu installer USB disk before switching on."
    echo "Press and hold the option/alt key for booting to Ubuntu"
    read -n1 -r
    sudo poweroff
else
    echo "EFI is unmounted, exiting"
fi
