#!/bin/bash
cat ./ProxmoxInterfaces.txt >> /etc/network/interfaces;
for i in $(seq 1 9); do
mkdir /etc/net/ifaces/vmbr$i ; cp ./vmbropt.txt /etc/net/ifaces/vmbr$i/options
done
systemctl restart network;
apt-get install python3-pip python3-venv -y;
python3 -m venv myenv;
source myenv/bin/activate;
pip3 install wldhx.yadisk-direct;
read -p "Enter the local storage name: " STORAGE
curl -L $(yadisk-direct https://disk.yandex.ru/d/fKkyVaUGrU9ZZA) -o ISP-disk001.vmdk
qm create 100 --name "ISP" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr0 --net1 virtio,bridge=vmbr1 --net2 virtio,bridge=vmbr2
qm importdisk 100 ISP-disk001.vmdk $STORAGE --format qcow2 
qm set 100 -ide0 $STORAGE:100/vm-100-disk-0.qcow2 --boot order=ide0
echo "ISP is done!!!"
curl -L $(yadisk-direct https://disk.yandex.ru/d/RTO6rzQCgoi_2w) -o HQ-R-disk001.vmdk
qm create 101 --name "HQ-R" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single --net0 e1000,bridge=vmbr1 --net1 e1000,bridge=vmbr3 
qm importdisk 101 HQ-R-disk001.vmdk $STORAGE --format qcow2 
qm set 101 -ide0 $STORAGE:101/vm-101-disk-0.qcow2 --boot order=ide0
echo "HQ-R is done!!!"
curl -L $(yadisk-direct https://disk.yandex.ru/d/arhOlptNl4fIQg) -o BR-R-disk001.vmdk
qm create 102 --name "BR-R" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 e1000,bridge=vmbr2 --net1 e1000,bridge=vmbr4
qm importdisk 102 BR-R-disk001.vmdk $STORAGE --format qcow2 
qm set 102 -ide0 $STORAGE:102/vm-102-disk-0.qcow2 --boot order=ide0
echo "BR-R is done!!!"
curl -L $(yadisk-direct https://disk.yandex.ru/d/D7U1KJVEOIoibQ) -o HQ-SRV-disk001.vmdk
qm create 103 --name "HQ-SRV" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr3
qm importdisk 103 HQ-SRV-disk001.vmdk $STORAGE --format qcow2 
qm set 103 -ide0 $STORAGE:103/vm-103-disk-0.qcow2 --boot order=ide0
echo "HQ-SRV is done!!!"
curl -L $(yadisk-direct https://disk.yandex.ru/d/looDS7d-rTbfcA) -o BR-SRV-disk001.vmdk
qm create 104 --name "BR-SRV" --cores 2 --memory 2048 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr4
qm importdisk 104 BR-SRV-disk001.vmdk $STORAGE --format qcow2 
qm set 104 -ide0 $STORAGE:104/vm-104-disk-0.qcow2 --boot order=ide0
echo "BR-SRV is done!!!"
curl -L $(yadisk-direct https://disk.yandex.ru/d/--CnGh-_AI5YqQ) -o CLI-disk001.vmdk
qm create 105 --name "CLI" --cores 2 --memory 4096 --ostype l26 --scsihw virtio-scsi-single  --net0 virtio,bridge=vmbr0
qm importdisk 105 CLI-disk001.vmdk $STORAGE --format qcow2
qm set 105 -ide0 $STORAGE:105/vm-105-disk-0.qcow2 --boot order=ide0
echo "CLI is done!!!"
echo "ALL DONE!!!"
