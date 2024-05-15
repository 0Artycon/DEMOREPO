#!/bin/bash
for i in $(seq 1 9); do
qm create 1${i}0 --name "ISP" --cores 2 --memory 2048 --ostype l26 --scsi0 tomb:30 --cdrom local:iso/AltLinux-Server.iso --scsihw virtio-scsi-single --net0 virtio,bridge=vmbr0 --net1 virtio,bridge=vmbr1 --net2 virtio,bridge=vmbr2
qm create 1${i}1 --name "HQ-R" --cores 2 --memory 2048 --ostype l26 --scsi0 tomb:30 --cdrom local:iso/AltLinux-Server.iso --scsihw virtio-scsi-single --net0 e1000,bridge=vmbr1 --net1 e1000,bridge=vmbr3
qm create 1${i}2 --name "BR-R" --cores 2 --memory 2048 --ostype l26 --scsi0 tomb:30 --cdrom local:iso/vesr-1.18.9-build3.iso --scsihw virtio-scsi-single --net0 e1000,bridge=vmbr2 --net1 e1000,bridge=vmbr4
qm create 1${i}3 --name "HQ-SRV" --cores 2 --memory 2048 --ostype l26 --scsi0 tomb:30 --cdrom local:iso/AltLinux-Server.iso --scsihw virtio-scsi-single --net0 virtio,bridge=vmbr3
qm create 1${i}4 --name "BR-SRV" --cores 2 --memory 2048 --ostype l26 --scsi0 tomb:30 --cdrom local:iso/AltLinux-Server.iso --scsihw virtio-scsi-single --net0 virtio,bridge=vmbr4
qm create 1${i}5 --name "CLI" --cores 2 --memory 3072 --ostype l26 --scsi0 tomb:30 --cdrom local:iso/alt-workstation-10.1-x86_64.iso --scsihw virtio-scsi-single --net0 virtio,bridge=vmbr0
done
