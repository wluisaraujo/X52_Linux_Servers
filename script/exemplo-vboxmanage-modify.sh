#!/bin/bash

## remove all host only interfaces
#for vnic in $(vboxmanage list hostonlyifs | grep ^Name | awk '{ print $2}') 
#  do 
#    vboxmanage hostonlyif remove $vnic
#  done

GUEST=frontend.exemplo.com.br
vboxmanage controlvm $GUEST poweroff
vboxmanage modifyvm $GUEST --nic1 nat
frontend$ vboxmanage modifyvm frontend.exemplo.com.br --nic2 hostonly --hostonlyadapter1 vboxnet0
frontend$ vboxmanage modifyvm frontend.exemplo.com.br --nic3 hostonly --hostonlyadapter2 vboxnet1


vboxmanage startvm $GUEST --typ e headless



## create vbox host only nic vbox0
vboxmanage hostonlyif create
vboxmanage hostonlyif ipconfig vboxnet0 \
--ip 200.100.50.254 --netmask 255.255.255.0

## configure vboxnet0 address 200.100.50.99
vboxmanage dhcpserver modify --ifname vboxnet0 --enable \
--ip 200.100.50.254 --netmask 255.255.255.0 --lowerip 200.100.50.240 --upperip 200.100.50.253

## create vbox host only nic vbox1
vboxmanage hostonlyif create
vboxmanage hostonlyif ipconfig vboxnet1 \
--ip 172.16.100.254 --netmask 255.255.255.0 

## configure vboxnet1 address
vboxmanage dhcpserver modify --ifname vboxnet1 --enable \
--ip 172.16.100.254 --netmask 255.255.255.0 --lowerip 172.16.100.240 --upperip 172.16.100.253
