#!/usr/bin/env bash
 
qemu-system-x86_64 -bios OVMF.fd -drive file=disk.img,if=ide 
