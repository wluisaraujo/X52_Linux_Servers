#!/bin/bash
#echo "Qual curso  ?"
#read CURSO

export CURSO=752

if [[ -z ${CURSO} ]]
   then
	echo "Variavel do curso não definida "
   else
	echo "Preparando ambiente do curso $CURSO"
	export BASEDIR=/home/repositorio/FREQUENTES/${CURSO} && cd ${BASEDIR}
	ls -ld $BASEDIR > /dev/null 2>&1
# 	import appliance
#	if [ $? == 0 ]
if [ -d /home/repositorio/FREQUENTES/${CURSO} ]
	  then
	    for OVA in $(ls -1 ${BASEDIR}/*${CURSO}*.ova)
	      do
		      echo " Importando appliance ${OVA}"
	        vboxmanage import $OVA
	      done
#	create vbox host only nic vbox0
		vboxmanage hostonlyif create && vboxmanage hostonlyif ipconfig vboxnet0 --ip 200.100.50.254 --netmask 255.255.255.0
		vboxmanage dhcpserver modify --ifname vboxnet0 --enable
		vboxmanage dhcpserver modify --ifname vboxnet0 --enable --ip 200.100.50.254 --netmask 255.255.255.0 --lowerip 200.100.50.240 --upperip 200.100.50.253

#	create vbox host only nic vbox1
		vboxmanage hostonlyif create && vboxmanage hostonlyif ipconfig vboxnet1 --ip 172.16.100.254 --netmask 255.255.255.0
		vboxmanage dhcpserver modify --ifname vboxnet1 --enable
		vboxmanage dhcpserver modify --ifname vboxnet1 --enable --ip 172.16.100.254 --netmask 255.255.255.0 --lowerip 172.16.100.240 --upperip 172.16.100.253

      for VM in $(vboxmanage list vms | awk '{ print $1}' | sed s/\"//g )
		    do
		      vboxmanage modifyvm ${VM} --memory 512
		      vboxmanage modifyvm ${VM} --pae on
		      vboxmanage modifyvm ${VM} --cpus 2
		      vboxmanage modifyvm ${VM} --groups "/${CURSO}"
	      done

    vboxmanage modifyvm Security --nic1 nat
	  vboxmanage modifyvm Security --nic2 hostonly --hostonlyadapter2 vboxnet1
		vboxmanage modifyvm Security --nic3 hostonly --hostonlyadapter3 vboxnet0
		  for GUEST in Cliente-Externo Lab-Gamification-4752
		    do
		      vboxmanage modifyvm ${GUEST} --nic1 nat
		      vboxmanage modifyvm ${GUEST} --nic2 hostonly --hostonlyadapter2 vboxnet0
        done
	    for GUEST in Storage Web-Server01 Web-Server02 Proxy-Server Mail-Server DevOps
		    do
		      vboxmanage modifyvm ${GUEST} --nic1 hostonly --hostonlyadapter1 vboxnet1
        done
	fi
fi
