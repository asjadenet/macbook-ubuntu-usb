#!/bin/bash
partition=$(mount | grep "on / type ext4" | awk '{print $1;}')
#echo $partition
devicename="${partition::-1}"
#echo $devicename
echo "Now we run gdisk for deleting EFI partion"
echo "Please delete manually EFI partion and create again with filesystem type code AF00"
echo "p - print partition table"
echo "d - delete partition table"
echo "n - new partition table"
echo "w - write and exit"
read -n 1 -r -s -p $'Press enter to continue...\n'
sudo gdisk $devicename
echo "Formatting EFI partition to hfsplus filesystem..."
yes | sudo mkfs.hfsplus ${devicename}1 -v Ubuntu
