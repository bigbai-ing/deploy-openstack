# deply-openstack
install an-all-one openstack

环境:
  系统：ubuntu 16.04
  网络：需要可以连接外网,最好是有两个网口，一个是管理加存储网络(management network),另外一个是业务网络(provider network)
  安全：ubuntu系统一般不需要更多设置，centos、redhat可能需要放开各个服务所用的端口等。
  硬件要求: 
     CPU: 最好是2颗 4核 双线程 以上
     RAM: 8G 以上
     Storage: 20G以上
     NIC: 1个以上

简单架构：控制节点：SQL \ Memcache \ Message Queue \ NTP \ Keystone \ Glance \ Compute Management \ Networking Management 


此部署脚本使用方式: 

参考：https://github.com/nciefeiniu/ansible-openstack-Newton
     以及openstack官方ansible：https://github.com/search?q=org%3Aopenstack+openstack-ansible&unscoped_q=openstack-ansible
         keystone部分： https://github.com/openstack/openstack-ansible-os_keystone
         nova部分:https://github.com/openstack/openstack-ansible-os_nova
         ....

