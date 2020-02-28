#!/bin/bash

cd $HOME && mkdir -pv "$HOME/VirtualBox VMs/752/Storage"

if [ -d "$HOME/VirtualBox VMs/752/Storage" ]
  then
#printf "Diretorio existe\n"
    for D in $(seq 10 15)
      do
        cd "$HOME/VirtualBox VMs/752/Storage"
        vboxmanage createmedium disk --filename "$HOME/VirtualBox VMs/752/Storage/Disk${D}.vdi" \
        --size 5120 --format VDI --variant Standard
        vboxmanage storageattach "Storage" --storagectl "SATA Controller" \
        --port ${D} --type hdd --medium "$HOME/VirtualBox VMs/752/Storage/Disk${D}.vdi"
    done
  else
    printf "VM não encontrada\n" && exit 1
fi
