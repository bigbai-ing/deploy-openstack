#!/bin/bash

#创建外网ip

. /root/admin-openrc.sh
stty erase ^H
read  -p "请输入外网名称:" n
#neutron net-create --router:external=true $n
neutron net-create --router:external=true  --provider:network_type=flat --provider:physical_network=public --shared  $n
read -p "请输入子网名称：" name
read -p "请输入开始地址：" start
read -p "请输入结束地址：" end
read -p "网关地址:"  gateway
read -p "请输入网络地址，例如：10.0.0.0/24:" cidr 
neutron subnet-create --name $name --allocation-pool start=$start,end=$end --gateway $gateway --dns-nameserver 114.114.114.114 --enable_dhcp=False --ip-version 4  $n $cidr
  
nova floating-ip-create $n 
nova floating-ip-pool-list
