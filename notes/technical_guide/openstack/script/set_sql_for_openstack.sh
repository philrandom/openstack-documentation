#!/bin/bash

if [ $# != 2 ]
then
        echo "./set_sql_for_openstack.sh <ip_controller> <host_sql>"
        exit 1
fi


mkdir /tmp/dis

cat << EOF > distant_install_sql.sh
yum update
yum install mariadb mariadb-server python2-PyMySQL
EOF

cat << EOF > /tmp/dis/openstack.cnf
[mysqld]
bind-address = $2

default-storage-engine = innodb
innodb_file_per_table = on
max_connections = 4096
collation-server = utf8_general_ci
character-set-server = utf8
EOF

echo "cat << EOF > /etc/my.cnf.d/openstack.cnf" >> distant_install_sql.sh
cat /tmp/dis/openstack.cnf >> distant_install_sql.sh
echo "EOF" >> distant_install_sql.sh

cat << EOF > /tmp/dis/dis_suite
systemctl enable mariadb.service
systemctl start mariadb.service
mysql_secure_installation
EOF

cat /tmp/dis/dis_suite >> distant_install_sql.sh

rm -r /tmp/dis

chmod +x distant_install_sql.sh
scp distant_install_sql.sh root@os-$2.unilim.fr:/root/.
ssh root@os-$2.unilim.fr ./distant_install_sql.sh
