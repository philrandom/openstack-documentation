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
yum install -y python3-openstackclient gcc *-python-devel *-python3-devel
# RHEL et CentOS active SELinux par defaut.pour eviter 
# les problemes d'autorité liée à SELinux.
# Si une erreure persiste, nottament lors de l'activation
# de etcd, alors forcez  SELINUX=permissive 
# dans /etc/selinux/config
# SELINUx n'est pas la seul source d'erreurs de etcd
# veillez lancer les services dans le bonne ordre
# du premier au dernier :
# - memcached
# - etcd
# - httpd
yum install -y openstack-selinux
echo "[DANGER] desactivation du parfeux..."
# lorsque le parefeux n'est pas desactiver il peut causer 
# plusieurs erreurs d'acces tels que ERR 504 Bad Gateway
# lors d'une execution openstack faiseant appel à une 
# base sql externe lors d'une validation d'identité 
systemctl stop firewalld
systemctl disable firewalld
echo "terminer"
EOF

chmod +x script_de_preparation_environnement.sh

for item in ${arr[*]}
do
	echo "setting repo for $item"
	scp script_de_preparation_environnement.sh root@os-$item.unilim.fr:/root/.
	ssh root@os-$item.unilim.fr ./script_de_preparation_environnement.sh
	clear
done

echo "setting repo for controller"
./script_de_preparation_environnement.sh
