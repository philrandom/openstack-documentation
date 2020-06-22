#!/bin/bash

if [ $# !=  5 ]; then
	echo "./set_keystone_controller.sh <GLANCE_DBPASS> <host_sql> <host_controller> <sql_password_for_root> <glance_sile_system_store_datadir>"
	echo
	echo "recommandation pour tout mots de passe utiliser : "
	echo "       openssl rand -hex 10"
	exit 1
fi

<<COMMENT

echo "_________________________________________________________"
echo "configuration de la base sql distante pour ajout de la db glance"
mkdir /tmp/glance/
cat << EOF > /tmp/glance/glance_db.sql
CREATE DATABASE glance;
GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' \
  IDENTIFIED BY '$1';
GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%' \
  IDENTIFIED BY '$1';
EOF
echo "envoie et execution sur $2. entrez le mot de passe SQL pour user root..."
#scp /tmp/glance/glance_db.sql root@$2:/root/.
#ssh root@$2 mysql -u root --password=$4 < /tmp/glance/glance_db.sql



echo "_________________________________________________________"
. admin-openrc
echo "creation de l'user glance. Entrez le mot de passe $1"
openstack user create --domain default --password-prompt glance
echo "assignation au role"
openstack role add --project service --user glance admin
echo "creation du service"
openstack service create --name glance \
  --description "OpenStack Image" image



echo "_________________________________________________________"
echo "creation du endpoint API"
openstack endpoint create --region RegionOne \
  image public http://$3:9292
openstack endpoint create --region RegionOne \
  image internal http://$3:9292
openstack endpoint create --region RegionOne \
  image admin http://$3:9292

COMMENT


echo "_________________________________________________________"
echo "INSTALLATIONi glance version ussuri"
echo "[WARN] le depot officiel n'est pas correctement maintenue."
echo "       veillez utiliser l'installation depuis les sources."
echo "       repondez 'N' ou rien pour utiliser les sources."
echo "       sinon repondez uniquement 'y'."
read -p "Utilisez le depot officiel ? [y/N]: " UTILISATION_DEPOT_OFFICIEL
if [[ $UTILISATION_DEPOT_OFFICIEL == y ]] ; then
	echo "depuis depot officiel..."
	# L'installation via les depots officiel n'est pas bien maintenue
	yum install -y openstack-glance
	glance_api_service=openstack-glance-api
else
	echo "depuis les sources..."
	cp /usr/local/etc/glance /etc/glance/
	glance_api_service=glance-api
	# donc nous passons à une installation depuis les sources
<<COMMENT
	mkdir devstack
	cd devstack
	git clone -b stable/ussuri https://opendev.org/openstack/glance.git
	cd glance ; python3 setup.py install
	git clone -b stable/ussuri https://opendev.org/openstack/python-glanceclient.git
	cd python-glanceclient ; python3 setup.py install

	echo "creation du service glance-api"
cat << EOF > /etc/systemd/system/glance-api.service
[Unit]
Description=Start glance-api for openstack
After=httpd.service
StartLimitIntervalSec=0
[Service]
Type=simple
Restart=always
RestartSec=1
User=centos
ExecStart=/usr/local/bin/glance-api

[Install]
WantedBy=multi-user.target
EOF
COMMENT
	# Fin de l'installation depuis les sources
fi

echo "configuration"
etcglance=/etc/glance
#cat $etcglance/glance-api.conf > $etcglance/glance-api.conf.backup.origin
sed -i "s/#connection = <None>/connection = mysql+pymysql:\/\/glance:$1@$2\/glance/g;" $etcglance/glance-api.conf
sed -i "s/\[keystone_authtoken\]/\[keystone_authtoken\]\nwww_authenticate_uri  = http:\/\/$3:5000\nauth_url = http:\/\/$3:5000\nmemcached_servers = $3:11211\nauth_type = password\nproject_domain_name = Default\nuser_domain_name = Default\nproject_name = service\nusername = glance\npassword = $1/g" $etcglance/glance-api.conf
sed -i "s/\[paste_deploy\]/\[paste_deploy\]\nflavor = keystone" $etcglance/glance-api.conf
sed -i "s/\[glance_store\]/\[glance_store\]\nstopres = file,http\ndefault_store = file\nfilesystem_store_datadir = $5" $etcglance/glance-api.conf

echo "_________________________________________________________"
echo "populate image service database"
su -s /bin/sh -c "glance-manage db_sync" glance

systemctl enable $glance_api_service
systemctl start $glance_api_service


echo "_________________________________________________________"
echo "TEST verification....."
. admin-openrc
wget http://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img
 glance image-create --name "cirros" \
  --file cirros-0.4.0-x86_64-disk.img \
  --disk-format qcow2 --container-format bare \
  --visibility=public

glance image-list
