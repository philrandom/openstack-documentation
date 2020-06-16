#!/bin/sh
# a ne lancer que sur
# ground_control

# list des noms machines 
arr=(comp-1 comp-2 comp-3 sql gateway-1 gateway-2)

for item in ${arr[*]}
do
	echo "setting repo for $item"
	# NOTE à n'utilisé que si packstack a mal executé l'ajout de repo
	ssh root@os-$item.unilim.fr rm -f /etc/yum.repos.d/packstack_0.repo
	# fin NOTE
	
	scp /etc/yum.repos.d/CentOS-PowerTools.repo root@os-$item.unilim.fr:/etc/yum.repos.d/.
done

yum install -y puppet hiera openssh-clients tar nc rubygem-json
systemctl start puppet
systemctl status puppet
yum install -y erlang

# lancer packstack
