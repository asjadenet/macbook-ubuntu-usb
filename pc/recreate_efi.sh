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
echo "Press any key to continue..."
read -n1 -r
sudo gdisk $devicename
echo "Formatting EFI partition to hfsplus filesystem..."
sudo mkfs.hfsplus ${devicename}1 -v Ubuntu
sudo blkid ${devicename}1 
