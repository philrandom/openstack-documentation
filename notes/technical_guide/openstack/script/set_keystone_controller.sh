#!/bin/bash

if [ $# !=  3 ]; then
	echo "./set_keystone_controller.sh <KEYSTONE_DBPASS> <host_sql> <host_controller>"
	echo
	echo "recommandation pour tout mots de passe utiliser : "
	echo "       openssl rand -hex 10"
	exit 1
fi



echo "_________________________________________________________"
echo "configuration de la base sql distante pour ajout de la db keystone"
mkdir /tmp/keystone/
cat << EOF > /tmp/keystone/keystone_db.sql
CREATE DATABASE keystone;
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' IDENTIFIED BY '$1';
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' IDENTIFIED BY '$1';
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'$2' IDENTIFIED BY '$1';
EOF
echo "envoie et execution sur host_sql"
scp /tmp/keystone/keystone_db.sql root@$2:/root/.
ssh root@$2 mysql -u root -p < keystone_db.sql


echo "_________________________________________________________"
echo "insatallationdes packets"
yum install -y openstack-keystone httpd python3-mod_wsgi

echo "_________________________________________________________"
echo "configuration de keystone pour connection à la database $2"
cat /etc/keystone/keystone.conf > /etc/keystone/keystone.conf.backup.origin
sed -i "s/#connection = <None>/connection = mysql+pymysql:\/\/keystone:$1@$2\/keystone/g; s/#provider = fernet/provider = fernet/" /etc/keystone/keystone.conf
echo "remplissage identité du service database"
su -s /bin/sh -c "keystone-manage db_sync" keystone
echo "initialisation de clef Fernet repo"
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone
echo "lancement du service d identité sur le port 5000 dans la region RegionOne"
keystone-manage bootstrap --bootstrap-password $1 \
  --bootstrap-admin-url http://$3:5000/v3/ \
  --bootstrap-internal-url http://$3:5000/v3/ \
  --bootstrap-public-url http://$3:5000/v3/ \
  --bootstrap-region-id RegionOne

echo "_________________________________________________________"
echo "configuration Apache"
cat /etc/httpd/conf/httpd.conf > /etc/httpd/conf/httpd.conf.backup.origin
sed -i "s/#ServerName www.example.com:80/ServerName $3/g" /etc/httpd/conf/httpd.conf 
echo "config wsgi-keystone.conf module web"
ln -s /usr/share/keystone/wsgi-keystone.conf /etc/httpd/conf.d/


echo "_________________________________________________________"
echo "finalisation : demarage du service"
systemctl enable httpd.service
systemctl start httpd.service

export OS_USERNAME=admin
export OS_PASSWORD=$1
export OS_PROJECT_NAME=admin
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_AUTH_URL=http://$3:5000/v3
export OS_IDENTITY_API_VERSION=3


 
echo "_________________________________________________________"
echo "creation de domain, projects, users, roles"
openstack domain create --description "An Example Domain" example
openstack project create --domain default --description "Service Project" service
openstack project create --domain default \
  --description "Demo Project" myproject
openstack user create --domain default \
  --password-prompt myuser
openstack role create myrole
openstack role add --project myproject --user myuser myrole



echo "_________________________________________________________"
echo "TESTING............."
echo "le password est $1"
openstack --os-auth-url http://$3:5000/v3 \
  --os-project-domain-name Default --os-user-domain-name Default \
  --os-project-name admin --os-username admin token issue
openstack --os-auth-url http://$3:5000/v3 \
  --os-project-domain-name Default --os-user-domain-name Default \
  --os-project-name myproject --os-username myuser token issue

