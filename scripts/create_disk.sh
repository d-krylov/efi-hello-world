#!/usr/bin/env bash


echo "Creating disk.img..."
dd if=/dev/zero of=disk.img bs=512 count=93750 

echo "Creating GPT..."

(echo n; echo 1; echo 2048; echo 93716; echo ef00; echo w; echo y;) | gdisk disk.img

losetup --offset 1048576 --sizelimit 46934528 /dev/loop0 disk.img 

mkdosfs -F 32 /dev/loop0

mkdir   mntdir
mount   /dev/loop0 mntdir/

mkdir   -p mntdir/EFI/BOOT 


echo    "Copy EFI files on disk..."
cp      hello.efi mntdir/EFI/BOOT/bootx64.efi

umount  mntdir/
losetup -d /dev/loop0

rm mntdir -rf 
