#!/bin/bash
echo "Installing missing packages..."
./pc/install_missing_packages.sh
echo "Recreating EFI partition..."
./pc/recreate_efi.sh
echo "Preparing fstab for EFI..."
./pc/prep_fstab.sh
echo "Making GRUB commands file..."
./pc/make_grub_commands.sh
