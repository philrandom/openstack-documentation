#!/bin/sh

# WARNING script à lancer sur sql server


## creation de la table sql pour les jetons keystone
## ici Fernet sera déployé

if [ $# != 3 ]; then
	echo "./set_keystone.sh <KEYSTONE_DBPASS> <host_controller> <host_sql_server>"
	exit 1
fi



cat << EOF > database_fernet.sql
CREATE DATABASE keystone;
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' \
  IDENTIFIED BY '$1';
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' \
  IDENTIFIED BY '$1';
EOF

cat << EOF > distant_script_keystone.sh
#mysql -u root -p < database_fernet.sql

# installation du serveur apache
# les port d'ecoute par defaut de keystone sont 5000 35357
# or apache ici utilise mod_wsgi qui ecoute sur ces ports egalement
# il y a un risque que le service keystone se desactive
#yum install -y openstack-keystone httpd mod_wsgi

#debug mode
cat /etc/keystone/keystone.conf
read -n1 -r -p "Press any key to continue..." key
#end debug mode

echo "________________________________________________________________________________"
echo "utilisation d une valeur aleatoire comme jeton admin enregistrer dans /var/tmp/jeton_admin"
openssl rand -hex 10 > /var/tmp/jeton_admin

cat /etc/keystone/keystone.conf > /etc/keystone/keystone.conf.backup.orig
#sed "s/ADMIN_TOKEN/$(cat /var/tmp/jeton_admin)/g/ ; s/KEYSTONE_DBPASS/$1/g; s/@controller/@$2/g ; s/$(cat /etc/keystone/keystone.conf | grep provider)/provider = fernet/g" /etc/keystone/keystone.conf > /etc/keystone/keystone.conf.second
sed "s/ADMIN_TOKEN/$(cat /var/tmp/jeton_admin)/g ; s/KEYSTONE_DBPASS/$1/g; s/@controller/@$2/g " /etc/keystone/keystone.conf > /etc/keystone/keystone.conf.second
echo "________________________________________________________________________________"
echo "svp rempalcer decommenter  provider = fernet   uniquement dans le bloc [ token ]"
read -n1 -r -p "Press any key to continue..." key
vim /etc/keystone/keystone.conf.second
cat /etc/keystone/keystone.conf.second > /etc/keystone/keystone.conf

echo "________________________________________________________________________________"
echo "populate identity service database"
su -s /bin/sh -c "keystone-manage db_sync" keystone
echo "ignorez les erreurs svp..."
echo "________________________________________________________________________________"
echo "initialisation des clefs fernet"
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone

# config apache

echo "________________________________________________________________________________"
echo "configuration du serveur apache"
cat /etc/httpd/conf/httpd.conf > /etc/httpd/conf/httpd.conf.backup.orig
sed 's/$(cat /etc/httpd/conf/httpd.conf | grep ServerName)/ServerName $2/g' >  /etc/httpd/conf/httpd.conf.second
cat /etc/httpd/conf/httpd.conf.second > /etc/httpd/conf/httpd.conf
echo "________________________________________________________________________________"
echo "configuration wsgi-keystone"
cat wsgi > /etc/httpd/conf.d/wsgi-keystone.conf			#documentation francaise
#ln -s /usr/share/keystone/wsgi-keystone.conf /etc/httpd/conf.d/	#documentation americaine
systemctl enable httpd
systemctl start httpd

echo "________________________________________________________________________________"
echo "exportation des valeurs..."
export OS_TOKEN=$(cat /var/tmp/jeton_admin)
export OS_URL=http://$2:35357/v3		#documentation francaise
export OS_IDENTITY_API_VERSION=3

export OS_PROJECT_NAME=admin			# doc us
export OS_USER_DOMAIN_NAME=Default		# doc us
export OS_PROJECT_DOMAIN_NAME=Default		# doc us

openstack service create --name keystone --description "OpenStack Identity" identity

EOF

cat << EOF > wsgi
Listen 5000
Listen 35357

<VirtualHost *:5000>
    WSGIDaemonProcess keystone-public processes=5 threads=1 user=keystone group=keystone display-name=%{GROUP}
    WSGIProcessGroup keystone-public
    WSGIScriptAlias / /usr/bin/keystone-wsgi-public
    WSGIApplicationGroup %{GLOBAL}
    WSGIPassAuthorization On
    ErrorLogFormat "%{cu}t %M"
    ErrorLog /var/log/httpd/keystone-error.log
    CustomLog /var/log/httpd/keystone-access.log combined

    <Directory /usr/bin>
        Require all granted
    </Directory>
</VirtualHost>

<VirtualHost *:35357>
    WSGIDaemonProcess keystone-admin processes=5 threads=1 user=keystone group=keystone display-name=%{GROUP}
    WSGIProcessGroup keystone-admin
    WSGIScriptAlias / /usr/bin/keystone-wsgi-admin
    WSGIApplicationGroup %{GLOBAL}
    WSGIPassAuthorization On
    ErrorLogFormat "%{cu}t %M"
    ErrorLog /var/log/httpd/keystone-error.log
    CustomLog /var/log/httpd/keystone-access.log combined

    <Directory /usr/bin>
        Require all granted
    </Directory>
</VirtualHost>
EOF


chmod +x distant_script_keystone.sh ; ./distant_script_keystone.sh



