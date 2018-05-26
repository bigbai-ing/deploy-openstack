#!/bin/bash
#Author:liupz
#This is to output vm's message.
source admin-openrc.sh
ip=$1

vm_message=$(nova list --all | grep -w $ip)
echo $vm_message

vm_id=$(echo $vm_message | awk '{print $2}')
nova show $vm_id

vm_host=$(nova show $vm_id |grep  -w OS-EXT-SRV-ATTR:host | awk '{print $4}')
echo "vm on $vm_host"

#ansible $vm_host -m shell -a "qemu-img info /var/lib/nova/instances/$vm_id/disk" > /dev/null 2>&1
#if [ $? -eq 0 ];then
#	echo "vm disk file ok"
#else
#	echo "vm disk could not read"
#fi

ansible $vm_host -m script -a "/root/check_disk_state.sh $vm_id" 1>/dev/null

host_ip=$(cat /etc/hosts | grep $vm_host |awk '{print $1}')
echo "host_ip=$host_ip"

vm_info=$(ansible $vm_host -m shell -a "ps -ef | grep $vm_id | grep vnc ")
if [ "$vm_info" ]
	then
		vnc_port=$(echo $vm_info | grep -o "0.0.0.0:[0-9]\{1,\}" | cut -d ":" -f 2)
		echo "vnc_port=$vnc_port"
	else 
		echo "vm state is shutoff" 
fi

vm_backing_file=$(ansible $vm_host -m shell -a "qemu-img info /var/lib/nova/instances/$vm_id/disk | grep backing |awk '{print $3}'")
echo $vm_backing_file
if [ $? -eq 0 ];then
       echo "vm backing file ok"
else
       echo "vm backing file  could not read or have some other problems"
fi
echo $vm_id
#novnc url
openstack console url show $vm_id --novnc

#spice url  
#openstack console url show $vm_id --spice
#xvpvnc url
#openstack console url show $vm_id --xvpvnc

tenant_id=$(nova show $vm_id | grep tenant_id | awk '{print $4}')
openstack project show $tenant_id


