#!/bin/env bash
export CURSO="752"
printf  "Remove all vms \n"

vboxmanage list vms | awk '{ print $1}' | sed s/\"//g > /tmp/vms.old

if [ -f /tmp/vms.old ]
  then
    for OLD in $(cat /tmp/vms.old)
      do
        vboxmanage unregistervm $OLD --delete
      done
#------------------------------------------------------------------------------#
    printf  "Remove all host only interfaces \n"

    for vnic in $(vboxmanage list hostonlyifs | grep ^Name | awk '{ print $2}')
      do
        vboxmanage hostonlyif remove $vnic
      done
  else
    printf "VM's não encontradas \n" && exit 1
fi
#------------------------------------------------------------------------------#
printf "create vbox host only nic vbox0 \n"

vboxmanage hostonlyif create && vboxmanage hostonlyif ipconfig vboxnet0 \
--ip 200.100.50.254 --netmask 255.255.255.0
#------------------------------------------------------------------------------#
printf "configure address vboxnet0 \n"

vboxmanage dhcpserver modify --ifname vboxnet0 --enable \
--ip 200.100.50.254 --netmask 255.255.255.0 \
--lowerip 200.100.50.240 --upperip 200.100.50.253
#------------------------------------------------------------------------------#
printf "create vbox host only nic vbox1 \n"

vboxmanage hostonlyif create && vboxmanage hostonlyif ipconfig vboxnet1 \
--ip 172.16.100.254 --netmask 255.255.255.0
#------------------------------------------------------------------------------#
printf "configure address vboxnet1  \n"

vboxmanage dhcpserver modify --ifname vboxnet1 --enable \
--ip 172.16.100.254 --netmask 255.255.255.0 \
--lowerip 172.16.100.240 --upperip 172.16.100.253
#------------------------------------------------------------------------------#

if [ -d /home/repositorio/FREQUENTES/${CURSO} ]
  then
    for OVA in $(ls -1 /home/repositorio/FREQUENTES/${CURSO}/*${CURSO}*.ova)
	    do
		    echo " Importing appliance ${OVA}"
	      vboxmanage import $OVA
	    done
    printf "create vbox host only nic vbox0 \n"
		vboxmanage hostonlyif create && vboxmanage hostonlyif ipconfig vboxnet0 \
    --ip 200.100.50.254 --netmask 255.255.255.0
		vboxmanage dhcpserver modify --ifname vboxnet0 --enable
		vboxmanage dhcpserver modify --ifname vboxnet0 --enable --ip 200.100.50.254 \
    --netmask 255.255.255.0 --lowerip 200.100.50.240 --upperip 200.100.50.253
#------------------------------------------------------------------------------#
    printf "create vbox host only nic vbox1 \n"

    vboxmanage hostonlyif create && vboxmanage hostonlyif ipconfig vboxnet1 \
    --ip 172.16.100.254 --netmask 255.255.255.0
		vboxmanage dhcpserver modify --ifname vboxnet1 --enable
		vboxmanage dhcpserver modify --ifname vboxnet1 --enable --ip 172.16.100.254 \
    --netmask 255.255.255.0 --lowerip 172.16.100.240 --upperip 172.16.100.253
#------------------------------------------------------------------------------#
    printf "Adjusting CPU/Memory \n"

    for VM in $(vboxmanage list vms | awk '{ print $1}' | sed s/\"//g )
      do
        vboxmanage modifyvm ${VM} --memory 512
        vboxmanage modifyvm ${VM} --pae on
        vboxmanage modifyvm ${VM} --cpus 2
        vboxmanage modifyvm ${VM} --groups "/${CURSO}"
	    done
#------------------------------------------------------------------------------#
    printf "Adjusting NIC to host Security \n"

    vboxmanage modifyvm Security --nic1 nat
	  vboxmanage modifyvm Security --nic2 hostonly --hostonlyadapter2 vboxnet1
		vboxmanage modifyvm Security --nic3 hostonly --hostonlyadapter3 vboxnet0
#------------------------------------------------------------------------------#
    for GUEST in Cliente-Externo Lab-Gamification-4752
      do
        echo "Adjusting NIC to host $GUEST"
		    vboxmanage modifyvm ${GUEST} --nic1 nat
		    vboxmanage modifyvm ${GUEST} --nic2 hostonly --hostonlyadapter2 vboxnet0
      done
#------------------------------------------------------------------------------#
    for GUEST in Storage Web-Server01 Web-Server02 Proxy-Server Mail-Server DevOps
		    do
          echo "Adjusting NIC to host $GUEST"
		      vboxmanage modifyvm ${GUEST} --nic1 hostonly --hostonlyadapter1 vboxnet1
        done
fi
#------------------------------------------------------------------------------#
cd $HOME && mkdir -pv "$HOME/VirtualBox VMs/${CURSO}/Storage"

if [ -d "$HOME/VirtualBox VMs/${CURSO}/Storage" ]
  then
    for D in $(seq 10 15)
      do
        cd "$HOME/VirtualBox VMs/${CURSO}/Storage"
        vboxmanage createmedium disk --filename \
        "$HOME/VirtualBox VMs/${CURSO}/Storage/Disk${D}.vdi" \
        --size 10240 --format VDI --variant Standard \
        && vboxmanage storageattach "Storage" --storagectl "SATA Controller" \
        --port ${D} --type hdd \
        --medium "$HOME/VirtualBox VMs/${CURSO}/Storage/Disk${D}.vdi"
    done
  else
    printf "404 VM not found \n" && exit 1
fi
