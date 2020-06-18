#!/bin/sh
# a ne lancer que sur
# ground_control

# VERSION pour 2 comp-n + 1 control

# list des noms machines 
#arr=(comp-1 comp-2 comp-3 sql gateway-1 gateway-2)
arr=(comp-1 comp-2)



cat << EOF > /etc/yum.repos.d/CentOS-PowerTools.repo
[PowerTools]
name=CentOS-$releasever - PowerTools
mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=PowerTools&infra=$infra
baseurl=http://mirror.centos.org/$contentdir/$releasever/PowerTools/$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF



cat << EOF > script_de_preparation_environnement.sh
#!/bin/sh
echo "Preapration de l'environnement"
yum update --disablerepo=epel
yum install centos-release-openstack-ussuri
yum upgrade
yum install python-openstackclient
# RHEL et CentOS active SELinux par defaut.pour eviter les problemes d'autorité liée à SELinux:
yum install openstack-selinux
echo "terminer"
EOF

for item in ${arr[*]}
do
	echo "setting repo for $item"
	# NOTE à n'utilisé que si packstack a mal executé l'ajout de repo
	ssh root@os-$item.unilim.fr rm -f /etc/yum.repos.d/packstack_0.repo
	# fin NOTE
	
	scp /etc/yum.repos.d/CentOS-PowerTools.repo root@os-$item.unilim.fr:/etc/yum.repos.d/.
	scp script_de_preparation_environnement.sh root@os-$item.unilim.fr:/root/.
	ssh root@os-$item.unilim.fr chmod +x script_de_preparation_environnement.sh
	ssh root@os-$item.unilim.fr ./script_de_preparation_environnement.sh
done

./script_de_preparation_environnement.sh



# lancer packstack
