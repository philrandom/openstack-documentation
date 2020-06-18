#!/bin/bash
# Mets en cache les jetons et permet de les securisé en les cryptants

# WARNING prévut avec le serveur controle portant le nom os-ground-control.unilim.fr

#yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
yum install memcached python3-memcached
#yum update --disablerepo=epel

cat /etc/sysconfig/memcached > /etc/sysconfig/memcached.backup.origin 

sed "s/OPTIONS=\"-l 127.0.0.1,::1\"/OPTIONS=\"-l 127.0.0.1,::1,os-ground-control.unilim.fr\"/" /etc/sysconfig/memcached > /etc/sysconfig/memcached.second

cat /etc/sysconfig/memcached.second > /etc/sysconfig/memcached

systemctl enable memcached.service
systemctl start memcached.service
