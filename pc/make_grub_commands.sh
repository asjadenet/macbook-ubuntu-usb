#!/bin/bash
echo "#first command:" > grub-commands.txt
echo "ls -l" >> grub-commands.txt
echo "#Please check your (hdX,gpt2) match to UUID:" >> grub-commands.txt
uuid=$(blkid -o value -s UUID $(mount | grep "on / type ext4" | awk '{print $1;}'))
echo $uuid >> grub-commands.txt
echo "#Then run:" >> grub-commands.txt
echo "set root=(hdX,gpt2)" >> grub-commands.txt
echo "#You can view you home directory" >> grub-commands.txt
echo "ls /home" >> grub-commands.txt
echo "#And also boot directory:" >> grub-commands.txt
echo "ls /boot" >> grub-commands.txt
echo "#Then run:" >> grub-commands.txt
vmlinuzline=$(ls -r --width=1 /boot/vmlinuz-*-generic | head -n 1) >> grub-commands.txt
echo "linux $vmlinuzline root=UUID=$uuid" >> grub-commands.txt
echo "#After that:" >> grub-commands.txt
initrdline=$(ls -r --width=1 /boot/initrd.img-*-generic | head -n 1) >> grub-commands.txt
echo "initrd $initrdline" >> grub-commands.txt
echo "#And last step for booting:" >> grub-commands.txt
echo "boot" >> grub-commands.txt
if df -P | grep -q "/media/"; then
    usbdisk=$(df -P | grep "/media/" | awk 'NF{ print $NF }')
    mkdir -p "$usbdisk/grub-commands"
    cp grub-commands.txt "$usbdisk/grub-commands/."
    echo "grub-commands.txt is now in your USB disk $usbdisk/grub-commands/:"
    ls -l "$usbdisk/grub-commands/"
else
    echo "USB disk not found. Please copy grub-commands.txt manually into your computer"
fi
echo "Your grub-commands.txt contains:"
cat grub-commands.txt
