#!/bin/bash
qm create 100 --name "ISP" --cores 2 --memory 2048 --ostype l26 --scsi0 tomb:30  --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr0 --net1 virtio,bridge=vmbr1 --net2 virtio,bridge=vmbr2
qm create 101 --name "HQ-R" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single --net0 e1000,bridge=vmbr1 --net1 e1000,bridge=vmbr3 
qm importdisk 101 HQ-R-disk001.vmdk $STORAGE --format qcow2 
qm set 101 -ide0 $STORAGE:101/vm-101-disk-0.qcow2 --boot order=ide0
qm create 102 --name "BR-R" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 e1000,bridge=vmbr2 --net1 e1000,bridge=vmbr4
qm importdisk 102 BR-R-disk001.vmdk $STORAGE --format qcow2 
qm set 102 -ide0 $STORAGE:102/vm-102-disk-0.qcow2 --boot order=ide0
qm create 103 --name "HQ-SRV" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr3
qm importdisk 103 HQ-SRV-disk001.vmdk $STORAGE --format qcow2 
qm set 103 -ide0 $STORAGE:103/vm-103-disk-0.qcow2 --boot order=ide0
qm create 104 --name "BR-SRV" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr4
qm importdisk 104 BR-SRV-disk001.vmdk $STORAGE --format qcow2 
qm set 104 -ide0 $STORAGE:104/vm-104-disk-0.qcow2 --boot order=ide0
qm create 105 --name "CLI" --cores 2 --memory 4096 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr0
qm importdisk 105 CLI-disk001.vmdk $STORAGE --format qcow2
qm set 105 -ide0 $STORAGE:105/vm-105-disk-0.qcow2 --boot order=ide0
