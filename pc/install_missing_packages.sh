#!/bin/bash
wget https://launchpad.net/~detly/+archive/ubuntu/mactel-utils/+files/mactel-boot_0.9-1~xenial_amd64.deb
sudo dpkg -i mactel-boot_0.9-1~xenial_amd64.deb
if [ ! -f /usr/sbin/hfs-bless ]; then
    echo "hfs-bless not present! Cannot continue"
    exit 1
fi
wget https://launchpad.net/~detly/+archive/ubuntu/mactel-utils/+files/mactel-boot-logo_1.0-1~xenial_all.deb
sudo dpkg -i mactel-boot-logo_1.0-1~xenial_all.deb
if [ ! -f /usr/share/mactel-boot-logo/ubuntu.icns ]; then
    echo "Ubuntu icon not present! Cannot continue"
    exit 1
fi
sudo apt-get update
sudo apt-get install hfsprogs gdisk grub-efi-amd64
