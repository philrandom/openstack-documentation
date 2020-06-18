#!/bin/sh

if [ $# != 1 ] ; then
	echo "./install_file_de_message.sh <password_rabbit>"
	exit 1
fi

##modif doc officiel rabbitmq
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
yum install rabbitmq-server
yum update --disablerepo=epel

#yum install rabbitmq-server
systemctl enable rabbitmq-server.service
systemctl start rabbitmq-server.service

#Ajouter l’utilisateur openstack :
rabbitmqctl add_user openstack $1
rabbitmqctl set_permissions openstack ".*" ".*" ".*"
