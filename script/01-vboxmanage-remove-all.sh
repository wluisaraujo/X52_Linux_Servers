#!/bin/bash

## remove all vms
vboxmanage list vms | awk '{ print $1}' | sed s/\"//g > /tmp/vms.old
for OLD in $(cat /tmp/vms.old)
  do
    vboxmanage unregistervm $OLD --delete
  done

## remove all host only interfaces
for vnic in $(vboxmanage list hostonlyifs | grep ^Name | awk '{ print $2}')
  do
    vboxmanage hostonlyif remove $vnic
  done
