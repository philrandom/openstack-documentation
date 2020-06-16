#!/bin/sh

# list des noms machines 
arr=(comp-1 comp-2 comp-3 sql gateway-1 gateway-2)

for item in ${arr[*]}
do
	echo "setting repo for $item"
	#ssh root@os-$item.unilim.fr `rm /etc/yum.repos.d/packstack_0.repo; dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm; dnf config-manager --set-enabled PowerTools ; dnf repolist`
	#ssh root@os-$item.unilim.fr `rm /etc/yum.repos.d/packstack_0.repo  ; yum install dnf-plugins-core ; yum config-manager --set-enabled PowerTools`
	ssh root@os-$item.unilim.fr `rm /etc/yum.repos.d/packstack_0.repo`
	scp CentOS-PowerTools.repo root@os-$item.unilim.fr:/etc/yum.repos.d/.
done
