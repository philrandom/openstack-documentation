#!/bin/sh
# a ne lancer que sur
# ground_control

# VERSION pour 2 comp-n + 1 control

# list des noms machines 
#arr=(comp-1 comp-2 comp-3 sql gateway-1 gateway-2)
arr=(comp-1 comp-2 sql)





cat << EOF > script_de_preparation_environnement.sh
#!/bin/sh
echo "Preapration de l'environnement"
#yum update --disablerepo=epel # recommander
yum install -y centos-release-openstack-ussuri
yum upgrade -y
yum install -y python3-openstackclient
# RHEL et CentOS active SELinux par defaut.pour eviter les problemes d'autorité liée à SELinux:
yum install -y openstack-selinux
echo "terminer"
EOF



for item in ${arr[*]}
do
	echo "setting repo for $item"
	scp script_de_preparation_environnement.sh root@os-$item.unilim.fr:/root/.
	ssh root@os-$item.unilim.fr chmod +x script_de_preparation_environnement.sh
	ssh root@os-$item.unilim.fr ./script_de_preparation_environnement.sh
	clear
done

echo "setting repo for controller"
chmod +x script_de_preparation_environnement.sh
./script_de_preparation_environnement.sh
