#!/bin/bash
qm create 100 --name "ISP" --cores 2 --memory 2048 --ostype l26 --scsi0 tomb:30  --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr0 --net1 virtio,bridge=vmbr1 --net2 virtio,bridge=vmbr2
