#!/bin/bash

set_user_sql() {

        service=$1
        pass=$2
        host_sql=$3
        pass_sql=$4
        echo "Parametrage sql du service $service sur $host_sql pour les acces"
        echo "_________________________________________________________"
        mkdir /tmp/$service/
cat << EOF > /tmp/$service/$service.sql
CREATE DATABASE $service;
GRANT ALL PRIVILEGES ON $service.* TO '$service'@'localhost' \
  IDENTIFIED BY '$pass';
GRANT ALL PRIVILEGES ON $service.* TO '$service'@'%' \
  IDENTIFIED BY '$pass';
EOF
        ssh root@$host_sql mysql -u root --password=$pass_sql < /tmp/$service/$service.sql
        ssh root@$host_sql systemctl restart mariadb
}

create_service_user() {
	module=$1
	service=$2
	
	. admin-openrc
	openstack user create --domain default --password-prompt $module
	openstack role add --project service --user $module admin
	openstack service create --name $module --description "OpenStack Networking" $service
}

create_api_endpoint() {
        service=$1
        controller=$2
        port=$3

        openstack endpoint create --region RegionOne $service public http://$controller:$port
        openstack endpoint create --region RegionOne $service internal http://$controller:$port
        openstack endpoint create --region RegionOne $service admin http://$controller:$port
}




question_install_from_src() {

        
        version=$1              # version openstack exemple stable/train stable/ussuri master
	service=$2


echo "INSTALLATION $service version $version"
echo "[WARN] le depot officiel n'est pas correctement maintenue."
echo "       veillez utiliser l'installation depuis les sources."
echo "       repondez 'N' ou rien pour utiliser les sources."
echo "       sinon repondez uniquement 'y'."
read -p "Utilisez le depot officiel ? [y/N]: " UTILISATION_DEPOT_OFFICIEL
if [[ $UTILISATION_DEPOT_OFFICIEL == y ]] ; then
        echo "depuis depot officiel..."
        yum install -y openstack-$service
       
else
        echo "depuis les sources..."
        mkdir devstack
        cd devstack
        git clone -b $version https://opendev.org/openstack/$service.git
        cd $service ; python3 setup.py install
	
	ck_pkg=0
	
	while [[ $ck_pkg == 0 ]] ; do
		./tools/generate_config_file_samples.sh
		if [[ $? != 0 ]] ; then
			./tools/generate_config_file_samples.sh > /tmp/pkg_erreur
			pip3 install $(cat /tmp/pkg_erreur | grep ModuleNotFoundError | sed "s/ModuleNotFoundError: No module named '//" | sed "s/'//")
			ck_pkg=0
		else
			ck_pkg=1
		fi
	done
	cp -r etc/$service/ /etc/$service/
	cp etc/$service.conf.ini /etc/$service/$service.conf
fi
}

creation_systemd_service() {

	service=$1 # ex:glance-api ex:neutron-server

cat << EOF > /etc/systemd/system/openstack-$service.service
[Unit]
Description=Start $service for openstack
After=httpd.service
StartLimitIntervalSec=0
[Service]
Type=simple
Restart=always
RestartSec=1
User=centos
ExecStart=/usr/local/bin/$service
[Install]
WantedBy=multi-user.target
EOF

	if [[ $? == 0 ]] ; do 
		echo "[ OK ] creation du service openstack-$service"
	else
		echo "[FAIL] creation du service openstack-$service"
	done
}
